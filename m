Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC05DC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 813F02168B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 10:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Po6yPSIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732103AbfFYKnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 06:43:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfFYKnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 06:43:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so8777705pgl.2;
        Tue, 25 Jun 2019 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3jHKxS9Kogr9qqdX19ENZz0Qw2yWpRAgexX6QLS/rnc=;
        b=Po6yPSIbbWGLrfDa4V7fOtDKBArKnI5y9ekQZD2WUtoNTNkKBWC+AgyTwjt0CQ5GIM
         qlcxNytMoY0tYDp2vWF6XqgXeaTLunFRIVafN77Jb8cImPqBtg4gUTM01OL70kOg2z4m
         CTPXvk58hkItaFaZg+REyUGx7RFUsTSnQQhqYXwtwEYh5uAwIrQXQ0sEVnlxKPFpuY/i
         J37oorJzpwI0AwFSLc6wOzrSNlqFrcWP9S0JiNSlWtMc/Ron30hQZArGZuTdxYV4s7w/
         rANUxTU5/So+w/r5ASVy4WkdJjY+6p//mI1wlt40qsV0Z8eSKSAVfqYArn3aMI5hLX0M
         +0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3jHKxS9Kogr9qqdX19ENZz0Qw2yWpRAgexX6QLS/rnc=;
        b=F1+lj5zOBuNLc0ujyWJXLWZ3ZmAEnc88YzipqPBLLu8F+MyPxjoyIe82TwPm8Clsa2
         iQ6i0zcDz3sMniVlz0xgiT1lJZm3jxy701jjxpYLUM+/vvYTYWJTsuTxWMZ6Pi5J/VLk
         +0elUCx0TMRbfgkz5UGkb+LwGwksYOpurvRIMNCVLY5B5VBYRavT0SSqa3i/Sn2l0azV
         9LDY18hklo9NPLpNoGUzACXmTkbSJB8BGlw8w9V2I+WokAgutHMdL21MwklZ7pLK0Fts
         yBtBdbgCpVdVbFktC+qbmdQustpqImWlo4SdzgoNv1aQo0Tv/VUt+o+igNNlD3FdGgfS
         fLmQ==
X-Gm-Message-State: APjAAAXf6CX0uKsWv4UfU4wcr/3PA3av9Ox58kDosqGLDW7PE2FomQZf
        Zm2hQPbXBmf+6EJc60YER/4=
X-Google-Smtp-Source: APXvYqwNh9AJL+27sY07DzBTihEQMlT3d5EQd6GP5q9N2fehLoVqGOUbYiLPYolNd15XJSUo3vs9AA==
X-Received: by 2002:a63:a61:: with SMTP id z33mr20274329pgk.154.1561459390566;
        Tue, 25 Jun 2019 03:43:10 -0700 (PDT)
Received: from Pilot130.192.168.0.22 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.googlemail.com with ESMTPSA id 14sm22026759pfj.36.2019.06.25.03.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jun 2019 03:43:10 -0700 (PDT)
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com, joel@jms.id.au,
        andrew@aj.id.au, benh@kernel.crashing.org, robh+dt@kernel.org,
        mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com
Cc:     sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: [patch v3 4/5] defconfig and MAINTAINERS updated for AST2500 DMA UART driver
Date:   Tue, 25 Jun 2019 16:14:35 +0530
Message-Id: <1561459476-14268-5-git-send-email-open.sudheer@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: sudheer veliseti <sudheer.open@gmail.com>

defconfig changes to add DMA based UART in AST2500
Maintainers File updated.
Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>
---

Changes in v3:
- Added changes logs 

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

