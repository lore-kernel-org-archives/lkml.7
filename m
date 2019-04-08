Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2884C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5EF92190B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750881;
	bh=tnJbTWW21PlO5Pu7ffmK6C//X8IHmjWs41PxznQuR0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=VgS58rRBc7IkKMr02zzUtXDdbCTqNLd+OiZW7Dst5ziF6/Cmd5ebqFC/F16KxHQub
	 jzxHvor7QzoZmSlj08L+nXbDp4sXdq8SHFjpecT988qFiMkZ3pUP19pfiJ97tksgAC
	 Pv7D742xj0YOylRYdUs1QaRemmKxRuIFPQh8xdhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDHTOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbfDHTOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:33 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 943A5218FD;
        Mon,  8 Apr 2019 19:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750873;
        bh=tnJbTWW21PlO5Pu7ffmK6C//X8IHmjWs41PxznQuR0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WWoBUwyW0wzwscycbTfxfZQUr4Um5TTqqqYYMS5VycPzlU57NTh5Kz8OrkgilzlyN
         hjkQN3f3/FmUf+vabKFq5FAsARgsTlded6KU5mcmg/bMAo5DEtiQ81ftRwbXEw/b15
         LJvtLe4om6fQKlodMSsu0aMiXrR/TkPHi0hvX1QY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 09/13] x86: lazy-preempt: properly check against preempt-mask
Date:   Mon,  8 Apr 2019 14:14:11 -0500
Message-Id: <58de20b4bd55e3813c3988344f6a4de3e2881d5e.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 0f8a27bb5f45cc8a66f488549cecc4ce4d4533c2 ]

should_resched() should check against preempt_offset after unmasking the
need-resched-bit. Otherwise should_resched() won't work for
preempt_offset != 0 and lazy-preempt set.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/x86/include/asm/preempt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 22992c837795..f66708779274 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 	/* preempt count == 0 ? */
 	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp)
+	if (tmp != preempt_offset)
 		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
-- 
2.14.1

