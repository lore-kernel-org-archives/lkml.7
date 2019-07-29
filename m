Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3692AC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DF12073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="FgWlPQe2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbfG2Sbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:31:39 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50178 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbfG2Sbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1564425094; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FcAGdPJjm/WMTlzjt6hmmuMxvU5mwY58SKXONjZ0mHo=;
        b=FgWlPQe2UhH3kzpVoP39R0lIiiXxDQLO7Mu0sanwZem3Jyi2hsP/NtJpW5zBhPTGO/hyi/
        0pSrMs788GN97pAoF62fYW0v8dCRpOzUZ1dwB1QX8JNWcwbYTTpY9+484U8I2P8XHF5JVz
        ga3JpE/PFpsn9Dcjl6VUTRPcm5NIYPY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Paul Burton <paul.burton@mips.com>, od@zcrc.me,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 2/3] remoteproc: Add prepare/unprepare callbacks
Date:   Mon, 29 Jul 2019 14:31:08 -0400
Message-Id: <20190729183109.18283-2-paul@crapouillou.net>
In-Reply-To: <20190729183109.18283-1-paul@crapouillou.net>
References: <20190729183109.18283-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .prepare() callback is called before the firmware is loaded to
memory. This is useful for instance in the case where some setup is
required for the memory to be accessible.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: No change

 drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
 include/linux/remoteproc.h           |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 3c5fbbbfb0f1..68faad3ef0c1 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1300,11 +1300,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	struct device *dev = &rproc->dev;
 	int ret;
 
+	if (rproc->ops->prepare) {
+		ret = rproc->ops->prepare(rproc);
+		if (ret) {
+			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* load the ELF segments to memory */
 	ret = rproc_load_segments(rproc, fw);
 	if (ret) {
 		dev_err(dev, "Failed to load program segments: %d\n", ret);
-		return ret;
+		goto unprepare_rproc;
 	}
 
 	/*
@@ -1355,6 +1363,9 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	rproc_unprepare_subdevices(rproc);
 reset_table_ptr:
 	rproc->table_ptr = rproc->cached_table;
+unprepare_rproc:
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
 
 	return ret;
 }
@@ -1484,6 +1495,9 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
 
 	rproc->state = RPROC_OFFLINE;
 
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
+
 	dev_info(dev, "stopped remote processor %s\n", rproc->name);
 
 	return 0;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..be65c2a92c58 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -355,6 +355,8 @@ enum rsc_handling_status {
 
 /**
  * struct rproc_ops - platform-specific device handlers
+ * @prepare:	prepare the device for power up (before the firmware is loaded)
+ * @unprepare:	unprepare the device after it is stopped
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
@@ -371,6 +373,8 @@ enum rsc_handling_status {
  * @get_boot_addr:	get boot address to entry point specified in firmware
  */
 struct rproc_ops {
+	int (*prepare)(struct rproc *rproc);
+	void (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-- 
2.21.0.593.g511ec345e18

