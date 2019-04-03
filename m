Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6ECFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89073217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCOFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:05:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50722 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfDCOFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:05:38 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5F02D282723
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, jflat@chromium.org, kernel@collabora.com,
        lee.jones@linaro.org, bleung@chromium.org, groeck@chromium.org,
        rajatja@google.com, dtor@chromium.org
Subject: [PATCH v2 2/2] mfd: cros_ec: Instantiate the CrOS USB PD logger driver
Date:   Wed,  3 Apr 2019 16:05:29 +0200
Message-Id: <20190403140529.23103-2-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403140529.23103-1-enric.balletbo@collabora.com>
References: <20190403140529.23103-1-enric.balletbo@collabora.com>
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

Changes in v2: None

 drivers/mfd/cros_ec_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
-- 
2.20.1

