Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACADDC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797B920883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JUkqm4Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfDIGI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:08:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52563 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIGI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:08:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dcLC3Fs9z9sNj;
        Tue,  9 Apr 2019 16:08:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554790133;
        bh=b+lLXWelGn0jDE9KSkoP25RySRJxegTyui5Cc3aep6E=;
        h=Date:From:To:Cc:Subject:From;
        b=JUkqm4Certk4Rck2RCNUtaXk0dNWFN+SlxLtTXWLPC2Bz5FPgL3ycPl47Ij/vmj01
         4vG9Uwz7YihKjyX/Ovc3polFoANCqsepu9DCMUbD1T7h0tBUASpblJ1xXFnrlgQ+l3
         LrwbA1rIV6g7IaQdI/lPfFtFcf3UN1eQ9cfa60VIK4N5DxaHgVOxSREWifb58St3bl
         OoGaJ4WxXqwuQA0bssjEoqms2S+CmqgYC+51T1Hudpv3td+FE5Zu5gsSqiriDE/pia
         kd4yOok1tX4Poi/teHWpbWhqbdDrKv7SvhCVqxD/n6Bd7ARMIU4brqZXphBAlO6nkF
         SlxrQjt1Z9zPw==
Date:   Tue, 9 Apr 2019 16:08:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Noralf =?UTF-8?B?VHLDuG5uZXM=?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190409160849.391d3efa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DWKl6TYJOO3DDbnDEbr3Usa"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DWKl6TYJOO3DDbnDEbr3Usa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/gpu/drm/cirrus/cirrus.c: In function 'cirrus_fb_blit_rect':
drivers/gpu/drm/cirrus/cirrus.c:310:25: error: implicit declaration of func=
tion '__io_virt'; did you mean '__do_irq'? [-Werror=3Dimplicit-function-dec=
laration]
   drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
                         ^~~~~~~~~
                         __do_irq
drivers/gpu/drm/cirrus/cirrus.c:310:25: warning: passing argument 1 of 'drm=
_fb_memcpy_dstclip' makes pointer from integer without a cast [-Wint-conver=
sion]
   drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
                         ^~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/cirrus/cirrus.c:33:
include/drm/drm_format_helper.h:18:34: note: expected 'void *' but argument=
 is of type 'int'
 void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer =
*fb,
                            ~~~~~~^~~
drivers/gpu/drm/cirrus/cirrus.c:314:37: warning: passing argument 1 of 'drm=
_fb_xrgb8888_to_rgb565_dstclip' makes pointer from integer without a cast [=
-Wint-conversion]
   drm_fb_xrgb8888_to_rgb565_dstclip(__io_virt(cirrus->vram),
                                     ^~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/cirrus/cirrus.c:33:
include/drm/drm_format_helper.h:25:46: note: expected 'void *' but argument=
 is of type 'int'
 void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
                                        ~~~~~~^~~
drivers/gpu/drm/cirrus/cirrus.c:319:37: warning: passing argument 1 of 'drm=
_fb_xrgb8888_to_rgb888_dstclip' makes pointer from integer without a cast [=
-Wint-conversion]
   drm_fb_xrgb8888_to_rgb888_dstclip(__io_virt(cirrus->vram),
                                     ^~~~~~~~~~~~~~~~~~~~~~~
In file included from drivers/gpu/drm/cirrus/cirrus.c:33:
include/drm/drm_format_helper.h:28:46: note: expected 'void *' but argument=
 is of type 'int'
 void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
                                        ~~~~~~^~~

Caused by commit

  ab3e023b1b4c ("drm/cirrus: rewrite and modernize driver.")

I have marked that driver BROKEN for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/DWKl6TYJOO3DDbnDEbr3Usa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlysNvEACgkQAVBC80lX
0GxmWwf/VoRfLiEXUWEl7T/H4C6lWqLfx1fxGJLssggwzz8Pn3eXiGQ8g5Gtys6R
NKjvb9r6IpmHbk/6FXiuE4kU8Qile9cRp0pu5U6NMxnM4eV5d5tG1q5mroDvDr3/
WtG38VgiF9KmiMShsZfjhMxBxmBOccmCazmcnbieMA9rj/xdTOJFrbT4XSO5Yaks
lrRSf8CnH54/TPIvW8lt2r6kZBMNiMdJ7aaxjf7PYI2pxAS7mLaOFqtSZ2AT4pc3
E2woWMwUBsj9IPLea2zzMDJWI5BADD6v7xfJrlKS7NIW8T/jQOXEm2l4+D2RIV1H
kzjXDIanTnHSTIA3Svcj7Zkvy6+3Aw==
=G9CV
-----END PGP SIGNATURE-----

--Sig_/DWKl6TYJOO3DDbnDEbr3Usa--
