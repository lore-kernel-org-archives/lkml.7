Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D567C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0926120679
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfH1Hr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:47:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41525 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbfH1Hrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:47:55 -0400
X-UUID: 4a791d614abe41039e1fcfcbac0eab9b-20190828
X-UUID: 4a791d614abe41039e1fcfcbac0eab9b-20190828
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1855172273; Wed, 28 Aug 2019 15:47:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs02n2.mediatek.inc
 (172.21.101.101) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 28 Aug
 2019 15:47:54 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 15:47:51 +0800
Message-ID: <1566978464.7317.19.camel@mhfsdcap03>
Subject: Re: [PATCH 2/2] clk: mediatek: add pericfg clocks for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Erin Lo" <erin.lo@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 28 Aug 2019 15:47:44 +0800
In-Reply-To: <1566975333.24969.2.camel@mtksdaap41>
References: <1566971755-21217-1-git-send-email-chunfeng.yun@mediatek.com>
         <1566971755-21217-2-git-send-email-chunfeng.yun@mediatek.com>
         <1566975333.24969.2.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 713EC96C0A4AABC7BF3F4C27B34FBB7BEDA8C68640AC4F87A0B57E3202F859B22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

On Wed, 2019-08-28 at 14:55 +0800, Weiyi Lu wrote:
> On Wed, 2019-08-28 at 13:55 +0800, Chunfeng Yun wrote:
> > Add pericfg clocks for MT8183, it's used when support USB
> > remote wakeup
> > 
> > Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/clk/mediatek/clk-mt8183.c      | 35 ++++++++++++++++++++++++++
> >  include/dt-bindings/clock/mt8183-clk.h |  4 +++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
> > index 1aa5f4059251..b19221bad0c9 100644
> > --- a/drivers/clk/mediatek/clk-mt8183.c
> > +++ b/drivers/clk/mediatek/clk-mt8183.c
> > @@ -999,6 +999,25 @@ static const struct mtk_gate infra_clks[] = {
> >  		"msdc50_0_sel", 24),
> >  };
> >  
> > +static const struct mtk_gate_regs peri_cg_regs = {
> > +	.set_ofs = 0x20c,
> > +	.clr_ofs = 0x20c,
> > +	.sta_ofs = 0x20c,
> > +};
> > +
> > +#define GATE_PERI(_id, _name, _parent, _shift) {	\
> > +	.id = _id,				\
> > +	.name = _name,				\
> > +	.parent_name = _parent,			\
> > +	.regs = &peri_cg_regs,			\
> > +	.shift = _shift,			\
> > +	.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
> > +}
> 
> Hi Chunfeng,
> 
> I suggest
> 
> #define GATE_PERI(_id, _name, _parent, _shift)		\
> 	GATE_MTK(_id, _name, _parent, &peri_cg_regs, _shift,	\
> 		&mtk_clk_gate_ops_no_setclr_inv)
> 
Good point, thanks

> > +
> > +static const struct mtk_gate peri_clks[] = {
> > +	GATE_PERI(CLK_PERI_AXI, "periaxi", "axi_sel", 31),
> > +};
> > +
> >  static const struct mtk_gate_regs apmixed_cg_regs = {
> >  	.set_ofs = 0x20,
> >  	.clr_ofs = 0x20,
> > @@ -1194,6 +1213,19 @@ static int clk_mt8183_infra_probe(struct platform_device *pdev)
> >  	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> >  }
> >  
> > +static int clk_mt8183_peri_probe(struct platform_device *pdev)
> > +{
> > +	struct clk_onecell_data *clk_data;
> > +	struct device_node *node = pdev->dev.of_node;
> > +
> > +	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
> > +
> > +	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
> > +			       clk_data);
> > +
> > +	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> > +}
> > +
> >  static int clk_mt8183_mcu_probe(struct platform_device *pdev)
> >  {
> >  	struct clk_onecell_data *clk_data;
> > @@ -1223,6 +1255,9 @@ static const struct of_device_id of_match_clk_mt8183[] = {
> >  	}, {
> >  		.compatible = "mediatek,mt8183-infracfg",
> >  		.data = clk_mt8183_infra_probe,
> > +	}, {
> > +		.compatible = "mediatek,mt8183-pericfg",
> > +		.data = clk_mt8183_peri_probe,
> >  	}, {
> >  		.compatible = "mediatek,mt8183-mcucfg",
> >  		.data = clk_mt8183_mcu_probe,
> > diff --git a/include/dt-bindings/clock/mt8183-clk.h b/include/dt-bindings/clock/mt8183-clk.h
> > index 0046506eb24c..a7b470b0ec8a 100644
> > --- a/include/dt-bindings/clock/mt8183-clk.h
> > +++ b/include/dt-bindings/clock/mt8183-clk.h
> > @@ -284,6 +284,10 @@
> >  #define CLK_INFRA_FBIST2FPC		100
> >  #define CLK_INFRA_NR_CLK		101
> >  
> > +/* PERICFG */
> > +#define CLK_PERI_AXI			0
> > +#define CLK_PERI_NR_CLK			1
> > +
> >  /* MFGCFG */
> >  #define CLK_MFG_BG3D			0
> >  #define CLK_MFG_NR_CLK			1
> 
> 


