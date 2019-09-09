Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B97C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC50F2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX3llKcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbfIIOpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:45:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46281 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfIIOpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:45:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id m3so7938315pgv.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 07:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TVzAji3GW1QKfy7eDTvui/A8m2Rjy2R5WVJhQA7E3lY=;
        b=NX3llKcB9Vfz5GwB3fe8lqYrjLwk+0rBxImcX4jZV11gkkeNnudXWi9WTJ2LsF/dA9
         DpPaPmh+I8IoYZUHijkhyFRx2sbrMY6BU60KQMM1NngqyI0qEOCywLIbcuP+QO1LHH7y
         watq9wRRMsMDIBA2+nO9gngjJ+gro0eqYITydnA4HlQHkzAsl6hKnM/85AQoxq0KzdDU
         jOZlQhsiFaZq0XmEozny47pbhm4BpRC7jtYDEX42fqP6kpB8oMKe8yszFFUfJFbdkpwP
         5K14pP5MVMJR4UOh82ZlcWGcZtOq8ZFGYuD9LsChM/GPzGyPoNoRsunPaR5Gf7lPFtIF
         T6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TVzAji3GW1QKfy7eDTvui/A8m2Rjy2R5WVJhQA7E3lY=;
        b=Qv/n0qJ31kMEBgo30yFe1n1oXwRGiNObc4Vc6AZ45nEsXjygyJCuHG8bSEDxOLFLas
         tyxrG+xoMJpW5qx8f/869Aq6dRO/c7MmwXgpkD5guQTPAd9t+hjBd/0yOsr5D38iGdrm
         qgruzO0CKk3YrqhBDof7S/XNY1V2/6CufdfZOb06YQFuDgRH0rNwHethwa0KddA+SXlr
         /Yf3d5GDbrHCtz48F8akAZ48tEs1Xxj/SZPwouV1OebSMI1KFvGxeNmkjtgwvG5IWddp
         s7Q3tsJ2WbQEZDqdKuyBbKkPgIa2NUTFrNG/UMTIA7md/wrGUn6Ip1k5oS7IOYw8wSHk
         TM3A==
X-Gm-Message-State: APjAAAUCRXAHY/34gTn+lTPxUgNjQANHxJQmwwjUOf1iMJc6hBrQVYE4
        wuYnrSCdUaKmhKriH4I035U=
X-Google-Smtp-Source: APXvYqxiAhEjG4HZ/IFOCSeUKorah3JrKQ5eM6H+PJsFj7IK3XWu4Nsn334GnkakFyQuO6scOh8FsQ==
X-Received: by 2002:a63:ee08:: with SMTP id e8mr22406175pgi.70.1568040313430;
        Mon, 09 Sep 2019 07:45:13 -0700 (PDT)
Received: from localhost.localdomain ([149.28.153.17])
        by smtp.gmail.com with ESMTPSA id t9sm15334693pgj.89.2019.09.09.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:45:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 1/9] hacking: Group sysrq/kgdb/ubsan into 'Generic Kernel Debugging Instruments'
Date:   Mon,  9 Sep 2019 22:44:45 +0800
Message-Id: <20190909144453.3520-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909144453.3520-1-changbin.du@gmail.com>
References: <20190909144453.3520-1-changbin.du@gmail.com>
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
index 10023dbac8e4..bd3938483514 100644
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
@@ -2111,10 +2119,6 @@ config BUG_ON_DATA_CORRUPTION
 
 source "samples/Kconfig"
 
-source "lib/Kconfig.kgdb"
-
-source "lib/Kconfig.ubsan"
-
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
-- 
2.20.1

