Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F1C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F9221852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 15:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfGDPiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 11:38:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727874AbfGDPiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 11:38:12 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hj3oG-0004wg-Aa; Thu, 04 Jul 2019 17:38:08 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Gromm <christian.gromm@microchip.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH 4/7] staging: most: Use spinlock_t instead of struct spinlock
Date:   Thu,  4 Jul 2019 17:38:00 +0200
Message-Id: <20190704153803.12739-5-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704153803.12739-1-bigeasy@linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For spinlocks the type spinlock_t should be used instead of "struct
spinlock".

Use spinlock_t for spinlock's definition.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/staging/most/net/net.c     | 3 +--
 drivers/staging/most/video/video.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/most/net/net.c b/drivers/staging/most/net/net.c
index c8a64e2090273..09b604df45e63 100644
--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -69,7 +69,7 @@ struct net_dev_context {
 
 static struct list_head net_devices = LIST_HEAD_INIT(net_devices);
 static struct mutex probe_disc_mt; /* ch->linked = true, most_nd_open */
-static struct spinlock list_lock; /* list_head, ch->linked = false, dev_hold */
+static DEFINE_SPINLOCK(list_lock); /* list_head, ch->linked = false, dev_hold */
 static struct core_component comp;
 
 static int skb_to_mamac(const struct sk_buff *skb, struct mbo *mbo)
@@ -507,7 +507,6 @@ static struct core_component comp = {
 
 static int __init most_net_init(void)
 {
-	spin_lock_init(&list_lock);
 	mutex_init(&probe_disc_mt);
 	return most_register_component(&comp);
 }
diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
index adca250062e1b..fcd9e111e8bd0 100644
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -54,7 +54,7 @@ struct comp_fh {
 };
 
 static struct list_head video_devices = LIST_HEAD_INIT(video_devices);
-static struct spinlock list_lock;
+static DEFINE_SPINLOCK(list_lock);
 
 static inline bool data_ready(struct most_video_dev *mdev)
 {
@@ -540,7 +540,6 @@ static struct core_component comp = {
 
 static int __init comp_init(void)
 {
-	spin_lock_init(&list_lock);
 	return most_register_component(&comp);
 }
 
-- 
2.20.1

