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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9581C10F14
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0CE208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 01:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vLpQ7mt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbfJDBUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 21:20:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46752 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732698AbfJDBUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 21:20:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id o18so4888376wrv.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 18:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUAonWj+crtkdXG/WWKIValoecqHVHH6udCzw0FtFkA=;
        b=vLpQ7mt3ThQb0VSxXv49DD4KXlBDUNrlQmJp0dM20xHrM7td1QN4D7E3RNX0OHcRlu
         8V37WKkj94esobZIItKhQneuIdxzi7hufucFjV0REHpXBKZtK0uGqClaCBwXTNZoZta8
         uhJfuyA/alk6gF5CzPBB4KFu04OdtcBs8d098NlgITGIxeclz6dz2LwPgX5243ogjbsG
         T4/OeqMAzLf6x2kqOcpdLjSAXcVHWmWOt//XIZjfPauEzvjg7RLVIC2hVvfNP5QSxs/j
         B1j2tc04vGHjdpZvxe9J/ThuInnQB4gkSwxdiOSI+ZCHGPC7tbawnJAZ1dI7O2IiMmbU
         46pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUAonWj+crtkdXG/WWKIValoecqHVHH6udCzw0FtFkA=;
        b=W3L6wW+b8cD/XRO0JNbjVH6GOBszZrvOtC3K4/aT45jIv7d1NvPTVox202YAG770k9
         8yAit2whaw3aOX5TIa5lQTt9c24z+4/VsXL2SpNfyvlsUE5C/DrDk050cTdopExA6W1d
         n2LF8rw9ij+AuSFE2rt5HXq9hvXTctzktbc+PQoHCHTCDqbBD96r3eOSuDJAA2fBIBpt
         1ikHJFp3rHQ6ZMFKKifxsx35/IKGu62rMjxEeS6NxSS9xC6ZF7IvDP7ROi3nNTv3BtZK
         kvUWjfMH0bgPsnYUgohyh2FQ4vixMUUY7UIE46auW7leV/HC0Mtomuc/ki3Cv5aLUsei
         55HA==
X-Gm-Message-State: APjAAAWl49HWQ9dQHyzuXY+hqMf7PzgpMtbltVrrQnF0VE7NXa+ANAJq
        JL/fpSnNY6ZIjU7zG8ZLtZAT4NB+dANqYQ==
X-Google-Smtp-Source: APXvYqzmE/7+G/TNlgdVxbF34gURdIGzZm+D6rwY1er+oIdfx5HC05wpQ+Q2xajsIvx0B2hYjNEpXw==
X-Received: by 2002:adf:eec5:: with SMTP id a5mr5127263wrp.191.1570152048538;
        Thu, 03 Oct 2019 18:20:48 -0700 (PDT)
Received: from localhost.localdomain ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id a4sm4097404wmm.10.2019.10.03.18.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 18:20:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [RESEND PATCH v3 6/9] hacking: Move SCHED_STACK_END_CHECK after DEBUG_STACK_USAGE
Date:   Fri,  4 Oct 2019 09:20:07 +0800
Message-Id: <20191004012010.11287-7-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004012010.11287-1-changbin.du@gmail.com>
References: <20191004012010.11287-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are both memory debug options to debug kernel stack issues.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
---
 lib/Kconfig.debug | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 389876ee49d8..2cf52b3b5726 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -634,6 +634,18 @@ config DEBUG_STACK_USAGE
 
 	  This option will slow down process creation somewhat.
 
+config SCHED_STACK_END_CHECK
+	bool "Detect stack corruption on calls to schedule()"
+	depends on DEBUG_KERNEL
+	default n
+	help
+	  This option checks for a stack overrun on calls to schedule().
+	  If the stack end location is found to be over written always panic as
+	  the content of the corrupted region can no longer be trusted.
+	  This is to ensure no erroneous behaviour occurs which could result in
+	  data corruption or a sporadic crash at a later stage once the region
+	  is examined. The runtime overhead introduced is minimal.
+
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -987,18 +999,6 @@ config SCHEDSTATS
 	  application, you can say N to avoid the very slight overhead
 	  this adds.
 
-config SCHED_STACK_END_CHECK
-	bool "Detect stack corruption on calls to schedule()"
-	depends on DEBUG_KERNEL
-	default n
-	help
-	  This option checks for a stack overrun on calls to schedule().
-	  If the stack end location is found to be over written always panic as
-	  the content of the corrupted region can no longer be trusted.
-	  This is to ensure no erroneous behaviour occurs which could result in
-	  data corruption or a sporadic crash at a later stage once the region
-	  is examined. The runtime overhead introduced is minimal.
-
 config DEBUG_TIMEKEEPING
 	bool "Enable extra timekeeping sanity checking"
 	help
-- 
2.20.1

