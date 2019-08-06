Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89F4C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936BD20C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oUkCdFia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731918AbfHFNKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 09:10:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38872 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfHFNKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 09:10:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so37835855plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1DRYxM4S/B7SoxMDhNxSzKMNHFlAjuQUN144vOww2A=;
        b=oUkCdFiaTmZ8YWhjKmmX9kta69kGgzWITjsFkueRoaps7eZWMWSw47AOaqC0Pnrmvh
         CvUvtUFYz7JX+4oGPuvOSAIf8R4F9M7yBpZJGKc7DJSJbWCPyjyP4dqe9y+ImdYq5+1c
         CAAQ4HwQZsme5eotFfJV0nlXHowMbBG9WrhEQpAaSDELEB1NuqRh5SIrYH1+V9ZlJv9E
         BQhbdSuje1UEGomUVZy3sBoreZTo0n1gqY3KRSzjVtdaff39gmoTvm4iBVYe2/Ysef3b
         zcPbPDHCaFwcJ5tYfyV99VPOF8pTOYBRSDS842MqlLLctrPytfmbLRIgi2XOXkL8Lcbr
         qD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1DRYxM4S/B7SoxMDhNxSzKMNHFlAjuQUN144vOww2A=;
        b=SI4Aat377fJZb2WQBGQVu1YikqVM15vu4sB8IisPAi7k/KqJQ21fjddAx8n3i8Q0hX
         /nXj7kHTujn3x87fSoOFKl7hFc49yKuCU3q6gkodeLUCLDHRAq9OSRxi5rLC+koVPrvi
         jzu6sI2vV+m4Q58Rf7YZHeUoVxl7gWEZ+6pYg0qktyshyhB1JmT9dZ7QvNinGk3hEuBC
         ync8LRvUtK2ang50Us206rmYz4SOrMKgI0X/LfAhk2PW/Lt3hrNLfE4BW0y8FllwKx+z
         mwR3pFBjKyt2nn5gt0rtcKm75FIozCH2rRJO/gHiS3xuliuarbwnQWLhCcg8QbLsIrZs
         nVHg==
X-Gm-Message-State: APjAAAVXXtkIdvUX6xkVrbT44l9Rf5O46Wpyi3EGBsxHaBw32zXT8nE+
        8+fpO15l6kKQyeSZfOdDU7QFg7X0mA==
X-Google-Smtp-Source: APXvYqyqBD0hvTStxFBTJ8PSsP8JsP8y9JbdoOz6Z54aeKGRi1OhfciLK1A+yM7BTbCaJjLifJASfA==
X-Received: by 2002:a17:902:4222:: with SMTP id g31mr3254070pld.41.1565097006526;
        Tue, 06 Aug 2019 06:10:06 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7180:928a:153d:caa0:477e:f9fd])
        by smtp.gmail.com with ESMTPSA id v8sm73715371pgs.82.2019.08.06.06.10.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 06:10:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for IMX290 CMOS image sensor driver
Date:   Tue,  6 Aug 2019 18:39:38 +0530
Message-Id: <20190806130938.19916-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
References: <20190806130938.19916-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for Sony IMX290 CMOS image sensor driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d0ed735994a5..27e4c1f57b61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14669,6 +14669,14 @@ S:	Maintained
 F:	drivers/media/i2c/imx274.c
 F:	Documentation/devicetree/bindings/media/i2c/imx274.txt
 
+SONY IMX290 SENSOR DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-media@vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/imx290.c
+F:	Documentation/devicetree/bindings/media/i2c/imx290.txt
+
 SONY IMX319 SENSOR DRIVER
 M:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.17.1

