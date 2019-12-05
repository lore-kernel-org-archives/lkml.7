Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A8C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063C921835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS0KdwME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfLEVwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33838 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387445AbfLEVw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:26 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so5276438iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=kS0KdwME849/KgAuUKGhPx/EtW0pfwI6CbDjk5RAUK90k8mPddX0bqEtdw9zFskOSG
         m7XYPjg5DO+FzAAHJ3py/JHWY16I9o1oX+evkUdicdE+8Dmk7XbY3xK2rZesUuBRp6/C
         l5cdZ08kLzDcquPQKB/IXUl3lLCyibBIdQwI3Ai7VydCoccxFyMBKcfbiJLtVJ8ClmDp
         taDtiHNT7ApiE7HawWDSWhbG2ZPvnh2IIzbAE/F09MIAwVQEM4BnD+QmStfT5+xX/mS8
         31t6iSFIx1wAVF9dBGHGyez0I0Xwd3zFhH76MO7pUemZ04GZaGrPzlI+NgKULcSbJWRn
         ALZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSU9SXAkmvms1vPhMJGPQ7upzP8v1mEBZy+G6+yOB3Q=;
        b=WeT6MyMAmNtn14nEiNWB2pD7k9egIqmsjHHV13UEAkv9+HOSr/M4ZfYWSpcOhVpdue
         D+baqp5g0McHHGw98kTGZzyjmxWPEzAzTbHwcm0TnfKOdSYf3IHMwbvQVxMRH5Ja1Jio
         +G83i0ylzPDUk+r4Zjn8WobOW28qi6Lsddyl5D+2h+CyFreswI8uXm6TixsoAvIyhU3J
         +j0TrkEEvd3DcswE/S7fSIM5fzuIDbLHCObEU0Aj15PbfCYzH55vqKHXayWdE1EhcDSC
         teDplRLskA+foUnLJWiqF77dFG6nRYM66r6Y4QWE/zSBYGqAVojIQfUKANcysuAaX/4U
         diGA==
X-Gm-Message-State: APjAAAVis0gbmqP4C4MwX3f/OzJbD0/1KNoEWSXRFxSSFModyy0BjxOy
        Z9d70FmSqBMcsySOQBGUi4o=
X-Google-Smtp-Source: APXvYqw5SGNnV+pOD9gBIGw4vEx58WWu6LGdl2FkYBmou1rAhXR8BoQ7ienEZ7o+b6E6CPgBZrj81A==
X-Received: by 2002:a5e:a809:: with SMTP id c9mr3757154ioa.105.1575582745259;
        Thu, 05 Dec 2019 13:52:25 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:24 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 13/18] dyndbg: prefer declarative init in caller, to memset in callee
Date:   Thu,  5 Dec 2019 14:51:44 -0700
Message-Id: <20191205215151.421926-14-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
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

