Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A9C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982322175B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 16:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEIQAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 12:00:38 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46688 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfEIQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 12:00:38 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hOlTI-0007jn-DY; Thu, 09 May 2019 16:00:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] reset: fix potential null pointer dereference on pointer dev
Date:   Thu,  9 May 2019 17:00:36 +0100
Message-Id: <20190509160036.19433-1-colin.king@canonical.com>
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
functon dev_name, however, dev is later being null checked.
Thus there is a potential null pointer dereference on a null
dev. Fix this by performing the null check on dev before
dereferencing it.

Addresses-Coverity: ("Dereference before null check")
Fixes: 6691dffab0ab ("reset: add support for non-DT systems")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/reset/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 81ea77cba123..83f1a1d5ee67 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -691,12 +691,13 @@ __reset_control_get_from_lookup(struct device *dev, const char *con_id,
 {
 	const struct reset_control_lookup *lookup;
 	struct reset_controller_dev *rcdev;
-	const char *dev_id = dev_name(dev);
+	const char *dev_id;
 	struct reset_control *rstc = NULL;
 
 	if (!dev)
 		return ERR_PTR(-EINVAL);
 
+	dev_id = dev_name(dev);
 	mutex_lock(&reset_lookup_mutex);
 
 	list_for_each_entry(lookup, &reset_lookup_list, list) {
-- 
2.20.1

