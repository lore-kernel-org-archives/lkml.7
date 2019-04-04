Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBCBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF40B2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDDIMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:12:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:19195 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfDDIMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:12:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 01:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,306,1549958400"; 
   d="scan'208";a="288604528"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2019 01:11:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D8A62B2; Thu,  4 Apr 2019 11:11:58 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] driver core: platform: Propagate error from insert_resource()
Date:   Thu,  4 Apr 2019 11:11:58 +0300
Message-Id: <20190404081158.16133-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since insert_resource() might return an error we don't need
to shadow its error code and would safely propagate to the user.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
- move an assignment to the separate line inside first branch (Rafael)

 drivers/base/platform.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dab0a5abc391..9cf9e2af9efd 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -438,10 +438,12 @@ int platform_device_add(struct platform_device *pdev)
 				p = &ioport_resource;
 		}
 
-		if (p && insert_resource(p, r)) {
-			dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
-			ret = -EBUSY;
-			goto failed;
+		if (p) {
+			ret = insert_resource(p, r);
+			if (ret) {
+				dev_err(&pdev->dev, "failed to claim resource %d: %pR\n", i, r);
+				goto failed;
+			}
 		}
 	}
 
-- 
2.20.1

