Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39850C004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1742F20844
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfGIL26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:28:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:54993 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbfGIL26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:28:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 04:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="173539452"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2019 04:28:55 -0700
Message-ID: <5D247BC2.70104@intel.com>
Date:   Tue, 09 Jul 2019 19:34:26 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 08/12] KVM/x86/vPMU: Add APIs to support host save/restore
 the guest lbr stack
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com> <1562548999-37095-9-git-send-email-wei.w.wang@intel.com> <20190708144831.GN3402@hirez.programming.kicks-ass.net> <5D240435.2040801@intel.com> <20190709093917.GS3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190709093917.GS3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2019 05:39 PM, Peter Zijlstra wrote:
> On Tue, Jul 09, 2019 at 11:04:21AM +0800, Wei Wang wrote:
>> On 07/08/2019 10:48 PM, Peter Zijlstra wrote:
>>> *WHY* does the host need to save/restore? Why not make VMENTER/VMEXIT do
>>> this?
>> Because the VMX transition is much more frequent than the vCPU switching.
>> On SKL, saving 32 LBR entries could add 3000~4000 cycles overhead, this
>> would be too large for the frequent VMX transitions.
>>
>> LBR state is saved when vCPU is scheduled out to ensure that this
>> vCPU's LBR data doesn't get lost (as another vCPU or host thread that
>> is scheduled in may use LBR)
> But VMENTER/VMEXIT still have to enable/disable the LBR, right?
> Otherwise the host will pollute LBR contents. And you then rely on this
> 'fake' event to ensure the host doesn't use LBR when the VCPU is
> running.

Yes, only the debugctl msr is save/restore on vmx tranisions.


>
> But what about the counter scheduling rules;

The counter is emulated independent of the lbr emulation.

Here is the background reason:

The direction we are going is the architectural emulation, where the 
features
are emulated based on the hardware behavior described in the spec. So 
the lbr
emulation path only offers the lbr feature to the guest (no counters 
associated, as
the lbr feature doesn't have a counter essentially).

If the above isn't clear, please see this example: the guest could run 
any software
to use the lbr feature (non-perf or non-linux, or even a testing kernel 
module to try
lbr for their own purpose), and it could choose to use a regular timer 
to do sampling.
If the lbr emulation takes a counter to generate a PMI to the guest to 
do sampling,
that pmi isn't expected from the guest perspective.

So the counter scheduling isn't considered by the lbr emulation here, it 
is considered
by the counter emulation. If the guest needs a counter, it configures 
the related msr,
which traps to KVM, and the counter emulation has it own emulation path
(e.g. reprogram_gp_counter which is called when the guest writes to the 
emulated
eventsel msr).


> what happens when a CPU
> event claims the LBR before the task event can claim it? CPU events have
> precedence over task events.

I think the precedence (cpu pined and task pined) is for the counter 
multiplexing,
right?

For the lbr feature, could we thought of it as first come, first served?
For example, if we have 2 host threads who want to use lbr at the same time,
I think one of them would simply fail to use.

So if guest first gets the lbr, host wouldn't take over unless some 
userspace
command (we added to QEMU) is executed to have the vCPU actively
stop using lbr.


>
> I'm missing all these details in the Changelogs. Please describe the
> whole setup and explain why this approach.

OK, just shared some important background above.
I'll see if any more important details missed.

Best,
Wei
