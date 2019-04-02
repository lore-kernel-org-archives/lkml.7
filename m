Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C761BC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10982084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731579AbfDBOGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:06:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54189 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfDBOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:06:33 -0400
X-Originating-IP: 109.213.83.19
Received: from localhost (alyon-652-1-60-19.w109-213.abo.wanadoo.fr [109.213.83.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1B9CD6001E;
        Tue,  2 Apr 2019 14:06:27 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:06:27 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 9/9] rtc: Add support for the MediaTek MT6358 RTC
Message-ID: <20190402140627.GC22216@piout.net>
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1552275991-34648-10-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1553161886.13384.7.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553161886.13384.7.camel@mtksdaap41>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2019 17:51:26+0800, Yingjoe Chen wrote:
> 
> Hi,
> 
> 
> Should use 'rtc: mt6397: ' as prefix for this patch.
> 
> 
> On Mon, 2019-03-11 at 11:46 +0800, Hsin-Hsiung Wang wrote:
> > From: Ran Bi <ran.bi@mediatek.com>
> > 
> > This add support for the MediaTek MT6358 RTC. MT6397 mfd will pass
> > RTC_WRTGR address offset to RTC driver.
> > 
> > Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index f85f1fc..c8a0090 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -27,7 +27,7 @@
> >  #define RTC_BBPU		0x0000
> >  #define RTC_BBPU_CBUSY		BIT(6)
> >  
> > -#define RTC_WRTGR		0x003c
> > +#define RTC_WRTGR_DEFAULT	0x003c
> >  
> >  #define RTC_IRQ_STA		0x0002
> >  #define RTC_IRQ_STA_AL		BIT(0)
> > @@ -78,6 +78,7 @@ struct mt6397_rtc {
> >  	struct regmap		*regmap;
> >  	int			irq;
> >  	u32			addr_base;
> > +	u32			wrtgr_offset;
> >  };
> >  
> >  static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> > @@ -86,7 +87,8 @@ static int mtk_rtc_write_trigger(struct mt6397_rtc *rtc)
> >  	int ret;
> >  	u32 data;
> >  
> > -	ret = regmap_write(rtc->regmap, rtc->addr_base + RTC_WRTGR, 1);
> > +	ret = regmap_write(rtc->regmap,
> > +			   rtc->addr_base + rtc->wrtgr_offset, 1);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > @@ -341,6 +343,15 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	rtc->addr_base = res->start;
> >  
> > +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> > +	if (res) {
> > +		rtc->wrtgr_offset = res->start;
> > +		dev_info(&pdev->dev, "register offset:%d\n", rtc->wrtgr_offset);
> > +	} else {
> > +		rtc->wrtgr_offset = RTC_WRTGR_DEFAULT;
> > +		dev_err(&pdev->dev, "Failed to get register offset\n");
> > +	}
> > +
> 
> Since this will be passed by MFD, do we still need to keep the DEFAULT?
> Any case this platform_get_resource will failed?
> 
> It's too bad HW changed this offset, but I'm not sure about passing this
> information from MFD. We have 1 register that have different offset now,
> and might have others for future chips, adding each one by
> IORESOURCE_IRQ doesn't looks like a good solution. Keeping this
> information in RTC driver only also looks better.
> 

I agree, this would be better.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
