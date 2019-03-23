Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DA3C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8986921874
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 11:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCWLh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 07:37:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52657 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCWLh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 07:37:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2NBbAkL998270
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 23 Mar 2019 04:37:10 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2NBb9Le998267;
        Sat, 23 Mar 2019 04:37:09 -0700
Date:   Sat, 23 Mar 2019 04:37:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Gustavo A. R. Silva" <tipbot@zytor.com>
Message-ID: <tip-93417a3fda2060f2a34e3341904024c5b6980d1f@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        keescook@chromium.org
Reply-To: gustavo@embeddedor.com, hpa@zytor.com, tglx@linutronix.de,
          keescook@chromium.org, linux-kernel@vger.kernel.org,
          mingo@kernel.org
In-Reply-To: <20190228213714.GA9246@embeddedor>
References: <20190228213714.GA9246@embeddedor>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Mark expected switch case fall-through
Git-Commit-ID: 93417a3fda2060f2a34e3341904024c5b6980d1f
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

Commit-ID:  93417a3fda2060f2a34e3341904024c5b6980d1f
Gitweb:     https://git.kernel.org/tip/93417a3fda2060f2a34e3341904024c5b6980d1f
Author:     Gustavo A. R. Silva <gustavo@embeddedor.com>
AuthorDate: Thu, 28 Feb 2019 15:37:14 -0600
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 23 Mar 2019 12:32:01 +0100

genirq: Mark expected switch case fall-through

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

With -Wimplicit-fallthrough added to CFLAGS:

 kernel/irq/manage.c: In function ‘irq_do_set_affinity’:
 kernel/irq/manage.c:198:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpumask_copy(desc->irq_common_data.affinity, mask);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 kernel/irq/manage.c:199:2: note: here
   case IRQ_SET_MASK_OK_NOCOPY:
   ^~~~

Annotate it.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>
Link: https://lkml.kernel.org/r/20190228213714.GA9246@embeddedor

---
 kernel/irq/manage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9ec34a2a6638..1401afa0d58a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -196,6 +196,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
 		cpumask_copy(desc->irq_common_data.affinity, mask);
+		/* fall through */
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
 		irq_set_thread_affinity(desc);
