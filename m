Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4341C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43D42086A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 03:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bq63Rjrh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfD0DeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 23:34:04 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:17158 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfD0Ddv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 23:33:51 -0400
Received: from grover.flets-west.jp (softbank126125154137.bbtec.net [126.125.154.137]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3R3Xie8029345;
        Sat, 27 Apr 2019 12:33:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3R3Xie8029345
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556336025;
        bh=pcu/osjIIRg4wqmdG4C8oYhKJp+1QGehdijvvPa7Egw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bq63RjrhoukXHGubhkNvEfUaft0eyvGmY9rS9Q7HooEhOSBtyEOOTmLZtmNTkPnJW
         8TVOwcxc6A7ZhbgM14dsD3LD6Wu8B71jAPB8qQLMVjTwRjmkZ2Tzxwm7BmUu8DL8tT
         UqADqGKklaSr19xMvzFwiTJKaS2BMghMvGfU4MdG+SDW4f8xt9eE5kMnJToiPvU1lT
         fUYPhqmIraWSqLxomeKMX+De60HGZrIdbEaKAQEkc7MSEBVeK3O4GymhmCLu8aygSD
         4Fw9XKh/HNup0GZOt9Dg8i2aqUhr1O6exPE3mMc0wGDwPzE3p2PiR7AWr0t0qd1fmx
         6dfVtbpw+Fh9g==
X-Nifty-SrcIP: [126.125.154.137]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kbuild: move Documentation to vmlinux-alldirs
Date:   Sat, 27 Apr 2019 12:33:37 +0900
Message-Id: <1556336020-15634-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
References: <1556336020-15634-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minor code cleanup.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 251ded5..334ef8a 100644
--- a/Makefile
+++ b/Makefile
@@ -988,8 +988,9 @@ vmlinux-dirs	:= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \
 		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \
 		     $(net-y) $(net-m) $(libs-y) $(libs-m) $(virt-y)))
 
-vmlinux-alldirs	:= $(sort $(vmlinux-dirs) $(patsubst %/,%,$(filter %/, \
-		     $(init-) $(core-) $(drivers-) $(net-) $(libs-) $(virt-))))
+vmlinux-alldirs	:= $(sort $(vmlinux-dirs) Documentation \
+		     $(patsubst %/,%,$(filter %/, $(init-) $(core-) \
+			$(drivers-) $(net-) $(libs-) $(virt-))))
 
 init-y		:= $(patsubst %/, %/built-in.a, $(init-y))
 core-y		:= $(patsubst %/, %/built-in.a, $(core-y))
@@ -1006,7 +1007,7 @@ export KBUILD_VMLINUX_LIBS := $(libs-y1)
 export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
 export LDFLAGS_vmlinux
 # used by scripts/package/Makefile
-export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include scripts tools)
+export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch include scripts tools)
 
 vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS)
 
@@ -1360,7 +1361,7 @@ MRPROPER_FILES += .config .config.old .version \
 #
 clean: rm-dirs  := $(CLEAN_DIRS)
 clean: rm-files := $(CLEAN_FILES)
-clean-dirs      := $(addprefix _clean_, . $(vmlinux-alldirs) Documentation)
+clean-dirs      := $(addprefix _clean_, . $(vmlinux-alldirs))
 
 PHONY += $(clean-dirs) clean archclean vmlinuxclean
 $(clean-dirs):
-- 
2.7.4

