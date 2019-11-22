Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28411C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087872067D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 02:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVCjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 21:39:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:33816 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbfKVCje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 21:39:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Nov 2019 18:39:34 -0800
X-IronPort-AV: E=Sophos;i="5.69,228,1571727600"; 
   d="scan'208";a="201353334"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.239.13.123]) ([10.239.13.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 21 Nov 2019 18:39:31 -0800
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
To:     Andy Lutomirski <luto@amacapital.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
References: <20191122015225.GG16617@linux.intel.com>
 <81CEB9B7-79EA-4B02-A79C-C9113331A28A@amacapital.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <fee43477-337a-8de3-9788-e8c8d58d0116@intel.com>
Date:   Fri, 22 Nov 2019 10:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <81CEB9B7-79EA-4B02-A79C-C9113331A28A@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/2019 10:21 AM, Andy Lutomirski wrote:
> 
>> On Nov 21, 2019, at 5:52 PM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
>>
>> ﻿On Thu, Nov 21, 2019 at 03:53:29PM -0800, Fenghua Yu wrote:
>>>> On Thu, Nov 21, 2019 at 03:18:46PM -0800, Andy Lutomirski wrote:
>>>>
>>>>> On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
>>>>>
>>>>>> It would be really, really nice if we could pass this feature through to a VM. Can we?
>>>>>
>>>>> It's hard because the MSR is core scoped rather than thread scoped.  So on an HT
>>>>> enabled system a pair of logical processors gets enabled/disabled together.
>>>>>
>>>>
>>>> Well that sucks.
>>>>
>>>> Could we pass it through if the host has no HT?  Debugging is *so* much
>>>> easier in a VM.  And HT is a bit dubious these days anyway.
>>>
>>> I think it's doable to pass it through to KVM. The difficulty is to disable
>>> split lock detection in KVM because that will disable split lock on the whole
>>> core including threads for the host. Without disabling split lock in KVM,
>>> it's doable to debug split lock in KVM.
>>>
>>> Sean and Xiaoyao are working on split lock for KVM (in separate patch set).
>>> They may have insight on how to do this.
>>
>> Yes, with SMT off KVM could allow the guest to enable split lock #AC, but
>> for the initial implementation we'd want to allow it if and only if split
>> lock #AC is disabled in the host kernel.  Otherwise we have to pull in the
>> logic to control whether or not a guest can disable split lock #AC, what
>> to do if a split lock #AC happens when it's enabled by the host but
>> disabled by the guest, etc...
> 
> What’s the actual issue?  There’s a window around entry and exit when a split lock in the host might not give #AC, but as long as no user code is run, this doesn’t seem like a big problem.
> 
The problem is that guest can trigger split locked memory access just by 
disabling split lock #AC even when host has it enabled. In this 
situation, there is bus lock held on the hardware without #AC triggered, 
which is conflict with the purpose that host enables split lock #AC
