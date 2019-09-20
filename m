Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449E3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7AD20882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408125AbfITF1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:27:16 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39734 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408098AbfITF1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:27:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 7BB05FB02;
        Fri, 20 Sep 2019 07:27:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PWaZCynLm9U3; Fri, 20 Sep 2019 07:27:12 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id CBF9E48768; Thu, 19 Sep 2019 22:27:07 -0700 (PDT)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] leds: lm3692x: Don't overwrite return value in error path
Date:   Thu, 19 Sep 2019 22:27:04 -0700
Message-Id: <e3ee36845c1555bd722807f85329341d5ec9728e.1568957104.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <cover.1568957104.git.agx@sigxcpu.org>
References: <cover.1568957104.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver currently reports successful initialization on every failure
as long as it's able to power off the regulator. Don't check the return
value of regulator_disable to avoid that.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 drivers/leds/leds-lm3692x.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 487228c2bed2..31115655f97b 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -198,7 +198,7 @@ static int lm3692x_brightness_set(struct led_classdev *led_cdev,
 static int lm3692x_init(struct lm3692x_led *led)
 {
 	int enable_state;
-	int ret;
+	int ret, ret2;
 
 	if (led->regulator) {
 		ret = regulator_enable(led->regulator);
@@ -313,14 +313,15 @@ static int lm3692x_init(struct lm3692x_led *led)
 		gpiod_direction_output(led->enable_gpio, 0);
 
 	if (led->regulator) {
-		ret = regulator_disable(led->regulator);
-		if (ret)
+		ret2 = regulator_disable(led->regulator);
+		if (ret2)
 			dev_err(&led->client->dev,
 				"Failed to disable regulator\n");
 	}
 
 	return ret;
 }
+
 static int lm3692x_probe_dt(struct lm3692x_led *led)
 {
 	struct fwnode_handle *child = NULL;
-- 
2.23.0.rc1

