Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F11C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B33E20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 12:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfDEMnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:43:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEMni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 08:43:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35ChBCP2753902
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 05:43:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35ChBJA2753899;
        Fri, 5 Apr 2019 05:43:11 -0700
Date:   Fri, 5 Apr 2019 05:43:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-95c5c618fa4349b2ba13aebeabf71911208dfc5e@git.kernel.org>
Cc:     tglx@linutronix.de, mojha@codeaurora.org, jason@lakedaemon.net,
        marc.zyngier@arm.com, dan.carpenter@oracle.com, hpa@zytor.com,
        mingo@kernel.org, jiaxun.yang@flygoat.com,
        linux-kernel@vger.kernel.org
Reply-To: jiaxun.yang@flygoat.com, linux-kernel@vger.kernel.org,
          mojha@codeaurora.org, jason@lakedaemon.net, marc.zyngier@arm.com,
          tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          dan.carpenter@oracle.com
In-Reply-To: <20190329062136.GQ32613@kadam>
References: <20190329062136.GQ32613@kadam>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/urgent] irqchip/irq-ls1x: Missing error code in
 ls1x_intc_of_init()
Git-Commit-ID: 95c5c618fa4349b2ba13aebeabf71911208dfc5e
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

Commit-ID:  95c5c618fa4349b2ba13aebeabf71911208dfc5e
Gitweb:     https://git.kernel.org/tip/95c5c618fa4349b2ba13aebeabf71911208dfc5e
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Fri, 29 Mar 2019 09:21:37 +0300
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 5 Apr 2019 14:37:56 +0200

irqchip/irq-ls1x: Missing error code in ls1x_intc_of_init()

Currently, when irq_domain_add_linear() fails, the error code does not get
set so it returns zero which is wrong.  Fix it by setting the appropriate
error code.

Fixes: 9e543e22e204 ("irqchip: Add driver for Loongson-1 interrupt controller")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: kernel-janitors@vger.kernel.org
Link: https://lkml.kernel.org/r/20190329062136.GQ32613@kadam

---
 drivers/irqchip/irq-ls1x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ls1x.c b/drivers/irqchip/irq-ls1x.c
index 86b72fbd3b45..353111a10413 100644
--- a/drivers/irqchip/irq-ls1x.c
+++ b/drivers/irqchip/irq-ls1x.c
@@ -130,6 +130,7 @@ static int __init ls1x_intc_of_init(struct device_node *node,
 					     NULL);
 	if (!priv->domain) {
 		pr_err("ls1x-irq: cannot add IRQ domain\n");
+		err = -ENOMEM;
 		goto out_iounmap;
 	}
 
