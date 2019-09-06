Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B59C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6092206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393841AbfIFN6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 09:58:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45101 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbfIFN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 09:58:09 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6EkZ-0002vX-Dc; Fri, 06 Sep 2019 13:58:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] unicode: make array 'token' static const, makes object smaller
Date:   Fri,  6 Sep 2019 14:58:07 +0100
Message-Id: <20190906135807.23152-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array 'token' on the stack but instead make it
static const. Makes the object code smaller by 234 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
   5371	    272	      0	   5643	   160b	fs/unicode/utf8-core.o

After:
   text	   data	    bss	    dec	    hex	filename
   5041	    368	      0	   5409	   1521	fs/unicode/utf8-core.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/unicode/utf8-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 71ca4d047d65..2a878b739115 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -154,7 +154,7 @@ static int utf8_parse_version(const char *version, unsigned int *maj,
 {
 	substring_t args[3];
 	char version_string[12];
-	const struct match_token token[] = {
+	static const struct match_token token[] = {
 		{1, "%d.%d.%d"},
 		{0, NULL}
 	};
-- 
2.20.1

