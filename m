Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F441C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA0B2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfKTO0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:26:20 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:41456 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfKTO0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:26:18 -0500
Received: from ramsan ([84.195.182.253])
        by albert.telenet-ops.be with bizsmtp
        id UESH2100u5USYZQ06ESHD6; Wed, 20 Nov 2019 15:26:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXQvx-0001uX-KO; Wed, 20 Nov 2019 15:26:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iXQvx-0007bY-JI; Wed, 20 Nov 2019 15:26:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] reset: Fix {of,devm}_reset_control_array_get kerneldoc return types
Date:   Wed, 20 Nov 2019 15:26:13 +0100
Message-Id: <20191120142614.29180-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191120142614.29180-1-geert+renesas@glider.be>
References: <20191120142614.29180-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_reset_control_array_get() and devm_reset_control_array_get() return
struct reset_control pointers, not internal struct reset_control_array
pointers, just like all other reset control API calls.

Correct the kerneldoc to match the code.

Fixes: 17c82e206d2a3cd8 ("reset: Add APIs to manage array of resets")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/reset/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 55245f485b3819da..4ea62aa00260f82c 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -861,8 +861,7 @@ static int of_reset_control_get_count(struct device_node *node)
  * @acquired: only one reset control may be acquired for a given controller
  *            and ID
  *
- * Returns pointer to allocated reset_control_array on success or
- * error on failure
+ * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
 of_reset_control_array_get(struct device_node *np, bool shared, bool optional,
@@ -915,8 +914,7 @@ EXPORT_SYMBOL_GPL(of_reset_control_array_get);
  * that just have to be asserted or deasserted, without any
  * requirements on the order.
  *
- * Returns pointer to allocated reset_control_array on success or
- * error on failure
+ * Returns pointer to allocated reset_control on success or error on failure
  */
 struct reset_control *
 devm_reset_control_array_get(struct device *dev, bool shared, bool optional)
-- 
2.17.1

