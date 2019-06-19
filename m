Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B71C9C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890DA206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfFSJav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:30:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:15349 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726865AbfFSJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:30:50 -0400
X-UUID: d9d58902b1fd4112bba2f96e2c3e6567-20190619
X-UUID: d9d58902b1fd4112bba2f96e2c3e6567-20190619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2047790678; Wed, 19 Jun 2019 17:30:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Jun 2019 17:30:43 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Jun 2019 17:30:43 +0800
Message-ID: <1560936643.2158.15.camel@mtksdaap41>
Subject: Re: [PATCH v5 07/14] soc: mediatek: Refactor sram control
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Sean Wang <sean.wang@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 19 Jun 2019 17:30:43 +0800
In-Reply-To: <CANMq1KAYU8xVcdhYBDwy8Nh+=naH5bDYyJ2seZWHzvNHW=eDvw@mail.gmail.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
         <20190319080140.24055-8-weiyi.lu@mediatek.com>
         <CANMq1KAYU8xVcdhYBDwy8Nh+=naH5bDYyJ2seZWHzvNHW=eDvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 20:07 +0800, Nicolas Boichat wrote:
> On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Put sram enable and disable control in separate functions.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Refactoring looks ok, just a small comment.
> 
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
> 
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 79 ++++++++++++++++++++-----------
> >  1 file changed, 51 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 3e9be07a2627..65b734b40098 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -235,12 +235,55 @@ static void scpsys_clk_disable(struct clk *clk[], int max_num)
> >         }
> >  }
> >
> > +static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)
> > +{
> > +       u32 val;
> > +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> > +       int tmp;
> > +
> > +       val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
> > +       writel(val, ctl_addr);
> > +
> > +       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> > +       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> > +               /*
> > +                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> > +                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> > +                * is applied here.
> > +                */
> > +               usleep_range(12000, 12100);
> 
> Does the range really need to be so tight? Would 12000, 13000 also be ok?
> 

I think Sean could give you a more accurate answer.

Hi Sean, would you mind answering this question?

> > +       } else {
> > +               /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> > +               int ret = readl_poll_timeout(ctl_addr, tmp,
> > +                               (tmp & pdn_ack) == 0,
> > +                               MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> > +{
> > +       u32 val;
> > +       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> > +       int tmp;
> > +
> > +       val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
> > +       writel(val, ctl_addr);
> > +
> > +       /* Either wait until SRAM_PDN_ACK all 1 or 0 */
> > +       return readl_poll_timeout(ctl_addr, tmp,
> > +                       (tmp & pdn_ack) == pdn_ack,
> > +                       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +}
> > +
> >  static int scpsys_power_on(struct generic_pm_domain *genpd)
> >  {
> >         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> >         struct scp *scp = scpd->scp;
> >         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> > -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> >         u32 val;
> >         int ret, tmp;
> >
> > @@ -252,6 +295,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         if (ret)
> >                 goto err_clk;
> >
> > +       /* subsys power on */
> >         val = readl(ctl_addr);
> >         val |= PWR_ON_BIT;
> >         writel(val, ctl_addr);
> > @@ -273,24 +317,9 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
> >         val |= PWR_RST_B_BIT;
> >         writel(val, ctl_addr);
> >
> > -       val &= ~scpd->data->sram_pdn_bits;
> > -       writel(val, ctl_addr);
> > -
> > -       /* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> > -       if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> > -               /*
> > -                * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> > -                * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> > -                * applied here.
> > -                */
> > -               usleep_range(12000, 12100);
> > -
> > -       } else {
> > -               ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> > -                                        MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > -               if (ret < 0)
> > -                       goto err_pwr_ack;
> > -       }
> > +       ret = scpsys_sram_enable(scpd, ctl_addr);
> > +       if (ret < 0)
> > +               goto err_pwr_ack;
> >
> >         if (scpd->data->bus_prot_mask) {
> >                 ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> > @@ -317,7 +346,6 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >         struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
> >         struct scp *scp = scpd->scp;
> >         void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> > -       u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> >         u32 val;
> >         int ret, tmp;
> >
> > @@ -329,17 +357,12 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
> >                         goto out;
> >         }
> >
> > -       val = readl(ctl_addr);
> > -       val |= scpd->data->sram_pdn_bits;
> > -       writel(val, ctl_addr);
> > -
> > -       /* wait until SRAM_PDN_ACK all 1 */
> > -       ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> > -                                MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> > +       ret = scpsys_sram_disable(scpd, ctl_addr);
> >         if (ret < 0)
> >                 goto out;
> >
> > -       val |= PWR_ISO_BIT;
> > +       /* subsys power off */
> > +       val = readl(ctl_addr) | PWR_ISO_BIT;
> >         writel(val, ctl_addr);
> >
> >         val &= ~PWR_RST_B_BIT;
> > --
> > 2.18.0
> >


