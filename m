Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F5C04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BA121019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQVhsZXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbfEURor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:44:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37513 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfEURoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:44:46 -0400
Received: by mail-pg1-f194.google.com with SMTP id n27so6343856pgm.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 10:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=606JMBHU1WCSkVE8vEh8jp0Vn08O9hluQpv6YSChqEM=;
        b=bQVhsZXwJoS8kkAVFoHwkcLXby5dBYqyoeVKoiXPqgc7fmXn1bh8ym5oYjKC4HS7Tj
         9oCLmvze7JP4BG602rGkjb0Rp6P9Iw+/OkRoeJliB8fgxIRu1qINoBy3cwhjPL+63Tu/
         OU32v+ugrsYpgf4PkCeaVSWXM3XmJt0AC/wLyUKT6tv6vIUzy8XChksFv5QwqetG3l4l
         1t+jCnm+4R2NtxtdGjmnXXwDLUdqNqe6PXgjXqdvyUEcYZBIfbQBwf766rewrwLIWjl8
         b2dhZIJupbfBiYO3AqNNhhnTt8ST4hsQFVj3FO9ObC778Rd86z74h0x9191+G6uv3xka
         uiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=606JMBHU1WCSkVE8vEh8jp0Vn08O9hluQpv6YSChqEM=;
        b=Lx5fJcU+hVJQyCIKcNyrz5uvlam+yFEQ9lXVIH5APSKjFF+eqJmRoKosFaj08HLpKd
         4C4w9W249BW7U/RgMQfxt017dyZdCP4WNdttCnjwDhYe5q+u1Cd7kmINEUJetbydFbM+
         BrPIBill+5LGPy+NixOP0I5PEkryjSjX6quJNRP4d6MeX9IZ1EsqfltjnTrWutYnTGn7
         bdLUKakGD3HapNRhL78prBz8E99D+wCPMP30ZSGqmIpCrP3NGUDDwfsfCzhhszDlHQCp
         BilG5r1IS9R3Fthd/5Pg3jxAIzZ7+BfWYrwvnaGaK4PEBnT+NuAcOiXHM97nudErXZu2
         rNbQ==
X-Gm-Message-State: APjAAAUQ2um/47yZ+Ovx3MmwgSrngJqHuhehxogkXb+ryGRucggYGOGA
        b4w1GD+HPo7VB3iW+vWrGOmpwg==
X-Google-Smtp-Source: APXvYqx9jmSTOfoHKfChiJWP6QeuV7uyrYxH5QrdJfyQeoHf+pjwRhSwqdCXVT6bvmqUA2iagFvxog==
X-Received: by 2002:a63:5166:: with SMTP id r38mr12376011pgl.429.1558460684705;
        Tue, 21 May 2019 10:44:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id r77sm29853892pgr.93.2019.05.21.10.44.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 10:44:43 -0700 (PDT)
Date:   Tue, 21 May 2019 10:44:38 -0700
From:   Benson Leung <bleung@google.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Takashi Iwai <tiwai@suse.com>, linux-iio@vger.kernel.org,
        alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/30] Update cros_ec_commands.h
Message-ID: <20190521174438.GA2821@google.com>
References: <20190509211353.213194-1-gwendal@chromium.org>
 <CAPUE2ut4OUhrmbx6n8KCj7+ghXmC9iMnxGN8DMvyvZstznwwng@mail.gmail.com>
 <20190518063949.GY4319@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <20190518063949.GY4319@dell>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Sat, May 18, 2019 at 07:39:49AM +0100, Lee Jones wrote:
> On Fri, 17 May 2019, Gwendal Grignou wrote:
>=20
> > Lee,
> >=20
> > I verified and merged the changes on the kernels (3.18, 4.4 and 4.14)
> > used on chromebook using a squashed version of these patches.
> > (crrev.com/c/1583322, crrev.com/c/1583385, crrev.com/c/1583321
> > respectively)
> > Please let me know if you have any questions.
>=20
> Is no one else from Chromium going to review?
>=20
> These seem like quite important changes.
>=20

I've gone ahead and acked the whole series. Enric and I are OK with this go=
ing
in for 5.3, and as Gwendal mentioned, he's landed these changes into our
production kernels for Chrome OS as well, so this is what we want to sync o=
n.

Let me know if you have any other concerns.

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXOQ5BgAKCRBzbaomhzOw
wt8HAP9uU1klLrzkR34L7NbfgwEDQgELzBnyp0zr6eH8FswIUwEAhSZ8hXpksiuJ
cuKw4zj4F0wocqqx1xPt59u73qeMXgM=
=Zm0H
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
