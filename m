Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F03C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D800420866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fNKVlIMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfFNOce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:32:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43304 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbfFNOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:32:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so2756547wru.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y/TWjdw0CHDqXafiiLtO/KaC5YS+exiuXkBCJaSMnJ0=;
        b=fNKVlIMY4FVsfPdnLgdEX9qrJHDL9W1MLV53BBVrNycT0XTcFH3R+iJUw1KTXyqQKQ
         RpuwnsFdpcu/EJPNRkQLQcnQtEhSVke9n0IjKB1HV96d01l8P74c39MU/7u6XERfBviU
         hSSOlqLIH7+912JAkZadGNbjg7OOmOyBQH55FLVWO6o9YmEr+qXVcfTXPAfz13DROwHZ
         VXPLZ8Y50llcNbtAkC+PaRyo8CLmKscotPHl0EB8xXV/F2eeKf7Pt2U/1zozhMhE5JDd
         qKohVwLz7OI2tDYb7wcek5VBiQw7Lv2UR9OBGNQ3BxGvDY2ZmSR663XMqQbGzCOcHI0P
         7tFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y/TWjdw0CHDqXafiiLtO/KaC5YS+exiuXkBCJaSMnJ0=;
        b=DQKtArV5QFmieKMBq/6Uc1YxV7m1c5FqiRoun2hhnB5n7N6aNC/4PvDHqUQ0H1zy5/
         oBgjSVzjjUA2hjxTGBFI9KcK1cu6J1mWZg9/QJKKqkUNa8afyXU+BBieiRulqbQirr7b
         /p7nmTxoqQlcMIIEn6h3501Ahvp3MS+mgzdCmxMkodUczDgU1tlpLKKCMxvECoL3okZ1
         AhFbfBiWaJm6nHfc/IZ8EJiJ1ZiY7OX2U2uy7pwwXm25qkBdCd8wmNoTA505erXKj8GJ
         dkEnHMU7gb0ZC6be9CEx08oaU2C7H9mgPtugr2RgcCuwYVqgUMcLgf5VVYU1NhbOYqf4
         n/tw==
X-Gm-Message-State: APjAAAXBVqjAlKnos+BAt4jMJdlw/QvLehm0azUWMplgBbiKk9UlJtgD
        gVfjPLGaRhMHfpCay18zHwzXrA==
X-Google-Smtp-Source: APXvYqygclMsfluC06vgwXwmnjmCnSmSi+jE+5OTpoIaQEVrJpy4dgAe2LSTakf7AGY/Bq0h+3sRrQ==
X-Received: by 2002:a5d:4a0b:: with SMTP id m11mr16965069wrq.251.1560522748105;
        Fri, 14 Jun 2019 07:32:28 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t6sm4738007wmb.29.2019.06.14.07.32.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 07:32:27 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] nvmem: Broaden the selection of NVMEM_SNVS_LPGPR
Date:   Fri, 14 Jun 2019 15:32:20 +0100
Message-Id: <20190614143221.32035-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
References: <20190614143221.32035-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

The SNVS LPGR IP block is also found on other i.MX SoCs that
are not covered by the current SOC_IMX6 || SOC_IMX7D logic.

One example is the i.MX7ULP.

To avoid keep expanding the SoC logic selection, make it broader
by using the more generic ARCH_MXC symbol instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 82a07c24e1db..96a8aedf1a9a 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -194,7 +194,7 @@ config MESON_MX_EFUSE
 
 config NVMEM_SNVS_LPGPR
 	tristate "Support for Low Power General Purpose Register"
-	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  This is a driver for Low Power General Purpose Register (LPGPR) available on
 	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
-- 
2.21.0

