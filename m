Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE61C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2106E20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688727;
	bh=k7v/O//98hs+glhuNToKN+VL21zVJBnd2COAegwivTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d60gMSAoEfpTB9keu9WUh6k8w6YBzPD+uFPp/2952vvP4hIxnBBertT+QVbwewVZ+
	 oh3HgIsd325PPmDj38RxnAcDPYS5yJJ5gBHhEYg6hAdacpaLi1k2fZ/N4bRQK/bv/v
	 KxEj4UbJyhvYG0yr72B2PG2GjNQqLaS5ySgwWRs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfCDIee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfCDIe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0956F20823;
        Mon,  4 Mar 2019 08:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688468;
        bh=k7v/O//98hs+glhuNToKN+VL21zVJBnd2COAegwivTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w6nVNWpv+J8n8ED19e1WKIsAVhN7uhboutQpogfMMywcN0kBDRXP4B+AuuMMow/6H
         0BwOpVs+Tt44SEfoKLiAyp1EJZmWELa5GC7qOwS1CwSBH1EFXYO8c6dPJ1pN2fbfI4
         WxHWhP/cgXeoGGhxwVq34B7XJVdItUsq1GUvCigs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Srinivas Ramana <sramana@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-msm@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 19/88] genirq: Make sure the initial affinity is not empty
Date:   Mon,  4 Mar 2019 09:22:02 +0100
Message-Id: <20190304081631.354951328@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bddda606ec76550dd63592e32a6e87e7d32583f7 ]

If all CPUs in the irq_default_affinity mask are offline when an interrupt
is initialized then irq_setup_affinity() can set an empty affinity mask for
a newly allocated interrupt.

Fix this by falling back to cpu_online_mask in case the resulting affinity
mask is zero.

Signed-off-by: Srinivas Ramana <sramana@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arm-msm@vger.kernel.org
Link: https://lkml.kernel.org/r/1545312957-8504-1-git-send-email-sramana@codeaurora.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/manage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9dbdccab3b6a3..5c0ba5ca59308 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -393,6 +393,9 @@ int irq_setup_affinity(struct irq_desc *desc)
 	}
 
 	cpumask_and(&mask, cpu_online_mask, set);
+	if (cpumask_empty(&mask))
+		cpumask_copy(&mask, cpu_online_mask);
+
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
-- 
2.19.1



