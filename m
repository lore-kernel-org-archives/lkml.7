Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B823C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5674B21775
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLWOSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:18:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:17844 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfLWOR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="211567547"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2019 06:17:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6410114CA; Mon, 23 Dec 2019 16:17:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/37] mfd: intel_soc_pmic_mrfld: Convert to use new SCU IPC API
Date:   Mon, 23 Dec 2019 17:17:07 +0300
Message-Id: <20191223141716.13727-29-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the Intel Merrifield PMIC driver over the new SCU IPC API
where the SCU IPC instance is passed to the functions.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_mrfld.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
index 26a1551c5faf..bd94c989d232 100644
--- a/drivers/mfd/intel_soc_pmic_mrfld.c
+++ b/drivers/mfd/intel_soc_pmic_mrfld.c
@@ -74,10 +74,11 @@ static const struct mfd_cell bcove_dev[] = {
 static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
 				    unsigned int *val)
 {
+	struct intel_soc_pmic *pmic = context;
 	u8 ipc_out;
 	int ret;
 
-	ret = intel_scu_ipc_ioread8(reg, &ipc_out);
+	ret = intel_scu_ipc_dev_ioread8(pmic->scu, reg, &ipc_out);
 	if (ret)
 		return ret;
 
@@ -88,10 +89,11 @@ static int bcove_ipc_byte_reg_read(void *context, unsigned int reg,
 static int bcove_ipc_byte_reg_write(void *context, unsigned int reg,
 				     unsigned int val)
 {
+	struct intel_soc_pmic *pmic = context;
 	u8 ipc_in = val;
 	int ret;
 
-	ret = intel_scu_ipc_iowrite8(reg, ipc_in);
+	ret = intel_scu_ipc_dev_iowrite8(pmic->scu, reg, ipc_in);
 	if (ret)
 		return ret;
 
@@ -117,6 +119,10 @@ static int bcove_probe(struct platform_device *pdev)
 	if (!pmic)
 		return -ENOMEM;
 
+	pmic->scu = devm_intel_scu_ipc_dev_get(dev);
+	if (!pmic->scu)
+		return -ENOMEM;
+
 	platform_set_drvdata(pdev, pmic);
 	pmic->dev = &pdev->dev;
 
-- 
2.24.0

