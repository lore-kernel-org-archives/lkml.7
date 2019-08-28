Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D5C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F412339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mghVl0G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfH1SH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:07:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40798 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfH1SH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:07:29 -0400
Received: by mail-pl1-f196.google.com with SMTP id h3so322476pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 11:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=4LY24jdGTgaoMQ8xfxyPP4Knk17bgdAs6BUO30/7gAE=;
        b=mghVl0G0s7qUglA4AZbMyRjBQagPeERGcvj/Y7r6XhF6gUAZnH40QR93aY+Drab1K8
         kdLbEf6039KznJkBRFRgUo8Ka1px5Nii9F/IRQLYTLs3UZEBA4QjWpaMhJzGNzzOByYM
         wsFFa1JtGEPu9nCXc3jO8skYuQ4cyk1fdEaVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=4LY24jdGTgaoMQ8xfxyPP4Knk17bgdAs6BUO30/7gAE=;
        b=dVDI0U5g/P+9gkzcFq4hR4q+shI9WENt1Zo1h+omx80oSZJWV2zW3Mh/BZ0fBaauvp
         sM1WsVxcMmvFMSzbQcdt9oJycI73cLUa6VZ7JEiZln0frRrz4/P5xqD5gUplZZYZfkho
         H6yXKAw4DQ9DSfs7g7HY9+h+w0NJ9Ij9Vkg19VKLHl8RYmiWaNQlPQ9evtSVOkKawcn6
         TtJF3SR0PjkRZK0pE6r7l9//GsoF+2lot5S5eLwMY+NLxFoVsrTYn9K00OZ6n2I2UrIF
         3gMPjqxOPNhNprKSeoSZE2LFdY/9VO9yo6LxzPHm45ADLj0pEteulQTWsyBD2j07Y9AK
         xAGQ==
X-Gm-Message-State: APjAAAUN7vFumWpcN04aMc0g6N1eiJVVa+YD/WB4fR/Qnn+iuJJ0+Gr6
        J65iYxWvVq5nt/02y+27oi256ExFFGIiBQ==
X-Google-Smtp-Source: APXvYqwXbDBBoaFXgodDghYqlSjalGi7xFKMnV8fFcoMSlJ2iAZp2QPfZJKq7lueSoL/t/RlQIN1Yw==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr5578624pls.26.1567015648232;
        Wed, 28 Aug 2019 11:07:28 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id v22sm2745313pgk.69.2019.08.28.11.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 11:07:27 -0700 (PDT)
Message-ID: <5d66c2df.1c69fb81.b094.745d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3003195.OAk3N042hN@phil>
References: <20190828082150.42194-1-swboyd@chromium.org> <20190828082150.42194-5-swboyd@chromium.org> <3003195.OAk3N042hN@phil>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v5 4/4] tpm: tpm_tis_spi: Support cr50 devices
To:     Heiko Stuebner <heiko@sntech.de>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 28 Aug 2019 11:07:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Heiko Stuebner (2019-08-28 10:36:29)
> Am Mittwoch, 28. August 2019, 10:21:50 CEST schrieb Stephen Boyd:
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1 Secure
> > Microcontroller requires a special driver to handle its specifics:
> >=20
> >  - need to ensure a certain delay between SPI transactions, or else
> >    the chip may miss some part of the next transaction
> >  - if there is no SPI activity for some time, it may go to sleep,
> >    and needs to be waken up before sending further commands
> >  - access to vendor-specific registers
> >=20
> > Cr50 firmware has a requirement to wait for the TPM to wakeup before
> > sending commands over the SPI bus. Otherwise, the firmware could be in
> > deep sleep and not respond. The method to wait for the device to wakeup
> > is slightly different than the usual flow control mechanism described in
> > the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> > start a SPI transfer so we can keep track of the last time the TPM
> > driver accessed the SPI bus to support the flow control mechanism.
>=20
> While the previous version did run just fine on my mainline gru-scarlet,
> this v5 very persistently runs into a panic on every boot:
>=20
> [    6.625500] Unable to handle kernel NULL pointer dereference at virtua=
l address 0000000000000000
> [    6.632983] tpm_tis_spi spi1.0: Timeout waiting for TPM ready IRQ
> [    6.637415] Mem abort info:
> [    6.637417]   ESR =3D 0x96000004
> [    6.637419]   Exception class =3D DABT (current EL), IL =3D 32 bits
> [    6.637423]   SET =3D 0, FnV =3D 0
> [    6.644235] tpm_tis_spi spi1.0: TPM ready IRQ confirmed on attempt 1
> [    6.647350]   EA =3D 0, S1PTW =3D 0
> [    6.647352] Data abort info:
> [    6.647353]   ISV =3D 0, ISS =3D 0x00000004
> [    6.647354]   CM =3D 0, WnR =3D 0
> [    6.647357] user pgtable: 4k pages, 48-bit VAs, pgdp=3D00000000eacc4000
> [    6.647361] [0000000000000000] pgd=3D0000000000000000
> [    6.694812] Internal error: Oops: 96000004 [#1] SMP
> [    6.700258] Modules linked in: tpm_tis_spi_mod(+) dw_mipi_dsi industri=
alio_triggered_buffer panfrost(+) drm_kms_helper videobuf2_memops kfifo_buf=
 tpm_tis_core ov2685 ov5695 cros_ec_sensors_core videobuf2_v4l2 gpu_sched t=
pm videobuf2_common v4l2_common v4l2_fwnode crct10dif_ce drm videodev phy_r=
ockchip_pcie phy_rockchip_dphy dw_wdt rng_core cros_ec_dev rockchip_thermal=
 i2c_hid elants_i2c mc drm_panel_orientation_quirks pwm_bl ipv6
> [    6.742857] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.3.0-rc6-02924-=
gef15fcdb727f-dirty #1308
> [    6.752580] Hardware name: Google Scarlet (DT)
> [    6.757542] pstate: a0000085 (NzCv daIf -PAN -UAO)
> [    6.762901] pc : __wake_up_common+0x58/0x170
> [    6.767670] lr : __wake_up_locked+0x18/0x20
> [    6.772340] sp : ffff000010003d40
> [    6.776038] x29: ffff000010003d40 x28: 0000000000000060=20
> [    6.781972] x27: 0000000000000000 x26: ffff000010e4fcef=20
> [    6.787905] x25: 0000000000000001 x24: 0000000000000000=20
> [    6.793838] x23: 0000000000000000 x22: 0000000000000000=20
> [    6.799772] x21: 0000000000000003 x20: ffff8000f0431308=20
> [    6.804944] dwmmc_rockchip fe320000.dwmmc: Unexpected data interrupt l=
atency
> [    6.805707] x19: ffff8000f04312f8 x18: 0000000000000000=20
> [    6.819504] x17: 0000000000000000 x16: 0000000000000000=20
> [    6.825437] x15: 0000000000000000 x14: 0000000000000000=20
> [    6.831370] x13: 0000000000000000 x12: ffff000010dc9688=20
> [    6.837304] x11: 071c71c71c71c71c x10: 0000000000000040=20
> [    6.843237] x9 : ffff000010de15d8 x8 : ffff000010de15d0=20
> [    6.849171] x7 : ffffffffffffffe8 x6 : 0000000000000000=20
> [    6.855104] x5 : 0000000000000000 x4 : 0000000000000000=20
> [    6.856947] tpm_tis_spi spi1.0: SPI transfer timed out
> [    6.861037] x3 : 0000000000000000 x2 : 0000000000000001=20
> [    6.861040] x1 : 0000000000000003 x0 : 0000000000000000=20
> [    6.861045] Call trace:
> [    6.866794] spi_master spi1: failed to transfer one message from queue
> [    6.872724]  __wake_up_common+0x58/0x170
> [    6.872727]  __wake_up_locked+0x18/0x20
> [    6.872732]  complete+0x74/0xa8
> [    6.900836]  cr50_spi_irq_handler+0x18/0x28 [tpm_tis_spi_mod]

Thanks! I forgot about pending interrupts and got a little overzealous
in consolidating that line of code. Can you try this patch?

---8<-----
diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
index 535674f4b02a..24b1fb514161 100644
--- a/drivers/char/tpm/cr50_spi.c
+++ b/drivers/char/tpm/cr50_spi.c
@@ -259,12 +259,12 @@ int cr50_spi_probe(struct spi_device *spi)
 	phy =3D &cr50_phy->spi_phy;
 	phy->flow_control =3D cr50_spi_flow_control;
 	phy->is_cr50 =3D true;
+	init_completion(&phy->ready);
=20
 	cr50_phy->access_delay =3D CR50_NOIRQ_ACCESS_DELAY;
-
-	mutex_init(&cr50_phy->time_track_mutex);
 	cr50_phy->wake_after =3D jiffies;
 	cr50_phy->last_access =3D jiffies;
+	mutex_init(&cr50_phy->time_track_mutex);
=20
 	if (spi->irq > 0) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq, cr50_spi_irq_handler,
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index fdac842a61ed..2f120ddce2d2 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -201,7 +201,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm=
_tis_spi_phy *phy,
 	if (!phy->iobuf)
 		return -ENOMEM;
=20
-	init_completion(&phy->ready);
 	phy->spi_device =3D spi;
=20
 	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
@@ -239,6 +238,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	else
 		irq =3D -1;
=20
+	init_completion(&phy->ready);
 	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
 }
=20
