Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92402C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618F4214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbL/GmLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfDWGZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:25:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42264 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDWGZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:25:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id w25so6924913pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6XzPsxxN8b6uMru/eDEDCwc0UWRn8N/+CAQtdHTzt8M=;
        b=bbL/GmLLu4JeD4lq4jZjm7oRW/WpzAPSxEmpWqO8pht1URvea6+J+mA5uWSRk32uXJ
         21tWMrAxUiEFbjHx/4QxAVYReVcElLPEZYEm9mnxseKePBMIOseBC88izQXEoIN4A7Il
         t3BbxBMfdIa4zfafVQ6+tDy9RIiJdqi2aZWjOoAemEhVtVg7DAGmqMW7qeiQDVp5JWSa
         c40K1ldJrJBMa4PPJGOMAqlEbma4RkMgKGdqPneROuj2/lxvdWue4jyaP50GfgxADtV/
         hIuRUWTMdebDjc580ruwlPvnxIYx4Bmk/Bu5HQdvmRDmMF9KXDql+HzaUD3XYfDnG1VC
         7IUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6XzPsxxN8b6uMru/eDEDCwc0UWRn8N/+CAQtdHTzt8M=;
        b=iGaWEdeu4WzZfAfBF1MyohN7s0Eu75a9IS9/bJiC2xno5Lh0N9+yRoGKLINB9rw5+Q
         1eyeZ+AMdeRI9Q4/F2+kc8jno82eUGVwos+ZR05w9c0uQHhmAgTpFUDnnCYugCQA0w1P
         h1SBG57juRvszZdFKiwH2M2626qdsHE8ojothC7iRAImpFmMGm5EtapwuMQUA7WJqygm
         2+mc06PUSVKBF0f4mG/omZPV44U8l5VVNb/lkEiWkrF7l7/a425UVtkcZEcUJN3J9Kbk
         cpy8Tnnt1AkBsuV5TlcH/HRFimcb20AATrjOhRow2omLQB/us8ouwx4uVzPOjFiwtTqo
         EP2Q==
X-Gm-Message-State: APjAAAXu6XQnH4plp/Ig/TtpN2rNm/EWT9ZSgyGVI3z6B9xUWqUrbg0E
        YrKSj3K57rxuKofZwPPPeRg=
X-Google-Smtp-Source: APXvYqwQVeiw+QMDbuCB20n+yM6NTy6IdIKvi4zEWFCzOUSCijljDUZFDZ0oysGFaDbh34nXB5rv/w==
X-Received: by 2002:a62:6f47:: with SMTP id k68mr25148875pfc.196.1556000729939;
        Mon, 22 Apr 2019 23:25:29 -0700 (PDT)
Received: from localhost.localdomain ([175.223.38.143])
        by smtp.gmail.com with ESMTPSA id p3sm19490287pfn.167.2019.04.22.23.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 23:25:29 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: [RFC][PATCH 2/2] printk: take console_sem when accessing console drivers list
Date:   Tue, 23 Apr 2019 15:25:11 +0900
Message-Id: <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to take console_sem lock when we iterate console
drivers list. Otherwise, another CPU can concurrently
modify console drivers list or console drivers.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/printk/printk.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b0e361ca1bea..c2bccf58d03e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2674,12 +2674,17 @@ void register_console(struct console *newcon)
 	struct console_cmdline *c;
 	static bool has_preferred;
 
-	if (console_drivers)
-		for_each_console(bcon)
-			if (WARN(bcon == newcon,
-					"console '%s%d' already registered\n",
-					bcon->name, bcon->index))
-				return;
+	console_lock();
+	if (console_drivers) {
+		for_each_console(bcon) {
+			if (bcon != newcon)
+				continue;
+			WARN(1, "console '%s%d' already registered\n",
+			     bcon->name, bcon->index);
+			console_unlock();
+			return;
+		}
+	}
 
 	/*
 	 * before we register a new CON_BOOT console, make sure we don't
@@ -2691,6 +2696,7 @@ void register_console(struct console *newcon)
 			if (!(bcon->flags & CON_BOOT)) {
 				pr_info("Too late to register bootconsole %s%d\n",
 					newcon->name, newcon->index);
+				console_unlock();
 				return;
 			}
 		}
@@ -2701,6 +2707,7 @@ void register_console(struct console *newcon)
 
 	if (!has_preferred || bcon || !console_drivers)
 		has_preferred = preferred_console >= 0;
+	console_unlock();
 
 	/*
 	 *	See if we want to use this console driver. If we
-- 
2.21.0

