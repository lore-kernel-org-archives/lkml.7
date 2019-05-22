Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2757C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8758721479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFLUSAWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfEVNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:31:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44863 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEVNbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:31:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so2302331wru.11;
        Wed, 22 May 2019 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rEQ/WnhMwqs5C4c6PNMxERwhskU5orLfEryB3qcbjT4=;
        b=UFLUSAWqWg6daJ35xCkWVB1vcmbh+fLJR4+rjP61tfhaZiDH6ExobqSUzYqfojfgMd
         I1HnTNy/at6hbdqfhznA6ih87UsHZT67HNzJGXO4KpQRdZbYg68O+N58zJTJOpfdzkhe
         liyovf2olmqMQiowIiM/9OnbO8Ka3QZ/xLHNl+Tyz4PNkA7Xg/5r8ZLbRgsgJqvLExIK
         yBZwSbCG2z49QJ+QJeYPm+A8Sz6RLEjp/IsxKBkT/enrnqJQ1+G9kysLol+2mLwOT0Ho
         twsKKoBHdl9BiMZE2zRUDYOtSoVvy1zPhz4Gwxjr2sAW/RjydnrcLzOwUF3DSGVU2Rny
         WMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rEQ/WnhMwqs5C4c6PNMxERwhskU5orLfEryB3qcbjT4=;
        b=unDChLsjX7Z4DHAkQPZqD5C1HiVmyoiNHqMl5QvNucZyc+DuXM/FnGN34J0w39kfrk
         T60my5+dp9n2Bhv/TXeOn+fULw2dXgLgfzQIb6Ju95ziV8LTmr9sW/uLt9uL0Uq2lcpP
         L6Rgv3gD3zh7bocxqdICEl/YiDHj0TDk8ErOu0bipb+yhE12zUuPDfWk43b3kt5ZQd0P
         ZK6fT58fb+wAjEhdCpgULNAZRgUnuvv5fimnfPhTFeVs6Knp3w7mqleVC4IQTyKukNQ8
         gEKkyN21LDbDKc1n8PrTK8deal2Wpdip4a5vz1QHMCoCwzL/HolDsja6QPqAtdEAELPo
         b/zA==
X-Gm-Message-State: APjAAAXfPWO8frvyEkVUxx0oREQIbh+lX4yboBY3Q8SvWpTakqxkQwUc
        dk2Qb/1ljMUC1aW7+99Chawg32j/BIc=
X-Google-Smtp-Source: APXvYqyMWVXknoIVnKr5MQRKeSiR1bI2J667ghT8FHG3wmRO53Pz7iC+u2miZM/T6CGi8hvSbLNbTg==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr2822832wrm.98.1558531890284;
        Wed, 22 May 2019 06:31:30 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id f65sm2941939wmg.45.2019.05.22.06.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 06:31:29 -0700 (PDT)
Date:   Wed, 22 May 2019 15:31:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, jckuo@nvidia.com, talho@nvidia.com,
        josephl@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 03/12] clk: tegra: save and restore PLLs state for
 system
Message-ID: <20190522133128.GN30938@ulmo>
References: <1558481483-22254-1-git-send-email-skomatineni@nvidia.com>
 <1558481483-22254-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Zl+NncWK+U5aSfTo"
Content-Disposition: inline
In-Reply-To: <1558481483-22254-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Zl+NncWK+U5aSfTo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2019 at 04:31:14PM -0700, Sowjanya Komatineni wrote:
> This patch has implementation of saving and restoring PLL's state to
> support system suspend and resume operations.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-divider.c |  19 ++++
>  drivers/clk/tegra/clk-pll-out.c |  25 +++++
>  drivers/clk/tegra/clk-pll.c     | 220 ++++++++++++++++++++++++++++++++++=
++----
>  drivers/clk/tegra/clk.h         |  14 +++
>  4 files changed, 258 insertions(+), 20 deletions(-)

When you resend the series, can you Cc Peter De Schrijver for the clock
patches. I'm slightly concerned about the size of these changes and I'm
not very familiar with the clock implementation so I'd like Peter to
have a look.

Thierry

--Zl+NncWK+U5aSfTo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlzlTzAACgkQ3SOs138+
s6HFTg//czVVMjqx7R0ccVr5szkBBSZtMFdt0+mg0S5Q9E7j0lAb2uWbw2lVQYFC
J55/4hi4gOcal5T94IbqwMNqVhfMn9QTZN7bezWBZm3nQ63IinacluOrwHQ/iRrZ
AhRiUczUKPmLh9SGpY6SdPVHH2R11w85PMmBT6PCUupVu6pIWgvJs/eEtxatCClc
n4lAFUQk8Xjln1KArNxPsmJzo6jeoqT5w9UxCocRcZoYYyfXh+xdfNvl/cuemKAe
O7+bkI6BYTXCLfxDojptl4xF6XZXNClWiYbZv2FVnd3MS6sTnKhMCnSox9XBrNPK
C3NFqKqtkiTuNyC18DVRAi6bcd7IZ78h1AvmdMK+E70KH8EITvdmeI+yrW6gNEmV
klvIEtEkmHr5eJg06w2bM0lV8BWoRW8xz0mlqs0ItYACC9Mo0Ea53ito5rGb7PjF
ZUrTAGQE7YfEJpDo/vzsa8m4NF9tzDo4ghplYpwdcC3k0RzLz5eOSVOD6QmTzlf6
CbUfxZx5yvfqX+Q+RVZkSlom97sjtsJ6K6wbNPc+NWqx73GTw2cU9KG0PbKWNl+i
MDgyU79e0mju+a8PEnJHzDTKO9cClkWwSR3FKXMHNF/kL2bL2ktv6Nvp0R6qEpYD
t4VvJ/VLJ0q2f5uEDBMfaAY29/nKDGnAwYApFzDqnDQpQ5XNs2c=
=NJoP
-----END PGP SIGNATURE-----

--Zl+NncWK+U5aSfTo--
