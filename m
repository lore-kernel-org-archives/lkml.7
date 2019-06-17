Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A159C31E53
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4D2218BA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfFQF5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 01:57:13 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41166 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbfFQF5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 01:57:12 -0400
X-UUID: c5763d6611ef4ddeb505b357bc61c525-20190617
X-UUID: c5763d6611ef4ddeb505b357bc61c525-20190617
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jjian.zhou@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1289336308; Mon, 17 Jun 2019 13:57:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 17 Jun
 2019 13:57:03 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Jun 2019 13:57:01 +0800
Message-ID: <1560751020.3103.25.camel@mhfsdcap03>
Subject: Re: [PATCH 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
From:   jjian zhou <jjian.zhou@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= 
        <Chaotian.Jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yong Mao =?UTF-8?Q?=28=E6=AF=9B=E5=8B=87=29?= 
        <yong.mao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Mon, 17 Jun 2019 13:57:00 +0800
In-Reply-To: <CAPDyKFrXU4bpKeB7Aa15j2nHqUCn-bk+YKn9_vkznmi+PS8H7A@mail.gmail.com>
References: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
         <CAPDyKFrXU4bpKeB7Aa15j2nHqUCn-bk+YKn9_vkznmi+PS8H7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 17:46 +0800, Ulf Hansson wrote:
> On Fri, 14 Jun 2019 at 07:26, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> >
> > From: jjian zhou <jjian.zhou@mediatek.com>
> >
> > SDIO IRQ is triggered by low level. It need disable SDIO IRQ
> > detected function. Otherwise the interrupt register can't be cleared.
> > It will process the interrupt more.
> >
> > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index c518cc2..29992ae 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1389,10 +1389,12 @@ static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> >         struct msdc_host *host = mmc_priv(mmc);
> >
> >         spin_lock_irqsave(&host->lock, flags);
> > -       if (enb)
> > +       if (enb) {
> >                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > -       else
> > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       } else {
> >                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> 
> Rather than clearing SDC_CFG_SDIOIDE in the irq handler, you need to
> do it here. As otherwise when the mmc core calls
> host->ops->enable_sdio_irq() to disable the SDIO IRQ, it may stay
> enabled.
> 

Thank you for your review.

I remove the spin lock in "__msdc_enable_sdio_irq" and add 
spin lock in "msdc_enable_sdio_irq". The modification of
"__msdc_enable_sdio_irq" and "msdc_enable_sdio_irq" is as following.

static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
{
	if (enb) {
		sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
		sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
	} else {
		sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
		sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
	}
}

static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
{
	unsigned long flags;
	struct msdc_host *host = mmc_priv(mmc);
	spin_lock_irqsave(&host->lock, flags);;
	__msdc_enable_sdio_irq(host, enb);
	spin_unlock_irqrestore(&host->lock, flags);

	if (enb)
		pm_runtime_get_noresume(host->dev);
	else
		pm_runtime_get_noidle(host->dev);
}

> > +       }
> >         spin_unlock_irqrestore(&host->lock, flags);
> >  }
> >
> > @@ -1422,6 +1424,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >                 spin_lock_irqsave(&host->lock, flags);
> >                 events = readl(host->base + MSDC_INT);
> >                 event_mask = readl(host->base + MSDC_INTEN);
> > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> > +                       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> 
> As stated above, I suggest you move this into __msdc_enable_sdio_irq()
> and thus call that function from here instead. Well, that doesn't work
> as is, because of the spin lock, so you rather need to make a
> sub-function of __msdc_enable_sdio_irq, that don't take/releases the
> lock.
> 
> I hope that was clear. If not, I can post a patch to show you what I mean.
> 

I also modify this part handler in msdc_irq.

	spin_lock_irqsave(&host->lock, flags);
	events = readl(host->base + MSDC_INT);
	event_mask = readl(host->base + MSDC_INTEN);
	if ((events & event_mask) & MSDC_INT_SDIOIRQ)
		__msdc_enable_sdio_irq(host, 0);
	/* clear interrupts */
	writel(events & event_mask, host->base + MSDC_INT);

	mrq = host->mrq;
	cmd = host->cmd;
	data = host->data;
	spin_unlock_irqrestore(&host->lock, flags);

	if ((events & event_mask) & MSDC_INT_SDIOIRQ)
		sdio_signal_irq(host->mmc);

I also will add spin lock in the "msdc_ack_sdio_irq".

Looking forward to your suggestions.
> 
> >                 /* clear interrupts */
> >                 writel(events & event_mask, host->base + MSDC_INT);
> >
> > @@ -1572,10 +1576,7 @@ static void msdc_init_hw(struct msdc_host *host)
> >         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> >
> >         /* Config SDIO device detect interrupt function */
> > -       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > -               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > -       else
> > -               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> >         /* Configure to default data timeout */
> >         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > --
> > 1.9.1
> >
> 
> Kind regards
> Uffe


