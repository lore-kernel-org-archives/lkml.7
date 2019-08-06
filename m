Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1854C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7644E20651
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 10:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565085706;
	bh=l2L7hKM0gazybQJ7eY/btm4i/Lb7hzoHs45H8pleOdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x6ZNaxp31iV6Dw8nynAjZtaZKWJ6Au1a6snQaBRAt8dvsUr+okC4og3lSD0wxvm7f
	 lPMmGkPKwZvEDF5mBYdlGX/vbfoHjCeEQ6Mgc2sugkaPaVy5aEWOfBIIvCHbwfNy7I
	 YYa2wr8hy8uIBsskCszFQcEuuarcoljS6cpP69Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfHFKBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 06:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:59512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732726AbfHFKBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 06:01:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B999C1684;
        Tue,  6 Aug 2019 03:01:42 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 817F33F706;
        Tue,  6 Aug 2019 03:01:41 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/12] irqchip/gic-v3: Warn about inconsistent implementations of extended ranges
Date:   Tue,  6 Aug 2019 11:01:19 +0100
Message-Id: <20190806100121.240767-11-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806100121.240767-1-maz@kernel.org>
References: <20190806100121.240767-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As is it usual for the GIC, it isn't disallowed to put together a system
that is majorly inconsistent, with a distributor supporting the
extended ranges while some of the CPUs don't.

Kindly tell the user that things are sailing isn't going to be smooth.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3.c       | 5 +++++
 include/linux/irqchip/arm-gic-v3.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f53e58d398ba..334a10d9dbfb 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1014,6 +1014,11 @@ static void gic_cpu_init(void)
 
 	gic_enable_redist(true);
 
+	WARN((gic_data.ppi_nr > 16 || GIC_ESPI_NR != 0) &&
+	     !(gic_read_ctlr() & ICC_CTLR_EL1_ExtRange),
+	     "Distributor has extended ranges, but CPU%d doesn't\n",
+	     smp_processor_id());
+
 	rbase = gic_data_rdist_sgi_base();
 
 	/* Configure SGIs/PPIs as non-secure Group-1 */
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 9ec3349dee04..5cc10cf7cb3e 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -496,6 +496,7 @@
 #define ICC_CTLR_EL1_A3V_SHIFT		15
 #define ICC_CTLR_EL1_A3V_MASK		(0x1 << ICC_CTLR_EL1_A3V_SHIFT)
 #define ICC_CTLR_EL1_RSS		(0x1 << 18)
+#define ICC_CTLR_EL1_ExtRange		(0x1 << 19)
 #define ICC_PMR_EL1_SHIFT		0
 #define ICC_PMR_EL1_MASK		(0xff << ICC_PMR_EL1_SHIFT)
 #define ICC_BPR0_EL1_SHIFT		0
-- 
2.20.1

