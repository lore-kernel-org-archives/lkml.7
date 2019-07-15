Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF61C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189E321841
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200553;
	bh=x96MHjF5hXmAOPNhH+7wJICs+aYBWsibZOopNdLtvr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SwdvI5Km7jVmtMwmDnIfxr8XWFcExWYlCh5BC724RxX1Z2B+fHf5/VLTRsHNyZlWV
	 PdFss5yfbueG/WLwOaS2KrwcRZlYgDgZr5vfxKCVL2LkXVP+PaIswJTc2rbqZIdF/M
	 SybxVYMg+zcLz4hAcM/sx+Fz9QMlv8a1p237HlwQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390164AbfGOOWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:22:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390603AbfGOOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:22:24 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D880720868;
        Mon, 15 Jul 2019 14:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200543;
        bh=x96MHjF5hXmAOPNhH+7wJICs+aYBWsibZOopNdLtvr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnYgUW3w4DD5kbHmFUwQT3Hr11SErxOL+CV3vtGUC8rtqelMtKPPot+HrMAjFtBJ+
         0f2hYnuS0CpanN5VdG41OWZZJJe+vpvrbuKqYQxnSYWFkfApxOoRNE3yVWHBzN9El/
         hLrLgZKs7QZbIqQOmQYqckxzay7vEBXBMR0ZkpoA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Jilong Kou <koujilong@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miao Xie <miaoxie@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 074/158] sched/core: Add __sched tag for io_schedule()
Date:   Mon, 15 Jul 2019 10:16:45 -0400
Message-Id: <20190715141809.8445-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

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
index 6859ea1d5c04..795c63ca44a9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5133,7 +5133,7 @@ long __sched io_schedule_timeout(long timeout)
 }
 EXPORT_SYMBOL(io_schedule_timeout);
 
-void io_schedule(void)
+void __sched io_schedule(void)
 {
 	int token;
 
-- 
2.20.1

