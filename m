Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4B5CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D113E2190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRCiTT4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfKCWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:23:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46518 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfKCWXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:23:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id 19so5627324lft.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 14:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ESUhhN6edmpvHFOV1Utv000unf+voyNT/XqNjo94L3E=;
        b=QRCiTT4RtFkcbSgtjNd916P8LiP+fVE6O67kBgLv/qfB9arXpn+JSLOI9BH4ht8w5p
         KO911xAHoIUr2XcjLsIrtSJrqAIg3Qasmv8+1w5kf9IBMmZCyRQju63Wp5V55a43xrXN
         8ovnfJqkCmPQcjvSEwLq70modMTgbPR99uE3DigW7sy3fcFtk2miLcyWe1QfTA2wL+m4
         dg8noVdcjht1feN13oMlJxV2e5zNNV2q5SsIQ8N1+oERo0Zcwm0tnPK1UutkbuGvAh0v
         +BrnKqpxrWpfpHLar2RvsTp9piW4rgejaoXD1dWiwwDCLFBp2hXa7Ab6zkyeU8jcSK4a
         bz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ESUhhN6edmpvHFOV1Utv000unf+voyNT/XqNjo94L3E=;
        b=MYyacYWvu9tz0aWQMTP8LFSPLaFZDqThPLUMrBU5fSzkHVzTA8AVCGFKGjNljbqT8D
         cudc/yfGI/b3e3U5vyIdtlQIgMDFUKGVL5vPhpYmGPDxLSTh5YM4E7oyEADUDet4C+oA
         zyYRJ2lBURx+64ojvcc1GtlK6cCcRSXtPAg+fZIYOJbpvIqxfpt8LR4qRfnGZnJw1dIn
         WQ0InDE5hNNP6lScPnYgq2FzG4dHTG8seQa5JCsqjQDMU7iYJE2nyCkt8YEKBo33Qn4J
         ybxcZQGflG/p7ZMTVq0iP/ckGYEkxvLcPKb55fJ9zrEvsYsjkCCreEPQSSVd3GSNYRso
         TX8w==
X-Gm-Message-State: APjAAAUXGJ2inHogOwVbOiphNySv3FxZ02eCMB1cF8vM+mscVr+SQJfu
        5JLV5pexw7sTpqg4+qO7H2o6PSyXNyPmUC2TCJcU9yCjPkY=
X-Google-Smtp-Source: APXvYqxPSzDXNKfugYnnHKUIKKHIHEvHG3nXTxP1PlQspCYo+knQSZ/r4By3eoLa9c19qr7bRZjXcrwmJ2fir+v3Ops=
X-Received: by 2002:a19:ca13:: with SMTP id a19mr14186914lfg.133.1572819812751;
 Sun, 03 Nov 2019 14:23:32 -0800 (PST)
MIME-Version: 1.0
References: <20191101015621.12451-1-chris.packham@alliedtelesis.co.nz>
 <20191101015621.12451-2-chris.packham@alliedtelesis.co.nz> <b681ed9d-a31a-e5cc-04ba-6f38a5cc745b@gmail.com>
In-Reply-To: <b681ed9d-a31a-e5cc-04ba-6f38a5cc745b@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 3 Nov 2019 23:23:21 +0100
Message-ID: <CACRpkdZ6xOmRUnNCRBAPak1Q_g9WSNYKGpLeU-ajroUbB_gSeA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: bcm: nsp: use gpiolib infrastructure for interrupts
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 3:55 AM Florian Fainelli <f.fainelli@gmail.com> wrote:

> > +             girq = &chip->gc.irq;
> > +             girq->chip = irqc;
> > +             /* This will let us handle the parent IRQ in the driver */
> > +             girq->parent_handler = NULL;
> > +             girq->num_parents = 0;
> > +             girq->parents = NULL;
> > +             girq->default_type = IRQ_TYPE_NONE;
> > +             girq->handler = handle_simple_irq;
>
> It might be worth creating a helper that can be called to initialize all
> relevant members to the values that indicate: let me manage the
> interrupt. This would make us more future proof with respect to
> assumptions being made in gpiolib as well as if new fields are added in
> the future. This would be a separate patch obviously.

I have some different plans for this, but first I want to pull all
struct gpiolib_irq_chip *girq setup over to the new API,
so I can get rid of the old helper functions.

First chained variants, when that is done, threaded variants,
when that is done abstract this type that is using its own
parent handler and then eventually delete the old helper
functions.

Then I can think about adding new helper functions :D

Yours,
Linus Walleij
