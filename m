Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C3DC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FD32080F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfJFTMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:12:43 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:54732 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfJFTMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:12:43 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990429AbfJFTMibd0Fl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:12:38 +0200
Date:   Sun, 6 Oct 2019 21:12:37 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     mirq-linux@rere.qmqm.pl
Cc:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, rf@opensource.wolfsonmicro.com,
        piotrs@opensource.cirrus.com, enric.balletbo@collabora.com,
        paul@crapouillou.net, srinivas.kandagatla@linaro.org,
        andradanciu1997@gmail.com, kuninori.morimoto.gx@renesas.com,
        m.felsch@pengutronix.de, shifu0704@thundersoft.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] ASoc: tas2770: Fix build error without GPIOLIB
Message-ID: <20191006191237.GA6543@lenoch>
References: <20191006072241.56808-1-yuehaibing@huawei.com>
 <20191006104631.60608-1-yuehaibing@huawei.com>
 <20191006153158.GA9882@qmqm.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191006153158.GA9882@qmqm.qmqm.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Micha³,

On Sun, Oct 06, 2019 at 05:31:58PM +0200, mirq-linux@rere.qmqm.pl wrote:
> On Sun, Oct 06, 2019 at 06:46:31PM +0800, YueHaibing wrote:
> > If GPIOLIB is not set, building fails:
> > 
> > sound/soc/codecs/tas2770.c: In function tas2770_reset:
> > sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
> >    gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
> >    ^~~~~~~~~~~~~~~~~~~~~~~~
> >    gpio_set_value_cansleep
> > sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
> > sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
> >   tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
> >                         ^~~~~~~~~~~~~~~~~~~~~~~
> >                         devm_regulator_get_optional
> > sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
> >              GPIOD_OUT_HIGH);
> >              ^~~~~~~~~~~~~~
> >              GPIOF_INIT_HIGH
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
> > Suggested-by: Ladislav Michl <ladis@linux-mips.org>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> > v2: Add missing include file
> > ---
> >  sound/soc/codecs/tas2770.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
> > index 9da88cc..a36d0d7 100644
> > --- a/sound/soc/codecs/tas2770.c
> > +++ b/sound/soc/codecs/tas2770.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/pm.h>
> >  #include <linux/i2c.h>
> >  #include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/firmware.h>
> 
> The Kconfig part is missing - is this intended? If I guess correctly,
> the driver won't work without GPIOLIB, so it should either
> 'select GPIOLIB' or 'depends on GPIOLIB || COMPILE_TEST' or even
> 'select GPIOLIB if !COMPILE_TEST'.

while the first one is actually preferable I won't do this in this patch,
but rather generally. The same you can say about regulator, regmap and
other interfaces, so perhaps leaving that to patchset focusing on this
kind of problem seem to be better.

Btw, I guess linux/gpio/consumer.h is enough for this driver and including
linux/gpio.h should be dropped.

	ladis

