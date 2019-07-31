Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED53C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29828206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dehlSFC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388004AbfGaOwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:52:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38980 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387948AbfGaOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:52:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so28014646pfn.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 07:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:from:to:subject:user-agent:date;
        bh=+/qoGVl+L8+8r/LaPr/8YaHHYTkLEsuwwMR94e7XMnc=;
        b=dehlSFC+8ixLpBQZj/OSHzPFmNLuT+cEmypAz8kqyJWUEHq9j41URTM6XYpsRIAauW
         zm3wzV/VrEouwauN0UqBPNd/VCXVgHYJ+R66S/VB54L+K3jJSM7Xn9HOoW6Htu+iiT+F
         fnkz8Mb1jtTD/OWugr0oH2Tt+gIUU4Ux2V+hY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:from:to:subject
         :user-agent:date;
        bh=+/qoGVl+L8+8r/LaPr/8YaHHYTkLEsuwwMR94e7XMnc=;
        b=pgy7R4Gz9cJAmsjCx87L19eO51U7kRVCezu8MSZOcdkn54cSM79tq0mC5JrWXaCYW3
         iKaBt4Hky3ssMil2LGzSGlnGVMcKXmCmA3WV5Gs5qXhUtGo6tsm+wka6lWh8z7Tik4t+
         Ri2cHLEixTk8Snogx8fiNoAxn8bHO+1t5ksI/BoM1Lj6WUMxeAjJBnRo+S+GgHLRjVqK
         bqxIYkcAjLMh4gfr1I+jznH4p4LXJMkXU9nqX/8st0fW56u4C1dSsqj2qaHKEv53wb+9
         GbVj3ZfmH4MEJMewWsbMsrFK/3b5wYrrIoNAdaCXhgY10giif1VLqwwj0rUUqTbU8nuQ
         0bNA==
X-Gm-Message-State: APjAAAUdOT4tc+ipEnU3EOjn5sbWu4l5C0HSDWkc/WRWeyhiWubCciiw
        xWua4T7A/Dj8/QjtAGrCGbYJaw==
X-Google-Smtp-Source: APXvYqzCsh7/ZcPFRY6pZ2tJDtKM4I8pTwsiBWYKyBAO2azCW8VnYZIap/SQLPxETfTfJlIqon26aw==
X-Received: by 2002:a63:c013:: with SMTP id h19mr84283959pgg.108.1564584749553;
        Wed, 31 Jul 2019 07:52:29 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b14sm2948137pga.20.2019.07.31.07.52.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 07:52:28 -0700 (PDT)
Message-ID: <5d41ab2c.1c69fb81.6129.661f@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190731142645.GA1680@kunai>
References: <20190730053845.126834-1-swboyd@chromium.org> <20190731142645.GA1680@kunai>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        cocci@systeme.lip6.fr, Marek Szyprowski <m.szyprowski@samsung.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [Cocci] [PATCH v5 0/3] Add error message to platform_get_irq*()
User-Agent: alot/0.8.1
Date:   Wed, 31 Jul 2019 07:52:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2019-07-31 07:26:46)
> Hi Stephen,
>=20
> > There were some comments about adding an 'optional' platform_get_irq()
> > API in v4. This series doesn't include that, but I can add such an API
> > if it's required. I started to look into how it might work and got hung
> > up on what an optional IRQ means. I suppose it means that in DT there
> > isn't an 'interrupts' property in the device node, but in ACPI based
> > firmware I'm not sure what that would correspond to. Furthermore, the
> > return value is hard to comprehend. Do we return an error when an
> > optional irq can't be found? It doesn't seem safe to return 0 because
> > sometimes 0 is a valid IRQ. Do other errors in parsing the IRQ
> > constitute a failure when the IRQ is optional?
>=20
> Some time ago, I tried a series like yours and got stuck at this very
> point. I found drivers where using an interrupt was optional and
> platform_get_irq() returning a failure wasn't fatal. The drivers used
> PIO then or dropped some additional functionality. Some of them were
> very old.
>=20
> I didn't like the idea that platform_get_irq() will spit out errors for
> those drivers, yet I couldn't create a suitable cocci-script to convert
> drivers to use the *_optional callback where possible. So, I neither
> created the optional callback.
>=20
> I still have doubts of unneeded error messages popping up. Has this been
> discussed already? (Sorry, I missed the first iterations of this series)

Not heavily discussed, but it was mentioned in an earlier round. If
these drivers pop up, I think we can have another function like
platform_get_irq_probe() or platform_get_irq_nowarn() that doesn't print
an error message. Then we can convert the drivers that are poking around
for interrupts to use this new function instead. It isn't the same as a
platform_get_optional_irq() API because it returns an error when the irq
isn't there or we fail to parse something, but at least the error
message is gone.

