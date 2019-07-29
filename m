Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E97C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC98220578
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfG2Ojf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:39:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:54007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfG2Ojf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:39:35 -0400
Received: from orion.localdomain ([77.4.29.213]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M1YtP-1hp5sB08vT-0037Xk; Mon, 29 Jul 2019 16:39:28 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     info@metux.net, dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform: x86: pcengines-apu2: wire up simswitch gpio as led
Date:   Mon, 29 Jul 2019 16:39:26 +0200
Message-Id: <1564411166-23693-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:ltH4E6R4g0MxzsYo+40DFZlGZaVFzz+3zZNAt208kreFs5oy0FK
 AJjK8OeYKHEomYfHh44Xg8P556HSBdZXlghN2ZgKMsbS0GuvoDD4JYWUkqtnoDKgZrGdDrI
 lu6Bub97UEYu0DT9FmY7qBZdI99gn7nHQCLieoDw7ndWdGw8MQWRKNXxjM0AVzCaYn/ZOWk
 dV0Cr1YlHvoP0MEVfHGZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6drEupQFt28=:F1fb72R9MNDngMBysdYa3W
 cDk718OJ0qyn02ZMnWUnhANgFu0pZOkbpfwH17U2XlR79UI+E9ayvLKIn9PZPrc6GA4BinS8o
 vtXaui5h52kbU2ISmExV5l3jZ7lAjJCW84Qw823dL9r8bnN5sMkNpilI9Uqrj9W/goZ3Gdc1q
 eyo6+xZTMg8vCBPcrn8VMpIZiCct38RsaSFpCSVV97RKSosr300Xs0z0oD5lY6SikP6ThdRsx
 mfF4MfVpKWCA8yrsP9H3dOGAPXoNsqPdkFEQ0apbF81hMyNU00YPlrIvkgqG0ipuS0ZIlL93x
 G7SJ/1tQ214psaOSwh+bORdu9emSyHGVlzbudCas60rOvEqRmQGtBMih8ZC2Y+jHVaK5Alpng
 US9AdIIMSBYeu1Nt84M/AgNjGYPu9n6suVJjbMIZHQXWCTJUvGWObXP1UcVK1rjZko0+YNegk
 ADV6jOs1nR2a95sFDWs9foQ142A5lQeicUQ5SIEsDPcM05DeiFYVSZPeHvDKIfoM+K53YHCNr
 wL24noL1DyBMw0wfQXQybKbde45Pui/l6a8+w3Y5MKmFN47l7b1pCav0boO+OWVEdR9RVL3CL
 a9KpOJWKQss8AqR6opKVNXrmVZX3y0TVGzgsKznNFh1WKFb8cjmM0SAc6cF6MThBtJ+L+nxlp
 0+n2boCO2OAkpbYr0Vc3ErArPgSpIELzd64VvKx+Yx09wIoJaKsWi0Ir7m28LBKbmV+HR0IYh
 eCKOkdb9+59JNvVUcKch8y5KVCuO9ndBhKfs/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

The APU3+ boards have two SIM sockets, while only one of them
can be routed to the mpcie slots at a time. Selection is done
via simswap gpio.

We currently don't have a fitting subsystem for those cases yet,
so just wire it up to a LED for the time being. While this isn't
really semantically correct, it's a good compromise.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/platform/x86/pcengines-apuv2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index b0d3110..adecd6a 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -69,7 +69,8 @@
 static const struct gpio_led apu2_leds[] = {
 	{ .name = "apu:green:1" },
 	{ .name = "apu:green:2" },
-	{ .name = "apu:green:3" }
+	{ .name = "apu:green:3" },
+	{ .name = "apu:simswap" },
 };
 
 static const struct gpio_led_platform_data apu2_leds_pdata = {
@@ -86,6 +87,8 @@
 				NULL, 1, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
 				NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_REG_SIMSWAP,
+				NULL, 3, GPIO_ACTIVE_LOW),
 	}
 };
 
-- 
1.9.1

