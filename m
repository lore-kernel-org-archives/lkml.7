Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1737DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5536206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDIaWj34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfKNL5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:57:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33292 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfKNL5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:57:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id w9so6170142wrr.0;
        Thu, 14 Nov 2019 03:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frQGlUTn9Jq9ZLUZoAjrFv3oqqQ1jMEbiU+EAO+xP6I=;
        b=aDIaWj34ygBQSSDWD5hQ9YpeVuWwZNH7CdHj9hBxJNl/T3QsG5XMZnJ0ryTQLKBrgo
         T13NYcReq6SkR/TjqUQrkSt2mGgvIU19vsvZZ8h9pI7khqTqo+3FToFrTrnMg6JK/Fwo
         IDBmUPEOzM5i8rBf261yvgxU//JjXAGI/1H4f4OJfteBYGC2rB60afLcLb+aNlIdp3IW
         FyeB6WVrZ0dqj9vSlYhw1vrlqhMQT4f7ggcX4a1jZhOE3PLHg/b7KMvOdCIASvSKCtCU
         XWneEb8h7RK60e82NFSCykCmfWmKkK30D9+Tmw0V5k+3MdUBIA6SIU7CNs0Xe9rGCkxK
         NDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frQGlUTn9Jq9ZLUZoAjrFv3oqqQ1jMEbiU+EAO+xP6I=;
        b=ayJk1pbJYorirAl99TkXTMh5S4airRNQWDTSZjWzRzEDBVDXXCVWWUOAUrn5ih/cJN
         5KN3DjvviaiaxxmpNmFeK2ANtXItt/vpOsBEI2v+IG2QLqEqVDVz0ExWFXjf4wgymt7Q
         pdoLSTpTkVaWyfPZp8z1anoLREWmLwgH4rE21+59yWbeLMYrbFE2pXEZvbbttMm3JUrT
         fzIOcsijPP8lXSqHRxnBwdCIILmznLys21C3XsrdtlegUprInohW6rUsBy+MSBHJaMJJ
         NCgbggmSpJlkHuNJWPX2PZVskyTHM7okeKXZxO0Lp/Aff/HTuES062UkFHGGmmOjmBkJ
         I5Fg==
X-Gm-Message-State: APjAAAXvVd06LLetqwipvIdyWTc3KjpacHvxcI3cwr2ogJHUhCnX/hwT
        jxMSftvlj/jYHy8FoobgCzs=
X-Google-Smtp-Source: APXvYqykuKrXCa6AZEj4dLtCbHRAgkUmLXX8ndKH3RBW3BwO5DxC/ywlyh72ZRj8FfmZbTgRIxaHsg==
X-Received: by 2002:adf:a3d5:: with SMTP id m21mr7532379wrb.386.1573732629596;
        Thu, 14 Nov 2019 03:57:09 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id i13sm6602719wrp.12.2019.11.14.03.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:57:08 -0800 (PST)
Date:   Thu, 14 Nov 2019 12:56:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: tegra: divider: Check UART's divider enable-bit
 state on rate's recalculation
Message-ID: <20191114115656.GC5690@aiwendil>
References: <20191030004813.9187-1-digetx@gmail.com>
 <20191113230303.726AE206E3@mail.kernel.org>
 <02df00b3-5e23-441f-b2d5-b84fdb411e98@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <02df00b3-5e23-441f-b2d5-b84fdb411e98@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 02:29:51PM +0300, Dmitry Osipenko wrote:
> 14.11.2019 02:03, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Dmitry Osipenko (2019-10-29 17:48:13)
> >> UART clock is divided using divisor values from DLM/DLL registers when
> >> enable-bit is unset in clk register and clk's divider configuration is=
n't
> >> taken onto account in this case. This doesn't cause any problems, but
> >> let's add a check for the divider's enable-bit state, for consistency.
> >>
> >> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >=20
> > Is this going to be picked up or should I just apply atop the tegra PR?
>=20
> Looks like this patch missed the Tegra's PR by accident.
>=20
> Stephen, I assume it will be easier if you could apply this patch atop.
> The patch doesn't have any dependencies on any other patches, so it's
> fine to apply it separately. Thanks in advance!
>=20
> Thierry, please let us know if you have any objections.

It's not so much that I missed to pick this up. It's just that it didn't
make it in time. This was posted just a couple of days before v5.4-rc6
and I had already finalized the branches at that point. Given that this
doesn't fix any actual issues it didn't seem worth to force it in at
that point.

That said, I don't have any objections if Stephen wants to pick this up
on top of the pull requests.

Thierry

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3NQQgACgkQ3SOs138+
s6GN+RAAlZUaaL6lrEOCJlwJGKgjjrETnZko9J+MhX2AI2fHkqzpUYdYvN2/w9Sq
RhMHSQfYTNuZ1fXleTQ1UhiINXS5WpRuBMWadA/Sb+3A6PZ92YQ+8/GH5I1uAxG4
is5Fqgbg0TwOIxNNMP/j8Sh1wvKIfx0lrlKA8+sM7tKTCuH1rVgJ+WYHdLzJib/n
Gnnickw+pryCvL83/2ZiQpxHd4gu5yZlw9uwa5rMRGaPRsbk+VVarMGonYMauMV5
hrNkVw+Q4YesuQvXy2edLaZQtpZ509uDf6vaq4QVvdwF58SRrgEUqqp0N1Xydh0s
DxbNK641Z+0Pk7RmgYyQl03QxoYGprEMXv+R50XDcJQ+vqpuX74Lw+vb/4LSexBf
KteBcilGVv8oyfL3JndvePNqGf/gWiJDZktr+193EJN5NqoSc34ajFf2DFyhwevf
a0VWFMBYePxJZ/XzZeVaBfHLzqTlIxIxiTqbdlLdb7rag9pXMMIAuaENH7kPzcne
+UNX40y6k7VMkL3eXXDoGpIeQvuvcO/HX3SREe+x5g5CuZtHIEG4uyGuYB316cIt
aVajRoQFWbuB40wo2L1+UsVYpUVQlZU3GxsB2L36U4rqjLgiKxai8Olp8zlTwjEv
qZFNjfUhtnSlbzsHq4hGlj+5V35tUnsivI/L/XByshtrYKrJF9Y=
=VQeb
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
