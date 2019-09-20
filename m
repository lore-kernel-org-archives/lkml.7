Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E41C4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC70F2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 05:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408088AbfITF1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 01:27:14 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:39708 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392287AbfITF1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 01:27:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 28ED8FB02;
        Fri, 20 Sep 2019 07:27:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7LGiFDFAHeGf; Fri, 20 Sep 2019 07:27:11 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id D8DC348847; Thu, 19 Sep 2019 22:27:07 -0700 (PDT)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] leds: lm3692x: Handle failure to probe the regulator
Date:   Thu, 19 Sep 2019 22:27:05 -0700
Message-Id: <6f980a7d8acec4d33bcc78a11f5ce4ee392e7c05.1568957104.git.agx@sigxcpu.org>
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

Instead use devm_regulator_get_optional since the regulator
is optional and check for errors.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 drivers/leds/leds-lm3692x.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3692x.c b/drivers/leds/leds-lm3692x.c
index 31115655f97b..6f6a17ec7c9f 100644
--- a/drivers/leds/leds-lm3692x.c
+++ b/drivers/leds/leds-lm3692x.c
@@ -337,9 +337,18 @@ static int lm3692x_probe_dt(struct lm3692x_led *led)
 		return ret;
 	}
 
-	led->regulator = devm_regulator_get(&led->client->dev, "vled");
-	if (IS_ERR(led->regulator))
+	led->regulator = devm_regulator_get_optional(&led->client->dev, "vled");
+	if (IS_ERR(led->regulator)) {
+		ret = PTR_ERR(led->regulator);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(&led->client->dev,
+					"Failed to get vled regulator: %d\n",
+					ret);
+			return ret;
+		}
 		led->regulator = NULL;
+	}
 
 	child = device_get_next_child_node(&led->client->dev, child);
 	if (!child) {
-- 
2.23.0.rc1

