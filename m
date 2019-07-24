Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF0C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9297A20693
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999573;
	bh=EzkKUuaEp7qjK4fm/shaNJujSptQQlsYiCZmVZUkz7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RZ835GOtMDcHGNPMHaMb85MWhAIS9FGS+6Vc1QV28ibiYspRfrQjXlTv/PJzVvwzl
	 +i5i+Ts2nEKi1mHi90UpBXcdi5PiQ+h2+ARDSk+7nJ8ZUHIkY/DLmmLHQbf9lcm27J
	 sfjSnBFZfoxUWCDSsbAivlkBTkNBWuOsQBByJem0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbfGXTrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390118AbfGXTrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:47:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA98217D4;
        Wed, 24 Jul 2019 19:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997660;
        bh=EzkKUuaEp7qjK4fm/shaNJujSptQQlsYiCZmVZUkz7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHS8pNDuWukfxuQiqtXoUpekzaKiNhJhnF2YCmszpJYdghFnrXHf2q9eLDPI8qxLz
         8t8VFKPux/cWdqI+FmFWreGcX9ThALM9ZfK9Xw0rRycOG46PGM8FC4hJ4dQj+hIW5i
         h9v4LC2FJ24T9BjIASA+4sGmPLCmxu9Rhxp7xNXM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jilong Kou <koujilong@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 100/371] sched/core: Add __sched tag for io_schedule()
Date:   Wed, 24 Jul 2019 21:17:32 +0200
Message-Id: <20190724191732.360972400@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit e3b929b0a184edb35531153c5afcaebb09014f9d ]

Non-inline io_schedule() was introduced in:

  commit 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")

Keep in line with io_schedule_timeout(), otherwise "/proc/<pid>/wchan" will
report io_schedule() rather than its callers when waiting for IO.

Reported-by: Jilong Kou <koujilong@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 10ab56434f2f ("sched/core: Separate out io_schedule_prepare() and io_schedule_finish()")
Link: https://lkml.kernel.org/r/20190603091338.2695-1-gaoxiang25@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a75ad50b5e2f..242233490a49 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5175,7 +5175,7 @@ long __sched io_schedule_timeout(long timeout)
 }
 EXPORT_SYMBOL(io_schedule_timeout);
 
-void io_schedule(void)
+void __sched io_schedule(void)
 {
 	int token;
 
-- 
2.20.1



