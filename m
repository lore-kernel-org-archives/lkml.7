Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D540C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF99B22296
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mhUQ8OF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbfGVNJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:09:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37868 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfGVNJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:09:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so38408700qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=psl7iNAw/byxvPnfx/LEJOVXAhm5xGESxpPWVbp40rc=;
        b=mhUQ8OF3F3Vek8dleK+RuvhZ1eNVEO+z4+7fIaAo2mOVhB2HfWx6jq/I4z0tBsJIVQ
         ei2WNHci/bVQ17Uwy8Zw3+PLiAKJ2IqS7tV0bRQJllV3Y42dAO/LK+HBBnHv0wjaAtUb
         HhJHrDiFyarKRqBV7cG/7DLIqQMWLP6qwM3YduWhzbWVqR5xgmHR6DbyLzzu6O3zpkND
         xccqLMEHTyXxQ+KSI2IK+A69p+zS5lDqPkGgCAAID6ueX2k+ZHQd9kmkQmwgb6diJZVH
         aUO0XIMRaJPQgoOB5AjwQPZv547GKnU07ymZHKSH5ixXwmcZMKvJhKSPmxFaqxSnhKX4
         NHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=psl7iNAw/byxvPnfx/LEJOVXAhm5xGESxpPWVbp40rc=;
        b=s97URLdufI4PJ2YFr3IJTxWjiYVr3gYkCevkLLznGMFp3Wdg8wWjegN3utg7a+Kv6x
         IabclFlWm0zIDuPYJKhwTb7QP1vMfmJ4tCP5jJVue25ikco9NKq4bRl3M23VgKq4f9CW
         ikaMhzI8Gm5+VpmknA4nvUis8es/G29EHK2y/6ZhssY3l60kOYBysV02Rqo233/405kk
         rj00lAqcLckP0Eq13F9HaI+5jdeN7P1txRpMw0JtM8RAEZC6MXNZbcPrZDVsb9jyQBII
         KEljDCN8ABozT6SKHbhkon3PcD7cTnqF/oaRvA+BroEJOn0zQ8A/5LSJ/CkspMGDjMGr
         tNHw==
X-Gm-Message-State: APjAAAVfyHFRb9ZDi8HvfjHAWFvLvluORj3SWHK1+jCT/O/6bBEXN2bl
        x7owtnuIcITVLFiT+2Jer4U2xg==
X-Google-Smtp-Source: APXvYqwNbNCgbOVDznXjMsRskMRpZruZqPCZRzSm4n4HnfCCs/ZfjYQ8NOfExbb+Y2C9/sNyanY8qQ==
X-Received: by 2002:a0c:8a23:: with SMTP id 32mr51641397qvt.231.1563800941472;
        Mon, 22 Jul 2019 06:09:01 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w25sm15937561qto.87.2019.07.22.06.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 06:09:00 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     talgi@mellanox.com
Cc:     saeedm@mellanox.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] linux/dim: fix -Wunused-const-variable warnings
Date:   Mon, 22 Jul 2019 09:08:43 -0400
Message-Id: <1563800923-15441-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of compilation warnings due to tx_profile[] and
rx_profile[] are only used in lib/dim/net_dim.c but include/linux/dim.h
is included elsewhere.

In file included from ./include/rdma/ib_verbs.h:64,
                 from ./include/linux/mlx5/device.h:37,
                 from ./include/linux/mlx5/driver.h:51,
                 from
drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c:37:
./include/linux/dim.h:326:1: warning: 'tx_profile' defined but not used
[-Wunused-const-variable=]
 tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 ^~~~~~~~~~
./include/linux/dim.h:320:1: warning: 'rx_profile' defined but not used
[-Wunused-const-variable=]
 rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 ^~~~~~~~~~

Fix them by moving tx_profile[] and rx_profile[] into lib/dim/net_dim.c
instead.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/dim.h | 12 ------------
 lib/dim/net_dim.c   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index d3a0fbfff2bb..d5f3b10fe6e1 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -316,18 +316,6 @@ void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
 	{64, 32}   \
 }
 
-static const struct dim_cq_moder
-rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
-	NET_DIM_RX_EQE_PROFILES,
-	NET_DIM_RX_CQE_PROFILES,
-};
-
-static const struct dim_cq_moder
-tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
-	NET_DIM_TX_EQE_PROFILES,
-	NET_DIM_TX_CQE_PROFILES,
-};
-
 /**
  *	net_dim_get_rx_moderation - provide a CQ moderation object for the given RX profile
  *	@cq_period_mode: CQ period mode
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 5bcc902c5388..f2a8674721cf 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -5,6 +5,18 @@
 
 #include <linux/dim.h>
 
+static const struct dim_cq_moder
+rx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+	NET_DIM_RX_EQE_PROFILES,
+	NET_DIM_RX_CQE_PROFILES,
+};
+
+static const struct dim_cq_moder
+tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
+	NET_DIM_TX_EQE_PROFILES,
+	NET_DIM_TX_CQE_PROFILES,
+};
+
 struct dim_cq_moder
 net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
 {
-- 
1.8.3.1

