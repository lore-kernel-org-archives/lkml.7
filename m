Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C14BC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FAF20856
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 23:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfDGXmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 19:42:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:45484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726223AbfDGXmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 19:42:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DA1DAE0E;
        Sun,  7 Apr 2019 23:41:57 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     George Hilliard <thirtythreeforty@gmail.com>,
        George Hilliard <thirtythreeforty@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Nishad Kamdar <nishadkamdar@gmail.com>,
        linux-kernel@vger.kernel.org,
        Sergej Perschin <ser.perschin@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <blogic@openwrt.org>
Date:   Mon, 08 Apr 2019 09:41:47 +1000
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
In-Reply-To: <CACmrr9gRRTpamy-0oQafzZ1a7jZZcHOQhGU8ghYLLD3XsEU3XA@mail.gmail.com>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org> <20190402103203.14959-4-gregkh@linuxfoundation.org> <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com> <87r2ak18yy.fsf@notabene.neil.brown.name> <20190402204658.GA5187@habor.localdomain> <CACmrr9gRRTpamy-0oQafzZ1a7jZZcHOQhGU8ghYLLD3XsEU3XA@mail.gmail.com>
Message-ID: <87bm1hz8lg.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03 2019, George Hilliard wrote:

> On Tue, Apr 2, 2019 at 3:45 PM Christian L=C3=BCtke-Stetzkamp
> <christian@lkamp.de> wrote:
>> There are two other larger differences that I found during my
>> work. One is that drivers/mmc/host/mtk-sd.c has much more features,
>> like voltage and clock handling and some support for high speed
>> modes. I don't know if these features are required/useful for this
>> device.
>
> For what it's worth, I found an old forum post of someone who was
> dealing with a crashy kernel on their mt7688.  They removed the
> mt7621-mmc driver and hacked the clock code out of the mainline
> driver.  Apparently it worked.  I never got around to duplicating
> their work, however.  (I too ran into severe instability problems with
> the mt7621-mmc driver, but they only appeared in conjunction with
> using the SLOB allocator.  I could never debug it because when JTAG
> was turned on, the SDMC peripheral was disabled for some reason I
> never discovered.  More info on that if someone is interested.)
>
> The correct way to do this would be to have a "compatible" flag that
> bypassed the clock handling code.  I don't think there are any
> relevant clocks to set up on the MT7628/MT7688 - the MSDC peripheral
> does not appear in the clock plan.
>
>> The other thing is the card detect handling. This driver is
>> doing the card detect / read only detection on its own, where the in
>> tree one just uses some default gpio functions there and I don't know
>> weather this must be changed or weather there is a gpio driver for the
>> mt7621.
>
> There is a "mtk,mt7621-gpio"-compatible GPIO driver available.
> Probably it would work with GPIO on new hardware that did not to route
> CD to the CD pin, because the CD pin is muxed using the same "SD card"
> pin state as the SD data pins.  I do not know if it is possible for
> the GPIO peripheral to read the pin while it is muxed to the SD
> controller, as would be necessary for existing hardware.
>
> George

FYI I have mmc working on my mt7621 board using the
drivers/mmc/host/mtk_sd.c driver and the following patch.
I haven't looked at the card-detect yet.

I'll post bits of this to relevant lists as they are ready, not to this
list any more.  If anyone would like to hear about my progress, please
let me know.

Thanks,
NeilBrown

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 833ef0590af8..45ae93114a07 100644
=2D-- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -366,6 +366,8 @@ struct mtk_mmc_compatible {
 	u8 clk_div_bits;
 	bool hs400_tune; /* only used for MT8173 */
 	u32 pad_tune_reg;
+	u32 caps;
+	u32 ocr_avail;
 	bool async_fifo;
 	bool data_tune;
 	bool busy_check;
@@ -507,6 +509,21 @@ static const struct mtk_mmc_compatible mt7622_compat =
=3D {
 	.support_64g =3D false,
 };
=20
+static const struct mtk_mmc_compatible mt7620_compat =3D {
+	.clk_div_bits =3D 8,
+	.hs400_tune =3D false,
+	.pad_tune_reg =3D MSDC_PAD_TUNE,
+	.async_fifo =3D false,
+	.data_tune =3D false,
+	.busy_check =3D false,
+	.stop_clk_fix =3D false,
+	.enhance_rx =3D false,
+	.caps =3D (MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED |
+		 MMC_CAP_SD_HIGHSPEED),
+	.ocr_avail =3D (MMC_VDD_28_29 | MMC_VDD_29_30 | MMC_VDD_30_31 |
+		      MMC_VDD_31_32 | MMC_VDD_32_33),
+};
+
 static const struct of_device_id msdc_of_ids[] =3D {
 	{ .compatible =3D "mediatek,mt8135-mmc", .data =3D &mt8135_compat},
 	{ .compatible =3D "mediatek,mt8173-mmc", .data =3D &mt8173_compat},
@@ -514,6 +531,7 @@ static const struct of_device_id msdc_of_ids[] =3D {
 	{ .compatible =3D "mediatek,mt2701-mmc", .data =3D &mt2701_compat},
 	{ .compatible =3D "mediatek,mt2712-mmc", .data =3D &mt2712_compat},
 	{ .compatible =3D "mediatek,mt7622-mmc", .data =3D &mt7622_compat},
+	{ .compatible =3D "ralink,mt7620-sdhci", .data =3D &mt7620_compat},
 	{}
 };
 MODULE_DEVICE_TABLE(of, msdc_of_ids);
@@ -2194,13 +2212,17 @@ static int msdc_drv_probe(struct platform_device *p=
dev)
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |=3D MMC_CAP2_SDIO_IRQ_NOTHREAD;
=20
=2D	mmc->caps |=3D MMC_CAP_ERASE | MMC_CAP_CMD23;
+	mmc->caps |=3D MMC_CAP_ERASE | MMC_CAP_CMD23 |
+		host->dev_comp->caps;
+	mmc->f_max =3D host->src_clk_freq;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs =3D MAX_BD_NUM;
 	mmc->max_seg_size =3D BDMA_DESC_BUFLEN;
 	mmc->max_blk_size =3D 2048;
 	mmc->max_req_size =3D 512 * 1024;
 	mmc->max_blk_count =3D mmc->max_req_size / 512;
+	mmc->ocr_avail |=3D host->dev_comp->ocr_avail;
+
 	if (host->dev_comp->support_64g)
 		host->dma_mask =3D DMA_BIT_MASK(36);
 	else
@@ -2226,8 +2248,13 @@ static int msdc_drv_probe(struct platform_device *pd=
ev)
 	msdc_ungate_clock(host);
 	msdc_init_hw(host);
=20
=2D	ret =3D devm_request_irq(&pdev->dev, host->irq, msdc_irq,
=2D		IRQF_TRIGGER_LOW | IRQF_ONESHOT, pdev->name, host);
+	if (irq_get_trigger_type(host->irq) =3D=3D IRQ_TYPE_NONE)
+		ret =3D devm_request_irq(&pdev->dev, host->irq, msdc_irq,
+				       IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				       pdev->name, host);
+	else
+		ret =3D devm_request_irq(&pdev->dev, host->irq, msdc_irq,
+				       0, pdev->name, host);
 	if (ret)
 		goto release;
=20
diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt762=
1-dts/mt7621.dtsi
index 86f630045c13..54f33857a17d 100644
=2D-- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -34,6 +34,12 @@
 		clock-output-names =3D "cpu", "bus";
 	};
=20
+	mmc_clock: mmc_clock@0 {
+		#clock-cells =3D <0>;
+		compatible =3D "fixed-clock";
+		clock-frequency =3D <48000000>;
+	};
+
 	palmbus: palmbus@1E000000 {
 		compatible =3D "palmbus";
 		reg =3D <0x1E000000 0x100000>;
@@ -292,6 +298,13 @@
 		compatible =3D "ralink,mt7620-sdhci";
 		reg =3D <0x1E130000 0x4000>;
=20
+		pinctrl-names =3D "default", "state_uhs";
+		pinctrl-0 =3D <&sdhci_pins>;
+		pinctrl-1 =3D <&sdhci_pins>;
+
+		clocks =3D <&mmc_clock &mmc_clock>;
+		clock-names =3D "source", "hclk";
+
 		interrupt-parent =3D <&gic>;
 		interrupts =3D <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
 	};

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyqirsACgkQOeye3VZi
gblwRQ/+I0kSmtJcZBRM/GFJ3BMqHGNUTu1MA07j5ZglGzLQrin1+j13f/0ko6gx
61udLhnnS8YoYd5Vf7QD5/AmsYbizw/SeZ3hLIXTL7IZSA9zcAExIHq7J7qigbyF
FBzwuh4HEVZVNvs5WfVk70QPhQSl6jEsXTLdmPz1MQVenFpAXGAtpffdmgCF5fPw
fjj//ztsfM3hcbck2TyH/tluSJMbQql1PhoFgF9L217MzTXu6VGGgkF2Y0JGm0Fa
3PF0f9H9/ctT5nOcMzXIfEBtMRpG8Ct5n04eVgfEIYcBZ1g1WTI4eZ2l4yFBkPo8
8p25f2XcgeThpTejGY+t+aen1woMFGfKJEdcqYK9zIDObi2RjKLWdj6JY7kRkqfi
Nbh134kz4bXzL2spEbvFTWk8mRGQ5PFMsgoRBfIJYzPf3RMFbSb9a84DJITGl8cj
+c6ePfx98yTQGCYJO/R6fBls6AoFA0YUkC6B5tUPqtUacXZwFCK14OhwS5lG4CcK
fUFk2exFkIRH0p/X2rhHGHBtSGgSJzuUqM9vHbe6WJWmuKcJ9NcoXe7syo+oAMZm
B0qF4HNqLo1OqFcgLIgSrSUAZjDY+L1mFaGzOivSaE7x0EaFUma0FrA7NkLq8fNa
Kz7m+ociqx4ZHt3SLO1f86qbbRnJRPzZIMj1JR5TB1I4sXdlKR0=
=vFw3
-----END PGP SIGNATURE-----
--=-=-=--
