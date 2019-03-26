Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73084C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4490E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582422;
	bh=MWI4RXkWJZsDxRFqx0YQQNIiZg9Bn5a/LmvDGROxMBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4W275NYRcot80+mP25fAaoyPgRgCiBlXgwYjNpU1SJMKjtmOpcNffYdo+5EjSjLQ
	 8cVpPsXRg7ou+f6cmLORv3bMQdCvUj+hXBmpokUiwxzSFu9NuSiUiMRGLkOdfnP09v
	 4gxWMMJaWDqM9dvZhtBBu3Y+Dup/aj0O071eEovc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732813AbfCZGkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbfCZGkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:40:19 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7DDC2087C;
        Tue, 26 Mar 2019 06:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582418;
        bh=MWI4RXkWJZsDxRFqx0YQQNIiZg9Bn5a/LmvDGROxMBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh1oosbv0ed3h+CpDD2urjUpR9Nhaza/dnEb+w+tjDJmq1WaNoSGqRoy2ji7Dlqna
         N/5KmIGbBw/JuoBin+YNtXF6VMcOvu1F6tvQ4t17/GzNChjKX88vZ0/Zs5BVzyC3pw
         buU2tMOL4wpLACGH5MoPf8h6LkSCuqSWJp+NPOvM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.0 49/52] locking/lockdep: Add debug_locks check in __lock_downgrade()
Date:   Tue, 26 Mar 2019 15:30:36 +0900
Message-Id: <20190326042703.598339291@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 71492580571467fb7177aade19c18ce7486267f5 upstream.

Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
warning right after a previous lockdep warning. It is likely that the
previous warning turned off lock debugging causing the lockdep to have
inconsistency states leading to the lock downgrade warning.

Fix that by add a check for debug_locks at the beginning of
__lock_downgrade().

Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Link: https://lkml.kernel.org/r/1547093005-26085-1-git-send-email-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/locking/lockdep.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3535,6 +3535,9 @@ static int __lock_downgrade(struct lockd
 	unsigned int depth;
 	int i;
 
+	if (unlikely(!debug_locks))
+		return 0;
+
 	depth = curr->lockdep_depth;
 	/*
 	 * This function is about (re)setting the class of a held lock,


