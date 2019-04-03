Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF855C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2420663
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUfGc5Ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDCQZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:25:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40386 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDCQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:25:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so9133907wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0EmDFsjig/DderCz7tcHoVUGWeQbNVjKjDEHTFmeGu8=;
        b=TUfGc5YsbzWWOZ6DuoiWIVZyKvTf4nmPxL2AVdeUSidr1fHJCleEsKiPX2mfFbtLJy
         eLWK0/r2HVgHvNR7Qlx9xHbAVkWe408JQ4rHm0erGjV07gYQy3FY9w1oOt13IctaJjDS
         uN908Utw80avnnK+fZEQ3xK0Q63fRWRwlMTPTblBBuxgBm9eYkIqJEHNnLawRxdCc7sO
         qSGi4li3uMIUWSPLanTuYS+eEOrVC3m36pSJyNwZ7pk6XvRux2ANPVPOWt6ZZgI/zL9L
         oy4aa8ivFQrw6XLhp94NIGOWPpPxT/hFuTGU/j5eOg1pRFzYAVNU/uY7BqIjU7Z2L+7t
         DNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0EmDFsjig/DderCz7tcHoVUGWeQbNVjKjDEHTFmeGu8=;
        b=iyF7AVbTZBLBfe7RIO2GLH4l20aVbBUwi3lvEeDZ/v67b0infUEuFrZhcgUUR1qxwB
         FzST071CA/qJ/4QC3K3/pi2/o7Idp2qR852r/OEWxoB2c/J8r1TzQW2qjaCV3CtmGzxS
         o6nWKn/FcapwOoOwoVxPxgWF2oRYIBLIw3CevzWk+tQgKmWkniEboJOrm09srTC8AYI0
         w6TZQHy377MtpHKSrzk6qp5vq06Czs57iQGXNwa96298mzGo7VEOsVuPmjUAFENr4CMF
         nYUVlzrFdrMVLEzN3Q+toIBfauw5kZ34//SzTsp1sCdXDxlFZHjPYcIEF9VAEYZKN7l1
         FZmA==
X-Gm-Message-State: APjAAAW4WlTQZMIcVcTftf4oaNseVoW182uqinZoOLwpD4wzjcHPFyuK
        +vcEBL7XN6Dtk1VEubbWoHYKv16y
X-Google-Smtp-Source: APXvYqzJpMfnOnRQt+lJ1jz3h9LibXdjYWQDX9FnzCtzh7x1Q2j+FpJzwZY91mOZ5fYBdjx94lO7dA==
X-Received: by 2002:a1c:f504:: with SMTP id t4mr535777wmh.121.1554308702105;
        Wed, 03 Apr 2019 09:25:02 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id z18sm27303729wrr.90.2019.04.03.09.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:25:01 -0700 (PDT)
Date:   Wed, 3 Apr 2019 18:25:00 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Yannick =?utf-8?Q?Fertr=C3=A9?= <yannick.fertre@st.com>
Cc:     Philippe Cornu <philippe.cornu@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] drm/panel: otm8009a: set clock to 29.70 Mhz
Message-ID: <20190403162500.GR5238@ulmo>
References: <1553155646-13636-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7L9kolmstoDTZ4pm"
Content-Disposition: inline
In-Reply-To: <1553155646-13636-1-git-send-email-yannick.fertre@st.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7L9kolmstoDTZ4pm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:07:26AM +0100, Yannick Fertr=C3=A9 wrote:
> The panel does not support clock frequency over 30.74 Mhz.
> The clock rate has been reduced to 29.70 Mhz & new timings have
> been computed to get a framerate of 50fps.
>=20
> Signed-off-by: Yannick Fertr=C3=A9 <yannick.fertre@st.com>
> ---
>  drivers/gpu/drm/panel/panel-orisetech-otm8009a.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Applied, thanks.

Thierry

--7L9kolmstoDTZ4pm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyk3lwACgkQ3SOs138+
s6HS3w/+PGEnfEQNvqWeX7xXAFBa/nqHjv+XF8knlt34CIIFX9qn72tht3EvJxL4
dnVqzsr8vh8sCvgUD+b9esNmOIy3U+qq4HgMwGgfvbSqPHEBUgt3nZzbAhlojLI7
DTfjaC+NtVKrDUQ0vm73+MT3vomcm6nNonIPmlBrAsSWVeubW3qsS2x7CS/6AMls
RPHEUTsv6DHCf3DttvfvDu3twm5t2tvIzbVjlVUimowlIqez65ykdS1vG2JGu1K3
KohzG0l5ALSQCK+zZOPxAkqdtakVLAj7swxJ3hXaXc+woMphQ8HI38k+29mA5wrO
r5g4qizHviGXoElqsty3R45jsXD/+370bUKpUsuaI0qrW9w2qQ8B3rwSZLe5MG4S
SnvaaeMj9Li74kqdJanPCoQxZrI5wCdfTIF9FEVzpQpJdupUae/jjIhxoBs2wl66
BvdiYtsDokBC5VHQBi1B6Pl5Br2zCnViN9mhj+7fa2239EAB50wJPJN9jeB6Rqb8
xRDAfnjc9UGrIkhQ2H4eo0UmMhZGu4jb2qKkwVq0QFc+V3RRHgBL/p+Im+0R4cjb
0jyr0UgBfBzmwNdrHYtKfqzrXRnMlqZtkBFLCKud3TPNAdbeHqOgzjetMCyC5MmU
/Plr+bTDFVOXs9FQezNSbh+G6MLDjMhe+K8a641oiJQYAMhMY2o=
=l9oc
-----END PGP SIGNATURE-----

--7L9kolmstoDTZ4pm--
