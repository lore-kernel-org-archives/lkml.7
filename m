Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C64C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38823214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWr34zd2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfDRT61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39470 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRT60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id l18so1530549pgj.6;
        Thu, 18 Apr 2019 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6m+z7g3EFd1rannjYRxmeahgviDOKxTIyUAGSrZVUCA=;
        b=DWr34zd2tlqExXIm3WBesOBARj1noCVmsnJd9sB4CDKcOPTFqM+mKUpAYwtPhEeyUK
         eQUwJfUy6GuchtcHO/xBbVV+QtX03Cdg9bDdoNcpb0HnpEYol8CZhZ1D3wEGET1PfCFg
         xlYKBLXb9+v09AVZDTsYtz+AXXhBLyqmrgpNhnRSHP6FLuFtd5p0gW20z0Vy3V1BAxP9
         k00xbnz9WEh1o4/bfg4R9jy5rrF4jFdQ8AdTVd12tXqWcnmATpI4JpftmM4VQOW1wE3s
         ffyZUxqJ+bvzxQNW3bCO0AKsusxKbzJVtMelj0BxD7Lk8GzHQLnjkl2ERGCWeS5clFGF
         Ct/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=6m+z7g3EFd1rannjYRxmeahgviDOKxTIyUAGSrZVUCA=;
        b=cSN1N9st3vxW2qnkiO75P9Zc4BwmY5lUIeMsp+Cd4coUN1PtX0JmzGcQdA4AYA6+Yg
         nD4wZPUd7MjUbBm1Pr+TDd9Vn7XYy7+DoNCaLrl0ijYdKcJi9raBfeBzIe3VrZAw2eqv
         l3MmZRuMDUC4oG8Gcgh1Dzzs3x2vz62KcwCpK9opkXBqzfrmIMZsPHYsg01QrP8bOpTV
         y+QaItCYL/w+eekQEIoJssqsp1wCdgxfUNYqQCYvUaAuW9X9A0yxQcCBJMlJhQmi4yLC
         +oDqou0B680mTZwuZapsHZ8qC2lK+c2PjndYf4X7BpHv4Vy5ZVJ2+M//KHYkoqQRU/Jt
         xj+g==
X-Gm-Message-State: APjAAAXYVP1yfHg/c/jj8Re2mvZ8Ic2GjVQ/Te9YTJ4b9DOwp9zqUIVP
        kxdOXmjgVBMUVACoBMUqBmyCX9NSpxA=
X-Google-Smtp-Source: APXvYqwRbJbOKlDFm46pI/cvEGKc9r+XfEiAOCA821wqhwOJr0hWPsAe8hjISyMmbuCrtzlsKv2aGg==
X-Received: by 2002:a63:f444:: with SMTP id p4mr92599928pgk.32.1555617505235;
        Thu, 18 Apr 2019 12:58:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c17sm3830791pfd.76.2019.04.18.12.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:24 -0700 (PDT)
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/6] thermal: Introduce devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:15 -0700
Message-Id: <1555617500-10862-2-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thermal_of_cooling_device_register() and thermal_cooling_device_register()
are typically called from driver probe functions, and
thermal_cooling_device_unregister() is called from remove functions. This
makes both a perfect candidate for device managed functions.

Introduce devm_thermal_of_cooling_device_register(). This function can
also be used to replace thermal_cooling_device_register() by passing a NULL
pointer as device node. The new function requires both struct device *
and struct device_node * as parameters since the struct device_node *
parameter is not always identical to dev->of_node.

Don't introduce a device managed remove function since it is not needed
at this point.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/thermal/thermal_core.c | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/thermal.h        |  5 +++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6590bb5cb688..e0b530603db6 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1046,6 +1046,55 @@ thermal_of_cooling_device_register(struct device_node *np,
 }
 EXPORT_SYMBOL_GPL(thermal_of_cooling_device_register);
 
+static void thermal_cooling_device_release(struct device *dev, void *res)
+{
+	thermal_cooling_device_unregister(
+				*(struct thermal_cooling_device **)res);
+}
+
+/**
+ * devm_thermal_of_cooling_device_register() - register an OF thermal cooling
+ *					       device
+ * @dev:	a valid struct device pointer of a sensor device.
+ * @np:		a pointer to a device tree node.
+ * @type:	the thermal cooling device type.
+ * @devdata:	device private data.
+ * @ops:	standard thermal cooling devices callbacks.
+ *
+ * This function will register a cooling device with device tree node reference.
+ * This interface function adds a new thermal cooling device (fan/processor/...)
+ * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bind itself
+ * to all the thermal zone devices registered at the same time.
+ *
+ * Return: a pointer to the created struct thermal_cooling_device or an
+ * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
+ */
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+				struct device_node *np,
+				char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops)
+{
+	struct thermal_cooling_device **ptr, *tcd;
+
+	ptr = devres_alloc(thermal_cooling_device_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	tcd = __thermal_cooling_device_register(np, type, devdata, ops);
+	if (IS_ERR(tcd)) {
+		devres_free(ptr);
+		return tcd;
+	}
+
+	*ptr = tcd;
+	devres_add(dev, ptr);
+
+	return tcd;
+}
+EXPORT_SYMBOL_GPL(devm_thermal_of_cooling_device_register);
+
 static void __unbind(struct thermal_zone_device *tz, int mask,
 		     struct thermal_cooling_device *cdev)
 {
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 5f4705f46c2f..43cf4fdd71d4 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -447,6 +447,11 @@ struct thermal_cooling_device *thermal_cooling_device_register(char *, void *,
 struct thermal_cooling_device *
 thermal_of_cooling_device_register(struct device_node *np, char *, void *,
 				   const struct thermal_cooling_device_ops *);
+struct thermal_cooling_device *
+devm_thermal_of_cooling_device_register(struct device *dev,
+				struct device_node *np,
+				char *type, void *devdata,
+				const struct thermal_cooling_device_ops *ops);
 void thermal_cooling_device_unregister(struct thermal_cooling_device *);
 struct thermal_zone_device *thermal_zone_get_zone_by_name(const char *name);
 int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp);
-- 
2.7.4

