Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E891C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C63D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATAktAWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfFRSNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:13:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43462 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfFRSNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:13:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so473337ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u0LO1voIJdc5rwD/tpLzm7lno4EknpAahwh3tgnDyWQ=;
        b=ATAktAWzRWJqwtcElWQ3cEKWeBdAWybAa8BzjTELprX3qa5UtsSUFtLxLcl1e/YGPq
         g/Nd3wXZUBrBwPrePMRdUhamp6KDoHsnA5S5Mm3vsE1tUY9qOYmECzbTxLFpddgidmpX
         MQiRQ7a5kL8+Tm5W9xGYvvaSFgmsVo1CrptxXjZ2CQg1ZJdGE/K8oTWGCaie7xUJQBk2
         eQAwDPPNBbH4wnMCtXAtXj0ZX62MuK5oqdIqNw9AxRBTIEpOVYoCtUOhhkev1elc5+qE
         Y0v+IBWbBwzDWuGCYPk/UM+VdbxJy54xZdsSgN8v1kEp3DfLVNy4I1QZrhWJye8sV2WM
         2IYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u0LO1voIJdc5rwD/tpLzm7lno4EknpAahwh3tgnDyWQ=;
        b=uBwnK1BKhTeDag9SXyrWT0/g9gSggxGiiRHOGdTwM8X7WYiWiSlkgnQaPuturq8SIZ
         7wpVzXIoQRRriK4QCYiBFDIohPJ08CQNlM1TWjJyP5WWJRKR6R9CI5eH5PXP6qaqu3FL
         LsB2B7wWxzIgD0ajGOSVdSHfM49T9lFeJXmHkVVprP/BkxM5h5U+tVkAXExen3sFFum2
         fEXepZOFkZPc/PUstmtYwzf4D7USMpZnkdLfaLCoB6pF9T27czhEx8NeJRoOQ3Q+IPMf
         APYUYj7LbQ3FWFb8qmOOADq/nzomhaSxB2sXZbJzaxhI1aqbAHZC5Cnkjl9ernJz2fFv
         SJzw==
X-Gm-Message-State: APjAAAUSKzM/HjGTBRMuRjoOlI8he6+naXaCTERmWNTKp9CcJMOwE7pw
        Naw1hQFIRu7PArIl36kos2UWH9OHiNBOkjQuFNuYOw==
X-Google-Smtp-Source: APXvYqzttjMGTsCm4NOJoHIaebz4OVBkTcqC7LsTaUDReiBRtrpyuiRrFKDNbdxG8k4tXulYkhc9wCAJ03yN7NWCrX8=
X-Received: by 2002:a2e:9dd7:: with SMTP id x23mr557672ljj.160.1560881589735;
 Tue, 18 Jun 2019 11:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org> <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
 <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
In-Reply-To: <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Tue, 18 Jun 2019 11:12:58 -0700
Message-ID: <CAOReqxhETC9xAojXyDWLMOJ3W22Zn4GNGry44=XC=t_k7SCHqA@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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

On Tue, Jun 18, 2019 at 11:01 AM Fletcher Woodruff
<fletcherw@chromium.org> wrote:
>
> On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
> <cezary.rojewski@intel.com> wrote:
> > On 2019-06-14 21:48, Fletcher Woodruff wrote:
> > > +static irqreturn_t rt5677_irq(int unused, void *data)
> > > +{
> > > +     struct rt5677_priv *rt5677 = data;
> > > +     int ret = 0, i, reg_irq, virq;
> > > +     bool irq_fired = false;
> > > +
> > > +     mutex_lock(&rt5677->irq_lock);
> > > +     /* Read interrupt status */
> > > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > > +     if (ret) {
> > > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);
> >
> > The entire rt5677 makes use of dev_XXX with the exception of.. this very
> > function. Consider reusing "component" field which is already part of
> > struct rt5677_priv and removing pr_XXX.
>
> I was using dev_XXX, but I believe Curtis found that 'component' was
> sometimes uninitialized when this function was called, so I switched
> back to pr_XXX. I may be misremembering though, so I'll let Curtis
> comment as well.
>
The issue here is that the IRQ is setup in the i2c probe and the
component is setup in the codec probe. In theory if the hardware is in
a bad state you can get an interrupt between the probes and have the
interrupt called with the component being NULL. It might be worth
considering migrating the IRQ setup to the codec probe so this
condition cannot happen and then we can avoid using pr_XXX.
> > > +     if (ret) {
> > > +             dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
> > >               return ret;
> >
> > You may want to simplify this, similarly to how's it done in your
> > rt5677_i2c_probe - leave message alone and return "ret" explicitly at
> > the end.
>
> Good suggestion. I'll update that for the next patch.
