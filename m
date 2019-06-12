Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8433C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD0E2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbfFLIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:35:02 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfFLIfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:35:01 -0400
Received: from 5HSWXM1.fritz.box ([87.191.24.82]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPA (Nemesis) id
 1M2fDr-1hf6Fd0pHb-0048ig; Wed, 12 Jun 2019 10:34:47 +0200
From:   Rolf Evers-Fischer <embedded24@evers-fischer.de>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rolf Evers-Fischer <embedded24@evers-fischer.de>
Subject: [PATCH v2] sh: dma: Add missing IS_ERR_OR_NULL test
Date:   Wed, 12 Jun 2019 10:34:22 +0200
Message-Id: <20190612083422.9843-1-embedded24@evers-fischer.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jl32H1BfLq9Y/22OHrK2aMRkznc+2LMbUEpdRaS2GHNJPPABLD0
 Y0FZmQvq1135O7mkZmR39+ckXm28iaqsTslyKhJFNPxwKiaSom6FqZluxEXIszXbTDBRNBE
 AlfgZ+pHV6lXpbvf4qBxHTLt3wvgKUci/M78moSFSXpvbT7zmZSj0XgLRF8EJ0j8nwWi8xs
 x/GddDngyWG1L1x36DoKw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mMP0RALRnOw=:DU7Y0nAx02zYfpysYPncdO
 8NGnjxQ1zJiG9LNv99jTg5aV0bGJ9Rn7cTFnqLRKo9ybj2ogdFn+ZhWcBhFsAUcr00RS6dp8m
 6rthfkhIyvFow6IQ+eaXadvg1hh6kMXEMAJNEhsV1mAp+KFqtPo0BCXXMALAq4M7EY2RdtJCg
 iNJ1jKXLgNbMfvY/IT15vaJZoyjHl776vHb2LTHvXI1I7W2HFjZfo7xlrv8q0y6ciMHoWSUqO
 phG4MYrKbgQjB3O/tGCNPrYVSOgs2LzIwjpDm/tTHG3BixCch7yPLW6wXF420Z83XqBzd2kHe
 vTd6VKoLgNfVJv9BwnZbX5oUdJIiw6baK8rKAhkaY+VN9G3slaMSVrw46weXutMtZhLOyphKm
 Aayu1Xvd39B9fY2ylPNoeb4OkQzCmmkCnKpbR1Nn+MujtM8P10Zho7wlxaoz75IDmvWJn9CrX
 52MrDbM9/oTQO1+0+Tro6LQ7QVaPQfTzgO3+PJLhQ++Z9qgM7IsEuIWKSiXZAWO4TlbgVvK1w
 sv3BW0EygAP7VSOd3fYcP2E6kLQR4v+wafIvlAkjbJkI74Y/mU6P9ODU0Jll/48CpkcMz7AMG
 7T5WyMn81PkwBXm2UnxeuCdhgdf9aJjezflc3j6DWjuQBnyyVTbbUoT+Wnb3oAAV+ew/uVYjG
 IwMx6GqY2CzfttSL0tl8HigzrC0ZC+P0bolR5lP5kRPQiPwnMOU0GnpgcQHVRJ+TBg091O6SO
 izJJos7bs0E+mnSZ2d9lrOgT/FiaLNz8d1WRETsr55g4rMQsC+ZTyLuNnQo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_dma_channel may return ERR_PTR or NULL, so a check is added.

Changes since v1:
 - Removed unnecessary parentheses
 - Replaced IS_ERR with IS_ERR_OR_NULL

Signed-off-by: Rolf Evers-Fischer <embedded24@evers-fischer.de>
---
 arch/sh/drivers/dma/dma-api.c   | 20 +++++++++++++++++++-
 arch/sh/drivers/dma/dma-sysfs.c |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..aedce0b9ecc5 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -94,7 +94,7 @@ int get_dma_residue(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
-	if (info->ops->get_residue)
+	if (!IS_ERR_OR_NULL(channel) && info->ops->get_residue)
 		return info->ops->get_residue(channel);
 
 	return 0;
@@ -195,6 +195,9 @@ int request_dma(unsigned int chan, const char *dev_id)
 	int result;
 
 	channel = get_dma_channel(chan);
+	if (IS_ERR_OR_NULL(channel))
+		return PTR_ERR(channel);
+
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
@@ -217,6 +220,9 @@ void free_dma(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR_OR_NULL(channel))
+		return;
+
 	if (info->ops->free)
 		info->ops->free(channel);
 
@@ -229,6 +235,9 @@ void dma_wait_for_completion(unsigned int chan)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR_OR_NULL(channel))
+		return;
+
 	if (channel->flags & DMA_TEI_CAPABLE) {
 		wait_event(channel->wait_queue,
 			   (info->ops->get_residue(channel) == 0));
@@ -274,6 +283,9 @@ void dma_configure_channel(unsigned int chan, unsigned long flags)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR_OR_NULL(channel))
+		return;
+
 	if (info->ops->configure)
 		info->ops->configure(channel, flags);
 }
@@ -285,6 +297,9 @@ int dma_xfer(unsigned int chan, unsigned long from,
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR_OR_NULL(channel))
+		return PTR_ERR(channel);
+
 	channel->sar	= from;
 	channel->dar	= to;
 	channel->count	= size;
@@ -299,6 +314,9 @@ int dma_extend(unsigned int chan, unsigned long op, void *param)
 	struct dma_info *info = get_dma_info(chan);
 	struct dma_channel *channel = get_dma_channel(chan);
 
+	if (IS_ERR_OR_NULL(channel))
+		return PTR_ERR(channel);
+
 	if (info->ops->extend)
 		return info->ops->extend(channel, op, param);
 
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 8ef318150f84..6ba5b569d446 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -30,7 +30,7 @@ static ssize_t dma_show_devices(struct device *dev,
 		struct dma_info *info = get_dma_info(i);
 		struct dma_channel *channel = get_dma_channel(i);
 
-		if (unlikely(!info) || !channel)
+		if (unlikely(!info) || IS_ERR_OR_NULL(channel))
 			continue;
 
 		len += sprintf(buf + len, "%2d: %14s    %s\n",
-- 
2.21.0

