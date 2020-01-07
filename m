Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C23C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039A72087F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UTt5Y2pK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgAGRte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:49:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25570 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728391AbgAGRtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:49:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578419372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=X+zqo0NbHh5cbkQHmKFsPVtgZKvFsxqLBaaKTc1KGTI=;
        b=UTt5Y2pKK5G8ShW6amUmHulXjbU8/Rg1nloKe9kJbkrcLzDCGM5rNpeBSX+BHquwhjxGYY
        r8odEF4PU317VnEX5FNj2rf4UsQDppDEWWjqGxO9MuIVwaE7Ni5ncMP+Pd2c7bOkbNbkXt
        bI/79LlsNn2y8lq1uioVrN5VGk7q/Wg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-KEbdmgX_N8WQZT4ApkC5rA-1; Tue, 07 Jan 2020 12:49:28 -0500
X-MC-Unique: KEbdmgX_N8WQZT4ApkC5rA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59FD18024E9;
        Tue,  7 Jan 2020 17:49:27 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5C367DB5D;
        Tue,  7 Jan 2020 17:49:23 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] locking/qspinlock: Fix inaccessible URL of MCS lock paper
Date:   Tue,  7 Jan 2020 12:49:14 -0500
Message-Id: <20200107174914.4187-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
 kernel/locking/qspinlock.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 2473f10c6956..b9515fcc9b29 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -31,14 +31,15 @@
 /*
  * The basic principle of a queue-based spinlock can best be understood
  * by studying a classic queue-based spinlock implementation called the
- * MCS lock. The paper below provides a good description for this kind
- * of lock.
+ * MCS lock. A copy of the original MCS lock paper ("Algorithms for Scalable
+ * Synchronization on Shared-Memory Multiprocessors by Mellor-Crummey and
+ * Scott") is available at
  *
- * http://www.cise.ufl.edu/tr/DOC/REP-1992-71.pdf
+ * https://bugzilla.kernel.org/show_bug.cgi?id=206115
  *
- * This queued spinlock implementation is based on the MCS lock, however to make
- * it fit the 4 bytes we assume spinlock_t to be, and preserve its existing
- * API, we must modify it somehow.
+ * This queued spinlock implementation is based on the MCS lock, however to
+ * make it fit the 4 bytes we assume spinlock_t to be, and preserve its
+ * existing API, we must modify it somehow.
  *
  * In particular; where the traditional MCS lock consists of a tail pointer
  * (8 bytes) and needs the next pointer (another 8 bytes) of its own node to
-- 
2.18.1

