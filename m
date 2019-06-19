Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932F3C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641ED20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731478AbfFSJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:19:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34647 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726971AbfFSJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:19:57 -0400
X-UUID: f3fb713c525e4f24a8b3c1773af5cc52-20190619
X-UUID: f3fb713c525e4f24a8b3c1773af5cc52-20190619
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 12975164; Wed, 19 Jun 2019 17:19:48 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Jun 2019 17:19:47 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Jun 2019 17:19:47 +0800
Message-ID: <1560935987.2158.8.camel@mtksdaap41>
Subject: Re: [PATCH v5 06/14] soc: mediatek: Refactor clock control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 19 Jun 2019 17:19:47 +0800
In-Reply-To: <CANMq1KCxhnn+fKaxS1RbpYYJ7pcXzD8XkqTBJHiauHbfrYVTGA@mail.gmail.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
         <20190319080140.24055-7-weiyi.lu@mediatek.com>
         <CANMq1KCxhnn+fKaxS1RbpYYJ7pcXzD8XkqTBJHiauHbfrYVTGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 20:02 +0800, Nicolas Boichat wrote:
> On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Put clock enable and disable control in separate function.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 49 ++++++++++++++++++++-----------
> >  1 file changed, 32 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 765ad4a5e5df..3e9be07a2627 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -208,6 +208,33 @@ static int scpsys_regulator_disable(struct scp_domain *scpd)
> >         return regulator_disable(scpd->supply);
> >  }
> >
> > +static int scpsys_clk_enable(struct clk *clk[], int max_num)
> > +{
> > +       int i, ret = 0;
> > +
> > +       for (i = 0; i < max_num && clk[i]; i++) {
> > +               ret = clk_prepare_enable(clk[i]);
> > +               if (ret) {
> > +                       for (--i; i >= 0; i--)
> > +                               clk_disable_unprepare(clk[i]);
> 
> Would it be simpler to just call scpsys_clk_disable(clk, i) ?
> 

OK, I'll try.

> > +
> > +                       break;
> > +               }
> > +       }
> > +
> > +       return ret;
> > +}
> 
> Maybe not for this series, but could you use clk_bulk_prepare_enable
> instead? The only issue is that it'd still call clk_prepare_enable on
> NULL clocks, but that does nothing, so it's just a little less
> efficient...
> 

OK, I'll try after this series.

> > +
> > +static void scpsys_clk_disable(struct clk *clk[], int max_num)
> > +{
> > +       int i;
> > +
> > +       for (i = max_num - 1; i >= 0; i--) {
> > +               if (clk[i])
> 
> if test not needed, clk_disable_unprepare ignores NULL parameters.
> 

You're right. Supposed it's not needed, I'll test.

> > +                       clk_disable_unprepare(clk[i]);
> > +       }
> > +}
> 
> ditto: clk_bulk_disable_unprepare
> 
> > +
> >  static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  {
> >         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> > @@ -216,21 +243,14 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> >         u32 val;
> >         int ret, tmp;
> > -       int i;
> >
> >         ret = scpsys_regulator_enable(scpd);
> >         if (ret < 0)
> >                 return ret;
> >
> > -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
> > -               ret = clk_prepare_enable(scpd->clk[i]);
> > -               if (ret) {
> > -                       for (--i; i >= 0; i--)
> > -                               clk_disable_unprepare(scpd->clk[i]);
> > -
> > -                       goto err_clk;
> > -               }
> > -       }
> > +       ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
> > +       if (ret)
> > +               goto err_clk;
> >
> >         val = readl(ctl_addr);
> >         val |= PWR_ON_BIT;
> > @@ -283,10 +303,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         return 0;
> >
> >  err_pwr_ack:
> > -       for (i = MAX_CLKS - 1; i >= 0; i--) {
> > -               if (scpd->clk[i])
> > -                       clk_disable_unprepare(scpd->clk[i]);
> > -       }
> > +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
> >  err_clk:
> >         scpsys_regulator_disable(scpd);
> >
> > @@ -303,7 +320,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> >         u32 val;
> >         int ret, tmp;
> > -       int i;
> >
> >         if (scpd->data->bus_prot_mask) {
> >                 ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > @@ -344,8 +360,7 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         if (ret < 0)
> >                 goto out;
> >
> > -       for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> > -               clk_disable_unprepare(scpd->clk[i]);
> > +       scpsys_clk_disable(scpd->clk, MAX_CLKS);
> >
> >         ret = scpsys_regulator_disable(scpd);
> >         if (ret < 0)
> > --
> > 2.18.0
> >


