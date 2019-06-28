Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58432C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 07:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfF1HSv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:18:51 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:58625 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfF1HSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 03:18:51 -0400
X-Originating-IP: 86.250.200.211
Received: from xps13 (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C7C8D240007;
        Fri, 28 Jun 2019 07:18:38 +0000 (UTC)
Date:   Fri, 28 Jun 2019 09:18:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     anders.roxell@linaro.org, bbrezillon@kernel.org,
        broonie@kernel.org, christophe.kerello@st.com,
        computersforpeace@gmail.com, devicetree@vger.kernel.org,
        dwmw2@infradead.org, jianxin.pan@amlogic.com, juliensu@mxic.com.tw,
        lee.jones@linaro.org, liang.yang@amlogic.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, paul@crapouillou.net, paul.burton@mips.com,
        richard@nod.at, stefan@agner.ch, vigneshr@ti.com
Subject: Re: [PATCH v4 1/2] mtd: rawnand: Add Macronix Raw NAND controller
Message-ID: <20190628091836.3148d450@xps13>
In-Reply-To: <OFDDC43C05.7B4092B5-ON48258427.001EE57E-48258427.002122D1@mxic.com.tw>
References: <1561443056-13766-1-git-send-email-masonccyang@mxic.com.tw>
        <1561443056-13766-2-git-send-email-masonccyang@mxic.com.tw>
        <20190627193635.29abff43@xps13>
        <OFDDC43C05.7B4092B5-ON48258427.001EE57E-48258427.002122D1@mxic.com.tw>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi masonccyang@mxic.com.tw,

masonccyang@mxic.com.tw wrote on Fri, 28 Jun 2019 14:01:55 +0800:

> Hi Miquel,
> 
> 
> > > Add a driver for Macronix raw NAND controller.  
> > 
> > Could you pass userspace major MTD tests and can you attach/mount/edit
> > a UBI/UBIFS storage?  
> 
> mtd_debug passed and using dd utility to read and write 
> with md5sum checking passed.

Please don't use dd, use nanddump/nandwrite/flasherase/nandbiterrs and
run the other tests from the mtd-utils test suite (available in
Buildroot for instance).

> 
> UBI/UBIFS testing is not yet. will do it.
> 
> 
> > > +static int mxic_nfc_clk_enable(struct mxic_nand_ctlr *nfc)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret = clk_prepare_enable(nfc->send_clk);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   ret = clk_prepare_enable(nfc->send_dly_clk);
> > > +   if (ret)
> > > +      goto err_send_dly_clk;  
> > 
> > I'm not sure why you only enable 2 out of 3 clocks and also why ou
> > handle two of them here (which is great, I prefer having a separate
> > helper for that) and the other one elsewhere?
> >   
> 
> send_clk and send_dly_clk are device domain clocks.
> 
> send_clk is clock without phase delay to ps_clk, used for sending device
> signals except for SIO[7:0].
> send_dly_clk is clock with phase delay to ps_clk, used for sending 
> SIO[7:0]
> 
> ps_clk is system domain clock and it's a source clock of send_clk and 
> send_dly_clk.

And why is that explaining the fact that you configure them in
different places? You can explain this with a nice comment at the top
of the function, but I would rather prefer that you handle all three
clocks in one go if possible.

> 
> > > +
> > > +   return ret;
> > > +
> > > +err_send_dly_clk:
> > > +   clk_disable_unprepare(nfc->send_clk);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +static void mxic_nfc_clk_disable(struct mxic_nand_ctlr *nfc)
> > > +{
> > > +   clk_disable_unprepare(nfc->send_clk);
> > > +   clk_disable_unprepare(nfc->send_dly_clk);
> > > +}
> > > +
> > > +static void mxic_nfc_set_input_delay(struct mxic_nand_ctlr *nfc, u8   
> idly_code)
> > > +{
> > > +   writel(IDLY_CODE_VAL(0, idly_code) |
> > > +          IDLY_CODE_VAL(1, idly_code) |
> > > +          IDLY_CODE_VAL(2, idly_code) |
> > > +          IDLY_CODE_VAL(3, idly_code),
> > > +          nfc->regs + IDLY_CODE(0));
> > > +   writel(IDLY_CODE_VAL(4, idly_code) |
> > > +          IDLY_CODE_VAL(5, idly_code) |
> > > +          IDLY_CODE_VAL(6, idly_code) |
> > > +          IDLY_CODE_VAL(7, idly_code),
> > > +          nfc->regs + IDLY_CODE(1));
> > > +}
> > > +
> > > +static int mxic_nfc_clk_setup(struct mxic_nand_ctlr *nfc, unsigned   
> long freq)
> > > +{
> > > +   int ret;
> > > +
> > > +   ret = clk_set_rate(nfc->send_clk, freq);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   ret = clk_set_rate(nfc->send_dly_clk, freq);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   /*
> > > +    * A constant delay range from 0x0 ~ 0x1F for input delay,
> > > +    * the unit is 78 ps, the max input delay is 2.418 ns.
> > > +    */
> > > +   mxic_nfc_set_input_delay(nfc, 0xf);
> > > +
> > > +   /*
> > > +    * Phase degree = 360 * freq * output-delay
> > > +    * where output-delay is a constant value 1 ns in FPGA.  
> > 
> > Will it always be in FPGA?  
> 
> yes.
> 
> >   
> > > +    *
> > > +    * Get Phase degree = 360 * freq * 1 ns
> > > +    *                  = 360 * freq * 1 sec / 1000000000
> > > +    *                  = 9 * freq / 25000000
> > > +    */
> > > +   ret = clk_set_phase(nfc->send_dly_clk, 9 * freq / 25000000);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int mxic_nfc_set_freq(struct mxic_nand_ctlr *nfc, unsigned   
> long freq)
> > > +{
> > > +   int ret;
> > > +
> > > +   if (freq > MXIC_NFC_MAX_CLK_HZ)
> > > +      freq = MXIC_NFC_MAX_CLK_HZ;
> > > +
> > > +   mxic_nfc_clk_disable(nfc);
> > > +   ret = mxic_nfc_clk_setup(nfc, freq);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   ret = mxic_nfc_clk_enable(nfc);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static void mxic_nfc_hw_init(struct mxic_nand_ctlr *nfc)
> > > +{
> > > +   writel(DATA_STROB_EDO_EN, nfc->regs + DATA_STROB);
> > > +   writel(HC_CFG_NIO(8) | HC_CFG_TYPE(1, HC_CFG_TYPE_RAW_NAND) |
> > > +          HC_CFG_SLV_ACT(0) | HC_CFG_MAN_CS_EN |
> > > +          HC_CFG_IDLE_SIO_LVL(1), nfc->regs + HC_CFG);
> > > +   writel(INT_STS_ALL, nfc->regs + INT_STS_EN);
> > > +   writel(0x0, nfc->regs + ONFI_DIN_CNT(0));
> > > +   writel(0, nfc->regs + LRD_CFG);
> > > +   writel(0, nfc->regs + LRD_CTRL);
> > > +   writel(0x0, nfc->regs + HC_EN);
> > > +
> > > +   /* Default 10 MHz to setup tRC_min/tWC_min:100 ns */
> > > +   mxic_nfc_set_freq(nfc, 10000000);
> > > +}
> > > +
> > > +static void mxic_nfc_cs_enable(struct mxic_nand_ctlr *nfc)
> > > +{
> > > +   writel(readl(nfc->regs + HC_CFG) | HC_CFG_MAN_CS_EN,
> > > +          nfc->regs + HC_CFG);
> > > +   writel(HC_CFG_MAN_CS_ASSERT | readl(nfc->regs + HC_CFG),
> > > +          nfc->regs + HC_CFG);  
> > 
> > So you can drive only one CS with this controller?  
> 
> yes,
> 
> >   
> > > +}
> > > +
> > > +static void mxic_nfc_cs_disable(struct mxic_nand_ctlr *nfc)
> > > +{
> > > +   writel(~HC_CFG_MAN_CS_ASSERT & readl(nfc->regs + HC_CFG),
> > > +          nfc->regs + HC_CFG);
> > > +}
> > > +
> > > +static int  mxic_nfc_wait_ready(struct nand_chip *chip)
> > > +{
> > > +   struct mxic_nand_ctlr *nfc = nand_get_controller_data(chip);
> > > +   u32 sts;
> > > +
> > > +   return readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > +              sts & INT_RDY_PIN, 0, USEC_PER_SEC);
> > > +}
> > > +
> > > +static int mxic_nfc_data_xfer(struct mxic_nand_ctlr *nfc, const void   
> *txbuf,
> > > +               void *rxbuf, unsigned int len)
> > > +{
> > > +   unsigned int pos = 0;
> > > +
> > > +   while (pos < len) {
> > > +      unsigned int nbytes = len - pos;
> > > +      u32 data = 0xffffffff;
> > > +      u32 sts;
> > > +      int ret;
> > > +
> > > +      if (nbytes > 4)
> > > +         nbytes = 4;
> > > +
> > > +      if (txbuf)
> > > +         memcpy(&data, txbuf + pos, nbytes);
> > > +
> > > +      ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > +                sts & INT_TX_EMPTY, 0, USEC_PER_SEC);
> > > +      if (ret)
> > > +         return ret;
> > > +
> > > +      writel(data, nfc->regs + TXD(nbytes % 4));
> > > +
> > > +      if (rxbuf) {
> > > +         ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > +                   sts & INT_TX_EMPTY, 0,
> > > +                   USEC_PER_SEC);
> > > +         if (ret)
> > > +            return ret;
> > > +
> > > +         ret = readl_poll_timeout(nfc->regs + INT_STS, sts,
> > > +                   sts & INT_RX_NOT_EMPTY, 0,
> > > +                   USEC_PER_SEC);
> > > +         if (ret)
> > > +            return ret;
> > > +
> > > +         data = readl(nfc->regs + RXD);
> > > +         data >>= (8 * (4 - nbytes));
> > > +         memcpy(rxbuf + pos, &data, nbytes);
> > > +         WARN_ON(readl(nfc->regs + INT_STS) & INT_RX_NOT_EMPTY);
> > > +      } else {
> > > +         readl(nfc->regs + RXD);
> > > +      }
> > > +      WARN_ON(readl(nfc->regs + INT_STS) & INT_RX_NOT_EMPTY);  
> > 
> > WARN_ON() is maybe a bit overkill here?  
> 
> should I remove it ?

I would stick to regular dev_warn.


Thanks,
Miquèl
