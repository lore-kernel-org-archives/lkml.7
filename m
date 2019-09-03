Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C48FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48D022CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4ycrKz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfICT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:26:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfICT0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:26:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so18676250wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X7LOfbEzmxWDRUYRuEzBuTJ6VKUzfdWfj/jsTb2hBhE=;
        b=P4ycrKz77LO/F8JLYcANp/4uFdyCVH35SV39HLLI4aQ3wyNOyYJJPpwocZRengbG8e
         H7lY+5TC0ybiVCBVPoTp3Hh+V2gr+/D9DibMtN1S/5N08F8Y/nndU5cclOH6rtBmYtsJ
         RGZol+xKNhXWWIG60neQghT6vHrdmAW/oJp0cy+2PxP/BG+8Zqblm+8E/wUJ46n57WZ+
         BKQy3DGy4k+koJCbbvpw/PveLkeZ7OfISrVi+hAHD2p9iccitj3Ek+8x94hv4a0KHxcD
         jQriZeP0mCNPbWkR7YCmrwoHXn7P6k4FSLaKqlwMVvF/tiCkyfMIQY7WWttIuUsMZJ7J
         iORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X7LOfbEzmxWDRUYRuEzBuTJ6VKUzfdWfj/jsTb2hBhE=;
        b=KvJbbx+LRvPuMzwR1EYVS1Karcah4/w93saO4ec1Mfk1rQeCvBzf2zkM+PBZ1CUoRI
         m+DUbMLT/FKgQUvs4mWo34SZraK8SZMFWzK3C0ota2f1rV0WZXtD4R0vhSSqKaGC3AKk
         D24Hgnvs1FJqTFE1vbyRR197Yzrzttz0vKPPy0RtGIQkyM5REUuvMkXboXt2w2Myyu1W
         5Fb3v1tbaicc2rdlUL8sHRqAmDtkGT6/OJoCGi0QZhUG3vQmMHz04TO/BJRIM12I1ZZ1
         kAyijQqyEJwrOXPv56Uor/DlCdjBBAMj4ZYINsAaK8RDGdKTr6yQnXxFKYwJHQXIAo41
         dVJQ==
X-Gm-Message-State: APjAAAUiUoMvhBnKib2HM+ZPL3KvCwKckP907wDkPoC7Iy9YDozg6tnh
        pDlq6A7BjMpLt7IQVZpkyem58w==
X-Google-Smtp-Source: APXvYqwhKx+lvSTr6idloMJNUmzIe0WiaLfN1tBr5HnJNiXSV+DK7lzPC4Qn3TlmvpseiD9C7XQHUQ==
X-Received: by 2002:a5d:574c:: with SMTP id q12mr16298520wrw.69.1567538792400;
        Tue, 03 Sep 2019 12:26:32 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id b184sm473895wmg.47.2019.09.03.12.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 12:26:31 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/3] arm64: defconfig: Enable Qualcomm GENI based I2C controller
Date:   Tue,  3 Sep 2019 20:26:23 +0100
Message-Id: <20190903192625.14775-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables the
keyboard, touchpad and touchscreen.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index facf19cc275d..0fe943ac53b5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -366,6 +366,7 @@ CONFIG_I2C_IMX_LPI2C=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_PXA=y
+CONFIG_I2C_QCOM_GENI=m
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RK3X=y
 CONFIG_I2C_SH_MOBILE=y
-- 
2.17.1

