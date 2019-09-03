Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42151C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134B82168B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDliV/tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfICT0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:26:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfICT0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:26:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so18702995wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iu9mDdhXT5qnRAh0+sfN4E5G1hBz9p+AFjOzkuFdANU=;
        b=QDliV/tlu4dauS5+qtBz/dQPRgPdi/gMVcoNyyqV3Q4kzX7DRZVQDNiD9jVvIlnfMR
         /rk9ZexDZsw7sP3eXj2drFwQ6jvMnQQz1+j9b7qcvmVMnUVnmfAE6oZ9TSmiosD3q4b1
         EzrklQbsEyR4Ns4LE2onsV7tAgqhCa9c8al/mk+U8cUTdIzmYc+rnitTHP7FN9BvfvDf
         cuT2qQrx6VyUlpDaXmrIN1rwQIRwIQWCEl67rM6ltk2RTUYoD1TgEASrqRLgdpuSh1Z0
         4+h/xhMlrPM8g9T+QRiMksvIf0aGed8kjfQrz0C/YqGKJzGeIT8rFmz6Bm45kcpGBAZX
         WnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iu9mDdhXT5qnRAh0+sfN4E5G1hBz9p+AFjOzkuFdANU=;
        b=Fbt56E/7Mls7XiXb/O5VuzgPSvMlRksLL8wE7lD6SUNzmicp24Vz5Y3mNu+OenL1Q1
         fy9GyC1M9tlcuY5dCL3Nl6ZAOB6Dv2fkaZJ6UcYa7JbZJwGbauLmCcMpDzVWoJ60uGUT
         keq+kTebpu9PnUJy1uCVSA0nvJW58Cw1xDsW0GfYxmd0eWGe9klvfPI2Nh32ZeNrv0lX
         nl9SWRjZhkCCjPMIr+XvjJiKPYaNsJ/lTk+/T4hW1irekAMKoiy84PYTRsxCIVp/yR9y
         rnJ7LwVHnddLi0lR6vhdOYCBxMLw4fbKHJVJlb7Td6LOEFVW23c5GP/ZRnwHh1h1+N93
         dekA==
X-Gm-Message-State: APjAAAVajXbSlj/48in/C272br5mgkC/09yqiTr0Z5COZrigLZ7dytn6
        QhLLcw+9TVOz8CIxvfiV2bnAqw==
X-Google-Smtp-Source: APXvYqxgB+1waw5g1KRrYZlfGed4VEHLM5YikKdfvBylnWAfiHaWQTKKGR0A+NIve5O7A/znEXdUAg==
X-Received: by 2002:adf:ba0c:: with SMTP id o12mr27433308wrg.284.1567538794208;
        Tue, 03 Sep 2019 12:26:34 -0700 (PDT)
Received: from localhost.localdomain ([95.147.198.36])
        by smtp.gmail.com with ESMTPSA id b184sm473895wmg.47.2019.09.03.12.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 12:26:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 3/3] arm64: defconfig: Enable Qualcomm QUSB2 PHY
Date:   Tue,  3 Sep 2019 20:26:25 +0100
Message-Id: <20190903192625.14775-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903192625.14775-1-lee.jones@linaro.org>
References: <20190903192625.14775-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested on the Lenovo Yoga C630 where this patch enables USB.
Without it USB devices are not enumerated.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index af7ca722b519..a94d002182ee 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -770,6 +770,7 @@ CONFIG_PHY_HISTB_COMBPHY=y
 CONFIG_PHY_HISI_INNO_USB2=y
 CONFIG_PHY_MVEBU_CP110_COMPHY=y
 CONFIG_PHY_QCOM_QMP=m
+CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_USB_HS=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
-- 
2.17.1

