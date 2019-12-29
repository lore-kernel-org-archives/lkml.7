Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB15AC2D0DA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809CD206E4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 14:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb35NC83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfL2Ogu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 09:36:50 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:33957 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfL2Ogu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 09:36:50 -0500
Received: by mail-io1-f66.google.com with SMTP id z193so29496906iof.1;
        Sun, 29 Dec 2019 06:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6P+l8FSlWBBte5aUxpeVJfQc+EhiRf7R8DtYJ/9CnDI=;
        b=Yb35NC83I5I7rr0g/aKTefVU+PtUCvsF58AputPF9VqGwwq7HGoXHrAnRrVrLe38i6
         Gf+D4lTUnef2r3wkZf8VDdia0LNTt235huRgflqorMssYPMYr4l/m6KB9VUllvTHAePW
         XZxc3+rT+021SRw9QkIi+UjCsHh8uScYVEdAEpn3zWCGELqGQB8Dw1qIKGvIsB8Z30o3
         Een5bv+OzDYelHKWETGXB1Y6ckk3cqOgz6cetWgeyFrVQU7yQLgq96zKokez/fP+j1bY
         EiGvFTHWhctAmC6rvvxPIA2/Xb5MnX1T/0Ee826qf8wcEzcS/R38qKb5dX66aPlORovX
         AkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6P+l8FSlWBBte5aUxpeVJfQc+EhiRf7R8DtYJ/9CnDI=;
        b=dHd+XkXPUYGqM6wCsrnEdg8L8R+9gscNq7oUstvGwKsPlPG0XB5vIg4YfseZ9dNyUE
         NLBRQdEMjlPzvoZgca+Rint2qy1J2PTXXsMm+dexd+zxZM+9kYv30PSStzjnhXuofNfx
         5JQlrYsJ+Rn1LzH4ZCN0onNlSFL9ND5Ez/3Qent63JqLnSxt8TO1w0U/FIPpmoldcMm/
         fHTKTTL3s0fow+ngbx2CET7yvZS1Kg92Y4qpprW+nBI/XLUZT1NSyjVGbsDI/TE+ic19
         UtzpppOa/7If1FYJC9U9ubq/mhfDgTK+2angkXIFBamQT7aZZnbmA1i0XUfsdPRbedwR
         mQ7A==
X-Gm-Message-State: APjAAAUIKY6nOJSRn7em8FFaUBN5rNm51skxDvpdqschSB9AIdigaJej
        enoYxms5qLoItnGARLNo/MF1mDJsFXC7e98BeHs=
X-Google-Smtp-Source: APXvYqyNz1FemOTTeZVrJPqsxKYy5wfDrBT8NhLYyVBm5RrFtVEGvc5exe5evt0DbAlmISUi6IF2gqQQe/GiWx36UOg=
X-Received: by 2002:a02:3ece:: with SMTP id s197mr48415001jas.30.1577630209372;
 Sun, 29 Dec 2019 06:36:49 -0800 (PST)
MIME-Version: 1.0
References: <20191229104325.10132-1-tiny.windzz@gmail.com> <CAMpxmJUggb7srWeLNzkcrb+L1THhP4DNH8nkkDaYDEs316ywDQ@mail.gmail.com>
In-Reply-To: <CAMpxmJUggb7srWeLNzkcrb+L1THhP4DNH8nkkDaYDEs316ywDQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 29 Dec 2019 22:36:38 +0800
Message-ID: <CAEExFWt+8FL45kLMWc3odS4GsCRkskD1Z08q6UAF1sYx32Hf-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib: devres: provide devm_ioremap_resource_nocache()
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        suzuki.poulose@arm.com, saravanak@google.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        dan.j.williams@intel.com, Joe Perches <joe@perches.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>, mans@mansr.com,
        Thomas Gleixner <tglx@linutronix.de>, hdegoede@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, ztuowen@gmail.com,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 8:11 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> niedz., 29 gru 2019 o 11:43 Yangtao Li <tiny.windzz@gmail.com> napisa=C5=
=82(a):
> >
> > Provide a variant of devm_ioremap_resource() for nocache ioremap.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  Documentation/driver-api/driver-model/devres.rst |  1 +
> >  include/linux/device.h                           |  2 ++
> >  lib/devres.c                                     | 15 +++++++++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documen=
tation/driver-api/driver-model/devres.rst
> > index 13046fcf0a5d..af1b1b9e3a17 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -317,6 +317,7 @@ IOMAP
> >    devm_ioremap_uc()
> >    devm_ioremap_wc()
> >    devm_ioremap_resource() : checks resource, requests memory region, i=
oremaps
> > +  devm_ioremap_resource_nocache()
> >    devm_ioremap_resource_wc()
> >    devm_platform_ioremap_resource() : calls devm_ioremap_resource() for=
 platform device
> >    devm_platform_ioremap_resource_wc()
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 96ff76731e93..3aa353aa52e2 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -962,6 +962,8 @@ extern void devm_free_pages(struct device *dev, uns=
igned long addr);
> >
> >  void __iomem *devm_ioremap_resource(struct device *dev,
> >                                     const struct resource *res);
> > +void __iomem *devm_ioremap_resource_nocache(struct device *dev,
> > +                                           const struct resource *res)=
;
> >  void __iomem *devm_ioremap_resource_wc(struct device *dev,
> >                                        const struct resource *res);
> >
> > diff --git a/lib/devres.c b/lib/devres.c
> > index f56070cf970b..a182f8479fbf 100644
> > --- a/lib/devres.c
> > +++ b/lib/devres.c
> > @@ -188,6 +188,21 @@ void __iomem *devm_ioremap_resource(struct device =
*dev,
> >  }
> >  EXPORT_SYMBOL(devm_ioremap_resource);
> >
> > +/**
> > + * devm_ioremap_resource_nocache() - nocache variant of
> > + *                                   devm_ioremap_resource()
> > + * @dev: generic device to handle the resource for
> > + * @res: resource to be handled
> > + *
> > + * Returns a pointer to the remapped memory or an ERR_PTR() encoded er=
ror code
> > + * on failure.
> > + */
> > +void __iomem *devm_ioremap_resource_nocache(struct device *dev,
> > +                                           const struct resource *res)
> > +{
> > +       return __devm_ioremap_resource(dev, res, DEVM_IOREMAP_NC);
> > +}
> > +
> >  /**
> >   * devm_ioremap_resource_wc() - write-combined variant of
> >   *                             devm_ioremap_resource()
> > --
> > 2.17.1
> >
>
> This has been discussed before. The nocache variants of ioremap() are
> being phased out as they're only ever needed on one obscure
> architecture IIRC. This is not needed, rather we should convert all
> nocache calls to regular ioremap().

Thanks for pointing out!
I have seen the use of ioremap_nocache in many architectures,
so they are wrong and should be changed to ioremap?

Yangtao

>
> Bart
