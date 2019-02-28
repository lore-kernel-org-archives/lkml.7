Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13C9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8F3218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfB1VhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:37:18 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.170]:39570 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731069AbfB1VhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:37:17 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 27033723C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 15:37:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id zTMjgNJrhYTGMzTMjgdwfm; Thu, 28 Feb 2019 15:37:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=60546 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gzTMh-001rVD-B4; Thu, 28 Feb 2019 15:37:16 -0600
Date:   Thu, 28 Feb 2019 15:37:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] genirq: Mark expected switch fall-through
Message-ID: <20190228213714.GA9246@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gzTMh-001rVD-B4
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:60546
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warning:

kernel/irq/manage.c: In function ‘irq_do_set_affinity’:
kernel/irq/manage.c:198:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   cpumask_copy(desc->irq_common_data.affinity, mask);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
kernel/irq/manage.c:199:2: note: here
  case IRQ_SET_MASK_OK_NOCOPY:
  ^~~~

In order to get the warning mentioned above, the following
line was added to the top Makefile:

KBUILD_CFLAGS  += $(call cc-option,-Wimplicit-fallthrough=3,)

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
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
-- 
2.21.0

