Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C599C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D771F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfCVMgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:36:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389249AbfCVMKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MCAJdA568458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 05:10:19 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MCAIsU568452;
        Fri, 22 Mar 2019 05:10:18 -0700
Date:   Fri, 22 Mar 2019 05:10:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chen Jie <tipbot@zytor.com>
Message-ID: <tip-5a07168d8d89b00fe1760120714378175b3ef992@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        dvhart@infradead.org, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, chenjie6@huawei.com, zengweilin@huawei.com
Reply-To: zengweilin@huawei.com, chenjie6@huawei.com, peterz@infradead.org,
          hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, dvhart@infradead.org
In-Reply-To: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
References: <1552621478-119787-1-git-send-email-chenjie6@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/urgent] futex: Ensure that futex address is aligned in
 handle_futex_death()
Git-Commit-ID: 5a07168d8d89b00fe1760120714378175b3ef992
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

Commit-ID:  5a07168d8d89b00fe1760120714378175b3ef992
Gitweb:     https://git.kernel.org/tip/5a07168d8d89b00fe1760120714378175b3ef992
Author:     Chen Jie <chenjie6@huawei.com>
AuthorDate: Fri, 15 Mar 2019 03:44:38 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 22 Mar 2019 13:05:26 +0100

futex: Ensure that futex address is aligned in handle_futex_death()

The futex code requires that the user space addresses of futexes are 32bit
aligned. sys_futex() checks this in futex_get_keys() but the robust list
code has no alignment check in place.

As a consequence the kernel crashes on architectures with strict alignment
requirements in handle_futex_death() when trying to cmpxchg() on an
unaligned futex address which was retrieved from the robust list.

[ tglx: Rewrote changelog, proper sizeof() based alignement check and add
  	comment ]

Fixes: 0771dfefc9e5 ("[PATCH] lightweight robust futexes: core")
Signed-off-by: Chen Jie <chenjie6@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: <dvhart@infradead.org>
Cc: <peterz@infradead.org>
Cc: <zengweilin@huawei.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1552621478-119787-1-git-send-email-chenjie6@huawei.com

---
 kernel/futex.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index c3b73b0311bc..9e40cf7be606 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3436,6 +3436,10 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
 {
 	u32 uval, uninitialized_var(nval), mval;
 
+	/* Futex address must be 32bit aligned */
+	if ((((unsigned long)uaddr) % sizeof(*uaddr)) != 0)
+		return -1;
+
 retry:
 	if (get_user(uval, uaddr))
 		return -1;
