Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6AAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0097A214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334977;
	bh=it8lY9TZDTewnGZR8yaGYsXgoP1j7QOUfj3hV9NYNTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02jPD3VZwajVd7irTqQZK54r1ESQMyBJPxzQWFZ4mNQ1v5r6JcS9XVAP8G/coqCMQ
	 2a5tNXaFnXbiw9ZTJoUdo0KKE0yUVg7Z79FQWnftsRILBgWtwSOxMNmBWD26QL1zxo
	 hsC+8BE4D7hnOuKH2+Hw9WeIxwFGG6zHszUxB8CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfCKT4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728749AbfCKT4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:56:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60C9214AE;
        Mon, 11 Mar 2019 19:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334201;
        bh=it8lY9TZDTewnGZR8yaGYsXgoP1j7QOUfj3hV9NYNTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VvHcI8Ah7CI2/RskHbEORtezFKLyL5SlAz7Uw37+o6OO7FN4h0lbYyJXi8Oj43LrM
         glic1p/cClIIaGJyv4OJts8963n7l4PslLRffYUhatwk5NpwyaGQKCmV0E7cjWZ022
         UaBsnOVbDQ3ZWyUq6pDazENtxbKSlqZrZGXVO52U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <ren_guo@c-sky.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 42/52] csky: Fixup dead loop in show_stack
Date:   Mon, 11 Mar 2019 15:55:06 -0400
Message-Id: <20190311195516.137772-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

[ Upstream commit 131aee8b9807bc98379fa5a0270389dbc7dcec90 ]

When STACKTRACE is enabled, we must pass fp as stack for unwind,
otherwise random value in stack will casue a dead loop.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Lu Baoquan <lu.baoquan@intellif.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/dumpstack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index a9a03ac57ec5..28d2deb0848d 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -47,7 +47,11 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		if (task)
 			stack = (unsigned long *)task->thread.esp0;
 		else
+#ifdef CONFIG_STACKTRACE
+			asm volatile("mov %0, r8\n":"=r"(stack)::"memory");
+#else
 			stack = (unsigned long *)&stack;
+#endif
 	}
 	endstack = (unsigned long *)
 		(((unsigned long)stack + THREAD_SIZE - 1) & -THREAD_SIZE);
-- 
2.19.1

