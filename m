Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B842175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 09:58:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfEJJ6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 05:58:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39019 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbfEJJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 05:58:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hP2IT-00007p-5S; Fri, 10 May 2019 09:58:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] reset: remove redundant null check on pointer dev
Date:   Fri, 10 May 2019 10:58:32 +0100
Message-Id: <20190510095832.28233-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer dev is being dereferenced when passed to the inlined
functon dev_name, however, dev is later being null checked
so at first this seems like a potential null pointer dereference.

In fact, _reset_control_get_from_lookup is only ever called from
__reset_control_get, right after checking dev->of_node hence
dev can never be null.  Clean this up by removing the redundant
null check.

Thanks to Philipp Zabel for spotting that dev can never be null.

Addresses-Coverity: ("Dereference before null check")
Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove null check point, it is redundant.

---
 drivers/reset/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 81ea77cba123..921f4bbbad8a 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -694,9 +694,6 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 	const char *dev_id = dev_name(dev);
 	struct reset_control *rstc = NULL;
 
-	if (!dev)
-		return ERR_PTR(-EINVAL);
-
 	mutex_lock(&reset_lookup_mutex);
 
 	list_for_each_entry(lookup, &reset_lookup_list, list) {
-- 
2.20.1

