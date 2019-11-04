Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED03C47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5206020869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egXtoZb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfKDPuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:50:18 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38800 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:50:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id p20so6314197qtq.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kP1Dsw0pGBhULD74j5Sjmpym4D/yTZlUKtWObbsiHq4=;
        b=egXtoZb7MmoQ1HRgP9tQUpSPHXsTK+enkEWTl24Fk3OGYR/IOBbJiHQPQy98PTWtak
         QmdJXQBXQJP7sUhFBUnMEYnTikz5jW4KkkK9StBmCPX0mUZFuanD20UXFQFheD3spcHb
         CEuT1sDaWxqErg3SQ0xnbreybvvUCbm8BSDsNMnSD7WnlWuekBne0wJDC9Z1R05sC/jF
         /slklHPsyOfI3EaXdejEC1N3dB6X5oDBSJ06oU7zummvij6J3akUSE1zI0mPJCSdjEcB
         KC/Uwk37Tw+akwYLUtvCEviimV7d4e/sq1DkTjaD6MBSgmbm0qIXneJcjf/KAXNOr08y
         XQBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kP1Dsw0pGBhULD74j5Sjmpym4D/yTZlUKtWObbsiHq4=;
        b=WBFCYod/fj6EIxPvItAoyntjlkK2S/ZK/hrQjFj3To3gHQIEW5eW111UwUxk4JK3b5
         7K+TsZOmsCEzH8o8OiZRKkykS0Zt9fRnBLS2Mwrz4oZ9t4IQ761BZg1xM8nmWp2UTZ7X
         Q9noiDnCSSwY3PVR7TX50Wlj1UJ/+/IpMg18gyGrc2iULxjdzp6vMQOYa/FVpT3bm/Qs
         d9/OPalVPFq4K0xFkPrIARbb4AsHXpvSOiRAhhuaXS/a8QebI8HikE4OyrcdVRAO3eNW
         N0iHBlExoB5JJ+PsWM9RE2Ej49uYVwUoH9iub1O9rxd32n6Tdnkb7Sf+GuVRv8p0TPW9
         S16Q==
X-Gm-Message-State: APjAAAV0u6L2venh11hTTD33r+L4udtYTrIdjHYTdakahflGiKI5zQ6B
        UARMiuHtJ4fy51TmeobYiDo=
X-Google-Smtp-Source: APXvYqyrimVjWSw/EKVn3HCyESovWIH32e5G3bolAeT1se236k1nrnEwMwOkvn+BhDb2AXYfV8eZMQ==
X-Received: by 2002:ac8:5485:: with SMTP id h5mr13011854qtq.16.1572882615816;
        Mon, 04 Nov 2019 07:50:15 -0800 (PST)
Received: from smtp.gmail.com ([165.204.55.250])
        by smtp.gmail.com with ESMTPSA id a66sm8308420qkd.34.2019.11.04.07.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:50:15 -0800 (PST)
Date:   Mon, 4 Nov 2019 10:50:13 -0500
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        hamohammed.sa@gmail.com, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, trivial@kernel.org
Subject: Re: [PATCH v2 VKMS 0/2] drm/vkms: Changing some words in 'blend'
 function documentation
Message-ID: <20191104155012.wdg25roebjqt4tiy@smtp.gmail.com>
References: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="arzbpojwlifr6sea"
Content-Disposition: inline
In-Reply-To: <20191101214848.7574-1-gabrielabittencourt00@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--arzbpojwlifr6sea
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gabriela,

In the case of this series and the patch "drm/vkms: Fix typo in function
documentation", I recommend you to use a single patch. In general, If
your changes produce a lot of deltas, you need to split them into
individual patches that modify things in logical stages. In these
patches, you made changes to some files that belong to the same patch;
thus, a single logical change is contained within a single patch.[1]

Btw, thanks for fix these issues.

Best Regards

1. https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#se=
parate-your-changes

On 11/01, Gabriela Bittencourt wrote:
> Changes in v2:
> - Add fixing typo in word 'destination'
> - Add change of the preposition
> - In v1 the name of the function was wrong, fix it in this version
> - Add the patch changing the word 'TODO'
>=20
> I've tested the patches using kernel-doc
>=20
> Gabriela Bittencourt (2):
>   drm/vkms: Fix typo and preposion in function documentation
>   drm/vkms: Changing a 'Todo' to a 'TODO' in code comment
>=20
>  drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> --=20
> 2.20.1
>=20

--=20
Rodrigo Siqueira
Software Engineer, Advanced Micro Devices (AMD)
https://siqueira.tech

--arzbpojwlifr6sea
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl3ASLQACgkQWJzP/com
vP8nuBAAtA6lod7nNzI304FKxAxD1+ZvfHaYc7MNdBouOK0OiYwKTA3yu2W97k2S
LO/lfqZc9fBLb8r4MgogGnRbQ6esN5A/lSUpPUsHltcD6HKWK/wdl1soebYYn+M0
LEyKFHsGptJuQyXLvBIo44UaXBmXzadRZxsaF62F/LLsbqDnHswM7OLrl832Wv3r
YMBp6P0siy6tJXUMy0FPYWD6/t/67Fq+Z287d7Xex9Kc6RJLly98mNlmfkvg9NcD
88NaSz3dVo0eUvUffiy3LWwRcUlVdZvE4jOjv9w+qzEJ5xKEMNHYCEd1Osqq/Q+x
HkfWuwXY4MtIs1UHaC8uR0eC47oaX/mWuZSoEqnbS7O60sKwbxZIUdHMcGJdMkLw
qDbJ5GXslD1nMzfOJzVyWljoLVS92ScFn+Q1f4x75j7aV5ioJW7A91GJytloLFDd
LBGa3maYQmuvWtjOLbiIQc9fqXt0Ef/Hiv57ZRCCbPBg5wui1EtqfLiWN73tLlKh
rEMAAFOhCDcsomnzkl6tMT37iHlhAgMSDBx0oXNtv+Pl+oo4QN5s4Gb0YBawOSTA
kqZak08Mci4zrBFqlarBjxlJirWO4f8fS3yVYQsm1vqXcV71hoa18SwDeTApUHh7
n3+5wK5xKmelhdgX+cJxZm8dI3NiW5+uER+cm9Kfbv7ZPusk4ro=
=5GmA
-----END PGP SIGNATURE-----

--arzbpojwlifr6sea--
