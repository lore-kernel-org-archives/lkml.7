Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B775C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D5A206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfEBTsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 15:48:25 -0400
Received: from mga18.intel.com ([134.134.136.126]:59997 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfEBTsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 15:48:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 12:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="140776176"
Received: from kheitke-ubuntu.lm.intel.com ([10.232.116.89])
  by orsmga006.jf.intel.com with ESMTP; 02 May 2019 12:48:24 -0700
From:   Kenneth Heitke <kenneth.heitke@intel.com>
To:     johannes@sipsolutions.net
Cc:     linux-kernel@vger.kernel.org,
        Kenneth Heitke <kenneth.heitke@intel.com>
Subject: [PATCH] devcoredump: remove unnecessary initialization of iterator 'iter'
Date:   Thu,  2 May 2019 13:48:46 -0600
Message-Id: <20190502194846.19700-1-kenneth.heitke@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iterator 'iter' will be set by the call to for_each_sg and therefore
does not need to be initialized.

Signed-off-by: Kenneth Heitke <kenneth.heitke@intel.com>
---
 include/linux/devcoredump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/devcoredump.h b/include/linux/devcoredump.h
index 269521f143ac..a9f3e2480739 100644
--- a/include/linux/devcoredump.h
+++ b/include/linux/devcoredump.h
@@ -42,7 +42,6 @@ static inline void _devcd_free_sgtable(struct scatterlist *table)
 	struct scatterlist *delete_iter;
 
 	/* free pages */
-	iter = table;
 	for_each_sg(table, iter, sg_nents(table), i) {
 		page = sg_page(iter);
 		if (page)
-- 
2.17.1

