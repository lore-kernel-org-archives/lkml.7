Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56518C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4E120644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 08:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbfHAIVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:21:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:25114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfHAIVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 04:21:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 01:21:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,333,1559545200"; 
   d="scan'208";a="180626986"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2019 01:21:31 -0700
Subject: Re: setup_boot_APIC_clock() NULL dereference during early boot on
 reduced hardware platforms
To:     Thomas Gleixner <tglx@linutronix.de>,
        Aubrey Li <aubrey.intel@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
References: <CAD8Lp448i7jOk9C5NJtC2wHMaGuRLD4pxVqK17YqRCuMVXhsOA@mail.gmail.com>
 <CAERHkruxfBc8DqNUr=fbYuQWrXrHC7cK6HnVR3xp0iLA9QtxiQ@mail.gmail.com>
 <alpine.DEB.2.21.1908010931550.1788@nanos.tec.linutronix.de>
 <CAERHkrtaVAQHDU1cj2_GLL59LPjp7E=3X0Zna0spfFB=Ve5__w@mail.gmail.com>
 <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <81666b28-d029-56c3-8978-90abc219d1b7@linux.intel.com>
Date:   Thu, 1 Aug 2019 16:21:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908011011250.1788@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/1 16:13, Thomas Gleixner wrote:
> On Thu, 1 Aug 2019, Aubrey Li wrote:
>> On Thu, Aug 1, 2019 at 3:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>>
>>> On Thu, 1 Aug 2019, Aubrey Li wrote:
>>>> On Thu, Aug 1, 2019 at 2:26 PM Daniel Drake <drake@endlessm.com> wrote:
>>>>> global_clock_event is NULL here. This is a "reduced hardware" ACPI
>>>>> platform so acpi_generic_reduced_hw_init() has set timer_init to NULL,
>>>>> avoiding the usual codepaths that would set up global_clock_event.
>>>>>
>>>> IIRC, acpi_generic_reduced_hw_init() avoids initializing PIT, the status of
>>>> this legacy device is unknown in ACPI hw-reduced mode.
>>>>
>>>>> I tried the obvious:
>>>>>  if (!global_clock_event)
>>>>>     return -1;
>>>>>
>>>> No, the platform needs a global clock event, can you turn on some other
>>>
>>> Wrong. The kernel boots perfectly fine without a global clock event. But
>>> for that the TSC and LAPIC frequency must be known.
>>
>> I think LAPIC fast calibrate is only supported on intel platform, while
>> Daniel's box is an AMD platform. That's why lapic_init_clockevent() failed
>> and fall into the code path which needs a global clock event.
> 
> We know that.
> 
> The point is that it does not matter which vendor a CPU comes from. The
> kernel does support legacyless boot when the frequencies are known. Whether
> that's currently possible on that particular CPU is a different question.
> 
Yeah, I should specify, Daniel, your platform needs a global clock event, ;-)

Thanks,
-Aubrey
