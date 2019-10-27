Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03511CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA55421E6F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187517;
	bh=7WADeKBaB4arR8SftPdnUH6Zgraeo0sOTstc86e4hTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QzLIKkecEMzCuS6eYlMqbQftpcra1KaO9ssYKNieScy9UUUPRr70RakUXVVlFUpt7
	 N1fN5o7JLzuySMODoFa4J5HwsS4ey+hZRPGSN24FPN4zc2ZGKes1lrURce9NE1tx3h
	 SPEJbcNZS8vfYTfcH48BOA4wGjT6uHZ6Btby/hOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfJ0OpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:45:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfJ0OpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:45:16 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267A5214AF;
        Sun, 27 Oct 2019 14:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187515;
        bh=7WADeKBaB4arR8SftPdnUH6Zgraeo0sOTstc86e4hTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1v8UzLCqO0MdDSA4+Q2KaRcrzQnVzPnV316gLeJzeXQAU4GGsryQOWzB+Rm6YQhN
         mSZsiHY1cbtErphVcLFlu/AUFtUHNkWzSiaOztcyHnuuqmrTnhlUo0BQug28vWRhXr
         frtWk0osTXX3Jf2EXD1jyMsN7PEZrJDjrn9j0Uis=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 20/36] irqchip/gic-v4.1: Suppress per-VLPI doorbell
Date:   Sun, 27 Oct 2019 14:42:18 +0000
Message-Id: <20191027144234.8395-21-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GICv4.1 gives us a per-VPE doorbell, avoid programming anything
else on VMOVI/VMAPI/VMAPTI and on any other action that would have
otherwise resulted in a per-VLPI doorbell to be programmed.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 10bd156aa042..75c4d1a6f20d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -691,7 +691,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmapti_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmapti_cmd.db_enabled)
 		db = desc->its_vmapti_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -714,7 +714,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmovi_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmovi_cmd.db_enabled)
 		db = desc->its_vmovi_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -1227,6 +1227,13 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
 
+	/*
+	 * GICv4.1 does away with the per-LPI nonsense, nothing to do
+	 * here.
+	 */
+	if (is_v4_1(its_dev->its))
+		return;
+
 	if (its_dev->event_map.vlpi_maps[event].db_enabled == enable)
 		return;
 
-- 
2.20.1

