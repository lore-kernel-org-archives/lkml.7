Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1238EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE5A22BEF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUDfHT3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfGZNZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:25:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41610 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGZNZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:42 -0400
Received: by mail-pf1-f193.google.com with SMTP id m30so24543931pff.8;
        Fri, 26 Jul 2019 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XnwQtA++4ZLQs18Zi/kVWI3WT0kdxj4T2Lu+EaH+lNM=;
        b=EUDfHT3Y1h+g5qNNasOMRbGs4FROTTau5miuZF1wBpoiCwIxlfrvi6feHwz+MTe7yf
         zXyLaRMXduj9kqj1QWbGuzaDVllBTUprvYCfp7LUt39JcqNTTkBnpkZWkrTnCeBdPhOS
         9KmCcO/qmA/CS5V5zQ+qt5llyJYjaEgCjnzsEeZNtUeefrPFIBZjZdQDFqFvjBHsrmns
         GM6kH6J01Gd4FfX/YwyMyD8R5EWeBgLObSCniqX5monH6I6g6I96uhRds/gg+2WpyNsm
         7P8K68ue70jt8NvnT+rF58SwQX4OQ/fPbJlL095xFhDLLhzR+zV2vYVnb6pzgSHcpDvi
         DBVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XnwQtA++4ZLQs18Zi/kVWI3WT0kdxj4T2Lu+EaH+lNM=;
        b=sEythI0M8lxuNTNINUnVM+XSaI8QKkiS2XWVd+yvDMvpm8UIwu3T5ottTDo+rZhX4e
         JG7+Fkv2wiZQE5O3nuFHXbY/XWShKdT/2VScKDV7P0P0T6sD0b4hM6405hSF2L3tGDS7
         bSdSjHUVZylqcPuMvjHinj5YxXA1xfDe5RMDpSuaSMCyhjNibYMzTgmnstffyzFbeA2x
         WDD67iKZ/N7MVJ2fNNGlm+4p+LCSi1JHd2kBMHC5FmXcjcSaiwXfwF41wFNiI4yNJ2Tp
         HRMmjjqHbHaQQoIPIJF4Bmo6lOGZPBfmrhsXhIJp1uaRHpP+ou5V5kEGMAPPbW3tAld8
         gSgQ==
X-Gm-Message-State: APjAAAV3GKZk7AQQgPXeXRo05U+uvzKvT7C97Nhd2tWTobvfKrBO5MFz
        jEzdAIO+oXr9Qbzu9SdGXdo=
X-Google-Smtp-Source: APXvYqzTWZbkX606qEM14eI+153drc1gKBISCMCaxjG+FvU99HV0t2kzhGHkSgxYnarXYG3KfRm3dw==
X-Received: by 2002:a62:1ac8:: with SMTP id a191mr22270899pfa.164.1564147541492;
        Fri, 26 Jul 2019 06:25:41 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id k36sm54544603pgl.42.2019.07.26.06.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 06:25:40 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v4 4/5] defconfig and MAINTAINERS updated for AST2500 DMA UART driver
Date:   Fri, 26 Jul 2019 18:57:19 +0530
Message-Id: <1564147640-30753-5-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
References: <1564147640-30753-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

defconfig changes to add DMA based UART in AST2500
Maintainers File updated.

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v4:
- config name changed to CONFIG_SERIAL_AST_DMA_UART as per convention
Changes in v3:
- Added changes logs 

MAINTAINERS                          | 12 ++++++++++++
 arch/arm/configs/aspeed_g5_defconfig |  1 +
 2 files changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e27ab492f..d814a52ecf99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1347,6 +1347,18 @@ F:	drivers/crypto/axis
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
+ARM/ASPEED DMA UART DRIVER
+M:	sudheer v <sudheer.open@gmail.com>
+R:	Joel Stanley <joel@jms.id.au>
+R:	Andrew Jeffery <andrew@aj.id.au>
+R:	Vinod Koul <vkoul@kernel.org>
+L:	dmaengine@vger.kernel.org
+L:	openbmc@lists.ozlabs.org
+L:	linux-aspeed@lists.ozlabs.org
+S:	Maintained
+F:	drivers/tty/serial/8250/8250_aspeed_uart_dma.c
+F:	Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
+
 ARM/ASPEED I2C DRIVER
 M:	Brendan Higgins <brendanhiggins@google.com>
 R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 1849cbc161b4..fc17cc9ddc00 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_SERIAL_AST_DMA_UART=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
2.17.1

