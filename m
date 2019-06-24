Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C511C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6CE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 08:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rJMPYKCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfFXIHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 04:07:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:32898 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfFXIHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 04:07:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id h19so13635352wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 01:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V2Khsz88+K+VINNLIfEeL8PKE1M3cSt+v1bYdXdfOmk=;
        b=rJMPYKCce3xb6K92lZt52spzZfmCrnqBvcBdcOQW/Z6PGKl7aYQk5YJd4/GPBFjqCv
         QmsPLHTXiBO1Nyjaf8bgnpBb9+1WWk+gwa8ROa3NU8kEbVVZQeLfBMImmRRwUs5gBrXv
         bDOMujz81I8gw25thbhPmPWen9T6axUAYtcqN4lXYYql56iBr0PjxD+VRQD36YXdq5Fp
         JUnLS93UoMvLGtNzNBpibrx27rNZ1u0R3dXDW8JsyW1Aemo7Qqkh2c+k2TGJALHpStzM
         N7LFdRnlH1IzL/Yh2mzDyzslue3OVOeIqzmWaNOidwGalIdtPJfeJDG2BzGVUGS1aT1F
         Es3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=V2Khsz88+K+VINNLIfEeL8PKE1M3cSt+v1bYdXdfOmk=;
        b=pzjQqb4rpqCc4o8wCeRve8yWjU4ThaIXbzON4rvK+PHBBfcpuTw+tvdHm8BX1F8lqZ
         C4QG3lQ5TLDgaOoSVNvTQIyWAriTH07V6qCPdyqz7jQvVJO3slRvBkgezZ/fDDtjXwGH
         acFHkXN8qn37s0ssUGBbhKagO/0Yjwo/rF5VBZCAH47k+UdaFFVbj2nLpoUCnS+NUtcj
         L3HvTmgaT3haEv/BtD6K8giv5TnUB/1/1FmrG1Z9Rj+JmORQLa3OSvDDxcYbwsctqR+o
         uwW2B+KSXoeqsgarCMrLcwu9XSyLad1WCDzRiyRd/kqkDC7D4TtwmkAZOGdXyp9AjxDr
         EnsA==
X-Gm-Message-State: APjAAAXgaIe51RsLorqRUegV55dKpoRMduZb80bQop9bSEWxCctUasrY
        2NG0As6iZXUmKN6Qa1DLAX6XxA==
X-Google-Smtp-Source: APXvYqx/RnU7WfKSZ6hbEClosUclv+7AmzLzZXGVpy5i+kmDWG6qda1MKvAB6RprWj+W3poxMWWEcA==
X-Received: by 2002:a1c:7d56:: with SMTP id y83mr14935807wmc.77.1561363619195;
        Mon, 24 Jun 2019 01:06:59 -0700 (PDT)
Received: from [192.168.0.41] (209.94.129.77.rev.sfr.net. [77.129.94.209])
        by smtp.googlemail.com with ESMTPSA id l1sm9878205wmg.13.2019.06.24.01.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 01:06:58 -0700 (PDT)
Subject: Re: [PATCH 2/5] clocksource/drivers/timer-microchip-pit64b: add
 Microchip PIT64B support
To:     Claudiu.Beznea@microchip.com, alexandre.belloni@bootlin.com
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, arnd.bergmann@linaro.org
References: <1552580772-8499-1-git-send-email-claudiu.beznea@microchip.com>
 <1552580772-8499-3-git-send-email-claudiu.beznea@microchip.com>
 <a738fce5-1108-34d7-d255-dfcb86f51c56@linaro.org>
 <20190408121141.GK7480@piout.net>
 <88ab46de-c3b6-6dd2-3fa2-f2d0075e969f@microchip.com>
 <7267f37b-4f80-97e3-7a8e-bc1a9a28b995@linaro.org>
 <5e3d783e-7bcc-64c1-c814-eaf99a6aa205@microchip.com>
 <845acd59-665a-4d0a-3da8-2ba605600928@linaro.org>
 <34574b0f-7d09-eb92-ea62-4199c293b0e7@microchip.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1ebaa306-8a7f-fd58-56e0-a61b767357f7@linaro.org>
Date:   Mon, 24 Jun 2019 10:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <34574b0f-7d09-eb92-ea62-4199c293b0e7@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2019 12:34, Claudiu.Beznea@microchip.com wrote:
> Hi Daniel,
> 
> On 20.06.2019 11:53, Daniel Lezcano wrote:
>> Hi Claudiu,
>>
>> sorry for the late reply.
> 
> No problem, I understand.
> 
>>
>>
>> On 13/06/2019 16:12, Claudiu.Beznea@microchip.com wrote:
>>> Hi Daniel,
>>>
>>> On 31.05.2019 13:41, Daniel Lezcano wrote:
>>>>
>>>> Hi Claudiu,
>>>>
>>>>
>>>> On 30/05/2019 09:46, Claudiu.Beznea@microchip.com wrote:
>>>>> Hi Daniel,
>>>>>
>>>>> Taking into account the discussion on this tread and the fact that we have
>>>>> no answer from Rob on this topic (I'm talking about [1]), what do you think
>>>>> it would be best for this driver to be accepted the soonest? Would it be OK
>>>>> for you to mimic the approach done by:
>>>>>
>>>>> drivers/clocksource/timer-integrator-ap.c
>>>>>
>>>>> with the following bindings in DT:
>>>>>
>>>>> aliases {
>>>>> 	arm,timer-primary = &timer2;
>>>>> 	arm,timer-secondary = &timer1;
>>>>> };
>>>>>
>>>>> also in PIT64B driver?
>>>>>
>>>>> Or do you think re-spinning the Alexandre's patches at [2] (which seems to
>>>>> me like the generic way to do it) would be better?
>>>>
>>>> This hardware / OS connection problem is getting really annoying for
>>>> everyone and this pattern is repeating itself since several years. It is
>>>> time we fix it properly.
>>>>
>>>> The first solution looks hackish from my POV. The second approach looks
>>>> nicer and generic as you say. So I would vote for [2]
>>>> flagging approach proposed by Mark [3].
>>>
>>> With this flagging approach this would mean a kind unification of
>>> clocksource and clockevent functionalities under a single one, right? So
>>> that the driver would register to the above layers only one device w/ 2
>>> functionalities (clocksource and clockevent)? Please correct me if I'm
>>> wrong? If so, from my point of view this would require major re-working of
>>> clocksource and clockevent subsystems. Correctly if I wrongly understood,
>>> please.
>>
>> Well, actually I was not expecting to change all the framework but just
>> pass a flag to the probe function telling if the node is for a
>> clocksource, a clockevent or both.
>>
> 
> Giving so, whit these proposals I'm thinking at having something like this,
> using Alexandre's new macros from [2] and passing a bitmask to timer's
> probing functions (in the above example adapted only for pit64b driver
> introduced in this thread):

Yes basically that is what I had in mind. Thanks for taking care of
that. However after seeing the code I realize the impact is larger than
expected as all the TIMER_OF_DECLARE will be impacted.

AFAICT, this driver can be converted to the timer-of API. So I think it
makes sense to keep this contained in the API.

In the function timer_of_init(), we can add the parsing of the node and
set the timer-of flags with:

#define TIMER_OF_IS_CLOCKSOURCE	 0x8
#define TIMER_OF_IS_CLOCKEVENT  0x10

In addition the API:

int timer_of_is_clocksource(struct timer_of *to)
{
	return (to & TIMER_OF_IS_CLOCKSOURCE);
}
int timer_of_is_clockevents(struct timer_of *to)
{
	return (to & TIMER_OF_IS_CLOCKEVENT);
}




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

