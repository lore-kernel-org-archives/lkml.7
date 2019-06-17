Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88E6C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A722087F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfFQKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:08:31 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52770 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfFQKIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:08:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5D84F263992
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
To:     Pavel Machek <pavel@ucw.cz>, Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
References: <20190614224533.169881-1-mka@chromium.org>
 <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c88619de-45f4-9ba7-cfdc-0cedb764f6f4@collabora.com>
Date:   Mon, 17 Jun 2019 12:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/6/19 17:41, Pavel Machek wrote:
> Hi!
> 
>> This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
>>
>> According to the commit message the AUO B101EAN01 panel on minnie
>> requires a PWM delay of 200 ms, however this is not what the
>> datasheet says. The datasheet mentions a *max* delay of 200 ms
>> for T2 ("delay from LCDVDD to black video generation") and T3
>> ("delay from LCDVDD to HPD high"), which aren't related to the
>> PWM. The backlight power sequence does not specify min/max
>> constraints for T15 (time from PWM on to BL enable) or T16
>> (time from BL disable to PWM off).
>>

Hmm, clearly we are not looking at the same datasheet, because in the one I have
I don't see any reference to T15/T16 or LCDVDD. And, I assume I am probably
wrong because you might have better access to the specific panel specs for minnie.

I looked at my archive and the datasheet I have is similar to this [1]. In page
21, Section 6.5 Power ON/OFF Sequence, there are two delays T3 and T4, it is
*min* time between the pwm signal and the bl_en and it is 200 ms. That's the
delay the patch was adding.

[1] http://www.yslcd.com.tw/docs/product/B101EAN01.1.pdf

>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>> Enric, if you think I misinterpreted the datasheet please holler!
> 
> Was this tested? Was previous patch tested?
> 

IIRC, It was tested measuring the backlight power on timing (although I am not
sure if I tested this on minnie or another board with better access to the pins)

> Does patch being reverted actually break anything? If so, cc stable?
> 
> 								Pavel
> 								
> 

Probably will not break anything, I don't remember the reverted patch as a fix
of any specific issue. IIRC it was more a fear to be out of specs but I'll not
be surprised if the datasheet lies and this delay is not needed at all.

Matthias, are you reverting this to solve any problem? Could you share your
datasheet?

Thanks,
~Enric
