Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A330C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86962190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wvl4GBEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbfGXSXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:23:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38251 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfGXSXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:23:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id f5so12806800pgu.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=/UTQACYWihs+D96UuX0GSdpYwsPs5H8hc15Sw9zwTZk=;
        b=Wvl4GBEqyyXdTe4u0bb1ApAIBbHmw53V4/SCd/PG9Hdm2RRbDxwGy/KcZW2mMIdi5a
         tpVV3GgCiX2Vy9+6tZqQYkL4DQVKkJdpNQZitry9DyjVa79VYejx92ybrBYjGgO0pCgA
         UBE74+Xcccczump72mYfNZ9Oh7H8HMvmSagws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=/UTQACYWihs+D96UuX0GSdpYwsPs5H8hc15Sw9zwTZk=;
        b=YKDt9maURG7IABpMerjfJs3jj4NEvBjgwaThQkUmDYK9WBY9q/ZyWWEjFskOnnmJrI
         KrAywngNWYpK12iRHxnDgZaN6ALeirNh3qW37ckLYoHESOcbKV//ARWg6r+d/Y9BH66R
         0uVZQyGf8aEQ9qmzl0K6cfXIylt1z2y9EHsG2sCWWhmyBbo/A8mchDTCH/iXm8olQ/wW
         Qyf5tC3YH4EtDf5N50QZZSsklQ/ERC9wv5YaFBf+l4Oc/iu+WXPAuVr0OeJn+eE2+5kf
         24PSMQ+KK7oIDA3RvMEBxJn0R7ldFpMjZK/8pvbLsFAHrnj1QbZcVlloWFL9/IDy6hs2
         0J6Q==
X-Gm-Message-State: APjAAAWCjk9FwlLQsOO12NXNFd16tLreVEh+KDsjAJASaj9XhXIBHPWp
        7XuyF/gqTpkJ7nHpNwmT1yXYnA==
X-Google-Smtp-Source: APXvYqxE7IY+6hLQMkntNC/0nJx+QAa8wu/tGuTS6Mzp5neZx5a6cta2lYffYGzN4+PvPsCRBu0miQ==
X-Received: by 2002:aa7:9516:: with SMTP id b22mr12525506pfp.106.1563992627374;
        Wed, 24 Jul 2019 11:23:47 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i3sm50422950pfo.138.2019.07.24.11.23.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:23:46 -0700 (PDT)
Message-ID: <5d38a232.1c69fb81.f85f4.67e3@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9b5d8470-dd6e-4358-141f-6b6c40774de1@web.de>
References: <20190723181624.203864-4-swboyd@chromium.org> <9b5d8470-dd6e-4358-141f-6b6c40774de1@web.de>
Subject: Re: [PATCH v4 3/3] coccinelle: Add script to check for platform_get_irq() excessive prints
To:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jul 2019 11:23:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Elfring (2019-07-24 06:18:35)
> > +@script:python depends on org@
> > +p1 << r.p1;
> > +@@
> > +
> > +cocci.print_main(p1)
>=20
> Will an additional message be helpful at this place?
>=20
>=20
> Will further software development considerations become more interesting
> also around a contribution like =E2=80=9CCoccinelle: Add a SmPL script for
> the reconsideration of redundant dev_err() calls=E2=80=9D?
> https://lore.kernel.org/lkml/2744a3fc-9e67-8113-1dd9-43669e06386a@web.de/
> https://lore.kernel.org/patchwork/patch/1095937/
> https://lkml.org/lkml/2019/7/1/145
> https://systeme.lip6.fr/pipermail/cocci/2019-July/006071.html
>=20

Did this patch ever get merged? It seems better to amend that patch
instead of introduce another one.

