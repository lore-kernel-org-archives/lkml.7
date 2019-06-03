Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC531C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4BE2786B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfFCPwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:52:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53946 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfFCPv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:51:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74A51A25;
        Mon,  3 Jun 2019 08:51:58 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8F18E3F246;
        Mon,  3 Jun 2019 08:51:57 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        suzuki.poulose@arm.com, Peter Rosin <peda@axentia.se>
Subject: [RFC PATCH 39/57] drivers: mux: Use class_find_device_by_of_node helper
Date:   Mon,  3 Jun 2019 16:50:05 +0100
Message-Id: <1559577023-558-40-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic helper to find a device matching the of_node.

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/mux/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index d1271c1..3591e40 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -405,18 +405,12 @@ int mux_control_deselect(struct mux_control *mux)
 }
 EXPORT_SYMBOL_GPL(mux_control_deselect);
 
-static int of_dev_node_match(struct device *dev, const void *data)
-{
-	return dev->of_node == data;
-}
-
 /* Note this function returns a reference to the mux_chip dev. */
 static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
 {
 	struct device *dev;
 
-	dev = class_find_device(&mux_class, NULL, np, of_dev_node_match);
-
+	dev = class_find_device_by_of_node(&mux_class, NULL, np);
 	return dev ? to_mux_chip(dev) : NULL;
 }
 
-- 
2.7.4

