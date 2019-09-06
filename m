Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8650CC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65801206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393242AbfIFLKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:10:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392227AbfIFLIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6E-00074K-Ec; Fri, 06 Sep 2019 13:08:18 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C1A841C0E06;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Lubomir Rintel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mmp: Do not call irq_set_default_host() on DT
 platforms
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809574.24167.17474658256308027802.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7224cec4e76c8d8169e328923597e659b705760d
Gitweb:        https://git.kernel.org/tip/7224cec4e76c8d8169e328923597e659b705760d
Author:        Lubomir Rintel <lkundrak@v3.sk>
AuthorDate:    Fri, 16 Aug 2019 20:18:49 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:34:34 +01:00

irqchip/mmp: Do not call irq_set_default_host() on DT platforms

Using a default domain on DT platforms is unnecessary, as the firmware
tables describe the full topology, and nothing is implicit.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
[maz: wrote an actual changelog]
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index 14618dc..0671c3b 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -395,7 +395,6 @@ static int __init mmp_of_init(struct device_node *node,
 	icu_data[0].conf_enable = mmp_conf.conf_enable;
 	icu_data[0].conf_disable = mmp_conf.conf_disable;
 	icu_data[0].conf_mask = mmp_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp_handle_irq);
 	max_icu_nr = 1;
 	return 0;
@@ -414,7 +413,6 @@ static int __init mmp2_of_init(struct device_node *node,
 	icu_data[0].conf_enable = mmp2_conf.conf_enable;
 	icu_data[0].conf_disable = mmp2_conf.conf_disable;
 	icu_data[0].conf_mask = mmp2_conf.conf_mask;
-	irq_set_default_host(icu_data[0].domain);
 	set_handle_irq(mmp2_handle_irq);
 	max_icu_nr = 1;
 	return 0;
