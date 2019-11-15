Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FAC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4947920733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 22:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSxkLjju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfKOWeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:34:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33813 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfKOWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 17:33:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id h13so5643028plr.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t2lfkYvCG1qZ4zH71UsZZVKevqEX7pyTohdYU3/dDg=;
        b=TSxkLjjusnWyOxYQuwJ0yeo2qVuacsTryAzYn0nABmfZ+giChdSbiAlTILiu0av+QY
         jkWKBo4DLgZtHrpz+tdF+VlAgQsfA3OdIm5fhLhv9vSP8EAGtXSK+OSQOTBRtAQcct2g
         QR0Sglw0sLDa8vkUzDJ7iwCPgDCjEiKh+VvE3qSkwQesXq0iaKdptZvJJxiDYbc1N+j4
         xaT/k5+AjeJLF9P+ANrQoOWHWCa16LHqeI0KGWEjIvKKArK5TYv/F94+FbsrOhMSzjwN
         nH0qNcPvGaUtYtZ3JDYIjIjaFjXf66XE2kFG4WMS8hUVt2ONxPzvC68OWC0+AqOf4NGA
         wEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t2lfkYvCG1qZ4zH71UsZZVKevqEX7pyTohdYU3/dDg=;
        b=e5/IJYSo6re7kNarFud4StX8+Qf4bIfJ6nzSObVXG+MlARCAcmUhpuw4VRiu22Rle6
         Cse68n+oiqM54jGGHkj1Kv+/eivngKf39qGuAX7s/3+GRuMvrK7dPy1N1MfebwNYSspA
         oh3mix9JrK2PWjOKb6H34KzF5aV0XrziSctN+I0Nz2EPnQSR5XOkY4rEGfgadWe2824X
         b/usc1mkxrPQPajSrM8MOxn84IjwzxznX7/1puoq5eyqpixApyZ31X1D1NOwdyVNCh9r
         4UyLpoQLq5czUXk4cspkbjASnfWuNFFA4i7hMN6FvMEC9PHTyukyb2Up4MDIqQO80K60
         CEzg==
X-Gm-Message-State: APjAAAUHP9AltWVEDNsgmqxus1PIdUTY/p8BbqBHspp97Q+Ar+ExtOcn
        werfWcrmMrGTpnyOta+dO2EB5Q==
X-Google-Smtp-Source: APXvYqyCcGnCxpjNDXnOlQ5PDU1yc/iIX1FpvG9yax85c887grRTZSpLNG9/CAqWEFTR/yqC0+Ui1Q==
X-Received: by 2002:a17:902:9a47:: with SMTP id x7mr3791386plv.84.1573857238838;
        Fri, 15 Nov 2019 14:33:58 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m15sm11699724pfh.19.2019.11.15.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 14:33:58 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [stable 4.19+][PATCH 02/20] ARM: dts: stm32: relax qspi pins slew-rate for stm32mp157
Date:   Fri, 15 Nov 2019 15:33:38 -0700
Message-Id: <20191115223356.27675-2-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115223356.27675-1-mathieu.poirier@linaro.org>
References: <20191115223356.27675-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

commit 86ec2e1739aa1d6565888b4b2059fa47354e1a89 upstream

Relax qspi pins slew-rate to minimize peak currents.

Fixes: 844030057339 ("ARM: dts: stm32: add flash nor support on stm32mp157c eval board")

Link: https://lore.kernel.org/r/20191025130122.11407-1-alexandre.torgue@st.com
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
Signed-off-by: Olof Johansson <olof@lixom.net>
Cc: stable <stable@vger.kernel.org> # 4.19+
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index c4851271e810..d9dce0c804e1 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -290,13 +290,13 @@
 						 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
 					bias-disable;
 					drive-push-pull;
-					slew-rate = <3>;
+					slew-rate = <1>;
 				};
 				pins2 {
 					pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
 					bias-pull-up;
 					drive-push-pull;
-					slew-rate = <3>;
+					slew-rate = <1>;
 				};
 			};
 
@@ -308,13 +308,13 @@
 						 <STM32_PINMUX('G', 7, AF11)>; /* QSPI_BK2_IO3 */
 					bias-disable;
 					drive-push-pull;
-					slew-rate = <3>;
+					slew-rate = <1>;
 				};
 				pins2 {
 					pinmux = <STM32_PINMUX('C', 0, AF10)>; /* QSPI_BK2_NCS */
 					bias-pull-up;
 					drive-push-pull;
-					slew-rate = <3>;
+					slew-rate = <1>;
 				};
 			};
 
-- 
2.17.1

