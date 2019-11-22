Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0776C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790C120731
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401813;
	bh=MqCGkEaFKEvYpnpR5yjcDLhn3RcaqfJeMd3Ts7sMgNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1NGctEOpj/i/tcyMF8A3z4I09EnRKwjxlI154oKlsmKB7lbaTxj0ffT28U/bWrncL
	 L40b1UP5hF8dcaBZZG49b+S6Zu6+h21sC2htzg084H8bq8Wi8lcLM90KQm/qzsRPOq
	 li5Ls7zpKt5ZO8JT57tyW7IcO4Xe71aGWKT78w90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfKVFuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfKVFuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:50:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6FF820717;
        Fri, 22 Nov 2019 05:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401805;
        bh=MqCGkEaFKEvYpnpR5yjcDLhn3RcaqfJeMd3Ts7sMgNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3oXOUGVWqiYX3ZX+VjhQIxeOHU2e1+aVBH7X83ywNuZF1sVAbF70IlALeCg3IhRz
         M0kIiP9Ohnvln2U5rECHsWBeU2KdLalerJvSS488+yeY5oFpq4+UklGjb2TQeFI5jX
         TI5TuAbtHkgJHDf1GuJR6b5FenlLIwhFxVS2yv7I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shenghui Wang <shhuiw@foxmail.com>, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 050/219] bcache: do not mark writeback_running too early
Date:   Fri, 22 Nov 2019 00:46:22 -0500
Message-Id: <20191122054911.1750-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shenghui Wang <shhuiw@foxmail.com>

[ Upstream commit 79b791466e525c98f6aeee9acf5726e7b27f4231 ]

A fresh backing device is not attached to any cache_set, and
has no writeback kthread created until first attached to some
cache_set.

But bch_cached_dev_writeback_init run
"
	dc->writeback_running		= true;
	WARN_ON(test_and_clear_bit(BCACHE_DEV_WB_RUNNING,
			&dc->disk.flags));
"
for any newly formatted backing devices.

For a fresh standalone backing device, we can get something like
following even if no writeback kthread created:
------------------------
/sys/block/bcache0/bcache# cat writeback_running
1
/sys/block/bcache0/bcache# cat writeback_rate_debug
rate:		512.0k/sec
dirty:		0.0k
target:		0.0k
proportional:	0.0k
integral:	0.0k
change:		0.0k/sec
next io:	-15427384ms

The none ZERO fields are misleading as no alive writeback kthread yet.

Set dc->writeback_running false as no writeback thread created in
bch_cached_dev_writeback_init().

We have writeback thread created and woken up in bch_cached_dev_writeback
_start(). Set dc->writeback_running true before bch_writeback_queue()
called, as a writeback thread will check if dc->writeback_running is true
before writing back dirty data, and hung if false detected.

After the change, we can get the following output for a fresh standalone
backing device:
-----------------------
/sys/block/bcache0/bcache$ cat writeback_running
0
/sys/block/bcache0/bcache# cat writeback_rate_debug
rate:		0.0k/sec
dirty:		0.0k
target:		0.0k
proportional:	0.0k
integral:	0.0k
change:		0.0k/sec
next io:	0ms

v1 -> v2:
  Set dc->writeback_running before bch_writeback_queue() called,

Signed-off-by: Shenghui Wang <shhuiw@foxmail.com>
Signed-off-by: Coly Li <colyli@suse.de>

Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/writeback.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index ba5395fd386d5..b5fc3c6c7178e 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -781,7 +781,7 @@ void bch_cached_dev_writeback_init(struct cached_dev *dc)
 	bch_keybuf_init(&dc->writeback_keys);
 
 	dc->writeback_metadata		= true;
-	dc->writeback_running		= true;
+	dc->writeback_running		= false;
 	dc->writeback_percent		= 10;
 	dc->writeback_delay		= 30;
 	atomic_long_set(&dc->writeback_rate.rate, 1024);
@@ -810,6 +810,7 @@ int bch_cached_dev_writeback_start(struct cached_dev *dc)
 		destroy_workqueue(dc->writeback_write_wq);
 		return PTR_ERR(dc->writeback_thread);
 	}
+	dc->writeback_running = true;
 
 	WARN_ON(test_and_set_bit(BCACHE_DEV_WB_RUNNING, &dc->disk.flags));
 	schedule_delayed_work(&dc->writeback_rate_update,
-- 
2.20.1

