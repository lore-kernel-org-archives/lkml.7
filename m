Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D11C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527DB2199C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Rz2HmPfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbfGWAOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:14:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50945 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfGWAOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:14:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45szVJ64tXz9s3Z;
        Tue, 23 Jul 2019 10:14:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563840841;
        bh=vxPSh/IsBG0RLSVqqoMz7eABCbPSkHkd4zA2cI05eSw=;
        h=Date:From:To:Cc:Subject:From;
        b=Rz2HmPfZaLg6QJji/HcqKPA6qPmi26+eSEmQcXBvCFITJasflOZuZCmXl4Q+kGSF1
         7wkFBh+epYu6rj8mJadoU2kGTdKiWO2f3tmgtsSKEpyiQcP4Gim9bAjF9Q8PrnPojG
         K71s+STv6GFp/Btn5XWVezDws4Hrgyzk00q1KRRpnBWyA/cJXRTjW4sh8eaYZo3PoW
         /5EQzPRU7mDbjk5nL4kLcfDZgn0Cd4D9akKUYBBtYvitU2nkAXcfGvPS0CxKmiPrIO
         bfGf8TL7I5P2ezx4G4BuvuYuVFB4RxnM0HKaUNFq7okxGVrVOYOcjsjwdHb2LPDo1F
         2OVEDzxDXkb6w==
Date:   Tue, 23 Jul 2019 10:13:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pawel Osciak <posciak@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: linux-next: build failure after merge of the v4l-dvb tree
Message-ID: <20190723101341.751596b2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b+3piXOgcVYq24xfgHN+cdY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b+3piXOgcVYq24xfgHN+cdY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the v4l-dvb tree, today's linux-next build (x86_64
allmodconfig) failed like this:

In file included from <command-line>:
include/media/vp8-ctrls.h:25:2: error: unknown type name '__s8'
  __s8 quant_update[4];
  ^~~~
include/media/vp8-ctrls.h:26:2: error: unknown type name '__s8'
  __s8 lf_update[4];
  ^~~~
include/media/vp8-ctrls.h:27:2: error: unknown type name '__u8'
  __u8 segment_probs[3];
  ^~~~
include/media/vp8-ctrls.h:28:2: error: unknown type name '__u8'
  __u8 padding;
  ^~~~
include/media/vp8-ctrls.h:29:2: error: unknown type name '__u32'
  __u32 flags;
  ^~~~~
include/media/vp8-ctrls.h:36:2: error: unknown type name '__s8'
  __s8 ref_frm_delta[4];
  ^~~~
include/media/vp8-ctrls.h:37:2: error: unknown type name '__s8'
  __s8 mb_mode_delta[4];
  ^~~~
include/media/vp8-ctrls.h:38:2: error: unknown type name '__u8'
  __u8 sharpness_level;
  ^~~~
include/media/vp8-ctrls.h:39:2: error: unknown type name '__u8'
  __u8 level;
  ^~~~
include/media/vp8-ctrls.h:40:2: error: unknown type name '__u16'
  __u16 padding;
  ^~~~~
include/media/vp8-ctrls.h:41:2: error: unknown type name '__u32'
  __u32 flags;
  ^~~~~
include/media/vp8-ctrls.h:45:2: error: unknown type name '__u8'
  __u8 y_ac_qi;
  ^~~~
include/media/vp8-ctrls.h:46:2: error: unknown type name '__s8'
  __s8 y_dc_delta;
  ^~~~
include/media/vp8-ctrls.h:47:2: error: unknown type name '__s8'
  __s8 y2_dc_delta;
  ^~~~
include/media/vp8-ctrls.h:48:2: error: unknown type name '__s8'
  __s8 y2_ac_delta;
  ^~~~
include/media/vp8-ctrls.h:49:2: error: unknown type name '__s8'
  __s8 uv_dc_delta;
  ^~~~
include/media/vp8-ctrls.h:50:2: error: unknown type name '__s8'
  __s8 uv_ac_delta;
  ^~~~
include/media/vp8-ctrls.h:51:2: error: unknown type name '__u16'
  __u16 padding;
  ^~~~~
include/media/vp8-ctrls.h:55:2: error: unknown type name '__u8'
  __u8 coeff_probs[4][8][3][11];
  ^~~~
include/media/vp8-ctrls.h:56:2: error: unknown type name '__u8'
  __u8 y_mode_probs[4];
  ^~~~
include/media/vp8-ctrls.h:57:2: error: unknown type name '__u8'
  __u8 uv_mode_probs[3];
  ^~~~
include/media/vp8-ctrls.h:58:2: error: unknown type name '__u8'
  __u8 mv_probs[2][19];
  ^~~~
include/media/vp8-ctrls.h:59:2: error: unknown type name '__u8'
  __u8 padding[3];
  ^~~~
include/media/vp8-ctrls.h:63:2: error: unknown type name '__u8'
  __u8 range;
  ^~~~
include/media/vp8-ctrls.h:64:2: error: unknown type name '__u8'
  __u8 value;
  ^~~~
include/media/vp8-ctrls.h:65:2: error: unknown type name '__u8'
  __u8 bit_count;
  ^~~~
include/media/vp8-ctrls.h:66:2: error: unknown type name '__u8'
  __u8 padding;
  ^~~~
include/media/vp8-ctrls.h:86:2: error: unknown type name '__u16'
  __u16 width;
  ^~~~~
include/media/vp8-ctrls.h:87:2: error: unknown type name '__u16'
  __u16 height;
  ^~~~~
include/media/vp8-ctrls.h:89:2: error: unknown type name '__u8'
  __u8 horizontal_scale;
  ^~~~
include/media/vp8-ctrls.h:90:2: error: unknown type name '__u8'
  __u8 vertical_scale;
  ^~~~
include/media/vp8-ctrls.h:92:2: error: unknown type name '__u8'
  __u8 version;
  ^~~~
include/media/vp8-ctrls.h:93:2: error: unknown type name '__u8'
  __u8 prob_skip_false;
  ^~~~
include/media/vp8-ctrls.h:94:2: error: unknown type name '__u8'
  __u8 prob_intra;
  ^~~~
include/media/vp8-ctrls.h:95:2: error: unknown type name '__u8'
  __u8 prob_last;
  ^~~~
include/media/vp8-ctrls.h:96:2: error: unknown type name '__u8'
  __u8 prob_gf;
  ^~~~
include/media/vp8-ctrls.h:97:2: error: unknown type name '__u8'
  __u8 num_dct_parts;
  ^~~~
include/media/vp8-ctrls.h:99:2: error: unknown type name '__u32'
  __u32 first_part_size;
  ^~~~~
include/media/vp8-ctrls.h:100:2: error: unknown type name '__u32'
  __u32 first_part_header_bits;
  ^~~~~
include/media/vp8-ctrls.h:101:2: error: unknown type name '__u32'
  __u32 dct_part_sizes[8];
  ^~~~~
include/media/vp8-ctrls.h:103:2: error: unknown type name '__u64'
  __u64 last_frame_ts;
  ^~~~~
include/media/vp8-ctrls.h:104:2: error: unknown type name '__u64'
  __u64 golden_frame_ts;
  ^~~~~
include/media/vp8-ctrls.h:105:2: error: unknown type name '__u64'
  __u64 alt_frame_ts;
  ^~~~~
include/media/vp8-ctrls.h:107:2: error: unknown type name '__u64'
  __u64 flags;
  ^~~~~

Caused by commit

  a57d6acaf352 ("media: uapi: Add VP8 stateless decoder API")

I have added the following fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Jul 2019 10:07:40 +1000
Subject: [PATCH] media: uapi: new file needs types.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/media/vp8-ctrls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/media/vp8-ctrls.h b/include/media/vp8-ctrls.h
index 6cc2eeea4c90..53cba826e482 100644
--- a/include/media/vp8-ctrls.h
+++ b/include/media/vp8-ctrls.h
@@ -11,6 +11,8 @@
 #ifndef _VP8_CTRLS_H_
 #define _VP8_CTRLS_H_
=20
+#include <linux/types.h>
+
 #define V4L2_PIX_FMT_VP8_FRAME v4l2_fourcc('V', 'P', '8', 'F')
=20
 #define V4L2_CID_MPEG_VIDEO_VP8_FRAME_HEADER (V4L2_CID_MPEG_BASE + 2000)
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/b+3piXOgcVYq24xfgHN+cdY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl02UTUACgkQAVBC80lX
0GyKSAf/Y11rsVPac4eRmBDk874SiM/KGcfQUr0pEd+2vC3Dl5/SxK/4lJhGuvah
T73n6tuY3icTmz2xkgW7j/Dk8jEsOzb+4lxKyWflMBCk0zKsCfWfk7+19U+CRlRS
MrKMp8hNXo3DwQWBOt6dJXRmuMRr2DwFk5/ePSMTUZKerWvLSjRIgWQrY7b3jPWi
OL0u8s+DeQTY1QqxmlWFdfNzT27LPdzrFdajpMKhgdKXkJiIRsJwlAcECA41sVwL
xkaFDgqpjHG8BjmTEYut9n/ZOdFM8rGNXUox0BOccRY5WcXkZhySiYFiFvemjkT/
u26sviFVkpG5+DaPdihkFDbRfaF+8w==
=tFqD
-----END PGP SIGNATURE-----

--Sig_/b+3piXOgcVYq24xfgHN+cdY--
