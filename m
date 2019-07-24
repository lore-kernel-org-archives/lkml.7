Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126FC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8209821841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 18:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qqasr8OY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfGXSRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 14:17:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfGXSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 14:17:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so22325539plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 11:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=64VEudo8O/wtH6l4p/XqXhB+pkLzJ9hf6Gzrj+C81S4=;
        b=Qqasr8OYtknXSmYcgeOfBomaYAOs40Q5Ji/pPOYAb/xkQlK3p9Gh8ZUGJjbEakX0jm
         g+ZZ6Yxbipzny57R8nL5nQc6QxHagLdlNyaQa8mgzJ2diBAvX+FItnpgFRw50+IdKjLn
         0ZN2vv+ALhyJy/kDcEn/nplL4ev46fxTMjuTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=64VEudo8O/wtH6l4p/XqXhB+pkLzJ9hf6Gzrj+C81S4=;
        b=fDLci2CNkXpx+ht2zNcjGm+moLO5rS6PgHQUiXiT0t9d24T1CMocQs7TxHXHW+tRTg
         UejfeyK1lKm/8+yUtxYyV4m94G57Ok4RCXUW0f+M6f+P7/Uw6N6WOSVsSkOy/3rhlg9D
         cOmH07mUeVlO10V/PM652m3p66LGC1VVLqfmNo4k2RY+6j8C+qQDlsBTWcQRrBg+0oQW
         ujydV53vZj+N6EGwF/WxoUmYT5eoFHFp8x94RViKPTx1sfcvvnbcodQ4LiZvKW0WvZ7k
         MD9SB366xA4XYYfOc3R7zDKAxfI5NGKieaGBROt03nxOPJEMf8dWLH3JNwzWMEGnHviC
         1mJg==
X-Gm-Message-State: APjAAAVhtcdkmG/p9IB36yLKha7NAkbFzUYQ7WRMSuVpgfvS/iDHz08F
        pUHJle+dXGDfETr3tMTuhyw6Vg==
X-Google-Smtp-Source: APXvYqxK0qMUscVeGe+4+IEh/oz8xs62peAkQnZxB09uo26n6J6UINiNUvD9t4Qbbh70TRdYbsyTkA==
X-Received: by 2002:a17:902:684:: with SMTP id 4mr87320935plh.138.1563992274074;
        Wed, 24 Jul 2019 11:17:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p15sm44575510pjf.27.2019.07.24.11.17.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 11:17:53 -0700 (PDT)
Message-ID: <5d38a0d1.1c69fb81.4e830.7802@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d12a32e6-fd82-71f8-c320-ea6e844db3f4@web.de>
References: <20190723181624.203864-2-swboyd@chromium.org> <d12a32e6-fd82-71f8-c320-ea6e844db3f4@web.de>
Subject: Re: [PATCH v4 1/3] driver core: platform: Add an error message to platform_get_irq*()
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 24 Jul 2019 11:17:52 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Elfring (2019-07-24 08:00:43)
> > Let's consolidate all these error messages into the API itself,
> > allowing us to get rid of the error messages in each driver.
>=20
> Such information from the commit descriptions sounds positive.
>=20
>=20
> > +++ b/drivers/base/platform.c
> =E2=80=A6
> > @@ -163,6 +158,22 @@ int platform_get_irq(struct platform_device *dev, =
unsigned int num)
> =E2=80=A6
> > +/**
> > + * platform_get_irq - get an IRQ for a device
> > + * @dev: platform device
> > + * @num: IRQ number index
> > + */
>=20
> Do you find the provided description for the programming interface
> really sufficient then?
> Would it be more helpful to indicate the existence of an appropriate erro=
r message
> also in this software documentation (besides the C source code)?
>=20

Sure. I'll add some more documentation in this patch too so that
developers can easily see that they shouldn't print an error message
themselves.

