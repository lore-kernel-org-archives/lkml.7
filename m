Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDC0C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B862053B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rGxWRkY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfJARcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:32:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37138 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfJARcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:32:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so4155609wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eit7XFw0W/bYi2TCI4JrcqCDUmHso2PStZ6TlpS2snM=;
        b=rGxWRkY13ekSaaxG3ktLGMpWWwSYN3s/18UU4LQrZ+IE3qC2fMHQaLA8PtNtW8Fksu
         KTzaHkN37F/CDznHSNRpGbLwHveN4J33EzlUiOW8Z5aleLb/ZFn6aq4qH4mq1wlBjMxP
         B57/N2RDXkOqV0VGItpMxUJGst7S6NtDyrbWe1NB6c/LOmiXtSQEJ8qm4nZ6jiMgo3EY
         QeiO6fD0+VQ1yMtcQxKJo6e4cNG7o7ioUreH0pHflcFacOIjkLO5U9ahcFr5zal74ocT
         4fwpyWQSwRrQ4n0Z7g+Gpupa2Gy6vSabwVwrC8oXhLIwD8G2tHLmrylvqvW7m/+p21a+
         2RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eit7XFw0W/bYi2TCI4JrcqCDUmHso2PStZ6TlpS2snM=;
        b=QG3fQvFmSQgicvtuf6Z3B9QSg/H8RX4SP80+jSp7d4rtVF1AKXFztZ3IwuSR1KiB5V
         jNmXXah+ArxOueTThhV4vS3YkQx6VSUt+GH3pUacHEBOXzpXMzmgzr0KSN1hrmC9QQb6
         mAsvhIwVVvYflZIX9Z5Ru8piDUpQGrNwiVZp2xs05DGQDhdTfxro0aseXaVZQKVelPkM
         5uCuXUO6Hj0nfwjHqfeChiqWMTQmg9keOpRve5VmopVMVztsUasbgrxBYAxO1fgmzlHc
         3Iun1igG9njSWyFCgEqPARcWZi8LukpTWGVygtLK+RqkQmDcMdCmGIpzGMHShckjsl5b
         Pcpg==
X-Gm-Message-State: APjAAAWuvNZY1qdgyIXx956I8xV+5LPoptFq8N+8/jwSIY0jxPG9f/ue
        HMINp5Qj+HaY+QGn14nra0LEow==
X-Google-Smtp-Source: APXvYqyF7yR/rpwfrA41ZRGNTEjjIVMSgetqL/JWumgvwhhhAuDGo44vyKvWwhHKt91GmyMiQrTAYg==
X-Received: by 2002:a05:600c:2:: with SMTP id g2mr4682497wmc.111.1569951170420;
        Tue, 01 Oct 2019 10:32:50 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id v8sm27868403wra.79.2019.10.01.10.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 10:32:49 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org
Cc:     peng.fan@nxp.com, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] nvmem: imx: scu: fix dependency in Kconfig
Date:   Tue,  1 Oct 2019 18:32:32 +0100
Message-Id: <20191001173232.18822-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix below error by adding HAVE_ARM_SMCCC dependency in Kconfig
ERROR: "__arm_smccc_smc" [drivers/nvmem/nvmem-imx-ocotp-scu.ko] undefined!

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 8fd425d38d97..fd0716818881 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -50,6 +50,7 @@ config NVMEM_IMX_OCOTP
 config NVMEM_IMX_OCOTP_SCU
 	tristate "i.MX8 SCU On-Chip OTP Controller support"
 	depends on IMX_SCU
+	depends on HAVE_ARM_SMCCC
 	help
 	  This is a driver for the SCU On-Chip OTP Controller (OCOTP)
 	  available on i.MX8 SoCs.
-- 
2.21.0

