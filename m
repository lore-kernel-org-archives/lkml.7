Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C92C4649A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380A21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 08:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfGEIs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 04:48:59 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41281 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGEIs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 04:48:59 -0400
Received: by mail-ed1-f65.google.com with SMTP id p15so7539922eds.8;
        Fri, 05 Jul 2019 01:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DrtkCOU3d35z8J32aN8s3zZgpzBWbHJuGIW4lFwRsYw=;
        b=XrtSRwSHZloS2G5Heluef/b7vZruYDB/jfr5+ZMhwOsj1gnjx56ZJhW5HQ7OrrWzMx
         4cfKp3M2DF2i9gBvDefGKhK5Vub75xsel3BWI3MiqjXCRQAZSeuT0UPSg19ziVaxMWOG
         F+FMt9PcsbdxgG/lBhIu93ehH4hYMSdB/CSQg790jbIz0bGwW83FFegsM7DucUNxeDYP
         Imuwn0GxCvXYKPHS7E0f4BE/RduVDseOPEa0nvS63Tu+8bkFkMEDuB51+CUkI1zT4VnX
         Ca+SBNBEBrEK2ieUkT60fOB6SaSviGaDPAv7f0Egm+6pwVS/8almxhxfJXvdOKqVWcE9
         BX+w==
X-Gm-Message-State: APjAAAUmjJEDFX34nsWb8c3H4cOgiL3kNEJ/GmEUCqnL4uSTl0CNc4hm
        r4iBh4eKEQ3uNjikeSDjZiNs9nn3JsE=
X-Google-Smtp-Source: APXvYqwu+bxllRyOqly7Q+oL0fEOlMYhSGmI+6IFW1TpYlK7nJPYua/M0lZo8p1L/k1DbOthpzHkeQ==
X-Received: by 2002:a50:a485:: with SMTP id w5mr3138570edb.277.1562316536934;
        Fri, 05 Jul 2019 01:48:56 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id d4sm2456460edb.4.2019.07.05.01.48.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jul 2019 01:48:55 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id n4so9088509wrs.3;
        Fri, 05 Jul 2019 01:48:55 -0700 (PDT)
X-Received: by 2002:a5d:568e:: with SMTP id f14mr2777076wrv.167.1562316534957;
 Fri, 05 Jul 2019 01:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190513142410.9299-1-um@mutluit.com>
In-Reply-To: <20190513142410.9299-1-um@mutluit.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 5 Jul 2019 16:48:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v67OEa+ge7qpbNa5R7DCpgwKfs4T8KHTKe4fnuQYwzJURQ@mail.gmail.com>
Message-ID: <CAGb2v67OEa+ge7qpbNa5R7DCpgwKfs4T8KHTKe4fnuQYwzJURQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v3] drivers: ata: ahci_sunxi: Increased
 SATA/AHCI DMA TX/RX FIFOs
To:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-ide@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Uenal Mutlu <um@mutluit.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Pablo Greco <pgreco@centosproject.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Schinagl <oliver@schinagl.nl>,
        Linus Walleij <linus.walleij@linaro.org>,
        FUKAUMI Naoki <naobsd@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 10:24 PM Uenal Mutlu <um@mutluit.com> wrote:
>
> Increasing the SATA/AHCI DMA TX/RX FIFOs (P0DMACR.TXTS and .RXTS, ie.
> TX_TRANSACTION_SIZE and RX_TRANSACTION_SIZE) from default 0x0 each
> to 0x3 each, gives a write performance boost of 120 MiB/s to 132 MiB/s
> from lame 36 MiB/s to 45 MiB/s previously.
> Read performance is above 200 MiB/s.
> [tested on SSD using dd bs=4K/8K/12K/16K/20K/24K/32K: peak-perf at 12K]
>
> Tested on the SBCs Banana Pi R1 (aka Lamobo R1) and Banana Pi M1 which
> are based on the Allwinner A20 32bit-SoC (ARMv7-a / arm-linux-gnueabihf).
> These devices are RaspberryPi-like small devices.
>
> This problem of slow SATA write-speed with these small devices lasts
> for about 7 years now (beginning with the A10 SoC). Many commentators
> throughout the years wrongly assumed the slow write speed was a
> hardware limitation. This patch finally solves the problem, which
> in fact was just a hard-to-find software problem due to lack of
> SATA/AHCI documentation by the SoC-maker Allwinner Technology.
>
> Lists of the affected sunxi and other boards and SoCs with SATA using
> the ahci_sunxi driver:
>   $ grep -i -e "^&ahci" arch/arm/boot/dts/sun*dts
>   and http://linux-sunxi.org/SATA#Devices_with_SATA_ports
>   See also http://linux-sunxi.org/Category:Devices_with_SATA_port
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Uenal Mutlu <um@mutluit.com>

Tested-by: Chen-Yu Tsai <wens@csie.org>

on a Lamabo R1 as well.

Maybe we could merge this soon so it makes the next merge window?

Thanks.
