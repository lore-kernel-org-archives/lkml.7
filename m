Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D9C0650F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A87B21726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mx+c4i+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbfHBXX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:23:29 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40333 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfHBXX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:23:28 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so36777612pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=2tknq8ha5U7BNuuyVatdtjPrjoFm8FVQiAPwO+BVgX8=;
        b=mx+c4i+C8tUW+7JDguP35xhR2WoEl5zaNtr74xW7KRFkkEMEawzKZqCutkcuVc6Y+i
         +c4QrhEPS7BAUe3/EsS72++dyo2Zq3xVYCWpZxxU2puKBjHe/IhblCWqnRK9EkwkmYX4
         dNw+cFrWsqbBEDEcSCwakZtYTsUhJudYq3FTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=2tknq8ha5U7BNuuyVatdtjPrjoFm8FVQiAPwO+BVgX8=;
        b=A0F1Dnn861xMW/Rm/E7oWP3OrrvxwR5A7i07Ldne6z147e2i1/ZWGe+izIvsTmPxgK
         /sQRoegrGhSKNdtUwmOginK0CQTnAwA1qxlMrZdJ6h+urBLZIYIFln5r8pi7xEW9tVuA
         ywd++fAd26XeVxeQf6bf58gP8t6n4cLvkH4xbEVwQ78V/FeLSivXG6N3FLwilMmc5au7
         elnvyisWM8b1dCIn6+m0r/qI1vHCZxIwm3bRoQKEWhHFxBKJoyMBKaeLDnKLRbjl46YY
         lo4TjMKCh/xC0+2OnngCJZXkdHBMjz3pnFbgUiR4R8LcmyFioHjIH9ogtf90Av5rqvGD
         rIwg==
X-Gm-Message-State: APjAAAXMMbKpJ5utZDPG6Rm4gsXsbS1PaPPhfquPKJghUNh2cg3JhoKl
        KORnLsTNhYYn6GqBDG/3YqVjpg==
X-Google-Smtp-Source: APXvYqxNh0B8Wf8ImRp8AspYzF98NGC9VpLKh9ipgxTx9XSVhtLvzsOHEkswTpvOyF0jVuId3lju4w==
X-Received: by 2002:a17:90a:bb94:: with SMTP id v20mr6693868pjr.88.1564787885862;
        Fri, 02 Aug 2019 16:18:05 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j16sm7485490pjz.31.2019.08.02.16.18.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 16:18:05 -0700 (PDT)
Message-ID: <5d44c4ad.1c69fb81.49b6c.56dd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190802202209.2jzeosacc66mtnpr@linux.intel.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-2-swboyd@chromium.org> <20190802202209.2jzeosacc66mtnpr@linux.intel.com>
Subject: Re: [PATCH v2 1/6] hwrng: core: Freeze khwrng thread during suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
User-Agent: alot/0.8.1
Date:   Fri, 02 Aug 2019 16:18:03 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jarkko Sakkinen (2019-08-02 13:22:09)
> On Tue, Jul 16, 2019 at 03:45:13PM -0700, Stephen Boyd wrote:
> > The hwrng_fill() function can run while devices are suspending and
> > resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> > is suspended, the hwrng may hang the bus while attempting to add some
> > randomness. It's been observed on ChromeOS devices with suspend-to-idle
> > (s2idle) and an i2c based hwrng that this kthread may run and ask the
> > hwrng device for randomness before the i2c bus has been resumed.
> >=20
> > Let's make this kthread freezable so that we don't try to touch the
> > hwrng during suspend/resume. This ensures that we can't cause the hwrng
> > backing driver to get into a bad state because the device is guaranteed
> > to be resumed before the hwrng kthread is thawed.
> >=20
> > Cc: Andrey Pronin <apronin@chromium.org>
> > Cc: Herbert Xu <herbert@gondor.apana.org.au>
> > Cc: Duncan Laurie <dlaurie@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>=20
> This does not need a fixes tag?
>=20

I'll add Fixes: be4000bc4644 ("hwrng: create filler thread")

