Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFF0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01F9218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sryS97gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfB1Ppd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:45:33 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33588 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731175AbfB1Ppd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:45:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so9916640pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 07:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iv1JTrjEA4B9DOkxSeUXnbdmJSPgc02SMTzS60GzpbE=;
        b=sryS97gWrsuce0iN9m7IBlFKtZfMEKn4BXzKntpqf2tzkM18aUj2bc4CsOI00aAwD6
         W2mlU8jDMncJGK0A6D3FVI/JWvrHDSmt8CJ/o3yfOwShGl2DDfRzIAF2hIUjBIDoD6rO
         lKDzDTbkgHqi/R8RDE5KACuVmmrGBoU+CUgG0FBuhSqJNydk+vgnlDaIXkOXwfbHcUE6
         yaWQPzvJKpde2dEuhwwe+0H30zquTuxk5faRR6Kiepqtlp4gribjYDTaGB/KwrfIY7/x
         CnBUQgxp1Ut/930kNR3Z+B0hxRLg9cATdDDHpl4uPIXox5zHk/9JfjmRKMuKQCwhN303
         pcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iv1JTrjEA4B9DOkxSeUXnbdmJSPgc02SMTzS60GzpbE=;
        b=RjXhQ4zy9MF9hF0W+Dsox0QYnHkoG0/oCS9ndKdoQERuiB3lQnsBEJVRgB9AicnEvj
         5oVEEmeaB2pXFzr/lW4G4FocxbHCguxttP/dCXK3+eQbA8aTQVjviRkboJr5zvnXovLp
         /JhLmm/yrhIgAwhspSbe6HvekiReNAbIatuR6ZXcqgxYcS8VOcgzgcX9e0N+evU6BN4r
         LMPgPr5TV7YZMstTaSAlfj1ZKMcS7RNTicdsGNabeZKSKhRQ3meTCzSXlbKaf2J6PuaP
         +kP17eDp9lKH2t5stdk+cXm9qWKrBTV7F4zMDqjEPzG9BaBi1jvvD8uH6Ye/paRtdf3z
         C8CQ==
X-Gm-Message-State: AHQUAubVMSxqz26TcEFcQSYA0b5EeQCtiNWQNXvE+BCq0ftBfv5Q5srT
        e7SUtZXMmsJtSHTU2Z3w45f9
X-Google-Smtp-Source: AHgI3IZTMkNzKFbQ6r9RzBF9iVJOG9gTvSwtSCBQMlK3ynquTd780sqJDkdnQTvOX7QiLQfYIqO8aw==
X-Received: by 2002:a62:f201:: with SMTP id m1mr217493pfh.97.1551368732335;
        Thu, 28 Feb 2019 07:45:32 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:905:9c3:2dd3:3db1:5145:4da9])
        by smtp.gmail.com with ESMTPSA id m13sm37485286pff.175.2019.02.28.07.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:45:31 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     xuwei5@hisilicon.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/3] dt-bindings: mmc: Add HI3670 MMC controller binding
Date:   Thu, 28 Feb 2019 21:15:09 +0530
Message-Id: <20190228154511.17566-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
References: <20190228154511.17566-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI3670 SoC is architecturally same as the HI3660 SoC. Hence, the same
K3 specific designware driver is reused for HI3670 SoC and the binding
is documented with fallback approach for compatible property.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
index 07242d141773..36c4bea675d5 100644
--- a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
@@ -13,6 +13,8 @@ Required Properties:
 
 * compatible: should be one of the following.
   - "hisilicon,hi3660-dw-mshc": for controllers with hi3660 specific extensions.
+  - "hisilicon,hi3670-dw-mshc", "hisilicon,hi3660-dw-mshc": for controllers
+     with hi3670 specific extensions.
   - "hisilicon,hi4511-dw-mshc": for controllers with hi4511 specific extensions.
   - "hisilicon,hi6220-dw-mshc": for controllers with hi6220 specific extensions.
 
-- 
2.17.1

