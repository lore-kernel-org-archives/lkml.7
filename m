Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA63C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3C0C20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232543;
	bh=kdg5QZNVtGmqpcPFrk+cGsHAsdNydU+gcPhVjqrCepY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uMcBLsaEugC6xsPjy3N/OVYw3UDjY6tcq9HvdOJEQSlGal1nyWfbDaRRoRru0+4QI
	 wDkaoT4vRAeUxC0v++iXIsbtAbJvrqErE0+kzFxPSzzOayCS//ZYLT3Fgm51vMSsUZ
	 WQVQ0FuIc866NASi9R24lFnufgrHIFspgQA3UFNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731107AbfKHRCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:02:03 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:59424 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbfKHRB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:01:58 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aQ-0002sR-4h; Fri, 08 Nov 2019 17:58:14 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 10/11] irqchip/irq-gic-v3-its: Lock VLPI map array before translating it
Date:   Fri,  8 Nov 2019 16:58:04 +0000
Message-Id: <20191108165805.3071-11-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108165805.3071-1-maz@kernel.org>
References: <20191108165805.3071-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obtaining the mapping ivformation for a VLPI should always be
done with the vlpi_lock for this device held. Otherwise, we
expose ourselves to races against a concurrent unmap.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a83828e983ff..ae4acd13f97a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1489,12 +1489,14 @@ static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
 static int its_vlpi_get(struct irq_data *d, struct its_cmd_info *info)
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	struct its_vlpi_map *map = get_vlpi_map(d);
+	struct its_vlpi_map *map;
 	int ret = 0;
 
 	mutex_lock(&its_dev->event_map.vlpi_lock);
 
-	if (!its_dev->event_map.vm || !map->vm) {
+	map = get_vlpi_map(d);
+
+	if (!its_dev->event_map.vm || !map) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.20.1

