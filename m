Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C27C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E775220679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfG3KKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:10:13 -0400
Received: from icp-osb-irony-out1.external.iinet.net.au ([203.59.1.210]:44702
        "EHLO icp-osb-irony-out1.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729648AbfG3KKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:10:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2AIBgDsFkBd/1/rO8tmghmDVSESFxO?=
 =?us-ascii?q?NGogdAYJDAYkskRsJAQEBAQEBAQEBGxwBAYQ6BAICgmQ3Bg4BAwEBAQQBAQE?=
 =?us-ascii?q?BBQFthGVFhUsGJy8zPxJXBxKDIoF3E61XM4QGAYRygUiBNIcJhG6BQD+DdWy?=
 =?us-ascii?q?EAwobhX8ElTqVQwmBJXeUGBmYEYtkgVmZaCKBWE0fGYMngnmNVkQ1MIt0glI?=
 =?us-ascii?q?BAQ?=
X-IPAS-Result: =?us-ascii?q?A2AIBgDsFkBd/1/rO8tmghmDVSESFxONGogdAYJDAYksk?=
 =?us-ascii?q?RsJAQEBAQEBAQEBGxwBAYQ6BAICgmQ3Bg4BAwEBAQQBAQEBBQFthGVFhUsGJ?=
 =?us-ascii?q?y8zPxJXBxKDIoF3E61XM4QGAYRygUiBNIcJhG6BQD+DdWyEAwobhX8ElTqVQ?=
 =?us-ascii?q?wmBJXeUGBmYEYtkgVmZaCKBWE0fGYMngnmNVkQ1MIt0glIBAQ?=
X-IronPort-AV: E=Sophos;i="5.64,326,1559491200"; 
   d="scan'208";a="229598851"
Received: from 203-59-235-95.perm.iinet.net.au (HELO rtcentos7.electromag.com.au) ([203.59.235.95])
  by icp-osb-irony-out1.iinet.net.au with ESMTP; 30 Jul 2019 18:10:07 +0800
From:   Richard Tresidder <rtresidd@electromag.com.au>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        rtresidd@electromag.com.au, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rfontana@redhat.com, allison@lohutok.net, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2 2/2] power/supply/sbs-battery: Add ability to force load a battery via the devicetree
Date:   Tue, 30 Jul 2019 18:10:04 +0800
Message-Id: <1564481404-39505-3-git-send-email-rtresidd@electromag.com.au>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
References: <1564481404-39505-1-git-send-email-rtresidd@electromag.com.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to force load a hot pluggable battery during boot where
there is no gpio detect method available and the module is statically
built. Normal polling will then occur on that battery when it is inserted.

Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
---
 drivers/power/supply/sbs-battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 048d205..b55721d 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -816,6 +816,7 @@ static int sbs_probe(struct i2c_client *client,
 	struct power_supply_config psy_cfg = {};
 	int rc;
 	int irq;
+	bool dt_force_load;
 
 	sbs_desc = devm_kmemdup(&client->dev, &sbs_default_desc,
 			sizeof(*sbs_desc), GFP_KERNEL);
@@ -852,6 +853,9 @@ static int sbs_probe(struct i2c_client *client,
 	if (rc)
 		chip->poll_retry_count = 0;
 
+	dt_force_load = of_property_read_bool(client->dev.of_node,
+						"sbs,force-load");
+
 	if (pdata) {
 		chip->poll_retry_count = pdata->poll_retry_count;
 		chip->i2c_retry_count  = pdata->i2c_retry_count;
@@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
 	 * Before we register, we might need to make sure we can actually talk
 	 * to the battery.
 	 */
-	if (!(force_load || chip->gpio_detect)) {
+	if (!(force_load || chip->gpio_detect || dt_force_load)) {
 		rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
 
 		if (rc < 0) {
-- 
1.8.3.1

