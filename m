Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0569FCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C292067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVYc/M5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfJ2UAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:00:41 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:35940 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:39 -0400
Received: by mail-il1-f195.google.com with SMTP id s75so31399ilc.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTUFFn9ZOO6M4M/vQcEM8xkeQp+LXLxVeDhMCnKVDnk=;
        b=hVYc/M5etxseb0mXAnVmSFr/wOwxEOHMX8oLMxTHcfXScjVlzjbJ26WrcUiVtmuPOj
         1Yb4TA0hhWmmGrlUR2QlIAhBB3rvC/3WTNQBVgvgXC75ei8MdMZZKIqw7AN41GKQXYPl
         B/zccT4/7Nt7sY+Lpg3qIpWVLWHOH4by3Wve5t1/DIb9LBYrsnyPt7PUSkehDLuqgPPa
         S6r8dz2QdtuJojuzCStySSL4J/JizgnUrMtv32E+O62lR8rdu0kJEzTJ7TT4Cwjv0hnE
         IlUL9gYWnxWIk7s59aSnv2+muEKx2FcVWuI5VRO12dyBz1xwNc29K53YpxHJjAIUmcP+
         LARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTUFFn9ZOO6M4M/vQcEM8xkeQp+LXLxVeDhMCnKVDnk=;
        b=pfePV0cWDE5c4mNoFY2xQus5+bapwjbSxtIl/ZiTdprSJtvrxth/GAh0KFQ51FaiJI
         fDVqeks1UrLoAkZfAZ/K48v6EmbAgMOWNperUH5Xrd6VFM8dKFOxtSj+lMJVk7+2O3f9
         Om+X8T3XXJbtv/G1XKVMwMKe46coX2o868SGR8PL6kHcNoaiegGpIP5k9Kq0t96nnmTl
         OnMKX5y11lDz8I2s+W4bkNrgOcc7yKEtZ3ePfOLlw86ZLdRWSnC8ten11xpOddlNsHGQ
         t41RDiPOw+iWNUB6uj30ArgO9MS9TzQoRbata/vs2zswMiOu1Lyv27235jdi9x4Gzhne
         td5g==
X-Gm-Message-State: APjAAAV07f648Pf7GabX2xd6zUJ3DQEhwt0LukykFw0WihKtfaGud/zX
        znQqjU5wESLV1m7O1KXWXas=
X-Google-Smtp-Source: APXvYqy8h6ixuDbKnAAMgbI9gLpHYBg7eb8Eqc7lX7ZVY0Utbqvst+qGBAzUNSHpJhTzQyfxpQTJTw==
X-Received: by 2002:a92:c9c5:: with SMTP id k5mr30142061ilq.112.1572379238813;
        Tue, 29 Oct 2019 13:00:38 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n2sm2262ion.25.2019.10.29.13.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:00:38 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 06/16] dyndbg: fix overcounting of ram used by dyndbg
Date:   Tue, 29 Oct 2019 14:00:35 -0600
Message-Id: <20191029200035.9889-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  But it
counted strlens of all ddebug callsite entries, which are full of
pointers into shared __dyndbg memory, and shouldnt be counted at all
(since theyre already in the __dyndbg section)

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 540ca0861cf0..4ce0c53cdcfd 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -992,7 +992,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (__start___dyndbg == __stop___dyndbg) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1003,9 +1002,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1022,9 +1018,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(__stop___dyndbg - __start___dyndbg));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.21.0

