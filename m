Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC77C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D9F213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbfDAJCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:02:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:48322 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbfDAJCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:02:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Apr 2019 02:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,296,1549958400"; 
   d="scan'208";a="160224386"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2019 02:02:45 -0700
Message-ID: <5CA1D4FD.9000104@intel.com>
Date:   Mon, 01 Apr 2019 17:08:13 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>,
        Like Xu <like.xu@linux.intel.com>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        like.xu@intel.com, Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] [PATCH v2 0/5] Intel Virtual PMU Optimization
References: <1553350688-39627-1-git-send-email-like.xu@linux.intel.com> <20190323172800.GD6058@hirez.programming.kicks-ass.net> <28851e9d-5ed4-8ce1-8ff4-9d6c04180388@linux.intel.com> <20190325071924.GE6058@hirez.programming.kicks-ass.net>
In-Reply-To: <20190325071924.GE6058@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/25/2019 03:19 PM, Peter Zijlstra wrote:
> On Mon, Mar 25, 2019 at 02:47:32PM +0800, Like Xu wrote:
>> On 2019/3/24 1:28, Peter Zijlstra wrote:
>>> On Sat, Mar 23, 2019 at 10:18:03PM +0800, Like Xu wrote:
>>>> === Brief description ===
>>>>
>>>> This proposal for Intel vPMU is still committed to optimize the basic
>>>> functionality by reducing the PMU virtualization overhead and not a blind
>>>> pass-through of the PMU. The proposal applies to existing models, in short,
>>>> is "host perf would hand over control to kvm after counter allocation".
>>>>
>>>> The pmc_reprogram_counter is a heavyweight and high frequency operation
>>>> which goes through the host perf software stack to create a perf event for
>>>> counter assignment, this could take millions of nanoseconds. The current
>>>> vPMU always does reprogram_counter when the guest changes the eventsel,
>>>> fixctrl, and global_ctrl msrs. This brings too much overhead to the usage
>>>> of perf inside the guest, especially the guest PMI handling and context
>>>> switching of guest threads with perf in use.
>>> I think I asked for starting with making pmc_reprogram_counter() less
>>> retarded. I'm not seeing that here.
>> Do you mean pass perf_event_attr to refactor pmc_reprogram_counter
>> via paravirt ? Please share more details.
> I mean nothing; I'm trying to understand wth you're doing.

I also feel the description looks confusing (sorry for being late to
join in due to leaves). Also the code needs to be improved a lot.


Please see the basic idea here:

reprogram_counter is a heavyweight operation which goes through the
perf software stack to create a perf event, this could take millions of
nanoseconds. The current KVM vPMU always does reprogram_counter
when the guest changes the eventsel, fixctrl, and global_ctrl msrs. This
brings too much overhead to the usage of perf inside the guest, especially
the guest PMI handling and context switching of guest threads with perf in
use.

In fact, during the guest perf event life cycle, it mostly only toggles the
enable bit of eventsel or fixctrl. From the KVM point of view, if the guest
only toggles the enable bits, it is not necessary to do reprogram_counter,
because it is serving the same guest perf event. So the "enable bit" can
be directly applied to the hardware msr that the corresponding host event
is occupying.

We optimize the current vPMU to work in this manner:
1) rely on the existing host perf (perf_event_create_kernel_counter) to
create a perf event for each vPMC. This creation is only needed when
guest writes a complete new value to eventsel or fixctrl.

2) vPMU captures guest accesses to the eventsel and fixctrl msrs.
If the guest only toggles the enable bit, then we don't need to
reprogram_pmc_counter, as the vPMC is serving the same guest
event. So KVM only updates the enable bit directly to the hardware
msr that the corresponding host event is scheduled on.

3) When the host perf reschedules perf counters and happens to
have the vPMC's perf event scheduled out, KVM will do
reprogram_counter.

4) We use a lazy approach to release the vPMC's perf event. That is,
if the vPMC wasn't used for a vCPU time slice, the corresponding perf
event will be released via kvm calling perf_event_release_kernel.

Regarding who updates the underlying hardware counter:
The change here is when a perf event is used by the guest
(i.e. exclude_host=true or using a new flag if necessary), perf doesn't
update the hardware counter (e.g. a counter's event_base and config_base),
instead, the hypervisor helps to update them.

Hope the above has made it clear to understand. Thanks!

Best,
Wei
