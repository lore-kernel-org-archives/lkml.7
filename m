Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FCEC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14E052173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Elqvwcnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLGACH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:02:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38909 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfLGACH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:02:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id o8so3383942pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 16:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ypbI226Z6HwiGkoTR1JpKgba6WvTPNZIi/BPfsRGNIA=;
        b=ElqvwcnzW0W9oCfunbBUslllxAJJDJmQ5G7Vg6dFAlMWiLbJiFERQ1eoab+EKJa13n
         LJ4eaOrD2kcKMckHLdBkIbszs98PMOCN6X6zf1jWGpWVQWrYQrfvcQP41XMPGZcYBHAL
         9PmI459WbzY4zm6hoLqu9CuAADU1U8NRZVqRw/VpHvPNP8YW8c/JiSlvn41hPyyftJzt
         58WkGrLXxwLADXtYy/+T2EQtSHj2RKy5yYSTsak+LkyH8DUnBepvDl0Yd6QDJP4QVUke
         vQHhybKEmjVL9n/xAe8tSp3XYimepvOvb0If+4+oIxiVvPxtK8C9nhHMD1i6b3Us1G5e
         tt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ypbI226Z6HwiGkoTR1JpKgba6WvTPNZIi/BPfsRGNIA=;
        b=dH+Pqj/D3gkKd5GFF12uednk4IcdR3PmyzrVfMg8ExfExLnW0DhvsX/cku0kGoHg+I
         0P7eeJacrkb4SGnXffZesQBackiRqvHYb1gWQDOdU1CHUNJxC53O5JnHV4eD1ImWQR77
         lke/EECe5HSHppxw461KbEQRgoXaqbexWUYtMLkdlh+uCSq/q9TvFKL/KTq90OkyFA3y
         sQGdE1SUVRlT5G/4MufTKwa5FFabLCaqxskPcUoDCNdsn+0ah5lRTjCuWM7rX4rLTFIi
         tCecc7xRhWya1nVOpMrMSxwJso3YGw2uAzk9LcZ96tMeMriIEgF5z6Pq8Gxli8S54mth
         cn8g==
X-Gm-Message-State: APjAAAWuqd790Umo1u5MwKVvNPz6+Omr3eI795pXmt/B2JObdHI5MtLP
        PLKUcXfZjEV0k5o7EC4zw8AR5A==
X-Google-Smtp-Source: APXvYqxkRC1g7WD/h9hWhhUCNMxPtI4B4dxiEuhbxv6mOg5XJJm+jcwOGCOW6TkEFPfDGL+tX7EXKQ==
X-Received: by 2002:a17:902:ff15:: with SMTP id f21mr17121456plj.163.1575676926500;
        Fri, 06 Dec 2019 16:02:06 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id b10sm17715991pff.59.2019.12.06.16.02.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Dec 2019 16:02:05 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     guillaume La Roque <glaroque@baylibre.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bluetooth: hci_bcm: enable IRQ capability from node
In-Reply-To: <6f6cbb0d-3265-8e6d-60fb-6df2539d36af@baylibre.com>
References: <20191204161239.16653-1-glaroque@baylibre.com> <7hv9qu2rt1.fsf@baylibre.com> <6f6cbb0d-3265-8e6d-60fb-6df2539d36af@baylibre.com>
Date:   Fri, 06 Dec 2019 16:02:05 -0800
Message-ID: <7ho8wl0zr6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

guillaume La Roque <glaroque@baylibre.com> writes:

> hi Kevin,
>
>
> On 12/6/19 1:58 AM, Kevin Hilman wrote:
>> Guillaume La Roque <glaroque@baylibre.com> writes:
>>
>>> Actually IRQ can be found from GPIO but all platorms don't support
>> nit: s/platorms/platforms/
> will fix in v3
>>> gpiod_to_irq, it's the case on amlogic chip.
>>> so to have possibility to use interrupt mode we need to add interrupts
>>> field in node and support it in driver.
>>>
>>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>>> ---
>>> sorry for noise,
>>>
>>> v2 is for rebasing on master branch
>>>
>>> guillaume
>>>
>>>  drivers/bluetooth/hci_bcm.c | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
>>> index f8f5c593a05c..9f52d57c56de 100644
>>> --- a/drivers/bluetooth/hci_bcm.c
>>> +++ b/drivers/bluetooth/hci_bcm.c
>>> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device =
*serdev)
>>>  {
>>>  	struct bcm_device *bcmdev;
>>>  	const struct bcm_device_data *data;
>>> +	struct platform_device *pdev;
>>>  	int err;
>>>=20=20
>>>  	bcmdev =3D devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
>>> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device =
*serdev)
>>>  #endif
>>>  	bcmdev->serdev_hu.serdev =3D serdev;
>>>  	serdev_device_set_drvdata(serdev, bcmdev);
>>> +	pdev =3D to_platform_device(bcmdev->dev);
>>> +	bcmdev->irq =3D platform_get_irq(pdev, 0);
>> I don't know this driver well enough to be sure, but don't you need some
>> error checking here?
>>
>> If this fails (on platforms with no IRQ defined), is an error code in
>> bcmdev->irq going to affect later code that tries to setup IRQs?
>
> not needed to do something here because=C2=A0 bcm_get_resources function =
check irq <=3D0 if yes it check if host-wakeup gpio was defined in node and=
 try a gpiod_to_irq.
>
> at the end in bcm_request_irq function i check if irq <=3D0 if yes return=
 EOPNOTSUPP
>

OK, sounds good.  Thanks for clarifying.

Kevin
