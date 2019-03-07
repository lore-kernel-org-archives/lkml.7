Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5B3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D073420663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfCGAEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:04:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39966 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCGAD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:03:29 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h1gVJ-00086o-4P; Thu, 07 Mar 2019 00:03:17 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jason Baron <jbaron@akamai.com>, kgraul@linux.ibm.com,
        ktkhai@virtuozzo.com, kyeongdon.kim@lge.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com,
        Christoph Hellwig <hch@lst.de>,
        zhengbin <zhengbin13@huawei.com>, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        houtao1@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 2/8] aio_poll_wake(): don't set ->woken if we ignore the wakeup
Date:   Thu,  7 Mar 2019 00:03:10 +0000
Message-Id: <20190307000316.31133-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
References: <CAHk-=wghRmdYKRAwakeHmjcpbLt9fJAHyU2x8s_NZONhz6RTOw@mail.gmail.com>
 <20190307000316.31133-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

In case of early wakeups, aio_poll() assumes that aio_poll_complete()
has either already happened or is imminent.  In that case we do not
want to put iocb on the list of cancellables.  However, ignored
wakeups need to be treated as if wakeup has not happened at all.
Trivially fixed by having aio_poll_wake() set ->woken only after
it's committed to taking iocb out of the waitqueue.

Spotted-by: zhengbin <zhengbin13@huawei.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/aio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ea30b78187ed..3a8b894378e0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1668,13 +1668,13 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	__poll_t mask = key_to_poll(key);
 	unsigned long flags;
 
+	/* for instances that support it check for an event match first: */
+	if (mask && !(mask & req->events))
+		return 0;
+
 	req->woken = true;
 
-	/* for instances that support it check for an event match first: */
 	if (mask) {
-		if (!(mask & req->events))
-			return 0;
-
 		/*
 		 * Try to complete the iocb inline if we can. Use
 		 * irqsave/irqrestore because not all filesystems (e.g. fuse)
-- 
2.11.0

