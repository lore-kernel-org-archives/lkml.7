Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35921C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1640024FFB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731792AbfE3ED7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:03:59 -0400
Received: from mga12.intel.com ([192.55.52.136]:6382 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726031AbfE3EDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:03:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 21:03:54 -0700
X-ExtLoop1: 1
Received: from hyungwoo-ubuntu.sc.intel.com ([10.3.62.78])
  by FMSMGA003.fm.intel.com with ESMTP; 29 May 2019 21:03:54 -0700
From:   Hyungwoo Yang <hyungwoo.yang@intel.com>
To:     enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        jettrink@chromium.org
Subject: [PATCH] platform/chrome: fix crash during suspend
Date:   Wed, 29 May 2019 21:03:54 -0700
Message-Id: <1559189034-11268-1-git-send-email-hyungwoo.yang@intel.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel crashes during suspend due to wrong conversion in
suspend and resume functions.

Use the proper helper to get ishtp_cl_device instance.

Signed-off-by: Hyungwoo Yang <hyungwoo.yang@intel.com>
---
 drivers/platform/chrome/cros_ec_ishtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index e504d25..430731c 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -707,7 +707,7 @@ static int cros_ec_ishtp_reset(struct ishtp_cl_device *cl_device)
  */
 static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
 {
-	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
+	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = ishtp_get_client_data(cros_ish_cl);
 
@@ -722,7 +722,7 @@ static int __maybe_unused cros_ec_ishtp_suspend(struct device *device)
  */
 static int __maybe_unused cros_ec_ishtp_resume(struct device *device)
 {
-	struct ishtp_cl_device *cl_device = dev_get_drvdata(device);
+	struct ishtp_cl_device *cl_device = ishtp_dev_to_cl_device(device);
 	struct ishtp_cl	*cros_ish_cl = ishtp_get_drvdata(cl_device);
 	struct ishtp_cl_data *client_data = ishtp_get_client_data(cros_ish_cl);
 
-- 
1.9.1

