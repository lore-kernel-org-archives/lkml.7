Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F88BC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49622082E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJZnSC6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfDMKdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34062 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfDMKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so15166715wrq.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M+CJ1LJc9P2ifnMdggmdy0GXogKPiE65a9+NtihK7P0=;
        b=tJZnSC6xmDl13sDlpyfJlX+BGBIDs5+cetS2YFFL7EcsFoXHy8xfhijs+Skxo47d9p
         XyArjCGOnm+xr8CJ0+iHVx/UEr6/N3zDCmmeckSc1+u0XqDPmH1n8x3uK1kmvuro/7mb
         O9ccqX/SfuetqrQy3KDI0EIGi74fu5sud2Q3YZJ5cf2cUmuHvakNnm0iWrRVHTNb/ndm
         tTTq6Gr8Oyo43NVnvNYOZFpaQpr7PSi14Y6iK0DXbekuuRQC/iPRfMKfrs+z0Zh5m25N
         aObO8LMT3NnSU5/MMW5dp7QwBMtEFtfExIv0Y6BxVhrOj9s8BTV8/U5iw8IsOAr5nLG9
         XHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M+CJ1LJc9P2ifnMdggmdy0GXogKPiE65a9+NtihK7P0=;
        b=qjx3eNTrfAal858PlgVJVYYkHfdkUEoMyI+WUoRt+Gun/hibvoq6/hVwrqogJ/clgu
         PKRzkXJrrTYVOXBHTH5VbzLrFpeuv7xPS8jyNzG1fCtLwLTXEzWAoEPQcIF/6OpbIr8e
         UDhM9Kv/Bq3D1L2PB/2HVr1sJW7HfJsJPXV2r4fA07kqbjWE9zNs6gSAYdpnQycoQdCR
         730ZBZQ4dHCgGUykgzTeyMg1EJx0c9ZC2Yrv/KE4jYdC3T4dSGPYDbRwNKK6v2NCR2PX
         jghcRkG6bo7gdVBSMBS0oRObu7Es4b4xV0tW3G76fW0t5/qNT8aj7KThN0NiQfjCe5H2
         b6ZQ==
X-Gm-Message-State: APjAAAWmTcOTvs0hHUAHRQdlgOeEr4EI1UagTDw2fL0dx66b3ODXM9tu
        mfVHnXVELC+fFmCLTzgAv84GDg==
X-Google-Smtp-Source: APXvYqx8uu/TQnw7pbLPr5ZTQ9u2P9TUX/R4WVLirO5vVb3dyZDSepLPStN1WVjrhfiqT6xFTTmYZA==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr42712691wrn.29.1555151587606;
        Sat, 13 Apr 2019 03:33:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:07 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 01/20] dt-bindings: imx-ocotp: Add i.MX8MQ compatible
Date:   Sat, 13 Apr 2019 11:32:46 +0100
Message-Id: <20190413103305.9576-2-srinivas.kandagatla@linaro.org>
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

Add compatible for i.MX8MQ and add i.MX7D/S, i.MX7ULP and i.M8MQ
to the description.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 7a999a135e56..68f7d6fdd140 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -1,7 +1,8 @@
 Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
 
 This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ and i.MX6SLL SoCs.
+i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
+i.MX7D/S, i.MX7ULP and i.MX8MQ SoCs.
 
 Required properties:
 - compatible: should be one of
@@ -13,6 +14,7 @@ Required properties:
 	"fsl,imx7d-ocotp" (i.MX7D/S),
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
+	"fsl,imx8mq-ocotp" (i.MX8MQ),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.21.0

