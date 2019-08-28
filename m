Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C16C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29150217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 09:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfH1JMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 05:12:06 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:25511 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726408AbfH1JME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 05:12:04 -0400
X-UUID: 4c1be4bdcdd8419ca0e2f7c55482f8f8-20190828
X-UUID: 4c1be4bdcdd8419ca0e2f7c55482f8f8-20190828
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 525857148; Wed, 28 Aug 2019 17:11:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 28 Aug 2019 17:12:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 28 Aug 2019 17:12:04 +0800
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>
CC:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v7 03/13] soc: mediatek: Refactor polling timeout and documentation
Date:   Wed, 28 Aug 2019 17:11:36 +0800
Message-ID: <1566983506-26598-4-git-send-email-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
References: <1566983506-26598-1-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use USEC_PER_SEC to indicate the polling timeout directly.
And add documentation of scp_domain_data.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 503222d..e97fc0e 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -21,7 +21,7 @@
 #include <dt-bindings/power/mt8173-power.h>
 
 #define MTK_POLL_DELAY_US   10
-#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
+#define MTK_POLL_TIMEOUT    USEC_PER_SEC
 
 #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
 #define MTK_SCPD_FWAIT_SRAM		BIT(1)
@@ -108,6 +108,17 @@ enum clk_id {
 
 #define MAX_CLKS	3
 
+/**
+ * struct scp_domain_data - scp domain data for power on/off flow
+ * @name: The domain name.
+ * @sta_mask: The mask for power on/off status bit.
+ * @ctl_offs: The offset for main power control register.
+ * @sram_pdn_bits: The mask for sram power control bits.
+ * @sram_pdn_ack_bits: The mask for sram power control acked bits.
+ * @bus_prot_mask: The mask for single step bus protection.
+ * @clk_id: The basic clocks required by this power domain.
+ * @caps: The flag for active wake-up action.
+ */
 struct scp_domain_data {
 	const char *name;
 	u32 sta_mask;
-- 
1.8.1.1.dirty

