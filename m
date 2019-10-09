Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21852ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED77920B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2mxlj0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbfJIPKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:10:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729644AbfJIPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570633837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eHwEpktLjemhDVWBTEE5wdMKU4jlPm/MsrXeEwc5KjE=;
        b=B2mxlj0lnjrlG6zX49vE7p9bjUH3hj8GjGCEfEHxDiqXia1thAlDBX5f/qsMmUOAu4Qftc
        o4RuZXJnb9wrZl0W7YiDuZZyBg42Pw2ymKPavVsBhowpGvW9dbt3+NqGz32xmKq5yFwwF4
        M4sO+X44fCxT6kgLeBxt6Og33awo4wo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-viXaEt5iNF6tq0J-nUDL7A-1; Wed, 09 Oct 2019 11:10:33 -0400
Received: by mail-wm1-f72.google.com with SMTP id g67so799878wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:10:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LxNQTZ3YeufmomqfUHsgwjNWfLwpx4ZrPxKfNiHSTCQ=;
        b=RcrNIWuwxH67WYl5L067qF/tHTzHWzxH4ekXmvSpP9ynEsYEHvZ94ea8dCHqddVWWG
         baVXrIWH5OsUMX//g2eksCI55QzsrExyQSLwpxcPDzi2Ke8BiUSMMUzH7BtT/UPskyVs
         vTqz71H6hPC9uataBVWmrsf5n2D48quPLyL/Ygb8pUsaHFdPjrPFXzT5ufPCsuScklqx
         ipl4y9JlJM32qd1XTx/bN0ql+sf2B0mLcj/1hdFpg4T2kEfo/ueEwHxnjODV6MPEn01y
         aevpbkNcKcaJjJf7u1hlJ1btAeT0DkaOJueGIEzAWKqGo7oZq/cA/6CoePeqoxBGwTIZ
         59Kg==
X-Gm-Message-State: APjAAAV4RiDoTww+fCbqoviU4WVRkdE1RIoOvEgIBrK7TLh+aaapWosk
        N5KJR/1Obz/3YWvhjY52AyqC99vcvSziHx6ONt/Fh2ZDfr99A7zcJLmScu5wE9a8XiUvZfRfead
        VgwKkbHQdSA0u1vF0w45F5pWN
X-Received: by 2002:a1c:a651:: with SMTP id p78mr3091154wme.53.1570633832723;
        Wed, 09 Oct 2019 08:10:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy2DKfpiOa0gDYGVHcI1QGzExxF+RjY57g4EvetJOtB+5T4xjb1JbF4tMF5HPiOYyOdwRBr+Q==
X-Received: by 2002:a1c:a651:: with SMTP id p78mr3091130wme.53.1570633832474;
        Wed, 09 Oct 2019 08:10:32 -0700 (PDT)
Received: from mcroce-redhat.mxp.redhat.com (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id e3sm2708136wme.39.2019.10.09.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 08:10:31 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: Add make dir-pkg build option
Date:   Wed,  9 Oct 2019 17:10:19 +0200
Message-Id: <20191009151019.13488-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-MC-Unique: viXaEt5iNF6tq0J-nUDL7A-1
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
 scripts/package/buildtar | 9 +++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

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
index 2f66c81e4021..ca283079f652 100755
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
@@ -133,6 +133,11 @@ if tar --owner=3Droot --group=3Droot --help >/dev/null=
 2>&1; then
 =09opts=3D"$opts --owner=3Droot --group=3Droot"
 fi
=20
+if [ "${1}" =3D dir-pkg ]; then
+=09echo "Kernel tree successfully created in $tmpdir"
+=09exit 0
+fi
+
 tar cf $tarball -C $tmpdir $opts $dirs
=20
 echo "Tarball successfully created in $tarball"
--=20
2.21.0

