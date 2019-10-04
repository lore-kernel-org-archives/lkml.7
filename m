Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7A4C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B75208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlghlkVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfJDBVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:21:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44525 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731860AbfJDBVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:21:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id z9so4903397wrl.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KG0ezs+b9rI/gjrdngdJh2WIuRvdCqz/n29uB7/zJto=;
        b=YlghlkVkA7qOIJy8Cm29fBlWjbmjspe7213n9yGIHtVF7hT6TJqcKaIAjJscKNyLPg
         r3BjXO/lg1qZPfVoMvfjUb4nrx3WhOS6OdELed4VKCRfy/Y/x8QdT+ApbJtdBSeSGDHn
         NRGguTqW9dpvev+iY0FwHdBHTSGpF3gzVqJ6rT2s52ReE5PTQk7K8uZPwjgW1riYRRxq
         OsG0iU21ojSiwajTUqklCMYW+9rhPjBgEdRDd2tNaDh7O7cyH2mh1KxV81AyaiV2BfZE
         /zIBdR5eaENsFzfYGA2i4VSpkTJx5XCblouSHH5W/bQFKm97NxjiRlTW+UL8nwEWC5zl
         BovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KG0ezs+b9rI/gjrdngdJh2WIuRvdCqz/n29uB7/zJto=;
        b=AjMIBZek9BGTX6NTorq77c87FvMqRgT62ty03uIsqJ5yyHgx05UrmhWTPmgUufYCOm
         xJCHAs6Myjyj14aW4MR72Pza3Y5Ds31oNnvErdN72aWaOzYqB6d/zjBBwGqJAOGOHdQH
         NnZ9p9CwEMMTPImF8/Q1n7y/ZQ5hHrcuO/GWOfSNV6MQ1W9ODAY31RSeH3Tg2hMs/EjQ
         gjntlolVNHUbrmluNKWMpDed98mLDB2o2pcDdeM56E7HbjBaPxep3cXbc+Be6GBXAhWO
         99sZgTUdsHMgvoHhnxPRVwqZQOshrVB1yeJz911MTVXkeG7qov1xvfyIC6XBYyLaz0q+
         /ciA==
X-Gm-Message-State: APjAAAV5Oa8VeoUJyxsZ/wJTZEUEsCxzt8lO/8YyZU420BeqPCFekqyE
        6OgLH9Jum8Qv6yySDDe8y7vX/wwCR5Z+KA==
X-Google-Smtp-Source: APXvYqxMx8kRAaR0oXAV8VE2fW5HQq9l86dUvU717rlccEItLRvk4rVkxzAX1w0XoVm8OrgN7YO31Q==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr5137124wrr.23.1570152059785;
        Thu, 03 Oct 2019 18:20:59 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:59 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 9/9] hacking: Move DEBUG_FS to 'Generic Kernel Debugging Instruments'
Date:   Fri,  4 Oct 2019 09:20:10 +0800
Message-Id: <20191004012010.11287-10-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DEBUG_FS does not belong to 'Compile-time checks and compiler options'.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 12727e12a28b..82cb1bcf07a8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -286,18 +286,6 @@ config READABLE_ASM
           to keep kernel developers who have to stare a lot at assembler listings
           sane.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  For detailed documentation on the debugfs API, see
-	  Documentation/filesystems/.
-
-	  If unsure, say N.
-
 config HEADERS_INSTALL
 	bool "Install uapi headers to usr/include"
 	depends on !UML
@@ -445,6 +433,18 @@ config MAGIC_SYSRQ_SERIAL
 	  This option allows you to decide whether you want to enable the
 	  magic SysRq key.
 
+config DEBUG_FS
+	bool "Debug Filesystem"
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  For detailed documentation on the debugfs API, see
+	  Documentation/filesystems/.
+
+	  If unsure, say N.
+
 source "lib/Kconfig.kgdb"
 
 source "lib/Kconfig.ubsan"
-- 
2.20.1

