Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191CDC072A4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7D320815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 06:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbfETGGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 02:06:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:27154 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730368AbfETGGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 02:06:46 -0400
X-UUID: 6b1714260d78452591e3b4401a4f0fd5-20190520
X-UUID: 6b1714260d78452591e3b4401a4f0fd5-20190520
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <chun-hung.wu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2012965388; Mon, 20 May 2019 14:06:40 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 20 May 2019 14:06:38 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 20 May 2019 14:06:38 +0800
Message-ID: <1558332398.11080.9.camel@mtkswgap22>
Subject: Re: [PATCH 4/4] iio: auxadc: mediatek: change to subsys_initcall
From:   Chun-Hung Wu <chun-hung.wu@mediatek.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>
Date:   Mon, 20 May 2019 14:06:38 +0800
In-Reply-To: <20190518113643.53a42976@archlinux>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
         <1557994247-16739-5-git-send-email-chun-hung.wu@mediatek.com>
         <20190518113643.53a42976@archlinux>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2F0B7CBF20F89F7C6C59579E9C4CCAF43409E6EB9A5EC6F37009CE4AC58C707A2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, 2019-05-18 at 11:36 +0100, Jonathan Cameron wrote:
> On Thu, 16 May 2019 16:10:47 +0800
> Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
> 
> >   Move auxadc platform_driver_register() from module_init
> > to subsys_initcall because auxadc user drivers
> > are all moudle drivers, need to gurantee
> > auxadc driver ready before module_init.
> > 
> Is it not possible to make them use deferred handling to come
> back later if this isn't yet available?
> 
> subsys_initcall often ends up being a more fragile approach.

Agreed, I will ask auxadc driver users to add deferred handling
instead of moving auxadc platform_driver_register() from module_init
to subsys_initcall.

Thanks,
Chun-hung

> 
> Thanks,
> 
> Jonathan
> 
> > Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> > ---
> >  drivers/iio/adc/mt6577_auxadc.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index 58d7cb2..cb8e3dd 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -350,7 +350,19 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
> >  	.probe	= mt6577_auxadc_probe,
> >  	.remove	= mt6577_auxadc_remove,
> >  };
> > -module_platform_driver(mt6577_auxadc_driver);
> > +
> > +static int __init mt6577_auxadc_init(void)
> > +{
> > +	return platform_driver_register(&mt6577_auxadc_driver);
> > +}
> > +
> > +static void __exit mt6577_auxadc_exit(void)
> > +{
> > +	platform_driver_unregister(&mt6577_auxadc_driver);
> > +}
> > +
> > +subsys_initcall(mt6577_auxadc_init);
> > +module_exit(mt6577_auxadc_exit);
> >  
> >  MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
> >  MODULE_DESCRIPTION("MTK AUXADC Device Driver");
> 


