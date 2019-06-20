Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414CFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1FC2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dnqBRU4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfFTOq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:46:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59834 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfFTOq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:46:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5KEkmor098920;
        Thu, 20 Jun 2019 09:46:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561042009;
        bh=sQX2i5IGsl3vihAlodZ3TP/Eg3a+lh9I2QnVBA7Vtig=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=dnqBRU4y3JnnbZmkZ8b9Ry7+YgJg1/HcassHVppi6O76Rar7epCqL5+Hy/KNA8Y4m
         QT6KcfBP4ryUE6RCDU/GvVHmhkA4bf+Yy+mx03EznPFLcJdAL5u5GhYF2zpKQI7CVV
         U/lioyAY9wjxB2oIWxLGF52yYitlwQStipNL2ShU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5KEkmGG067841
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jun 2019 09:46:48 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 20
 Jun 2019 09:46:48 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 20 Jun 2019 09:46:48 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5KEkiH2118963;
        Thu, 20 Jun 2019 09:46:45 -0500
Subject: Re: [PATCH] backlight: gpio-backlight: Set power state instead of
 brightness at probe
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20190517150546.4508-1-paul.kocialkowski@bootlin.com>
 <bee40295b2c6b489468d4e1fc12d7a1ac122cb9b.camel@bootlin.com>
 <29712212-0567-702b-fbc9-c0f37806d84c@linaro.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <fc58a7f5-a71d-f559-80a4-81be54e66bc6@ti.com>
Date:   Thu, 20 Jun 2019 17:47:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <29712212-0567-702b-fbc9-c0f37806d84c@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On 20/06/2019 16.56, Daniel Thompson wrote:
> On 18/06/2019 13:58, Paul Kocialkowski wrote:
>> Hi,
>>
>> On Fri, 2019-05-17 at 17:05 +0200, Paul Kocialkowski wrote:
>>> On a trivial gpio-backlight setup with a panel using the backlight but
>>> no boot software to enable it beforehand, we fall in a case where the
>>> backlight is disabled (not just blanked) and thus remains disabled when
>>> the panel gets enabled.
>>>
>>> Setting gbl->def_value via the device-tree prop allows enabling the
>>> backlight in this situation, but it will be unblanked straight away,
>>> in compliance with the binding. This does not work well when there
>>> was no
>>> boot software to display something before, since we really need to
>>> unblank
>>> by the time the panel is enabled, not before.
>>>
>>> Resolve the situation by setting the brightness to 1 at probe and
>>> managing the power state accordingly, a bit like it's done in
>>> pwm-backlight.
>>
>> Any feedback on this? I was under the impression that it could be quite
>> controversial, as it implies that the backlight can no longer be
>> enabled without a bound panel (which IMO makes good sense but could be
>> a matter to debate).
> 
> My apologies. This patch brought on such severe deja-vu I got rather
> confused. Then when I went digging I've also dropped the ball on the
> same feature previously.
> 
> Peter Ujfalusi provided a similar patch to yours but with a slightly
> different implementation:
> https://lore.kernel.org/patchwork/patch/1002359/
> 
> On the whole I think it is important to read the GPIO pin since
> otherwise we swap problems when there bootloader does setup the
> backlight for problems where it does not.
> 
> The thing I don't get is why both patches try to avoid setting the
> backlight brightness from def_value. Simple displays, especially
> monochrome ones are perfectly readable with the backlight off... zero
> brightness is not a "bad" value.

Because we might have non monochrome displays where the display is not
readable when the backlight is off and for the sake of to be consistent?
Flickering backlight is not really a nice thing during boot.

> Not sure if Peter is still willing to rev his version of this code
> (given how badly we neglected him previously) or whether you want to try
> and combine both ideas.

Nothing special, things sometimes got overlooked.
I should have been nagging you about it ;)

I think the v2 patch from me should apply just fine and it has the gpio
read as well, if not, then I might not be able to resend as I'm out of
office for a while

- Péter


> 
> 
> Daniel.
> 
> 
>>
>> Cheers,
>>
>> Paul
>>
>>> Fixes: 8b770e3c9824 ("backlight: Add GPIO-based backlight driver")
>>> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>>> ---
>>>   drivers/video/backlight/gpio_backlight.c | 19 ++++++++++++++++++-
>>>   1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/video/backlight/gpio_backlight.c
>>> b/drivers/video/backlight/gpio_backlight.c
>>> index e470da95d806..c9cb97fa13d0 100644
>>> --- a/drivers/video/backlight/gpio_backlight.c
>>> +++ b/drivers/video/backlight/gpio_backlight.c
>>> @@ -57,6 +57,21 @@ static const struct backlight_ops
>>> gpio_backlight_ops = {
>>>       .check_fb    = gpio_backlight_check_fb,
>>>   };
>>>   +static int gpio_backlight_initial_power_state(struct
>>> gpio_backlight *gbl)
>>> +{
>>> +    struct device_node *node = gbl->dev->of_node;
>>> +
>>> +    /* If we absolutely want the backlight enabled at boot. */
>>> +    if (gbl->def_value)
>>> +        return FB_BLANK_UNBLANK;
>>> +
>>> +    /* If there's no panel to unblank the backlight later. */
>>> +    if (!node || !node->phandle)
>>> +        return FB_BLANK_UNBLANK;
>>> +
>>> +    return FB_BLANK_POWERDOWN;
>>> +}
>>> +
>>>   static int gpio_backlight_probe_dt(struct platform_device *pdev,
>>>                      struct gpio_backlight *gbl)
>>>   {
>>> @@ -142,7 +157,9 @@ static int gpio_backlight_probe(struct
>>> platform_device *pdev)
>>>           return PTR_ERR(bl);
>>>       }
>>>   -    bl->props.brightness = gbl->def_value;
>>> +    bl->props.brightness = 1;
>>> +    bl->props.power = gpio_backlight_initial_power_state(gbl);
>>> +
>>>       backlight_update_status(bl);
>>>         platform_set_drvdata(pdev, bl);
> 


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
