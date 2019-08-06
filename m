Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA81C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950C020C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 15:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SBHVFkT0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbfHFPBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:01:03 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40928 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733097AbfHFPBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 11:01:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so41647182pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=Eb02brmqmP+bKn8o/CtSlhtLL2DjYzWXI1dJoOmHVws=;
        b=SBHVFkT04CnXj2BzqKjwe15XXW+whxMdICKRznLSFSSDLqu/XcqTiMcL3OlDamrzbi
         wrXD0KtHM3gbNfHtiHorbQ5EXVuXky4q/SuT1jGnUelEQECP0tNPHCuRwvIdol8jaCln
         ZLdL3bwpiool6mLFTfz5u4UHCWCPxVGbsYG60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=Eb02brmqmP+bKn8o/CtSlhtLL2DjYzWXI1dJoOmHVws=;
        b=kqu+14PI7vjUrfFEaHVW2e5tsb/o30au90wvbp7TTcQ91NyK0Xa371nXLtyvqVFTNZ
         HpY2wSser4ijS1TewXlmv1S9Rod9/TRl/7dwXVzJwunQOuEnGQNDqqfariSCxfdT4Of1
         01Z4qzt7siIrhP+Zhgg1Tyq5Cw3IKo+Hw3+d0feOy4wi9hkymQe3kqt8vKIL08KkLiL9
         G/9vt9muF0QNwelnbBlZBF70saJX7sJS6LtdOiJJZP9tmDuo3Hqv5tMXytxa2eyGJURQ
         qyeERuBoPsvicv6O3TAfbC7NEKmhS/eOXEoLioU+1MB30R9IZafd7nnF2ErMtplbi15d
         Z0Ng==
X-Gm-Message-State: APjAAAXPjGtWoJluyL9MVdVW02r9pjmOo68sDU38pRs1Sq7cHZmxTYNi
        EPhls1qsxXAYbBhV7aSJF5QfNiiHfSA=
X-Google-Smtp-Source: APXvYqwDRt60hsXVQabJLS4rgQ72yXCj7Ne3Ts2ec9WePAq9tfC3jtA2eAeI3eEjWxFyxqb4+7eRyg==
X-Received: by 2002:a63:2004:: with SMTP id g4mr3265246pgg.97.1565103662068;
        Tue, 06 Aug 2019 08:01:02 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o14sm18400492pjp.19.2019.08.06.08.01.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 08:01:01 -0700 (PDT)
Message-ID: <5d49962d.1c69fb81.6e0a5.148a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190805233241.220521-1-swboyd@chromium.org>
References: <20190805233241.220521-1-swboyd@chromium.org>
Subject: Re: [PATCH v3] hwrng: core: Freeze khwrng thread during suspend
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
User-Agent: alot/0.8.1
Date:   Tue, 06 Aug 2019 08:01:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2019-08-05 16:32:41)
> The hwrng_fill() function can run while devices are suspending and
> resuming. If the hwrng is behind a bus such as i2c or SPI and that bus
> is suspended, the hwrng may hang the bus while attempting to add some
> randomness. It's been observed on ChromeOS devices with suspend-to-idle
> (s2idle) and an i2c based hwrng that this kthread may run and ask the
> hwrng device for randomness before the i2c bus has been resumed.
>=20
> Let's make this kthread freezable so that we don't try to touch the
> hwrng during suspend/resume. This ensures that we can't cause the hwrng
> backing driver to get into a bad state because the device is guaranteed
> to be resumed before the hwrng kthread is thawed.
>=20
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---

Sorry, forgot to add

Fixes: be4000bc4644 ("hwrng: create filler thread")

