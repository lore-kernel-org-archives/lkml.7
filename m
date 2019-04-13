Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47896C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1199D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="raLvbQlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfDMKew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:34:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50581 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfDMKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:34:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id z11so14282702wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xB7d15HDtlm2Iw4UdBy0TeItX/FDCpsJFoIKT0Z/+rI=;
        b=raLvbQlre//k5BpAeG2FSg2rNSOHqQIZ80YqB7jMNk05CChZyCivxmIOXam/LY+6jj
         aG6co5E3ZM0rEMHUTEa9b20NyYDMJlZ4ZxzGidDEvIqffHN0v/dGBFt/FHV/cNKyKUw1
         NckxSLiyOy8GDb8CTYDb0XiAVImRI/NVT72Qj9veagTOnpbIAjAjl0avmojIAY5rRkB1
         Vo/mjQToRKHsB+9oo2LgB0WwEbH7qHA+Y/ZOqn2+Vi+PiVMdMgGiAWL/c5YF+j4YKK+a
         b9NeVd3hVW+QYGOdO2Fg0mQOd30y39p0hvXW1bIhuKsS9BdK/zzF3SwPAiLWKOdJIQmw
         rXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xB7d15HDtlm2Iw4UdBy0TeItX/FDCpsJFoIKT0Z/+rI=;
        b=oZK4aPxGIpvdVKQ4NkhLNT/515k1bWItx8mLDZSGZA7mo/RNeCPlYHZH2BRCJlL6OR
         IUcxdj0hUdInHvUfgBw2bLeVUhXN+jSmkp0ji2kvQbW//uNfIO0YY1xvzdqZ50g0XLW6
         0UqEX8Om8wMSWUkVPx7Aa90tSY1O39P2PM4if1tVDkRoXKgm9RDyMJtiwk3m+fgWNvNc
         n/waB4mT+MnUE6y8zFidD6D3SQfbQBplfwFjmEaFPHasiMOkcuBBLramH0z0qbfxitnI
         0iYFeLhN5F92orImzRj0xKs+39do0fvWwMlxaX112Nk/KugKGCI/sBKDRhQNv+3t78+H
         BfzA==
X-Gm-Message-State: APjAAAXPtkfVCk3S78Q62KdrTeWtRxpvGmD6mXvQwe6j8KHZEaxID2pb
        9F6Cwa4dtrZ7CoLE+UK2Y5IE0AzBSvo=
X-Google-Smtp-Source: APXvYqzRfUHq15VFjdxoveR++k8apquWr118w5OMac45MB6NWoxo5dNYjLU01e1ddZRVR6gUV2HNfg==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr14406088wmh.32.1555151689392;
        Sat, 13 Apr 2019 03:34:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id h9sm8155844wmb.5.2019.04.13.03.34.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:34:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [PATCH] slimbus: fix a NULL pointer dereference in of_qcom_slim_ngd_register
Date:   Sat, 13 Apr 2019 11:34:47 +0100
Message-Id: <20190413103447.10011-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

In case platform_device_alloc fails, the fix returns an error
code to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 71f094c9ec68..f3585777324c 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1342,6 +1342,10 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			return -ENOMEM;
 
 		ngd->pdev = platform_device_alloc(QCOM_SLIM_NGD_DRV_NAME, id);
+		if (!ngd->pdev) {
+			kfree(ngd);
+			return -ENOMEM;
+		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-- 
2.21.0

