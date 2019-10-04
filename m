Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D9CC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98264222C0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 22:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="br7cGTb8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388849AbfJDW1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 18:27:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35380 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388197AbfJDW1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 18:27:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id p30so2457401pgl.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTUNCaOOSGwA+ig+a2CKta3BFk73Lmp2ve0uszPOGFc=;
        b=br7cGTb8FH/qLzSnTzorqurt95SrUFywuFB5Jl8nSZ7AiRZhJKECx1dlOZkzMPQ2de
         TI1tjqQbCkW9EHXKfKG7xkzTJMC/7Qy6nJJL98/o+m//yicGc2lAl7axy70kmOlCuoAi
         8y0cNXf8U+jYYxIync3074I2CzZAIS81DVyhRRzRBsFn4cqEQxUnAphdR9CKenTeBiKE
         Da76fC7/0+PavmPZSpvRvz7wGQHMcf15iQfAoREnVjNpN2syvrWojYJvp8kReVwph+HW
         wpiCnrI0daqKIORVVW6qp8rF8XZy1UwRNwB8jlmE2X4H7Yt3Ek4Z0i7WEHj6VSswUeki
         7FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTUNCaOOSGwA+ig+a2CKta3BFk73Lmp2ve0uszPOGFc=;
        b=LvmqnIL93PSyfcENpS7ULFZVLwIpnGm/73JJvkrZ36FesOOeiLJ4IRy4F6JMT6XBjH
         RvSEvnA5z0uum9Z7h1be7ccjtvI4S+KsUrQyYYzedMXyDUzfL8cnk91QuwhTHJ14vkgs
         cueOwUBLFGrjv7ahToZ0NbtkTMRroZqKZ/QH+6BfcLQbUv6PxItIy0l7KUYAVz9SIEMr
         Zz0JRpxD4+Mhu0uTNPepM5i7+ShCSvXWTD6BDU4c/TbFWj5ra4livVai/8c/3ldadCct
         WtawD1giTuxVIM0Q9ZtpAO0iacmy8I3i6CP5qEzslgg1Z5Ek0Ha24bW08uIFM5QJP2AZ
         699Q==
X-Gm-Message-State: APjAAAXmKM0yWJgOOvrCDyhVAHImfPC71wMObymfdDCWDcs0uKDo2bcp
        RIJAHnmPoC/HeGMfOt8rZczrrQ==
X-Google-Smtp-Source: APXvYqztxqw61a4Nv7hxanL7+0PPCWg7dFcRWKaXzKZi+YVENH+DI3r7XNAlz+VlWXgVpUqJ9ACV5A==
X-Received: by 2002:a17:90a:3847:: with SMTP id l7mr19708014pjf.118.1570228033776;
        Fri, 04 Oct 2019 15:27:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x37sm6328136pgl.18.2019.10.04.15.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 15:27:13 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 4/6] rpmsg: glink: Fix rpmsg_register_device err handling
Date:   Fri,  4 Oct 2019 15:27:00 -0700
Message-Id: <20191004222702.8632-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191004222702.8632-1-bjorn.andersson@linaro.org>
References: <20191004222702.8632-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Lew <clew@codeaurora.org>

The device release function is set before registering with rpmsg. If
rpmsg registration fails, the framework will call device_put(), which
invokes the release function. The channel create logic does not need to
free rpdev if rpmsg_register_device() fails and release is called.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Cc: stable@vger.kernel.org
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- None

 drivers/rpmsg/qcom_glink_native.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 21fd2ae5f7f1..89e02baea2d0 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1423,15 +1423,13 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 
 		ret = rpmsg_register_device(rpdev);
 		if (ret)
-			goto free_rpdev;
+			goto rcid_remove;
 
 		channel->rpdev = rpdev;
 	}
 
 	return 0;
 
-free_rpdev:
-	kfree(rpdev);
 rcid_remove:
 	spin_lock_irqsave(&glink->idr_lock, flags);
 	idr_remove(&glink->rcids, channel->rcid);
-- 
2.18.0

