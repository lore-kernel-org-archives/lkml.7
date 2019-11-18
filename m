Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0164C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940D720748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 11:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="ZiZ90qqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKRLZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 06:25:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53622 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfKRLYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:24:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so16987534wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 03:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=ZiZ90qqpfO5qG7SMgAh9/PB8QFX94uZpsWOqL6XjsbR9k5YCqcy9OSx87H09ThU+0w
         vys3j3NPV7goOMpCenbAPyOKNvRwKCMnbmiGxqi+1n2EGup9wl2ulfLkuB0N+ksQaWh5
         tpchHcQSPNzqhcfPrkJ1VxR3gsSN+rvrINqOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zPi0SchlJBpcK2Uafamd7sY3psIZzF+ErFogb8EsMtA=;
        b=X5s9+JUGRaLqTwmSoQunm8g2tLNm4HJp8Ac+5RXJUPWOtfrE8iZl1RtACGM/ueMRe4
         MExmA9A0ltU3YsxLS8WFw8PGAqYNZeVv7QLGig4v5pZGvVGjNLP4PCBH3E1RU3mqk2D9
         mzFy3PWwis0BL1ISecfSDhbD7SgoaWLQimNHBTvS2biV+inikxJ4Ioh/Al/m9BQhDGHP
         q5BLBd/Tx5yx7RPTXeJctWaEBTECop9LPg1F4UVVFDp3lbxuGOb+U3pt+VoMPW4t+7/d
         ZYatSLX5WWYwlJfp6ZU6gXtESAQz5uMzbJ5AlvRQ5JExFLdEWY7/Q+wQF3kr5pyLZrrl
         C7FQ==
X-Gm-Message-State: APjAAAX3KCQTIcVTphu3JhAFV5SDP5gx52aCj/ARgaMKAIUxX7KjPz3w
        Anzh+p0v5Y4QUyfy8D9zdN1Q7g==
X-Google-Smtp-Source: APXvYqyMlre0ptC746RrIs0o3/q5vSgHaOfHInZsRln9L66Xi9zEqoUBbz9OzBot4n1Ofcy+OJlHFw==
X-Received: by 2002:a1c:b607:: with SMTP id g7mr29865871wmf.94.1574076252099;
        Mon, 18 Nov 2019 03:24:12 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:24:11 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 31/48] serial: ucc_uart: stub out soft_uart_init for !CONFIG_PPC32
Date:   Mon, 18 Nov 2019 12:23:07 +0100
Message-Id: <20191118112324.22725-32-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
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

