Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DAFC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 065A3216FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 20:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I3I/eDxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfE1UYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 16:24:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfE1UYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 16:24:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SKNwmq2218325
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 13:23:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SKNwmq2218325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559075039;
        bh=tlehJrju+Lh8zMfh1YbmXh3aTwOQejrF3vthB7kN5mQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=I3I/eDxLdINs2v5hsmVT+No9QQhH6vTnq9J1Hn2g4zYV5cTdb8fqxiSwHoThqTIFQ
         JDcC6D3MQasqIyyvxlAasG9PAfO8HTISRlZrmecQYIJboa3cT+XKtNpv0Y9rdhoj8c
         tg9JX3dY6AXxmZ/Lptx+3Q7qalMHDPRR7l5Fw0xSsIwhi1iYuZW7DAvd2CB8aHF4Ya
         +cLrFkhoYeMbQmsKWZiy7LaWGvi+pFLLlm18IgjsUgb7JpcQquVWVpdEDIrEZmsOji
         JhCn3y4B3M2ptZlif3ZmwMAASSGEhf+dGhXW2LIFSms/r/FxTs/EvQDRl0rOyU6CY5
         lQHBNnyRogYOg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SKNvoN2218322;
        Tue, 28 May 2019 13:23:57 -0700
Date:   Tue, 28 May 2019 13:23:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Geert Uytterhoeven <tipbot@zytor.com>
Message-ID: <tip-43b98d876f89dce732f50b71607b6d2bbb8d8e6a@git.kernel.org>
Cc:     hpa@zytor.com, geert+renesas@glider.be, marc.zyngier@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: mingo@kernel.org, marc.zyngier@arm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          geert+renesas@glider.be
In-Reply-To: <20190527115742.2693-1-geert+renesas@glider.be>
References: <20190527115742.2693-1-geert+renesas@glider.be>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] genirq/irqdomain: Remove WARN_ON() on out-of-memory
 condition
Git-Commit-ID: 43b98d876f89dce732f50b71607b6d2bbb8d8e6a
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

Commit-ID:  43b98d876f89dce732f50b71607b6d2bbb8d8e6a
Gitweb:     https://git.kernel.org/tip/43b98d876f89dce732f50b71607b6d2bbb8d8e6a
Author:     Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate: Mon, 27 May 2019 13:57:42 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 28 May 2019 13:10:55 -0700

genirq/irqdomain: Remove WARN_ON() on out-of-memory condition

There is no need to print a backtrace when memory allocation fails, as
the memory allocation core already takes care of that.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Link: https://lkml.kernel.org/r/20190527115742.2693-1-geert+renesas@glider.be

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a453e229f99c..e7d17cc3a3d7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -139,7 +139,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 
 	domain = kzalloc_node(sizeof(*domain) + (sizeof(unsigned int) * size),
 			      GFP_KERNEL, of_node_to_nid(of_node));
-	if (WARN_ON(!domain))
+	if (!domain)
 		return NULL;
 
 	if (fwnode && is_fwnode_irqchip(fwnode)) {
