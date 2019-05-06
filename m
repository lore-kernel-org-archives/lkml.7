Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED17C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7320830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QZmNCGD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfEFMFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:05:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33685 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbfEFMFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:05:30 -0400
Received: by mail-pl1-f196.google.com with SMTP id y3so6284019plp.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 05:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OlDYrQagoRRgIUanTTiaH0xI7ydpH4Phsvkhb6Hldvk=;
        b=QZmNCGD8utu44MaRa3SN0Q0GcNmFA99KuHhZxTOd2VZMnVKc59yjcdQ/pRtA57LPED
         tnD9fTyyuHB439p746gDr0wxz8EYTiLTZyxVPqEqRVXl0aJttq/xKBHLPNGsJI94+UTw
         oRNDEWKsskTZyOpdFjppaLtL/JmS/Suj2k7T9nGi1PBfbDv3eKtg7vQ9JLDXK8qwmFxn
         tlC5BvDMHGqYwksGbUV9PT6PFNgD3ag1yScw2DFJHR+QLPcEgaj/9/PZ9r3gugaKhoi6
         j7jgIZJPDbotWYsn3ZwlWCyxp2A96hsPxfVvqg0zGFR0QFOTc77kRJb/TL5X7ASQDUl+
         eRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlDYrQagoRRgIUanTTiaH0xI7ydpH4Phsvkhb6Hldvk=;
        b=Syt/qYKaV5IehZMFZs91lAagVODBOQOfgLT6k+NHvWLwPbM2x+wZtu7P7i3SvKsJSV
         q7w80XTNNJ2y0Igu+5QuTqHUyUmCaSxWZ8gjUVbN3bGAdWGHkh4ZxYwwP4wRGJPmCVBb
         TthZdwT57UoBi+EePm+dJDt7HXUyeyYwM6Pvr28dBIsRUIw4/FMQznWuAxklpV4xYa3q
         ltgHyluXNStJtOQs1cRUoEFhqtJlFylTABUuonw+pqvAN6xSAsR4rTLFu0RWt13na/Qp
         8sE+neVTOPjwhE7+kspEq3OYfiojOD5GIB6lqWJb4IMgFrs8toUJdMiPpgkAKKwOBkEt
         kNoA==
X-Gm-Message-State: APjAAAXJF0dOHVOlWXcq9Tnou3HbEr6XFVVrBJoUQ1AjPo8gUrSg7+c4
        hKgXES2nIrEyAQuyQbALIFxM
X-Google-Smtp-Source: APXvYqxAN92qtTThzTYGnaJj3GjkLg+pVGzJHyzT5l3HLI6BdbkS+ocPCrKkEwXf1Pjbn44N2iNjcg==
X-Received: by 2002:a17:902:183:: with SMTP id b3mr31792924plb.267.1557144330073;
        Mon, 06 May 2019 05:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:611b:55a4:e119:3b84:2d86:5b07])
        by smtp.gmail.com with ESMTPSA id q17sm26482318pfi.185.2019.05.06.05.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 05:05:29 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: Enable SPI1 on Ficus
Date:   Mon,  6 May 2019 17:34:58 +0530
Message-Id: <20190506120458.25842-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
References: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SPI1 exposed on both Low and High speed expansion connectors
of Ficus. SPI1 has 3 different chip selects wired as below:

CS0 - Serial Flash (unpopulated)
CS1 - Low Speed expansion
CS2 - High Speed expansion

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
index 027d428917b8..9baa378fc770 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
@@ -146,6 +146,12 @@
 	};
 };
 
+&spi1 {
+	/* On both Low speed and High speed expansion */
+	cs-gpios = <0>, <&gpio4 6 0>, <&gpio4 7 0>;
+	status = "okay";
+};
+
 &usbdrd_dwc3_0 {
 	dr_mode = "host";
 };
-- 
2.17.1

