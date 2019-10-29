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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D710CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BAAC21D7C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDzKxlR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfJ2UBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:01:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43029 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbfJ2UBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:01:06 -0400
Received: by mail-io1-f68.google.com with SMTP id c11so16178760iom.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6XMcK0TgQyED/+3WKhANhwDjSMsgCtUa0b29cO4tKk=;
        b=XDzKxlR2PeWEcyNikS0iGgqcRRPxFlqSdJuM5idQ4dPKW+2tj2VPg2sRpyw+AzuvM8
         nZo2LD9Q34OsIDiyTHpiwL8F80KwXfTMQK12Canq5RNyKLp047RV68ePnicCWDntPuhi
         aNHttC/MTVdZl5lgTm9JE5a5aGPGnKa6V2C8u1vkZsvEy+pcoe13Bbc3ZdU5faXO+lr4
         Mf0rYyb0CDAekCpfEp/dw2JD4owmgnON9igkkmDquB4vMAghJmSz4sop0jW5Q86ci8oH
         bVXyDAuZvFNRyeZCxTub9JOUMI4B3kH7b9lRKxbm5oZa7U3zXeKj/i/XeVnfEX/iEfXp
         y6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L6XMcK0TgQyED/+3WKhANhwDjSMsgCtUa0b29cO4tKk=;
        b=HC44Cf6UNM6PQNt/5JpZLDOJsqrmdD4JWSNjhJWy4m3fiyyuvk+Cna52/AnIcqwMC4
         yU/8YPwHYNETCioQZBM7sMs4z46nl5/R+Ib4zZ6tc/09vhnfrnDLHHCyqNA3oWDWw+Ya
         RjLRlYNg1czM4vBKI09JyoD/EN9NfCAzKOyG3D7Tg17B3rVd/mhMOtq+WNtMGbmoYRTd
         c3snT0lZ4jpRJJmjzl3rOUZRMkhwKcZy3pkn8qBMTubQtrspy2Uc/8l5SZKLYQB25T5w
         GfH3ski9ZXmYY6Z/AruJuIrdUOZRROzJK7mVRx2JTo/g6EfjW9KDWH+ntsehcDNeCT/c
         8EJw==
X-Gm-Message-State: APjAAAXov2u3b2B7jBEsOhONgx8clZrWMBun6QeyriioJ/sS8f89A5b2
        sqwDVcXcV5qB10O2NA7Ae8w=
X-Google-Smtp-Source: APXvYqxVUzZtTPZOXwvR1nlzqtk0qtZPLTU2hoA5E7/i3tIBGt1D6Qa/9iHUddmXcaMdO/iayZYMZA==
X-Received: by 2002:a05:6602:255a:: with SMTP id j26mr4361820ioe.155.1572379265488;
        Tue, 29 Oct 2019 13:01:05 -0700 (PDT)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id n3sm2236491ilm.8.2019.10.29.13.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 13:01:04 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 12/16] dyndbg: add filter parameter to ddebug_parse_flags
Date:   Tue, 29 Oct 2019 14:01:02 -0600
Message-Id: <20191029200102.10201-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new *filter param to 2 functions, allowing ddebug_parse_flags()
to communicate filter settings to ddebug_change(),

Also, ddebug_change doesnt alter any of its arguments, including its 2
new ones; mods, filter.  Say so by adding const modifier to them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5cb44088fff5..173b28250bd6 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -134,7 +134,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
  * logs the changes.  Takes ddebug_lock.
  */
 static int ddebug_change(const struct ddebug_query *query,
-			 struct flagsettings *mods)
+			 const struct flagsettings *mods,
+			 const struct flagsettings *filter)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -430,7 +431,10 @@ static int ddebug_read_flags(const char *str, struct flagsettings *f)
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
 
@@ -462,7 +466,9 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 		mods->flags = 0;
 		break;
 	}
-	vpr_info("*flagsp=0x%x *maskp=0x%x\n", mods->flags, mods->mask);
+
+	vpr_info("mods:flags=0x%x,mask=0x%x filter:flags=0x%x,mask=0x%x\n",
+		 mods->flags, mods->mask, filter->flags, filter->mask);
 
 	return 0;
 }
@@ -470,6 +476,7 @@ static int ddebug_parse_flags(const char *str, struct flagsettings *mods)
 static int ddebug_exec_query(char *query_string, const char *modname)
 {
 	struct flagsettings mods = {};
+	struct flagsettings filter = {};
 	struct ddebug_query query;
 #define MAXWORDS 9
 	int nwords, nfound;
@@ -484,12 +491,12 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
-	if (ddebug_parse_flags(words[nwords-1], &mods)) {
+	if (ddebug_parse_flags(words[nwords-1], &mods, &filter)) {
 		pr_err("flags parse failed\n");
 		return -EINVAL;
 	}
 	/* actually go and implement the change */
-	nfound = ddebug_change(&query, &mods);
+	nfound = ddebug_change(&query, &mods, &filter);
 	vpr_info_dq(&query, nfound ? "applied" : "no-match");
 
 	return nfound;
-- 
2.21.0

