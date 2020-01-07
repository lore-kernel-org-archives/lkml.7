Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A477C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509624656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 15:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OgieY9+0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgAGPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 10:17:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27575 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 10:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578410235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4LUp+KV0Xs3fT6uEMj0PoIGzJKwKG2YrH/5vUC/DB9I=;
        b=OgieY9+0yhlk/Ga7GS4Lr42RBfB5kIEdZfgnrlf+nPjTxUGJbS6fWBLNtzMvSqsXqGmZDd
        HojUbZ4lfj6FXA/ChY21gkOVgu0NvIwbVXfWtKFfF7mrpBnER+1nyGofbfnqFvdYfwvaZL
        1gkCmEUYoJqt7Iy1M3Mq2b1Ev5hlqq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-f2624RUSP3m6tI7f5b3kKg-1; Tue, 07 Jan 2020 10:17:12 -0500
X-MC-Unique: f2624RUSP3m6tI7f5b3kKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F089C593A9;
        Tue,  7 Jan 2020 15:17:10 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 96EFF1036D1B;
        Tue,  7 Jan 2020 15:17:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Date:   Tue,  7 Jan 2020 10:16:19 -0500
Message-Id: <20200107151619.20802-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that the URL of the MCS lock paper listed in the source
code is no longer accessible. I did got question about where the paper
was. This patch updates the URL to BZ 206115 which contains a copy of
the paper from

  https://www.cs.rochester.edu/u/scott/papers/1991_TOCS_synch.pdf

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/qspinlock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10c6956..ce75b2270b58 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -31,10 +31,9 @@
 /*
  * The basic principle of a queue-based spinlock can best be understood
  * by studying a classic queue-based spinlock implementation called the
- * MCS lock. The paper below provides a good description for this kind
- * of lock.
+ * MCS lock. A copy of the original MCS lock papaer is available at
  *
- * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
+ * https://bugzilla.kernel.org/show_bug.cgi?id=206115
  *
  * This queued spinlock implementation is based on the MCS lock, however to make
  * it fit the 4 bytes we assume spinlock_t to be, and preserve its existing
-- 
2.18.1

