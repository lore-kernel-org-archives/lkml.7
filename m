Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648E4C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326FD2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oh7gGm4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDKJdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:33:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34940 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfDKJdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:33:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so6401861wrp.2;
        Thu, 11 Apr 2019 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6chxqTQA0tMNzqAdAf+8Od+wwKgavbgPcOMaHBLDHFI=;
        b=oh7gGm4N9qZEisKWoHppa6HBu6mxFTTLM2nFKxkowSCHLeHT0CG8ipKy13/LKYFwko
         7pvPuHVe2XNXHfgAMwGpl8D+wdiPlD4yOirdDUS1rl7NpPWrwQg7yFYkDFWWzRwGEcZ4
         iWuirpAaU+uqqpEbEY0XcXcItTj0Y/IwLcTvyFGp2GeDQQ59GovJwRf1sK6aUs6XF+RA
         bEpg3a1bemYSCMWLf2UxxO3aYaA/6mQrgPsPnrDRPAeM3QgzwTNQBP5bP+ao6xYOupQY
         pcvjk4r+fTrhTVWMoQc8ypKGfQmwzT0AG4ljwZJxUHtfCjMSDPgok1Ht4st8J2twxIDQ
         aNzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6chxqTQA0tMNzqAdAf+8Od+wwKgavbgPcOMaHBLDHFI=;
        b=FGgP/xjQC3pUPaQfJQSU8VfiQP9OU9a2WODh/TuguzkMeTmq5EkfBiZkRRIiugFxJF
         dSqFR0aJ/8ZmxkFl7/JGUlrD4DvS6TAIwWj/lrQN9KwNawm4zFre24ld0aTmu9tHXjAe
         1RiyCBBaWn6VtQxVblVULyQKTQHDyJGJvjSGg5f6DB988tS36BAs8vq/5zlpZCtdS5Z5
         bfW4274VZbFhKXWoOBaKoQh/jOpBf5S/ZOgRGmJP33BzXAW4rTrl4oJ+3qIH2p7zR0sV
         9vZgFPF64C2CYwKkVmEcCbOT6q6LVlLWe+e9L56mtSP0EpbGzuYGgvcJ62DYKQ8yDTVa
         j1nA==
X-Gm-Message-State: APjAAAVLSeSbTdwD1v70GM31+iw5x2xB6tWkVG16Na9RBwBa+I3mHx3R
        6eR/m5ssXwtJNlQ9+mAriZ8=
X-Google-Smtp-Source: APXvYqwL1Vr4CowdXmpTZTniMokTR1dMdNbVm+P4PlUsnPzO43Z+xg0CXHRJkrny2Vt6m1gFEm8bVQ==
X-Received: by 2002:adf:eb89:: with SMTP id t9mr30098179wrn.109.1554975183444;
        Thu, 11 Apr 2019 02:33:03 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id y1sm108629493wrd.34.2019.04.11.02.33.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 02:33:02 -0700 (PDT)
Date:   Thu, 11 Apr 2019 11:33:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     jonathanh@nvidia.com, digetx@gmail.com, jroedel@suse.de,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH -next] memory: tegra: Make terga20_mc_reset_ops static
Message-ID: <20190411093301.GC4633@ulmo>
References: <20190410140450.31604-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20190410140450.31604-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 10:04:50PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warning:
>=20
> drivers/memory/tegra/tegra20.c:277:33: warning:
>  symbol 'terga20_mc_reset_ops' was not declared. Should it be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/memory/tegra/tegra20.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks. I noticed that you use a slightly different name in your
git author settings and your email setup. The only difference seems to
be a space between the first and last name, so you may want to look into
that to avoid having any inconsistencies.

Thierry

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyvCcsACgkQ3SOs138+
s6H3CxAAqu3KSq5VHxMoNXIIzmtxcijOO3c3p+9Lv1rYg6PrOWy1Pk9w8i76n4Bm
/GJn3cFbXh6w2fXd4ZovGYD//1RBjl4W4DIxn+3RFzGhV2VStkGRdm26IJqk7+A8
aizexYsa1pvboxmY9csoHl4nF2mCabO4MGVG9c3Y9Or+/K3wQXH6ivTxHi0m7y6Z
jHQCCz8mSgCiYQvG71vVQGY18N4UZuC/cSwPNTLdeq/8yydPKqD300WZSQkp27Ed
W9LLiqK4WCsRbzgkXkhv/7KBT2aqzD5T7OK18sMx9HOajkAqKarUzNJ19VPjG4t4
Hy+Q4L+iPJ3hHzx348BmPjb1/tVC/tHwKGQ4DRu68zaIo6dQEkmEXcYP1y3PJtBM
HrtLayZT1ISz6ynta3Im9UEErLZq4/W7NkEUMvTxPYrDIzQaAmCLtz3pRKYi1KsA
X0Dku5z1fQE2NnKQyNZ8/kqcuRfG4EIe9UtCV01Mafo1M16uO670lhoRdc83vYS5
5CJqEKYshH0DBMLfTaD21MNRtWbguGrdflw7/IF/fgDE4bz16zaFC/O01M+B3f+Q
z46XFks4O8wHGW4/Q+pZ9HRAcuI3oQtW+fm+5l08IcgKAn1FeD9lkQO9XnSCbRnK
qMswaMr5gRP+pmoQn01oBYo+fjS26sK3SS5jbN8OuX040ebSWi4=
=AsFa
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
