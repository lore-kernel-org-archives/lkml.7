Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C90CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D7B2067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="JlyPeQVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfKAMnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37585 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730797AbfKAMmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id v2so10130058lji.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4Xv5WoIG3tnGwzAreyDrYqib6OrZF77Ddvl40A6T0E=;
        b=JlyPeQVcsCkn6meA+ft/u91froZy6pUJF8+frfj7p47K+TzysfloPqSKcKSWfUZVto
         akAMuL5TH0SelqXLgcKmhUMxAkYxiIKlZdanQjq1oOy4UpHTwZIW9Lrde31GRRCh3oD7
         dKUMvxnfbKDVK6COMfIfpfg4KVLwutVYRu058=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4Xv5WoIG3tnGwzAreyDrYqib6OrZF77Ddvl40A6T0E=;
        b=WNLRK7hprvWSIfbKNIi976ZrbT9HUSsNVOMbnS7kKNMxTSdLW6/DTwxGkGXBFGGiEy
         ztKMEUezCWKivXu3rxs3/JzjmvTv6jomIgMQeCJyfp5VGxsj3fxGRW4HE6YqryTbIh6y
         uqLCD/O1cdBG6jM1qrVQSQ2CkknoBt17+h9abMZP3pPO1SrPckauYpEPibSlxfEioR5B
         9V/xO0MBOCBRiKTCjinQ3RH3ImKBZ7R1j84vcQ9G6l+BM5uKCCjiP5kfU2XGAyjXeq3V
         HvDNa6GTYwGuukoYIoHJoMwTC1HuH2YewRWmshd1Tetlp6WGE0TNpNiB/ZosqY9agivd
         Zvpw==
X-Gm-Message-State: APjAAAVUzBSO+oELwu2i49W/G8T/E5vYzNLMhIyH/qs34nlvMjdcDmKK
        JbhmbHOpujS+o5juGiUiQjtkpg==
X-Google-Smtp-Source: APXvYqyOU7gVdRVcReMBDUWsa49WOymHuHyQm46HkUrGJZni45GgB03JF0BRUfADOyP5/70QKBrABg==
X-Received: by 2002:a2e:2903:: with SMTP id u3mr8372560lje.131.1572612171901;
        Fri, 01 Nov 2019 05:42:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-serial@vger.kernel.org
Subject: [PATCH v3 30/36] serial: ucc_uart: factor out soft_uart initialization
Date:   Fri,  1 Nov 2019 13:42:04 +0100
Message-Id: <20191101124210.14510-31-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191101124210.14510-1-linux@rasmusvillemoes.dk>
References: <20191018125234.21825-1-linux@rasmusvillemoes.dk>
 <20191101124210.14510-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "soft uart" mechanism is a workaround for a silicon bug which (as
far as I know) only affects some PPC-based SOCs.

The code that determines which microcode blob to request relies on
some powerpc-specific bits (e.g. the mfspr(SPRN_SVR) and hence also
the asm/reg.h header). This makes it a little awkward to allow this
driver to be built for non-PPC based SOCs with a QE, even if they are
not affected by that silicon bug and thus don't need any of the Soft
UART logic.

There's no way around guarding those bits with some ifdeffery, so to
keep that isolated, factor out the
do-we-need-soft-uart-and-if-so-handle-the-firmware to a separate
function, which we can then easily stub out for non-PPC.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/tty/serial/ucc_uart.c | 110 ++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 52 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 8a378ee5d34f..f286e91714cb 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -1183,70 +1183,76 @@ static void uart_firmware_cont(const struct firmware *fw, void *context)
 	release_firmware(fw);
 }
 
-static int ucc_uart_probe(struct platform_device *ofdev)
+static int soft_uart_init(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
-	const unsigned int *iprop;      /* Integer OF properties */
-	const char *sprop;      /* String OF properties */
-	struct uart_qe_port *qe_port = NULL;
-	struct resource res;
+	struct qe_firmware_info *qe_fw_info;
 	int ret;
 
-	/*
-	 * Determine if we need Soft-UART mode
-	 */
 	if (of_find_property(np, "soft-uart", NULL)) {
 		dev_dbg(&ofdev->dev, "using Soft-UART mode\n");
 		soft_uart = 1;
+	} else {
+		return 0;
 	}
 
-	/*
-	 * If we are using Soft-UART, determine if we need to upload the
-	 * firmware, too.
-	 */
-	if (soft_uart) {
-		struct qe_firmware_info *qe_fw_info;
-
-		qe_fw_info = qe_get_firmware_info();
-
-		/* Check if the firmware has been uploaded. */
-		if (qe_fw_info && strstr(qe_fw_info->id, "Soft-UART")) {
-			firmware_loaded = 1;
-		} else {
-			char filename[32];
-			unsigned int soc;
-			unsigned int rev_h;
-			unsigned int rev_l;
-
-			soc = soc_info(&rev_h, &rev_l);
-			if (!soc) {
-				dev_err(&ofdev->dev, "unknown CPU model\n");
-				return -ENXIO;
-			}
-			sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
-				soc, rev_h, rev_l);
-
-			dev_info(&ofdev->dev, "waiting for firmware %s\n",
-				filename);
+	qe_fw_info = qe_get_firmware_info();
 
-			/*
-			 * We call request_firmware_nowait instead of
-			 * request_firmware so that the driver can load and
-			 * initialize the ports without holding up the rest of
-			 * the kernel.  If hotplug support is enabled in the
-			 * kernel, then we use it.
-			 */
-			ret = request_firmware_nowait(THIS_MODULE,
-				FW_ACTION_HOTPLUG, filename, &ofdev->dev,
-				GFP_KERNEL, &ofdev->dev, uart_firmware_cont);
-			if (ret) {
-				dev_err(&ofdev->dev,
-					"could not load firmware %s\n",
-					filename);
-				return ret;
-			}
+	/* Check if the firmware has been uploaded. */
+	if (qe_fw_info && strstr(qe_fw_info->id, "Soft-UART")) {
+		firmware_loaded = 1;
+	} else {
+		char filename[32];
+		unsigned int soc;
+		unsigned int rev_h;
+		unsigned int rev_l;
+
+		soc = soc_info(&rev_h, &rev_l);
+		if (!soc) {
+			dev_err(&ofdev->dev, "unknown CPU model\n");
+			return -ENXIO;
+		}
+		sprintf(filename, "fsl_qe_ucode_uart_%u_%u%u.bin",
+			soc, rev_h, rev_l);
+
+		dev_info(&ofdev->dev, "waiting for firmware %s\n",
+			 filename);
+
+		/*
+		 * We call request_firmware_nowait instead of
+		 * request_firmware so that the driver can load and
+		 * initialize the ports without holding up the rest of
+		 * the kernel.  If hotplug support is enabled in the
+		 * kernel, then we use it.
+		 */
+		ret = request_firmware_nowait(THIS_MODULE,
+					      FW_ACTION_HOTPLUG, filename, &ofdev->dev,
+					      GFP_KERNEL, &ofdev->dev, uart_firmware_cont);
+		if (ret) {
+			dev_err(&ofdev->dev,
+				"could not load firmware %s\n",
+				filename);
+			return ret;
 		}
 	}
+	return 0;
+}
+
+static int ucc_uart_probe(struct platform_device *ofdev)
+{
+	struct device_node *np = ofdev->dev.of_node;
+	const unsigned int *iprop;      /* Integer OF properties */
+	const char *sprop;      /* String OF properties */
+	struct uart_qe_port *qe_port = NULL;
+	struct resource res;
+	int ret;
+
+	/*
+	 * Determine if we need Soft-UART mode
+	 */
+	ret = soft_uart_init(ofdev);
+	if (ret)
+		return ret;
 
 	qe_port = kzalloc(sizeof(struct uart_qe_port), GFP_KERNEL);
 	if (!qe_port) {
-- 
2.23.0

