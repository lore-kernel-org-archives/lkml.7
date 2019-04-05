Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0218C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E7F20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbfDEMoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:44:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:44:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Chtt02753966
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:43:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35Chs6x2753963;
        Fri, 5 Apr 2019 05:43:54 -0700
Date:   Fri, 5 Apr 2019 05:43:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kefeng Wang <tipbot@zytor.com>
Message-ID: <tip-e8458e7afa855317b14915d7b86ab3caceea7eb6@git.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangkefeng.wang@huawei.com, tglx@linutronix.de, mingo@kernel.org,
        marc.zyngier@arm.com, mojha@codeaurora.org, hpa@zytor.com
Reply-To: marc.zyngier@arm.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, mojha@codeaurora.org,
          linux-arm-kernel@lists.infradead.org,
          linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com
In-Reply-To: <20190404074512.145533-1-wangkefeng.wang@huawei.com>
References: <20190404074512.145533-1-wangkefeng.wang@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] genirq: Initialize request_mutex if
 CONFIG_SPARSE_IRQ=n
Git-Commit-ID: e8458e7afa855317b14915d7b86ab3caceea7eb6
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

Commit-ID:  e8458e7afa855317b14915d7b86ab3caceea7eb6
Gitweb:     https://git.kernel.org/tip/e8458e7afa855317b14915d7b86ab3caceea7eb6
Author:     Kefeng Wang <wangkefeng.wang@huawei.com>
AuthorDate: Thu, 4 Apr 2019 15:45:12 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 14:37:56 +0200

genirq: Initialize request_mutex if CONFIG_SPARSE_IRQ=n

When CONFIG_SPARSE_IRQ is disable, the request_mutex in struct irq_desc
is not initialized which causes malfunction.

Fixes: 9114014cf4e6 ("genirq: Add mutex to irq desc to serialize request/free_irq()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: <linux-arm-kernel@lists.infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190404074512.145533-1-wangkefeng.wang@huawei.com

---
 kernel/irq/irqdesc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 13539e12cd80..9f8a709337cf 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -558,6 +558,7 @@ int __init early_irq_init(void)
 		alloc_masks(&desc[i], node);
 		raw_spin_lock_init(&desc[i].lock);
 		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
+		mutex_init(&desc[i].request_mutex);
 		desc_set_defaults(i, &desc[i], node, NULL, NULL);
 	}
 	return arch_early_irq_init();
