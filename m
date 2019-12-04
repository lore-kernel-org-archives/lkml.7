Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14447C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE40320675
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOCiY0JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfLDRyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:54:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51233 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbfLDRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:54:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id g206so672203wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 09:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv62CozvCA1B6P8J26EHB66T5kbk3JQPOnjXd+X5TW4=;
        b=vOCiY0JFlFJIOQ4t6cY7uj6DYbT/XQHPgmVwJBK58KtBnR1FKoGNsTcWdQ11AjcYJP
         Glk9PdpSMhfV06xy5ZdCmEAS8WfcawnjBqZFtA0STHLvFnf2Dm581iFqKn/LvmN8UO8l
         pZ6rDQ8geX2DvykxtCwazNXMkm3102e7bEslLqFfO0ooI+Qfu21/cGpy2z1L0jZI85Gk
         6s2RtLehmYLsqFf6Xsqwl1SRKkgZN5NQG//ENRxXVcWIMWP4aIGypyLpYQq8l3w2+FBC
         qQpQuwtprRfseuRnuS/KFKAAYMEDWTvPEhExLMsLszmTGBbID5ZBzy4KWxhSPzHlxBLh
         TDIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bv62CozvCA1B6P8J26EHB66T5kbk3JQPOnjXd+X5TW4=;
        b=jun8clvRFTWvc9HDhwZ315FA1EBBpq4LbzqqK2FwHP5mmGR6y/y0cDXyuE6HW6RrDS
         0DTV8z9Heie81FtrxpJIykJ1CgH6hUfCjQbQxE2Pi613n2hk8d1HAkYLs3FVu4vWHxMI
         aS0w99+TYjGMIA7jqITNQOyV76MI2V1DZTBRA6LS+LMxyJ98kwWjtuD9e4IMfu9z9JSC
         dYJhL9nLrYIkH9rWbLSWYU4EY9tcX98LWzCrut3jf16g4zQosuPlrSflkYbwS/T20ycA
         YbU16b9v9JuSb26LcZVPe4tT6cvLdSIVuL9gg/FX4KLvcv7K+0spOMhQiSoozOZ59lVx
         RT0w==
X-Gm-Message-State: APjAAAW5P/oDhvm467t2A+DXWZuQ7+WKzGt5Z47gRfboTrxGdNUF2XSk
        aMASvAdPSAA7oxW9emI7+eQ=
X-Google-Smtp-Source: APXvYqyceCn6Gp0C/kLGj6Vew2ePfjRGNgtHAXl98hIOMNq+0dwhCEImPUeHM2CaiHrC6X8BTOpVkQ==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr856058wme.89.1575482073493;
        Wed, 04 Dec 2019 09:54:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:404e:f500:ccf8:1f84:3636:b143])
        by smtp.gmail.com with ESMTPSA id t1sm8343990wma.43.2019.12.04.09.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 09:54:32 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix cast of gfp_t to ulong in __def_gfpflag_names
Date:   Wed,  4 Dec 2019 18:54:25 +0100
Message-Id: <20191204175425.71855-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro '__def_gfpflag_names' is used to define arrays of
struct trace_print_flags. This structure is defined as being
a pair of 'unsigned long' - 'const char *'.

However, the macro __def_gfpflag_names is used to for GFP flags
and thus take entries of type gfp_t (plus their name) which
is a bitwise type, non-convertible to usual integers.
These entries are casted to 'unsigned long' but this doesn't
prevent Sparse to rughtfully complain:
	warning: cast from restricted gfp_t

The correct way to cast a bitwise type to a normal integer
(which is OK here) is to use '__force'.

So, fix the cast by adding the '__force' required for such casts.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/trace/events/mmflags.h | 70 +++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d43777e..3b85bbf79115 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -14,41 +14,41 @@
  */
 
 #define __def_gfpflag_names						\
-	{(unsigned long)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
-	{(unsigned long)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
-	{(unsigned long)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
-	{(unsigned long)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
-	{(unsigned long)GFP_USER,		"GFP_USER"},		\
-	{(unsigned long)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
-	{(unsigned long)GFP_KERNEL,		"GFP_KERNEL"},		\
-	{(unsigned long)GFP_NOFS,		"GFP_NOFS"},		\
-	{(unsigned long)GFP_ATOMIC,		"GFP_ATOMIC"},		\
-	{(unsigned long)GFP_NOIO,		"GFP_NOIO"},		\
-	{(unsigned long)GFP_NOWAIT,		"GFP_NOWAIT"},		\
-	{(unsigned long)GFP_DMA,		"GFP_DMA"},		\
-	{(unsigned long)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
-	{(unsigned long)GFP_DMA32,		"GFP_DMA32"},		\
-	{(unsigned long)__GFP_HIGH,		"__GFP_HIGH"},		\
-	{(unsigned long)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
-	{(unsigned long)__GFP_IO,		"__GFP_IO"},		\
-	{(unsigned long)__GFP_FS,		"__GFP_FS"},		\
-	{(unsigned long)__GFP_NOWARN,		"__GFP_NOWARN"},	\
-	{(unsigned long)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
-	{(unsigned long)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
-	{(unsigned long)__GFP_NORETRY,		"__GFP_NORETRY"},	\
-	{(unsigned long)__GFP_COMP,		"__GFP_COMP"},		\
-	{(unsigned long)__GFP_ZERO,		"__GFP_ZERO"},		\
-	{(unsigned long)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
-	{(unsigned long)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
-	{(unsigned long)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
-	{(unsigned long)__GFP_THISNODE,		"__GFP_THISNODE"},	\
-	{(unsigned long)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
-	{(unsigned long)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
-	{(unsigned long)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
-	{(unsigned long)__GFP_WRITE,		"__GFP_WRITE"},		\
-	{(unsigned long)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
-	{(unsigned long)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
-	{(unsigned long)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
+	{(__force ulong)GFP_TRANSHUGE,		"GFP_TRANSHUGE"},	\
+	{(__force ulong)GFP_TRANSHUGE_LIGHT,	"GFP_TRANSHUGE_LIGHT"}, \
+	{(__force ulong)GFP_HIGHUSER_MOVABLE,	"GFP_HIGHUSER_MOVABLE"},\
+	{(__force ulong)GFP_HIGHUSER,		"GFP_HIGHUSER"},	\
+	{(__force ulong)GFP_USER,		"GFP_USER"},		\
+	{(__force ulong)GFP_KERNEL_ACCOUNT,	"GFP_KERNEL_ACCOUNT"},	\
+	{(__force ulong)GFP_KERNEL,		"GFP_KERNEL"},		\
+	{(__force ulong)GFP_NOFS,		"GFP_NOFS"},		\
+	{(__force ulong)GFP_ATOMIC,		"GFP_ATOMIC"},		\
+	{(__force ulong)GFP_NOIO,		"GFP_NOIO"},		\
+	{(__force ulong)GFP_NOWAIT,		"GFP_NOWAIT"},		\
+	{(__force ulong)GFP_DMA,		"GFP_DMA"},		\
+	{(__force ulong)__GFP_HIGHMEM,		"__GFP_HIGHMEM"},	\
+	{(__force ulong)GFP_DMA32,		"GFP_DMA32"},		\
+	{(__force ulong)__GFP_HIGH,		"__GFP_HIGH"},		\
+	{(__force ulong)__GFP_ATOMIC,		"__GFP_ATOMIC"},	\
+	{(__force ulong)__GFP_IO,		"__GFP_IO"},		\
+	{(__force ulong)__GFP_FS,		"__GFP_FS"},		\
+	{(__force ulong)__GFP_NOWARN,		"__GFP_NOWARN"},	\
+	{(__force ulong)__GFP_RETRY_MAYFAIL,	"__GFP_RETRY_MAYFAIL"},	\
+	{(__force ulong)__GFP_NOFAIL,		"__GFP_NOFAIL"},	\
+	{(__force ulong)__GFP_NORETRY,		"__GFP_NORETRY"},	\
+	{(__force ulong)__GFP_COMP,		"__GFP_COMP"},		\
+	{(__force ulong)__GFP_ZERO,		"__GFP_ZERO"},		\
+	{(__force ulong)__GFP_NOMEMALLOC,	"__GFP_NOMEMALLOC"},	\
+	{(__force ulong)__GFP_MEMALLOC,		"__GFP_MEMALLOC"},	\
+	{(__force ulong)__GFP_HARDWALL,		"__GFP_HARDWALL"},	\
+	{(__force ulong)__GFP_THISNODE,		"__GFP_THISNODE"},	\
+	{(__force ulong)__GFP_RECLAIMABLE,	"__GFP_RECLAIMABLE"},	\
+	{(__force ulong)__GFP_MOVABLE,		"__GFP_MOVABLE"},	\
+	{(__force ulong)__GFP_ACCOUNT,		"__GFP_ACCOUNT"},	\
+	{(__force ulong)__GFP_WRITE,		"__GFP_WRITE"},		\
+	{(__force ulong)__GFP_RECLAIM,		"__GFP_RECLAIM"},	\
+	{(__force ulong)__GFP_DIRECT_RECLAIM,	"__GFP_DIRECT_RECLAIM"},\
+	{(__force ulong)__GFP_KSWAPD_RECLAIM,	"__GFP_KSWAPD_RECLAIM"}\
 
 #define show_gfp_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-- 
2.24.0

