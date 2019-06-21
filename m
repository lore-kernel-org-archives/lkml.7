Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49E6C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7E721530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 11:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj7cZGNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbfFULQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 07:16:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfFULQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 07:16:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id m30so3432543pff.8;
        Fri, 21 Jun 2019 04:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ks+wgx/4HM/gUpKQKhvFzIwQsEuEY3r2Qt0MyQ+nHZs=;
        b=pj7cZGNxXfRtnwmfrCkITH3hZW2lPhrJn3adSPIX70yPFItqoE8Cwe9r5T6J0cKGZr
         LqMLpLf7NxOPGAP6hq+JEBXwrlMEZoa4x6p4YSAP2Yc8v1fEZz4mCwpHLeb8MH1vZ76p
         9NtyN+fI5VqPSWS/T/5XOZe1QAsp+F4eM77QffnQXR8Us6hMLCLyadn3lI123FOm818m
         RYprRcx7brgcSI4vK1K5PUEX4YDL2Cfwn0rJhsrUxqO+6Fno2m5Tfmd430PUvQ9eZb1E
         3jpsx1cshwZq3yMh4O88D2J9HEhVCkA4AWyv1jVY4HMMqFJXXZsn8Gu3xYWLX3Qx91Rc
         4zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ks+wgx/4HM/gUpKQKhvFzIwQsEuEY3r2Qt0MyQ+nHZs=;
        b=ebN7w4zotEa4eXmXsMPWMVIWFb3oQ9n8r//+xeLZuYsjZmr2S7fRUask+bvoTfRMTh
         W6JDAey/DYLHnu3AXhyFgyjKYAs+XId1wEQX9Noc4sF9mxfnDqRJJImBao4RqZrX0MNV
         Ja5bMcDpgAcrEli6b+9EeHwleBfrGB1v+0YpH96WURbbQh17urp2dqbMHClYUXVnfwyv
         ltXbOiSIzFZZVq+N4ioEy4692uAN/gs5bYkwYKc086o4qMShvWNwDpdYMlqwoX8NnR+O
         WQk9gnGgebk73S+imNrD1qa3YJxgew9RllWBjsjjBbMnD+FlgTZM88KKUYf9RdVWdUXR
         6MpA==
X-Gm-Message-State: APjAAAUKoKohtBmTVJbgxexq+86QXtkKy64tEi+FXvWpj26NXdNtVgOm
        1UgPgGM54DCpoFGY1rVu1E8=
X-Google-Smtp-Source: APXvYqzCufeGfxRq1tfK229KQkh0+mNnU9qPRl2p/RMjJ2iDTt35Mcn/vG1OOl9rh/Tn+liYek6hFQ==
X-Received: by 2002:a63:7749:: with SMTP id s70mr5409461pgc.242.1561115780790;
        Fri, 21 Jun 2019 04:16:20 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id w4sm2405737pfw.97.2019.06.21.04.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Jun 2019 04:16:20 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch 4/5] defconfig and MAINTAINERS updated for AST2500 DMA UART driver
Date:   Fri, 21 Jun 2019 16:47:34 +0530
Message-Id: <1561115855-4186-5-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---
 MAINTAINERS                          | 13 +++++++++++++
 arch/arm/configs/aspeed_g5_defconfig |  1 +
 2 files changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 997e27ab492f..c9a9790b97f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1347,6 +1347,19 @@ F:	drivers/crypto/axis
 F:	drivers/pinctrl/pinctrl-artpec*
 F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
 
+ARM/ASPEED DMA UART DRIVER
+M:	sudheer v <sudheer.open@gmail.com>
+M:	ShivahShankar <shivahshankar.shankarnarayanrao@aspeedtech.com>
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
index 1849cbc161b4..25bf26630939 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=6
 CONFIG_SERIAL_8250_RUNTIME_UARTS=6
+CONFIG_AST_SERIAL_DMA_UART=y
 CONFIG_SERIAL_8250_EXTENDED=y
 CONFIG_SERIAL_8250_ASPEED_VUART=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
-- 
2.17.1

