Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E31C432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885A1222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 09:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HDnWCsyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbfIZJLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 05:11:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50283 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfIZJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 05:11:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id 5so1818545wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 02:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvlClry7u7XrfGIVsfJ+TjM0+OzUnx/9VnLu9RuXPxE=;
        b=HDnWCsyWuMRI0mLG/7gMEhhik8MvA1Tz46EzqLquUWfr7VTeW5joimm4bIwU9cZf7x
         L2VDgW4g/sueve9OFN9PyHt3W64X5i3q1Nq5T49n5uCkqcdM4Ra20F5v7YHJvmmqlwCZ
         op5sXml/au4o6Wb0aNR6PrBohasuofJRqa6a0Y1cIAVQx330TxKpDkc9N2c7b0+WdvGf
         bOZRD4jxBlUNm0NZB5J14U04KQDbJ7BF78dXLJuUsDitR8Z6Nvatkse9ar8ufN031aB6
         4YfePqfcxlCQIptELuPS0j/J85XKiszJWJDbBKdiMpMi6SceOS2hjcj5Ym2D/3wE7aIW
         jpWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NvlClry7u7XrfGIVsfJ+TjM0+OzUnx/9VnLu9RuXPxE=;
        b=NCwT5+VBsm87G0JbJp4Gr05dy0IGudnLwzpGcvuVJOaIjAsvCW9bxuK21V7jxduagb
         fBTo4xSPqRJbV4ihRKPHJTovkfh0dP1lWQdyL1cdgoWfRhOcRC9fHjseKgf8o5sPB/X9
         SAAnzgMmjykxGRuvY4zN+1q/xwlqjFBEasUBZXU7wpPgoqEXMhvnDXeXiyLHjsbgWaKf
         ucZeyfF+insSNfvUpZuMK91u4TC1g+JuGGpGibGjnO+lv5ouQ3y6G3R4YKk/1OefLcd7
         ZIkOm/9AVERvBlvKMH+ulW84/KyCMoequHrPAcgcJeeQVojv1XZixfjIGZZajux69XwX
         p6Kw==
X-Gm-Message-State: APjAAAWVl3YyO4ikhSC3psj3jRZcyDSlfXjk/739ElOP0Wr8MpjNQpIf
        eplTsaFacrAqX7TV8hEUNdF/6PAsBFc=
X-Google-Smtp-Source: APXvYqzt9vQs2kwjHGDHTQIwhxjlF5ljsO+4VEFVjJaJ4vavi9pJr7B9bYNgMlw5HFGexb3OXZKeKA==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr2144290wmh.19.1569489073735;
        Thu, 26 Sep 2019 02:11:13 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
        by smtp.gmail.com with ESMTPSA id a10sm1886935wrm.52.2019.09.26.02.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 02:11:12 -0700 (PDT)
From:   Ross Burton <ross.burton@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bruce.ashfield@gmail.com
Subject: [PATCH] arch/x86/boot: use prefix map to avoid embedded paths
Date:   Thu, 26 Sep 2019 10:11:04 +0100
Message-Id: <20190926091104.3762-1-ross.burton@intel.com>
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
 arch/x86/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

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

