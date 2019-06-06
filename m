Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3438C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CD82083E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 22:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwO+LEHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFFWkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 18:40:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40449 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfFFWkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 18:40:19 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so142265qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=X04iGhDQzw+yQxS/c88O+hKoiyR84ubnTVeo0JYdCO8=;
        b=AwO+LEHwNcOjItvoP+6RgLmB/qXyyEalhoWC967tTiNj9hmgsQAOnXLqpCvE/LgIrW
         7LxBC0iHC0hdkuKNSaFVfUcmFmFitowIF/tRuTvWUXcHKMUz0mLqTPm9Ss0m/SfPDNfk
         uViw3s2aPk9pKyeA4f/yRoMyaaP1q/RUikSq+4GQbL+tMyrojZGXNU4cxKqDeDThHKh5
         ah9Njc/fnFkfljlJDoZtuG8jw++nrpbDxjgFLb/Y+nDOgXBCEXVX6kPfkb9MNo3apGGN
         NHeHSg3fu8MyZaGcdMasrp20RMaYPp6VrSfzQMwB4r62AMDs4YnSYFtsoBTelMv+nqQd
         3HVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=X04iGhDQzw+yQxS/c88O+hKoiyR84ubnTVeo0JYdCO8=;
        b=T+DGdCbTXcefMVE86d7V/ZLVDbdpPjrd5phRX9Ad2a6dtMm2Gb/8WH3VUZ9O+gedH6
         zlZ0XnkUgul+X49sy4bHqXGfjyneOz8CgTq8MftLREJVzm+a7ma5YNkYAejc/ZSOHfJq
         T3LP46uXuCXwyJZy08OUIdBtISkdPIxhmq9mW3jWPwygIcAPVuvnDmDnuBG0T5Rev6KK
         LNpGbcWTzH0CNQ6xBhbihykRZnjpDcqEnOEO48qZsfOtWvM01mR8qO/Awnk6HxkFRXZn
         3lxGUuabOV8HelPUxzsFMJNtR3EqkLC9mu5bf2iDXjFLFooDzWMMAw+TkFxCPjwhQ+Hy
         12Ew==
X-Gm-Message-State: APjAAAWCB7uY9bX/h0oQLYCUUURmAkSnu9RLHoGwPfWXunXcQoVtG26a
        LsmlnAg7JJRrvf8jUGHY1w4=
X-Google-Smtp-Source: APXvYqxsUjIa/bzBg+ectDFHonbB3fvpMVWwMiFC9WyWojB2K3od3AKrLhj5ninduUP/gVHZ7yiAYQ==
X-Received: by 2002:a0c:ed4b:: with SMTP id v11mr40088143qvq.126.1559860818713;
        Thu, 06 Jun 2019 15:40:18 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.146])
        by smtp.gmail.com with ESMTPSA id c18sm105921qkm.78.2019.06.06.15.40.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 15:40:18 -0700 (PDT)
Date:   Thu, 6 Jun 2019 19:40:13 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/vkms: Introduces writeback support
Message-ID: <cover.1559860606.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cmukgb7fz6z6a5r7"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cmukgb7fz6z6a5r7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This patchset introduces the writeback connector to vkms. The first
patch is required for enabling the virtual encoder to be compatible with
the crtc when we have multiple encoders. The second patch adds the
required implementation to enable writeback in the vkms. With this
patchset, vkms can successfully pass all the kms_writeback tests from
IGT.

Rodrigo Siqueira (2):
  drm/vkms: Use index instead of 0 in possible crtc
  drm/vkms: Add support for writeback

 drivers/gpu/drm/vkms/Makefile         |   9 +-
 drivers/gpu/drm/vkms/vkms_crtc.c      |   5 +
 drivers/gpu/drm/vkms/vkms_drv.c       |  12 +-
 drivers/gpu/drm/vkms/vkms_drv.h       |  16 ++-
 drivers/gpu/drm/vkms/vkms_output.c    |  12 +-
 drivers/gpu/drm/vkms/vkms_plane.c     |   4 +-
 drivers/gpu/drm/vkms/vkms_writeback.c | 165 ++++++++++++++++++++++++++
 7 files changed, 214 insertions(+), 9 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_writeback.c

--=20
2.21.0

--cmukgb7fz6z6a5r7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlz5lk0ACgkQWJzP/com
vP+dqA/9HI1pPOrEyDIDVVJXSpLTTija/8sRarCwikNphSgn/0b7lDcISbEFDYFj
qgFkYToECrof2TEd5dQbIOTEZ3CzVmtlECSmAk/2Bv3Fm47OfhRXN33m2mgKha4A
+6S1Mr5HYCF/+OsOgMQQNNEi8kqRUuan+Tf5oKlfLKuP8bCBIv0cfRgq+yvkcQRE
6qvyMCE3TS19H7Qr9EsTXUJ5Hvr5hFs/0uHfPDAZgoEqj4DXIvICFMwDhKI3txXj
ZhXxKPJn4a6wluSpDAJuuJwan9ARUlxgT3KQR4k881yg95Q/qlG+xzbq3DrsWbLQ
jogEDXKYFiqKDXTfy77Re1/28YHLRrcWOQSMlDk+4dVWBVIKPGSpHQuBIl86WGrs
Jovl9ePplJW+ltCP+KEaO9Q+9nOhE3xXVIUurLN+wREBjc/SIFlNZho/N5C6U1Mu
DIWBNlUgG8l4Gnd4yJo6q4RwqoVnexXBx+7z6IdmN7RXpKh7fJaGyUKys89uz2ZJ
n2zLhLBgwLqE0H8hRZtAa3TNui2xOFH8M3tS3qHSZLnH/dt414EC2wUQjLUX/5Ln
OWnKSXV2S8j/WS381V7L2F8JPe1fcYmtIBCW10+3y63QUQgWyYvIE6GH8yKGmb7y
V2d5ImBPgcrMlaSm+UZ45rEGG5qOfV3v/rOg4jzVjRUcbq3SOTM=
=yMZ+
-----END PGP SIGNATURE-----

--cmukgb7fz6z6a5r7--
