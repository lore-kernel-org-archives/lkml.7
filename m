Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB93DC341C8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D66224725
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ly/oQT9L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbfLMMbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 07:31:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53109 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLMMbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 07:31:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so6181441wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z41FKQuYBUSuoSb2FV0vifxkTTBPMXxzD/YOhZ2tMXg=;
        b=Ly/oQT9L+ts7qFVZIDbECN/aSDdc+QRYixCMzB3z+8bWc36CMUodtwuYDGPaBOM/Ih
         gLkJq29oULc4rltitaD9MXHtFWZFPgwpOtHwj9ZMOKuo01Yy8jFUyMK5dFhAa75pBX+7
         CQMwgUHLt9uRCgaYBPs6z9R8fpeYG6seMH6b/CGWq0OB9ozvko1nV46ueLh0yAmeFB7U
         qot0qE7kJH6deDEOt5ZZTwWT5Keh4ntPraiEvn6E+TFHvEG2QCaC+sCh1TYeqJVDcnAq
         StldK8xrkuSot7KQ5sgxR+59OsbvQikY9X50zAf2wOgPOzKqLUlm24kNLlQy9Gg5lbuA
         Vlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z41FKQuYBUSuoSb2FV0vifxkTTBPMXxzD/YOhZ2tMXg=;
        b=Z1JQYX/DT/9uXQnch9DNSA923U0v/D+p1v8oaNe7Td/xfc8lBOf8HJTiH9NJafy/w8
         XtwV1PfXCXm2i9YvQ5MTUnigZ9V/lKTiwPN0z7URiVvlvaC25rfF3qdP+gjdg9OQ11zA
         XHw4EZNf9eiPyJwwidPXO2qeGN1DyMxnvrKz9JJVpVrJgfernf9Dek86H/OwOER5lhvl
         SJrUmxhJZH3DNoOPVv94EXzNtDCAKeVRuoBl+lJ1f27eF1jME4WAX9CN+n2JK9LAY1S4
         sjwiymIVqH+peJ21HfqIfAbhuwaYm00KAa/86RZDuL89e0WEwDJBTvD5quHNuTsn7J/n
         8yVQ==
X-Gm-Message-State: APjAAAUhzb1c6yBkcPqTGi19DODJPwkhTXNAiJgqz15u6aMQoxxtK3CL
        49SXp9d+wVE+njW6BvTKEVyUZw==
X-Google-Smtp-Source: APXvYqyI9oCoKlmkTNb1eHINYrX90erhUnwNmt0X9Htia3GuiYl8nmeYuA97/k8Vm2oQdER9i+aAoQ==
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr5002476wma.79.1576240279760;
        Fri, 13 Dec 2019 04:31:19 -0800 (PST)
Received: from ?IPv6:2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca? ([2a01:cb1d:6e7:d500:82a9:347a:43f3:d2ca])
        by smtp.gmail.com with ESMTPSA id g7sm9913377wrq.21.2019.12.13.04.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 04:31:19 -0800 (PST)
Subject: Re: [PATCH v4] bluetooth: hci_bcm: enable IRQ capability from node
To:     Johan Hovold <johan@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
References: <20191213105521.4290-1-glaroque@baylibre.com>
 <20191213111702.GX10631@localhost>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <162e5588-a702-6042-6934-dd41b64fa1dc@baylibre.com>
Date:   Fri, 13 Dec 2019 13:31:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191213111702.GX10631@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johan,

On 12/13/19 12:17 PM, Johan Hovold wrote:
> On Fri, Dec 13, 2019 at 11:55:21AM +0100, Guillaume La Roque wrote:
>> Actually IRQ can be found from GPIO but all platforms don't support
>> gpiod_to_irq, it's the case on amlogic chip.
>> so to have possibility to use interrupt mode we need to add interrupts
>> field in node and support it in driver.
> "node" is a bit vague, please refer to devicetree here and in the patch
> summary.
>
 i will
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  drivers/bluetooth/hci_bcm.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>> index f8f5c593a05c..aa194f8d703e 100644
>> --- a/drivers/bluetooth/hci_bcm.c
>> +++ b/drivers/bluetooth/hci_bcm.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/module.h>
>>  #include <linux/acpi.h>
>>  #include <linux/of.h>
>> +#include <linux/of_irq.h>
>>  #include <linux/property.h>
>>  #include <linux/platform_data/x86/apple.h>
>>  #include <linux/platform_device.h>
>> @@ -1421,6 +1422,7 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
>>  #endif
>>  	bcmdev->serdev_hu.serdev = serdev;
>>  	serdev_device_set_drvdata(serdev, bcmdev);
>> +	bcmdev->irq = of_irq_get(bcmdev->dev->of_node, 0);
> And this clearly makes no sense for acpi, so you'd need to add it to
> bcm_of_probe().
>
> Shouldn't you be used using of_irq_get_byname()?
i can use it if you prefer but no other interrupt need to be defined
>
> And since you're extending the binding, I think you need a preparatory
> patch documenting this in:
>
> 	Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
sorry i forgot this, i will do
>>  	/* Initialize routing field to an unused value */
>>  	bcmdev->pcm_int_params[0] = 0xff;
> Johan


thanks

Guillaume

