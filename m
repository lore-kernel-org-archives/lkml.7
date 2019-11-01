Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E70CA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067432067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 12:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="NyDUYXIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbfKAMne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 08:43:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38334 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbfKAMmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 08:42:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so9722387ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kflmqvkrnbAdjtigGqKs8mrz9iivtun3aqewA1JiMFE=;
        b=NyDUYXIkhTDjdmcgUcb7b8dT2gpIksVGRkNvSwSQvkqtWGv133eWTcTSER9gfehL2d
         xIX+2LmMSj7lUEN7LE/YOEFM6VbPLtCOtLTLUt1BrzKhNUVsGx4vPn6gsVKzSmG63HIj
         SxvAHLMyYmfyRjb4Cm6Bt36xnnrs75vuZ8SdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kflmqvkrnbAdjtigGqKs8mrz9iivtun3aqewA1JiMFE=;
        b=iLtMSoi77AEhu0yx5HRjOAU2Z9S48t7KreJiVIsP3Cw3v9vGc68OMyImWMp60NOjEU
         FuAQJ0Oo0NcRothxmSHwPXp83OiIwDVClrhhcQMLxyZtQ1VuztStPySUTXbxEiIEnmD4
         t/xSODzWOPjFrrkcHIm3eV6vJ1chmfV4eNTjoBT4cSwCwaC+aYrjdN97eXlU10TRWPJp
         EfJVyhWtKT5EgWkkEowX2J6GgwY4N7XaAdhT1ZfgMNZRex+oe5ulzDWS7urwYB2FyxxO
         Z1dfvWBFZnjHsy3/kSgMebH6Jr+6W5U6xdO1Y6Rce54LJ5ZOe9EKn2wcPwYOYMdc+Lqq
         B31Q==
X-Gm-Message-State: APjAAAWOaN5x8wSeltyuAlB5TK7qYADX4J9iT1ImPu/sXAdUNa4ktNeZ
        3tl7hUHi/BLMqgYK2bIGdIJ7sQ==
X-Google-Smtp-Source: APXvYqyLQLds66fY7FIOqZw6ay5z/I38XkSj/bvi0wnqkb308z2FGjsozCwzsn16lZt6ap2J/567QA==
X-Received: by 2002:a2e:9058:: with SMTP id n24mr8241727ljg.114.1572612167256;
        Fri, 01 Nov 2019 05:42:47 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o26sm2458540lfi.57.2019.11.01.05.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:42:46 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v3 26/36] soc: fsl: move cpm.h from powerpc/include/asm to include/soc/fsl
Date:   Fri,  1 Nov 2019 13:42:00 +0100
Message-Id: <20191101124210.14510-27-linux@rasmusvillemoes.dk>
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

Some drivers, e.g. ucc_uart, need definitions from cpm.h. In order to
allow building those drivers for non-ppc based SOCs, move the header
to include/soc/fsl. For now, leave a trivial wrapper at the old
location so drivers can be updated one by one.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/powerpc/include/asm/cpm.h | 172 +--------------------------------
 include/soc/fsl/cpm.h          | 171 ++++++++++++++++++++++++++++++++
 2 files changed, 172 insertions(+), 171 deletions(-)
 create mode 100644 include/soc/fsl/cpm.h

diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index 4c24ea8209bb..ce483b0f8a4d 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -1,171 +1 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __CPM_H
-#define __CPM_H
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/of.h>
-#include <soc/fsl/qe/qe.h>
-
-/*
- * SPI Parameter RAM common to QE and CPM.
- */
-struct spi_pram {
-	__be16	rbase;	/* Rx Buffer descriptor base address */
-	__be16	tbase;	/* Tx Buffer descriptor base address */
-	u8	rfcr;	/* Rx function code */
-	u8	tfcr;	/* Tx function code */
-	__be16	mrblr;	/* Max receive buffer length */
-	__be32	rstate;	/* Internal */
-	__be32	rdp;	/* Internal */
-	__be16	rbptr;	/* Internal */
-	__be16	rbc;	/* Internal */
-	__be32	rxtmp;	/* Internal */
-	__be32	tstate;	/* Internal */
-	__be32	tdp;	/* Internal */
-	__be16	tbptr;	/* Internal */
-	__be16	tbc;	/* Internal */
-	__be32	txtmp;	/* Internal */
-	__be32	res;	/* Tx temp. */
-	__be16  rpbase;	/* Relocation pointer (CPM1 only) */
-	__be16	res1;	/* Reserved */
-};
-
-/*
- * USB Controller pram common to QE and CPM.
- */
-struct usb_ctlr {
-	u8	usb_usmod;
-	u8	usb_usadr;
-	u8	usb_uscom;
-	u8	res1[1];
-	__be16	usb_usep[4];
-	u8	res2[4];
-	__be16	usb_usber;
-	u8	res3[2];
-	__be16	usb_usbmr;
-	u8	res4[1];
-	u8	usb_usbs;
-	/* Fields down below are QE-only */
-	__be16	usb_ussft;
-	u8	res5[2];
-	__be16	usb_usfrn;
-	u8	res6[0x22];
-} __attribute__ ((packed));
-
-/*
- * Function code bits, usually generic to devices.
- */
-#ifdef CONFIG_CPM1
-#define CPMFCR_GBL	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
-#define CPMFCR_TC2	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
-#define CPMFCR_DTB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
-#define CPMFCR_BDB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
-#else
-#define CPMFCR_GBL	((u_char)0x20)	/* Set memory snooping */
-#define CPMFCR_TC2	((u_char)0x04)	/* Transfer code 2 value */
-#define CPMFCR_DTB	((u_char)0x02)	/* Use local bus for data when set */
-#define CPMFCR_BDB	((u_char)0x01)	/* Use local bus for BD when set */
-#endif
-#define CPMFCR_EB	((u_char)0x10)	/* Set big endian byte order */
-
-/* Opcodes common to CPM1 and CPM2
-*/
-#define CPM_CR_INIT_TRX		((ushort)0x0000)
-#define CPM_CR_INIT_RX		((ushort)0x0001)
-#define CPM_CR_INIT_TX		((ushort)0x0002)
-#define CPM_CR_HUNT_MODE	((ushort)0x0003)
-#define CPM_CR_STOP_TX		((ushort)0x0004)
-#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
-#define CPM_CR_RESTART_TX	((ushort)0x0006)
-#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
-#define CPM_CR_SET_GADDR	((ushort)0x0008)
-#define CPM_CR_SET_TIMER	((ushort)0x0008)
-#define CPM_CR_STOP_IDMA	((ushort)0x000b)
-
-/* Buffer descriptors used by many of the CPM protocols. */
-typedef struct cpm_buf_desc {
-	ushort	cbd_sc;		/* Status and Control */
-	ushort	cbd_datlen;	/* Data length in buffer */
-	uint	cbd_bufaddr;	/* Buffer address in host memory */
-} cbd_t;
-
-/* Buffer descriptor control/status used by serial
- */
-
-#define BD_SC_EMPTY	(0x8000)	/* Receive is empty */
-#define BD_SC_READY	(0x8000)	/* Transmit is ready */
-#define BD_SC_WRAP	(0x2000)	/* Last buffer descriptor */
-#define BD_SC_INTRPT	(0x1000)	/* Interrupt on change */
-#define BD_SC_LAST	(0x0800)	/* Last buffer in frame */
-#define BD_SC_TC	(0x0400)	/* Transmit CRC */
-#define BD_SC_CM	(0x0200)	/* Continuous mode */
-#define BD_SC_ID	(0x0100)	/* Rec'd too many idles */
-#define BD_SC_P		(0x0100)	/* xmt preamble */
-#define BD_SC_BR	(0x0020)	/* Break received */
-#define BD_SC_FR	(0x0010)	/* Framing error */
-#define BD_SC_PR	(0x0008)	/* Parity error */
-#define BD_SC_NAK	(0x0004)	/* NAK - did not respond */
-#define BD_SC_OV	(0x0002)	/* Overrun */
-#define BD_SC_UN	(0x0002)	/* Underrun */
-#define BD_SC_CD	(0x0001)	/* */
-#define BD_SC_CL	(0x0001)	/* Collision */
-
-/* Buffer descriptor control/status used by Ethernet receive.
- * Common to SCC and FCC.
- */
-#define BD_ENET_RX_EMPTY	(0x8000)
-#define BD_ENET_RX_WRAP		(0x2000)
-#define BD_ENET_RX_INTR		(0x1000)
-#define BD_ENET_RX_LAST		(0x0800)
-#define BD_ENET_RX_FIRST	(0x0400)
-#define BD_ENET_RX_MISS		(0x0100)
-#define BD_ENET_RX_BC		(0x0080)	/* FCC Only */
-#define BD_ENET_RX_MC		(0x0040)	/* FCC Only */
-#define BD_ENET_RX_LG		(0x0020)
-#define BD_ENET_RX_NO		(0x0010)
-#define BD_ENET_RX_SH		(0x0008)
-#define BD_ENET_RX_CR		(0x0004)
-#define BD_ENET_RX_OV		(0x0002)
-#define BD_ENET_RX_CL		(0x0001)
-#define BD_ENET_RX_STATS	(0x01ff)	/* All status bits */
-
-/* Buffer descriptor control/status used by Ethernet transmit.
- * Common to SCC and FCC.
- */
-#define BD_ENET_TX_READY	(0x8000)
-#define BD_ENET_TX_PAD		(0x4000)
-#define BD_ENET_TX_WRAP		(0x2000)
-#define BD_ENET_TX_INTR		(0x1000)
-#define BD_ENET_TX_LAST		(0x0800)
-#define BD_ENET_TX_TC		(0x0400)
-#define BD_ENET_TX_DEF		(0x0200)
-#define BD_ENET_TX_HB		(0x0100)
-#define BD_ENET_TX_LC		(0x0080)
-#define BD_ENET_TX_RL		(0x0040)
-#define BD_ENET_TX_RCMASK	(0x003c)
-#define BD_ENET_TX_UN		(0x0002)
-#define BD_ENET_TX_CSL		(0x0001)
-#define BD_ENET_TX_STATS	(0x03ff)	/* All status bits */
-
-/* Buffer descriptor control/status used by Transparent mode SCC.
- */
-#define BD_SCC_TX_LAST		(0x0800)
-
-/* Buffer descriptor control/status used by I2C.
- */
-#define BD_I2C_START		(0x0400)
-
-#ifdef CONFIG_CPM
-int cpm_command(u32 command, u8 opcode);
-#else
-static inline int cpm_command(u32 command, u8 opcode)
-{
-	return -ENOSYS;
-}
-#endif /* CONFIG_CPM */
-
-int cpm2_gpiochip_add32(struct device *dev);
-
-#endif
+#include <soc/fsl/cpm.h>
diff --git a/include/soc/fsl/cpm.h b/include/soc/fsl/cpm.h
new file mode 100644
index 000000000000..4c24ea8209bb
--- /dev/null
+++ b/include/soc/fsl/cpm.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CPM_H
+#define __CPM_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/of.h>
+#include <soc/fsl/qe/qe.h>
+
+/*
+ * SPI Parameter RAM common to QE and CPM.
+ */
+struct spi_pram {
+	__be16	rbase;	/* Rx Buffer descriptor base address */
+	__be16	tbase;	/* Tx Buffer descriptor base address */
+	u8	rfcr;	/* Rx function code */
+	u8	tfcr;	/* Tx function code */
+	__be16	mrblr;	/* Max receive buffer length */
+	__be32	rstate;	/* Internal */
+	__be32	rdp;	/* Internal */
+	__be16	rbptr;	/* Internal */
+	__be16	rbc;	/* Internal */
+	__be32	rxtmp;	/* Internal */
+	__be32	tstate;	/* Internal */
+	__be32	tdp;	/* Internal */
+	__be16	tbptr;	/* Internal */
+	__be16	tbc;	/* Internal */
+	__be32	txtmp;	/* Internal */
+	__be32	res;	/* Tx temp. */
+	__be16  rpbase;	/* Relocation pointer (CPM1 only) */
+	__be16	res1;	/* Reserved */
+};
+
+/*
+ * USB Controller pram common to QE and CPM.
+ */
+struct usb_ctlr {
+	u8	usb_usmod;
+	u8	usb_usadr;
+	u8	usb_uscom;
+	u8	res1[1];
+	__be16	usb_usep[4];
+	u8	res2[4];
+	__be16	usb_usber;
+	u8	res3[2];
+	__be16	usb_usbmr;
+	u8	res4[1];
+	u8	usb_usbs;
+	/* Fields down below are QE-only */
+	__be16	usb_ussft;
+	u8	res5[2];
+	__be16	usb_usfrn;
+	u8	res6[0x22];
+} __attribute__ ((packed));
+
+/*
+ * Function code bits, usually generic to devices.
+ */
+#ifdef CONFIG_CPM1
+#define CPMFCR_GBL	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_TC2	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_DTB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#define CPMFCR_BDB	((u_char)0x00)	/* Flag doesn't exist in CPM1 */
+#else
+#define CPMFCR_GBL	((u_char)0x20)	/* Set memory snooping */
+#define CPMFCR_TC2	((u_char)0x04)	/* Transfer code 2 value */
+#define CPMFCR_DTB	((u_char)0x02)	/* Use local bus for data when set */
+#define CPMFCR_BDB	((u_char)0x01)	/* Use local bus for BD when set */
+#endif
+#define CPMFCR_EB	((u_char)0x10)	/* Set big endian byte order */
+
+/* Opcodes common to CPM1 and CPM2
+*/
+#define CPM_CR_INIT_TRX		((ushort)0x0000)
+#define CPM_CR_INIT_RX		((ushort)0x0001)
+#define CPM_CR_INIT_TX		((ushort)0x0002)
+#define CPM_CR_HUNT_MODE	((ushort)0x0003)
+#define CPM_CR_STOP_TX		((ushort)0x0004)
+#define CPM_CR_GRA_STOP_TX	((ushort)0x0005)
+#define CPM_CR_RESTART_TX	((ushort)0x0006)
+#define CPM_CR_CLOSE_RX_BD	((ushort)0x0007)
+#define CPM_CR_SET_GADDR	((ushort)0x0008)
+#define CPM_CR_SET_TIMER	((ushort)0x0008)
+#define CPM_CR_STOP_IDMA	((ushort)0x000b)
+
+/* Buffer descriptors used by many of the CPM protocols. */
+typedef struct cpm_buf_desc {
+	ushort	cbd_sc;		/* Status and Control */
+	ushort	cbd_datlen;	/* Data length in buffer */
+	uint	cbd_bufaddr;	/* Buffer address in host memory */
+} cbd_t;
+
+/* Buffer descriptor control/status used by serial
+ */
+
+#define BD_SC_EMPTY	(0x8000)	/* Receive is empty */
+#define BD_SC_READY	(0x8000)	/* Transmit is ready */
+#define BD_SC_WRAP	(0x2000)	/* Last buffer descriptor */
+#define BD_SC_INTRPT	(0x1000)	/* Interrupt on change */
+#define BD_SC_LAST	(0x0800)	/* Last buffer in frame */
+#define BD_SC_TC	(0x0400)	/* Transmit CRC */
+#define BD_SC_CM	(0x0200)	/* Continuous mode */
+#define BD_SC_ID	(0x0100)	/* Rec'd too many idles */
+#define BD_SC_P		(0x0100)	/* xmt preamble */
+#define BD_SC_BR	(0x0020)	/* Break received */
+#define BD_SC_FR	(0x0010)	/* Framing error */
+#define BD_SC_PR	(0x0008)	/* Parity error */
+#define BD_SC_NAK	(0x0004)	/* NAK - did not respond */
+#define BD_SC_OV	(0x0002)	/* Overrun */
+#define BD_SC_UN	(0x0002)	/* Underrun */
+#define BD_SC_CD	(0x0001)	/* */
+#define BD_SC_CL	(0x0001)	/* Collision */
+
+/* Buffer descriptor control/status used by Ethernet receive.
+ * Common to SCC and FCC.
+ */
+#define BD_ENET_RX_EMPTY	(0x8000)
+#define BD_ENET_RX_WRAP		(0x2000)
+#define BD_ENET_RX_INTR		(0x1000)
+#define BD_ENET_RX_LAST		(0x0800)
+#define BD_ENET_RX_FIRST	(0x0400)
+#define BD_ENET_RX_MISS		(0x0100)
+#define BD_ENET_RX_BC		(0x0080)	/* FCC Only */
+#define BD_ENET_RX_MC		(0x0040)	/* FCC Only */
+#define BD_ENET_RX_LG		(0x0020)
+#define BD_ENET_RX_NO		(0x0010)
+#define BD_ENET_RX_SH		(0x0008)
+#define BD_ENET_RX_CR		(0x0004)
+#define BD_ENET_RX_OV		(0x0002)
+#define BD_ENET_RX_CL		(0x0001)
+#define BD_ENET_RX_STATS	(0x01ff)	/* All status bits */
+
+/* Buffer descriptor control/status used by Ethernet transmit.
+ * Common to SCC and FCC.
+ */
+#define BD_ENET_TX_READY	(0x8000)
+#define BD_ENET_TX_PAD		(0x4000)
+#define BD_ENET_TX_WRAP		(0x2000)
+#define BD_ENET_TX_INTR		(0x1000)
+#define BD_ENET_TX_LAST		(0x0800)
+#define BD_ENET_TX_TC		(0x0400)
+#define BD_ENET_TX_DEF		(0x0200)
+#define BD_ENET_TX_HB		(0x0100)
+#define BD_ENET_TX_LC		(0x0080)
+#define BD_ENET_TX_RL		(0x0040)
+#define BD_ENET_TX_RCMASK	(0x003c)
+#define BD_ENET_TX_UN		(0x0002)
+#define BD_ENET_TX_CSL		(0x0001)
+#define BD_ENET_TX_STATS	(0x03ff)	/* All status bits */
+
+/* Buffer descriptor control/status used by Transparent mode SCC.
+ */
+#define BD_SCC_TX_LAST		(0x0800)
+
+/* Buffer descriptor control/status used by I2C.
+ */
+#define BD_I2C_START		(0x0400)
+
+#ifdef CONFIG_CPM
+int cpm_command(u32 command, u8 opcode);
+#else
+static inline int cpm_command(u32 command, u8 opcode)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_CPM */
+
+int cpm2_gpiochip_add32(struct device *dev);
+
+#endif
-- 
2.23.0

