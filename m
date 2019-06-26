Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6C4920B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 10:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxB4Rfur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfFZK2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:28:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfFZK2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 06:28:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2127775wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5uzszV+7Ya3X0Ti8Q3j+2HtrxZYyAMfNJvKRoru6OH8=;
        b=WxB4RfuruC/yhs4Ah8lZU7dPpnMc3rmfsmOYiXZIjFaaiKpKUyDWvEZrq2JnMwwanr
         kvhkjQDzMf5yGS0Hfs58/UFdyYu3k6QhNBNNO52M/0j5G3GphUbG1XAnosFEvULcorOb
         zsUK74hfTp17R+H5cgo4nM/sd5jPhV5XS/q9mwz16sbanKtyJUPXQMqTqy7AEq6p/+nc
         JiLpwMDy230jq4H7Fuu7lCsSWy3d8tG0TFLnZEXc5NOVyQhIdqhtF3S+HANndt517xhI
         X51m4mCErjy4cfilG6QuWjoMF3gHYjg8WQt1o/NrhaYZv5yO1CluxMO0grbW6kW5aNoh
         15Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5uzszV+7Ya3X0Ti8Q3j+2HtrxZYyAMfNJvKRoru6OH8=;
        b=lqS2Dx0fu1TDRo+2gq3trmYJ5+GypU03Qkj5fUBenfNRzsaLs/Hv82GPdzfs5jka3Z
         3cz+Av5z+1mZ2XopkW3aDgqeEr0qdVjMmj60jevLZb/1FDpGz1GAlHr/K6RaIFLVJAm7
         au+mBysx73hdIs6iVRIVeZk0smrKs4Y7aWItD30cPBIysUHr8XymX7tSiOs4oB/zk/Cy
         wuhs4H/lBg3/rC55OcbJoMVByInQ8nKqSLrWuXYVoaF9DMR+RNnOydC50nQNcGWd44Di
         rUTqzykTD751UMkTZuUJAqepRUjXYVTk0YiuYE5Rtac4rGBi8Qef058AcEDYzBijdsrm
         b+vg==
X-Gm-Message-State: APjAAAUOzsE3v1OGRYzctOuPT/0XuDsqcbfOiXra3/RFH7xm9PIFd54f
        +BgassKHS5NVCqTYgN0UVMM1wA==
X-Google-Smtp-Source: APXvYqwOOh/6r5I0clXZFBFcf0kKl5YKJ1PT8erpdFmoxoO6wMDlTANQsMHVrnxZQyWwvy3dHhIdkg==
X-Received: by 2002:adf:ea8b:: with SMTP id s11mr3069165wrm.100.1561544885665;
        Wed, 26 Jun 2019 03:28:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z19sm2212042wmi.7.2019.06.26.03.28.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 03:28:05 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Rob Herring <robh@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 5/6] dt-bindings: imx-ocotp: Add i.MX8MM compatible
Date:   Wed, 26 Jun 2019 11:27:32 +0100
Message-Id: <20190626102733.11708-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
References: <20190626102733.11708-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

Add compatible for i.MX8MM as per arch/arm64/boot/dts/freescale/imx8mm.dtsi

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Rob Herring <robh@kernel.org>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
index 68f7d6fdd140..96ffd06d2ca8 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
@@ -15,6 +15,7 @@ Required properties:
 	"fsl,imx6sll-ocotp" (i.MX6SLL),
 	"fsl,imx7ulp-ocotp" (i.MX7ULP),
 	"fsl,imx8mq-ocotp" (i.MX8MQ),
+	"fsl,imx8mm-ocotp" (i.MX8MM),
 	followed by "syscon".
 - #address-cells : Should be 1
 - #size-cells : Should be 1
-- 
2.21.0

