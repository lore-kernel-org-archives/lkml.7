Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B846C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1066E22CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 18:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfH1S4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 14:56:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48154 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfH1S4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:56:18 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3377-0002cv-8h; Wed, 28 Aug 2019 20:56:13 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D42E31C0DB9;
        Wed, 28 Aug 2019 20:56:12 +0200 (CEST)
Date:   Wed, 28 Aug 2019 18:56:12 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Don't include <linux/ktime.h> in rcutiny.h
Cc:     Christoph Hellwig <hch@lst.de>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156701857268.18437.15300664547652858807.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     24691069a348f82a95e0fa9697bb5656c6d8c48c
Gitweb:        https://git.kernel.org/tip/24691069a348f82a95e0fa9697bb5656c6d8c48c
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Thu, 22 Aug 2019 10:53:43 +09:00
Committer:     Paul E. McKenney <paulmck@linux.ibm.com>
CommitterDate: Mon, 26 Aug 2019 16:27:01 -07:00

rcu: Don't include <linux/ktime.h> in rcutiny.h

The kbuild reported a built failure due to a header loop when RCUTINY is
enabled with my pending riscv-nommu port.  Switch rcutiny.h to only
include the minimal required header to get HZ instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 include/linux/rcutiny.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 8e727f5..9bf1dfe 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -12,7 +12,7 @@
 #ifndef __LINUX_TINY_H
 #define __LINUX_TINY_H
 
-#include <linux/ktime.h>
+#include <asm/param.h> /* for HZ */
 
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
