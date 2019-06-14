Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766F5C31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE120866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNnlqtg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfFNOcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:31 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46427 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728592AbfFNOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so2743546wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dEGsv1xt89okLqG46teao5LGbBhh1cK6PExvsJ89WBk=;
        b=JNnlqtg5TB2uvQJRhyzLfO8Insof31JtdxXMjKf4hY8C9fJfTRLifW5Kr+CZeEq2SL
         +vFgde0iTTnKb/Utb/PKv6MdEsiwAHgVXTZzg+AxAt47RM80XNsdG3CjFDfIoPfSnHxV
         cvbdnVFkzQHsEx2bhKZ6hK5FWL2/Pz/3MQkyBu2QyrcvtdT5g/dJ0N0WbMqZsu1i54/r
         KTHJxZt5pSw8JF1oeiOE5Nwtw5Jm9DGZhzDqiDkOngZVujT+yg9vfrZ3e9P+jcz/rrMY
         mlKLXIRYaCxjKmDgfqGoSmVYLOJgxeYWIyqFoFCj0loWxY6zdkvcu47GIdAn56y8WyjH
         /1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEGsv1xt89okLqG46teao5LGbBhh1cK6PExvsJ89WBk=;
        b=skoN+tXeOwsdIkRYdIqrUCNAWlh0iZ5Rr+RF+nhhWpTiB2r98SrB88M6RrkwkC1wmM
         cTKgsNz/+7f5ih7ERCXXhFXXSOELLLJYtljXaDGo7rqnmtx+bWz9EGKSnFRo538sItPJ
         o90LLlCNFIXP/VCk0z2mJd9zjpMbsZBeNWmwXsFM1EBet9rU/GloZM0LhzhvzrhyK+Fb
         5YEuH1NArLoz386BsWbjCzl9TETZdNsnc1AWfikKPgopT8GoyuGZJvBRsu7k5Dy1twBs
         stc8Xqca8he2kdpTp0FELHDIYQbqCqWgm0SBnuG+C5vyZrOTAtBppgfB5pz3IzCFH5ra
         ssZg==
X-Gm-Message-State: APjAAAXNJCeGkwx8GQSEbEl1zmzl0le4QbuLZlnW5NwZB4lVM+SzH9VW
        bokDikhn8JaoQKS95xZqcqV5uQ==
X-Google-Smtp-Source: APXvYqyuKVlYbA/gO/jV0TOhappla7urZF2qZpwFEIFS+3B9kmYiHjcMQGCZe64JSTYa6NMP7rK8uQ==
X-Received: by 2002:adf:e34e:: with SMTP id n14mr45219052wrj.169.1560522746259;
        Fri, 14 Jun 2019 07:32:26 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: fsl: scu: add ocotp binding
Date:   Fri, 14 Jun 2019 15:32:18 +0100
Message-Id: <20190614143221.32035-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

NXP i.MX8QXP is an ARMv8 SoC with a Cortex-M4 core inside as
system controller(SCU), the ocotp controller is being controlled
by the SCU, so Linux need use RPC to SCU for ocotp handling. This
patch adds binding doc for i.MX8 SCU OCOTP driver.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anson Huang <anson.huang@nxp.com>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 5d7dbabbb784..f378922906f6 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -133,6 +133,18 @@ RTC bindings based on SCU Message Protocol
 Required properties:
 - compatible: should be "fsl,imx8qxp-sc-rtc";
 
+OCOTP bindings based on SCU Message Protocol
+------------------------------------------------------------
+Required properties:
+- compatible:		Should be "fsl,imx8qxp-scu-ocotp"
+- #address-cells:	Must be 1. Contains byte index
+- #size-cells:		Must be 1. Contains byte length
+
+Optional Child nodes:
+
+- Data cells of ocotp:
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
 Example (imx8qxp):
 -------------
 aliases {
@@ -177,6 +189,16 @@ firmware {
 			...
 		};
 
+		ocotp: imx8qx-ocotp {
+			compatible = "fsl,imx8qxp-scu-ocotp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			fec_mac0: mac@2c4 {
+				reg = <0x2c4 8>;
+			};
+		};
+
 		pd: imx8qx-pd {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
-- 
2.21.0

