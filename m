Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20892C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E792B20449
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553710863;
	bh=6GVQbf2lt4o4cJkr8iHWK16691svUJpHtzL7mxaGbtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lNvrN83lz1/XfbFl+tmx0MzZejFcR+GnYc6gVS/iqSBYObv5ozvSeut03bCK1GxPH
	 vV9ibEkGSVFksCqWi+CiowvrzQRMps5pOTokeXPEUa+Q/bkJYSjPfJ/h1xpq046m8w
	 kyxmEkJEQTbA9pnHSvdzb4lEkA0bN6C5uXWiqx2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391077AbfC0SVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390700AbfC0SUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:20:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C77EB2082F;
        Wed, 27 Mar 2019 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710851;
        bh=6GVQbf2lt4o4cJkr8iHWK16691svUJpHtzL7mxaGbtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlnNWzZqv+mH50N2umszljbEPJuoky42aKuqZ9qW1+li2276hqAbjLafqhU44B/Av
         s4or7/EE3muwnkt2/503cOnWScMTw6T6a2ZMdhLGmjhlSj6LzcUi5EvP1LiTpA5ju3
         b/62P8GQy1tkq5EDiqEmvZpLVxS0UbJynXZYa1dw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 06/87] include/linux/relay.h: fix percpu annotation in struct rchan
Date:   Wed, 27 Mar 2019 14:19:19 -0400
Message-Id: <20190327182040.17444-6-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327182040.17444-1-sashal@kernel.org>
References: <20190327182040.17444-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 62461ac2e5b6520b6d65fc6d7d7b4b8df4b848d8 ]

The percpu member of this structure is declared as:
	struct ... ** __percpu member;
So its type is:
	__percpu pointer to pointer to struct ...

But looking at how it's used, its type should be:
	pointer to __percpu pointer to struct ...
and it should thus be declared as:
	struct ... * __percpu *member;

So fix the placement of '__percpu' in the definition of this
structures.

This silents a few Sparse's warnings like:
	warning: incorrect type in initializer (different address spaces)
	  expected void const [noderef] <asn:3> *__vpp_verify
	  got struct sched_domain **

Link: http://lkml.kernel.org/r/20190118144902.79065-1-luc.vanoostenryck@gmail.com
Fixes: 017c59c042d01 ("relay: Use per CPU constructs for the relay channel buffer pointers")
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jens Axboe <axboe@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/relay.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/relay.h b/include/linux/relay.h
index 68c1448e56bb..2560f8706408 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -65,7 +65,7 @@ struct rchan
 	struct kref kref;		/* channel refcount */
 	void *private_data;		/* for user-defined data */
 	size_t last_toobig;		/* tried to log event > subbuf size */
-	struct rchan_buf ** __percpu buf; /* per-cpu channel buffers */
+	struct rchan_buf * __percpu *buf; /* per-cpu channel buffers */
 	int is_global;			/* One global buffer ? */
 	struct list_head list;		/* for channel list */
 	struct dentry *parent;		/* parent dentry passed to open */
-- 
2.19.1

