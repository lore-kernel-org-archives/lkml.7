Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED95C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02818206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXXboVc7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfDQIGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:06:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51608 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfDQIF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:05:59 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so2216094wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PI+9kWespWroqsfzmFgybRIIwFO/E+pJGyIm3CKWQLk=;
        b=gXXboVc7qabiIXe3lYXP1Wl9FxK0ashMrfEYGagnHJFD+7QvNTKwB8TW4rJpCD74KR
         KZSfeTyx5bEtnVkmVmDYdNH8oNnfL9VfNusSd+7Nc0F3Yk3QVMh5mInI+t7ojUWAtpaR
         CSHoGrV7wPdzdrtJ/yMWed2CNvtG0UTPJTwfbeo1+lf3qlctVlqawboMv8ZomGCY2bEp
         WLmq17crmrQu/wkgw39ufFChcG2iBqiXt0kLhPeW3pHPPseMFSMBUDjRlkG7NoQgNLjv
         AQX3RNGQ6wB5oiZoXtBzL7GTz6/mUmRtLq215z+lNNhkYiDw1E9DQxCLEIfiRIQgxhZW
         Mt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PI+9kWespWroqsfzmFgybRIIwFO/E+pJGyIm3CKWQLk=;
        b=PEQsdVtxBy7HK8zC+uDr01IPcoilTeIWMuWDHMpM/g36o92pDQxnLwvqfbaVgj9D+g
         75/JrNbFrvI1e/eGryF5hHx6Fm4AeRNwbp7B3/7Vw4V/DZr2ULj1SHdcq56GwY9EApzd
         C0mVhmBMYM0NOzUQTL4fQ3RonZtASGBFlRRNvzO6em5EfYTrsmBsNaktrWlb3xUiuwcx
         VO8arNmLoQteEvAmv7wKUE5qwr8H1DZ/q0Gmh6IFkYzZqKb5mqoMQMGddeQB7ZDq1nDd
         SR/tTLDGuMGiLRISFarGRYa+g4DZiSt8TtdnSp8OgFjvTPOE33WAi7oJkdnqaccZxBXy
         OBHQ==
X-Gm-Message-State: APjAAAVmIdJUjll1/rXEWIObw7G0DOhFJu/DLUHtkoEcSlcFX6zDRpSf
        RgEoFHrpPvamANyaxOtUY88uhE0/cJI=
X-Google-Smtp-Source: APXvYqwMFbXOOGHbif5JJqQI4qd9Xeafj7oVZ0bCwVCGmINLYB3KNLVYoPUGho/dIl763uzppkCxSg==
X-Received: by 2002:a1c:495:: with SMTP id 143mr28199857wme.78.1555488357246;
        Wed, 17 Apr 2019 01:05:57 -0700 (PDT)
Received: from [192.168.0.41] (62.29.129.77.rev.sfr.net. [77.129.29.62])
        by smtp.googlemail.com with ESMTPSA id x192sm1728948wmf.48.2019.04.17.01.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 01:05:56 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after
 device initialization
To:     Jiada Wang <jiada_wang@mentor.com>, rui.zhang@intel.com,
        edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411100352.15977-1-jiada_wang@mentor.com>
 <92504666-9e17-4c6d-fc74-6cf68b9f017b@linaro.org>
 <9a4de8ca-fa49-2050-e40b-b54d03484213@mentor.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5e685e1d-dca7-7292-1342-dbe609c517d2@linaro.org>
Date:   Wed, 17 Apr 2019 10:05:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9a4de8ca-fa49-2050-e40b-b54d03484213@mentor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/04/2019 05:01, Jiada Wang wrote:
> Hi Daniel
> 
> On 2019/04/17 4:22, Daniel Lezcano wrote:
>> On 11/04/2019 12:03, Jiada Wang wrote:
>>> Currently IRQ is remain enabled after .remove, later if device is
>>> probed,
>>> IRQ is requested before .thermal_init, this may cause IRQ function be
>>> triggered but not able to clear IRQ status, thus cause system to hang.
>>>
>>> this patch by moving request of IRQ after device initialization to
>>> avoid this issue.
>>
>> Why not disable the interrupt and clear the irq status in the .remove
>> callback, so the place is clean when probing again?
>>
>>
>>          struct rcar_gen3_thermal_priv *priv = dev_get_drvdata(dev);
>>
>>          rcar_thermal_irq_set(priv, false);
>>
>> should do the trick no ?
>>
> yes, this issue also can be addressed by disable the interrupt in .remove.
> 
> But there is race condition between .remove and irq thread function,
> (which enables IRQ)
> so driver need to ensure threaded irq has been disabled before call
> rcar_thermal_irq_set(priv, false) in .remove.
> this adds additional complexity.
> 
> I am fine with both solutions,
> what is your opinion?

My opinion is it is the tree hiding the forest.

After a quick look at the irq setup and handling, it appears the
implementation is cumbersome. This part should be fixed before the rest:

 - check IRQF_ONESHOT flag
 - remove the lock in the interrupt handlers
 - remove rcar_gen3_thermal_irq() which is pointless
 - check the IRQF_SHARED flag is correct (I doubt)

As the function devm_request_threaded_irq() is called 3 times, you
should add the priv->tscs[i]->zone in the private data and the irq
thread handler should look like:

static irqreturn_t rcar_gen3_thermal_irq_thread(int irq, void *data)
{
	struct thermal_zone_device *tz = data;

	thermal_zone_device_update(tz, THERMAL_EVENT_UNSPECIFIED);

	[ ... ]

        return IRQ_HANDLED;
}

When the implementation is fixed, then we can take care of the .remove

>>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>>> ---
>>>   drivers/thermal/rcar_gen3_thermal.c | 48 ++++++++++++++++-------------
>>>   1 file changed, 26 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/thermal/rcar_gen3_thermal.c
>>> b/drivers/thermal/rcar_gen3_thermal.c
>>> index 88fa41cf16e8..4d095d7f9763 100644
>>> --- a/drivers/thermal/rcar_gen3_thermal.c
>>> +++ b/drivers/thermal/rcar_gen3_thermal.c
>>> @@ -375,28 +375,6 @@ static int rcar_gen3_thermal_probe(struct
>>> platform_device *pdev)
>>>         platform_set_drvdata(pdev, priv);
>>>   -    /*
>>> -     * Request 2 (of the 3 possible) IRQs, the driver only needs to
>>> -     * to trigger on the low and high trip points of the current
>>> -     * temp window at this point.
>>> -     */
>>> -    for (i = 0; i < 2; i++) {
>>> -        irq = platform_get_irq(pdev, i);
>>> -        if (irq < 0)
>>> -            return irq;
>>> -
>>> -        irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>>> -                     dev_name(dev), i);
>>> -        if (!irqname)
>>> -            return -ENOMEM;
>>> -
>>> -        ret = devm_request_threaded_irq(dev, irq,
>>> rcar_gen3_thermal_irq,
>>> -                        rcar_gen3_thermal_irq_thread,
>>> -                        IRQF_SHARED, irqname, priv);
>>> -        if (ret)
>>> -            return ret;
>>> -    }
>>> -
>>>       pm_runtime_enable(dev);
>>>       pm_runtime_get_sync(dev);
>>>   @@ -458,6 +436,32 @@ static int rcar_gen3_thermal_probe(struct
>>> platform_device *pdev)
>>>           goto error_unregister;
>>>       }
>>>   +    /*
>>> +     * Request 2 (of the 3 possible) IRQs, the driver only needs to
>>> +     * to trigger on the low and high trip points of the current
>>> +     * temp window at this point.
>>> +     */
>>> +    for (i = 0; i < 2; i++) {
>>> +        irq = platform_get_irq(pdev, i);
>>> +        if (irq < 0) {
>>> +            ret = irq;
>>> +            goto error_unregister;
>>> +        }
>>> +
>>> +        irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
>>> +                     dev_name(dev), i);
>>> +        if (!irqname) {
>>> +            ret = -ENOMEM;
>>> +            goto error_unregister;
>>> +        }
>>> +
>>> +        ret = devm_request_threaded_irq(dev, irq,
>>> rcar_gen3_thermal_irq,
>>> +                        rcar_gen3_thermal_irq_thread,
>>> +                        IRQF_SHARED, irqname, priv);
>>> +        if (ret)
>>> +            goto error_unregister;
>>> +    }
>>> +
>>>       rcar_thermal_irq_set(priv, true);
>>>         return 0;
>>>
>>
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

