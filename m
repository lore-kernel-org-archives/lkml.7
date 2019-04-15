Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCA6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1716020848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbfDORuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:50:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728036AbfDORtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:49:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 02E473ED7A4E7FCD7631;
        Tue, 16 Apr 2019 01:49:52 +0800 (CST)
Received: from FRA1000014316.huawei.com (100.126.230.97) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 01:49:42 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, <linuxarm@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/4 V3] ACPI: Let ACPI know we support Generic Initiator Affinity Structures
Date:   Tue, 16 Apr 2019 01:49:07 +0800
Message-ID: <20190415174907.102307-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
References: <20190415174907.102307-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [100.126.230.97]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until we tell ACPI that we support generic initiators, it will have
to operate in fall back domain mode and all _PXM entries should
be on existing non GI domains.

This patch sets the relevant OSC bit to make that happen.

Note that this currently doesn't take into account whether we have the relevant
setup code for a given architecture.  Do we want to make this optional, or
should the initial patch set just enable it for all ACPI supporting architectures?

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index eec263c9019e..ef251f454a5b 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -315,6 +315,7 @@ static void acpi_bus_osc_support(void)
 
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_HOTPLUG_OST_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_PCLPI_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |= OSC_SB_GENERIC_INITIATOR_SUPPORT;
 
 #ifdef CONFIG_X86
 	if (boot_cpu_has(X86_FEATURE_HWP)) {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d5dcebd7aad3..cc68b2ad0630 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -503,6 +503,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 
 extern bool osc_sb_apei_support_acked;
 extern bool osc_pc_lpi_support_confirmed;
-- 
2.19.1

