Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAFCC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D322B21774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BNS8YU7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfK1O7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:59:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35487 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfK1O5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:57:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so19826261lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOHk69/KFsExobLE9NJQaGShwXGaUdC/TzJxF/vkfiE=;
        b=BNS8YU7z/62qBru4p5dWldmGUqPFFFYcSf6UoO5+N8cI1t/eYIwVb93SWj/sJb/aPr
         CLgKaJzW4T4UJCDV6fxG/mFRQa5+pWEgUVNo9gk6Z/haJ0GbejDd0krX3Tx1ekUBIG7+
         Kf0VDKOEyN97OudALHUN6autns8qnyxm/Ncyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOHk69/KFsExobLE9NJQaGShwXGaUdC/TzJxF/vkfiE=;
        b=KxJOJoNYqDRO+dEE6VjXV+TB9WdPhAPMmid0IA9ijMmRNzdX0VtJu0HkFi1E2AVBdh
         9ImeV4LSDBTmp3vjlPD5/dOz6W4HgmEjIpyooJR+tyaG6kfyS4u2ThIjYE8bJ4gCXgv6
         znx4k7h5i/yQQePgm/TbBXsJIH4n/yKcrhG4/9QFviVwsucsUu3xaRi5HD0Bjffz5KDT
         Fr211ak4NWFk3Tyaw/K/fteuOT+FuBs2BuMPL6vVRh45P+G8rEY+2viNdDq0KVkbf5zD
         bcqxY0wV7Rllrn7CT6h5oBI7N9tN6AJMw6uDObF/6OJHZEGBwgq/ljtCiN73TE+0Qu97
         nkBw==
X-Gm-Message-State: APjAAAVARo8+2yqUXGz2XyJcruLHpGOZDkGQ+4LYvesEaCsuqIAAYcIY
        J+vkpP6nMAYge4nYU9p/1ocs1Q==
X-Google-Smtp-Source: APXvYqyIZpDYj/S47jI4BvahQQv0z5TMLaQBBFJjaoxjSz2gIfzyz1ZHAFXq4N7Oyd5IVHNFskfXyA==
X-Received: by 2002:a2e:7405:: with SMTP id p5mr19349633ljc.34.1574953067629;
        Thu, 28 Nov 2019 06:57:47 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id u2sm2456803lfl.18.2019.11.28.06.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 06:57:47 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>, Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v6 32/49] serial: ucc_uart: use of_property_read_u32() in ucc_uart_probe()
Date:   Thu, 28 Nov 2019 15:55:37 +0100
Message-Id: <20191128145554.1297-33-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
References: <20191128145554.1297-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For this to work correctly on little-endian hosts, don't access the
device-tree properties directly in native endianness, but use the
of_property_read_u32() helper.

Reviewed-by: Timur Tabi <timur@kernel.org>
Acked-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 36 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 313697842e24..c055abf4c919 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1256,10 +1256,10 @@ static int soft_uart_init(struct platform_device *ofdev)
 static int ucc_uart_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *iprop;      /* Integer OF properties */
 	const char *sprop;      /* String OF properties */
 	struct uart_qe_port *qe_port = NULL;
 	struct resource res;
+	u32 val;
 	int ret;
 
 	/*
@@ -1290,23 +1290,20 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 
 	/* Get the UCC number (device ID) */
 	/* UCCs are numbered 1-7 */
-	iprop = of_get_property(np, "cell-index", NULL);
-	if (!iprop) {
-		iprop = of_get_property(np, "device-id", NULL);
-		if (!iprop) {
-			dev_err(&ofdev->dev, "UCC is unspecified in "
-				"device tree\n");
+	if (of_property_read_u32(np, "cell-index", &val)) {
+		if (of_property_read_u32(np, "device-id", &val)) {
+			dev_err(&ofdev->dev, "UCC is unspecified in device tree\n");
 			ret = -EINVAL;
 			goto out_free;
 		}
 	}
 
-	if ((*iprop < 1) || (*iprop > UCC_MAX_NUM)) {
-		dev_err(&ofdev->dev, "no support for UCC%u\n", *iprop);
+	if (val < 1 || val > UCC_MAX_NUM) {
+		dev_err(&ofdev->dev, "no support for UCC%u\n", val);
 		ret = -ENODEV;
 		goto out_free;
 	}
-	qe_port->ucc_num = *iprop - 1;
+	qe_port->ucc_num = val - 1;
 
 	/*
 	 * In the future, we should not require the BRG to be specified in the
@@ -1350,13 +1347,12 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 	}
 
 	/* Get the port number, numbered 0-3 */
-	iprop = of_get_property(np, "port-number", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "port-number", &val)) {
 		dev_err(&ofdev->dev, "missing port-number in device tree\n");
 		ret = -EINVAL;
 		goto out_free;
 	}
-	qe_port->port.line = *iprop;
+	qe_port->port.line = val;
 	if (qe_port->port.line >= UCC_MAX_UART) {
 		dev_err(&ofdev->dev, "port-number must be 0-%u\n",
 			UCC_MAX_UART - 1);
@@ -1386,31 +1382,29 @@ static int ucc_uart_probe(struct platform_device *ofdev)
 		}
 	}
 
-	iprop = of_get_property(np, "brg-frequency", NULL);
-	if (!iprop) {
+	if (of_property_read_u32(np, "brg-frequency", &val)) {
 		dev_err(&ofdev->dev,
 		       "missing brg-frequency in device tree\n");
 		ret = -EINVAL;
 		goto out_np;
 	}
 
-	if (*iprop)
-		qe_port->port.uartclk = *iprop;
+	if (val)
+		qe_port->port.uartclk = val;
 	else {
 		/*
 		 * Older versions of U-Boot do not initialize the brg-frequency
 		 * property, so in this case we assume the BRG frequency is
 		 * half the QE bus frequency.
 		 */
-		iprop = of_get_property(np, "bus-frequency", NULL);
-		if (!iprop) {
+		if (of_property_read_u32(np, "bus-frequency", &val)) {
 			dev_err(&ofdev->dev,
 				"missing QE bus-frequency in device tree\n");
 			ret = -EINVAL;
 			goto out_np;
 		}
-		if (*iprop)
-			qe_port->port.uartclk = *iprop / 2;
+		if (val)
+			qe_port->port.uartclk = val / 2;
 		else {
 			dev_err(&ofdev->dev,
 				"invalid QE bus-frequency in device tree\n");
-- 
2.23.0

