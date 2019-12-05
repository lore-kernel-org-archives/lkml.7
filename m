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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF24AC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEBA21835
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 21:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRTPKDSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbfLEVwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 16:52:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42058 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbfLEVwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 16:52:21 -0500
Received: by mail-io1-f65.google.com with SMTP id f82so5222613ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=QRTPKDSlv/GL3XjawIYtaGXvXGngPuI8Ikxc3pTEP6Nh2z88/MoQGdiKTMyVeuktv/
         KUffij/CcrAWNZuHYXk0WqTljhQVd6Aa9DTqRtSNaAmA9Kv5RxuBl5Uu0PuYjfoDiuQh
         RXYG1cyOVRX3cHNema2EpmuV/9jvYMockgAMzJIFr40l2T6pKLARDP0cT08Fir3T6ZRv
         LEseFEXsUu6T+UNTwcNE5sCtjVSIz++HT8I2YMZxXF9BEbfGI0O9ReSjLo4AOEycXY6A
         tdEpYElxzaa6pphxrWxnh1ldlBh7x9WetfGo2j1Gj41zPNxfwXtFHs88ctjfK8xKS/Fq
         oUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CE8w0wMRoXjYU5yMlPYtNhR9/So/tLdxFIEhs/BR7j4=;
        b=F5+wPn4lI4B45Sgi9xJ2+oKTAEapVgY1nLdk2030TJLndTriDVzFJ9JX+t5nL0raDU
         vZxcIda7BnbxXuitYBRWQ1mj9HzZkykj3ydRN6vdbor2rAb4wM3h2Gs2T67OeXIabZ1d
         KUF6twCi9Z33bkJSzalPMMydeY/kQR+DtD88YbbQ6cCCApyLyD8Q5BiJXx3vsWxMZsj8
         BZFicrVOErYzN5PLuBm7/uGqiFzYNjv0EJ4AtZH8NV8FDyHuGsZT0fTMBI1uHD/4+PmZ
         fsgAMnAtcoltaH5YGz9570MCVr2uepWqr19ZvxjCxd694EI3o9LDgW3OXwYsaBnuks/K
         aOEA==
X-Gm-Message-State: APjAAAVH8s8vTOX35DGrI5vY3mOhgzaiT0SZhoieH25lAGKCGLQCl3Tr
        aTCpUyVPHgLAcCGaZqUdBzs=
X-Google-Smtp-Source: APXvYqy3hkFQE5IluQOcgFGZEg9YvMM0NuFzfxKSpAOruY0e+7UBuNvE9ozLb7G8p1zK/IN+vAbHxg==
X-Received: by 2002:a5e:df46:: with SMTP id g6mr8110770ioq.240.1575582741135;
        Thu, 05 Dec 2019 13:52:21 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n22sm740184iog.14.2019.12.05.13.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 13:52:20 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 11/18] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Thu,  5 Dec 2019 14:51:42 -0700
Message-Id: <20191205215151.421926-12-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191205215151.421926-1-jim.cromie@gmail.com>
References: <20191205215151.421926-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new *filter param to 2 functions, allowing ddebug_parse_flags()
to communicate filter settings to ddebug_change(),

Also, ddebug_change doesn't alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0d1b3dbdec1d..8c62c76badcf 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -147,7 +147,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flagsettings *mods)
+			 const struct flagsettings *mods,
+			 const struct flagsettings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -445,7 +446,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
  * flags fields of matched _ddebug's.  Returns 0 on success
  * or <0 on error.
  */
-static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
+
+static int ddebug_parse_flags(const char *str,
+			      struct flagsettings *mods,
+			      struct flagsettings *filter)
 {
 	int op;
 
@@ -477,7 +481,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 mods->flags, mods->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -485,6 +491,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
+	struct flagsettings filter = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -496,7 +503,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* check flags 1st (last arg) so query is pairs of spec,val */
-	if (ddebug_parse_flags(words[nwords-1], &mods)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
@@ -505,7 +512,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &mods);
+	nfound = ddebug_change(&query, &mods, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.23.0

