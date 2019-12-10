Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382AEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BC5120726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBflX7kZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLJC22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:28 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37002 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfLJC2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:22 -0500
Received: by mail-io1-f66.google.com with SMTP id k24so17120753ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=YBflX7kZB860OqQ3pc5OmQUi7VN7Mh3bDHbeyfxl5JzX3ad8r3W7d4Obk5uS0jduMK
         AHdhIpdCyCikk3asMewSgRKfOry7uJv21iCI/sX6Wne2+yN7SDn/wGKifvmmbMBjUrN4
         doFJNepRTgK1UkwEd7W3Oa/0kKAbhCyPM0zXDc2MqUQFJrPMsTJ9/JsbNgSX1wYmL7QT
         uk/tSuyjTqmsq13jE44IymMEP77Av6RJ0FJX5nVyVlrcnj6Fn+39QtBVRxu2W/vMRRZo
         aWQEMa3CN3+0QKBpPI8Zw50LPOLORGUuuUd5Ts7qTTmTivQ8XONMMjkYqeWqc4rWLMhD
         8Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=aPQK6BqJJc1TjOS6tWSzPmok6CDuX2dTy6Wc/RwXEZKKwGpDQ54evwxu/L9emH9aVH
         0Iqy5SGSEOMKeEsScx6BKZ327z+NJOhFTJUgZcZVSwaMK4LVML7XB7OizlojIqfBjqjc
         t4kYI+/BInCXW9lCWv2fr8WCYUkI8uxE0dUFrNMmeIUxZ+JIzGRXUuA8vVP9UxZkgNhZ
         9iZdnF+Mc5ZIN6DW453c6gJdkgJAkdO07iNk26ZgpF8ahBF8DuyvrtmljXO7+AMvwnq9
         YuMCwqTlA5oFX8rQK3hpLKaDu+K1aUJ2PWB8Zr9zEmm22oYSF32MBVE3CpqOhtsRT8hW
         QeUA==
X-Gm-Message-State: APjAAAU4LiFgr9yIM68oGjElhv+HXLzp72+OUxdyW5q+qzbhdufrZBy4
        S/xaI0ea/6S+JdQzlSYaLdo=
X-Google-Smtp-Source: APXvYqyE7CtlRFTfwkXJb/4dhwm498AblzR5fqtLks6zq5M/WQFCR8U5QWmiXqD1XPopmXV0B100RQ==
X-Received: by 2002:a5d:8899:: with SMTP id d25mr24664396ioo.260.1575944902104;
        Mon, 09 Dec 2019 18:28:22 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:21 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 13/16] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Mon,  9 Dec 2019 19:27:39 -0700
Message-Id: <20191210022742.822686-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drop memset in ddebug_parse_query, instead initialize the stack
variable in the caller.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index be8299e119ab..26432f88b329 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -373,7 +373,6 @@ static int ddebug_parse_query(char *words[], int nwords,
 		pr_err("expecting pairs of match-spec <value>\n");
 		return -EINVAL;
 	}
-	memset(query, 0, sizeof(*query));
 
 	if (modname)
 		/* support $modname.dyndbg=<multiple queries> */
@@ -494,7 +493,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
 	struct flagsettings filter = {};
-	struct ddebug_query query;
+	struct ddebug_query query = {};
 #define MAXWORDS 9
 	int nwords, nfound;
 	char *words[MAXWORDS];
-- 
2.23.0

