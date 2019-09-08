Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93B0C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDEE21744
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 01:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUbVsBcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfIHB2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 21:28:25 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34231 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIHB2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 21:28:24 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so5665921pgc.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Sep 2019 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UQmPIIwegPGz83zJAyixQuensfgfppyDFNw1ZRwmARE=;
        b=qUbVsBcmH0kCMHpbVD0J8rKDB2eVbH6FL4rkfPBVRAYWOdJZ4ht+Fo6/CQN98y5lYk
         agBgVCHYGbexJ9XjDEW3lxskyAHgA5Ej+9B+6KYTArYjBlBCDOsWgceJLKqzK+3xJLrV
         giGW1D/OO8aRtbBR6Vbli3xx/zWS6ZtV0aWzDZ8tl5/pJRsfPGPxV9BAQSMPMLvbPk8b
         2kaPuY+cedl+TWibolEjYjEaMJ3Zle5ft2/eOy4BUj1sTEcsbiwfbzjHENlCO3jS2e9k
         ozW3N+r3I6YuGiJnO7iuRa8GGhtmyl4DLlj+OmXc7lufonKHaqGFJiuw0xfCob8fMj24
         LaDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQmPIIwegPGz83zJAyixQuensfgfppyDFNw1ZRwmARE=;
        b=LBiQPHe701UOKNDFGFhalO9Cp6uC5KCwwax3SAP/S9x7mKcKlZcgTBhG9RCrjptkTk
         ZZknZL9tKJ13H2ZbDb5epCio3KIHAr4iCZ2r00MZz7OWbLzlSTM3NxjpqksoLyz0A7e7
         QhaVtpN2K3FcqTvZY99Srzd77ETpaZeJi7YRp4QXBlB7UJqnGRA40DU9R97GeJMsQHpO
         TkluyvCAAqpmJlpqAKWA0LLHEwIvsW5qhMKWJW50lxwVHde5xL++kYLRC9ibIYX+5efl
         wrdRPX+e5Ddea6Dq0vzxu9e14qJ1L+h5Q5IZFUR8RdHqniAnNuewPPcOqZrZCb/+j3rL
         XZ+A==
X-Gm-Message-State: APjAAAUV6XyigzGNkLduruoa4isi1C9kNohzwEYGIGyo7/REqDOkDev/
        aeO7suEmnnHsJEiLB7zWybY=
X-Google-Smtp-Source: APXvYqynOr9m2w/R0nv3+tWdQ/O105ZBC46A9Ia77kwyjrZmNrYxEz56qeyuCkBrGsyHHJNaKcBGSA==
X-Received: by 2002:a63:6947:: with SMTP id e68mr15040995pgc.60.1567906103848;
        Sat, 07 Sep 2019 18:28:23 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id s1sm18367884pjs.31.2019.09.07.18.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 18:28:23 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 1/8] kconfig/hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'
Date:   Sun,  8 Sep 2019 09:27:53 +0800
Message-Id: <20190908012800.12979-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908012800.12979-1-changbin.du@gmail.com>
References: <20190908012800.12979-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Group generic kernel debugging instruments sysrq/kgdb/ubsan together into
a new submenu.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5960e2980a8a..868fa64a0901 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -419,6 +419,8 @@ config DEBUG_FORCE_WEAK_PER_CPU
 
 endmenu # "Compiler options"
 
+menu "Generic Kernel Debugging Instruments"
+
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on !UML
@@ -452,6 +454,12 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+source "lib/Kconfig.kgdb"
+
+source "lib/Kconfig.ubsan"
+
+endmenu
+
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
@@ -2099,10 +2107,6 @@ config BUG_ON_DATA_CORRUPTION
 
 source "samples/Kconfig"
 
-source "lib/Kconfig.kgdb"
-
-source "lib/Kconfig.ubsan"
-
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
-- 
2.20.1

