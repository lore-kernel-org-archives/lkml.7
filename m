Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8266E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 10:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8GEBE5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCDKml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 05:42:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33916 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbfCDKml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 05:42:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id f14so4965647wrg.1;
        Mon, 04 Mar 2019 02:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6l3fENbuaQQuHhXWPlZNSkO8uTEpItPPWp54fhsPW4c=;
        b=H8GEBE5BGyyMgDyomdcZkVuR66YhwDwqrVjhZI9CAgBXZ5cPY6xew3LtSD6EW37Hdm
         WRiizr61QBIcTX6n+al799sDHEhgRJXFeQzqHrPHcCgkRLc9I6fMQ737uPQUfbjp0Koe
         g32ULIgFCEN4RcunHLPUp/RIM5F2os0kwuzPKs/2vz+5w5Agw05f/Ek3vjgPI/uJa5K+
         VjJZG7v04JVw/WEDTlD7ugy026UoumPQ03ZOcfCUl5qFZAIQHVLKvLKV/VPeVZAWJ5it
         8ZsZd+TnqOmsXQAn+cmOiiy0yBgMtPzEKOVfAaEmTNLuOSnEUEqCx+V5vGRA7hSTe4r6
         5cfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6l3fENbuaQQuHhXWPlZNSkO8uTEpItPPWp54fhsPW4c=;
        b=Shz7Mgn1R2SHXpFOw77YFsNE8+VC1lRCuQZA3+EXHxBXu0CO8ajBkRlFqujZTiK7cn
         UuEWOXSmMbz05cC5MNuH0nKzZoT+K4OaQYZfb+yMFxvKw7y/tKQz3gIzSEVNgRd/mkLk
         pggBN+bgQ7ok0/YI8uPWtTQip8tUVWg28F+aF7D74EEb9kz8wUzrNJeSEWIL3bMiY9wi
         ng6WU0q4bNzLX3++Lj1qZe0fNMDl1WfMVCKcxcyyRww9CVzhdxmjR0k9YJ6M5Z0USdHq
         kE/iPB3gYsdISHGfj6RZUgJCgu0PAwkm60jPLdA2TFp/X3Hkc+ZeeiMAtqIQJyVhIc3N
         N1fA==
X-Gm-Message-State: APjAAAXZom3jPMrMO2x2vbkiIaKe/Vuk6zk3w7ADNNfeLPRS7V6EnNIX
        5k5ul/IWxoH9RsHjWnTEFZU=
X-Google-Smtp-Source: APXvYqxvvtEaoURVXdELA0byFOfOQWIgLpfIQLocBusxJo9kE8QKvexX7GHejQUr/P1FVnfte6XteA==
X-Received: by 2002:a5d:6983:: with SMTP id g3mr12585950wru.286.1551696158790;
        Mon, 04 Mar 2019 02:42:38 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id j5sm6275993wrw.59.2019.03.04.02.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 02:42:37 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:42:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Mathieu Othacehe <m.othacehe@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] pwm: hibvt: Use individual struct per of-data.
Message-ID: <20190304104234.GA13010@ulmo>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20190219095808.12059-1-m.othacehe@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 19, 2019 at 10:58:06AM +0100, Mathieu Othacehe wrote:
> Split pwm-soc array in one struct per soc and point to the
> corresponding on in of-data.
>=20
> Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
> ---
>  drivers/pwm/pwm-hibvt.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Applied all three patches and, while applying, fixed up the commit
message and comment for patch 3/3 as pointed out by Uwe.

Thanks,
Thierry

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlx9AQYACgkQ3SOs138+
s6FXTw//XF51RJpnxjSFdJWD79GQqIIDaW0P0HjH0beD50Iy8BJjRwSN3jkV3bRU
knxzHzyiZwxHzqwUcbCZ942hsFOFbt1q88Ho4PA2X0tHhrCjsQtT5RV+wEC1vfl4
lvB7/cuu8b5zd1HleUaymdDd8CNih0AezUPzyucqybW23AlfXwJWt13BJLz4Jhxo
kEze3yV6bAohB+hGWHVabuLjdOD1B/FTnzRl8iQRPejJoMWxjomPoB4k/+9zEqYk
LIFyzO4hPBOEsFd6dbnQ9Ckif1GIz2O657HDpUC+vqcUT3XXfA1C/ieldLRcIonE
SmpMfM5d3/9Jn1uKi1P8gwyJevRqXkSIuFtSsDGGqmCrWUMjCQsf9gGLykAYi3sn
8sO3apKA8xyGoaQPwXXJwPCuewehvEhZWq94DjNd+5Szyc2n7a8Rv06z/IvW+7ol
br7DQoXqAA0klVXBJmWqN5baD/ZWM9fHPqIM7poPnbpqWnrPwyAbkQC+QlVbTbDC
L4yrj7gWQBJPswqPPzXVP5IagKpp+HtZglukz0p5dnIjqOYQvIRE8kDQRtkYVFoi
FrfR/L/BYLZv741OH8ZJDAkA/sQtF3TNC4F3Rubq3nxsIh4JRdl1G6qvGYzXQT4P
fNlCbyZX8olS4A7k6nQWtquHd6O6ov9gpxq/cQ06ZURCXPGD0rw=
=mMfv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
