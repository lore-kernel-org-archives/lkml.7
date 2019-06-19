Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01481C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52B621479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbfFSJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:31:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33181 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726826AbfFSJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:31:27 -0400
X-UUID: 541ef4796dac45c487a734321625e303-20190619
X-UUID: 541ef4796dac45c487a734321625e303-20190619
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2122254576; Wed, 19 Jun 2019 17:31:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Jun 2019 17:31:20 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Jun 2019 17:31:21 +0800
Message-ID: <1560936681.2158.16.camel@mtksdaap41>
Subject: Re: [PATCH v5 08/14] soc: mediatek: Refactor bus protection control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Rob Herring <robh@kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 19 Jun 2019 17:31:21 +0800
In-Reply-To: <CANMq1KDkzWk-CSib7NBtc-2zqmoW31vFrO5sOj1up-vFvnmhjQ@mail.gmail.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
         <20190319080140.24055-9-weiyi.lu@mediatek.com>
         <CANMq1KDkzWk-CSib7NBtc-2zqmoW31vFrO5sOj1up-vFvnmhjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 20:09 +0800, Nicolas Boichat wrote:
> On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Put bus protection enable and disable control in separate functions.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 48 ++++++++++++++++++++++---------
> >  1 file changed, 34 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 65b734b40098..6bf846cb1893 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -279,6 +279,34 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> >                         MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> >  }
> >
> > +static int scpsys_bus_protect_enable(struct scp_domain *scpd)
> > +{
> > +       struct scp *scp = scpd->scp;
> > +       int ret = 0;
> > +
> > +       if (scpd->data->bus_prot_mask) {
> > +               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > +                               scpd->data->bus_prot_mask,
> > +                               scp->bus_prot_reg_update);
> > +       }
> > +
> > +       return ret;
> 
> Maybe other people have different opinions, but I prefer:
> 
> if (!scpd->data->bus_prot_mask)
>     return 0;
> 
> return mtk_infracfg_set_bus_protection(...);
> 

ok, I'll update in next version.

> > +}
> > +
> > +static int scpsys_bus_protect_disable(struct scp_domain *scpd)
> > +{
> > +       struct scp *scp = scpd->scp;
> > +       int ret = 0;
> > +
> > +       if (scpd->data->bus_prot_mask) {
> > +               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > +                               scpd->data->bus_prot_mask,
> > +                               scp->bus_prot_reg_update);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  {
> >         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> > @@ -321,13 +349,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         if (ret < 0)
> >                 goto err_pwr_ack;
> >
> > -       if (scpd->data->bus_prot_mask) {
> > -               ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > -                               scpd->data->bus_prot_mask,
> > -                               scp->bus_prot_reg_update);
> > -               if (ret)
> > -                       goto err_pwr_ack;
> > -       }
> > +       ret = scpsys_bus_protect_disable(scpd);
> > +       if (ret < 0)
> > +               goto err_pwr_ack;
> >
> >         return 0;
> >
> > @@ -349,13 +373,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         u32 val;
> >         int ret, tmp;
> >
> > -       if (scpd->data->bus_prot_mask) {
> > -               ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> > -                               scpd->data->bus_prot_mask,
> > -                               scp->bus_prot_reg_update);
> > -               if (ret)
> > -                       goto out;
> > -       }
> > +       ret = scpsys_bus_protect_enable(scpd);
> > +       if (ret < 0)
> > +               goto out;
> >
> >         ret = scpsys_sram_disable(scpd, ctl_addr);
> >         if (ret < 0)
> > --
> > 2.18.0
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


