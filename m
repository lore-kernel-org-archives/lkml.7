Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09F7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB0322CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1LNd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:13:33 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:58726 "EHLO protonic.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfH1LNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:13:32 -0400
Received: from erd988 (erd988.prtnl [192.168.224.30])
        by sparta (Postfix) with ESMTP id 9B71F44A0065;
        Wed, 28 Aug 2019 13:15:28 +0200 (CEST)
Date:   Wed, 28 Aug 2019 13:13:30 +0200
From:   David Jander <david@protonic.nl>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] gpio: gpio-pca953x.c: Correct type of reg_direction
Message-ID: <20190828131330.6a28e5cc@erd988>
In-Reply-To: <CAMpxmJXQ=M9PeMFBf70aE5Jgg3c6P2=4QF5CxWpenh+2WXLhnA@mail.gmail.com>
References: <20190827064629.90214-1-david@protonic.nl>
        <CAMpxmJV2XC+CK1SfJnH2YuaD2Gh=fiBQY+WPbjnqkvxGW6ZH_w@mail.gmail.com>
        <CAMpxmJXQ=M9PeMFBf70aE5Jgg3c6P2=4QF5CxWpenh+2WXLhnA@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Aug 2019 12:56:28 +0200
Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> śr., 28 sie 2019 o 10:38 Bartosz Golaszewski
> <bgolaszewski@baylibre.com> napisał(a):
> >
> > wt., 27 sie 2019 o 08:46 David Jander <david@protonic.nl> napisał(a):  
> > >
> > > The type of reg_direction needs to match the type of the regmap, which is
> > > u8.
> > >
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > ---
> > >  drivers/gpio/gpio-pca953x.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> > > index 378b206d2dc9..30072a570bc2 100644
> > > --- a/drivers/gpio/gpio-pca953x.c
> > > +++ b/drivers/gpio/gpio-pca953x.c
> > > @@ -604,7 +604,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
> > >         u8 new_irqs;
> > >         int level, i;
> > >         u8 invert_irq_mask[MAX_BANK];
> > > -       int reg_direction[MAX_BANK];
> > > +       u8 reg_direction[MAX_BANK];
> > >
> > >         regmap_bulk_read(chip->regmap, chip->regs->direction, reg_direction,
> > >                          NBANK(chip));
> > > @@ -679,7 +679,7 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, u8 *pending)
> > >         bool pending_seen = false;
> > >         bool trigger_seen = false;
> > >         u8 trigger[MAX_BANK];
> > > -       int reg_direction[MAX_BANK];
> > > +       u8 reg_direction[MAX_BANK];
> > >         int ret, i;
> > >
> > >         if (chip->driver_data & PCA_PCAL) {
> > > @@ -768,7 +768,7 @@ static int pca953x_irq_setup(struct pca953x_chip *chip,
> > >  {
> > >         struct i2c_client *client = chip->client;
> > >         struct irq_chip *irq_chip = &chip->irq_chip;
> > > -       int reg_direction[MAX_BANK];
> > > +       u8 reg_direction[MAX_BANK];
> > >         int ret, i;
> > >
> > >         if (!client->irq)
> > > --
> > > 2.19.1
> > >  
> >
> > Applied for v5.4.  
> 
> Actually the second patch depends on the first one, so moved it over to fixes.

Btw, they are both bugfixes, IMHO it would be valuable to have them in 5.3rc
if possible... there is some severe breakage there right now.

Best regards,

-- 
David Jander

