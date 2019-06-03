Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191AC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC1B26E13
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlCcbZXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfFCTE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:04:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46513 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfFCTEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:04:23 -0400
Received: by mail-lf1-f66.google.com with SMTP id l26so14429595lfh.13;
        Mon, 03 Jun 2019 12:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLtUN7lXG9KPhRHs985aJMRbWTp9lCvBb94mMbrLpok=;
        b=XlCcbZXoDuvKN6jiSsX72oFNR8QupD/HNRosq4Y1f42OjPcCXPnpw6+y9nClElj1Kk
         XnS7flmeGNWwSVFC8m1+NLTmDXlW2Xj+1w6nHcUsyA2SlHfVyJJ77fyZdJuJTqg+81EJ
         j45t2f6omx2R9zlFldSPQfrrRG1zkpiLzc1u8onUiPR4QSLHZyR6YV+HniHdlF3kooUz
         G80mCs2PdTbe37DWkbvPiU/pURVC3f/G7aZVPtDiZXHRWJrpAFY35yf0otDPR1wu5aLn
         qhoFkLtJIY8U9omraXC3+B+utyF0G6aS9xPi4my1bpCJSxwGZToDkklkDMy4hXlrM+WX
         dDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLtUN7lXG9KPhRHs985aJMRbWTp9lCvBb94mMbrLpok=;
        b=G0iVIRjR0ih39/mJ0d47pnpD7g+KTaxnVeKCYOqNcWPw9IogWhTiUb9cwY14FO61ai
         x/pxmbymqRxBDRPxF6Bo2xYTKRV43wUNw3lSv+m9kxE+Z/aWAkjFlcFlteqC4oyne9Vr
         RjFtincIeZqiSc/VEg4Tm5P/lfoxIWc/hKOYLzroNiSiDmNWv/Pb9GsOrSqIMi9w09XI
         nfk6g0pIZ6F6es+YSegT/0qhIilmp99tTFYa8Maq5ESG7KX3aVhs9b3MzsIttw1fFO6m
         4UYOfgrgKRk/vgulfxwTjx1Sz0bjVB52e/vPnwlgL9QpZEKnT5qXBX/qx3xM0fw6KjxY
         ijJg==
X-Gm-Message-State: APjAAAVJm95D5gPBTcPoRPHE+oDf3d5ys80ZaBJ6nOSbbn32uKxe0Hcp
        X0+y+ynAkrzwkljhpTof5Jg=
X-Google-Smtp-Source: APXvYqyIrpQTRMo2iHa9+63PmcTehopN8Jdz6wy41nwW1tr4mbaxMGxsc4Rw1NYjC9m5Vhg3GaCzXw==
X-Received: by 2002:ac2:4565:: with SMTP id k5mr11068824lfm.170.1559588662180;
        Mon, 03 Jun 2019 12:04:22 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id l22sm2768805ljb.39.2019.06.03.12.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 12:04:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] clocksource/drivers/tegra: Support COMPILE_TEST universally
Date:   Mon,  3 Jun 2019 21:59:46 +0300
Message-Id: <20190603185948.30438-9-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603185948.30438-1-digetx@gmail.com>
References: <20190603185948.30438-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove build dependency on ARM for compile-testing to allow non-arch
specific build-bots (like Intel's test robot) to compile the driver and
report about problems.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3300739edce4..d17a347e813a 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -140,7 +140,7 @@ config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
 	select TIMER_OF
-	depends on ARM || ARM64
+	depends on ARCH_TEGRA || COMPILE_TEST
 	help
 	  Enables support for the Tegra driver.
 
-- 
2.21.0

