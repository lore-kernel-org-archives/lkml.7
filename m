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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFB5C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02187215EA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjNRnSU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732811AbfJDBVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:21:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51490 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732783AbfJDBU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id 7so3953984wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YqU65iM2qH8gUboTur4UrIo5rTm6nMUgwC8eweSFzNQ=;
        b=sjNRnSU3nbh+Qq/gSkfxHgphEf9rDxrJ/KFolrGvbwswGjZ1mFkw0p6TE6U7X0K0xB
         8K7qKw/eHsLHLdVKdVp6PKF+b6p/8dLWF2uyM2jr3MQmSQJHCcphCWrcFDkoKQ/sJv0G
         uPFQTo/TTTJTe7Kxi40/HEMKYSKKQiA3JdYQP64aN9sL2ghQn8fNGQIVD++lQ0e7b4O2
         +qY6UrT3iMcUnngcV1882UYvkB/r+ZY0rFpOmYC6RszD1/Kb9KoyLs/7j9dXzvseKn6c
         w1JJm2aD0UiWEY57u9b2SHexHdb6HGoJDDf1l2/hodvtqGJ6VRXfZv+XLtsPcxFF8IC9
         xB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YqU65iM2qH8gUboTur4UrIo5rTm6nMUgwC8eweSFzNQ=;
        b=UwFckWjWeGLT/8UDeDoZGxvstONC7KBLv53CWKiecOSKHq2z5XZkniSXOMN7dkLFUt
         44Gb0rGzpZfHgF8W1LhyIAbHTZom2cNptNZcFEQLqWWiOn4GPxR94B5yUpnbOlK7p64v
         mKoAz77b2OREhXvLhtHHZNyBXrrJLkRh+Ei/zVa/yIilZ/PwTLxne78FpPrR7UUKhWhP
         ZysY0Y7tTJOFF+tdgUKi3U0xhoo20sKNFkzeBkum8yRkL2DdS/pYJZX9FDish0awaAHw
         zbmKzD63wJSQ8lBJly85AybE/RMzwcjiQJ7UWluvWLWtukMyWlABTCgV8hx2CG0XErSH
         yjDw==
X-Gm-Message-State: APjAAAXgm+jKx8jkXmeSqQqxpd6MbFvMq+aHVx0MADov/QibF3+uAuUp
        Gvu9vfrJC8qE72tcSy1RKbw=
X-Google-Smtp-Source: APXvYqwsREZnQYjMvKf4455fq4MDmntRNwvAZ4Jn9eivJh2HZ4lNqfRAoHXzTUe7R0qNsmk0F0gmQQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr8580315wmk.11.1570152056172;
        Thu, 03 Oct 2019 18:20:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 8/9] hacking: Move DEBUG_BUGVERBOSE to 'printk and dmesg options'
Date:   Fri,  4 Oct 2019 09:20:09 +0800
Message-Id: <20191004012010.11287-9-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think DEBUG_BUGVERBOSE is a dmesg option which gives more debug info
to dmesg.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6db178071743..12727e12a28b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -164,6 +164,15 @@ config DYNAMIC_DEBUG
 	  See Documentation/admin-guide/dynamic-debug-howto.rst for additional
 	  information.
 
+config DEBUG_BUGVERBOSE
+	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
+	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
+	default y
+	help
+	  Say Y here to make BUG() panics output the file name and line number
+	  of the BUG call as well as the EIP and oops trace.  This aids
+	  debugging but costs about 70-100K of memory.
+
 endmenu # "printk and dmesg options"
 
 menu "Compile-time checks and compiler options"
@@ -1305,15 +1314,6 @@ config DEBUG_KOBJECT_RELEASE
 config HAVE_DEBUG_BUGVERBOSE
 	bool
 
-config DEBUG_BUGVERBOSE
-	bool "Verbose BUG() reporting (adds 70K)" if DEBUG_KERNEL && EXPERT
-	depends on BUG && (GENERIC_BUG || HAVE_DEBUG_BUGVERBOSE)
-	default y
-	help
-	  Say Y here to make BUG() panics output the file name and line number
-	  of the BUG call as well as the EIP and oops trace.  This aids
-	  debugging but costs about 70-100K of memory.
-
 menu "Debug kernel data structures"
 
 config DEBUG_LIST
-- 
2.20.1

