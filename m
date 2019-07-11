Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B38C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B6B20838
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N0bOZpjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGKGZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:25:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51913 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfGKGZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:25:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6B6PFuS2773761
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 10 Jul 2019 23:25:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6B6PFuS2773761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562826315;
        bh=9NVI2l+CH+yEiWCjAD0BrsgJmmpUAM62JcwOjoeTemo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N0bOZpjXhw3kxTbBt80ktau/p5t4PNSkEt4xeiRCyJGlAw3kMPGcLWSHTcQr+YtUr
         N145DHirneNzJFK0dqvId4XDFmDQ6Qy8BQhbDu+B/oiShI47wAf5pjPin/WlKJvqXm
         iqgtTT+zJFv66shJWD6kwcWURzjc9FZVZHXK6ua7mK5ZSOCNyRQwc27GucSh+GaE8v
         BD/ui5Evl0vjbqSl3AsYuGKSXX5QoFwbpX8Uma4MQLc4IlZWX0af08Ov9ItQGmtcIn
         H837ei4VHkT00hJ53wXe7L9B7LVeQvc+C1bhAls5MxhlgvdShm6CSLSSSdFrHBhKI0
         yMUAL9Bv7XadQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6B6PEMG2773758;
        Wed, 10 Jul 2019 23:25:14 -0700
Date:   Wed, 10 Jul 2019 23:25:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eiichi Tsukata <tipbot@zytor.com>
Message-ID: <tip-cbf5b73d162b22e044fe0b7d51dcaa33be065253@git.kernel.org>
Cc:     torvalds@linux-foundation.org, devel@etsukata.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, mingo@kernel.org,
          tglx@linutronix.de, devel@etsukata.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190711023501.963-1-devel@etsukata.com>
References: <20190711023501.963-1-devel@etsukata.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/stacktrace: Prevent infinite loop in
 arch_stack_walk_user()
Git-Commit-ID: cbf5b73d162b22e044fe0b7d51dcaa33be065253
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cbf5b73d162b22e044fe0b7d51dcaa33be065253
Gitweb:     https://git.kernel.org/tip/cbf5b73d162b22e044fe0b7d51dcaa33be065253
Author:     Eiichi Tsukata <devel@etsukata.com>
AuthorDate: Thu, 11 Jul 2019 11:35:01 +0900
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 11 Jul 2019 08:22:03 +0200

x86/stacktrace: Prevent infinite loop in arch_stack_walk_user()

arch_stack_walk_user() checks `if (fp == frame.next_fp)` to prevent a
infinite loop by self reference but it's not enogh for circular reference.

Once a lack of return address is found, there is no point to continue the
loop, so break out.

Fixes: 02b67518e2b1 ("tracing: add support for userspace stacktraces in tracing/iter_ctrl")
Signed-off-by: Eiichi Tsukata <devel@etsukata.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20190711023501.963-1-devel@etsukata.com

---
 arch/x86/kernel/stacktrace.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2abf27d7df6b..4f36d3241faf 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -129,11 +129,9 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 		if ((unsigned long)fp < regs->sp)
 			break;
-		if (frame.ret_addr) {
-			if (!consume_entry(cookie, frame.ret_addr, false))
-				return;
-		}
-		if (fp == frame.next_fp)
+		if (!frame.ret_addr)
+			break;
+		if (!consume_entry(cookie, frame.ret_addr, false))
 			break;
 		fp = frame.next_fp;
 	}
