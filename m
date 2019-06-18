Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B25C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1543B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvOFBSUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFRHIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:08:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38808 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:08:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so7157555pgl.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=whbkciZuL++lKNDvtvhbwAO5DyTyA866K2yDYDBjqZI=;
        b=zvOFBSUPmPI/GdgLLOxkDVawbMy7YCCvIZ8vYJvsFNaKl3Jn28Tawlq3CoP9wlm2bE
         V4c0+HIBf0vxfU8RK9E0YMWwL/1SEfbVk+bIhbxMbeHjmHa4r3E7ku3XoTzVZW3qOoM2
         rQHKBhbL5xJxRqeKHguWsj2O7CU3pdlv0/4v1XWIWvU9POj9MhnixLjcWryeMZrIN+xy
         yoMyl44dxeDQ3V5/i8Jd3JeR6ideyS4FL7V4IsSFGH2eQG+yqZeDEE+6AEE/OMzCtaVa
         ztwa5dduFHcj7lZAq1QGJXD/osZ3fKcSXmfHemnaCDYt9yDGdEZNt+BatVmigcYdS1VY
         5xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=whbkciZuL++lKNDvtvhbwAO5DyTyA866K2yDYDBjqZI=;
        b=tzVeubXv45YbmEly7IeVbhGydancLIxurUIzODW1XQjKNMPdJqZ3TYJs4IfXKZcpD2
         uNGfRYvR8uaGf0OxPPHLxq7d8DG9/ZHwdoHDvGTHpAg7zfsJbESO8uCSZVMlEZIN8qdR
         HJIy1NaqX7E15zAp2MhueB95ukNTnCNjo6CkZB6qkOf1Bee4wP4ygHNg9hGzTew8xyPn
         8jv2VFERiX4jZQDOQGTFM27JG9Eqcq0uZLkeV9WfDocqoIDzbB9MrUOQ1YRieyfMuI/G
         7TArb2js92zrmTbNQXEpKfDzVxgRwMaAszYzML0krUbSka00VORjEanXxDpgqkVhB1C+
         zdyw==
X-Gm-Message-State: APjAAAVYH/jGv0F17ni/VuPS0XSr7LQQchisGbceK//KH0ewwCFC/pkf
        5P5FrXD1oaA5q+AmKXA71YXp0nv/4CI=
X-Google-Smtp-Source: APXvYqwig0dnCKGj82lWud21PmluM29Y5AErwTeEnPoTw6eHbzOeKqZ0jJB54Z+SW0QC+OnctrVhjg==
X-Received: by 2002:a62:68c4:: with SMTP id d187mr121107689pfc.245.1560835607326;
        Mon, 17 Jun 2019 22:26:47 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v185sm3051958pfb.14.2019.06.17.22.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 22:26:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] slimbus: core: generate uevent for non-dt only
Date:   Mon, 17 Jun 2019 22:26:44 -0700
Message-Id: <20190618052644.32446-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Rely on MODULE_ALIAS() for automatic kernel module loading, rather than
basing it on the OF compatible. This ensures that drivers without
of_device_id table, such as wcd9335, will be automatically loaded.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
[bjorn: Added commit message]
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/slimbus/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index b2f07d2043eb..526e3215d8fe 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -98,11 +98,6 @@ static int slim_device_remove(struct device *dev)
 static int slim_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct slim_device *sbdev = to_slim_device(dev);
-	int ret;
-
-	ret = of_device_uevent_modalias(dev, env);
-	if (ret != -ENODEV)
-		return ret;
 
 	return add_uevent_var(env, "MODALIAS=slim:%s", dev_name(&sbdev->dev));
 }
-- 
2.18.0

