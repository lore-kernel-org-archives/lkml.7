Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9F3C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A8820651
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCNr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:47:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49976 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:47:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7CE1328264F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, gwendal@chromium.org,
        kernel@collabora.com, dtor@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_debugfs: Remove dev_warn when console log is not supported
Date:   Wed,  3 Apr 2019 15:47:18 +0200
Message-Id: <20190403134718.6874-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the debugfs interface is enabled, every time a CrOS device is
instantiated a warning like this can appear for every probed device.

 "device does not support reading the console log"

The warning message adds nothing, rather it is source of confusion as
this is expected on some cases. For example, on Samus, that has a
cros-ec and a cros-pd instance the message appears twice, and I suspect
this will happen also on those devices that has a non-standard EC.

If the command is not supported just return silently and don't print the
warning, otherwise the code will already print an error.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_debugfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 71308766e891..f0de1991b688 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -306,11 +306,12 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 	int read_params_size;
 	int read_response_size;
 
-	if (!ec_read_version_supported(ec)) {
-		dev_warn(ec->dev,
-			"device does not support reading the console log\n");
+	/*
+	 * If the console log feature is not supported return silently and
+	 * don't create the console_log entry.
+	 */
+	if (!ec_read_version_supported(ec))
 		return 0;
-	}
 
 	buf = devm_kzalloc(ec->dev, LOG_SIZE, GFP_KERNEL);
 	if (!buf)
-- 
2.20.1

