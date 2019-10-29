Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091FACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04B4217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i36cH2MQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfJ2Ln4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:43:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37905 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbfJ2Lnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so13273332wrq.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z9nVcHk3Q0mlF3PvM5FkU72I0eorT8jyZZzFFAHSx54=;
        b=i36cH2MQrS2Pku+ZBZcVraaRTjCF33KGknTNMtLaGuVw9x5HNGs1TCr3sisbGQS96u
         cP4cBHfQhioeopJuLhhvyFl68JgSP5EkdjdxJiVKXxNhZ1upA5TldrZg+6TL9raOLCDE
         kJ9aj3irlJn7kZZEVFU3VGAZ92tAPU4cYwhxpDW954Ivxb+Rcs61VbUBwowk/CkFeFzB
         hVTSTHSgPUpAWpeQ2+txTc8QQKPNhCIvpeiFo7VaBPr7+RST7+8vsZRdNn2+0sA2Nrdl
         q39nDADBdvJutHWV/f7hZ9fUYIKV7uQvsPdQcan3gsC/9iS+DLHlT316JsckM0pu0eF1
         9E6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z9nVcHk3Q0mlF3PvM5FkU72I0eorT8jyZZzFFAHSx54=;
        b=XVeI4+EzSZXpjCl/OBxlnho3HmeZeG4IUEvZyu1xKWvlS9tEJp+WKPaEY1ps3dOLFr
         ixieSL2yFzVrn5yiv65G20334fkbVS7wFNyQwnlspE7f39xLbFFALdRF7UcnL3QFgR61
         3+JVci2YzSKCqtIhTdqUWtftxPdItOtio3OF91pTX0SclCeXLDY/ZUlJg0XYrXu6s/RY
         e2vinzcMnxd3RzPpGjcqFqSpD/11PQCG32jYzOFCmbvRX+GsBk8xXMTBj3GUbyqn1C4s
         E4dbJ/6I5z9Xam7h8n8gFUCdpuK3w0kSI6+nFvtCjyRnjrOmkcJtBWQWmXEy4nq0osFz
         s9Pw==
X-Gm-Message-State: APjAAAXZxC9Ywfa4I29kbiWjtF2GTH7UNYckOfX8tuFSg2wd366qwc/m
        lBEORy3iBBa24zSaKx2FVY77TcDV+K0=
X-Google-Smtp-Source: APXvYqxiPH7I82nqprgDUTctqR7T/FbzjjRn0ss6emWFWYOezcwLl6U9I26OwlLPm/S0Mg0kwASagw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr20169902wrq.129.1572349423624;
        Tue, 29 Oct 2019 04:43:43 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/10] dt-bindings: nvmem: add binding for Rockchip OTP controller
Date:   Tue, 29 Oct 2019 11:42:39 +0000
Message-Id: <20191029114240.14905-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko@sntech.de>

Newer Rockchip SoCs use a different IP for accessing special one-
time-programmable memory, so add a binding for these controllers.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/rockchip-otp.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/rockchip-otp.txt

diff --git a/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
new file mode 100644
index 000000000000..40f649f7c2e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/rockchip-otp.txt
@@ -0,0 +1,25 @@
+Rockchip internal OTP (One Time Programmable) memory device tree bindings
+
+Required properties:
+- compatible: Should be one of the following.
+  - "rockchip,px30-otp" - for PX30 SoCs.
+  - "rockchip,rk3308-otp" - for RK3308 SoCs.
+- reg: Should contain the registers location and size
+- clocks: Must contain an entry for each entry in clock-names.
+- clock-names: Should be "otp", "apb_pclk" and "phy".
+- resets: Must contain an entry for each entry in reset-names.
+  See ../../reset/reset.txt for details.
+- reset-names: Should be "phy".
+
+See nvmem.txt for more information.
+
+Example:
+	otp: otp@ff290000 {
+		compatible = "rockchip,px30-otp";
+		reg = <0x0 0xff290000 0x0 0x4000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&cru SCLK_OTP_USR>, <&cru PCLK_OTP_NS>,
+			 <&cru PCLK_OTP_PHY>;
+		clock-names = "otp", "apb_pclk", "phy";
+	};
-- 
2.21.0

