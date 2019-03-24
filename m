Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D5120989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 21:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbfCXVQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 17:16:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42161 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXVQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 17:16:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2OLGknt1635524
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 24 Mar 2019 14:16:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2OLGjIX1635521;
        Sun, 24 Mar 2019 14:16:45 -0700
Date:   Sun, 24 Mar 2019 14:16:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Prasad Sodagudi <tipbot@zytor.com>
Message-ID: <tip-59c39840f5abf4a71e1810a8da71aaccd6c17d26@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, psodagud@codeaurora.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          psodagud@codeaurora.org, hpa@zytor.com, mingo@kernel.org
In-Reply-To: <1553439424-6529-1-git-send-email-psodagud@codeaurora.org>
References: <1553439424-6529-1-git-send-email-psodagud@codeaurora.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq: Prevent use-after-free and work list
 corruption
Git-Commit-ID: 59c39840f5abf4a71e1810a8da71aaccd6c17d26
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

Commit-ID:  59c39840f5abf4a71e1810a8da71aaccd6c17d26
Gitweb:     https://git.kernel.org/tip/59c39840f5abf4a71e1810a8da71aaccd6c17d26
Author:     Prasad Sodagudi <psodagud@codeaurora.org>
AuthorDate: Sun, 24 Mar 2019 07:57:04 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 24 Mar 2019 22:13:17 +0100

genirq: Prevent use-after-free and work list corruption

When irq_set_affinity_notifier() replaces the notifier, then the
reference count on the old notifier is dropped which causes it to be
freed. But nothing ensures that the old notifier is not longer queued
in the work list. If it is queued this results in a use after free and
possibly in work list corruption.

Ensure that the work is canceled before the reference is dropped.

Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: marc.zyngier@arm.com
Link: https://lkml.kernel.org/r/1553439424-6529-1-git-send-email-psodagud@codeaurora.org

---
 kernel/irq/manage.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1401afa0d58a..53a081392115 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -357,8 +357,10 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 	desc->affinity_notify = notify;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-	if (old_notify)
+	if (old_notify) {
+		cancel_work_sync(&old_notify->work);
 		kref_put(&old_notify->kref, old_notify->release);
+	}
 
 	return 0;
 }
