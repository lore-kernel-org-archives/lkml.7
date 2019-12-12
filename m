Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDD2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7362077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfLLHiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:38:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7221 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbfLLHiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:38:54 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 193F32A0078476331057;
        Thu, 12 Dec 2019 15:38:51 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 12 Dec 2019 15:38:42 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <linux@roeck-us.net>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhongjiang@huawei.com>
Subject: [PATCH] usb: typec: fusb302: Fix an undefined reference to 'extcon_get_state'
Date:   Thu, 12 Dec 2019 15:34:23 +0800
Message-ID: <1576136063-50916-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following compile error:

drivers/usb/typec/tcpm/fusb302.o: In function `tcpm_get_current_limit':
fusb302.c:(.text+0x3ee): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x422): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x450): undefined reference to `extcon_get_state'
fusb302.c:(.text+0x48c): undefined reference to `extcon_get_state'
drivers/usb/typec/tcpm/fusb302.o: In function `fusb302_probe':
fusb302.c:(.text+0x980): undefined reference to `extcon_get_extcon_dev'
make: *** [vmlinux] Error 1

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/usb/typec/tcpm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
index 72481bb..a81ea9f 100644
--- a/drivers/usb/typec/tcpm/Kconfig
+++ b/drivers/usb/typec/tcpm/Kconfig
@@ -32,6 +32,7 @@ endif # TYPEC_TCPCI
 config TYPEC_FUSB302
 	tristate "Fairchild FUSB302 Type-C chip driver"
 	depends on I2C
+	depends on EXTCON
 	help
 	  The Fairchild FUSB302 Type-C chip driver that works with
 	  Type-C Port Controller Manager to provide USB PD and USB
-- 
1.7.12.4

