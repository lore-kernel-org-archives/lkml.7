Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16F7C73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D6F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOI7rPcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfGJBwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:52:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43493 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfGJBwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:52:10 -0400
Received: by mail-qk1-f196.google.com with SMTP id m14so665240qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 18:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/vJaT+pqGNNv8eMpv9fAaGOGmsc6Sqo+aqF8frZ6VU4=;
        b=EOI7rPcvGy/A6BcL9HiADyvraniOSlO+5sCUSl/uIvTRJhpbgfLfd3m19LO1ovXVTM
         AHWQJbQD/ZMI6HA0Kn80unoTcoA6SgNGRgjbSA2omtQkdG5Aud66/RfOygTCIU8Wi31+
         5ZB0du45nRhBRU8N21nvVcmBmkAYUeKPobUFHwJn9JzdTykK0EI3IUyaFEZolNP9ggjW
         jlOmYhhOJJ0ZE3d0+lF5d9/IdyaeIattRgY6SeHwAg6SatLYULev9sHYtum8iGOiSePx
         K9yDYElmtREqM2UkXyOQZs78lwbzwTAFSHV3YyiwImrZWR+9Blkh7Dedla8hNQxHp7vH
         +a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/vJaT+pqGNNv8eMpv9fAaGOGmsc6Sqo+aqF8frZ6VU4=;
        b=Xus61Tx4hd0SUasMl4sTR4GW9BXqVkY67saxyniCjeu0jFDIIUbyk5bsvdj8DPG3nt
         XJltNOS0tEYnYXbrErO8+KC6j5spqVJiOyfr6wPRM1TgAjctnn5R/Vfs4AVjwOGTpAU6
         x1NjY445fTzU6nW8vtpNSiUJyz4jkT+Cbdmupb2Ei9W+Sque2RQjCN3gOU3xXRjoPTvG
         060+aE/E7XlyXKOmjWWsrrZTWyh7A2uWZdp/zKObyM8XGXNwCL4SbF+fpUD3srA7srqK
         MYepgCrn+aP4rhBa/RLsLZOC61Vp3UXHjFa6aCMWYRbBm/MZmRIUHRQty/txcxkg4L0f
         A8gA==
X-Gm-Message-State: APjAAAXKzZc6J7fBjRZRu0c9Oo1+ZuBXJOfd/4UkWC8NIFa5pgphlwYz
        mousMNTxCd4XDnIU6QwmEf0=
X-Google-Smtp-Source: APXvYqzjNiMJsDIb05GsaQaXWWCIkmVWa2PyK/6tCX9e2QA8jGN+nQ7bs1D9eeOKrISYN1nQyceSwA==
X-Received: by 2002:a37:9506:: with SMTP id x6mr21748901qkd.107.1562723529657;
        Tue, 09 Jul 2019 18:52:09 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id y16sm385418qkf.93.2019.07.09.18.52.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 18:52:09 -0700 (PDT)
Date:   Tue, 9 Jul 2019 22:52:02 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Simon Ser <contact@emersion.fr>,
        Oleg Vasilev <oleg.vasilev@intel.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/vkms: Use alpha value for blending
Message-ID: <cover.1562695974.git.rodrigosiqueiramelo@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fyrleg2cbocjyu6s"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fyrleg2cbocjyu6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The first patch of this series reworks part of the blend function to
improve the readability and also for preparing it for using alpha value.
The second patch updates the blend function for applying alpha value for
a fully transparent blend. After applying this patchset,
pipe-a-cursor-alpha-transparent in kms_cursor_crc start to pass.

This patchset depends on:
https://patchwork.freedesktop.org/series/61738/

Rodrigo Siqueira (2):
  drm/vkms: Rework blend function
  drm/vkms: Use alpha channel for blending cursor with primary

 drivers/gpu/drm/vkms/vkms_composer.c | 54 ++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 15 deletions(-)

--=20
2.21.0

--fyrleg2cbocjyu6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0lRMIACgkQWJzP/com
vP8Cnw//dlryTWFCJiRp35ea2i6MuLQbjbUeV8bUyH8LN4vDgMrtNcCapfD7jWLz
QaQJj/gXz60LBLSdzwOYP738pRVGw9yP4zE58PLhMCXkyL19SvtBz+3GDdrmkBmO
UiVPFsZa44edCFFnXiZ4qS7ElN5yL3x138zCbOnS3MoLMi02TvXN8nzqWWU07omC
k89d8Uf1pU3FmmOkcRdXe9DNZhkqu6W9fERu625mPzmtn3qEZqPvSDjCcjAizn0H
pS35uLEWvENNY1W0snhbS5X7aS8yMByMKTfO0Mo8BFQ4ZUb+iDUFXTBYPdXtfYX2
mD2prwwzuWn61Z+ByOM2L8ZuPMOAH48yw2iZzOW8Lsu2NWSh4Md31pUxSE5Bsguj
JddJE8v9BYSQgs9ntKYraKPKzhi6U2vFj1mYycfPWUEc6q4piiR9sLZRC2dFjbX/
f617U17muG2kCjdUA1ypcRnrkBXCtLjT0JnRB1bhFsgSEcnwX6TUrRZvEVPRC/xH
wDS7JfWEum++tlMWL+AUn01vHNItOIjAB8LdcWhuYbRxEZa5ut3UZpky0FTUcRlV
X9ELtMP5oGjF/N8qEaJ1LiFzj1GLlfZYglD6gOlyOtKKuePnRONPvSP7ow/V14Yb
9cZKu+NDl4pRozw3cdPp0rjyb3O9wylfGaN5yelcSsEP9Yh9Oso=
=twWP
-----END PGP SIGNATURE-----

--fyrleg2cbocjyu6s--
