Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB734C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A267B2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="auNfyTeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440162AbfIWRYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:24:34 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:33667
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389167AbfIWRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1569259471; bh=pdVswqBT9aS6mkTUEGl+a8PBJrUCnC9qbMNQhgBvJHY=; h=To:Cc:From:Subject:Date:From:Subject; b=auNfyTeDwhuCTCH5IlLG/rspSMRANUIIP1ECzlPSGH+zWTC6o89+kkGZ9lWbA+hmlisEv3dioG0kcupD/5EQ5mgm7CTGQPQlFQDxRpCVnz+pzn60bgWEr0lHkN9ndua1oHPW+i9Az8a91YOw+hrSUES44tu82UI991zfC6tb7MTShcBujpRYifsvTQ0yndxhzNgajgoD7N5GPk5kp4uztAMPQIZAtyl1WeHw6dR4Is2ZJUl4x7lYSmtyzuVfqdpkrtXgQxXn4RE4xHC3nDykYCWz7uM6gOTRAlJ1KhjsweUgIcQz/OdSOGDE8M6AuqBH+8e8B97fcSEmWKdgHMvwBA==
X-YMail-OSG: LWYymd8VM1nOugohR5dNj_IQ8tfeIV62PM5xxkky8KOKnt4UaN4Rf9FPeYkw.JA
 6GsGpsuSSfuuQ9vwAWqQbiOlP0AnnftMfImDYsphcaWM2JPC4WYGJh_m2688OQ01d4mgoZdAmtd9
 wiWexu5.tvd2xOAJc_dMn3TGMQCYADYMW9sjSIh7zIYmGwiz2yTfbIKas9QtCSIAw0Aa7VKlpLRj
 P569RZjPVSJsEsnwQ1_2OHf8xLE58i5hZ9hJo4E2ThQc1vXb0bjSAKnAX3ehFcZ5hrZTg1e5NpH7
 GyidTHL_K5qfiQwNaoyQXI0fgsWDDeggawjFNN13MHwnQl0WdKHXF16bxRohNJ2S8k3AHecuftRK
 6tatY8Hhca97bEIVLPiiwotARmsRnZokzeL7gztZMf839C_gKk86x0E_toS_siNPPPufhoy_Qhu6
 FhLRNE.l_Ell0fCtwfjJ.SrL2O.CRnS6vw_cva_cpbkcGLvusLpT9PpW3jjIG.HPdsHQrdbFXt5r
 7K1_KM1Qm.8vV5EYwJsKFFSvXeiFZR1iF6p_TRSWww_hIhktvkLLlC.AotbJhpRfCQGSD3uYnAAn
 _Sn3wftKkZ25rTaXQaMJZBCLodQXTde_cvtNhb3mmnLbLm_GpGMpqMyn6OlKZRUBQQHZzO8VaiDg
 x1A6nvKsReXx3Tx3TI8BztDcDaV74XFH9oj9jL5IgRG5nL9K_C.2cS2suzIcr7jJoBY0s8EZxfAO
 YGzUQ2lB7McBJshfAmZW46xU8_UxyRwkC4_hNzLpumMN5kY2XyNSc5QxYsa9MefrCMxGeu82gV_y
 6YkBWlIg3zSMK0hth7tnRyhuYcASG6PGKrvxloO29.Me3v2ft2a9gupCy_G.f8gZ5.9P_5CCEx.g
 1Ev8k0XQm14jPRC_cnHL9BR8200eo5PwES4rzOU6v8lXQvxOfMZhcdYXai.oSZvWN5pIkV_Vi_.G
 oQoPgx6m2GRPAMD7QA7B3EQtjO_VGIOk3m8i8bIEjRlzun448kXrVinUu427zwPI0RnJ6BPdilcX
 smRxDhycLBfyhX3BfZ4AMBgzWq2WNQ8C3o6Mk3mUPL0f1gjJcmEFrmRoMuNnu.ySpfazD6nmMwm.
 C1xmEhug4Gtj45uCspbyusKFF8Ne..SYxMYne9WjBr796jb1QuMXU_ZsLweao.gUR9wT.Sbk0nQJ
 7YAWjZIpp.oczWfbwqq7myzIgXCl0svLIL3rX2UnyUb0edL9sPqtcce5fQOECydmr6_j7Tfof6k.
 ck5CF_hiMPtquBPSLQqfQSI2Tp1qqItVjHIdEHMtHET7fmUMh_dRLIghWz3DyEUT_chYH8eYjjHo
 HEVRZRa8mhY.34Xiyq7ql9M6W8FlzPzDVaj8qQoQx8dVd2weydeE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Sep 2019 17:24:31 +0000
Received: by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0a848e5d9eb8d6e4560187fd4efe0d9e;
          Mon, 23 Sep 2019 17:24:29 +0000 (UTC)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, casey@schaufler-ca.com
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.4
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
Date:   Mon, 23 Sep 2019 10:24:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OMtMGNHphK3u0nw5V6u2YAXrkJTRo0nRG"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OMtMGNHphK3u0nw5V6u2YAXrkJTRo0nRG
Content-Type: multipart/mixed; boundary="wUpGR369qDJAcoWjTxwrrsBYxBT5932LG";
 protected-headers="v1"
From: Casey Schaufler <casey@schaufler-ca.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 casey@schaufler-ca.com
Message-ID: <d2418da0-056b-2e6f-ae40-acdfa842e341@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for v5.4

--wUpGR369qDJAcoWjTxwrrsBYxBT5932LG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Hello Linus

I have four patches for v5.4. Nothing is major. All but one are in
response to mechanically detected potential issues. The remaining
patch cleans up kernel-doc notations.

This is my first direct pull request. I think I have followed process
correctly, but if not I will attend to my error as required.

The following changes since commit 0ecfebd2b52404ae0c54a878c872bb93363ada=
36:

  Linux 5.2 (2019-07-07 15:41:56 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next.git smack-for-5.4

for you to fetch changes up to e5bfad3d7acc5702f32aafeb388362994f4d7bd0:

  smack: use GFP_NOFS while holding inode_smack::smk_lock (2019-09-04 09:=
37:07 -0700)

----------------------------------------------------------------
Eric Biggers (1):
      smack: use GFP_NOFS while holding inode_smack::smk_lock

Jann Horn (1):
      Smack: Don't ignore other bprm->unsafe flags if LSM_UNSAFE_PTRACE i=
s set

Jia-Ju Bai (1):
      security: smack: Fix possible null-pointer dereferences in smack_so=
cket_sock_rcv_skb()

luanshi (1):
      smack: fix some kernel-doc notations

 security/smack/smack_access.c |  6 +++---
 security/smack/smack_lsm.c    | 40 ++++++++++++++++++++-----------------=
---
 2 files changed, 23 insertions(+), 23 deletions(-)



--wUpGR369qDJAcoWjTxwrrsBYxBT5932LG--

--OMtMGNHphK3u0nw5V6u2YAXrkJTRo0nRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEC+9tH1YyUwIQzUIeOKUVfIxDyBEFAl2I/8wACgkQOKUVfIxD
yBG7kw//YjUo9wwvAozd8bqOcW+fdPzdKIt8M+I0Qicqj2oqrOIyONjcrbV4ynT1
vKNKTjM1+apG/wDUf3SNh9m/03qduT2oYdTGgTUrXzVgWAYZaji10hRgydbTmycY
rzU/LjE4lZH+cGEuEIugDKEycwXFlCqholuir75LPFvRWFFU3Q8+AC+sH8ut9KB1
7Eo3bw9jizYNqeXFq1aaqOEn/SOlly/8Ay+ydBWzL/fHgbTr1Ur+NTpZKUI8kV1A
Ra4o3FFX+GY+/uMVys4jO3nMA6JaQrAOG4cGzyjwLQsOFcEfrq10A9o2FV7eNd85
R65HG/b2W9OpSvzfxPn+AOmKe3pHaJtbKOyR3rohYNj32ZySkyVRvdRaSs/K4Jhb
ZbH3mwrjpf1UZxJEyoQKhrsf18MWd/r51M7G++xJ2RSELq7zD5GFSw1kEQDHZ7VR
33kNbVJouURa90WyusGJ3Z0XV8qGZL1bGnV5NAZqMp6zdw7wahl723PKZD3a/07N
GS/TVvLj7ZqaLdzfReh8CkwoICfIfBhPimRLfDcHmhLQ/T+pmm91cBKBbUlLZjAU
AH2bXtqzDqeJP7rasbUZJWajlcX3bmsWUGOnVuyoFuXaR9KCufdZWM8rawP38uKe
bluQOjQgDAaCFXmpeFu2ivaFMTLj6HPOIKMoVyd45TaEEtPSbD8=
=gCPy
-----END PGP SIGNATURE-----

--OMtMGNHphK3u0nw5V6u2YAXrkJTRo0nRG--
