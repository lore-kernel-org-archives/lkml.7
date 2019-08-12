Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E866C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0BE12075B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lzYAmOqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfHLVtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:49:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfHLVtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:49:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id i30so1658639pfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SxB55hS+dMxQE9HtSOzkt2R+4Ww8VTS/3uqSYLsuna8=;
        b=lzYAmOqbwT9CeDgDl15mFv5TdBb1wbf3WeSr2Od/BcCxri4TcJpC4oGHXsxNo+nIm9
         4UY8TGtG+c1GNcfBP3jlGRMkahWtZ8KjXFAcMh3FPNN2djLS0KjYin05hlqnu4Y5wal7
         S1qgMuIvQsiN1lVji4aUaHXHcMySssMiixIkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SxB55hS+dMxQE9HtSOzkt2R+4Ww8VTS/3uqSYLsuna8=;
        b=DG+FL/PKJILt3MoWMyhk1NEfVJANvBqjSXh/RYjmvu2N+8wPm5U5l7yqOzN+gD4I3j
         5ulK7fk3BKhixqJZnroazF1uZJ8tLfRZPjBb4JBbIHDj92ulfHeo9fGagfqSYMjoVSqA
         oIqgHxOpqG6f7qg5rSyE+Vb9bMITVUA1680DA8Mmgi4+mfGTjWAV+ggWE8AJ+LAryJvJ
         eQm+1xa8ULi3OcAbl/3eEyF1mbUvaqJcEp9gVPjFbHQprXqNmGYFX3Y1WTt1j706g74A
         bm5+mQjL/UVPpe7TIx0JcudpZXlsz78tEJjFBbJ70RlEx0B6JIGk3Mq4tXF/Wse2TSP3
         yWig==
X-Gm-Message-State: APjAAAWxjiFdsJ2bWkjr8u6Ns6Mt1FelGO0QQI1seQ+B87ajaJPVIk2V
        ZzRJ09Cl1187tIcH5xXdNO6nYyCN+sU=
X-Google-Smtp-Source: APXvYqyLfuIW+ob8nSQJagwEjJ+GYX0/WNpe63lBYSawHUQh2XGtOWLZsLANqss4+EgGiW1AD5Ae9g==
X-Received: by 2002:a17:90a:9903:: with SMTP id b3mr1250682pjp.80.1565646553526;
        Mon, 12 Aug 2019 14:49:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c71sm3236846pfc.106.2019.08.12.14.49.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 14:49:12 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:49:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH] kbuild: Parameterize kallsyms generation and correct
 reporting
Message-ID: <201908121448.4D023D7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kallsyms generation happens, temporary vmlinux outputs are linked
but the quiet make output doesn't report it, giving the impression that
the prior command is taking longer than expected.

Instead, report the KSYM step before the temporary linking. While at it,
this consolidates the repeated "kallsyms generation step" into a single
function and removes the existing copy/pasting.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 96b6c0233a61..ed52be015523 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -170,7 +170,6 @@ gen_btf()
 # Create ${2} .o file with all symbols from the ${1} object file
 kallsyms()
 {
-	info KSYM ${2}
 	local kallsymopt;
 
 	if [ -n "${CONFIG_KALLSYMS_ALL}" ]; then
@@ -277,7 +276,22 @@ info MODINFO modules.builtin.modinfo
 ${OBJCOPY} -j .modinfo -O binary vmlinux.o modules.builtin.modinfo
 
 kallsymso=""
+kallsymso_previous=""
 kallsyms_vmlinux=""
+
+# Perform one step in kallsyms generation, including temporary linking of
+# vmlinux.
+kallsyms_step()
+{
+	kallsymso_previous=${kallsymso}
+	kallsymso=.tmp_kallsyms${1}.o
+	kallsyms_vmlinux=.tmp_vmlinux${1}
+
+	info KSYM ${kallsymso}
+	vmlinux_link "${kallsymso_previous}" ${kallsyms_vmlinux}
+	kallsyms ${kallsyms_vmlinux} ${kallsymso}
+}
+
 if [ -n "${CONFIG_KALLSYMS}" ]; then
 
 	# kallsyms support
@@ -303,28 +317,15 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 	# a)  Verify that the System.map from vmlinux matches the map from
 	#     ${kallsymso}.
 
-	kallsymso=.tmp_kallsyms2.o
-	kallsyms_vmlinux=.tmp_vmlinux2
-
-	# step 1
-	vmlinux_link "" .tmp_vmlinux1
-	kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
-
-	# step 2
-	vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
-	kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
+	kallsyms_step 1
+	kallsyms_step 2
 
 	# step 3
-	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" .tmp_kallsyms1.o)
-	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" .tmp_kallsyms2.o)
+	size1=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso_previous})
+	size2=$(${CONFIG_SHELL} "${srctree}/scripts/file-size.sh" ${kallsymso})
 
 	if [ $size1 -ne $size2 ] || [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
-		kallsymso=.tmp_kallsyms3.o
-		kallsyms_vmlinux=.tmp_vmlinux3
-
-		vmlinux_link .tmp_kallsyms2.o .tmp_vmlinux3
-
-		kallsyms .tmp_vmlinux3 .tmp_kallsyms3.o
+		kallsyms_step 3
 	fi
 fi
 
-- 
2.17.1


-- 
Kees Cook
