Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF35C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D1A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263264;
	bh=cwQDyKb3VMvbDLWN7gApPn+tm++UAFlIEiifDux42J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ePQTmvSBFMzxohwH2PQICmyGFJN4YaUYeOeXJXSJD0oxve7cCHnZK4f8qAy+/2DiO
	 QZk8LoUPMrEyWj/1FaQUdELvAldEEQRAzuKXD85tIPp0Pc1g0DYnvLm5/7llWu/OuG
	 s1e+ue5YQrol4sAvreiLcgVEyCgPU/wa6jQOyjm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733014AbfIWS1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:27:43 -0400
Received: from foss.arm.com ([217.140.110.172]:46988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfIWS1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:27:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A331BB2;
        Mon, 23 Sep 2019 11:27:40 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518013F694;
        Mon, 23 Sep 2019 11:27:34 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 19/35] irqchip/gic-v4.1: Suppress per-VLPI doorbell
Date:   Mon, 23 Sep 2019 19:25:50 +0100
Message-Id: <20190923182606.32100-20-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
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
index eda35e66237f..b791c9beddf2 100644
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

