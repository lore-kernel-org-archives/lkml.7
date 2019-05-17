Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B3AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9151720879
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 04:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIDpDUlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfEQEGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 00:06:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36218 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfEQEGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 00:06:40 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so2632235pgb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 21:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YUNM61SbavGzuv3ZLziasFZlDP0wZTIm2rUlcIBaEc4=;
        b=yIDpDUlKX448aC7IJW7/WLegcIQtNfcka6iCLmWv+QC8U8/MdB2bGFG1VyVS4kpSpw
         /BO6E+als7fmAJI30vpohsn/1kZAGU+w8hBEM8/jPi5X6BWJckMO70rGA3WR0/ysroC7
         +Bqe/diruvyW7cYtdcSbqqvjegR3HmFUmeZFKadkyKGTUoOV/xU7JeqKRPkOLKtLavDV
         5aZumrHxYHdRzO67Oxw1vY9zTqo6oT3XnyuBePyIawE6U4y0cIBf9hJGqEM3AM+Byhcw
         k5ZiNGp9FBVlgawHroO+EHAMFT6unmCgJUCQM0P2TTZUsJvBcsVZ2N/auobicxfEMTaV
         GvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YUNM61SbavGzuv3ZLziasFZlDP0wZTIm2rUlcIBaEc4=;
        b=QS/c+VV0FlHYujVheiVgLp4O6xPRGheGSW/P0srVui8GOX7NBKLYxpPTo5TuCw206m
         Nlw1ZITKN0UrKH7X3NYMTw4Qcg5jLv+elqYkcDk29O/NNKZioEdprThSi9J0J4tYtvCw
         8iRjqoBDrbpKLg7kpicHfwxODwZE1UJIPnlDgOVOvEn0t8K9K+GMs2MinSK7eJAi9BPx
         V4CNjkj8zv29y/FE6Pubgo8dFbM1KTElKa9uJsG32GCbqWRTAs5tyoJpPSenfoJZ9yGH
         V9n3a8b0DtCv20B3K3fvGAvkCjjh6CvCw6QkRmxLw8KoN80aUuXtfG7Qvqzslr7UIqlF
         K+ew==
X-Gm-Message-State: APjAAAUZ33PpmEhrcXZT8muDm4Q2KdAjelVx1FQsThIIvzF+RQFBxUie
        LPQmDel9f2yk7a1CU9iye1Nh89jRAA==
X-Google-Smtp-Source: APXvYqz7kfN3pi13qegdwYdYgGYpAj2q8K5JcWDOsEo7Y6jybA2FcawPknW8Ht4RsODvS+LMWZrI0Q==
X-Received: by 2002:a62:bd0e:: with SMTP id a14mr38891835pff.44.1558065999551;
        Thu, 16 May 2019 21:06:39 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6390:5018:b478:7b0e:49e:16a3])
        by smtp.gmail.com with ESMTPSA id d3sm8628927pfn.113.2019.05.16.21.06.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 21:06:39 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 1/2] arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
Date:   Fri, 17 May 2019 09:36:24 +0530
Message-Id: <20190517040625.14607-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SPI0 and SPI4 exposed on the Low and High speed expansion
connectors of Rock960.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---

Changes in v2:

* Dropped the label property since it is not part of SPI binding

 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 12285c51cceb..c624b4e73129 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -114,6 +114,16 @@
 	};
 };
 
+&spi0 {
+	/* On Low speed expansion (LS-SPI0) */
+	status = "okay";
+};
+
+&spi4 {
+	/* On High speed expansion (HS-SPI1) */
+	status = "okay";
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "otg";
 };
-- 
2.17.1

