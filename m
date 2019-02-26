Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCC4C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0F220645
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 18:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfCESJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:09:10 -0500
Received: from mail1.bemta25.messagelabs.com ([195.245.230.2]:19702 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbfCESIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 13:08:32 -0500
Received: from [46.226.52.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.symcld.net id 80/2D-18573-B1BBE7C5; Tue, 05 Mar 2019 18:08:27 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsVy8IPnUV3p3XU
  xBlt2qVlMffiEzeLblQ4mi8u75rA5MHvsnHWX3WPTqk42j8+b5AKYo1gz85LyKxJYM1Yf+Mlc
  cEOo4s/lRywNjLP4uxi5OIQE1jFKLGuYwd7FyAnkVEh8n/WSEcTmFUiWWD2lgwXE5hRwlDjYu
  44VosZBovH2XzYQm03AUGLem/dg9SwCqhIbF34HiwsLeEosvj4VrF5EwEOidfsGZhCbWSBW4v
  y8pSwQ8wUlTs58wgIRl5A4+OIFUA0H0HwtieXHIkHCEgL2EtPfXwULSwjoSzQei4UIGwJd+Y0
  FwjaXuL36AesERsFZSIbOQjJ0ASPTKkbzpKLM9IyS3MTMHF1DAwNdQ0MjXUNLY11Tc73EKt1E
  vdRS3fLU4hJdQ73E8mK94src5JwUvbzUkk2MwPBOKThouYPx1PL0Q4ySHExKorx9XXUxQnxJ+
  SmVGYnFGfFFpTmpxYcYZTg4lCR4HXYB5QSLUtNTK9Iyc4CRBpOW4OBREuEV3wmU5i0uSMwtzk
  yHSJ1i1OU4vfDhXGYhlrz8vFQpcd5TIEUCIEUZpXlwI2BRf4lRVkqYl5GBgUGIpyC1KDezBFX
  +FaM4B6OSMC8LyBSezLwSuE2vgI5gAjri8+VqkCNKEhFSUg2MvY8+NqkI7n74OWjlLb7g8hUu
  RQ+OqH2ZqMSgPuWO+rOPCypfXv/ys+XQ+t0hji+KfAxftnE+mHSPzUMxb80Dn88vuET3Mrypf
  Xl51r6agj2sYc5lL24uW6V2wqpQ5qDwzZI7aQXGX4yKHq1+3GVlJMqamnvJjcFfn9/OXfzNZH
  4z9UVFl7VPKLEUZyQaajEXFScCACM38sT1AgAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-20.tower-262.messagelabs.com!1551809306!2441267!6
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30187 invoked from network); 5 Mar 2019 18:08:27 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-20.tower-262.messagelabs.com with AES128-SHA256 encrypted SMTP; 5 Mar 2019 18:08:27 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 5 Mar 2019 18:08:26 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22547)      id
 3322A3FC0F; Tue,  5 Mar 2019 18:08:25 +0000 (GMT)
Message-ID: <ad265849fb7471031eaf0f22729eb1f7ec2c667f.1551808797.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1551808797.git.stwiss.opensource@diasemi.com>
References: <cover.1551808797.git.stwiss.opensource@diasemi.com>
From:   Steve Twiss <stwiss.opensource@diasemi.com>
Date:   Tue, 26 Feb 2019 15:32:18 +0000
Subject: [PATCH 05/13] regulator: lp8755: Fix notifier mutex lock warning
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 05/03/2019 17:23:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mutex for the regulator_dev must be controlled by the caller of
the regulator_notifier_call_chain(), as described in the comment
for that function.

Failure to mutex lock and unlock surrounding the notifier call results
in a kernel WARN_ON_ONCE() which will dump a backtrace for the
regulator_notifier_call_chain() when that function call is first made.
The mutex can be controlled using the regulator_lock/unlock() API.

Fixes: b59320cc5a5e ("regulator: lp8755: new driver for LP8755")
Suggested-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
 drivers/regulator/lp8755.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 244822b..d82d307 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -372,10 +372,13 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
 		if ((flag0 & (0x4 << icnt))
 		    && (pchip->irqmask & (0x04 << icnt))
-		    && (pchip->rdev[icnt] != NULL))
+		    && (pchip->rdev[icnt] != NULL)) {
+			regulator_lock(pchip->rdev[icnt]);
 			regulator_notifier_call_chain(pchip->rdev[icnt],
 						      LP8755_EVENT_PWR_FAULT,
 						      NULL);
+			regulator_unlock(pchip->rdev[icnt]);
+		}
 
 	/* read flag1 register */
 	ret = lp8755_read(pchip, 0x0E, &flag1);
@@ -389,18 +392,24 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	/* send OCP event to all regualtor devices */
 	if ((flag1 & 0x01) && (pchip->irqmask & 0x01))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-			if (pchip->rdev[icnt] != NULL)
+			if (pchip->rdev[icnt] != NULL) {
+				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OCP,
 							      NULL);
+				regulator_unlock(pchip->rdev[icnt]);
+			}
 
 	/* send OVP event to all regualtor devices */
 	if ((flag1 & 0x02) && (pchip->irqmask & 0x02))
 		for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-			if (pchip->rdev[icnt] != NULL)
+			if (pchip->rdev[icnt] != NULL) {
+				regulator_lock(pchip->rdev[icnt]);
 				regulator_notifier_call_chain(pchip->rdev[icnt],
 							      LP8755_EVENT_OVP,
 							      NULL);
+				regulator_unlock(pchip->rdev[icnt]);
+			}
 	return IRQ_HANDLED;
 
 err_i2c:
-- 
1.9.3

