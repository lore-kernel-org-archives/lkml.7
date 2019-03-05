Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FBBC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE73220848
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfCELdB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:33:01 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:41362 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfCELdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:33:01 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id F407D36CDA6B083DE78B;
        Tue,  5 Mar 2019 19:32:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BWpTd071851;
        Tue, 5 Mar 2019 19:32:51 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519330741-3291465 ;
          Tue, 5 Mar 2019 19:33:07 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 01/15] ARM: actions: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:33:52 +0800
Message-Id: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:33:07,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:32:47
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn x25BWpTd071851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: add a missing space between "adding" and "missing"

 arch/arm/mach-actions/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 4fd479c..1a8e078 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -107,6 +107,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	timer_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!timer_base_addr) {
 		pr_err("%s: could not map timer registers\n", __func__);
 		return;
@@ -119,6 +120,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	sps_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!sps_base_addr) {
 		pr_err("%s: could not map sps registers\n", __func__);
 		return;
@@ -132,6 +134,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		scu_base_addr = of_iomap(node, 0);
+		of_node_put(node);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
 			return;
-- 
2.9.5

