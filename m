Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C55ECE587
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02D2D2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 13:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571060946;
	bh=7w3gIm1RDubbNnbCSohlx7B9JgV8F4JennIIjOtB8iE=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=OzznZqRnPOMopg/tTpaoNpNkNUvAM4x9Q3d7bdhKbPqLVadCp7lBSvzs7wMjamSTR
	 uNIbu0W3hBBaLvmJBlB1giRHPcu8WWvBA7ItmNdbWMU+Hc+BT4VzBs9MYuqWCVN46q
	 UDuu8b5flLA2PsyuphpJQH2Ns38AX7fhpGKyjTqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfJNNtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 09:49:05 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:57382 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732275AbfJNNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 09:49:04 -0400
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iK0iY-0001Qb-NC; Mon, 14 Oct 2019 15:48:58 +0200
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] ARM: dts: stm32: Enable high resolution timer
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Oct 2019 14:48:58 +0100
From:   Marc Zyngier <maz@kernel.org>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <61dda183-cd53-153b-8ed1-e2ecb8f96e03@st.com>
References: <20190927084819.645-1-benjamin.gaignard@st.com>
 <da48ce9633441cd0186518fa7ce1d528@www.loen.fr>
 <341949c8-7864-5d65-2797-988022724a4c@st.com>
 <ff11797da8f049b354797689754fde52@www.loen.fr>
 <69af57d1-13a9-9e35-78f2-4a0d17bdaf6d@st.com>
 <e376301a8e9ec02dfd7713748abed83e@www.loen.fr>
 <61dda183-cd53-153b-8ed1-e2ecb8f96e03@st.com>
Message-ID: <a42dd20677cddd8d09ea91a369a4e10b@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: benjamin.gaignard@st.com, alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-14 10:31, Benjamin GAIGNARD wrote:
> On 9/27/19 2:59 PM, Marc Zyngier wrote:
>> On 2019-09-27 13:44, Benjamin GAIGNARD wrote:
>>> On 9/27/19 2:41 PM, Marc Zyngier wrote:
>>>> On 2019-09-27 13:36, Benjamin GAIGNARD wrote:
>>>>> On 9/27/19 1:22 PM, Marc Zyngier wrote:
>>>>>> On 2019-09-27 09:48, Benjamin Gaignard wrote:
>>>>>>> Adding always-on makes arm arch_timer claim to be an high 
>>>>>>> resolution
>>>>>>> timer.
>>>>>>> That is possible because power mode won't stop clocking the 
>>>>>>> timer.
>>>>>>
>>>>>> The "always-on" is not about the clock. It is about the 
>>>>>> comparator.
>>>>>> The clock itself is *guaranteed* to always tick. If it didn't,
>>>>>> that'd be
>>>>>> an integration bug, and a pretty bad one.
>>>>>>
>>>>>> What you're claiming here is that your CPU never enters a 
>>>>>> low-power
>>>>>> mode?
>>>>>> Ever? I find this very hard to believe.
>>>>>>
>>>>>> Furthermore, claiming that always-on is the way to force the
>>>>>> arch-timer
>>>>>> to be an hrtimer is factually wrong. This is what happens *if*
>>>>>> this is
>>>>>> the only timer in the system. The only case this is true is for
>>>>>> virtual
>>>>>> machines. Anything else has a global timer somewhere that will 
>>>>>> allow
>>>>>> the arch timers to be used as an hrtimer.
>>>>>>
>>>>>> I'm pretty sure you too have a global timer somewhere in your 
>>>>>> system.
>>>>>> Enable it, and enjoy hrtimers without having to lie about the
>>>>>> properties
>>>>>> of your system! ;-)
>>>>>
>>>>> Hi Marc,
>>>>>
>>>>> This SoC doesn't have any other global timer. Use arch_time is 
>>>>> the
>>>>> only
>>>>> we have to provide hrtimer on this system.
>>>>
>>>> And you don't have any form of power management either? What 
>>>> happens
>>>> when
>>>> your CPU goes into idle? If your system does any form of power
>>>> management
>>>> *and* doesn't have a separate timer, it is remarkably broken.
>>>
>>> Even in low-power modes this timer is always powered and clocked so 
>>> it
>>> is working fine.
>>
>> You're missing the point again. It is not about the clock, but the
>> comparator
>> that is internal to the CPU, and not functional when the CPU is in 
>> its
>> lowest
>> power mode. See also the verbiage in [1] (44.3 STGEN functional
>> description),
>> which indicates that the clock source actually dies in low-power 
>> mode
>> (going
>> against the architecture which mandates it to be always-on).
>>
>> Also, coming back to your earlier assertion ("This SoC doesn't have
>> any other
>> global timer"): The documentation at [1] shows at least 17 timers 
>> that
>> could
>> be used and avoid this dirty hack.
>>
>> So for what it is worth, NAK to this patch.
>
>
> Hi Marc,
>
> I have listen your remarks and propose another way to solve this 
> issue:
>
> https://lkml.org/lkml/2019/10/9/690

I don't think you have. You're just trying to move the same dirty hack 
to
another place instead of properly describing your hardware, and Thomas
has pointed you in the same direction.

         M.
-- 
Jazz is not dead. It just smells funny...
