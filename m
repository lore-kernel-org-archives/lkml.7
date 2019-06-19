Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF024C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A7C2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhoiB4WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfFSITZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:19:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39051 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:19:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so2300844wrt.6;
        Wed, 19 Jun 2019 01:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7YoFXh1SKzUVoqeWemB28LJQhu4fSQVWGlc5kaxjqk=;
        b=uhoiB4WISm7cnAHZVjTtkxf28QkDNSnWYzIOH4TuQmjjGQTfEEG8t2RLpP5gR+hRXq
         TLlGQ8IY0CpdFnnwR29f3ZVNUwilevo1nlo4pADA1ADsPe9SNOyDGXFOrMtEZzFpm8rd
         jP7R78kPDYUMWjquZ0hB6utrtGtK42PNODrQxUgH/LhTu5VVh/9CsgyJQ6K0bDftmX6S
         zaicIQ8hjbiV9mVKJX2ciuqjmKSRGzw/vNK1WizAWKQU6VkRmiCBsbxCXPnETZgwEFx2
         MI7o1BIw85O84EXPk0pLbbsHYcaWgCBoXNdWYLKIuldjx5dwUyPAFIYNKd5PR7gJCctv
         5tVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7YoFXh1SKzUVoqeWemB28LJQhu4fSQVWGlc5kaxjqk=;
        b=rifty/lK6zvybEgxNyctX9Xot1O4LJmOE4n9Inaq0uM8pqInJ5W5LuHSSAmTtH67la
         fV+y5GPBiEQSMoS4sMm5HuZH/ICezTuuBNuRY2C++5IxyPtd/Nsm3oO5WbpGgT4RTh47
         rhkv89O3U6Z6OVpGOz88dgCJGqogEnU+Zd9zKzgbTLsKQnuSPsJqjvIGTJxZ5k1wZ2CV
         ctUlOgt9Cw0YJPktG94RxexG8x5vQCJpgwMkSoBAMc7xGOIQs/DU+E+/uATIl5b9UmYb
         w5FcxOvfxszspBVceRZ5sAuBYe6Ny5XilJB+wVGLtqp6vIwTEMNFVYjLruSdOVrEB0ND
         kxtw==
X-Gm-Message-State: APjAAAXyXmxuwz1QkAAs5FoDuDeICG+Fyvt1MmO48dgwEvKdx8kih6at
        DsEnFPuEgyHXSAMLlVKa390=
X-Google-Smtp-Source: APXvYqz0pT52tEUcfHZEaz4vcMQTlUIwMh/yoGLUdIJma7jANtGGX0ZNZM+mmDWwVNXz//QpuwYbJg==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr41286940wrs.2.1560932362281;
        Wed, 19 Jun 2019 01:19:22 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id y19sm844637wmc.21.2019.06.19.01.19.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:19:21 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:19:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/8] clocksource/drivers/tegra: Set up maximum-ticks
 limit properly
Message-ID: <20190619081920.GI3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-9-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:58PM +0300, Dmitry Osipenko wrote:
> Tegra's timer has 29 bits for the counter and for the "load" register
> which sets counter to a load-value. The counter's value is lower than
> the actual value by 1 because it starts to decrement after one tick,
> hence the maximum number of ticks that hardware can handle equals to
> 29 bits + 1.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J8AgACgkQ3SOs138+
s6EPEBAAn10gbUkVsBHDIrBFkwk3KyI/V6bofbaJQUM7laLFxcPxtchlHGg815Mf
fPIMSvscd6p0ASJwpG7FuIwHT0Wn16ZlwmKt+txnr96lne/hGy4TCG2U4ajG7uho
Oz4aRFpahRRB7yW9jBb4kfr7AKNAMFDeGEAcT8L+e1f7tfgpqT9+ZOImh6t9yfWs
xfeH0EYBDCwz4by5qz4TLJ575rgbFycX8GADCjA0VL2FIbnU3G9c34UsLIO6OMPn
EV5O+MGIjzfadAD0IdVkX1nURSYya1SvgCp167/dnzM6IBaBzQTfSJ8tMtEBCJJN
JockM2EqDiw8EytGKfWABIgCyKDwFT5gA2Ci4JTfr865Cufl5EwKJNpxQ52jyJoF
ZX3vnvsDx7pkiusralho+1HsP4J6D9fqULD6NmNNN7yzGHvMNt3o48B2MpHh3J5k
ygnXuxYMRKNP4kvBMhgXMDso+lWlt3iMfUysOvI0+RR7hQUCYujEJCDkNp19awf/
OtV5+xplrPqCqknrJ6t5hsSPqaX6Z2IJ7FCesK6XY9K0YywqzVwe/+HH0ktsRN6I
9O7r2P5yyBDtz0TGn8XkQoZ7BbtqUY629/xyF4vfYdpiUtMX3hmrh2Zbz+HEM7rY
ONbzVV/EJj40JmRJi4glPLIC2T2yEe3QqD1PqiQxREm4kBIpwEU=
=4r44
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
