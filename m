Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84372CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540C221D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YjWu5/BI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfKDNMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:12:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48491 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729025AbfKDNMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572873123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=mEeFwMQ/ppa/j4TsLmopSIuCw8suIuDki26NbkIs/yI=;
        b=YjWu5/BIaQJpbFNOrj+QtUOYfMaLAeGDFIon2L4mh6Lwg7H6Jl0v9z7EpyLNfNGd7igfwB
        eVDYUx6zmDQ/GzLn1HgTWQbifPSz04EC1d2aCPyg8Z7xIZn9St8giW3Rtxa0yySI3mQX6h
        eDV+B5wZCQ7vGoeVbwp+l6FGPCmp504=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-lGfyi6r-P_C3gnV3fPRSCQ-1; Mon, 04 Nov 2019 08:12:01 -0500
Received: by mail-wr1-f69.google.com with SMTP id v6so1097241wrm.18
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 05:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w29442xfvO7j2EoGslKoTV7tRbFcx9AseEe7FfaZKW8=;
        b=JS3WxRrCnRSMiIdwG6xZ+NCfnVx+IECIS21TtS4XIIMEQDkgHoq9ZMqoo4SgoqlbLH
         TSbrRU0cJwuVu6wqvniIze/lQD70OvfR+FqWfxwi7DxPT1+M10xtbUFmRsOGbHRXBxRd
         c65jlFpjRIDVadTEPvwWSorA6LkK2FM5dRkHLgUMSAB5bRE4li2CfTDq9QhKIU//KYQc
         /KGBAnDgc/tmpqANCPu8k6QXcAZvAkufscgSddINcNWsRi1zfx8UWgIkGbMg3ZZ1yvxB
         NvqBp3npXjIu84Hrd5+/mQAjACrmZGoORx2GXh6ZQXRbPWttLCWVcK3ryLk+gHMLqPMv
         G8DQ==
X-Gm-Message-State: APjAAAWeB2EXLtY9Pq0sCeVzVGP1bhxqdB7iAHbIXekphlKU3MgZzdVL
        1PBAutWLflz5SV8OV8SRSNcR0ZfIncDhuO9IcfDTqn6jOJ75cr3YVPhhSkyMmvjz6SlIuqct9GD
        GYRX4XejYGC9Q1Ao1zmkV5We+
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr5467098wml.161.1572873119559;
        Mon, 04 Nov 2019 05:11:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxwizl7SZT7hN7psw0/wzgb6PYDjICq1xPSIvHIRgo+xuWpaqRzauG4APe//qiXTTIEVhAb5g==
X-Received: by 2002:a7b:cae2:: with SMTP id t2mr5467078wml.161.1572873119326;
        Mon, 04 Nov 2019 05:11:59 -0800 (PST)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id q2sm15309813wmq.30.2019.11.04.05.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 05:11:58 -0800 (PST)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: Add make dir-pkg build option
Date:   Mon,  4 Nov 2019 14:11:44 +0100
Message-Id: <20191104131144.14333-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-MC-Unique: lGfyi6r-P_C3gnV3fPRSCQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'dir-pkg' target which just creates the same directory structures
as in tar-pkg, but doesn't package anything.
Useful when the user wants to copy the kernel tree on a machine using
ssh, rsync or whatever.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 scripts/Makefile.package | 3 ++-
 scripts/package/buildtar | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.package b/scripts/Makefile.package
index 56eadcc48d46..36600ad1d5e6 100644
--- a/scripts/Makefile.package
+++ b/scripts/Makefile.package
@@ -103,7 +103,7 @@ snap-pkg:
=20
 # tarball targets
 # ------------------------------------------------------------------------=
---
-tar-pkgs :=3D tar-pkg targz-pkg tarbz2-pkg tarxz-pkg
+tar-pkgs :=3D dir-pkg tar-pkg targz-pkg tarbz2-pkg tarxz-pkg
 PHONY +=3D $(tar-pkgs)
 $(tar-pkgs):
 =09$(MAKE) -f $(srctree)/Makefile
@@ -147,6 +147,7 @@ help:
 =09@echo '  deb-pkg             - Build both source and binary deb kernel =
packages'
 =09@echo '  bindeb-pkg          - Build only the binary kernel deb package=
'
 =09@echo '  snap-pkg            - Build only the binary kernel snap packag=
e (will connect to external hosts)'
+=09@echo '  dir-pkg             - Build the kernel as a plain directory st=
ructure'
 =09@echo '  tar-pkg             - Build the kernel as an uncompressed tarb=
all'
 =09@echo '  targz-pkg           - Build the kernel as a gzip compressed ta=
rball'
 =09@echo '  tarbz2-pkg          - Build the kernel as a bzip2 compressed t=
arball'
diff --git a/scripts/package/buildtar b/scripts/package/buildtar
index 2f66c81e4021..77c7caefede1 100755
--- a/scripts/package/buildtar
+++ b/scripts/package/buildtar
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 #
-# buildtar 0.0.4
+# buildtar 0.0.5
 #
 # (C) 2004-2006 by Jan-Benedict Glaw <jbglaw@lug-owl.de>
 #
@@ -24,7 +24,7 @@ tarball=3D"${objtree}/linux-${KERNELRELEASE}-${ARCH}.tar"
 # Figure out how to compress, if requested at all
 #
 case "${1}" in
-=09tar-pkg)
+=09dir-pkg|tar-pkg)
 =09=09opts=3D
 =09=09;;
 =09targz-pkg)
@@ -125,6 +125,10 @@ case "${ARCH}" in
 =09=09;;
 esac
=20
+if [ "${1}" =3D dir-pkg ]; then
+=09echo "Kernel tree successfully created in $tmpdir"
+=09exit 0
+fi
=20
 #
 # Create the tarball
--=20
2.23.0

