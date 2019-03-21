Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CBB218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfCUPak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:30:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:29715 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfCUPak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:30:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 08:30:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="133541193"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Mar 2019 08:30:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 15A36159; Thu, 21 Mar 2019 17:30:37 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] lib/generic-radix-tree: Make good use of while (level--)
Date:   Thu, 21 Mar 2019 18:30:36 +0300
Message-Id: <20190321153036.43084-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to split postincrement in while (level--) type of loops.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/generic-radix-tree.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index a7bafc413730..5a1818a0de1f 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -59,13 +59,9 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 	if (ilog2(offset) >= genradix_depth_shift(level))
 		return NULL;
 
-	while (1) {
+	while (level--) {
 		if (!n)
 			return NULL;
-		if (!level)
-			break;
-
-		level--;
 
 		n = n->children[offset >> genradix_depth_shift(level)];
 		offset &= genradix_depth_size(level) - 1;
@@ -157,9 +153,7 @@ void *__genradix_iter_peek(struct genradix_iter *iter,
 	if (ilog2(iter->offset) >= genradix_depth_shift(level))
 		return NULL;
 
-	while (level) {
-		level--;
-
+	while (level--) {
 		i = (iter->offset >> genradix_depth_shift(level)) &
 			(GENRADIX_ARY - 1);
 
-- 
2.20.1

