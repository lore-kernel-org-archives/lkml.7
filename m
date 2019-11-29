Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0823C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AA12464C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfK2V71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:59:27 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41896 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfK2V71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:59:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D9ABD28F55E
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, fparent@baylibre.com,
        linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] power: supply: cros_usbpd: Remove dev_err() getting the number of ports
Date:   Fri, 29 Nov 2019 22:59:16 +0100
Message-Id: <20191129215916.17105-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a device has no support to get the charger number of ports, it
doesn't have to result in a dev_err(), print saying "Could not get
charger port count" using a dev_info() would suffice. In such case,
the dev_info() message is already printed but the dev_err() is annoying,
specially, on those devices that doesn't support the command. So remove
the dev_err().

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/power/supply/cros_usbpd-charger.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/cros_usbpd-charger.c b/drivers/power/supply/cros_usbpd-charger.c
index 6cc7c3910e09..ffad9ee03a68 100644
--- a/drivers/power/supply/cros_usbpd-charger.c
+++ b/drivers/power/supply/cros_usbpd-charger.c
@@ -132,11 +132,8 @@ static int cros_usbpd_charger_get_num_ports(struct charger_data *charger)
 	ret = cros_usbpd_charger_ec_command(charger, 0,
 					    EC_CMD_CHARGE_PORT_COUNT,
 					    NULL, 0, &resp, sizeof(resp));
-	if (ret < 0) {
-		dev_err(charger->dev,
-			"Unable to get the number of ports (err:0x%x)\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	return resp.port_count;
 }
@@ -148,11 +145,8 @@ static int cros_usbpd_charger_get_usbpd_num_ports(struct charger_data *charger)
 
 	ret = cros_usbpd_charger_ec_command(charger, 0, EC_CMD_USB_PD_PORTS,
 					    NULL, 0, &resp, sizeof(resp));
-	if (ret < 0) {
-		dev_err(charger->dev,
-			"Unable to get the number or ports (err:0x%x)\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	return resp.num_ports;
 }
-- 
2.20.1

