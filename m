Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A15C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA92420880
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 09:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfHEJXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 05:23:39 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:28453 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbfHEJXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 05:23:39 -0400
Received: from twhfmnt1.mxic.com.tw (twhfm1p2.macronix.com [172.17.20.92])
        by TWHMLLG4.macronix.com with ESMTP id x759LnQD050642;
        Mon, 5 Aug 2019 17:21:49 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from MXML06C.mxic.com.tw (mxml06c.macronix.com [172.17.14.55])
        by Forcepoint Email with ESMTP id AB2C310B77D2B23713D5;
        Mon,  5 Aug 2019 17:21:49 +0800 (CST)
In-Reply-To: <20190801082233.759f6ae9@collabora.com>
References: <1564631710-30276-1-git-send-email-masonccyang@mxic.com.tw> <1564631710-30276-2-git-send-email-masonccyang@mxic.com.tw> <20190801082233.759f6ae9@collabora.com>
To:     "Boris Brezillon" <boris.brezillon@collabora.com>
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        christophe.kerello@st.com, computersforpeace@gmail.com,
        devicetree@vger.kernel.org, dwmw2@infradead.org,
        juliensu@mxic.com.tw, lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, mark.rutland@arm.com,
        miquel.raynal@bootlin.com, paul@crapouillou.net,
        paul.burton@mips.com, richard@nod.at, robh+dt@kernel.org,
        stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v6 1/2] mtd: rawnand: Add Macronix raw NAND controller driver
MIME-Version: 1.0
X-KeepSent: 566978C2:AD9BE9D7-4825844D:0030DD04;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.3FP4 SHF90 June 10, 2013
Message-ID: <OF566978C2.AD9BE9D7-ON4825844D.0030DD04-4825844D.00336FFE@mxic.com.tw>
From:   masonccyang@mxic.com.tw
Date:   Mon, 5 Aug 2019 17:21:50 +0800
X-MIMETrack: Serialize by Router on MXML06C/TAIWAN/MXIC(Release 9.0.1FP10 HF265|July 25, 2018) at
 2019/08/05 PM 05:21:49,
        Serialize complete at 2019/08/05 PM 05:21:49
Content-Type: text/plain; charset="US-ASCII"
X-MAIL: TWHMLLG4.macronix.com x759LnQD050642
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Boris,

> > +
> > +struct mxic_nand_ctlr {
> > +   struct clk *ps_clk;
> > +   struct clk *send_clk;
> > +   struct clk *send_dly_clk;
> > +   void __iomem *regs;
> > +   struct nand_controller controller;
> > +   struct device *dev;
> > +   void *priv;
> 
> Looks like this priv field point to a nand_chip object. Please replace
> it by:
> 
>    struct nand_chip *chip;

okay, will fix.

> 
> > +};
> > +
> > +struct mxic_nand_chip {
> > +   struct nand_chip chip;
> > +};
> 
> No need to define your own nand_chip struct if all it contains is the
> base definition.

okay, will fix.

> 
> > +
> > +static int mxic_nfc_clk_enable(struct mxic_nand_ctlr *nfc)
> > +{
> > +   int ret;
> > +
> > +   ret = clk_prepare_enable(nfc->ps_clk);
> > +   if (ret)
> > +      return ret;
> > +
> > +   ret = clk_prepare_enable(nfc->send_clk);
> > +   if (ret)
> > +      goto err_ps_clk;
> > +
> > +   ret = clk_prepare_enable(nfc->send_dly_clk);
> > +   if (ret)
> > +      goto err_send_dly_clk;
> > +
> > +   return ret;
> > +
> > +err_send_dly_clk:
> > +   clk_disable_unprepare(nfc->send_clk);
> > +err_ps_clk:
> > +   clk_disable_unprepare(nfc->ps_clk);
> > +
> > +   return ret;
> > +}
> > +
> > +static void mxic_nfc_clk_disable(struct mxic_nand_ctlr *nfc)
> > +{
> > +   clk_disable_unprepare(nfc->send_clk);
> > +   clk_disable_unprepare(nfc->send_dly_clk);
> > +   clk_disable_unprepare(nfc->ps_clk);
> > +}
> > +
> > +static void mxic_nfc_set_input_delay(struct mxic_nand_ctlr *nfc, u8 
idly_code)
> > +{
> > +   writel(IDLY_CODE_VAL(0, idly_code) |
> > +          IDLY_CODE_VAL(1, idly_code) |
> > +          IDLY_CODE_VAL(2, idly_code) |
> > +          IDLY_CODE_VAL(3, idly_code),
> > +          nfc->regs + IDLY_CODE(0));
> > +   writel(IDLY_CODE_VAL(4, idly_code) |
> > +          IDLY_CODE_VAL(5, idly_code) |
> > +          IDLY_CODE_VAL(6, idly_code) |
> > +          IDLY_CODE_VAL(7, idly_code),
> > +          nfc->regs + IDLY_CODE(1));
> > +}
> > +
> > +static int mxic_nfc_clk_setup(struct mxic_nand_ctlr *nfc, unsigned 
long freq)
> > +{
> > +   int ret;
> > +
> > +   ret = clk_set_rate(nfc->send_clk, freq);
> > +   if (ret)
> > +      return ret;
> > +
> > +   ret = clk_set_rate(nfc->send_dly_clk, freq);
> > +   if (ret)
> > +      return ret;
> > +
> > +   /*
> > +    * A constant delay range from 0x0 ~ 0x1F for input delay,
> > +    * the unit is 78 ps, the max input delay is 2.418 ns.
> > +    */
> > +   mxic_nfc_set_input_delay(nfc, 0xf);
> 
> Just curious. Shouldn't we use that to support EDO modes? This being
> said, a delay of 2.5ns will not be enough for EDO...

This mxic_nfc_set_input_delay() thing is for Data IO pins and these delay
are for internal #RE path latch Data.

> 
> > +
> > +   /*
> > +    * Phase degree = 360 * freq * output-delay
> > +    * where output-delay is a constant value 1 ns in FPGA.
> > +    *
> > +    * Get Phase degree = 360 * freq * 1 ns
> > +    *                  = 360 * freq * 1 sec / 1000000000
> > +    *                  = 9 * freq / 25000000
> > +    */
> > +   ret = clk_set_phase(nfc->send_dly_clk, 9 * freq / 25000000);
> > +   if (ret)
> > +      return ret;
> > +
> > +   return 0;
> > +}
> > +
> > +static int mxic_nfc_set_freq(struct mxic_nand_ctlr *nfc, unsigned 
long freq)
> > +{
> > +   int ret;
> > +
> > +   if (freq > MXIC_NFC_MAX_CLK_HZ)
> > +      freq = MXIC_NFC_MAX_CLK_HZ;
> > +
> > +   mxic_nfc_clk_disable(nfc);
> > +   ret = mxic_nfc_clk_setup(nfc, freq);
> > +   if (ret)
> > +      return ret;
> > +
> > +   ret = mxic_nfc_clk_enable(nfc);
> > +   if (ret)
> > +      return ret;
> > +
> > +   return 0;
> > +}
> > +
> > +static void mxic_nfc_hw_init(struct mxic_nand_ctlr *nfc)
> > +{
> > +   writel(DATA_STROB_EDO_EN, nfc->regs + DATA_STROB);
> 
> Oh, no, here is the EDO flag. BTW, you should not have it set by
> default, it's something you configure in your ->setup_data_interface()
> implementation.

okay, got it and will fix it.

> 
> > +   writel(HC_CFG_NIO(8) | HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) |
> > +          HC_CFG_SLV_ACT(0) | HC_CFG_MAN_CS_EN |
> > +          HC_CFG_IDLE_SIO_LVL(1), nfc->regs + HC_CFG);
> > +   writel(INT_STS_ALL, nfc->regs + INT_STS_EN);
> > +   writel(0x0, nfc->regs + ONFI_DIN_CNT(0));
> > +   writel(0, nfc->regs + LRD_CFG);
> > +   writel(0, nfc->regs + LRD_CTRL);
> > +   writel(0x0, nfc->regs + HC_EN);
> > +
> > +   /* Default 10 MHz to setup tRC_min/tWC_min:100 ns */
> > +   mxic_nfc_set_freq(nfc, 10000000);
> 
> Again, not something you should configure here, but I guess having a
> default setting does not hurt.

okay, will fix it.

> 
> > +}
> > +
> > +static void mxic_nfc_cs_enable(struct mxic_nand_ctlr *nfc)
> > +{
> > +   writel(readl(nfc->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> > +          nfc->regs + HC_CFG);
> > +   writel(HC_CFG_MAN_CS_ASSERT | readl(nfc->regs + HC_CFG),
> > +          nfc->regs + HC_CFG);
> > +}
> > +
> > +static void mxic_nfc_cs_disable(struct mxic_nand_ctlr *nfc)
> > +{
> > +   writel(~HC_CFG_MAN_CS_ASSERT & readl(nfc->regs + HC_CFG),
> > +          nfc->regs + HC_CFG);
> > +}
> > +
> > +static int  mxic_nfc_wait_ready(struct nand_chip *chip)
> > +{
> > +   struct mxic_nand_ctlr *nfc = nand_get_controller_data(chip);
> > +   u32 sts;
> > +
> > +   return readl_poll_timeout(nfc->regs + INT_STS, sts,
> > +              sts & INT_RDY_PIN, 0, USEC_PER_SEC);
> 
> You're not using interrupts at all? For things like R/B wait it's
> usually a good thing to rely on interrupts instead of status-polling.

In our current FPGA bitstreams, only implement status-polling.
Interrupts will implement in ASIC.


> > +
> > +static int mxic_nfc_setup_data_interface(struct nand_chip *chip, int 
chipnr,
> > +                const struct nand_data_interface *conf)
> > +{
> > +   struct mxic_nand_ctlr *nfc = nand_get_controller_data(chip);
> > +   const struct nand_sdr_timings *sdr;
> > +   unsigned long freq;
> > +
> > +   sdr = nand_get_sdr_timings(conf);
> > +   if (IS_ERR(sdr))
> > +      return PTR_ERR(sdr);
> > +
> > +   if (chipnr < 0)
> 
> Please use the NAND_DATA_IFACE_CHECK_ONLY macro for this check:
> 
>    if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>       return 0;
> 

okay, will fix.

> > +      return 0;
> > +
> > +   if (sdr->tRC_min)
> > +      freq = 1000000000 / (sdr->tRC_min / 1000);
> 
> Please use NSEC_PER_SEC instead of 1000000000. And I think you can get
> rid of the check on sdr->tRC_min (it should never be 0).

got it, thanks.

> 
> > +
> > +   return mxic_nfc_set_freq(nfc, freq);
> 
> You should set the EDO when ->tRC_min < 30000 IIRC, clear it otherwise.
> 

okay, will fix,


> > +}
> > +
> > +static const struct nand_controller_ops mxic_nand_controller_ops = {
> > +   .exec_op = mxic_nfc_exec_op,
> > +   .setup_data_interface = mxic_nfc_setup_data_interface,
> > +};
> > +
> > +static int mxic_nfc_probe(struct platform_device *pdev)
> > +{
> > +   struct mtd_info *mtd;
> > +   struct mxic_nand_ctlr *nfc;
> > +   struct mxic_nand_chip *mxic_nand;
> > +   struct nand_chip *nand_chip;
> > +   struct resource *res;
> > +   int err;
> > +
> > +   nfc = devm_kzalloc(&pdev->dev, sizeof(struct mxic_nand_ctlr),
> > +            GFP_KERNEL);
> > +   if (!nfc)
> > +      return -ENOMEM;
> > +
> > +   mxic_nand = devm_kzalloc(&pdev->dev, sizeof(struct 
mxic_nand_chip),
> > +             GFP_KERNEL);
> > +   if (!mxic_nand)
> > +      return -ENOMEM;
> > +
> > +   nfc->ps_clk = devm_clk_get(&pdev->dev, "ps");
> > +   if (IS_ERR(nfc->ps_clk))
> > +      return PTR_ERR(nfc->ps_clk);
> > +
> > +   nfc->send_clk = devm_clk_get(&pdev->dev, "send");
> > +   if (IS_ERR(nfc->send_clk))
> > +      return PTR_ERR(nfc->send_clk);
> > +
> > +   nfc->send_dly_clk = devm_clk_get(&pdev->dev, "send_dly");
> > +   if (IS_ERR(nfc->send_dly_clk))
> > +      return PTR_ERR(nfc->send_dly_clk);
> > +
> > +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   nfc->regs = devm_ioremap_resource(&pdev->dev, res);
> > +   if (IS_ERR(nfc->regs))
> > +      return PTR_ERR(nfc->regs);
> > +
> > +   nand_chip = &mxic_nand->chip;
> > +   mtd = nand_to_mtd(nand_chip);
> > +   mtd->dev.parent = &pdev->dev;
> > +   nand_chip->ecc.priv = NULL;
> 
> No need to do this NULL assignment, the object is allocated with
> devm_kzalloc().

okay, got it.

> 
> > +   nand_set_flash_node(nand_chip, pdev->dev.of_node);
> 
> The flash node should be a child of pdev->dev.of_node,
> pdev->dev.of_node is representing your controller not the NAND chip.

I should also patch DTS to add a subnode which is connected to NAND
controller, as your comments on
[PATCH v6 2/2] dt-bindings: mtd: Document Macronix raw NAND controller 
bindings

right ?

> 
> > +   nand_chip->priv = nfc;
> > +   nfc->dev = &pdev->dev;
> > +   nfc->priv = nand_chip;
> > +
> > +   nfc->controller.ops = &mxic_nand_controller_ops;
> > +   nand_controller_init(&nfc->controller);
> > +   nand_chip->controller = &nfc->controller;
> > +
> > +   mxic_nfc_hw_init(nfc);
> > +
> > +   err = nand_scan(nand_chip, 1);
> > +   if (err)
> > +      goto fail;
> > +
> > +   err = mtd_device_register(mtd, NULL, 0);
> > +   if (err)
> > +      goto fail;
> > +
> > +   platform_set_drvdata(pdev, nfc);
> > +   return 0;
> > +
> > +fail:
> > +   mxic_nfc_clk_disable(nfc);
> 
> Looks like you never call mxic_nfc_clk_enable(), which means you'll end
> up with unbalanced prepare/enable counts. Also not sure how that can
> work unless the bootloader takes care of enabling the clks for you.

mxic_nfc_set_freq() will do that.


thanks for your time and review.

best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================

