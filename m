Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7120C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D72B21019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 18:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqguwweG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfHQShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 14:37:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35389 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfHQShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 14:37:04 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so4824252pfd.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 11:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K+pJPk2iXl0LixGuiysFHZxmO1vjBGFGOdrJivWtPCQ=;
        b=dqguwweGv8m3jWuayl4ZIpq5unEXOopx/JAA/LfCxYiy9ROeW2F9g9c+65zQR5QPwB
         9CIN004auoeyYJTCT7vFNVgWqtJCaKHi3t/sSswuwQlv2+IOVxbQltyLVHe962wvKUnl
         JS2iIPVwDoaIkZ55RK7mxUwoOOLZxHpjnwrryQIcrznqxk7Ye1SdNSzfCqrI2mTtCi1C
         EKm3qhWNnQVYpGM61n/jCF3PYQcBnnyAfPOoOFFZK5UcM6Fm8/swH/zKlrhrqMenB9NG
         J3KtLdHMGMfVvdZUq1ikT1b8Eaf3EfuVQaaGP5Hqhfu1M83iWm2uOMVn/N8i8p0pyaIC
         GaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K+pJPk2iXl0LixGuiysFHZxmO1vjBGFGOdrJivWtPCQ=;
        b=FSHtYUzxSrH1swxEYCNvYedl2u5ASAESjQOkK1BzBxW4ZcwPNKYZWEl4Ny51VXiNLY
         5Y8Sp+UdvJWB9DkZzTbiPUjP3n/1WtvGjWm/uqUJ/LJZEIlLOII/OKj/rM1jlCPqWura
         AWktjQIEdc3bGo/oVkCRobVzavLDviRTiSliT0JJP90AoIb20Xojep1fyVWDO30/P1Tj
         yM1LjEoNmR56SkzlrGmVDbLJ9Acy5bJ6n59k8135IrhAJaV9fLqIs9X/6WH6KEOJ2KxD
         n+TuQeyVRFrwV9auL1k+P6aasaxbbZPemY/UFnC9uG6xLTYli1H3gNswo2QHGv2mwQ7R
         OpUA==
X-Gm-Message-State: APjAAAXy+tdOj36F/pdrnQu6xjYTylEjcBpATKbG9rzco+eV7Y4ZhRlN
        VsAIcuACmgGHTUpGBAVAG/MK
X-Google-Smtp-Source: APXvYqyNYDKZVgPbO6xvWKY8Qk0vt2+wG3ehY9XlYnpkjyxRyqxyasCLT5TPNa25fa8LpeGDa6KhLA==
X-Received: by 2002:a17:90a:2629:: with SMTP id l38mr13445995pje.71.1566067023939;
        Sat, 17 Aug 2019 11:37:03 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:909:4559:9185:a772:a21d:70ac])
        by smtp.gmail.com with ESMTPSA id 33sm8588640pgy.22.2019.08.17.11.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 11:37:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        fisher.cheng@bitmain.com, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/7] MAINTAINERS: Add entry for BM1880 SoC clock driver
Date:   Sun, 18 Aug 2019 00:06:12 +0530
Message-Id: <20190817183614.8429-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
References: <20190817183614.8429-1-manivannan.sadhasivam@linaro.org>
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
index 997a4f8fe88e..280defec35b2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1503,8 +1503,10 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

