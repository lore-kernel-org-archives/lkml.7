Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2B6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340D720714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418763;
	bh=k+zAYsoWvMmMxQVYUXNHmoxyfXwgy1E1ib5zhobtrJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXqxew8B0Gd3AenM1map3vBZIp4duZ2yVUTNX0+9GAlHEdtkixCtXYemSOpQlcKeb
	 8p+ZsmAeADZ4pBuuAL/9qk0I4c5Fl2MSSLVVhlHqh98EcxSgX6upzNEXUMdcPs15h+
	 Hcff9bXL9TKgfhTuNmo6bZh/LACKSeaGrMTDyuoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfKVKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:54374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfKVKck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:32:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42F382071C;
        Fri, 22 Nov 2019 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418759;
        bh=k+zAYsoWvMmMxQVYUXNHmoxyfXwgy1E1ib5zhobtrJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vp+nEF8QmZlj0X9NbNef3h2GWJUH6jRZuo7j/8FTfOpMT1UWJ6KubW/WLFpbEUBDC
         bqO8ao/eP5O5r6DWcUFdKeE6gauSotmBMC5LjjmhHbp7KtzWPQlQMcrXgn/WpzwPqd
         abOLBNJoaC6HrnGhkzpsO9St0Cdx/JBaEowmNFkw=
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
Subject: [PATCH 4.4 043/159] kprobes: Dont call BUG_ON() if there is a kprobe in use on free list
Date:   Fri, 22 Nov 2019 11:27:14 +0100
Message-Id: <20191122100737.054664317@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
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
index fdde50d39a46d..f59f49bc2a5d5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -514,8 +514,14 @@ static void do_free_cleaned_kprobes(void)
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



