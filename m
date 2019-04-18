Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE4C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9A420663
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aw4PbPE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbfDRT63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34177 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRT61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so1679653pgq.1;
        Thu, 18 Apr 2019 12:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P2kSmkr0gjxDrzltwWGdPiHLXWPJpXIu1nScfCyroiQ=;
        b=aw4PbPE2LbcT7H4oTgNGIFAcjm+SZXbSWJcBJtNUrPH25VznEczbSeJ40NXsVwaMtx
         h6y3WWQzakymz1v9uoaJ+dbywvlrNiry1RccU8/skfi5CL4Vz3CaOoWOE7pyFskOJGme
         VOf9/JgETdp70sq0dVR6mv7ot3zZY+pKRTRtUFmhdr788n34/Y4G8wJOUVbmdktSV6iW
         TYcmy2Ow0VuVtGlgxYZirN62xuRxV2sICTJkCbsH+jBd8LPZCHBhL3IHbvEQpMmyqzxD
         oc3O2D6vdravLNIs9ZNnsLCcF+nTexby1/A5gq3A98N7xUJc7jnTPlE0yLXXNBBiK0l9
         HYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=P2kSmkr0gjxDrzltwWGdPiHLXWPJpXIu1nScfCyroiQ=;
        b=gLxdNcmpQcGaGb3+JdmoWT708cOJ9unGDHt4W86kZPZUtT7yoPnNouePSa/BVVG3Ex
         fxi0+ScsIbyJZF7ChFlNuYlfowSSWqbAyXw9dycyf3ysMbszm3CaV4ghbVCiued6qqqR
         l0XNXrdoMv3mrRmDYrbMwB3/vZx8jOUFfZFFLNgNiaREEElU9BFBHGKH1Xsw3nZsc8N6
         gRYi+MU7tTYeRG/JrlvpEQsyuWWc0yZJnHs9Zg4zjUAWLe2R3lieOa+7xa3VcFGGwfO7
         mZqCW76KvxtCzeSrRkl6BxEnG0844qQBaFPzSQybMpWZKMx9q+x/Oj19HXfpHTPP7JMI
         AkTg==
X-Gm-Message-State: APjAAAV/xufX65STsQzX+ZFVr5FrFiGdoh7MZK28uDXteHWT5KdsCyHU
        vAVHBc+TBCrNdGO2SAPMKoc4KWGQyfw=
X-Google-Smtp-Source: APXvYqxpLyKpYoSfcl1WD6JN0XXUOmrDmvDwdlk09zltzORJYfgVRH8R3VUDuCoLqBR4k7NGttb+Fw==
X-Received: by 2002:a63:c61:: with SMTP id 33mr84153243pgm.293.1555617506752;
        Thu, 18 Apr 2019 12:58:26 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h10sm4335474pfj.79.2019.04.18.12.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:26 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mykola Kostenok <c_mykolak@mellanox.com>
Subject: [PATCH 2/6] hwmon: (aspeed-pwm-tacho) Use devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:16 -0700
Message-Id: <1555617500-10862-3-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_thermal_of_cooling_device_register() to register the cooling
device. As a side effect, this fixes a driver bug:
thermal_cooling_device_unregister() was not called on removal.

Fixes: f198907d2ff6d ("hwmon: (aspeed-pwm-tacho) cooling device support.")
Cc: Mykola Kostenok <c_mykolak@mellanox.com>
Cc: Joel Stanley <joel@jms.id.au>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index c4dd6301e7c8..0daf0b32aa4a 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -830,10 +830,8 @@ static int aspeed_create_pwm_cooling(struct device *dev,
 	}
 	snprintf(cdev->name, MAX_CDEV_NAME_LEN, "%pOFn%d", child, pwm_port);
 
-	cdev->tcdev = thermal_of_cooling_device_register(child,
-							 cdev->name,
-							 cdev,
-							 &aspeed_pwm_cool_ops);
+	cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
+					cdev->name, cdev, &aspeed_pwm_cool_ops);
 	if (IS_ERR(cdev->tcdev))
 		return PTR_ERR(cdev->tcdev);
 
-- 
2.7.4

