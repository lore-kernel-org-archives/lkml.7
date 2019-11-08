Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A0AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495DD2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214724;
	bh=o6dh4ufHmInF4oLXS+RpJ8zetcuZ7OaJYzjhG7NToF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bpGSXUycd2jh7l3/ey/hrim0I+AhChfJbCtmMbqdMnlF3Y+XFK7IQPxKL6hhz8qzq
	 UHj+PmwBLyEMZgAPULNu12X51mLTn1JTjpeghwQ4yOtVkmtCAA3lE7AhOrgiKJxz5g
	 MVgCw8boli83k+wYp6xP14527Vo3pCZ0o0V+HGP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390211AbfKHMFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:05:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389528AbfKHLlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:41:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE70222CF;
        Fri,  8 Nov 2019 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213297;
        bh=o6dh4ufHmInF4oLXS+RpJ8zetcuZ7OaJYzjhG7NToF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+s2hCH0Vktej00JmTku/tfkPVuB/nkmTpLgYpjNSkP3jcKfC8W5MG45r4vvosLSi
         pmKPw+NNMBN7BR07gvAizgDCPzZxrVJdQEvMUvZy2IgUoG3CbCCrXLMfUB9XcJNMqb
         y0xnZW9LcKjvquE7jeu8KKl6KR7fzopmRJwShPFk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 154/205] kprobes: Don't call BUG_ON() if there is a kprobe in use on free list
Date:   Fri,  8 Nov 2019 06:37:01 -0500
Message-Id: <20191108113752.12502-154-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

