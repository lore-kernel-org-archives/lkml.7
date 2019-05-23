Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E5CC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9422089E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 00:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxiHEwBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfEWAPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 20:15:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37392 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfEWAPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 20:15:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id o7so4710856qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 17:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9tvPRW8q3fH2QA6w9+3xF+YK1LShTnqzRo0EyBQVnwg=;
        b=mxiHEwBzBxx2KsYR/jHabcHJWmxH/5k5mSsTs87XouL24BqclOWwNhUpoTE+dTOCU4
         FbqLFyAoRi0le5m9A80A5vXc4UF/MsS5f3p4QsyKi7FihI5nb+Tv+qUzw0a0DaYzrKci
         c9HXekpVvly8eR0X0GC6r7HF7oUTfB56DA5TlbbBVEY8BcIWoRvIyorsLfX2t4C3yRae
         U2qAa8vV1RtaoEaFmTxES0WLpbMDwZl4RyZU5uylwd2/0lycRsduOck9+VhTypNZm2Em
         nL87uE+fHuU4gAYj47yEBBy2CrHnAHaUMtk6qYVZlNzVM/8oa/h0485Cp3baD9XxI+NH
         LIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9tvPRW8q3fH2QA6w9+3xF+YK1LShTnqzRo0EyBQVnwg=;
        b=Ckhd+WYs2e3r1ruMlqKQFlUZiHC6JMbWIbnXUTTPSJHFcHKgorgkL8s0v7a5RFKf6i
         XQlTtWe2D5EHaom2NBKakrbBGDaNrtB1hau8owAJQuwqIDs8XYzrasSz8afQJrM/Omph
         axARAPik3aHWcTcJtlRcp1be28Mvlhf26imV+hmhd3fn0Eha5Vlbz14Cszywys8vhGFe
         4Yb8jOcK1lm+X8tSdfuivu0OlVmcGUJNdnqWD928KsiS70WSg+pZSSiZlA1+E3c3VqVQ
         XsZKGZbIaWcFprMalYwi7p/s5iveTY5286qNSJdE49v+GnkZ0JXhV698kNV7OelwK1As
         itVg==
X-Gm-Message-State: APjAAAWITtPSZpO3LiuCfkwX/m1/IwHMLqMQfk8Fa6RvGNGXEjaDEaI3
        /1snoES9TznsFfnWc6IwPMY=
X-Google-Smtp-Source: APXvYqy4Q6YnpFFnALKCH8RY1ik8CsFV6qOKmGx8q0FW6M1IJ7PqT4cHLYPruwsW+XfQEFg8OPwbGw==
X-Received: by 2002:aed:3c2e:: with SMTP id t43mr66235757qte.39.1558570504683;
        Wed, 22 May 2019 17:15:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:482:3c8:56cb:1049:60d2:137b])
        by smtp.gmail.com with ESMTPSA id u46sm16798663qtu.57.2019.05.22.17.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 17:15:03 -0700 (PDT)
From:   Fabio Estevam <festevam@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, shawnguo@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] nvmem: Broaden the selection of NVMEM_SNVS_LPGPR
Date:   Wed, 22 May 2019 21:15:02 -0300
Message-Id: <20190523001502.20105-1-festevam@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SNVS LPGR IP block is also found on other i.MX SoCs that
are not covered by the current SOC_IMX6 || SOC_IMX7D logic.

One example is the i.MX7ULP.

To avoid keep expanding the SoC logic selection, make it broader
by using the more generic ARCH_MXC symbol instead.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 drivers/nvmem/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index afa4335e0a20..700c262a117c 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -188,7 +188,7 @@ config MESON_MX_EFUSE
 
 config NVMEM_SNVS_LPGPR
 	tristate "Support for Low Power General Purpose Register"
-	depends on SOC_IMX6 || SOC_IMX7D || COMPILE_TEST
+	depends on ARCH_MXC || COMPILE_TEST
 	help
 	  This is a driver for Low Power General Purpose Register (LPGPR) available on
 	  i.MX6 and i.MX7 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
-- 
2.17.1

