Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861FBC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CA22189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EiT8BWbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfGCTDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:03:02 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44549 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfGCTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:03:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so1678726pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1DRYxM4S/B7SoxMDhNxSzKMNHFlAjuQUN144vOww2A=;
        b=EiT8BWbl+xHvb7JFvpcjaMBfzfBwNgp5IyVQl4JjzJ7b6sxwpmksLvde9vYcrpQreD
         sRJqJbjhYOYJBEZompfAK7sofYrjSgbr3fdLQJ2n4MyEJ/tNP4N8IInWdCHMZ7wjDu6g
         ofrPqbN6sZFxyvHDXBpRnX31lju59FJeiu5ao9NWIoOajR3+rnbMoO9tb6S1+cVNT5WK
         HOUWSNdjAjNLEk8ssEXpuoRe33pQouijP6A8ueGkJJ7KeJNAmfDcfhq3SmmrXvFM0rIE
         MWHD64RlAdRvOL/6ylNB8a9b9WZENN2Zn6wKnLQjbEys6SQJHq03eJP2+jKrOWhuJcPU
         MAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1DRYxM4S/B7SoxMDhNxSzKMNHFlAjuQUN144vOww2A=;
        b=HI6lG4raxXdAjPsI0kb/kYVAnRVb4SQHrKYMUcrm8OSrn5wjgzMDkz2YPQQkWm9Brz
         iOSBe685sGyXzedGJ5kXypFfYcfC35bvTOBsJvQHOpwhKjz0yyPvf2THJg6CPPPrOp2R
         Kfn3i0wGaeWidFeCnxQed6qX8wnva4oy0VQNA+L93SDy1DLj78qLRZlQctsA7UBqTgXP
         xUBWPiDeQuOe/XjVW7LWO77Tu+mBc90tcxAEA6X0eIbGBTLOreX25jnS6eNaFpa8rgIi
         qwGEgCL1GxtEWUZF6epYtKZBQqo7bYESRnZ5I6IkeN0ZHYll2uvy7EZFQBGiV/RW9T9J
         TO1Q==
X-Gm-Message-State: APjAAAWePkFMtGnrj0Rn9pVIVCT8e2IezxuYpAnFo0NyYYGPOIW/vFhy
        yE6oWJHqmZ2ubnIFJZeqs1Rc
X-Google-Smtp-Source: APXvYqy8mtloT40dRnY/gaVB9FpkscYftIb1iPR1fDiwsvm8UFmgRrDb0Wh22kBTCyQyQyviBDgDXw==
X-Received: by 2002:a63:d04e:: with SMTP id s14mr13153497pgi.189.1562180579800;
        Wed, 03 Jul 2019 12:02:59 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:117:d72f:1d34:d0bb:bb4e:3065])
        by smtp.gmail.com with ESMTPSA id j14sm3631503pfn.120.2019.07.03.12.02.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 12:02:59 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mchehab@kernel.org, robh+dt@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] MAINTAINERS: Add entry for IMX290 CMOS image sensor driver
Date:   Thu,  4 Jul 2019 00:32:30 +0530
Message-Id: <20190703190230.12392-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
References: <20190703190230.12392-1-manivannan.sadhasivam@linaro.org>
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

