Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2030C606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A0E2166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 03:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfGIDJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 23:09:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:31235 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGIDJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 23:09:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 20:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="173437779"
Received: from unknown (HELO [10.239.13.7]) ([10.239.13.7])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2019 20:09:22 -0700
Message-ID: <5D2406AC.20402@intel.com>
Date:   Tue, 09 Jul 2019 11:14:52 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Peter Zijlstra <peterz@infradead.org>
CC:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        pbonzini@redhat.com, ak@linux.intel.com, kan.liang@intel.com,
        mingo@redhat.com, rkrcmar@redhat.com, like.xu@intel.com,
        jannh@google.com, arei.gonglei@huawei.com, jmattson@google.com
Subject: Re: [PATCH v7 10/12] KVM/x86/lbr: lazy save the guest lbr stack
References: <1562548999-37095-1-git-send-email-wei.w.wang@intel.com> <1562548999-37095-11-git-send-email-wei.w.wang@intel.com> <20190708145326.GO3402@hirez.programming.kicks-ass.net>
In-Reply-To: <20190708145326.GO3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2019 10:53 PM, Peter Zijlstra wrote:
> On Mon, Jul 08, 2019 at 09:23:17AM +0800, Wei Wang wrote:
>> When the vCPU is scheduled in:
>> - if the lbr feature was used in the last vCPU time slice, set the lbr
>>    stack to be interceptible, so that the host can capture whether the
>>    lbr feature will be used in this time slice;
>> - if the lbr feature wasn't used in the last vCPU time slice, disable
>>    the vCPU support of the guest lbr switching.
>>
>> Upon the first access to one of the lbr related MSRs (since the vCPU was
>> scheduled in):
>> - record that the guest has used the lbr;
>> - create a host perf event to help save/restore the guest lbr stack;
>> - pass the stack through to the guest.
> I don't understand a word of that.
>
> Who cares if the LBR MSRs are touched; the guest expects up-to-date
> values when it does reads them.

Another host thread who shares the same pCPU with this vCPU thread
may use the lbr stack, so the host needs to save/restore the vCPU's lbr 
state.
Otherwise the guest perf inside the vCPU wouldn't read the correct data
from the lbr msr (as the msrs are changed by another host thread already).

As Andi also replied, if the vCPU isn't using lbr anymore, host doesn't need
to save the lbr msr then.

Best,
Wei
