Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DD2C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC10206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141628;
	bh=o6dh4ufHmInF4oLXS+RpJ8zetcuZ7OaJYzjhG7NToF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hQJlBSkEbeq0r9v+kdn6rlXpAtJ/KRj6zBh8Ct5Wtq4803K0rktIPiDdFRBXifvru
	 JJL6yoHLNeK+1yrvsvtbPf5Jy4oS+H1sQPFISuOQnJbi36yV8NbfJBjU3HPhzW6BL2
	 SO0KngPqb9LAPn7rjvKvTyiVtXAxKJTftIPAwnhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfKSFdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbfKSFdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:39 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B86121783;
        Tue, 19 Nov 2019 05:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141618;
        bh=o6dh4ufHmInF4oLXS+RpJ8zetcuZ7OaJYzjhG7NToF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTqvGrcrQNuDLAPcsLYk+3Em+VvIZ4dPI5HkCUs7Of2P4JZWBx8W5/r3KFsHZvCyX
         6Alo65XwEcyX8EsDu0pM3cRdWiMxypmMCvOOVYHlQ+UwttbXa/nJr4o45Pv2P9I53v
         h29zHGMAVcQaBGrGch+/SiGtv93VChF5SUebCjoo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 185/422] kprobes: Dont call BUG_ON() if there is a kprobe in use on free list
Date:   Tue, 19 Nov 2019 06:16:22 +0100
Message-Id: <20191119051410.471648112@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit cbdd96f5586151e48317d90a403941ec23f12660 ]

Instead of calling BUG_ON(), if we find a kprobe in use on free kprobe
list, just remove it from the list and keep it on kprobe hash list
as same as other in-use kprobes.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naveen N . Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/153666126882.21306.10738207224288507996.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kprobes.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index b8efca9dc2cbb..aed90788db5c1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -544,8 +544,14 @@ static void do_free_cleaned_kprobes(void)
 	struct optimized_kprobe *op, *tmp;
 
 	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
-		BUG_ON(!kprobe_unused(&op->kp));
 		list_del_init(&op->list);
+		if (WARN_ON_ONCE(!kprobe_unused(&op->kp))) {
+			/*
+			 * This must not happen, but if there is a kprobe
+			 * still in use, keep it on kprobes hash list.
+			 */
+			continue;
+		}
 		free_aggr_kprobe(&op->kp);
 	}
 }
-- 
2.20.1



