Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01605C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B43C6216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgcBl8Sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392626AbfETRBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:01:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37452 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388204AbfETRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:01:39 -0400
Received: by mail-io1-f67.google.com with SMTP id u2so11621345ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6v5cZ4d3IbzzHyX9tB5SggAe9a0MLVJDqe4K+VrolY=;
        b=DgcBl8Smh89XruihvIIqo2/jwlRNXKwzhoakXmLzoUDPce90oG/GyzQ8l/jtA2OL0i
         SEXXSDe8NSrl1QM7MqUwkOtgDOh2Gr66AcXniCOv8ZqSJbDbxRvzXncS4+WdSFomASNH
         WfY30ET7xT7NYiS1Z1z8P77Zabz6rKiUmME9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x6v5cZ4d3IbzzHyX9tB5SggAe9a0MLVJDqe4K+VrolY=;
        b=t7v3QB3NOvgufO8covXVxBNRhdNesRp34VwzUka5FEbo8ZLcPH0uqzd1rAUPKScbVF
         dbCaJFPasjRAUbsDFQvNGiP1LEJ1tX+c3QBPi9sXu6KFjUGu5QVIJAFOrhoFHntkLioV
         uwk65oCEMHh4mOacsnGPPSHA/ADj5GvPO1a8p00njWnCrDFRvnYlTQU+QK4NhOY/ibfU
         KVtm+ZsrJ6LgWeJzT6ILifd2YdblGBK34/8j+6NBa8D1w2+U+xTuCsj2uB4glKsKC5/j
         DtfCxFOk6Fe5jNCf9LtFXDd594Qmm3r7MyLgkrv+RSfUii99pENsNgxDxVSOrtb6ktJV
         XnoQ==
X-Gm-Message-State: APjAAAWGqm/J551rFtQtMDIVqsbjN4Ykk5g6G5GvmZ7zHbT8gYCbFl9I
        jjS+5QtgQbSO29vaAVzKBKHd2Q==
X-Google-Smtp-Source: APXvYqy0W2gpclxj4ZGsAs2T9LwfcoVY4dorBvuLBx7NxPHNi4Rs1l+AN5UkFsEt4Xy4HrBvwIlWAw==
X-Received: by 2002:a6b:2c94:: with SMTP id s142mr25278871ios.302.1558371699238;
        Mon, 20 May 2019 10:01:39 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v202sm25015itb.38.2019.05.20.10.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:01:38 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] ARM: dts: rockchip: Limit GPU frequency on veyron mickey to 300 MHz when the CPU gets very hot
Date:   Mon, 20 May 2019 10:01:31 -0700
Message-Id: <20190520170132.91571-1-mka@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On rk3288 the CPU and GPU temperatures are correlated. Limit the GPU
frequency on veyron mickey to 300 MHz for CPU temperatures >= 85°C.

This matches the configuration of the downstream Chrome OS 3.14 kernel,
the 'official' kernel for mickey.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Note: this patch depends on "ARM: dts: rockchip: Add #cooling-cells
entry for rk3288 GPU" (https://lore.kernel.org/patchwork/patch/1075005/)
---
 arch/arm/boot/dts/rk3288-veyron-mickey.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-mickey.dts b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
index d889ab3c8235..f118d92a49d0 100644
--- a/arch/arm/boot/dts/rk3288-veyron-mickey.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-mickey.dts
@@ -125,6 +125,12 @@
 					 <&cpu2 8 THERMAL_NO_LIMIT>,
 					 <&cpu3 8 THERMAL_NO_LIMIT>;
 		};
+
+		/* At very hot, don't let GPU go over 300 MHz */
+		cpu_very_hot_limit_gpu {
+			trip = <&cpu_alert_very_hot>;
+			cooling-device = <&gpu 2 2>;
+		};
 	};
 };
 
-- 
2.21.0.1020.gf2820cf01a-goog

