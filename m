Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5A0C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE1C2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgAHBkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:40:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:52738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgAHBkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:40:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 516CBAFB0;
        Wed,  8 Jan 2020 01:40:01 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dave@stgolabs.net
Cc:     bigeasy@linutronix.de, bristot@redhat.com, jack@suse.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        longman@redhat.com, mingo@kernel.org, oleg@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, will@kernel.org,
        williams@redhat.com, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] locking/percpu-rwsem: Add might_sleep() for writer locking
Date:   Tue,  7 Jan 2020 17:33:05 -0800
Message-Id: <20200108013305.7732-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200108013305.7732-1-dave@stgolabs.net>
References: <20191115203906.fbo6t7d2n6xk3saw@linux-p48b>
 <20200108013305.7732-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are missing this annotation in percpu_down_write(). Correct
this.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---

Applies against your queue tree.

 kernel/locking/percpu-rwsem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 4cbeeada8d09..08db2abfa00d 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -212,6 +212,7 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	might_sleep();
 	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
 
 	/* Notify readers to take the slow path. */
-- 
2.16.4

