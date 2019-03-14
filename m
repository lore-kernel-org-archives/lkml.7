Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B19C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7AA213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 02:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCNCqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 22:46:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:4787 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726629AbfCNCqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 22:46:34 -0400
X-UUID: 7ea9410bb8704279b19a12cda38dce51-20190314
X-UUID: 7ea9410bb8704279b19a12cda38dce51-20190314
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ran.bi@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1858234063; Thu, 14 Mar 2019 10:46:24 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n2.mediatek.inc
 (172.21.101.79) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 14 Mar
 2019 10:46:22 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 10:46:21 +0800
Message-ID: <1552531581.18390.8.camel@mhfsdcap03>
Subject: Re: [PATCH v2 8/9] rtc: mt6397: fix alarm register overwrite
From:   mtk14576 <ran.bi@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <stable@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 14 Mar 2019 10:46:21 +0800
In-Reply-To: <CAGp9Lzq4D56PbivbHkQd41-TCoGACTiBqLz+Jyiqiog=YMvEbQ@mail.gmail.com>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1552275991-34648-9-git-send-email-hsin-hsiung.wang@mediatek.com>
         <CAGp9Lzq4D56PbivbHkQd41-TCoGACTiBqLz+Jyiqiog=YMvEbQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: BE8084FD0CFCDD336590D1C479EFF7B2D37843178BD9FCE3A754782EC6B2B1672000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2019-03-11 at 13:50 -0700, Sean Wang wrote:
> Hi,
> 
> On Sun, Mar 10, 2019 at 8:49 PM Hsin-Hsiung Wang
> <hsin-hsiung.wang@mediatek.com> wrote:
> >
> > From: Ran Bi <ran.bi@mediatek.com>
> >
> > Alarm registers high byte was reserved for other functions.
> > This add mask in alarm registers operation functions.
> > This also fix error condition in interrupt handler.
> >
> > Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
> >
> 
> add a  Cc: stable@vger.kernel.org  here to apply to all stable kernels
> for the critical fixup patch.
> 
> > Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 47 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 33 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index e9a25ec..f85f1fc 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -55,6 +55,14 @@
> >
> >  #define RTC_AL_SEC             0x0018
> >
> > +#define RTC_AL_SEC_MASK                0x003f
> > +#define RTC_AL_MIN_MASK                0x003f
> > +#define RTC_AL_HOU_MASK                0x001f
> > +#define RTC_AL_DOM_MASK                0x001f
> > +#define RTC_AL_DOW_MASK                0x0007
> > +#define RTC_AL_MTH_MASK                0x000f
> > +#define RTC_AL_YEA_MASK                0x007f
> > +
> >  #define RTC_PDN2               0x002e
> >  #define RTC_PDN2_PWRON_ALARM   BIT(4)
> >
> > @@ -111,7 +119,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
> >                 irqen = irqsta & ~RTC_IRQ_EN_AL;
> >                 mutex_lock(&rtc->lock);
> >                 if (regmap_write(rtc->regmap, rtc->addr_base + RTC_IRQ_EN,
> > -                                irqen) < 0)
> > +                                irqen) == 0)
> >                         mtk_rtc_write_trigger(rtc);
> >                 mutex_unlock(&rtc->lock);
> >
> > @@ -233,12 +241,12 @@ static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
> >         alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
> >         mutex_unlock(&rtc->lock);
> >
> > -       tm->tm_sec = data[RTC_OFFSET_SEC];
> > -       tm->tm_min = data[RTC_OFFSET_MIN];
> > -       tm->tm_hour = data[RTC_OFFSET_HOUR];
> > -       tm->tm_mday = data[RTC_OFFSET_DOM];
> > -       tm->tm_mon = data[RTC_OFFSET_MTH];
> > -       tm->tm_year = data[RTC_OFFSET_YEAR];
> > +       tm->tm_sec = data[RTC_OFFSET_SEC] & RTC_AL_SEC_MASK;
> > +       tm->tm_min = data[RTC_OFFSET_MIN] & RTC_AL_MIN_MASK;
> > +       tm->tm_hour = data[RTC_OFFSET_HOUR] & RTC_AL_HOU_MASK;
> > +       tm->tm_mday = data[RTC_OFFSET_DOM] & RTC_AL_DOM_MASK;
> > +       tm->tm_mon = data[RTC_OFFSET_MTH] & RTC_AL_MTH_MASK;
> > +       tm->tm_year = data[RTC_OFFSET_YEAR] & RTC_AL_YEA_MASK;
> >
> >         tm->tm_year += RTC_MIN_YEAR_OFFSET;
> >         tm->tm_mon--;
> > @@ -259,14 +267,25 @@ static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
> >         tm->tm_year -= RTC_MIN_YEAR_OFFSET;
> >         tm->tm_mon++;
> >
> > -       data[RTC_OFFSET_SEC] = tm->tm_sec;
> > -       data[RTC_OFFSET_MIN] = tm->tm_min;
> > -       data[RTC_OFFSET_HOUR] = tm->tm_hour;
> > -       data[RTC_OFFSET_DOM] = tm->tm_mday;
> > -       data[RTC_OFFSET_MTH] = tm->tm_mon;
> > -       data[RTC_OFFSET_YEAR] = tm->tm_year;
> > -
> >         mutex_lock(&rtc->lock);
> > +       ret = regmap_bulk_read(rtc->regmap, rtc->addr_base + RTC_AL_SEC,
> > +                              data, RTC_OFFSET_COUNT);
> > +       if (ret < 0)
> > +               goto exit;
> > +
> 
> Why did we need an additional regmap_bulk_read here? I would suppose
> data[RTC_OFFSET_*] & ~(RTC_AL_*_MASK) is always equal to 0.

In bootloader, RTC init part need to operate these RTC_AL_* registers
high byte for RTC operating mode settings and data storage, while
RTC_AL_* low byte was used as alarm register here. So we need an
additional regmap_bulk_read here to keep the RTC settings correct.

> 
> It might be another fixup since change is not being mentioned in the
> git message.
> 
> > +       data[RTC_OFFSET_SEC] = ((data[RTC_OFFSET_SEC] & ~(RTC_AL_SEC_MASK)) |
> > +                               (tm->tm_sec & RTC_AL_SEC_MASK));
> > +       data[RTC_OFFSET_MIN] = ((data[RTC_OFFSET_MIN] & ~(RTC_AL_MIN_MASK)) |
> > +                               (tm->tm_min & RTC_AL_MIN_MASK));
> > +       data[RTC_OFFSET_HOUR] = ((data[RTC_OFFSET_HOUR] & ~(RTC_AL_HOU_MASK)) |
> > +                               (tm->tm_hour & RTC_AL_HOU_MASK));
> > +       data[RTC_OFFSET_DOM] = ((data[RTC_OFFSET_DOM] & ~(RTC_AL_DOM_MASK)) |
> > +                               (tm->tm_mday & RTC_AL_DOM_MASK));
> > +       data[RTC_OFFSET_MTH] = ((data[RTC_OFFSET_MTH] & ~(RTC_AL_MTH_MASK)) |
> > +                               (tm->tm_mon & RTC_AL_MTH_MASK));
> > +       data[RTC_OFFSET_YEAR] = ((data[RTC_OFFSET_YEAR] & ~(RTC_AL_YEA_MASK)) |
> > +                               (tm->tm_year & RTC_AL_YEA_MASK));
> > +
> >         if (alm->enabled) {
> >                 ret = regmap_bulk_write(rtc->regmap,
> >                                         rtc->addr_base + RTC_AL_SEC,
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek


