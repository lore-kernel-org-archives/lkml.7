Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFA4C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF562081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgtvqWkR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfCIB7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:59:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45723 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfCIB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:59:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id 125so15277001pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y/pIRq3eoYMGqKuzxQRW6Xe3PFikDk+GOICmlrRtQ4w=;
        b=BgtvqWkRjvb9c+Gh/OXuz6H7Ix6XfCEwIgrSWCB7ywmHqwpb8aRc3mFQwwBXErT+q/
         GDEpx/TNa9emQWlTUAs9mo8BEipk3m9g25uP8fz+tbzx1sH4ULUOh5+Zy9RM9bcZkE6I
         ayubrBHrd723F2B8TjPXhMOxuqW+nSK71cKU6ZM50eU99unmTBIiTj0uFe/m1XMQOpbp
         S7YUcMfKUmw6bp4dVg8NAkURLowt+DeLEMiKiOB8LbxJ2k//Cq2u9mBCU2K3B3d8/ZtN
         /M35HtmK8tjCRpeNcCyB9yq07gpdU1eikVExZ2hoIqPK8jL3zgSB65qF8LKTw9aP1nEK
         YkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y/pIRq3eoYMGqKuzxQRW6Xe3PFikDk+GOICmlrRtQ4w=;
        b=F1Egl5kdHP+A2F//Ss2H1Rzxkmmjv/Iy5hDIOCpKHT9M+mF9pRI6I0a/7FsploEkW/
         mULmn/WPkXbe+7WT+c8CMipAiGKZkak65PUmEz6MGRvL6PUsyBjS+lxKKYAavDNc8syP
         05FVVLmb9CW4WaR0OBscuk0HQw9iLJ3Gfkb7sTjVJfzk6w9otb6EqhU5bT+fqbvhirb8
         b6/UdSvWXOABo6tQKe6aV99Qdd/UiKg1gFOoVbGSLXqRW3UtvZ3YN3/l46gkCzwRoPTn
         0T402Q9Qc59f+mKx+Gs/HeeHNw//z8A+DuVb4GRPL6vnTIziypf/tKstHenX4GLYl9T0
         y/Jg==
X-Gm-Message-State: APjAAAU0X8KSj5E+62s+mLwRzYmD+bAmmCyItfIdLzjEWVaGYOodu66V
        E4MJW00TMvC/FFSfAayA4uEl
X-Google-Smtp-Source: APXvYqw7CuEXXWxNJ0uqXcWyOAyvjrvSCwZpgL7bwgKagnDdpoUA6Sq6eUP7YwzTftQWnUpe1EzArQ==
X-Received: by 2002:a17:902:ba8d:: with SMTP id k13mr22137540pls.15.1552096748923;
        Fri, 08 Mar 2019 17:59:08 -0800 (PST)
Received: from localhost.localdomain ([157.51.75.198])
        by smtp.gmail.com with ESMTPSA id b65sm16040201pfm.127.2019.03.08.17.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 17:59:08 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, xuwei5@hisilicon.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, daniel.thompson@linaro.org,
        peter.griffin@linaro.org, guodong.xu@linaro.org,
        haojian.zhuang@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] arm64: dts: hisilicon: Add reset properties for HI6220 I2C and SPI
Date:   Sat,  9 Mar 2019 07:26:35 +0530
Message-Id: <20190309015635.5401-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both I2C and SPI needs to be taken out of reset before being used. Earlier,
we relied on the bootloader to do the job but a more cleaner approach would
be to handle the reset in kernel. Hence, add the reset properties to
the nodes to let the corresponding drivers take the peripherals out of
reset.

Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 108e2a4227f6..b071dc466374 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -730,6 +730,8 @@
 			pinctrl-0 = <&spi0_pmx_func &spi0_cfg_func>;
 			num-cs = <1>;
 			cs-gpios = <&gpio6 2 0>;
+			resets = <&sys_ctrl PERIPH_RSTEN3_SSP>;
+			reset-names = "reset";
 			status = "disabled";
 		};
 
@@ -741,6 +743,8 @@
 			i2c-sda-hold-time-ns = <300>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
+			resets = <&sys_ctrl PERIPH_RSTEN3_I2C0>;
+			reset-names = "reset";
 			status = "disabled";
 		};
 
@@ -752,6 +756,8 @@
 			i2c-sda-hold-time-ns = <300>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c1_pmx_func &i2c1_cfg_func>;
+			resets = <&sys_ctrl PERIPH_RSTEN3_I2C1>;
+			reset-names = "reset";
 			status = "disabled";
 		};
 
@@ -763,6 +769,8 @@
 			i2c-sda-hold-time-ns = <300>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c2_pmx_func &i2c2_cfg_func>;
+			resets = <&sys_ctrl PERIPH_RSTEN3_I2C2>;
+			reset-names = "reset";
 			status = "disabled";
 		};
 
-- 
2.17.1

