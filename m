Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC71BC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81DB218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 14:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yv+8xg8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfIRO5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 10:57:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35610 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731473AbfIRO5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 10:57:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8IEvgaf084990;
        Wed, 18 Sep 2019 09:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568818662;
        bh=zHZNeDL779jJyDu708ggzOFMfXOscN51xWhlBD7mkHE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Yv+8xg8b9T6T7OXzED6lcXrePQaHfDux9/FxyqZM4bbOma4NLiGBMF37UUfWVDUrV
         U2qpwFFM+IjTtw173jtmxjiH8XlgKyFmG/kg2ezkvCoxmD666XQXFL4JXa3zkVygpL
         ydKFgb6TCJ7ipVlU/ytCS3MZ8zZYGp84ny19SX+o=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8IEvgWL003176
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Sep 2019 09:57:42 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 18
 Sep 2019 09:57:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 18 Sep 2019 09:57:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8IEvf5m091969;
        Wed, 18 Sep 2019 09:57:41 -0500
From:   Jean-Jacques Hiblot <jjhiblot@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lee.jones@linaro.org>,
        <daniel.thompson@linaro.org>
CC:     <dmurphy@ti.com>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <tomi.valkeinen@ti.com>, <jjhiblot@ti.com>
Subject: [PATCH v7 1/5] leds: populate the device's of_node when possible
Date:   Wed, 18 Sep 2019 16:57:26 +0200
Message-ID: <20190918145730.22805-2-jjhiblot@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190918145730.22805-1-jjhiblot@ti.com>
References: <20190918145730.22805-1-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If initialization data is available and its fwnode is actually a of_node,
store this information in the led device's structure. This will allow the
device to use or provide OF-based API such (devm_xxx).

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
---
 drivers/leds/led-class.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 647b1263c579..c2167b66b61f 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -276,8 +276,11 @@ int led_classdev_register_ext(struct device *parent,
 		mutex_unlock(&led_cdev->led_access);
 		return PTR_ERR(led_cdev->dev);
 	}
-	if (init_data && init_data->fwnode)
+	if (init_data && init_data->fwnode) {
 		led_cdev->dev->fwnode = init_data->fwnode;
+		if (is_of_node(init_data->fwnode))
+			led_cdev->dev->of_node = to_of_node(init_data->fwnode);
+	}
 
 	if (ret)
 		dev_warn(parent, "Led %s renamed to %s due to name collision",
-- 
2.17.1

