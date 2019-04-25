Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684F0C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D53208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFrN8ifn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfDYIcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:32:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44503 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDYIcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 04:32:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id y12so8142203plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jIW32WrHBs99jVmzDwkmowyofrzG8/2LnuHeALQVAA0=;
        b=PFrN8ifnasv9JFgkqMxUdwY4XqcumWQ4tFtku3YIX7Z8Xw3gMjGdXebz+mGKwVe3mf
         uqSpHaV6X97Jexjs0XQuwfh4lPnDY/ZIoIY8NOMTj6txsQpC4YKAxw8PNYDR4UQR4hTz
         iLfRvmxeD1AosROYrBQhfuGldifCGsN+T7ZywERZ9II2lIfeeNjxkRqKorY5Ey9eG7jD
         8cv8Tjx32QphwlbVlbltaQKZxV5cYrozCgU9mKOBfHeCa/S8U1AkRLVKVDKbonGdR6Oy
         laSrH3cZYaKsWznCjnH3NYmvY00bF/ZJjJMu1tXB13Kb91C9hIaoB9eqY9ihRIWXScUQ
         hShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jIW32WrHBs99jVmzDwkmowyofrzG8/2LnuHeALQVAA0=;
        b=SR9t1vt2wkO88F+J2/y/POuIfHdlfu2kHYPhc+f881MvootGMI+NiulLDZBjW70IEf
         egi2amP7omLAmxlN7PQpO/vyzMFU+yuj7DtGNuAuuPuqq+BLIGWb1oLEchf2wczu6E4z
         eFGU3Ut2Om8fFYEoYD8/Huk+Jc5vNeSl7uDw/FiwZn7sFkuOgUw5tIoOU0yxhjn/blsR
         ipKWf+uMhSusUaI/J3cuB1Q8SEBUDk6eXKP5pzrUQkuYkIzNpjSKFx1HeI3hg/21BgYY
         SLFI5i+Cp/25HkPKS0/7M/eCZ3a0HowDUibB70fcbDrFsuoD2LTRaKixNs0neM0WeQYa
         RAYA==
X-Gm-Message-State: APjAAAUnQcec8GXaKxxcyL1/EQVmufI/5qYeH+/W/L+akwjCAu3/q1qr
        4eQPrgjA6VGkYctBXJs9vGOi
X-Google-Smtp-Source: APXvYqxkdrgKWWGciW0rcU7Nn5egx1GFUyCPlxx7V4v6adiNHKCBKP7mA2LEPBbxU9fgBYE2wjskrw==
X-Received: by 2002:a17:902:ab91:: with SMTP id f17mr39368241plr.151.1556181169837;
        Thu, 25 Apr 2019 01:32:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:81e:2691:7d48:1fca:4d86:743])
        by smtp.gmail.com with ESMTPSA id d69sm41765166pfg.24.2019.04.25.01.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 01:32:49 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, haitao.suo@bitmain.com,
        darren.tsao@bitmain.com, linux-gpio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] pinctrl: Rework Kconfig dependency for BM1880 pinctrl driver
Date:   Thu, 25 Apr 2019 14:02:24 +0530
Message-Id: <20190425083224.9762-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the BM1880 SoC pinctrl driver depend on COMPILE_TEST to get compiler
test coverage and also select this driver by default for ARCH_BITMAIN
platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pinctrl/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index c4ac4bf1e1e4..19d8af9a36a2 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -110,7 +110,8 @@ config PINCTRL_AMD
 
 config PINCTRL_BM1880
 	bool "Bitmain BM1880 Pinctrl driver"
-	depends on ARCH_BITMAIN
+	depends on OF && (ARCH_BITMAIN || COMPILE_TEST)
+	default ARCH_BITMAIN
 	select PINMUX
 	help
 	  Pinctrl driver for Bitmain BM1880 SoC.
-- 
2.17.1

