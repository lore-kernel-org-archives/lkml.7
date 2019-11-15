Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA85C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9481206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 00:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L95sZqvQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKOAEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 19:04:43 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:55181 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfKOAEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 19:04:43 -0500
Received: by mail-qv1-f74.google.com with SMTP id i32so5337548qvi.21
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 16:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AtYBVIFW/7jGl+9KqWhHNwm4HA65HS53beIwYaK2A58=;
        b=L95sZqvQsAHolj7BPNH68M1I3S9AB8Jf1zCyTuU2wTo1Wz5oNIokeJdWYWnLqwGww6
         s0iACpu3AzRR3C2eBHamXb8BUR/dibfXszwvNsAdBIUrkC+VlF/5f5zUiJjEpd7mQu1i
         95eT7Gu5tTBtEZA+XNl0COULfmxqQ5LY6Ri5S0J1wvtkbxBD8a0YvyCuXJhLKLPv5vK2
         mecTEeH1//VrKeDvsRPk5z7Jfes3clJX6JAyUdzz7OkYAdq49yX/WxDwVLaCi40N6fWD
         0odpUhptplN5Cr+mrSJoIkdVYz2FX+Mw9gDVTGIjiYNXZ74kpnc0PBB8BvsNGr2qkpfm
         W1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AtYBVIFW/7jGl+9KqWhHNwm4HA65HS53beIwYaK2A58=;
        b=dzjIRv1yS/N7k644sICizm89bHJRD6rwmIac1anFT1vADmvBfT9i6bTHA7AUyzIjYY
         TJL40LCkCgq2IvyytmX5V4uTY+x7PyK62/GPjD0+qtQCOYmjuZEQFk9h4kENcUwXeye8
         Zk52/g0gmpZK19B/+hHWNuCtiOo2fJ433ZP3XQj5aYnKZdJNSlBmE7Dr3sZLZYmHWB/R
         zCACNXy73Qd7zGE7dZC5ywQXFo8kSj0S4vOXNdhA3RyIcQ1Jbje5RVzpfHtBQV1MtPUF
         vJY2dpx2COCKOmAgzg/fPs7u7S4TMFquWCfEiHgc9XTyWBR3i0czUYLqJ7nR9Uu1WjVp
         9dHw==
X-Gm-Message-State: APjAAAU0GlP7FsXLWFSWwFiPsPdSzx+RzoZj8EJw7GBGTOxwmLJBXjpY
        /lgm3PdRF7+iuQB+ox7gTFhxQhIhUsKIa+k=
X-Google-Smtp-Source: APXvYqzj8PR66IdH+ZesFoCutqqn1xQ7OBDyOhPAfV1oOrDv9zJtimekZMdWd+XVYcx8Qy5LDxWe8Zy5EIQIH/g=
X-Received: by 2002:a0c:c125:: with SMTP id f34mr10599764qvh.22.1573776282301;
 Thu, 14 Nov 2019 16:04:42 -0800 (PST)
Date:   Thu, 14 Nov 2019 16:04:38 -0800
Message-Id: <20191115000438.45970-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v1] regulator: core: Don't try to remove device links if add failed
From:   Saravana Kannan <saravanak@google.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

device_link_add() might not always succeed depending on the type of
device link and the rest of the dependencies in the system. If
device_link_add() didn't succeed, then we shouldn't try to remove the
link later on as it might remove a link someone else created.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/regulator/core.c     | 8 ++++++--
 drivers/regulator/internal.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index a46be221dbdc..6fa790c58db1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1844,6 +1844,7 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 	struct regulator_dev *rdev;
 	struct regulator *regulator;
 	const char *devname = dev ? dev_name(dev) : "deviceless";
+	struct device_link *link;
 	int ret;
 
 	if (get_type >= MAX_GET_TYPE) {
@@ -1951,7 +1952,9 @@ struct regulator *_regulator_get(struct device *dev, const char *id,
 			rdev->use_count = 0;
 	}
 
-	device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+	link = device_link_add(dev, &rdev->dev, DL_FLAG_STATELESS);
+	if (!IS_ERR_OR_NULL(link))
+		regulator->device_link = true;
 
 	return regulator;
 }
@@ -2046,7 +2049,8 @@ static void _regulator_put(struct regulator *regulator)
 	debugfs_remove_recursive(regulator->debugfs);
 
 	if (regulator->dev) {
-		device_link_remove(regulator->dev, &rdev->dev);
+		if (regulator->device_link)
+			device_link_remove(regulator->dev, &rdev->dev);
 
 		/* remove any sysfs entries */
 		sysfs_remove_link(&rdev->dev.kobj, regulator->supply_name);
diff --git a/drivers/regulator/internal.h b/drivers/regulator/internal.h
index 83ae442f515b..2391b565ef11 100644
--- a/drivers/regulator/internal.h
+++ b/drivers/regulator/internal.h
@@ -36,6 +36,7 @@ struct regulator {
 	struct list_head list;
 	unsigned int always_on:1;
 	unsigned int bypass:1;
+	unsigned int device_link:1;
 	int uA_load;
 	unsigned int enable_count;
 	unsigned int deferred_disables;
-- 
2.24.0.432.g9d3f5f5b63-goog

