Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08840C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BA7206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOGHqc8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfK0Rvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:43 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46050 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0Rvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:43 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so14934548ioi.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=GOGHqc8iZW546KbftXHryNv9IybfCWLZYpDApJ7tQLXClbWbuLZhEMfi8tuszA0A9p
         54DakqQ750S95txELEM9Mk1eQ93KRz7fkwEVH7FF0ynTHwxyDmzu1daYmpP01zNgdrDt
         9gb7qkg/ty/qHeE9Rtfk9s1dxBKiyFSf6w83Z9Mn5ebbp6W3GQe5aVHCox7/1xR+G31Z
         3+OOwRirgNNdr+Y4e4nItETIUgb8voYpK8WHhKWwVStsY6sqM2mrgj12GyL76WhBebQO
         g0vBelNEm1VwkJQF0ZXHn9bv4N3QYtuAc+Vqy1D/5izo0edBJ68hE2B5cifV57l4mh6B
         EtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=azSkPGQy0L1iz3QzuUdY7bJ1ZxZIIVkuuRA0UcEF/zSjUnYbM6EqzIrUzff3R8lUYL
         WobwZip3aeLjR0SlPJy0MjBvsU9Lek6tIg7HkWLb5LMrHE1Zyy+T0QI9RLUwDReTQFbS
         E4HFcIA0pCM2ndifkNhtRifY12a8zo2RDoUOWf9+odeESh2Z2wvHu5a3LzsgRqO//+kA
         U8l2ZaggXh4/X91neugqc2z62YUa+4I5xzlWtZ9oEieUkz08tNZHT1TCszv/lOhkE6Uz
         bEE+S5BrE3fsEnAa5nKBgSQ/gfYPIbIEY2bY+zDQvMAlOmyCQ5MlnGqXPdEMFqW7d2tN
         r21Q==
X-Gm-Message-State: APjAAAUAf1gYNC6Jb56zpkLKhnznOACRIRjLC9OGXdKlFmtg5YaZL/8w
        lPpYxoiyKxd7LF8aFf/OjWI3oWJSVPw=
X-Google-Smtp-Source: APXvYqy8rkcDq5cPp3OE+tfnbarzC0UiP9ZhcElkGO1Hg7Jo9llvTofPJ6b+E5pgyFnB/TiQ9CqLRw==
X-Received: by 2002:a5d:8744:: with SMTP id k4mr8424858iol.227.1574877102744;
        Wed, 27 Nov 2019 09:51:42 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id e72sm3785762iof.63.2019.11.27.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:51:41 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 13/16] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Wed, 27 Nov 2019 10:51:29 -0700
Message-Id: <20191127175129.1351870-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
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

