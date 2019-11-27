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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9C2C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5E9D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtbQzuZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbfK0RvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:51:01 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:45442 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0RvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:51:00 -0500
Received: by mail-il1-f194.google.com with SMTP id o18so21740008ils.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 09:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/stFClXYrFISZefBb+JDS4GEu+QGCmV4uRwHZjJAkoE=;
        b=WtbQzuZI5b1TaYrehfBirydN35Ren4ZIo00zSBYkzZEL8CHiSswnIK373C2LaXRosk
         PdOzdvuvK+LKqtlG7bLOWn1/sm7t6c64Pa8ya9DOcx/uzYudr5+dZoEkuLYxxP8+VZE6
         313BBdHqbNzAo2N1VXBsIcwTEui0zH+7r8qoU/u7LvJsx11nPDMov4O2asLsOGofNmON
         am2+YO+QQCuX5pyR7cWtQ4+w4vJZ2RgOAxLELzPZZugSqeU7OTgQOrLZ9Yxu0VCcm2z8
         6kJAlebfwnARnQ376P3aVx+/IqKhr9sPKq97qEHZLKgNnJYvdJj73/VP5/+kdP3lzyZL
         l/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/stFClXYrFISZefBb+JDS4GEu+QGCmV4uRwHZjJAkoE=;
        b=TkFSz5grt8m0UpRFQvD8B+5qVPWkIBuSZxX3iHQdMdu0QqqRmHjQ6HFLV2DLCr33db
         b05z3+PaS2kojGQoKiEBpqdrp34j+93LroVbp1vXRkFAodbAaakCArfJG5g8qxIhI89C
         cooRRjbnlbgrvtGZthmk3EklP0nflrli7O/74VTzYzeJtHPsleO4XRSt4WsURlCNR350
         KNQKQ1ST5xowEDHTZcY8h4OPpX4XUxWE78gu2y9+NbX85ym/AvSvxDc9ibCy4WJVcFhc
         qbNwSw5bMIbrrXHs4foUCKaKUT8e9TTrW4g1r6YEEWV3GTmcdppb/wv6BUbOHXz+JzcO
         hhVQ==
X-Gm-Message-State: APjAAAW81aW8xphepx5v4OAu9942E04JvMgIpGbCE+L5drY5b4Df2dxd
        NCZohgtboY/OqS3olv0eu3k=
X-Google-Smtp-Source: APXvYqw33q5dwfgXuAvjHEwh1sOHN1/oHi4JN+Dh0iY0aN5kpGDMS+7rqL7n/NxscLGUm7Waac49Bw==
X-Received: by 2002:a92:d7cf:: with SMTP id g15mr46202361ilq.171.1574877058325;
        Wed, 27 Nov 2019 09:50:58 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id v123sm3855442ioe.35.2019.11.27.09.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 09:50:57 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Cc:     linux@rasmusvillemoes.dk, greg@kroah.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 05/16] dyndbg: fix overcounting of ram used by dyndbg
Date:   Wed, 27 Nov 2019 10:50:55 -0700
Message-Id: <20191127175055.1351403-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

during dyndbg init, verbose logging prints its ram overhead.  It
counted strlens of struct _ddebug's 4 string members, in all callsite
entries, which would be approximately correct if each had been
mallocd.  But they are pointers into shared .rodata; for example, all
10 kobject callsites have identical filename, module values.

Its best not to count that memory at all, since we cannot know they
were linked in because of CONFIG_DYNAMIC_DEBUG=y, and we want to
report a number that reflects what ram is saved by deconfiguring it.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0a4588fe342e..b5fb0aa0fbc3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1008,7 +1008,6 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 	int ret = 0;
 	int n = 0, entries = 0, modct = 0;
-	int verbose_bytes = 0;
 
 	if (__start___dyndbg == __stop___dyndbg) {
 		pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
@@ -1019,9 +1018,6 @@ static int __init dynamic_debug_init(void)
 	iter_start = iter;
 	for (; iter < __stop___dyndbg; iter++) {
 		entries++;
-		verbose_bytes += strlen(iter->modname) + strlen(iter->function)
-			+ strlen(iter->filename) + strlen(iter->format);
-
 		if (strcmp(modname, iter->modname)) {
 			modct++;
 			ret = ddebug_add_module(iter_start, n, modname);
@@ -1038,9 +1034,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in (readonly) verbose section\n",
+	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
 		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 verbose_bytes + (int)(__stop___dyndbg - __start___dyndbg));
+		 (int)(entries * sizeof(struct _ddebug)));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.23.0

