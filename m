Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F23C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2F822387
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 22:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RcdbOXyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfGWWY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 18:24:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35182 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729617AbfGWWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:24:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id w24so21150564plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 15:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=x9OpYleRntUaHxSfhcj52OHNmH6BLBDkmaW+Lv5uD5c=;
        b=RcdbOXyU0ZK3AX9x6aeatipyU2M/+Mjr/0xvpE/vy1iDNuo5rIR7vFUxZFzAwUe8Df
         X1pphTzHcQonYP9Vx11jY7RLxkEzC9ZUcxw8ZNCuB8Y1IbhEXwcT6xvU0ku5H1AgM69J
         xaECHEFbK2Ycqqg2eT8unHKci/RKo/sOxsDKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=x9OpYleRntUaHxSfhcj52OHNmH6BLBDkmaW+Lv5uD5c=;
        b=UGAOTrglqFXuPnLx3IZ+srpc/bGti8wt7vd5VARezJ8b8TJb+aqn5N+EvixUy7SeXh
         oxo9kHo1U1lUsvJYRZjRLJQoHGzpYMIZ+o1EqNp0A0vSxy2PnUc9vKhO6dxfXm9+Tleq
         iFUbYqiYIR5HRzwyZ/+GXEwZQex3FvrURoVPFMZXg5BmC0/RH8SUmHTFmTfuTE8wcJl6
         nMFlkVOgfbGEkunUySovZAc7IpHI7WkMw3cUdU9gd8cyq9YegZ+iCBf3/yfrpK3llVl/
         9NCeTpcU+iyUc9O+WF5wCp+Gv6IwCugzj+blsFts+hMPw9MhkPL05kXrQuFnf201A73W
         7DbQ==
X-Gm-Message-State: APjAAAXaMweO71MVf2/2a5LPHeBBE3yAoM6hG+0WCYI7aJK1fInx5HYZ
        pV9s91aMvuuigsIwWKi8vSKHBA==
X-Google-Smtp-Source: APXvYqytRvhn5XjfBP9p7cSY4JzQXSkKOnlLWMvNeL1LUfuhByvkDyBTpzF8k8rdkJ0Sk9svLOGnsw==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr86656114plp.59.1563920694907;
        Tue, 23 Jul 2019 15:24:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b26sm48563520pfo.129.2019.07.23.15.24.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 15:24:54 -0700 (PDT)
Message-ID: <5d378936.1c69fb81.2ee3b.0089@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqKMmQdvQmybXbGf_CZkvd1TTeMBPyk3uEUOK9Vz1+9PNg@mail.gmail.com>
References: <20190723181624.203864-1-swboyd@chromium.org> <20190723181624.203864-3-swboyd@chromium.org> <CAL_JsqKMmQdvQmybXbGf_CZkvd1TTeMBPyk3uEUOK9Vz1+9PNg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] treewide: Remove dev_err() usage after platform_get_irq()
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Tue, 23 Jul 2019 15:24:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-07-23 12:30:48)
> On Tue, Jul 23, 2019 at 12:16 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We don't need dev_err() messages when platform_get_irq() fails now that
> > platform_get_irq() prints an error message itself when something goes
> > wrong. Let's remove these prints with a simple semantic patch.
>=20
> Nice. Would be nice to see this for other commonly called functions in
> probe though we have deal with cases of failure being okay.
>=20
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
>=20
> What about cases of pr_err, pr_warn, etc.? And the subsystem specific
> prints like edac_printk and DRM_ERROR/DRM_DEV_ERROR.

I can add more variants to the script and maybe catch some more prints.
Is that what you're asking for?

>=20
> There's also some cases that the irq seems to be optional. They use
> dev_info, but will now have an error level print. That's fine with me,
> but some may complain...

Yeah I wonder if there should be a platform_get_irq_optional() API that
more explicitly indicates this and then doesn't print a warning when the
irq isn't there.

