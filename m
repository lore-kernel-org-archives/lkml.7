Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F568C282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8A720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=z3ntu.xyz header.i=@z3ntu.xyz header.b="tPrIvyL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfDPQCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:02:21 -0400
Received: from mail.z3ntu.xyz ([128.199.32.197]:47920 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbfDPQCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:02:19 -0400
Received: from g550jk.localnet (80-110-119-101.cgn.dynamic.surfer.at [80.110.119.101])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 26B6DC13D6;
        Tue, 16 Apr 2019 16:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1555430536; bh=LqBUngwNfb1vgcYjjJSO/R3M+BdjGQnh7ULQhYtZMgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tPrIvyL1Oj7hZZhYrwMQrPr8GbjdHxUDVpyPUbrcIOQSFROk1kQw4fMhPk+Y1D9J6
         cbie6ZELHw6OSG70s4JaWallUoqj2xYgxxPZERQkzehgNCzq+MVnVTOUPGr0dOZ7cG
         KAkwQhrh9xVXxhf9Q+nHZVKTI+btIXghnz5Tn8Qs=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT KEYBOARD, MOUSE, JOYSTICK , TOUCHSCREEN..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] Input: add a driver for GPIO controllable vibrators
Date:   Tue, 16 Apr 2019 18:02:15 +0200
Message-ID: <1633425.a675zxgQUS@g550jk>
In-Reply-To: <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
References: <20190412150625.28384-1-luca@z3ntu.xyz> <20190412150625.28384-2-luca@z3ntu.xyz> <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Freitag, 12. April 2019 19:43:52 CEST Stephen Boyd wrote:
> Quoting Luca Weiss (2019-04-12 08:06:24)
> 
> > diff --git a/drivers/input/misc/gpio-vibra.c
> > b/drivers/input/misc/gpio-vibra.c new file mode 100644
> > index 000000000000..3fd2dfd4f670
> > --- /dev/null
> > +++ b/drivers/input/misc/gpio-vibra.c
> > @@ -0,0 +1,209 @@
> > +
> > +static int gpio_vibrator_probe(struct platform_device *pdev)
> > +{
> 
> [...]
> 
> > +       vibrator->input->id.bustype = BUS_HOST;
> > +       vibrator->input->close = gpio_vibrator_close;
> > +
> > +       input_set_drvdata(vibrator->input, vibrator);
> > +       input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> > +
> > +       err = input_ff_create_memless(vibrator->input, NULL,
> > +                                     gpio_vibrator_play_effect);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> > +               return err;
> > +       }
> > +
> > +       err = input_register_device(vibrator->input);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "Couldn't register input dev: %d",
> > err);
> All the printks in this file need a newline.
Fixed.
> > +               return err;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, vibrator);
> > +
> > +       return 0;
> > +}
> > +
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id gpio_vibra_dt_match_table[] = {
> > +       { .compatible = "gpio-vibrator" },
> > +       {},
> 
> Nitpick: Drop the comma on the sentinel so nothing can go after it
> without causing a compilation error.
Changed as well.
> > +};
> > +MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
> > +#endif
> > +

Thanks for the review! Will send a v4 shortly.
Luca


