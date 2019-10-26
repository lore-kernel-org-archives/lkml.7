Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C782CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1262B2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 11:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LqU7fQxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfJZLD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 07:03:56 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36406 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfJZLDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 07:03:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so2184533plp.3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 04:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vyxQq6l0DnXXPlNTL9PGBy7Itz+G0TwXgp9Tr10w+hM=;
        b=LqU7fQxXADEoJo1iJRWCPMjKjlbLvMNCiGX6jTfiWYZG0EJ6J4XceuUuxTOMdSYt1W
         K23z+LYN8oSwZmG+kVX6OtzON2AIffTwVtY0imNKXzg9E4km7NgE/39FzqOPcOf+Rb17
         RGuZm9KUni1rKnG+YGQx7wBVyUbMsINQC0jQqgx0MXdswzY5Q9iSiykkynJ4GU305JFw
         N79jss3RB06juP8aMGcumOnPNsDXAgMcEtN7KgJAAoGRR1T4pvSbF5sS5U4qt+W+YL5P
         ee7gJBk15XQLz7oJWmkMyktlpO6guN+uL/ZyxqXLKCgiSbMKXWODkeX3I66TI3CYAumg
         93aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vyxQq6l0DnXXPlNTL9PGBy7Itz+G0TwXgp9Tr10w+hM=;
        b=trDNtH+i19JmopkVjx3Pi+MzeZlQ2luvsSbreSyZlvfehzp/pIR2VS7CFX/tU6chu7
         SrOCNcXSF25nCVcTCoeApQiSrVTI1xxSSGH3nN8LhcQOW3NjudOfGDRpnW3hn/pF6bca
         Bn4cZRMBlwvsmGVkgtezRKpBxAXZh2zdwaav5DwPN4ZYqDUM6Ks/dryl+aTwjHDezps4
         v1BvpAr0YjrzGbH1JZShLu6gPW8L6ttHQ5R1eGKa3xr6YmnBqsLLmafVqAQK9GU1HYgf
         Xm9Pr1zcVHmNvK26EDP9n8QwXKiYyrrWtr4nkExQshFWNUVFgJGGR4letDfdsQ0pizMg
         5uDA==
X-Gm-Message-State: APjAAAWMrIaQqEYNnH/Pl9aEW9gOCaJ0rOpSqh07E8TNKQxzTlmoYMBy
        +x3kQxI9mevZwbgzdyDq2vmi
X-Google-Smtp-Source: APXvYqyK9jvXbwURhpAqztJP3EnJdLxxvieDfHWxplIGYVviYZPsHLpbr0LXqo0jJlnLgVYJsK1XsQ==
X-Received: by 2002:a17:902:d913:: with SMTP id c19mr8912095plz.48.1572087834354;
        Sat, 26 Oct 2019 04:03:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6214:69c4:49ad:ba3c:6f9:2d8a])
        by smtp.gmail.com with ESMTPSA id x129sm5543379pfx.14.2019.10.26.04.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 04:03:53 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 7/7] MAINTAINERS: Add entry for BM1880 SoC clock driver
Date:   Sat, 26 Oct 2019 16:32:53 +0530
Message-Id: <20191026110253.18426-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
References: <20191026110253.18426-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Bitmain BM1880 SoC clock driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52f3ac28b69e..40e9ba15ad2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1529,8 +1529,10 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm64/boot/dts/bitmain/
+F:	drivers/clk/clk-bm1880.c
 F:	drivers/pinctrl/pinctrl-bm1880.c
 F:	Documentation/devicetree/bindings/arm/bitmain.yaml
+F:	Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml
 F:	Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
-- 
2.17.1

