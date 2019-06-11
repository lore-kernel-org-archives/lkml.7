Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F698C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQg8KvQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbfFKKlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:41:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39175 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfFKKlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:41:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so2336064wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyhckBm8THgO1AcZvtqNCZU3xMQ1j3cGrqaXKQ6WbdI=;
        b=OQg8KvQSnrphvOofdMTtzsvKGujUIWuYj1y2jJhYsUUJnfc5YvjQgj63rr2m+LiIt0
         3imTNZNG8Lci6WAr050UBiTC4xMuRbvBbLj+OzRZF+ZVxes6Rnd6qJSqEi47ylZsZNTz
         1bnnmMNh2VzawyKTFMnAQlX0NUbhTQvCyHYk+rrbOLjynzdhyjYgGudPPu2b5peh6e/W
         WIsWRIui9pT1KXuRPLflunZh5bFKClaFLv7JiUcjVXlhis1ALkbflrNmW51Y/e651F1L
         xhPAnH8+HBGsLGLVOsysHnb4om4QXPLAeLhS+oCmug5bI2VDO5u19U0uMJotsJxch5ak
         Ej/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyhckBm8THgO1AcZvtqNCZU3xMQ1j3cGrqaXKQ6WbdI=;
        b=G9L8GREwrbl/1chjdwZS1DJgT3lOZYT2eEPqzzYURae+STUMCmk5CB+fFKuFtqTITl
         pidL/WZtkH58A6vyGQ58MOwCV8ITFp8hS0EY5dW4rXP4NI6o1OdSAMc20+3Xp82L4C7B
         C7T6ALoVbIA1rXAMlkNvdI/fCBeNYiAEmqctNYcgvv/NKb0ANfPZTtf6KG1rwgYGf1R/
         YaNbze1dtDS5afyF/wVExYPPrj3orjqeG3DKojdABXEkXoSyX769D4eKrerNshEacRUG
         kutX0RiYro3Eg+w6upvsUJwzf0s9ODmwkbM5AOy6Bs7D4SF8DMdnQAzpfxiOyfM1pzPP
         BE+A==
X-Gm-Message-State: APjAAAXo1pYhiplSeK0bSODubfHutnsyI4xyw9hjwv/zDwJ8loN1pxl1
        14vTnKaL5aFunImCOpohjL2PLw==
X-Google-Smtp-Source: APXvYqw7U0OrxR281JBKNtGwW3T/tVCMLH0nKEqT8RKrvVAJtAC3Jt3/37FtCPWSnQMDlSVb6GPB5Q==
X-Received: by 2002:a1c:6242:: with SMTP id w63mr18506760wmb.161.1560249661813;
        Tue, 11 Jun 2019 03:41:01 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c65sm2359614wma.44.2019.06.11.03.41.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 03:41:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, pierre-louis.bossart@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        bgoswami@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH 3/5] soundwire: add module_sdw_driver helper macro
Date:   Tue, 11 Jun 2019 11:40:41 +0100
Message-Id: <20190611104043.22181-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
References: <20190611104043.22181-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Helper macro is for SoundWire drivers which do not do anything special in
module init/exit. This eliminates a lot of boilerplate. Each module may only
use this macro once, and calling it replaces module_init() and module_exit()

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/soundwire/sdw_type.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index 9c756b5a0dfe..aaa7f4267c14 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -16,4 +16,15 @@ void sdw_unregister_driver(struct sdw_driver *drv);
 
 int sdw_slave_modalias(const struct sdw_slave *slave, char *buf, size_t size);
 
+/**
+ * module_sdw_driver() - Helper macro for registering a Soundwire driver
+ * @__sdw_driver: soundwire slave driver struct
+ *
+ * Helper macro for Soundwire drivers which do not do anything special in
+ * module init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_sdw_driver(__sdw_driver) \
+	module_driver(__sdw_driver, sdw_register_driver, \
+			sdw_unregister_driver)
 #endif /* __SOUNDWIRE_TYPES_H */
-- 
2.21.0

