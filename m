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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 596ACC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFE52073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 02:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0NsW71F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfLJC2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 21:28:11 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39916 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfLJC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 21:28:08 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so17121205ioh.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 18:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ds4ZVlPOzvwTUXxm8CWmPR/78xRX0JHc5Iyf+QRVEvs=;
        b=M0NsW71FKz4msbAAqukxJOWkEYOgbcHz2et1+oWhoGVwyCjRSwcasfYSPajbFxk4FG
         efzm1dSl5sMV0+OdiMJH/zAGv+IVI49o5PrGvQINZtPfFbsE0xHdWUp6lmspA5g1YoRT
         8yy2MDbg97LCT4csK4l/zut6vFKeSE/SvyIigMkvBFWE0DYexqdEV5RZv+CfmgXB+iUf
         Q3mXkdLipmiARAS66thblkau0TC249s/LA02ZdIWeIoEjb2g7vBRTxBQRWsHy+qzQYor
         BxZtU3T06chEl6TMMEhN0FmrRld6COSquyC3BFLwWMK6ESeoB40jqM7xNbdcd0w7lW6b
         raHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds4ZVlPOzvwTUXxm8CWmPR/78xRX0JHc5Iyf+QRVEvs=;
        b=YoRfseaOH/L+oCNTAyVtTlCuagzdweFmTfK7SKx/pdPHA64sC5Ugh5BmPdW7Ws4MUB
         wWWh6FVKXYW2y4FJqQLxM99ghRYgg0uSHRdpiixYvHYK85mhZWz63TyZjVXQ3LnqZbLN
         g/tR/32iLErvgwoeJHAmExV3erhcPt79qR1Fr8qOtG9FTinHDMpTyIx1veN6bFVl9Jcq
         RuZVKiGhBsVwzU8K1rpAfgKhk+hYAXskonz3gfifd2ZgkuvEaw9qgCUy3juBwwMaLLsz
         KBDW6CUZqjLCyNztVTESk3XDW5luikaXhBV5L/9PE704Hy9Snn67bWZp8cw3V7eEL7ia
         0Jig==
X-Gm-Message-State: APjAAAU6ePRK3seRVhfGBMHpmvzqtcaUd4PySxkRme4BqlX2l/iDhPow
        B1WFQ4BpYzGhaQxvP0DlR8k=
X-Google-Smtp-Source: APXvYqz7v/iFaD3dpf/tqEJTJb3+J0I34EokCiU+t4SBidFed59/Xz7mvgHmWwgaEFb69LlBhvo3Dw==
X-Received: by 2002:a6b:d912:: with SMTP id r18mr22822414ioc.306.1575944887933;
        Mon, 09 Dec 2019 18:28:07 -0800 (PST)
Received: from localhost.localdomain (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id l9sm334052ioh.77.2019.12.09.18.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 18:28:07 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org
Cc:     gregkh@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v4 05/16] dyndbg: fix overcounting of ram used by dyndbg
Date:   Mon,  9 Dec 2019 19:27:31 -0700
Message-Id: <20191210022742.822686-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210022742.822686-1-jim.cromie@gmail.com>
References: <20191210022742.822686-1-jim.cromie@gmail.com>
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

Also fix wording and size under-reporting of the __dyndbg section.

Heres my overhead, on a virtme-run VM on a fedora-31 laptop:

  dynamic_debug:dynamic_debug_init: 260 modules, 2479 entries \
    and 10400 bytes in ddebug tables, 138824 bytes in __dyndbg section

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

