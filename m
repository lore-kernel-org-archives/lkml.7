Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E34BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AAF20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f/5+htOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfEFMF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:05:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37233 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:05:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6so6369521pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 05:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HNEnwk6bTyI+OdxTHxmPibg++VUvhYqw1S30xXcVZwM=;
        b=f/5+htOyvjkdDYEDCOaeUK7pb2MKXpEDjDcB9ympoEJwxl8lLpuo+/Do9n529BCo7G
         fy3eB+/l9rwfBf35NTTLyd4TCsrhybdKdrUmOODARQue/Kl8V9U1fbSn2sLxnTzw7s3e
         rxvR+cKHuYXhsWa76q/R17RMzgAGDDZba8esw+/oste9ySRMomylMMQfpYM+Kb7ZMBWH
         HWPlkCsTmWxd7DTrh9JACEnS1o0WoP/ds6ehK3ObZBcW0Rd1oi++HcOT5Z10RlWrxV0b
         t/Y/JBqtVTOHxVRFjsKFuthtsgL1WcoBvbOg6muXU6Ikd7MmXAftmvnsbp5YbwZnBIcV
         KXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HNEnwk6bTyI+OdxTHxmPibg++VUvhYqw1S30xXcVZwM=;
        b=BUSZm6kzN5xgp6EttNVwON/oZI3fwBlcFaGqj84nXKlCYQgD+QslHztLmwdq0rBsYi
         g5oX8wnt5ecox23swUrzWs8zB4weHvxBzbpUWow1upC6lIHcmNjTPA1RX66D9CK6xIyb
         GQo8Tz2FVcdI+JMeQSiT4hqGyWi+qwvf0dvLpT2eRepWxjIURACQ/c74yoOcbEAmMan2
         Yd8pmt85kxrMss4RsQ2EmZZyAwPSxzDDp8z23r0LCV6/KgEQoGpHJ3PNif/A50+VMcea
         iQF5cK69kmUkbCK7APoYJkA8mC/wQJOHIgccwD278YS/Effee5kjQaIalp9Cr67CRahU
         1oxQ==
X-Gm-Message-State: APjAAAXK+TfL1srw8vMkNIGx3et/ytXIORfgNLdh/t8Dsfg0ejGz5/MW
        P3SuEAl/zFHfGIGzj/rZlVNU
X-Google-Smtp-Source: APXvYqwFs/Zc/eWEWDAECt5UzKf54ZygzFhrTr+07TNz+PDBlMsTsn8Aof9hCZQDwHTJxr0qMFJQeQ==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr30660274pgd.91.1557144325309;
        Mon, 06 May 2019 05:05:25 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id q17sm26482318pfi.185.2019.05.06.05.05.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 05:05:24 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
Date:   Mon,  6 May 2019 17:34:57 +0530
Message-Id: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SPI0 and SPI4 exposed on the Low and High speed expansion
connectors of Rock960.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 12285c51cceb..7498344d4a73 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -114,6 +114,18 @@
 	};
 };
 
+&spi0 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
+
+&spi4 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "otg";
 };
-- 
2.17.1

