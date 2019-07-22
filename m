Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D3BC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EB121E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="5Bv3co0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfGVJZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:25:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfGVJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:25:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M9P82q3761103
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 02:25:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M9P82q3761103
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563787508;
        bh=X+Gtu1qOe3apPaoAOpj10EDUufvYamuZC8/F4saLTf0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=5Bv3co0oWD58gfjHQ8qBSJZcMPm+G53OXBvnn6kpk53fJkFuz7KOOsCDtdzyHhVhG
         SIHsZyC5WJi6jUHhNB1BYs4+cnB02I4jJT79zgRg7KxK4sCAnGSeZ3wGLcHjkzqp9R
         sVTm/Q9x8VCcjOv7Y9ZaMGSFeUswopVg6FZvypo1JFszMdJMdnpfLG/3cZarJQjZy5
         a69PmFOPw5QbUKh+Z8uxtDipYQyOdOuTVkmTa/Bgk9RJUE8/lNXDKhAfTEXM6RZC0o
         WkRWDr9fCc29+ucj1n3THyVLhgJSW77iIB9LhSJ8Nzltlw9EMv5Ra8yZwas2JouZUC
         MGC9IEneBWpSw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M9P7RI3761100;
        Mon, 22 Jul 2019 02:25:07 -0700
Date:   Mon, 22 Jul 2019 02:25:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vasily Averin <tipbot@zytor.com>
Message-ID: <tip-f9adc23ee91e6f561bb70c6147d8d45bd164d62f@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, vvs@virtuozzo.com,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, arnd@arndb.de, vvs@virtuozzo.com,
          hpa@zytor.com
In-Reply-To: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
References: <12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] futex: Cleanup generic SMP variant of
 arch_futex_atomic_op_inuser()
Git-Commit-ID: f9adc23ee91e6f561bb70c6147d8d45bd164d62f
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

Commit-ID:  f9adc23ee91e6f561bb70c6147d8d45bd164d62f
Gitweb:     https://git.kernel.org/tip/f9adc23ee91e6f561bb70c6147d8d45bd164d62f
Author:     Vasily Averin <vvs@virtuozzo.com>
AuthorDate: Tue, 16 Jul 2019 09:22:03 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 11:20:10 +0200

futex: Cleanup generic SMP variant of arch_futex_atomic_op_inuser()

The generic SMP variant of arch_futex_atomic_op_inuser() returns always
-ENOSYS so the switch case and surrounding code are pointless. Remove it
and just return -ENOSYS.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lkml.kernel.org/r/12bdaca8-99eb-e576-f842-5970ab1d6a92@virtuozzo.com

---
 include/asm-generic/futex.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/include/asm-generic/futex.h b/include/asm-generic/futex.h
index 8666fe7f35d7..02970b11f71f 100644
--- a/include/asm-generic/futex.h
+++ b/include/asm-generic/futex.h
@@ -118,26 +118,7 @@ futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
 static inline int
 arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
 {
-	int oldval = 0, ret;
-
-	pagefault_disable();
-
-	switch (op) {
-	case FUTEX_OP_SET:
-	case FUTEX_OP_ADD:
-	case FUTEX_OP_OR:
-	case FUTEX_OP_ANDN:
-	case FUTEX_OP_XOR:
-	default:
-		ret = -ENOSYS;
-	}
-
-	pagefault_enable();
-
-	if (!ret)
-		*oval = oldval;
-
-	return ret;
+	return -ENOSYS;
 }
 
 static inline int
