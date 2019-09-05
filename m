Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C43EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CFF20825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 19:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbfIETpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 15:45:06 -0400
Received: from fieldses.org ([173.255.197.46]:56754 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390112AbfIETog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:44:36 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id ED8896850; Thu,  5 Sep 2019 15:44:34 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 8/9] minor kstrdup_quotable simplification
Date:   Thu,  5 Sep 2019 15:44:32 -0400
Message-Id: <1567712673-1629-8-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567712673-1629-1-git-send-email-bfields@redhat.com>
References: <20190905193604.GC31247@fieldses.org>
 <1567712673-1629-1-git-send-email-bfields@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 47f40406f9d4..6f553f893fda 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -518,8 +518,8 @@ char *kstrdup_quotable(const char *src, gfp_t gfp)
 {
 	size_t slen, dlen;
 	char *dst;
-	const int flags = ESCAPE_STYLE_HEX;
-	const char esc[] = "\f\n\r\t\v\a\e\\\"";
+	const int flags = ESCAPE_SPECIAL|ESCAPE_STYLE_HEX;
+	const char esc[] = "\"";
 
 	if (!src)
 		return NULL;
-- 
2.21.0

