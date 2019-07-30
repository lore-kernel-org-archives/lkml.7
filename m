Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC82C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCBAC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Om+DDJFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfG3RVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:21:43 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36072 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfG3RVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:21:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so30191104pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 10:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=LwHqNqmoWfnNWSA0Wd3I+Yq8x/Ocfs3q7D+i58VJw/c=;
        b=Om+DDJFf+sCnwqgYzp1RKu0jdD5R87L+3VJG4evMyyWbfRfCbJrQMAaReYemh7yO7B
         uwSOADIJcS6VDcG5Sr6H6j5QGlAGZHLYAqXzfMy736Mj91J86maxySVU9lNiiufGxJLh
         gzlrTYRX+0Q5FYsth6Q5SCpKFi5dfWLq9BpY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=LwHqNqmoWfnNWSA0Wd3I+Yq8x/Ocfs3q7D+i58VJw/c=;
        b=Aup5WNmR0aTCO+l4rvPvXBIpZ1wKiCdAc/4jLXVJKZWIdx5kcLidF6WhC30arQYlsH
         lpIz+sTurixHbO1EnhV/UrDD/J190EiR0Re53OCiI+53wU7XjdYAZFZklgXicKEyr8WS
         4yR6Bh1XFhR9b+AKr/Pl1uP8NT6sw+xjLqRz7ikjz9HRIx4NtFtAJZX7wKZAY5lfQ5CA
         fKOIVFcks3/b1qBPHGaIcUji+1bEMf/fFVjSZ93jkQQnjOBBw7dMtHZ75Kl2Acvy2eFo
         sKpIQ5V+IOMqAITACA2NMwLoKSzV3qr/R15tE/vkZZh5oBPMD1UdJSIcrh0UeusZZFQz
         viDA==
X-Gm-Message-State: APjAAAVB/GoptoSTkzpxg8ChaWFEWUapfeolzshxGWcsGBMircRDgw/a
        f2Wn4rR582o7PfkFR996YTDagQ==
X-Google-Smtp-Source: APXvYqwVNLD621u4CizqbGe65IQvrujTBIzmZ5C+6xdEdPOQ09wcUI753a+amk0DNZZjQnKz6Yl8/g==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr119965674pja.104.1564507302595;
        Tue, 30 Jul 2019 10:21:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n185sm48328956pga.16.2019.07.30.10.21.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 10:21:42 -0700 (PDT)
Message-ID: <5d407ca6.1c69fb81.a0835.69e0@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHp75VeiMY4snbDkM=hdqRoUQZ5bEmhjEMdinmvV1voQhWfANg@mail.gmail.com>
References: <20190730053845.126834-1-swboyd@chromium.org> <20190730053845.126834-3-swboyd@chromium.org> <20190730064917.GB1213@kroah.com> <5d4063e0.1c69fb81.fb7c2.9528@mx.google.com> <CAHp75VcRJBmtqs6mN2wNE+fY8hVnPLDWRYZHQSwKXWsmhmhi8w@mail.gmail.com> <CAHp75VeiMY4snbDkM=hdqRoUQZ5bEmhjEMdinmvV1voQhWfANg@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 2/3] treewide: Remove dev_err() usage after platform_get_irq()
User-Agent: alot/0.8.1
Date:   Tue, 30 Jul 2019 10:21:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Shevchenko (2019-07-30 10:17:46)
> On Tue, Jul 30, 2019 at 8:16 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, Jul 30, 2019 at 6:36 PM Stephen Boyd <swboyd@chromium.org> wrot=
e:
> > > Quoting Greg Kroah-Hartman (2019-07-29 23:49:17)
> > > > On Mon, Jul 29, 2019 at 10:38:44PM -0700, Stephen Boyd wrote:
> > > > > We don't need dev_err() messages when platform_get_irq() fails no=
w that
> > > > > platform_get_irq() prints an error message itself when something =
goes
> > > > > wrong. Let's remove these prints with a simple semantic patch.
> >
> > > > Can you just break this up into per-subsystem pieces and send it th=
rough
> > > > those trees, and any remaining ones I can take, but at least give
> > > > maintainers a chance to take it.
> > >
> > > Ok. Let me resend just this patch broken up into many pieces.
> >
> > Please, for the subsystems / drivers where I'm the (co-)maintainer,
> > please split on per driver / module basis.
> > I will pickup them preventively, since it will be anyway run-time
> > bisectability breakage.
>=20
> However, having two messages slightly better than none from user prospect=
ive...
>=20

I only have this diffstat showing your name.

 drivers/platform/mellanox/mlxreg-hotplug.c | 5 +----
 drivers/platform/x86/intel_bxtwc_tmu.c     | 5 +----
 drivers/platform/x86/intel_int0002_vgpio.c | 4 +---
 drivers/platform/x86/intel_pmc_ipc.c       | 4 +---

You want a patch per line above?

