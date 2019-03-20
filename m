Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70A721841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESpCP5DH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfCTIoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:44:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45149 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfCTIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:44:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so1701898wra.12;
        Wed, 20 Mar 2019 01:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k3YJ7Fnl1gotfoSogyLH+LoBCfJbxA5BhnTx+Ck6Vbw=;
        b=ESpCP5DHA+xGXrd0HAuDzmKxzNWNX+VFpLohlqIrCR0c7opySvkNb7Iq9r2pP8zk5+
         rBMHBr6aC3BA69ycbWqFZc6aNHiB9qfnYeT1PBBGNcV+8dSsRs4T+q84G2y/CvG1mz3J
         crQKZg24Mhhzn8tbpQCt1sTdwzZH5vd7xRsFeRWJiYttJMsyJYEfKOk2QS8el4JnHxpf
         slu3X5DY7XJ/IYMHkHHvDhqUfUxTswIY4Fk5HOrX8BYc5UHy7UNNhn1FFatEH2W9zXCk
         EB+GgQVUlvfEHizX1JfaSI0/6bU4zyFpFQDmrq8xqf3P34B/xleJIeppYySCsAw/QsgX
         wUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3YJ7Fnl1gotfoSogyLH+LoBCfJbxA5BhnTx+Ck6Vbw=;
        b=dNALIDNcXOaFbdtjpZYmN3/z8J77pBkPnFaGi3EMIfaT18NHvYO81fary5U5PRQjPz
         OktdhP8CnKc+Pb+lg34be8Nq4XjgWXVZRQcJZ5tjs9fFDYKsEDUB4H+pEorSvqpalT0A
         b4msqAynajQD10l6kJuYiSvQJ+c1a/1swYZexQqKYIlEWfIKY3kUX7WzFmpdpLSRGlj1
         WVSqwPcJlNXlWWb/0uY/i98juB2zNGZBnvHNdVgtEfQmihupRXqNJJQLz86tEF3AulNk
         S/NTB7his7kWJ4eOKB/7cPsCaLBxHvEWL1+Wa7tQktoTwv18QHLEPz3i5cVwfzqlCB8I
         HbYw==
X-Gm-Message-State: APjAAAWjqmLwAMFQLKmGPNIlvv+avuuZDGy0C8uIn9wggKpRS8TRVzCf
        pPV7p8rlk2erPGSQa7okp/I=
X-Google-Smtp-Source: APXvYqzDGaaQpQgseeDXuNMmMCT+ovFlHABqfhy2hi0tDU5tUADACJN2LEXhegQ58QFwwuVYWWxTfg==
X-Received: by 2002:adf:d84d:: with SMTP id k13mr22838745wrl.154.1553071444561;
        Wed, 20 Mar 2019 01:44:04 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id r12sm2017564wrr.71.2019.03.20.01.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 01:44:03 -0700 (PDT)
Date:   Wed, 20 Mar 2019 09:44:02 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, sboyd@kernel.org, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH -next] clk: tegra: Make tegra_clk_super_mux_ops static
Message-ID: <20190320084402.GC6043@ulmo>
References: <20190319153504.23072-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline
In-Reply-To: <20190319153504.23072-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 11:35:04PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>=20
> Fix sparse warning:
>=20
> drivers/clk/tegra/clk-super.c:124:22:
>  warning: symbol 'tegra_clk_super_mux_ops' was not declared. Should it be=
 static?
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/clk/tegra/clk-super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyR/VIACgkQ3SOs138+
s6EQjxAAoaL/KeouycZmBXVUKnEMaYJ6vzftGYyTCO2OJ5T/A3BMGxpJE9o1X+Sm
0nvDonljrcoyVwP96Rrn6sMQaoOZd2tsM92U1T9nb0yBWD001TfDgjL02U9nVvf1
DLNodMHtX3SDeDJJLWi7tAd05XekdXwjiZpg3JgEkYjUVXX0HHRdpZsJTlJT7JmS
U+OnsXZugvo6OsviDkAxQd1JkYahukNVn7JgYunNf47zkodkhjD7oZflnJqkozgB
1Vz9zHgKdlQlYd9YigLMwQ+VX1/VcBnOVyxT0ACk4pGqw6+l0Y6q8tu5AB6AXQWK
xGRZSuedIQsQdondYAjXr1KhOEl2ZyHjD/fOWFrbXOhwTPrJI2KyZlF6UgDC0Lvm
rBVBYfx2x8mgemFb7Ne09wx3rGBodJD6UqoV/QfrytFxfCzy/aoC6L7tQbDuN+Vq
OUKSCBESPtzx1jJRVUVRMfov3/6nb0+qBbuE0ZtFW1ZcYBalJjCjzrW1AensY2fg
NRdqF2zZhcL7A0G4ABXAyr5xgmYgm2HoSTrqPir46UTP1SXZAxKaGL8/RBog+C2E
TsZ+nkeMn/D2aDBT5fR2QfKm2J6CulMCuiybP8nG+8JLnA4WjmkfLFhDas8GEn6q
1Wa5Z8AGdUukXTrRbAOgCGJg504URghNTlaTZrPpsWg4xq6XmNQ=
=EN85
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--
