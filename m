Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18EC004C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E0D214AE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 02:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEHCKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 22:10:34 -0400
Received: from mail.windriver.com ([147.11.1.11]:34943 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfEHCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 22:10:34 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x482AFAE015100
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 7 May 2019 19:10:15 -0700 (PDT)
Received: from pek-lpggp2.wrs.com (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 May 2019
 19:10:14 -0700
From:   Wenlin Kang <wenlin.kang@windriver.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <prarit@redhat.com>
CC:     <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kdb: Fix bound check compiler warning
Date:   Wed, 8 May 2019 09:52:39 +0800
Message-ID: <1557280359-202637-1-git-send-email-wenlin.kang@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strncpy() function may leave the destination string buffer
unterminated, better use strlcpy() instead.

This fixes the following warning with gcc 8.2:

kernel/debug/kdb/kdb_io.c: In function 'kdb_getstr':
kernel/debug/kdb/kdb_io.c:449:3: warning: 'strncpy' specified bound 256 equals destination size [-Wstringop-truncation]
   strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Wenlin Kang <wenlin.kang@windriver.com>
---
 kernel/debug/kdb/kdb_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6a4b414..7fd4513 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -446,7 +446,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
-		strncpy(kdb_prompt_str, prompt, CMD_BUFLEN);
+		strlcpy(kdb_prompt_str, prompt, CMD_BUFLEN);
 	kdb_printf(kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
-- 
1.9.1

