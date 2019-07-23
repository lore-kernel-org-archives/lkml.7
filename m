Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12D62184B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NOQFcqQw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732143AbfGWWXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:23:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37104 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbfGWWXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:23:12 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so19829795pfa.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=O5LjLvy2ENN8UCIu9fvPvWX0URUSSr24wNvrUVfew9c=;
        b=NOQFcqQwqc2MyLi3diYy2gjLaKUgdXHstdCAYqzZTMW+zymMeo4yWzG/dTc+iR6d3r
         lwFhEZn13gZ/UhVGFKgitWMHM5Ub9Xz/4cDmW7XXmKWQrzvoiJ91ImDUOpf01FdBT1IT
         nZq/KcY58OWUrC/QHd1gD4yYwvkR2Ku3gqUTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=O5LjLvy2ENN8UCIu9fvPvWX0URUSSr24wNvrUVfew9c=;
        b=uVrOhiWwVlUAUrLieRuaKcRAvvrOekHdqv+EsLzzT07wu7lVW0AugQM5O7aR2AqsB/
         YcPB/ctxeILk323W5ANL1UanO+KUieyGMEr53ZnwNdSi3jFlFSBJLvSon2vPa/z5EMpt
         AA+JKq8k2+JKBkzWAYmbrc/u36x3n8tZlFh05tb1WQaIaTJAPL8gYpwxb3xiobOONJmE
         X1i2lLRSF4RSANAcQt7N+s8LknBHqVICYIE3d9xK50AHeo7PhgU45lFuF7b80dXnLBf6
         Dhi2Y4LN9f7xW0StGllm2Ux7wd5PXVgN67ds1z6StjLoh7ey18v+3jyKTmHNEDL8mL/W
         /n5g==
X-Gm-Message-State: APjAAAXOzbZPqauSy4M3kVzeeD1eTNr6Z2SCkPozpw7rRep4SPiJsgQ0
        SmEK/7mCrQ59c70V8mm3fQ4DUg==
X-Google-Smtp-Source: APXvYqxQIcWAd3tSbwEZ2DZvyUDNnGmmEhzf42xNz7xWhTTm+U9jIEY+6duRWcsMC0PyGtST69hKMw==
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr8056464pfs.3.1563920592295;
        Tue, 23 Jul 2019 15:23:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s43sm53751114pjb.10.2019.07.23.15.23.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 15:23:11 -0700 (PDT)
Message-ID: <5d3788cf.1c69fb81.44f27.5907@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75Vf8EUKLSWoEshU_VogBDym_oco_kj3AhfT=9KqtaGba3Q@mail.gmail.com>
References: <20190723181624.203864-1-swboyd@chromium.org> <20190723181624.203864-3-swboyd@chromium.org> <CAHp75Vf8EUKLSWoEshU_VogBDym_oco_kj3AhfT=9KqtaGba3Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 15:23:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2019-07-23 11:31:54)
> On Tue, Jul 23, 2019 at 9:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
> >
> > // <smpl>
> > @@
> > expression ret;
> > struct platform_device *E;
> > @@
> >
> > ret =3D
> > (
> > platform_get_irq(E, ...)
> > |
> > platform_get_irq_byname(E, ...)
> > );
> >
> > if ( \( ret < 0 \| ret <=3D 0 \) )
> > {
> > (
> > -if (ret !=3D -EPROBE_DEFER)
> > -{ ...
> > -dev_err(...);
> > -... }
> > |
> > ...
> > -dev_err(...);
> > )
> > ...
> > }
> > // </smpl>
> >
>=20
> Can you teach it to remove curly braces when it's appropriate? (see
> below for examples)

I don't know if that works. I was hoping that checkpatch might do that
for me with --fix but it doesn't seem to warn about anything so I guess
not. Is there some sort of tidy script I can run on my patches to do
this?

>=20
> >  drivers/i2c/busses/i2c-cht-wc.c               |  1 -
>=20
> >  drivers/mfd/intel_soc_pmic_bxtwc.c            |  1 -
>=20
> >  drivers/pinctrl/intel/pinctrl-cherryview.c    |  1 -
> >  drivers/pinctrl/intel/pinctrl-intel.c         |  1 -
>=20
> >  drivers/platform/x86/intel_bxtwc_tmu.c        |  1 -
> >  drivers/platform/x86/intel_int0002_vgpio.c    |  1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          |  1 -
>=20
> Can you split this on per subsystem level?
>=20
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> after addressing above.

It depends on the previous patch to make behavior match, so maybe it
doesn't matter because it will go through one tree instead of many?
Either way I'm fine, I just don't want to spend the time on it until a
potential maintainer accepts or rejects it because of this.

