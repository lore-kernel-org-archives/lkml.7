Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA5EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE20921726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvXaVCro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbfHBQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:48:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44625 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388211AbfHBQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:48:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so36344803pgl.11;
        Fri, 02 Aug 2019 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlePsYbSrfMfafAbYJYrk5T4zzM5eA6dmI/PKyiUd1I=;
        b=SvXaVCro0m752UIMlfq4GOY8tdwJoFBn9YYnnmjd4bwjjFdViInqbkB5yuPx6VrOql
         47xoQDEL323tScp2bBGU6tGBkf7+ap9i4ciVYl4VoROAjw2izB22AyQX+dgO0zVqjl/H
         jC157DGGNnvwnvgF8tSy8p8TFzGl7UOnko4m6tvJ6isIcRK5F0GvaXgTRN/GgiYVpL4g
         WttMGMqj7tQLTasIyDiGfbeG5zLvAhawSdKeXMs8793Hly0jYxSNaKd9JFpzhLPqEzai
         v7a72MCzS32St7yIqYCyKyg04Za9rHTvfFqfVX47lWLvgj+neYztyZhmFNAYrZ9NXdeZ
         sSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mlePsYbSrfMfafAbYJYrk5T4zzM5eA6dmI/PKyiUd1I=;
        b=U2TAzmr7OHLIg4kBUJ5aqXbHZ4dp0mkekxVbnR0wCNPA6hCrUZPeZZY4JDj6tN1hjB
         G0JouSDdUiZLwZ21Ajkn6FmAhpemIeIlqupLhq+6OE5nwu3y9bYRz61ldSZLc460BCFv
         aI2Dq9wOokEuP17KZgADVmvjNu0Pq/1sm0fThe9fZVZ2kvhKpg73to9xtA3xSmCDOw5P
         Sugy+eQRVeUlqg2/FzV8ZZjwFj3eEk+L8EfHhYigp6ceOSikmNY/cnFU7qT5tw4tWwuX
         o78ZjzjLGEzf80pT5PQDipgb/gT488yrDAuI+YGxkzmi5s6NIrrCz3YzOEw0o5S0DQyr
         AaUw==
X-Gm-Message-State: APjAAAVNez5+ly12hQf4+UaR76E5IVMo8Cm2Ifm2tQn5EmjUNae9dKWV
        vvD8GnxggS6stvOvaEjoSuu+aCe6eIl2bQ==
X-Google-Smtp-Source: APXvYqwiOgQgonqzAjAKsb2BGomaAtTMLowrJcCq8CL8kJsOqL6Q5sq8k7jiP3yk7H2OAtfHSbOnNA==
X-Received: by 2002:a63:e48:: with SMTP id 8mr37618496pgo.389.1564764489304;
        Fri, 02 Aug 2019 09:48:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id s24sm76429541pfh.133.2019.08.02.09.48.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 09:48:08 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Madalin Bucur <madalin.bucur@nxp.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] dpaa_eth: Use refcount_t for refcount
Date:   Sat,  3 Aug 2019 00:47:59 +0800
Message-Id: <20190802164759.20135-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

refcount_t is better for reference counters since its
implementation can prevent overflows.
So convert atomic_t ref counters to refcount_t.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Add #include in dpaa_eth.h.

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 6 +++---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index f38c3fa7d705..2df6e745cb3f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -485,7 +485,7 @@ static struct dpaa_bp *dpaa_bpid2pool(int bpid)
 static bool dpaa_bpid2pool_use(int bpid)
 {
 	if (dpaa_bpid2pool(bpid)) {
-		atomic_inc(&dpaa_bp_array[bpid]->refs);
+		refcount_inc(&dpaa_bp_array[bpid]->refs);
 		return true;
 	}
 
@@ -496,7 +496,7 @@ static bool dpaa_bpid2pool_use(int bpid)
 static void dpaa_bpid2pool_map(int bpid, struct dpaa_bp *dpaa_bp)
 {
 	dpaa_bp_array[bpid] = dpaa_bp;
-	atomic_set(&dpaa_bp->refs, 1);
+	refcount_set(&dpaa_bp->refs, 1);
 }
 
 static int dpaa_bp_alloc_pool(struct dpaa_bp *dpaa_bp)
@@ -584,7 +584,7 @@ static void dpaa_bp_free(struct dpaa_bp *dpaa_bp)
 	if (!bp)
 		return;
 
-	if (!atomic_dec_and_test(&bp->refs))
+	if (!refcount_dec_and_test(&bp->refs))
 		return;
 
 	if (bp->free_buf_cb)
diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
index af320f83c742..f7e59e8db075 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
@@ -32,6 +32,7 @@
 #define __DPAA_H
 
 #include <linux/netdevice.h>
+#include <linux/refcount.h>
 #include <soc/fsl/qman.h>
 #include <soc/fsl/bman.h>
 
@@ -99,7 +100,7 @@ struct dpaa_bp {
 	int (*seed_cb)(struct dpaa_bp *);
 	/* bpool can be emptied before freeing by this cb */
 	void (*free_buf_cb)(const struct dpaa_bp *, struct bm_buffer *);
-	atomic_t refs;
+	refcount_t refs;
 };
 
 struct dpaa_rx_errors {
-- 
2.20.1

