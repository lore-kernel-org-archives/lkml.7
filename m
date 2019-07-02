Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CCC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37CC120B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoMSY239"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfGBQy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:54:59 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:50454 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGBQy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:54:59 -0400
Received: by mail-wm1-f41.google.com with SMTP id n9so1569374wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CimDCDGoDfxfHpl+rKhISumqp5NNRWpGlcfKsYJsg90=;
        b=eoMSY2395eqnBmzs60/mrSzr+W9p/RaS1h6zhNKCXI9HsqXF5vyNS923QFIAS0RjxX
         kpe4CRg43qJufKYPk6K1oNG4MLeKupRXl6/vzeGYK/0DekR0fAeaSgOY0MIatqEw2Ezi
         glHEcP/F2J4vJOFcMSZp2RW76PAiaJZ3WtSDPeO6FH3sYpxNsuwGsZ+s4KKTwcR0dlPa
         6lYzpot2hHny8J286wqn5XbmsSsWYiVhI6CFWI2KRYKSq+5JFwjMOtixnMCMtjYvUACv
         Hm/Gadim5oSfo8WMwGMeSJgnyCNOrTM+Ylv6P2hyPYUZ9ziT2RqMSh5dUb6GvJ9OMV/V
         Gaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CimDCDGoDfxfHpl+rKhISumqp5NNRWpGlcfKsYJsg90=;
        b=DRYrNr2u+51db87ENaNsvcKWriqir7AGTXpGcHe1IhTk+f/2ZRCRa75+oDbsfH0hnY
         L/L7G1C65XYGeUhjKAtKsRhL4FP/YJ51cCdViF5WJ99At6+me28xlX96NHuIAsy5rRBz
         ShckdFiAVDFWsCbqmON+x2RMeIqkdtYmIAWmaMYuGH4uwR1ygOFAt+osxdkH1XJUOEGD
         8DXLy47IhlgI7veskdrAHvdjEVP60r2LugijlSxVMQHDehngb3hFcYeHv7qAcz/gk/iX
         OXatL+SZ5X9b8F6llc0trQRWaS5lpjMwS7Vy8YGvJ0KobZcbAU5BxtHMCw9Dz9ALYthT
         zhgQ==
X-Gm-Message-State: APjAAAXN8E1ZOtzZOqQnfvQcQrjbBPkpI18AHhY36rfo4unwie/xK6rC
        ZNNXbbWrV+gf6g0bV16Ee2Uamw==
X-Google-Smtp-Source: APXvYqzorO0l43WUW0HU+l8DROk7HfESLlwuN0S38IG5WqRioa3y9qGboUPucd/0wLqFrSB2htFA0A==
X-Received: by 2002:a7b:c313:: with SMTP id k19mr3931340wmj.2.1562086496818;
        Tue, 02 Jul 2019 09:54:56 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h84sm3426757wmf.43.2019.07.02.09.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:54:55 -0700 (PDT)
Subject: Re: nvmem creates multiple devices with the same name
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20190521085641.i6g5aijwa5zbolah@pengutronix.de>
 <a9ccac90-7b2f-41da-2ca9-ca3bba52781b@linaro.org>
 <20190521092107.zpdkkhaanzruhqui@pengutronix.de>
 <20190701080642.4oxmw7c3rmwrt5ee@pengutronix.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <45d0cfaf-2511-4b1e-f4da-b67fa9f9e867@linaro.org>
Date:   Tue, 2 Jul 2019 17:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190701080642.4oxmw7c3rmwrt5ee@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On 01/07/2019 09:06, Sascha Hauer wrote:
> Hi Srinivas,
> 
> On Tue, May 21, 2019 at 11:21:07AM +0200, Sascha Hauer wrote:
>> On Tue, May 21, 2019 at 10:02:32AM +0100, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 21/05/2019 09:56, Sascha Hauer wrote:
>>>> . Are there any suggestions how to register the nvmem devices
>>>> with a different name?
>>>
>>> struct nvmem_config provides id field for this purpose, this will be used by
>>> nvmem to set the device name space along with name field.
>>
>> There's no way for a caller to know a unique name/id combination.
>> The mtd layer could initialize the id field with the mtd number, but
>> that would still not guarantee that another caller, like an EEPROM
>> driver or such, doesn't use the same name/id combination.
> 
> This is still an unresolved issue. Do you have any input how we could
> proceed here?

Sorry for the delay!
I think simplest solution would be to check if there is already an nvmem 
provider with the same name before assigning name to the device and then 
append the id in case it exists.

Let me know if below patch helps the situation so that I can take this 
in next cycle!

----------------------------------->cut<----------------------------
     nvmem: core: Check nvmem device name before adding the same one

     In some usecases where nvmem names are directly derived from
     partition names, its likely that different devices might have
     same partition name.
     This will be an issue as we will be creating two different
     nvmem devices with same name and sysfs will not be very happy with 
that.

     Simple solution is to check the existance of the nvmem provider with
     same name and append an id if it exists before creating the device 
name.

     Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index f24008b66826..cf70a405023c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -641,7 +641,11 @@ struct nvmem_device *nvmem_register(const struct 
nvmem_config *config)
                 nvmem->dev.of_node = config->dev->of_node;

         if (config->id == -1 && config->name) {
-               dev_set_name(&nvmem->dev, "%s", config->name);
+               if (nvmem_find(config->name))
+                       dev_set_name(&nvmem->dev, "%s%d", config->name,
+                                    nvmem->id);
+               else
+                       dev_set_name(&nvmem->dev, "%s", config->name);
         } else {
                 dev_set_name(&nvmem->dev, "%s%d",
                              config->name ? : "nvmem",
----------------------------------->cut<----------------------------
> 
> Thanks
>   Sascha
> 
