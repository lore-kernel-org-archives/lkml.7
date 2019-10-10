Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96140C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1708208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 10:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="lrZnZWs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfJJKPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 06:15:21 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:9438 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfJJKPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 06:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1570702519;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=9OBtSARrynOincT+6Aqsk3Vnc/FgMoCKd+vrgqEcf4o=;
        b=lrZnZWs6net8LIdiNTcN22k/6GP++DHj8RKTvhIj7Zk9gvKtElZs35f+/t3zBxV/Wi
        zjxSdDaO+9caAjkWfQZI1Uo6X1RIzcqZHIVoZ18FUpsT4QCvlih3NOMMZCd/LUceH7HA
        fXmaj+JjwTmgJzyrHgy7nfgj6JmKbTST7b6YGanwrX5r8zMg3/N1OMA98JaLymFNIh2A
        uAaElVXVmVKyMc0q6GaoVZAVegpLcw7+YV4BF+ylDBLsBzdZF/1nIk50SKnPzntRcLPy
        S43ImqRi7cdoQqAB3AOqSzpbpzKXRJnaye54e49G3ChOwhUGF0xZOKKNjMpD8KpFLPgO
        zNPQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u266EZF6ORJBG388B1M="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 44.28.0 AUTH)
        with ESMTPSA id L0811cv9AAFJKCO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 10 Oct 2019 12:15:19 +0200 (CEST)
Date:   Thu, 10 Oct 2019 12:15:09 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: sm5502: Clear pending interrupts during
 initialization
Message-ID: <20191010101509.GA122066@gerhold.net>
References: <CGME20191008105726epcas3p178e8421ce5062b6955475199efa130e1@epcas3p1.samsung.com>
 <20191008105434.119346-1-stephan@gerhold.net>
 <328ccd73-2ceb-2e3f-524c-3fd950ccbf09@samsung.com>
 <a4e6c33d-b715-34af-67c7-f9a3afc21e05@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4e6c33d-b715-34af-67c7-f9a3afc21e05@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chanwoo,

thank you for your suggestions!

On Thu, Oct 10, 2019 at 04:46:56PM +0900, Chanwoo Choi wrote:
> On 19. 10. 10. 오후 4:33, Chanwoo Choi wrote:
> > It is not proper. Instead, initialize the SM5502_RET_INT1/2 with zero.

Sorry about that. I don't have a datasheet, so I wasn't sure what's the
best way to fix the problem.

> > 
> > The reset value of SM5502_RET_INT1/2 are zero (0x00) as following:
> > If you can test it with h/w, please try to test it and then
> > send the modified patch. 
> > 
> > diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
> > index c897f1aa4bf5..e168f77a18ba 100644
> > --- a/drivers/extcon/extcon-sm5502.c
> > +++ b/drivers/extcon/extcon-sm5502.c
> > @@ -68,6 +68,14 @@ static struct reg_data sm5502_reg_data[] = {
> >                 .reg = SM5502_REG_CONTROL,
> >                 .val = SM5502_REG_CONTROL_MASK_INT_MASK,
> >                 .invert = false,
> > +       }, {
> > +               .reg = SM5502_REG_INT1,
> > +               .val = SM5502_RET_INT1_MASK,
> > +               .invert = true,
> > +       }, {
> > +               .reg = SM5502_REG_INT2,
> > +               .val = SM5502_RET_INT1_MASK,
> > +               .invert = true,
> >         }, {
> >                 .reg = SM5502_REG_INTMASK1,
> >                 .val = SM5502_REG_INTM1_KP_MASK
> > diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
> > index 9dbb634d213b..5c4edb3e7fce 100644
> > --- a/drivers/extcon/extcon-sm5502.h
> > +++ b/drivers/extcon/extcon-sm5502.h
> > @@ -93,6 +93,8 @@ enum sm5502_reg {
> >  #define SM5502_REG_CONTROL_RAW_DATA_MASK       (0x1 << SM5502_REG_CONTROL_RAW_DATA_SHIFT)
> >  #define SM5502_REG_CONTROL_SW_OPEN_MASK                (0x1 << SM5502_REG_CONTROL_SW_OPEN_SHIFT)
> >  
> > +#define SM5502_RET_INT1_MASK                   (0xff)
> > +
> >  #define SM5502_REG_INTM1_ATTACH_SHIFT          0
> >  #define SM5502_REG_INTM1_DETACH_SHIFT          1
> >  #define SM5502_REG_INTM1_KP_SHIFT              2
> > 
> >>  }
> >>  
> >>  static int sm5022_muic_i2c_probe(struct i2c_client *i2c,
> >>
> > 
> > 

This patch (i.e. writing to SM5502_REG_INT1 and SM5502_REG_INT2)
does not result in any difference.
There are still no interrupts being sent.

On the other hand, your other suggestion fixes the problem:

> 
> When write 0x1 to SM5502_REG_RESET, reset the device.
> So, you can reset the all registers by writing 1 to SM5502_REG_RESET as following:
> 

Writing 0x1 to SM5502_REG_RESET seems to make interrupts work, so writing
to SM5502_REG_INT1 and SM5502_REG_INT2 is not even necessary in this case.

Would you still prefer initializing SM5502_REG_INT1/2 or is the patch
below enough?

diff --git a/drivers/extcon/extcon-sm5502.c b/drivers/extcon/extcon-sm5502.c
index dc43847ad2b0..b3d93baf4fc5 100644
--- a/drivers/extcon/extcon-sm5502.c
+++ b/drivers/extcon/extcon-sm5502.c
@@ -65,6 +65,10 @@ struct sm5502_muic_info {
 /* Default value of SM5502 register to bring up MUIC device. */
 static struct reg_data sm5502_reg_data[] = {
 	{
+		.reg = SM5502_REG_RESET,
+		.val = SM5502_REG_RESET_MASK,
+		.invert = true,
+	}, {
 		.reg = SM5502_REG_CONTROL,
 		.val = SM5502_REG_CONTROL_MASK_INT_MASK,
 		.invert = false,
diff --git a/drivers/extcon/extcon-sm5502.h b/drivers/extcon/extcon-sm5502.h
index 9dbb634d213b..2ea1bc01be0a 100644
--- a/drivers/extcon/extcon-sm5502.h
+++ b/drivers/extcon/extcon-sm5502.h
@@ -237,6 +237,8 @@ enum sm5502_reg {
 #define DM_DP_SWITCH_UART			((DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DP_SHIFT) \
 						| (DM_DP_CON_SWITCH_UART <<SM5502_REG_MANUAL_SW1_DM_SHIFT))
 
+#define SM5502_REG_RESET_MASK		    (0x1)
+
 /* SM5502 Interrupts */
 enum sm5502_irq {
 	/* INT1 */
