Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82661CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6342D222CE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfJ1MN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:13:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728536AbfJ1MNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:13:19 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DA576D0D9DB9D6B6062C;
        Mon, 28 Oct 2019 20:13:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 28 Oct 2019 20:13:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <olof@lixom.net>, <bhelgaas@google.com>, <arnd@arndb.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/5] bus: hisi_lpc: Clean some types
Date:   Mon, 28 Oct 2019 20:10:03 +0800
Message-ID: <1572264605-172363-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
References: <1572264605-172363-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse complains of these:
drivers/bus/hisi_lpc.c:82:38: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:82:38:    expected void const volatile [noderef] <asn:2>*addr
drivers/bus/hisi_lpc.c:82:38:    got unsigned char *
drivers/bus/hisi_lpc.c:131:35: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:131:35:    expected unsigned char *mbase
drivers/bus/hisi_lpc.c:131:35:    got void [noderef] <asn:2>*membase
drivers/bus/hisi_lpc.c:186:35: warning: incorrect type in argument 1 (different address spaces)
drivers/bus/hisi_lpc.c:186:35:    expected unsigned char *mbase
drivers/bus/hisi_lpc.c:186:35:    got void [noderef] <asn:2>*membase
drivers/bus/hisi_lpc.c:228:16: warning: cast to restricted __le32
drivers/bus/hisi_lpc.c:251:13: warning: incorrect type in assignment (different base types)
drivers/bus/hisi_lpc.c:251:13:    expected unsigned int [unsigned] [usertype] val
drivers/bus/hisi_lpc.c:251:13:    got restricted __le32 [usertype] <noident>

Clean them up.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 20c957185af2..8101df901830 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -74,7 +74,7 @@ struct hisi_lpc_dev {
 /* About 10us. This is specific for single IO operations, such as inb */
 #define LPC_PEROP_WAITCNT	100
 
-static int wait_lpc_idle(unsigned char *mbase, unsigned int waitcnt)
+static int wait_lpc_idle(void __iomem *mbase, unsigned int waitcnt)
 {
 	u32 status;
 
@@ -209,7 +209,7 @@ static u32 hisi_lpc_comm_in(void *hostdata, unsigned long pio, size_t dwidth)
 	struct hisi_lpc_dev *lpcdev = hostdata;
 	struct lpc_cycle_para iopara;
 	unsigned long addr;
-	u32 rd_data = 0;
+	__le32 rd_data = 0;
 	int ret;
 
 	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
@@ -244,13 +244,12 @@ static void hisi_lpc_comm_out(void *hostdata, unsigned long pio,
 	struct lpc_cycle_para iopara;
 	const unsigned char *buf;
 	unsigned long addr;
+	__le32 _val = cpu_to_le32(val);
 
 	if (!lpcdev || !dwidth || dwidth > LPC_MAX_DWIDTH)
 		return;
 
-	val = cpu_to_le32(val);
-
-	buf = (const unsigned char *)&val;
+	buf = (const unsigned char *)&_val;
 	addr = hisi_lpc_pio_to_addr(lpcdev, pio);
 
 	iopara.opflags = FG_INCRADDR_LPC;
-- 
2.17.1

