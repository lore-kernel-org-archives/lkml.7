Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0660DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C966E20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOFsvrWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbfJVImF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:42:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35455 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388436AbfJVImF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:42:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so16598296wrb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7zx6YjrUFBDjmlRgA0qIw68+thnie5ZFOUiXEi4KEg=;
        b=IOFsvrWemMIlBx/Id6R7C0FEOjokmQxy2tXXKg2kEaF20aFgrcRucmX08oKRKRGrSB
         sTwb4Z4kje5NuCqNN+LSfX9Tx49KGScFacxoxCg/WzzftVhac/cyFWLCOILy9C2iTMV0
         0WmG2iRDNltXYKRseoabJcOEvthJeWH1pgmCRjR82TW1rHFZ2ipHY3lje6rpeh7OMCfM
         WpQpSlRlaV5A9C1I9FL4eSNpA/uNKnlt3td/2BSVyw8hncaYRMHiT56wZCL2s195qm8Q
         fPkrXm3wQL7PDC/09QwkRlNoJ0EQp1XRVjRFIhOl5f6FXz35Mua/TrRk9J3gvm6bUhDt
         2UCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7zx6YjrUFBDjmlRgA0qIw68+thnie5ZFOUiXEi4KEg=;
        b=mMuHMYhqry6wXPAviSd/cMxD3Pf8FjJ7XxeZUrdtbgXLmNW41eueDRq34mIu8cRG0l
         Z0WwggHdVkDGctM0C3AlPldadArMEghlf2zeWXq183ZqzqyVtGXXvFQ5tL7lKnJHYZqf
         /gLkpHX6WTOh5/Uj5K03JJdLVgTtenjMAtvEuKZ54Eo/rbj5mpxEFpGlEb4e+uQXB6y/
         +qZw4opg/5Nc5ujqPDFb7MO4Dx3/1N4zk5UUEG8XS88M5o6yfu/kvcqXU4dkAU8ymFno
         oZ61n2XdsKGG1fvuOp7xd2MXqo09xEaT19CUVNdcHt4AoQm0cetbEXYIwcRPfiMaMiMH
         hV+Q==
X-Gm-Message-State: APjAAAVYD4UIMLKSBteUaFvNIJ0mBfYWFwikzdwYa9K8CPKTaHbdlYq9
        KLSEUSqaUMIp5h1d7YUaWdtj9vd4
X-Google-Smtp-Source: APXvYqzcXNrvIwbbzD94/2BLL+deniiP5vjAf4yriWNWreVpt5hFPKkRsiy1oUXhDCUADb2H6/8oBw==
X-Received: by 2002:adf:a157:: with SMTP id r23mr2275618wrr.51.1571733722135;
        Tue, 22 Oct 2019 01:42:02 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id 37sm28155431wrc.96.2019.10.22.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 01:41:59 -0700 (PDT)
Date:   Tue, 22 Oct 2019 10:41:58 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
Message-ID: <20191022084158.GA1531961@ulmo>
References: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2019 at 02:33:42PM +0200, Patrik Jakobsson wrote:
> Fix typo where bits got compared (x < y) instead of shifted (x << y).
>=20
> Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> ---
>  include/drm/drm_scdc_helper.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Oh my...

Reviewed-by: Thierry Reding <treding@nvidia.com>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl2uwNQACgkQ3SOs138+
s6HmzQ/+LeJ9cSBWTm8G78GN2R6/IefuOM9gGj8CdAAJJnyL4wEFKkYc86SeiVfk
yNhx4VgC4X6Mv9X/Nt/qDaZRw5gUWYgxw163JntkOMtu4KL8kFkISNURSIR5tlrT
MufD5f+MqSziPl/y4Qr4CIaJyGRc6bwv0tCxZHNQL0jou4j0W8mYtZrm3yksgjd0
1J77t1n1aqcyIqcHtgmnOTmEa2U6RsdM6po1xUAqmJP4DzufvXVkI4fBdDDnvUdu
biuW2fXl0DBd9Hy29qbqO2HJGRxrE4nXEEOGoe7DT4G3gyDji11MV5VvMErWt5Nn
z+PxAOIr45cihflEfZx5Olq6u/1Czyj5WzoPhqTT65HMMe+TTQs+TMh2CNSY009C
jWXfNqpV8IrozTriqf52lNQgP3BJn7wZOW44lBz5iONKLuUrnFd2O5kLqTmOYcuL
MRjUl7ImuH20li2PLZDZha7SLqbcmAfolj06Fnlti+27xydRJ3a56+VZ9Fjv9YaV
/ZfObVrj7MUTjC8agnyqg63OJZwx0cJs30b7VQk0pM2xjLJIwdJCnFu7zcenQtIh
2C4o7Gk3+VnPT+m1F6relGT5eUYHyHZoedu6S5p0mpkUh8YalFWvwN6cBygyZLQ7
1F2AZgpNmfdSC3Fn8tyB6R3AkWepbHvuF2pNJyrQSbzyfnp2SfQ=
=kd/G
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
