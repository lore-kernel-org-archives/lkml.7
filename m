Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CEBC282CE
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA71218C3
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vuVjB4cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDMKdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:12 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54516 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfDMKdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id c1so14195381wml.4
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e5N50vWbvwd210ti5Fjky9lhAV+polTDMPPMD3NGiD4=;
        b=vuVjB4cpt4Qtyyal+jFw6fNzA2nBEhhJGLWxPEi0kegUc3yKJPBgNgzMza9uIDw7Lm
         M/Gt6BE0j6DLaamWYYYFrVksoR7v3xT/ZR4tpgKaFjQ5brkvPyKwyGhnmmF0Dilpa2Xj
         PKPXX64nrTTmljn3QjR7F3qMh1dUD5xCyWHYC2qRRVPstetjY5pSrSwg1ci/N4V5E2n1
         44H5VPZQmrAyR3rdsQSPqdLyaQayUuPW+fD3TkScsgY1hS2kjDjYhnVSKwgSDZMpvW2/
         wmE7N6az5r+IiinPHWRBaz7SDtfX9QhC/ODx47YiSs0BhRzN40i1QTlkQVBuiufPu3na
         jyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e5N50vWbvwd210ti5Fjky9lhAV+polTDMPPMD3NGiD4=;
        b=D1U5JQqmgaGw7uvadX/NwSwvphkRZwDUnLoO8QlPLzEWHqjiicRMgi1Wx3oDzuxJ7B
         uGDMWj6B0Ahl0tHFJB+t6VXVPN8Lqp+Ey9vSdM4OFPk+1SuEW+6N3O/fFgrgc2rYFwmk
         fSJ33APiXMlqu6XND01tLQWMFs9di64ypq+Pv9QaSwQP/KN9vdlWJkPigco8mZGzSvuy
         3ysVdoIZhifqw7imTmbKvliu776UsoleXW6dtYH9WLeLlRF85DcK3AeXjrsljELhkxgr
         mFfiDDF4ABLzhcnww+ldofYuov5M74lkontLPqJfCdeFB9+3AMiDZc5jcaYJrmuvy6rR
         8Ylw==
X-Gm-Message-State: APjAAAXDygYaEwD7mtY1Fh3dh8gp+v32rMCVWMqcdlpclEisWyM/44HL
        mrCK3pkF5LbXhZbno2RUOwF/Uw==
X-Google-Smtp-Source: APXvYqxmdS7zIuIspYt1GyDPLhf2lL3PuCW7Byewsro1jcrcY8WlwPnIj9crOKc/NKcCCaxizC+6fA==
X-Received: by 2002:a05:600c:2208:: with SMTP id z8mr14362083wml.89.1555151589684;
        Sat, 13 Apr 2019 03:33:09 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:09 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 03/20] nvmem: imx-ocotp: broaden Kconfig dependency
Date:   Sat, 13 Apr 2019 11:32:48 +0100
Message-Id: <20190413103305.9576-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

The i.MX OCOTP controller is used in numerous Freescale/NXP
SoCs from the MXC family, so the strict dependency on the
i.MX6 SoC is too narrow. Broaden it to cover all the MXC
familiy members.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 530d570724c9..9e1d83643e9c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -25,8 +25,8 @@ config NVMEM_IMX_IIM
 	  will be called nvmem-imx-iim.
 
 config NVMEM_IMX_OCOTP
-	tristate "i.MX6 On-Chip OTP Controller support"
-	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
+	tristate "i.MX 6/7/8 On-Chip OTP Controller support"
+	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
 	  This is a driver for the On-Chip OTP Controller (OCOTP) available on
-- 
2.21.0

