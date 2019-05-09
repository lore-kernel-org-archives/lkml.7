Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B27C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EEFD21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 20:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdhFSjIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfEIUaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 16:30:13 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:36003 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfEIUaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 16:30:11 -0400
Received: by mail-yw1-f66.google.com with SMTP id q185so2945339ywe.3;
        Thu, 09 May 2019 13:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TA7//dX4vtBRwfNw92xuXPb7M1etmOxtq99BxrnfvNg=;
        b=UdhFSjIjYPEQz069K1zUOUYpxwVXhfQpOnt8uw/FEn3ACH1y0XsqcFJq7hoikXnIN5
         7pHFpibEtzxazXcGCsvLOZaj2xpavBnlJidIg/GH9UDLSx9d/2nc1pFAxDX4LZP7z2E3
         aWsVgKYbbwktnAXc1/vvlntIwpaLUn0SZqYV+zUmm5Kp7AdDXuXPpZWerRZWBabIuucj
         noHlbC60V6XwuQlSTQx8M603v4bl00GDk9lVlGWT8UJw3OcNmYvV7Orj0Fa3w2IvPQFh
         x6dd0pLQT2cJqtMHPn4xxx78/cx6yDbRMVIK3Gb9NtR0mxPF8fY7rupO/tfaYd0AYPl1
         GGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TA7//dX4vtBRwfNw92xuXPb7M1etmOxtq99BxrnfvNg=;
        b=l1/kfcC4eYqL7cvLu7pGvKdbZaCPgV7NRAjkE8fuknbhrk2JPV5AehY3HaM/V48aYE
         qmRAjoCFcR9w8B/u4fmuaW/FT/hYt2n43QuFq90bYXN91HEo8RqQ+ltvbCF4rNilDeVi
         vFvl8LDq3vEj6wQtwCNQmD+rvF2cLIVsDfdUXM7co/D/6EB2RPVnvEVEENZM6TIeLK5j
         hmRYr1JLnTKEjuENnXVWVENAjImxvjII6/4Mn6TAMKkTOzZN4dyx1w2QM0SWhxrA5/Sv
         NskIXDjVWb4QyUaYl6KTIoEKP1n1BiAfTPx+sfQrW5vRpHGZe+Xhor+RFePe0r8/ElYo
         9Ccg==
X-Gm-Message-State: APjAAAUwFJvPszSJgPuvbYFezl+/d0Q3KgUrs98aNkh8nrGp4SD5Ag6z
        1d/WpIWYa/N1zNrl8075j9Q=
X-Google-Smtp-Source: APXvYqya9CY9+vVMA3jwse8sBZtcJuBFPP+dj9DSeNP6zoCn9RUV57N6dmyMltfl9TGSA04reMoPfA==
X-Received: by 2002:a81:9b8d:: with SMTP id s135mr3469060ywg.481.1557433810958;
        Thu, 09 May 2019 13:30:10 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id u6sm896150ywl.71.2019.05.09.13.30.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 13:30:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        bcm-kernel-feedback-list@broadcom.com, wahrenst@gmx.net,
        eric@anholt.net, stefan.wahren@i2se.com
Subject: [PATCH 2/2] clk: bcm: Allow CLK_BCM2835 for ARCH_BRCMSTB
Date:   Thu,  9 May 2019 13:29:56 -0700
Message-Id: <20190509202956.6320-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509202956.6320-1-f.fainelli@gmail.com>
References: <20190509202956.6320-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_BRCMSTB needs to use the BCM2835 clock driver for chips like
BCM7211 which adopted that clock controller, make that possible and the
driver default to be enabled for ARCH_BRCMSTB.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/clk/bcm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/bcm/Kconfig b/drivers/clk/bcm/Kconfig
index 0b873e23f128..0eb281d597fc 100644
--- a/drivers/clk/bcm/Kconfig
+++ b/drivers/clk/bcm/Kconfig
@@ -1,8 +1,8 @@
 config CLK_BCM2835
 	bool "Broadcom BCM2835 clock support"
-	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
 	depends on COMMON_CLK
-	default ARCH_BCM2835
+	default ARCH_BCM2835 || ARCH_BRCMSTB
 	help
 	  Enable common clock framework support for Broadcom BCM2835
 	  SoCs.
-- 
2.17.1

