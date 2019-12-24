Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF30C2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F1120706
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187782;
	bh=sofTiE/O+Tz6TEQPuGCdXYrRHmwdFceNL5oa3+oLZ6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scQZ7Xk23QPsufcEnksBgDVe1MNqY5bk4Tjio/Zali1xYLZkVKpqRYtXJSQditZ11
	 ECwousPOY2GYBoQJ/G6vVrD6jLPwKLybkIC7hqjoVL23mBdl2s6+mrjY+lVoJzyevt
	 uiVx5vV3laBFjnWO41pR5Y+CyEmEL9PdVCCtO+Ug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfLXLnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:43:01 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48063 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbfLXLnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:43:01 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji5y-000169-H6; Tue, 24 Dec 2019 12:11:22 +0100
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
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 14/32] irqchip/gic-v4.1: Suppress per-VLPI doorbell
Date:   Tue, 24 Dec 2019 11:10:37 +0000
Message-Id: <20191224111055.11836-15-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since GICv4.1 gives us a per-VPE doorbell, avoid programming anything
else on VMOVI/VMAPI/VMAPTI and on any other action that would have
otherwise resulted in a per-VLPI doorbell to be programmed.

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 403f5753e1ed..f00c8ddd3798 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -719,7 +719,7 @@ static struct its_vpe *its_build_vmapti_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmapti_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmapti_cmd.db_enabled)
 		db = desc->its_vmapti_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -742,7 +742,7 @@ static struct its_vpe *its_build_vmovi_cmd(struct its_node *its,
 {
 	u32 db;
 
-	if (desc->its_vmovi_cmd.db_enabled)
+	if (!is_v4_1(its) && desc->its_vmovi_cmd.db_enabled)
 		db = desc->its_vmovi_cmd.vpe->vpe_db_lpi;
 	else
 		db = 1023;
@@ -1353,6 +1353,13 @@ static void its_vlpi_set_doorbell(struct irq_data *d, bool enable)
 	u32 event = its_get_event_id(d);
 	struct its_vlpi_map *map;
 
+	/*
+	 * GICv4.1 does away with the per-LPI nonsense, nothing to do
+	 * here.
+	 */
+	if (is_v4_1(its_dev->its))
+		return;
+
 	map = dev_event_to_vlpi_map(its_dev, event);
 
 	if (map->db_enabled == enable)
-- 
2.20.1

