Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F126BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78F22077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfCMVCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:02:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:43850 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727408AbfCMVCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:02:12 -0400
X-UUID: ed3b61a1eaac4deeb74d58a6cd866892-20190314
X-UUID: ed3b61a1eaac4deeb74d58a6cd866892-20190314
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1527846795; Thu, 14 Mar 2019 05:02:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Mar 2019 05:02:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Mar 2019 05:02:02 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 1/3] mmc: sdio: Add helper macro for sdio_driver boilerplate
Date:   Thu, 14 Mar 2019 05:01:58 +0800
Message-ID: <6cb7e75934bc7ac56a0e7c6cbbc963f98a6730b0.1552510141.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1552510141.git.sean.wang@mediatek.com>
References: <cover.1552510141.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2E3F0C2F8990CB64BF5F3A34A71FAA3BF2422B16F826775C7306C7D187773D6C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This patch introduces the module_sdio_driver macro which is a convenience
macro for SDIO driver modules similar to module_usb_driver. It is intended
to be used by drivers which init/exit section does nothing but register/
unregister the SDIO driver. By using this macro it is possible to eliminate
a few lines of boilerplate code per SDIO driver.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Suggested-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/mmc/sdio_func.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/mmc/sdio_func.h b/include/linux/mmc/sdio_func.h
index 97ca105347a6..5685805533b5 100644
--- a/include/linux/mmc/sdio_func.h
+++ b/include/linux/mmc/sdio_func.h
@@ -111,6 +111,18 @@ struct sdio_driver {
 extern int sdio_register_driver(struct sdio_driver *);
 extern void sdio_unregister_driver(struct sdio_driver *);
 
+/**
+ * module_sdio_driver() - Helper macro for registering a SDIO driver
+ * @__sdio_driver: sdio_driver struct
+ *
+ * Helper macro for SDIO drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_sdio_driver(__sdio_driver) \
+	module_driver(__sdio_driver, sdio_register_driver, \
+		      sdio_unregister_driver)
+
 /*
  * SDIO I/O operations
  */
-- 
2.18.0

