Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1599C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56B6206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfDCNyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:54:13 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50510 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCNyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:54:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 859B828270B
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, jflat@chromium.org, kernel@collabora.com,
        lee.jones@linaro.org, bleung@chromium.org, groeck@chromium.org,
        rajatja@google.com, dtor@chromium.org
Subject: [PATCH 2/2] mfd: cros_ec: Instantiate the CrOS USB PD logger driver
Date:   Wed,  3 Apr 2019 15:54:03 +0200
Message-Id: <20190403135403.9472-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403135403.9472-1-enric.balletbo@collabora.com>
References: <20190403135403.9472-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cros-usbpd-logger driver for logging event data for the USB PD
charger available in the Embedded Controller on ChromeOS systems. The
logging feature is logically separate functionality from charge manager,
hence is instantiated as a different driver.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
Lee, this is send as separate patch because touches the MFD subsystem,
apart from that the driver won't be instantiated if [1/2] is not
merged, which I think is not a problem, it is safe for both go through
their subsystem separately.

Thanks,
 Enric

 drivers/mfd/cros_ec_dev.c                   | 3 ++-
 drivers/platform/chrome/cros_usbpd_logger.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 0638a0d82d97..3e33fa5b8657 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -612,7 +612,8 @@ static const struct mfd_cell cros_ec_rtc_cells[] = {
 };
 
 static const struct mfd_cell cros_usbpd_charger_cells[] = {
-	{ .name = "cros-usbpd-charger" }
+	{ .name = "cros-usbpd-charger" },
+	{ .name = "cros-usbpd-logger" },
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
diff --git a/drivers/platform/chrome/cros_usbpd_logger.c b/drivers/platform/chrome/cros_usbpd_logger.c
index 2091ad7c2afa..eb27078aae47 100644
--- a/drivers/platform/chrome/cros_usbpd_logger.c
+++ b/drivers/platform/chrome/cros_usbpd_logger.c
@@ -136,10 +136,10 @@ static void cros_usbpd_print_log_entry(struct ec_response_pd_log *r,
 		break;
 	case PD_EVENT_VIDEO_CODEC:
 		minfo = (struct mcdp_info *)r->payload;
-		len += append_str(buf, len, "HDMI info: family:%04x chipid:%04x"
+		len += append_str(buf, len, "HDMI info: family:%04x chipid:%04x ",
 				  MCDP_FAMILY(minfo->family),
 				  MCDP_CHIPID(minfo->chipid));
-		len += append_str(buf, len, " irom:%d.%d.%d fw:%d.%d.%d",
+		len += append_str(buf, len, "irom:%d.%d.%d fw:%d.%d.%d",
 				  minfo->irom.major, minfo->irom.minor,
 				  minfo->irom.build, minfo->fw.major,
 				  minfo->fw.minor, minfo->fw.build);
-- 
2.20.1

