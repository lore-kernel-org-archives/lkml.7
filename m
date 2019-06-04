Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C61C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4F723A1C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ok7kdjYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfFDKRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:17:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42650 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfFDKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:17:47 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x54AHT8A048287;
        Tue, 4 Jun 2019 05:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559643449;
        bh=P7u/0x1ABNz4IJDSe4vcOUhEhDTUB7ePRAMjbKE0Eww=;
        h=From:To:CC:Subject:Date;
        b=Ok7kdjYQ0Gfe6RfSkA3iOuxKo7k3WaFEDlfDgmYs3KTba/qaOFGyvVGgNI66/jA1O
         oG3AHr03unXKCn9SkdmlSIhw+UNTr0WRPEQp63Zqd7TrEV9oZn3VLgGEVzqc5lYwDO
         i1JXf3m7Un7+JkDqSrdTcQfg3zTk4wdpJpeQK79U=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x54AHTnf064832
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jun 2019 05:17:29 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 4 Jun
 2019 05:17:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 4 Jun 2019 05:17:27 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x54AHOnc015021;
        Tue, 4 Jun 2019 05:17:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <lokeshvutla@ti.com>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] irqchip: ti-sci-inta: Fix kernel crash if irq_create_fwspec_mapping fail
Date:   Tue, 4 Jun 2019 13:17:51 +0300
Message-ID: <20190604101751.8265-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_create_fwspec_mapping() can fail, returning 0 as parent_virq. In this
case vint_desc is going to be NULL in ti_sci_inta_alloc_irq() which will
cause NULL pointer dereference.

Also note that irq_create_fwspec_mapping() returns 'unsigned int' so the
check '<=' was wrong.

Use -EINVAL if irq_create_fwspec_mapping() returned with 0.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index 011b60a49e3f..ef4d625d2d80 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -159,9 +159,9 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	parent_fwspec.param[1] = vint_desc->vint_id;
 
 	parent_virq = irq_create_fwspec_mapping(&parent_fwspec);
-	if (parent_virq <= 0) {
+	if (parent_virq == 0) {
 		kfree(vint_desc);
-		return ERR_PTR(parent_virq);
+		return ERR_PTR(-EINVAL);
 	}
 	vint_desc->parent_virq = parent_virq;
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

