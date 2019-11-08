Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EBDC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B0E214DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 05:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJdy5MUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfKHFUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 00:20:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43227 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbfKHFUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 00:20:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id a18so3253232plm.10;
        Thu, 07 Nov 2019 21:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJrLEutB9IE4cH0o167QSbIRHowe1UGgC6cJgowDRoc=;
        b=WJdy5MUY1Qn6ddxA3VXbTCxIyHH/pCovQCmpMiGsm7aFyHIy6t5JxsMO5u7R4ZqdUg
         ASPNl9Htx31/fvHpIkQ8Wrk5YueUHpiKkqn5yxH2VSBaIaYeEbLsBX35sP/f6cYen0Gj
         BxiqVZVoq8SHoMB0f4AgMIooKXIdc2mX2V7aRF5T/dTecxbX09jc4GDFXP/3qXrN+Q6y
         DmGchBG33EVPLvwLM6YubzQs357dWd/hLNUg19/c06Xn0TlTfnV4KQE1tZawL3rbQ5xl
         ZHDn27LT4pu1DFXcDMEx3tWDIU2zl3H49jjiGVkDQf7TLCU5QF004qHs5kkSDmMtdCZN
         9myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hJrLEutB9IE4cH0o167QSbIRHowe1UGgC6cJgowDRoc=;
        b=kqdaaIKvKi/1kGJR7vFuXOn/NcounGal1goteESyhLnTigZQPUmTVjYlauDSMd2Zvc
         B6aYD3xEwEWJKWJ2fMSgu5X3MnEXT/ZWi/kRnEN5PN5zEKpvtiYbVs126FXFpackg3TI
         LiZTiX++B22LA6JJcaWoYiyhcEYGTH5iOv7VU3Y6W5OKVA/4cfmdKt6q4B2HrlY8fLFa
         kd+5bT0YeL0UTepKYUD5+vt4Mp8vjgxeM2layAq1JVddiP3zGWnun2JPbWQreDSn89DC
         nD6lMNzN64bPNJoPF5uuQCN0oMIGYHIfR42wp56faeuRKCfEpgO2XFSwlTJA1ne6NWlM
         LXaA==
X-Gm-Message-State: APjAAAVA4Uvh7LzibtfndVj442H4BPonu9FGmQD7gXXDTT3oY1osWDtJ
        YiwZi2KaxZWPIqaXcyqp3ElNXNpS5JxdVg==
X-Google-Smtp-Source: APXvYqyd3yOg4NaXOiiSFqpXKQuciExm5nky2I6MaamYJTkR7F+XGGCIOFvPLdiooYguNmRSf9Rl/A==
X-Received: by 2002:a17:90a:17ad:: with SMTP id q42mr11067718pja.100.1573190436040;
        Thu, 07 Nov 2019 21:20:36 -0800 (PST)
Received: from voyager.ibm.com ([36.255.48.244])
        by smtp.gmail.com with ESMTPSA id v19sm3798443pjr.14.2019.11.07.21.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 21:20:35 -0800 (PST)
From:   Joel Stanley <joel@jms.id.au>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>
Cc:     Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 07/11] fsi: Move defines to common header
Date:   Fri,  8 Nov 2019 15:49:41 +1030
Message-Id: <20191108051945.7109-8-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191108051945.7109-1-joel@jms.id.au>
References: <20191108051945.7109-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FSI master registers are common to the hub and AST2600 master (and
the FSP2, if someone was to upstream a driver for that).

Add defines to the fsi-master.h header, and introduce headings to
delineate the existing low level details.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
Acked-by: Jeremy Kerr <jk@ozlabs.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/fsi/fsi-master-hub.c | 46 -----------------------
 drivers/fsi/fsi-master.h     | 71 ++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index f158b1a88286..def35cf92571 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -13,53 +13,7 @@
 
 #include "fsi-master.h"
 
-/* Control Registers */
-#define FSI_MMODE		0x0		/* R/W: mode */
-#define FSI_MDLYR		0x4		/* R/W: delay */
-#define FSI_MCRSP		0x8		/* R/W: clock rate */
-#define FSI_MENP0		0x10		/* R/W: enable */
-#define FSI_MLEVP0		0x18		/* R: plug detect */
-#define FSI_MSENP0		0x18		/* S: Set enable */
-#define FSI_MCENP0		0x20		/* C: Clear enable */
-#define FSI_MAEB		0x70		/* R: Error address */
-#define FSI_MVER		0x74		/* R: master version/type */
-#define FSI_MRESP0		0xd0		/* W: Port reset */
-#define FSI_MESRB0		0x1d0		/* R: Master error status */
-#define FSI_MRESB0		0x1d0		/* W: Reset bridge */
-#define FSI_MECTRL		0x2e0		/* W: Error control */
-
-/* MMODE: Mode control */
-#define FSI_MMODE_EIP		0x80000000	/* Enable interrupt polling */
-#define FSI_MMODE_ECRC		0x40000000	/* Enable error recovery */
-#define FSI_MMODE_EPC		0x10000000	/* Enable parity checking */
-#define FSI_MMODE_P8_TO_LSB	0x00000010	/* Timeout value LSB */
-						/*   MSB=1, LSB=0 is 0.8 ms */
-						/*   MSB=0, LSB=1 is 0.9 ms */
-#define FSI_MMODE_CRS0SHFT	18		/* Clk rate selection 0 shift */
-#define FSI_MMODE_CRS0MASK	0x3ff		/* Clk rate selection 0 mask */
-#define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
-#define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
-
-/* MRESB: Reset brindge */
-#define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
-#define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
-
-/* MRESB: Reset port */
-#define FSI_MRESP_RST_ALL_MASTER 0x20000000	/* Reset all FSI masters */
-#define FSI_MRESP_RST_ALL_LINK	0x10000000	/* Reset all FSI port contr. */
-#define FSI_MRESP_RST_MCR	0x08000000	/* Reset FSI master reg. */
-#define FSI_MRESP_RST_PYE	0x04000000	/* Reset FSI parity error */
-#define FSI_MRESP_RST_ALL	0xfc000000	/* Reset any error */
-
-/* MECTRL: Error control */
-#define FSI_MECTRL_EOAE		0x8000		/* Enable machine check when */
-						/* master 0 in error */
-#define FSI_MECTRL_P8_AUTO_TERM	0x4000		/* Auto terminate */
-
 #define FSI_ENGID_HUB_MASTER		0x1c
-#define FSI_HUB_LINK_OFFSET		0x80000
-#define FSI_HUB_LINK_SIZE		0x80000
-#define FSI_HUB_MASTER_MAX_LINKS	8
 
 #define FSI_LINK_ENABLE_SETUP_TIME	10	/* in mS */
 
diff --git a/drivers/fsi/fsi-master.h b/drivers/fsi/fsi-master.h
index c7174237e864..6e8d4d4d5149 100644
--- a/drivers/fsi/fsi-master.h
+++ b/drivers/fsi/fsi-master.h
@@ -12,6 +12,71 @@
 #include <linux/device.h>
 #include <linux/mutex.h>
 
+/*
+ * Master registers
+ *
+ * These are used by hardware masters, such as the one in the FSP2, AST2600 and
+ * the hub master in POWER processors.
+ */
+
+/* Control Registers */
+#define FSI_MMODE		0x0		/* R/W: mode */
+#define FSI_MDLYR		0x4		/* R/W: delay */
+#define FSI_MCRSP		0x8		/* R/W: clock rate */
+#define FSI_MENP0		0x10		/* R/W: enable */
+#define FSI_MLEVP0		0x18		/* R: plug detect */
+#define FSI_MSENP0		0x18		/* S: Set enable */
+#define FSI_MCENP0		0x20		/* C: Clear enable */
+#define FSI_MAEB		0x70		/* R: Error address */
+#define FSI_MVER		0x74		/* R: master version/type */
+#define FSI_MSTAP0		0xd0		/* R: Port status */
+#define FSI_MRESP0		0xd0		/* W: Port reset */
+#define FSI_MESRB0		0x1d0		/* R: Master error status */
+#define FSI_MRESB0		0x1d0		/* W: Reset bridge */
+#define FSI_MSCSB0		0x1d4		/* R: Master sub command stack */
+#define FSI_MATRB0		0x1d8		/* R: Master address trace */
+#define FSI_MDTRB0		0x1dc		/* R: Master data trace */
+#define FSI_MECTRL		0x2e0		/* W: Error control */
+
+/* MMODE: Mode control */
+#define FSI_MMODE_EIP		0x80000000	/* Enable interrupt polling */
+#define FSI_MMODE_ECRC		0x40000000	/* Enable error recovery */
+#define FSI_MMODE_RELA		0x20000000	/* Enable relative address commands */
+#define FSI_MMODE_EPC		0x10000000	/* Enable parity checking */
+#define FSI_MMODE_P8_TO_LSB	0x00000010	/* Timeout value LSB */
+						/*   MSB=1, LSB=0 is 0.8 ms */
+						/*   MSB=0, LSB=1 is 0.9 ms */
+#define FSI_MMODE_CRS0SHFT	18		/* Clk rate selection 0 shift */
+#define FSI_MMODE_CRS0MASK	0x3ff		/* Clk rate selection 0 mask */
+#define FSI_MMODE_CRS1SHFT	8		/* Clk rate selection 1 shift */
+#define FSI_MMODE_CRS1MASK	0x3ff		/* Clk rate selection 1 mask */
+
+/* MRESB: Reset brindge */
+#define FSI_MRESB_RST_GEN	0x80000000	/* General reset */
+#define FSI_MRESB_RST_ERR	0x40000000	/* Error Reset */
+
+/* MRESP: Reset port */
+#define FSI_MRESP_RST_ALL_MASTER 0x20000000	/* Reset all FSI masters */
+#define FSI_MRESP_RST_ALL_LINK	0x10000000	/* Reset all FSI port contr. */
+#define FSI_MRESP_RST_MCR	0x08000000	/* Reset FSI master reg. */
+#define FSI_MRESP_RST_PYE	0x04000000	/* Reset FSI parity error */
+#define FSI_MRESP_RST_ALL	0xfc000000	/* Reset any error */
+
+/* MECTRL: Error control */
+#define FSI_MECTRL_EOAE		0x8000		/* Enable machine check when */
+						/* master 0 in error */
+#define FSI_MECTRL_P8_AUTO_TERM	0x4000		/* Auto terminate */
+
+#define FSI_HUB_LINK_OFFSET		0x80000
+#define FSI_HUB_LINK_SIZE		0x80000
+#define FSI_HUB_MASTER_MAX_LINKS	8
+
+/*
+ * Protocol definitions
+ *
+ * These are used by low level masters that bit-bang out the protocol
+ */
+
 /* Various protocol delays */
 #define	FSI_ECHO_DELAY_CLOCKS	16	/* Number clocks for echo delay */
 #define	FSI_SEND_DELAY_CLOCKS	16	/* Number clocks for send delay */
@@ -47,6 +112,12 @@
 /* fsi-master definition and flags */
 #define FSI_MASTER_FLAG_SWCLOCK		0x1
 
+/*
+ * Structures and function prototypes
+ *
+ * These are common to all masters
+ */
+
 struct fsi_master {
 	struct device	dev;
 	int		idx;
-- 
2.24.0.rc1

