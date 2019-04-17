Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447BC10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E98206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iaRmuoeA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfDQGxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:53:24 -0400
Received: from ozlabs.org ([203.11.71.1]:40195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDQGxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:53:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kXxs5XvDz9s4V;
        Wed, 17 Apr 2019 16:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555484001;
        bh=D7OfZrYLyQEuXBKIR6FhSm0zpSfws4FwSXqxTG0EmGU=;
        h=Date:From:To:Cc:Subject:From;
        b=iaRmuoeAXkBngA/mGo3A+KwIpjix8al2o9W21vzQahoxKuh4AnLUEdH2D4k6J7h55
         sTr5DgPwodDbebFbTwZ57mHViDIinnt83/bGFrIMLBnzzWasJjGtnofvOv0TDWHcTX
         2A6uBcRXw/p13gMvsf9DiC1OaufMf0XbrjXWOD/AxssEQsZkFNIbzvsCy+xB4JBdbA
         Dpa3LPM90qdW1WniHPxnCuq6n+VxLfCe/RPckuzY4wg8LVKfimCmdQnyFRoU2hOfPH
         6wMbBSHdMEE7xNfePr5uS7/43saL/n5lu5uUHwL3rxU0kn0led8jhlKr5euAnHJB0r
         2wl0W2jtyYwHg==
Date:   Wed, 17 Apr 2019 16:53:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190417165321.61cd6380@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bd=lVB6xi8RtUho1ZJYpL/Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bd=lVB6xi8RtUho1ZJYpL/Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

fs/binfmt_elf.c: In function 'load_elf_binary':
fs/binfmt_elf.c:1140:7: error: 'elf_interpreter' undeclared (first use in t=
his function); did you mean 'interpreter'?
  if (!elf_interpreter)
       ^~~~~~~~~~~~~~~
       interpreter


Caused by commit

  3ebf0dd657ce ("fs/binfmt_elf.c: move brk out of mmap when doing direct lo=
ader exec")

interacting with commit

  a34f642bccf1 ("fs/binfmt_elf.c: free PT_INTERP filename ASAP")

I have applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Apr 2019 16:48:29 +1000
Subject: [PATCH] fix "fs/binfmt_elf.c: move brk out of mmap when doing dire=
ct loader exec"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b3bbe6bca499..fe5668a1bbaa 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1137,7 +1137,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	 * collide early with the stack growing down), and into the unused
 	 * ELF_ET_DYN_BASE region.
 	 */
-	if (!elf_interpreter)
+	if (!interpreter)
 		current->mm->brk =3D current->mm->start_brk =3D ELF_ET_DYN_BASE;
=20
 	if ((current->flags & PF_RANDOMIZE) && (randomize_va_space > 1)) {
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/bd=lVB6xi8RtUho1ZJYpL/Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2zWEACgkQAVBC80lX
0GxAqQf/XtjY9CQ2auY+756f5/Mo7tU3IiCeQbfx/PqKttY6xFRhVPWUwYmLQBEO
GXC13BL00o2WU6QBZyvxVJOTJEymolxOLIxL3soIwa8tafJZeJtZNiLfFUREoAXL
meFN2pWstqGA3FjvJ02FmNQJ5kXEDIoKgRn+VGNzkj8RejX6Jld1JrY4X7oNjkw0
9WIRcIB82tuKDpoPC5ktq/LU608qR36dA3FBoCFZVnpGidbESqA+2WjYip1TQpyi
WKNB/FErVvGUTDihFlSYxt077pTncY2jKMA1eizlmvKrqBOJ9mq3KsoNS5eGeqIe
LIPTGdFTgPtv7cXK2ATcjUdvAXRQ8Q==
=0NE0
-----END PGP SIGNATURE-----

--Sig_/bd=lVB6xi8RtUho1ZJYpL/Y--
