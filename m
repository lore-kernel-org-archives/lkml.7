Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F9BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8255E222EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 12:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfKSM6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 07:58:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:58643 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfKSM6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 07:58:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 04:58:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="237322627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2019 04:58:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1F64E250; Tue, 19 Nov 2019 14:58:37 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regmap: regmap-w1: Drop unreachable code
Date:   Tue, 19 Nov 2019 15:58:37 +0300
Message-Id: <20191119125837.47619-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both init functions have a stray "return NULL" at the end which is never
reached so drop them.

Fixes: cc5d0db390b0 ("regmap: Add 1-Wire bus support")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/base/regmap/regmap-w1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-w1.c b/drivers/base/regmap/regmap-w1.c
index 3a7d30b8c3ac..1fbaaad71ca5 100644
--- a/drivers/base/regmap/regmap-w1.c
+++ b/drivers/base/regmap/regmap-w1.c
@@ -215,8 +215,6 @@ struct regmap *__regmap_init_w1(struct device *w1_dev,
 
 	return __regmap_init(w1_dev, bus, w1_dev, config,
 			 lock_key, lock_name);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(__regmap_init_w1);
 
@@ -233,8 +231,6 @@ struct regmap *__devm_regmap_init_w1(struct device *w1_dev,
 
 	return __devm_regmap_init(w1_dev, bus, w1_dev, config,
 				 lock_key, lock_name);
-
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_w1);
 
-- 
2.24.0

