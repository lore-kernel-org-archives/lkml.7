Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95673233FF
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 22:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJ7AtSw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfH1W4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 18:56:08 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:39682 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfH1W4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 18:56:06 -0400
Received: by mail-pg1-f202.google.com with SMTP id t19so774135pgh.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 15:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qtui76zbZDjBR4fv6nr88v7Tjsdi7Bt5xxDWhf7dUos=;
        b=hJ7AtSw7RjbmYX/4R+147PAQ5c/xVAItZshRqnnBzQSOhDicW/bPFv8afrFf/d1GbS
         IKX+9zhUwUSqUKnOptDQ7uNuRc7loUh+PoppdolKnauSOl6afFZN+rECJ4kh2E3xymtD
         NB76hryMlcotA7rkZtbtd4CNoL79uGkF/5gLe1WjYhStWWppuWUG8T05Q0I35bLgI8MV
         PwpM6hhIu4pn0Q8JYY68lIQEh2KlBXC1y3rYsrkixwfa2XZPQ9WR4f64e+fhhsMGuqEb
         Tr0aQAtVcRIWLZYDklwU3hnLdDaufp7pohDsNKsHn2GVExBpyrJTExR/NVUyAkr1v4KY
         BNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qtui76zbZDjBR4fv6nr88v7Tjsdi7Bt5xxDWhf7dUos=;
        b=UnCMZ6bPdaF61gPFjkATNdd49NuNcoebTQLICF+ZPDX+LibtK37rj/n7p2Q77+MM/k
         qehYiHUhfJE4DlVZhcvWUugbhWAsAsWHtyI0qSJHX2CTD2v222o+RpSFHZeYbv1kRBHS
         NcTkL0Y275FjS3IjR9XC0x2iTZRT5Ya3UbrJvDK+EjZfWH8aO70zjoiN7nfvPiGUxmx8
         UYAmpyJoCAeBio/KDKQgqGEUr31VJu0zT86LqFGV5V3XAcim9OJ1mI1lXSIaKXM4WqHM
         x524ZtOdwA02RFeaxT3aFWl82Mb/tFt07ahyIspC1O6sc4v/gfFE6nfpIxicRD1K41bj
         87/w==
X-Gm-Message-State: APjAAAVtPX+Zh3mELsidGktvDczXTg3eaJFj4u5PV3m/A/v/Rn+jIB7a
        Antn9xan9drx/vFu1vzG7/Obxhq4I38XnVU4XzI=
X-Google-Smtp-Source: APXvYqxhDs3boqgtF/Mg/oAdDvf6XtcKt/phH2xyKxBDtEtbb0KHRKV02W+dZOFQry8G2yp9I/8fLNq03tWOqp5eC/o=
X-Received: by 2002:a63:1020:: with SMTP id f32mr5719226pgl.203.1567032965505;
 Wed, 28 Aug 2019 15:56:05 -0700 (PDT)
Date:   Wed, 28 Aug 2019 15:55:24 -0700
In-Reply-To: <20190828225535.49592-1-ndesaulniers@google.com>
Message-Id: <20190828225535.49592-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190828225535.49592-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v3 03/14] parisc: prefer __section from compiler_attributes.h
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     miguel.ojeda.sandonis@gmail.com
Cc:     sedat.dilek@gmail.com, will@kernel.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, davem@davemloft.net,
        paul.burton@mips.com, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

Instead, we should:
1. Prefer __section(.section_name_no_quotes).
2. Only use __attribute__((__section__(".section"))) when creating the
section name via C preprocessor (see the definition of __define_initcall
in arch/um/include/shared/init.h).

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

See the discussions in:
Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Link: https://marc.info/?l=linux-netdev&m=156412960619946&w=2
Link: https://github.com/ClangBuiltLinux/linux/issues/619
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/parisc/include/asm/cache.h | 2 +-
 arch/parisc/include/asm/ldcw.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/cache.h b/arch/parisc/include/asm/cache.h
index 73ca89a47f49..e5de3f897633 100644
--- a/arch/parisc/include/asm/cache.h
+++ b/arch/parisc/include/asm/cache.h
@@ -22,7 +22,7 @@
 
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 
-#define __read_mostly __attribute__((__section__(".data..read_mostly")))
+#define __read_mostly __section(.data..read_mostly)
 
 void parisc_cache_init(void);	/* initializes cache-flushing */
 void disable_sr_hashing_asm(int); /* low level support for above */
diff --git a/arch/parisc/include/asm/ldcw.h b/arch/parisc/include/asm/ldcw.h
index 3eb4bfc1fb36..e080143e79a3 100644
--- a/arch/parisc/include/asm/ldcw.h
+++ b/arch/parisc/include/asm/ldcw.h
@@ -52,7 +52,7 @@
 })
 
 #ifdef CONFIG_SMP
-# define __lock_aligned __attribute__((__section__(".data..lock_aligned")))
+# define __lock_aligned __section(.data..lock_aligned)
 #endif
 
 #endif /* __PARISC_LDCW_H */
-- 
2.23.0.187.g17f5b7556c-goog

