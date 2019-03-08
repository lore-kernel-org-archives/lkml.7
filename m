Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D74C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E685A20854
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 09:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="M/jOhf7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfCHJPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 04:15:30 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:41836 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHJP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 04:15:26 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x289Dgtg011034;
        Fri, 8 Mar 2019 18:13:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x289Dgtg011034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552036423;
        bh=J5g9Gfl4sCC+dbt4osgG8WcQH8Dej03T5AiuXdbjW60=;
        h=From:To:Cc:Subject:Date:From;
        b=M/jOhf7ucJAEYTxn4QTduKP1KjtoFFGRTB6lWFmldLNrb4IOZJcHcVfwJopb5UKoy
         73Ly87ZznBGG41GZ5Mrp3YkmwAWkL7C433wSvvhZewD01QLWMqzcs+xmn3va/RJs6c
         1sSK1dMm1KA9A2mjDgas20pfMqGA6BhgcVXnV1cDbYEVdeDu+9tTf2HmI6rJ4q+gZj
         fMNIJ45l2M3Uf/zkoaz7lLT49YhsG/Tp+XkDaZyIC9L5keHL0qD3Szs/9EXj/qB+9E
         rORiStlYu6mkjVfTCRhoIbowl8hQ8rcW20AZa8zdRtoSmmjPUd2xwp+Vrb/U9EuF+1
         6BJYM4idTAkZA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Manoj Srivastava <srivasta@debian.org>,
        Liz Zhang <lizzha@microsoft.com>,
        Lili Deng <v-lide@microsoft.com>,
        Manoj Srivastava <manoj.srivastava.1962@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: add workaround for Debian make-kpkg
Date:   Fri,  8 Mar 2019 18:13:39 +0900
Message-Id: <1552036419-924-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 3812b8c5c5d5 ("kbuild: make -r/-R effective in top
Makefile for old Make versions"), make-kpkg is not working.

make-kpkg directly includes the top Makefile of Linux kernel, and
appends some debian_* targets.

  /usr/share/kernel-package/ruleset/kernel_version.mk:

    # Include the kernel makefile
    override dot-config := 1
    include Makefile
    dot-config := 1

I did not know the kernel Makefile was used in that way, and it is
hard to guarantee the behavior when the kernel Makefile is included
by another Makefile from a different project.

It looks like Debian Stretch stopped providing make-kpkg. Maybe it is
obsolete and being replaced with 'make deb-pkg' etc. but still widely
used.

This commit adds a workaround; if the top Makefile is included by
another Makefile, skip sub-make in order to make the main part visible.
'MAKEFLAGS += -rR' does not become effective for GNU Make < 4.0, but
Debian/Ubuntu is already using newer versions.

The effect of this commit:

  Debian 8 (Jessie)  : Fixed
  Debian 9 (Stretch) : make-kpkg (kernel-package) is not provided
  Ubuntu 14.04 LTS   : NOT Fixed
  Ubuntu 16.04 LTS   : Fixed
  Ubuntu 18.04 LTS   : Fixed

This commit cannot fix Ubuntu 14.04 because it installs GNU Make 3.81,
but its support will end in Apr 2019, which is before the Linux v5.1
release.

I added warning so that nobody would try to include the top Makefile.

Fixes: 3812b8c5c5d5 ("kbuild: make -r/-R effective in top Makefile for old Make versions")
Reported-by: Liz Zhang <lizzha@microsoft.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Tested-by: Lili Deng <v-lide@microsoft.com>
Cc: Manoj Srivastava <srivasta@debian.org>
---

Changes in v2:
  - Drop the unimportant comment about PowerPC

 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 4fb8896..6039685 100644
--- a/Makefile
+++ b/Makefile
@@ -31,6 +31,16 @@ _all:
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
+# Ugly workaround for Debian make-kpkg:
+# make-kpkg directly includes the top Makefile of Linux kernel. In such a case,
+# skip sub-make to support debian_* targets in ruleset/kernel_version.mk, but
+# displays warning to discourage such abusage.
+ifneq ($(word 2, $(MAKEFILE_LIST)),)
+$(warning Do not include top Makefile of Linux Kernel)
+sub-make-done := 1
+MAKEFLAGS += -rR
+endif
+
 ifneq ($(sub-make-done),1)
 
 # Do not use make's built-in rules and variables
-- 
2.7.4

