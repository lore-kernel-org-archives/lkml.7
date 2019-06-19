Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DE6C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D83F20823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 08:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9mKCg2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbfFSISr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 04:18:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35285 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfFSISr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 04:18:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so753479wml.0;
        Wed, 19 Jun 2019 01:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XDohhOV+pHdE7L4rZIwOI7ZdjdSqThUPjhIPOlnhiTY=;
        b=q9mKCg2NWSreGIcX3paMBNgkk4UoaxWs8fdt/S6cxY6PLvhy4k+4RcB+T/cjfOS9C9
         4l6RExhbKucn2V4r99KmkTfC3723hb4lSBgbZ2Ad0928VUQmMepPo5qddIK+k67Kydt7
         7n6YcndCjq4jJ/CjIpIMum+0fmSbt/2rhPhyzTWwIt4I0Tt+nU5+BtUl2/7pTePdWKPo
         NGlWtGOi6RsQ19R3C3ohRWbpG/7IRdLURzAPAln+ktPoAp1htMGZR8Rk/wHIGiFyKVay
         U1MuoQY3ZLlyU/5Qg0I+Ru5zdlNVV77Y4gA5iXM/rJ5XVwXFlvzrpe94G2gzIhszjVMX
         FWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XDohhOV+pHdE7L4rZIwOI7ZdjdSqThUPjhIPOlnhiTY=;
        b=uGxRgYqveAVdJC+o6d3PF4bjhCdB1vhTsNNcPQ0VqE+VxU0252mbuB43CvyFaRPbWx
         PWyzGBhubAD7pTfgGZ+gl71X+IgcfhUf1o3eUI/Bc+uy65bTg4Xsy7M1+ZlYd5DXny67
         1iYfwGeHXdw3ko3lEHZcCZDq7/QIE+U5xlRa3lbyd5Y5xSymGwsX0n0gURrnmFpXhaO9
         pui6JHP6QUoUIJfgwUsw1KVhDfU8zGxGfo+ajG07BqqvlT0MLdqKEz+EwB26LJwvC+5Q
         2/QzyXnGWglifsLL3RUrBPQOfVGqw/V1bqel77b54zvpakXRaTOgePEX141JxgFJk0LL
         F6+g==
X-Gm-Message-State: APjAAAUFb/XIFwK7M/l2HQb3SxjI5fw/wGa5tBQiW/OITcJ6nP3xpmtn
        v0A11y8tvHcEsVhlTh3zQqg=
X-Google-Smtp-Source: APXvYqx6jldkOW0flQM90MNNidGZ9HaRRRYLlP9Aybseee/qAH8EwHxaSrDQsNA3HA7GDqcbDv6HTg==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr7362743wmf.7.1560932325417;
        Wed, 19 Jun 2019 01:18:45 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id x16sm538719wmj.4.2019.06.19.01.18.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 01:18:44 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:18:43 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] clocksource/drivers/tegra: Add verbose definition
 for 1MHz constant
Message-ID: <20190619081843.GF3187@ulmo>
References: <20190618140358.13148-1-digetx@gmail.com>
 <20190618140358.13148-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bGR76rFJjkSxVeRa"
Content-Disposition: inline
In-Reply-To: <20190618140358.13148-6-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bGR76rFJjkSxVeRa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:03:55PM +0300, Dmitry Osipenko wrote:
> Convert all 1MHz literals to a verbose constant for better readability.
>=20
> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clocksource/timer-tegra.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--bGR76rFJjkSxVeRa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J7+MACgkQ3SOs138+
s6FqFg//XBsxZBdBq5VKGzKISCCijv/slktRW63Wk+BT0VyHln6IGOGJjo/jDQF+
541wBbCJktHkMNJkao/G6Aph5UmHp6Ok7OacodxJ21w7ir4rDwxubuHSOYjdz8Wt
iFXzuoWsW41b919r5KT5xWxxNrDBAvHiTxf71aRvmWvHVgbpqE/tGnbbQME87NtF
38YQBCktLJvTtg3muWQefd4aoRd0uI3qH7x4Py4Xh+Igs+L6Et1/ZudDbdZ5UiCO
/7T/YrHNuFwNUR6SROG0MAV7464JYOS9H4r2Ep97vsrK31fIR/u74zSYGwrKkizC
5ham8Q0Tx1IZ4esxA7nuQZOsoNXewurj/4rvuceaQZrt2hGxHaMSWosqxiDM2irc
k4akNV4W4E5Q5VsZRMFwNyJV2l7gibu4bTVdR0SD6sQ0MppwhrrWwKxQdL74cwFt
ojZZzqJle65nOGXq5973D62kPgggYWbkC+a4jSdmmshj92Le6DG88NYX4ACqxQNw
ftBUpMToJkG7NLkzfbij8aHQwo84HVi6Mqvm/rW7t0ZeLoLCycLeGZc0D7/G5SsZ
iXbiSTPm2Z96dPhWRNTB07rx1z1pxujLruDQGQ4oF5CngQXWtci2gHXooDLCGlWL
KoHHpqWwtA1NKXVmVM7GlDFqHdjVd5Phz+GSAXafvst9MsSjIk8=
=ULQO
-----END PGP SIGNATURE-----

--bGR76rFJjkSxVeRa--
