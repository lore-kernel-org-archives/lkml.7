Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5788DC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 256AC208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 21:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W9CPOfod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFYVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 17:47:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43193 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbfFYVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 17:47:20 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so17744564ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z/7iY+DnLcZ0LezbOS35sy0HgPdj0Ewcwnm4oaB/nKo=;
        b=W9CPOfods70wf/mb0mzHG5wJJRKM+sddo446tb0HsZyJTxvQCyJ/CtsdhdqbFMCGe0
         m2CZRzhDrc2+rhlxoVr1/AN07ukD7FfT8PZuoF0kNl1Tq2rmvT5fxpDD20YOv/tN2yra
         5ixXEccCb2M2cZtGDh+8vJqcltnX9vaCsn+T7VPMK4okAhweQMd03C9eoIuOk1m7KErs
         FDvxQLdPA3NpqdXOfJisP9QM1eKoUJcnuEBZTqj40V0d8ujg4aON8dMMvINLzOxs9atc
         gyF030AxBKO08/Om7d9GbN/WFuvZzWi+JPdqsdoiuPN7LukX4vv+/e2F+p0P5GQbgBOg
         G5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z/7iY+DnLcZ0LezbOS35sy0HgPdj0Ewcwnm4oaB/nKo=;
        b=sos+A+WLFXijrXyd6xnp0W0En4uYJBOMoUz+NqITcd1eUZS5ZgqWvIcOYVRw4D7051
         rZaxttu8HSdaTlllYDuUlbx6UVQOMt7SGolnpE9TKyNL6Jg4R/cVd9Tog5vu+ocy4U8o
         0O/TNsNnOCxj2s4ddM4qGyCoEjmEbRE9Q6Af7jZaJOzy49GzQ762DnMTFIOdsfDBjeJT
         K6AIpNi1iDKSJ+MFke0QESZXIdGtygfTAz/zfZ88nXBRN9Sd17olMh7HJIyjsTkztPSn
         aYEAOJg64xFVNYNamxou6iCeZtsJVkG4XAapL2JhJz7KMGDA+BlqhWWjKigq1iE/gtS8
         i2fw==
X-Gm-Message-State: APjAAAWZJP72Cp8t10lnGy/OgpkkNKmKa8Mn8gKPRHaBx8Q14TtQq2Em
        bSEdnks9tKJ1Eenb4U0NN/NRFyNNRMUwG5nkWowNZQ==
X-Google-Smtp-Source: APXvYqzMR10l93rViwuhFQNu55fJ5C0Pn/GPzn97xvFQHwI302OTE+IuljHXJI9gRVYElTANqxFQchnBMEROTxTabkA=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr463722ljm.180.1561499238305;
 Tue, 25 Jun 2019 14:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190624215649.8939-1-robh@kernel.org> <20190624215649.8939-11-robh@kernel.org>
 <CACRpkdYKE=zLJhmTeTWYGRCQNt3K8+rNNqsp5UDa2d31GG6Y2g@mail.gmail.com>
 <CAL_Jsq+uCMKhUFgCCK3uUetL9OwokQPaq74GJHQS2VS=UjVH8w@mail.gmail.com>
 <CACRpkdYnSZibUyhe5D8W259fCJBm05rG0_EmX+uoi=uqbrqEYA@mail.gmail.com> <CAL_Jsq+45dKRMdRCjfKgEkvsk1MLyeXnY4fjZmh50WLweyJfCg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+45dKRMdRCjfKgEkvsk1MLyeXnY4fjZmh50WLweyJfCg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 23:47:06 +0200
Message-ID: <CACRpkdYEYcvxVai9kjLyz_Sudiz=JPD7oKU4sVL-bxOmWN0dkg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: display: Convert tpo,tpg110 panel
 to DT schema
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:26 PM Rob Herring <robh@kernel.org> wrote:
> On Tue, Jun 25, 2019 at 2:26 AM Linus Walleij <linus.walleij@linaro.org> wrote:

> > Can I simply just merge the panel-common patch as well and we
> > are all happy?
>
> I have drm-misc commit rights too, so I'll apply the whole lot when it's ready.
>
> > I can also pick up more panel binding patches, IMO the yaml
> > conversions are especially uncontroversial and should have low
> > threshold for merging.
>
> Yes, but the threshold is at least 'make dt_binding_check' should not
> break. But don't worry, there are 2 other breakages in linux-next
> currently.

OK let's try to live with it for now, if it makes you too much trouble
we can just revert it, accidents happen.

Yours,
Linus Walleij
