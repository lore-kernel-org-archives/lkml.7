Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F69C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122BF216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfGZLWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:22:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48914 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZLWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:22:19 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqyIh-0000gP-7L; Fri, 26 Jul 2019 13:22:15 +0200
Date:   Fri, 26 Jul 2019 13:22:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Gromm <christian.gromm@microchip.com>
Subject: [PATCH v2] staging: most: Use DEFINE_SPINLOCK() instead of struct
 spinlock
In-Reply-To: <20190715191933.GA10934@kroah.com>
Message-ID: <alpine.DEB.2.21.1907261319100.1791@nanos.tec.linutronix.de>
References: <20190704153803.12739-1-bigeasy@linutronix.de> <20190704153803.12739-5-bigeasy@linutronix.de> <20190715191933.GA10934@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

For spinlocks the type spinlock_t should be used instead of "struct
spinlock".

Use DEFINE_SPINLOCK() and spare the run time initialization

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190704153803.12739-5-bigeasy@linutronix.de
---
V2: Rebase on 5.3-rc1. Massaged change log
---
 drivers/staging/most/net/net.c     |    3 +--
 drivers/staging/most/video/video.c |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/staging/most/net/net.c
+++ b/drivers/staging/most/net/net.c
@@ -69,7 +69,7 @@ struct net_dev_context {
 
 static struct list_head net_devices = LIST_HEAD_INIT(net_devices);
 static struct mutex probe_disc_mt; /* ch->linked = true, most_nd_open */
-static struct spinlock list_lock; /* list_head, ch->linked = false, dev_hold */
+static DEFINE_SPINLOCK(list_lock); /* list_head, ch->linked = false, dev_hold */
 static struct core_component comp;
 
 static int skb_to_mamac(const struct sk_buff *skb, struct mbo *mbo)
@@ -509,7 +509,6 @@ static int __init most_net_init(void)
 {
 	int err;
 
-	spin_lock_init(&list_lock);
 	mutex_init(&probe_disc_mt);
 	err = most_register_component(&comp);
 	if (err)
--- a/drivers/staging/most/video/video.c
+++ b/drivers/staging/most/video/video.c
@@ -54,7 +54,7 @@ struct comp_fh {
 };
 
 static struct list_head video_devices = LIST_HEAD_INIT(video_devices);
-static struct spinlock list_lock;
+static DEFINE_SPINLOCK(list_lock);
 
 static inline bool data_ready(struct most_video_dev *mdev)
 {
@@ -538,7 +538,6 @@ static int __init comp_init(void)
 {
 	int err;
 
-	spin_lock_init(&list_lock);
 	err = most_register_component(&comp);
 	if (err)
 		return err;
