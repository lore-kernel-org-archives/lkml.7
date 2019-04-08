Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25980C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F085520857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDHCdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:33:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:58264 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHCdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:33:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Apr 2019 19:33:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,323,1549958400"; 
   d="scan'208";a="162276380"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2019 19:33:33 -0700
Subject: Re: [PATCH v13 1/3] /proc/pid/status: Add support for architecture
 specific output
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        aubrey.li@intel.com, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190224044400.34975-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904052129371.1802@nanos.tec.linutronix.de>
 <CALCETrVhpqZiBe6zvK+z6HmD9AhK_O_O=2H=PYzBHid4C=SMYQ@mail.gmail.com>
 <c9662fea-faaf-beb3-246a-c60dad6d7420@linux.intel.com>
 <CALCETrVxkcn=R+T-9P3CNkEiRwUGmttem52vykBcYhVSYWwh8A@mail.gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <c0dcd47a-b155-8523-0d7d-a25dd3cc665c@linux.intel.com>
Date:   Mon, 8 Apr 2019 10:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <CALCETrVxkcn=R+T-9P3CNkEiRwUGmttem52vykBcYhVSYWwh8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/8 9:52, Andy Lutomirski wrote:
> On Sun, Apr 7, 2019 at 5:38 PM Li, Aubrey <aubrey.li@linux.intel.com> wrote:
>>
>> On 2019/4/8 1:34, Andy Lutomirski wrote:
>>> On Fri, Apr 5, 2019 at 12:32 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>>
>>>> On Sun, 24 Feb 2019, Aubrey Li wrote:
>>>>
>>>>> The architecture specific information of the running processes could
>>>>> be useful to the userland. Add support to examine process architecture
>>>>> specific information externally.
>>>>>
>>>>> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>> Cc: Andi Kleen <ak@linux.intel.com>
>>>>> Cc: Tim Chen <tim.c.chen@linux.intel.com>
>>>>> Cc: Dave Hansen <dave.hansen@intel.com>
>>>>> Cc: Arjan van de Ven <arjan@linux.intel.com>
>>>>
>>>> This really lacks
>>>>
>>>> Cc: Linux API <linux-api@vger.kernel.org>
>>>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>
>>>> Cc'ed now.
>>>>
>>>
>>> I certainly understand why you want to expose this info, but would it
>>> make more sense to instead add an arch_status file in /proc with
>>> architecture-specific info?  Or maybe an x86_status field for x86
>>> status, etc.
>>>
>>
>> I tried this, but no other architecture showed interest in arch_status
>> under /proc.
>>
> 
> Why is that a problem?  It could exist on x86 and not exist on other
> arches until needed.
> 

I placed it in tid_base_stuff, under live_patch entry, so it exists for
all arches, is there a better way to do this?

Thanks,
-Aubrey
