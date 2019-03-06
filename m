Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E1C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DB820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 16:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="d4djSLsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfCFQB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 11:01:27 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:59956 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCFQB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 11:01:26 -0500
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x26G0cMQ009811;
        Thu, 7 Mar 2019 01:00:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x26G0cMQ009811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551888039;
        bh=rzANvPh7XYNdT8fbWCbuqmzMaV3KolLp8OdfjmAjmsE=;
        h=From:To:Cc:Subject:Date:From;
        b=d4djSLsLYf5lmboBlQODP5KPdaAhPXrUcK1UUHNSsWb5owLU5toq7N/1JSpwPnNO4
         Bql7dPL7u/ngMD12Eq2ZVr2KAB+JBeFJrrzuCIHGNUDuSvkPbwaeUiaRwP16qHnigz
         yFNl+oX7xzfRvERww77R5OeJcrMHdxMc1qJWe3HLTCCejj+puN5TUPTTk7T8wLk5UI
         jDQ21NiYiA1MNj7AlD4XgTftloBYAkKMZzIvke3Gd4h2x/hDYNEJ9DXnJJOtGe2VDX
         2g9o29ujTlYQeawUMMuQdbytDQmqGjvTc93Z6af23vzRd/Zp9muB/U3J7Yh72SjNl5
         94XToxpTmlehQ==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Liz Zhang <lizzha@microsoft.com>, Lili Deng <v-lide@microsoft.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Riku Voipio <riku.voipio@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add workaround for Debian make-kpkg
Date:   Thu,  7 Mar 2019 01:00:35 +0900
Message-Id: <1551888035-13329-1-git-send-email-yamada.masahiro@socionext.com>
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

Looks like Debian Stretch stopped providing make-kpkg (except PowerPC).
Maybe it is obsolete and being replaced with 'make deb-pkg' etc.
but still widely used.

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
---

 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index ef4b32c..925d870 100644
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

