Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014D1C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9600222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ysX/vDA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfIZJdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:33:22 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35176 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfIZJdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:33:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id v8so1912149wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJ85dfscMDqrBZDgXpbqcnqJ8k34cVdqxeeH5KJixiU=;
        b=ysX/vDA1lodYeyDQtfZn53DOv9OAv0X8fbb1bprYw5jXG3TSGeYTvdUIAjlLEx3VWP
         XbeoGxqcUTQuImigCfBWKU9yNkKR+/sbRZ5KFIcTrlicfILlY+AQiQwVCOzADBA93TPn
         k+M8g73kgMs+qLz8Iqct4dBKkEr4PobMsOdnOc+/eX9xb2VtvZyKyn393yqe92T0o4j3
         mptU4DBwlnKdMxxTE10z9TwFKHIOvE2uHQ5vfS2MGEaG46R8+tCFfWIj8rTld4INQTZt
         Q/ctQ/mtblnRd8EJivE8MykzL6K2vGPhNGzyXrDN2eO2DkeeFsg5YRcYitoWVNBd+CYC
         QPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJ85dfscMDqrBZDgXpbqcnqJ8k34cVdqxeeH5KJixiU=;
        b=aM1Gsawm/wqgJIUY9PwwYfZhOQP+VMxrs/qYcHsa110Hr2lkVdBnjjgUDiCfQ1IAeY
         K1blK9pEN8/XjWdWrteeUBF1d5RZYW1LxDZ9Xv7296lKxybSiECkPzkkdRwkZQIx6Vgp
         U44Wik5opRazKf08hqsVQhWXaWz2ev0qmyyLTDR6c5ikTh7yrrTM1VPEuBXo7ddk7oZk
         UDoxzfIGQykz02EaKwpF9sMTJrUbk/59Q36v89yjdqJc1ApustaM75OHgb61bHL3ZdBl
         gRMhjY6Po/zUTlUxWtn6W1u6pfvddfT0LDF4jw/0qkdw7sDQZDGQmx/7Qljakr/4Ogta
         hM6g==
X-Gm-Message-State: APjAAAU5V6zoWSSaYZkl6OMp6kDJ8+sSXI6Y1LZVjq4YXphqVWi9/Nsh
        rpsGY9Y95/neaFMgp84U2vnMDMHzrsg=
X-Google-Smtp-Source: APXvYqw/qH4aB14JwZW8WSESoYcgUJKAAqhqHKalb7z9KOaJgGxpWD0ZU3zXq8GCnRsa6PhYuwdgMQ==
X-Received: by 2002:a05:6000:1281:: with SMTP id f1mr2154922wrx.247.1569490399073;
        Thu, 26 Sep 2019 02:33:19 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
        by smtp.gmail.com with ESMTPSA id h9sm1808020wrv.30.2019.09.26.02.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:33:17 -0700 (PDT)
From:   Ross Burton <ross.burton@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bruce.ashfield@gmail.com, bp@alien8.de
Subject: [PATCH v2] arch/x86/boot: use prefix map to avoid embedded paths
Date:   Thu, 26 Sep 2019 10:32:26 +0100
Message-Id: <20190926093226.8568-1-ross.burton@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bruce Ashfield <bruce.ashfield@gmail.com>

It was observed that the kernel embeds the path in the x86 boot
artifacts.

From https://bugzilla.yoctoproject.org/show_bug.cgi?id=13458:

[
   If you turn on the buildpaths QA test, or try a reproducible build, you
   discover that the kernel image contains build paths.

   $ strings bzImage-5.0.19-yocto-standard |grep tmp/
   out of pgt_buf in
   /data/poky-tmp/reproducible/tmp/work-shared/qemux86-64/kernel-source/arch/x86/boot/compressed/kaslr_64.c!?

   But what's this in the top-level Makefile:

   $ git grep prefix-map
   Makefile:KBUILD_CFLAGS  += $(call
   cc-option,-fmacro-prefix-map=$(srctree)/=)

   So the __FILE__ shouldn't be using the full path.  However
   arch/x86/boot/compressed/Makefile has this:

   KBUILD_CFLAGS := -m$(BITS) -O2

   So that clears KBUILD_FLAGS, removing the -fmacro-prefix-map option.
]

Other architectures do not clear the flags, but instead prune before
adding boot or specific options. There's no obvious reason why x86 isn't
doing the same thing (pruning vs clearing) and no build or boot issues
have been observed.

So we make x86 can do the same thing, and we no longer have embedded paths.

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 arch/x86/boot/Makefile            | 1 +
 arch/x86/boot/compressed/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5c246c..cd9c56496106 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -66,6 +66,7 @@ clean-files += cpustr.h
 # ---------------------------------------------------------------------------
 
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
+KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afdd7538..b246f18c5857 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
-- 
2.20.1

