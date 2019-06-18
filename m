Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41632C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE59205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9e6WBhg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbfFRSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:01:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44636 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729586AbfFRSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:01:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id r16so452634wrl.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4TRvD1f7mrzpWOl3NEs7czvhz+VRSz0lAkw6qBXnFLE=;
        b=j9e6WBhgGb2m272a9Ty7hK1Ru1Z8Et6pItbk3oLasaW5jrj9fVMlunQDavatnrdA33
         nzb+9HMIHPnH0Bnc8VFVGe38iQgbZxOUWbgSvfQgbfW8Vg2kHgOHg82aiuJqUfiLiQXr
         OmIJ73VMFS+TMf2dz94G4VDkLJiq4ACZ7CDus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4TRvD1f7mrzpWOl3NEs7czvhz+VRSz0lAkw6qBXnFLE=;
        b=ZGWyfX4Pn0FgHfNRYrEhLJz8IESMeM/6l8Mly5eCIm0RorPZQFlyG0yy+5qLT38m2+
         QNDPGR8eF/sqCfDl41G29+JUbsD7JsZCKkU42cvpgzEUw9yqn8M64MbnI/6TSvPhkQ+t
         RIaofYNHuFW9Bgpd9MiQ1T8CoGEoYuvE6Wk5iINZoqhMgEXTf+N/0zy24zDU2ZZTUaxR
         2dGpRbk2E5tIw3YwHYRnhB9A7V9oqN4v4yg8vwRmKymvGWYaRVjrwoaMInGoM1tBwUzb
         iTfcoTPs26eMafeo+a1gAG/nejYG7AN++H6qxQpgOwd7LdDhqV5Y3fvrL6fFtgNv71sj
         FLlg==
X-Gm-Message-State: APjAAAX0HL6LNO3FMK7NGFSwNBAjEpbrlGaYiEk4SrfjwOce/alTulpx
        H8EIXvm98Vml7EeKIEcUCdPf9P6aQC9+VsosClBK1w==
X-Google-Smtp-Source: APXvYqwkn/0bji0EJR+RJ98lDU9MBxhi3sf57NOIolkAwzcM8iS5SXwpkxoB2LXqSdeNugUR3A0nxHrOSh8c0/Naa04=
X-Received: by 2002:adf:ff84:: with SMTP id j4mr4994173wrr.71.1560880885230;
 Tue, 18 Jun 2019 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190614194854.208436-1-fletcherw@chromium.org>
 <20190614194854.208436-4-fletcherw@chromium.org> <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
In-Reply-To: <4e560e12-4c20-8d5d-b3f9-587a55da279d@intel.com>
From:   Fletcher Woodruff <fletcherw@chromium.org>
Date:   Tue, 18 Jun 2019 12:00:59 -0600
Message-ID: <CAN-6NYZzMqwDaw2oDyms4P9uKFPJvuQOtGbqMWLtFV3kDyQHJQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] ASoC: rt5677: clear interrupts by polarity flip
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 16, 2019 at 10:56 AM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
> On 2019-06-14 21:48, Fletcher Woodruff wrote:
> > +static irqreturn_t rt5677_irq(int unused, void *data)
> > +{
> > +     struct rt5677_priv *rt5677 = data;
> > +     int ret = 0, i, reg_irq, virq;
> > +     bool irq_fired = false;
> > +
> > +     mutex_lock(&rt5677->irq_lock);
> > +     /* Read interrupt status */
> > +     ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
> > +     if (ret) {
> > +             pr_err("rt5677: failed reading IRQ status: %d\n", ret);
>
> The entire rt5677 makes use of dev_XXX with the exception of.. this very
> function. Consider reusing "component" field which is already part of
> struct rt5677_priv and removing pr_XXX.

I was using dev_XXX, but I believe Curtis found that 'component' was
sometimes uninitialized when this function was called, so I switched
back to pr_XXX. I may be misremembering though, so I'll let Curtis
comment as well.

> > +     if (ret) {
> > +             dev_err(&i2c->dev, "Failed to request IRQ: %d\n", ret);
> >               return ret;
>
> You may want to simplify this, similarly to how's it done in your
> rt5677_i2c_probe - leave message alone and return "ret" explicitly at
> the end.

Good suggestion. I'll update that for the next patch.
