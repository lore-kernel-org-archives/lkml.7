Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F46C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 244A02168B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 05:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfJNFRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 01:17:53 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22805 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725869AbfJNFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 01:17:53 -0400
X-UUID: 7893d6ec1068416a81ca68070f178180-20191014
X-UUID: 7893d6ec1068416a81ca68070f178180-20191014
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <argus.lin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2028234777; Mon, 14 Oct 2019 13:17:45 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 14 Oct 2019 13:17:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 14 Oct 2019 13:17:42 +0800
Message-ID: <1571030264.19600.2.camel@mtkswgap22>
Subject: Re: [PATCH 3/3] soc: mediatek: pwrap: add support for MT6359 PMIC
From:   Argus Lin <argus.lin@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Chenglin Xu <chenglin.xu@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <wsd_upstream@mediatek.com>, <henryc.chen@mediatek.com>,
        <flora.fu@mediatek.com>, Chen Zhong <chen.zhong@mediatek.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 14 Oct 2019 13:17:44 +0800
In-Reply-To: <5ec86287-2a90-ca07-c9a6-262420a68fd3@gmail.com>
References: <1570088901-23211-1-git-send-email-argus.lin@mediatek.com>
         <1570088901-23211-4-git-send-email-argus.lin@mediatek.com>
         <5ec86287-2a90-ca07-c9a6-262420a68fd3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-04 at 01:27 +0200, Matthias Brugger wrote:
> 
> On 03/10/2019 09:48, Argus Lin wrote:
> > MT6359 is a new power management IC and it is used for
> > MT6779 SoCs. To define mt6359_regs for pmic register mapping
> > and pmic_mt6359 for accessing register.
> > 
> > Signed-off-by: Argus Lin <argus.lin@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-pmic-wrap.c | 72 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > index fa8daf2..dd04318 100644
> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > @@ -111,6 +111,29 @@ enum dew_regs {
> >  	PWRAP_RG_SPI_CON13,
> >  	PWRAP_SPISLV_KEY,
> > 
> > +	/* MT6359 only regs */
> > +	PWRAP_DEW_CRC_SWRST,
> > +	PWRAP_DEW_RG_EN_RECORD,
> > +	PWRAP_DEW_RECORD_CMD0,
> > +	PWRAP_DEW_RECORD_CMD1,
> > +	PWRAP_DEW_RECORD_CMD2,
> > +	PWRAP_DEW_RECORD_CMD3,
> > +	PWRAP_DEW_RECORD_CMD4,
> > +	PWRAP_DEW_RECORD_CMD5,
> > +	PWRAP_DEW_RECORD_WDATA0,
> > +	PWRAP_DEW_RECORD_WDATA1,
> > +	PWRAP_DEW_RECORD_WDATA2,
> > +	PWRAP_DEW_RECORD_WDATA3,
> > +	PWRAP_DEW_RECORD_WDATA4,
> > +	PWRAP_DEW_RECORD_WDATA5,
> > +	PWRAP_DEW_RG_ADDR_TARGET,
> > +	PWRAP_DEW_RG_ADDR_MASK,
> > +	PWRAP_DEW_RG_WDATA_TARGET,
> > +	PWRAP_DEW_RG_WDATA_MASK,
> > +	PWRAP_DEW_RG_SPI_RECORD_CLR,
> > +	PWRAP_DEW_RG_CMD_ALERT_CLR,
> > +	PWRAP_DEW_SPISLV_KEY,
> 
> That looks like PWRAP_SPISLV_KEY from MT6358.
> 
> Regards,
> Matthias
> 
Yes, I think I can reuse the PWRAP_SPISLV_KEY of MT6358.

B.R.
Argus
> > +
> >  	/* MT6397 only regs */
> >  	PWRAP_DEW_EVENT_OUT_EN,
> >  	PWRAP_DEW_EVENT_SRC_EN,
> > @@ -197,6 +220,42 @@ enum dew_regs {
> >  	[PWRAP_SPISLV_KEY] =		0x044a,
> >  };
> > 
> > +static const u32 mt6359_regs[] = {
> > +	[PWRAP_DEW_RG_EN_RECORD] =	0x040a,
> > +	[PWRAP_DEW_DIO_EN] =		0x040c,
> > +	[PWRAP_DEW_READ_TEST] =		0x040e,
> > +	[PWRAP_DEW_WRITE_TEST] =	0x0410,
> > +	[PWRAP_DEW_CRC_SWRST] =		0x0412,
> > +	[PWRAP_DEW_CRC_EN] =		0x0414,
> > +	[PWRAP_DEW_CRC_VAL] =		0x0416,
> > +	[PWRAP_DEW_CIPHER_KEY_SEL] =	0x0418,
> > +	[PWRAP_DEW_CIPHER_IV_SEL] =	0x041a,
> > +	[PWRAP_DEW_CIPHER_EN] =		0x041c,
> > +	[PWRAP_DEW_CIPHER_RDY] =	0x041e,
> > +	[PWRAP_DEW_CIPHER_MODE] =	0x0420,
> > +	[PWRAP_DEW_CIPHER_SWRST] =	0x0422,
> > +	[PWRAP_DEW_RDDMY_NO] =		0x0424,
> > +	[PWRAP_DEW_RECORD_CMD0] =	0x0428,
> > +	[PWRAP_DEW_RECORD_CMD1] =	0x042a,
> > +	[PWRAP_DEW_RECORD_CMD2] =	0x042c,
> > +	[PWRAP_DEW_RECORD_CMD3] =	0x042e,
> > +	[PWRAP_DEW_RECORD_CMD4] =	0x0430,
> > +	[PWRAP_DEW_RECORD_CMD5] =	0x0432,
> > +	[PWRAP_DEW_RECORD_WDATA0] =	0x0434,
> > +	[PWRAP_DEW_RECORD_WDATA1] =	0x0436,
> > +	[PWRAP_DEW_RECORD_WDATA2] =	0x0438,
> > +	[PWRAP_DEW_RECORD_WDATA3] =	0x043a,
> > +	[PWRAP_DEW_RECORD_WDATA4] =	0x043c,
> > +	[PWRAP_DEW_RECORD_WDATA5] =	0x043e,
> > +	[PWRAP_DEW_RG_ADDR_TARGET] =	0x0440,
> > +	[PWRAP_DEW_RG_ADDR_MASK] =	0x0442,
> > +	[PWRAP_DEW_RG_WDATA_TARGET] =	0x0444,
> > +	[PWRAP_DEW_RG_WDATA_MASK] =	0x0446,
> > +	[PWRAP_DEW_RG_SPI_RECORD_CLR] =	0x0448,
> > +	[PWRAP_DEW_RG_CMD_ALERT_CLR] =	0x0448,
> > +	[PWRAP_DEW_SPISLV_KEY] =	0x044a,
> > +};
> > +
> >  static const u32 mt6397_regs[] = {
> >  	[PWRAP_DEW_BASE] =		0xbc00,
> >  	[PWRAP_DEW_EVENT_OUT_EN] =	0xbc00,
> > @@ -977,6 +1036,7 @@ enum pmic_type {
> >  	PMIC_MT6351,
> >  	PMIC_MT6357,
> >  	PMIC_MT6358,
> > +	PMIC_MT6359,
> >  	PMIC_MT6380,
> >  	PMIC_MT6397,
> >  };
> > @@ -1757,6 +1817,15 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
> >  	.pwrap_write = pwrap_write16,
> >  };
> > 
> > +static const struct pwrap_slv_type pmic_mt6359 = {
> > +	.dew_regs = mt6359_regs,
> > +	.type = PMIC_MT6359,
> > +	.regmap = &pwrap_regmap_config16,
> > +	.caps = PWRAP_SLV_CAP_DUALIO,
> > +	.pwrap_read = pwrap_read16,
> > +	.pwrap_write = pwrap_write16,
> > +};
> > +
> >  static const struct pwrap_slv_type pmic_mt6380 = {
> >  	.dew_regs = NULL,
> >  	.type = PMIC_MT6380,
> > @@ -1790,6 +1859,9 @@ static irqreturn_t pwrap_interrupt(int irqno, void *dev_id)
> >  		.compatible = "mediatek,mt6358",
> >  		.data = &pmic_mt6358,
> >  	}, {
> > +		.compatible = "mediatek,mt6359",
> > +		.data = &pmic_mt6359,
> > +	}, {
> >  		/* The MT6380 PMIC only implements a regulator, so we bind it
> >  		 * directly instead of using a MFD.
> >  		 */
> > --
> > 1.8.1.1.dirty
> > 


