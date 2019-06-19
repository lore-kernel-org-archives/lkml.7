Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B226DC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95927208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfFSJMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:12:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:65249 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730996AbfFSJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:12:21 -0400
X-UUID: 583cab0048a7483293dd615e26509cae-20190619
X-UUID: 583cab0048a7483293dd615e26509cae-20190619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2102173806; Wed, 19 Jun 2019 17:11:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 19 Jun 2019 17:11:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Jun 2019 17:11:55 +0800
Message-ID: <1560935516.2158.2.camel@mtksdaap41>
Subject: Re: [PATCH v5 04/14] soc: mediatek: Refactor polling timeout and
 documentation
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
Date:   Wed, 19 Jun 2019 17:11:56 +0800
In-Reply-To: <CANMq1KCLQaFg3bOrHnXzbjU9KM5Ny2rRX9bP4xg17jOYirxxig@mail.gmail.com>
References: <20190319080140.24055-1-weiyi.lu@mediatek.com>
         <20190319080140.24055-5-weiyi.lu@mediatek.com>
         <CANMq1KCLQaFg3bOrHnXzbjU9KM5Ny2rRX9bP4xg17jOYirxxig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: FEF713524511270A67FE0C1B2152E937E6EDF13A65FACB2F23DD324F98A8FFCE2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-03-19 at 19:45 +0800, Nicolas Boichat wrote:
> On Tue, Mar 19, 2019 at 4:02 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
> >
> > Use USEC_PER_SEC to indicate the polling timeout directly.
> > And add documentation of scp_domain_data.
> >
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 9f52f501178b..2855111b221a 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -21,7 +21,7 @@
> >  #include <dt-bindings/power/mt8173-power.h>
> >
> >  #define MTK_POLL_DELAY_US   10
> > -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> > +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
> >
> >  #define MTK_SCPD_ACTIVE_WAKEUP         BIT(0)
> >  #define MTK_SCPD_FWAIT_SRAM            BIT(1)
> > @@ -108,6 +108,18 @@ static const char * const clk_names[] = {
> >
> >  #define MAX_CLKS       3
> >
> > +/**
> > + * struct scp_domain_data - scp domain data for power on/off flow
> > + * @name: The domain name.
> > + * @sta_mask: The mask for power on/off status bit.
> > + * @ctl_offs: The offset for main power control register.
> > + * @sram_pdn_bits: The mask for sram power control bits.
> > + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> > + * @bus_prot_mask: The mask for single step bus protection.
> > + * @clk_id: The basic clock needs to be enabled before enabling certain
> > + *          power domains.
> 
> I assume these are the clock*s* that *this* scp_domain requires?
> 
> So maybe just: "The basic clocks required by this power domain." ?
> 
Thanks for revision. I'll update in next version.
> > + * @caps: The flag for active wake-up action.
> > + */
> >  struct scp_domain_data {
> >         const char *name;
> >         u32 sta_mask;
> > --
> > 2.18.0
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


