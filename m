Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA7AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DA02133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 22:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="NKKbteQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfB1Wjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:39:51 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:37827 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfB1Wju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 17:39:50 -0500
Received: by mail-it1-f194.google.com with SMTP id z124so18425259itc.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 14:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=uHivxThy5oEIoOQZ8HlTW0n9/13W9GJOR3HZiimvqe4=;
        b=NKKbteQ4fC16pjtShMFPmcABZjmx5xOQ8ubr1qYkSgugFjzH8E5wF5+r24b/Nlhq3W
         w7HrTSQScJH5Nytju9ij9N49Fw+U/ywqxX2Z3nSVyQjkf5BcT2CpE+4U9Il0Z37D1xW5
         aMee85VMSq2n27cpw3wZwHeG00xNPKlv3s7Vx1cHjLmgCibNkCzI75T0EQYvFf3s83p2
         2SlYgZ4gF3vBbol1NjzQSj5tKaC10ZLpNsEzit2bZMqFj1nQKEfxJrvlozU+MOU6e1tz
         UybCMyBw5TpWcIpN/nyt1VVRRXWkDNGDVixbak1YXZDocFXXprR1EardZ/gsJ5W5v2LX
         xyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=uHivxThy5oEIoOQZ8HlTW0n9/13W9GJOR3HZiimvqe4=;
        b=j0LKzolrH4Sp7+wIFDpHe0Ijf+lSOYO9FyrxJt52RT/mbY9+t8/PL6QWoRTdqijTDx
         +xzuR++PeUFcVSSlgJZR0BDw9meTx3TVZEq0E7Ft+TJNDRRXbpNb1pSduDGq6VdHGts/
         5qJFziGblTAWelBQ9ikTUJPP7w9VuiV7xlGDyl8SEesmLsen/fDckc69kr6dTVpeK6o8
         EmTfIuAKFf8H8IPWizeFfhzX9x3AIHBcvoS6+dmrYMSywylazXinYVW56UiB08S905IG
         yOLZX2JfaJCDO+U0vcgboDjFp/D0HaSPbEdsev1b4Nz9icvpApSr/3NfrjxZHAQrCh4q
         zXDw==
X-Gm-Message-State: AHQUAuYAKrojVSz7VvNCdpSoNkeEH68f3fdkfDKZzh5NoDx36aPCBTet
        PhcenpKmx7m6pyTTPh0HV7gyBQ==
X-Google-Smtp-Source: AHgI3IZHOn1BV3fCTDaWj0JbPOQYCFPGhCxk4uLfF5Ger+Id7RirKEO093TXxBylha41EKDgbX23cw==
X-Received: by 2002:a24:43d1:: with SMTP id s200mr1426288itb.118.1551393589187;
        Thu, 28 Feb 2019 14:39:49 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id u197sm3400700itb.9.2019.02.28.14.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 14:39:48 -0800 (PST)
Date:   Thu, 28 Feb 2019 14:39:47 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "alistair23@gmail.com" <alistair23@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "of/device: Really only set bus DMA mask when
 appropriate"
In-Reply-To: <20190228223257.6189-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1902281437380.17965@viisi.sifive.com>
References: <20190228223257.6189-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alistair,

On Thu, 28 Feb 2019, Alistair Francis wrote:

> This reverts commit 6778be4e520959659b27a441c06a84c9cb009085.
> 
> Reverting the commit fixes these error messages and an non-functioning
> USB bus when attaching a USB to PCIe card to a RISC-V board:
>     xhci_hcd 0000:03:00.0: Host took too long to start, waited 16000 microseconds.
>     xhci_hcd 0000:03:00.0: startup error -19
>     xhci_hcd 0000:03:00.0: USB bus 2 deregistered
>     xhci_hcd 0000:03:00.0: WARNING: Host System Error
>     xhci_hcd 0000:03:00.0: remove, state 1
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> I'm not sure if this is the correct fix, it's possible something else is
> wrong, but I wanted to get some feedback.
> 
> drivers/of/device.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 3717f2a20d0d..8299f8055da7 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -149,11 +149,9 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>  	 * set by the driver.
>  	 */
>  	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
> +	dev->bus_dma_mask = mask;
>  	dev->coherent_dma_mask &= mask;
>  	*dev->dma_mask &= mask;
> -	/* ...but only set bus mask if we found valid dma-ranges earlier */

Does the DT data for the PCIe controller that you're using contain a 
dma-ranges node?

> -	if (!ret)
> -		dev->bus_dma_mask = mask;
>  
>  	coherent = of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",


- Paul
