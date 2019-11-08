Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D94AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543BD206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SRXE1NoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfKHNDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:03:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36979 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfKHNCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:02:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so4411073lfp.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=SRXE1NoSEoSCywO+L8E6ng+2FXGjgyGd7B+f0jJ2JaXIveaCYZLPIeDN3ivZQSSkGE
         u1V/D5rgTkWtpx6sNDzCdXxFB3bSCGyd8bTMf7BINnG8O7NsszC3ReD1KjCbn+P9Wj81
         /49kVxIImaa1ns64nyNk2b2uJQOsVial126RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=g8YGU/46v7HgAtqewpczFlJBC0saPATpW3xBL2eZAoAmD9mPsfbJ5MC/J88wUDhQ5x
         Tf2a6iO4Xzv37Nk7qx/DkBCO2fM31I1eVsJrM6v1x8vDm3RNjKNLqWtxLhHkEwkL5Vlv
         0EyUcpIIaCSDBpw8EpEtqSgyNQOUDqKt1oEPiMaBtRwAQzc4kgO08GIVAbF6GwRImMwm
         1YjlwQqsPVVO2gOKJzC1B5/2TzF8NoPobphRyLDreClea1tVwVe80CDm6fiWDGvV61/Z
         Zv74upooPu4o8tl0poCnpZkVjbLg/qhnZFCj1f5JGdd40Q7P6gIclUVQmnw98jgubLQ0
         Z6aA==
X-Gm-Message-State: APjAAAVdQ3aNEZwimPD/v0jKc6qKCpg4mAyqGC645TgBOvpCVvW41JCn
        2m6XbSAfz3De196Xdl8Er0iMAQ==
X-Google-Smtp-Source: APXvYqwOqHE3M01CuaW5urlsbt5KzMbJiYrCdCN84TCfTLcHk6GXpiZEJDNrDr2YmEEm613FNacMMA==
X-Received: by 2002:ac2:5dcc:: with SMTP id x12mr6536635lfq.163.1573218127481;
        Fri, 08 Nov 2019 05:02:07 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id d28sm2454725lfn.33.2019.11.08.05.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 05:02:06 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v4 31/47] serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
Date:   Fri,  8 Nov 2019 14:01:07 +0100
Message-Id: <20191108130123.6839-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
References: <20191108130123.6839-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Soft UART hack is only needed for some PPC-based SOCs. To allow
building this driver for non-PPC, guard soft_uart_init() and its
helpers by CONFIG_PPC32, and use a no-op soft_uart_init() otherwise.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index f286e91714cb..313697842e24 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -33,7 +33,10 @@
 
 #include <linux/firmware.h>
 #include <soc/fsl/cpm.h>
-#include <asm/reg.h>
+
+#ifdef CONFIG_PPC32
+#include <asm/reg.h> /* mfspr, SPRN_SVR */
+#endif
 
 /*
  * The GUMR flag for Soft UART.  This would normally be defined in qe.h,
@@ -1096,6 +1099,8 @@ static const struct uart_ops qe_uart_pops = {
 	.verify_port    = qe_uart_verify_port,
 };
 
+
+#ifdef CONFIG_PPC32
 /*
  * Obtain the SOC model number and revision level
  *
@@ -1238,6 +1243,16 @@ static int soft_uart_init(struct platform_device *ofdev)
 	return 0;
 }
 
+#else /* !CONFIG_PPC32 */
+
+static int soft_uart_init(struct platform_device *ofdev)
+{
+	return 0;
+}
+
+#endif
+
+
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-- 
2.23.0

