Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2133C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1124658
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 09:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576228692;
	bh=YDi2nL2pdMzIcbUQOsNhCRGTKAEMJ8JNqoS0JxCQt50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G/0EtC5CDSI+yT1qptflqf5iIQpaiS1hPPZa7FMoR8jWRMazg5Se3NnSavG79uf+a
	 0eAL3Xfywxw8DUxZlwQ16Cpt+2HKoXpiRfLZcq51jk5nt6x/lxiNh+1zXNaDhku1zs
	 UAJx3ocpONjwd+r5cFSvJ041MLYp10GkWoqXQDqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMJSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 04:18:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36767 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfLMJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:18:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id r19so1853074ljg.3;
        Fri, 13 Dec 2019 01:18:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RZ51uRTlJcv6c8enjZTOzifIqw0cVu1vMI6dvmNCekw=;
        b=B9gNUvtBEcd5FIuqBENpVyMAb01UBNBoM0kwj6htPtJ2jNXH7qwC/qvRs8Kes3/UR8
         cNnR7lPY0YGmgjC2GjkgrK+ncBrqPDz1uS7IdrNBb20iVTMyJ9ORbRANTGp1LewtsnhB
         iIOV4NJWzwmIE5qJJmXd0t7m0wC6rAhqpOEgv2N29clLpB78A0g5AWyjInv1cXsM1swB
         lXYVFUfcerhUHHVhalLYYsfGbJ3WppoW04/MyWQNJWqjkwjoRuShD32bmM+Hb0KreZDw
         WunR1E3Z514HmiW2dmIHfehb8tJFPNiexO0fWLEBt9XXG/34pbl1c06OGYj70GzwuIYb
         wMzQ==
X-Gm-Message-State: APjAAAWtfA1e6ku2DSbwWyQjRw5EW1pW8RGuTsm9yL7dZQugH+xj0Ssj
        9NLh1ITZ+91Zi1hzBW5p5hI=
X-Google-Smtp-Source: APXvYqwVxJbJvkmBpoQ44DVZmfkrX2ABY2jSL5V+LsTOqfrT61h5h4UZeIEkOUyzz6Rbwv1HTfRiaA==
X-Received: by 2002:a2e:850f:: with SMTP id j15mr8768401lji.91.1576228688991;
        Fri, 13 Dec 2019 01:18:08 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id l21sm4223245lfh.74.2019.12.13.01.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 01:18:08 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ifh5N-0007ZJ-0d; Fri, 13 Dec 2019 10:18:09 +0100
Date:   Fri, 13 Dec 2019 10:18:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, khilman@baylibre.com,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] bluetooth: hci_bcm: enable IRQ capability from node
Message-ID: <20191213091809.GW10631@localhost>
References: <20191211094923.20220-1-glaroque@baylibre.com>
 <cf77eec5df92b1845f0bf7cc8eb53edd4af9e1bf.camel@suse.de>
 <0CF02341-CF69-4680-B61F-DC5C0702F1A2@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0CF02341-CF69-4680-B61F-DC5C0702F1A2@holtmann.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 09:46:32PM +0100, Marcel Holtmann wrote:
> Hi Nicolas,
> 
> >> Actually IRQ can be found from GPIO but all platforms don't support
> >> gpiod_to_irq, it's the case on amlogic chip.
> >> so to have possibility to use interrupt mode we need to add interrupts
> >> field in node and support it in driver.
> >> 
> >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> >> ---
> >> drivers/bluetooth/hci_bcm.c | 3 +++
> >> 1 file changed, 3 insertions(+)
> > 
> > This triggers the following panic on Raspberry Pi 4:
> > 
> > [    6.634507] Unable to handle kernel NULL pointer dereference at virtual
> > address 0000000000000018

> >> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> >> index f8f5c593a05c..9f52d57c56de 100644
> >> --- a/drivers/bluetooth/hci_bcm.c
> >> +++ b/drivers/bluetooth/hci_bcm.c
> >> @@ -1409,6 +1409,7 @@ static int bcm_serdev_probe(struct serdev_device
> >> *serdev)
> >> {
> >> 	struct bcm_device *bcmdev;
> >> 	const struct bcm_device_data *data;
> >> +	struct platform_device *pdev;
> >> 	int err;
> >> 
> >> 	bcmdev = devm_kzalloc(&serdev->dev, sizeof(*bcmdev), GFP_KERNEL);
> >> @@ -1421,6 +1422,8 @@ static int bcm_serdev_probe(struct serdev_device
> >> *serdev)
> >> #endif
> >> 	bcmdev->serdev_hu.serdev = serdev;
> >> 	serdev_device_set_drvdata(serdev, bcmdev);
> >> +	pdev = to_platform_device(bcmdev->dev);
> > 
> > Ultimately bcmdev->dev here comes from a serdev device not a platform device,
> > right?
> 
> I was afraid of this, but then nobody spoke up. Can we fix this or
> should I just revert the patch?

Just revert it, the patch is plain broken and makes no sense.

As Nicolas pointed out, bcmdev->dev is a member of struct serdev_device
so cannot be cast to a platform device.

Johan
