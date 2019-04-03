Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2690C10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8612084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfDCNvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:51:32 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50492 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:51:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DC29A28264F
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@chromium.org, gwendal@chromium.org,
        kernel@collabora.com, dtor@chromium.org
Subject: [PATCH] platform/chrome: cros_ec_proto: Also return invalid command in cros_ec_cmd_xfer_status
Date:   Wed,  3 Apr 2019 15:51:23 +0200
Message-Id: <20190403135123.8723-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 9798ac6d32c1 ("mfd: cros_ec: Add cros_ec_cmd_xfer_status()
helper") was introduced to remove duplicated code in several users of
the cros_ec_cmd_xfer function. The idea behind that commit is mask all
the EC errors as protocol error when the EC command fails, what is
really useful because as a user you probably don't care of the exact
error reported by the EC, you only want to know if the command succeeded
or not.

That works for most of the errors returned by the EC, but we might be
also interested on report the EC_RES_INVALID_COMMAND, which happens when
the command is not supported by the EC. An use case for this is when you
need to show/hide a sysfs attribute for a specific command and you don't
have a EC feature flag that tells you that the command is supported or
not.

While here, also document properly the cros_ec_cmd_xfer_status
function.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_proto.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 97a068dff192..a4e0d3a6d891 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -478,6 +478,16 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
+/**
+ * cros_ec_cmd_xfer_status() - Send EC command.
+ * @ec_dev: EC device.
+ * @msg: EC message data for request and response.
+ *
+ * Return:
+ * 0 - OK
+ * -EINVAL - Invalid command.
+ * -EPROTO - Protocol error.
+ */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
 {
@@ -486,6 +496,11 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
+	} else if (msg->result == EC_RES_INVALID_COMMAND) {
+		dev_dbg(ec_dev->dev,
+			"Command %d not supported for this device\n",
+			msg->command);
+		return -EINVAL;
 	} else if (msg->result != EC_RES_SUCCESS) {
 		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
 		return -EPROTO;
-- 
2.20.1

