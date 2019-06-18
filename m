Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD90C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A320863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 19:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NmHlXE54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbfFRTKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:10:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36759 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfFRTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 15:10:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id i21so689574ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u69+nLXPtFpbs6TaePvjeaTV79sjBn+0kMLOo8QV9dQ=;
        b=NmHlXE549XG+CtzrGl8FRRUnyJMBn0Ba3aS5JivNDC+A5JPz2Yu7wHyIBXn4Xp8E6V
         +tknKiyvaCuv7ze4AXJHR1qp5i7fvOJbOcw0iJuAu8/91zOGW2QYkqYeW/ZI+k12mSww
         yEB2J+NHetS/6lLWvIHXYEa6iGpBEbKM3+uhjB+46CZxoFqr6MT/QQKwf/g+FPF8/EVX
         O/C88+IQ8Ukt0L/7G3GXgQizQAp2VJqMnGDnMDKs1x3n7CHM9tmtaSJw+YQPD5aUGWei
         chsoQnxg+awKflDM5STp2/1scSzQmrXB9sZ15ScrhAFF2S0zvQ0N6eAS+i1ovwkGolRH
         5sRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u69+nLXPtFpbs6TaePvjeaTV79sjBn+0kMLOo8QV9dQ=;
        b=tl6mwz1JivHP4kI1BRP1vrh0OvtR4T5ucAkmxWpUP3b7U0R3nzBuWoSZ2aMp95cpq+
         cF7FwYLSjmcszjkBSz8csJv60wzGL08ro9ZKRmbHZVxQy/W6ykCegWmcvwC7q4LldRja
         cMI/LXo1jalcZi9Tr4WnfZ9H/b0oQj57t1l0uJ+i5X/teJQbIIVsg1lc9aI1+GksftBF
         BK/W0f/S+BdWkPn2ssn2wCUqNPNcpXF6KTxxdVfBLNIRoRXEEnCUgWDRFZdTnvnO4IPG
         J3cXj6cOyruta2rzOAPmfFELHg+gZiv9yPaZ69yWaQphWmhQUOSupWI0QGEgjcAOzrl/
         lWHA==
X-Gm-Message-State: APjAAAUaGwNsD/CJexll/NhEyA6dwgOPJgNxk77rk2jrSKEYP/PWskO/
        X6rUtZiJTM1CQklp3NkrgTSd/Rsj1gr3m1seuijNDQ==
X-Google-Smtp-Source: APXvYqwLkpvNF/wVs3KqDx5UiSroFjYcsfziiGdNbJ6lJvw8dk/WsNpJ1kNCKjRCMErTB4agKCXbrCz8Hl94x0zS+io=
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr47206359lja.207.1560885021249;
 Tue, 18 Jun 2019 12:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org> <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
 <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
 <CAOReqxhETC9xAojXyDWLMOJ3W22Zn4GNGry44=XC=t_k7SCHqA@mail.gmail.com> <20190618184710.GP5316@sirena.org.uk>
In-Reply-To: <20190618184710.GP5316@sirena.org.uk>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 18 Jun 2019 12:10:10 -0700
Message-ID: <CAOReqxj+9WH70P5oDN12KdDqkX8Kp18NBdTswOZSC8u=AwS_LQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
To:     Mark Brown <broonie@kernel.org>
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:47 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 18, 2019 at 11:12:58AM -0700, Curtis Malainey wrote:
> > On Tue, Jun 18, 2019 at 11:01 AM Fletcher Woodruff
> > > On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
> > > > On 2019-06-14 21:48, Fletcher Woodruff wrote:
>
> > > > > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > > > > +     if (ret) {
> > > > > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);
>
> > > > The entire rt5677 makes use of dev_XXX with the exception of.. this very
> > > > function. Consider reusing "component" field which is already part of
> > > > struct rt5677_priv and removing pr_XXX.
>
> > > I was using dev_XXX, but I believe Curtis found that 'component' was
> > > sometimes uninitialized when this function was called, so I switched
> > > back to pr_XXX. I may be misremembering though, so I'll let Curtis
> > > comment as well.
>
> > The issue here is that the IRQ is setup in the i2c probe and the
> > component is setup in the codec probe. In theory if the hardware is in
>
> The component is not needed for a struct device, you must have a struct
> device if you have a regmap or have probed at all.
Ah yes, we could modify the struct and store the i2c device and get
the device out of that as well. That will likely be simpler. Ok lets
do that.
