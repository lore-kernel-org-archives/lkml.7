Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47038C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D1E220718
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 08:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BazAFLyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKRIj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 03:39:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44978 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfKRIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 03:39:28 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so18327424wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 00:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/4KEkLITq2bAD2Q4JLMyFpEUnZBBMmBfjgRPECjVtM=;
        b=BazAFLyy02yC+PNnAgDSZQFqJT1Orv2PdA02ZSK6GElQM4LdfBdBS6cbJzJ7vFtIOi
         MpaS3JUEbn4dXGOZffT/Q7WMKvsKtkjlF5gyTeRqih4u/I+WqrJEaB3+4GNLJr4KzHvF
         nM/KLDfoZPrjjTBuX7TvQ7/fhUZUrpQClQPstArW+3K0BX0AjWzUjhC8o67RyCJ90cYq
         /gxjz5ylu7K1IyOZDMEIdrun47ZjIn9YHzqWs1xY/fWT9vskRxUk5X4O+WiUORBy2Ho7
         nftOUpUEt9ji6UgAr1EkwHMnHqRR3Y9EVF54v2GmCeC8aCQF+1l15jnZ0L1G4UIcjlGN
         7djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/4KEkLITq2bAD2Q4JLMyFpEUnZBBMmBfjgRPECjVtM=;
        b=rAhsXfeEZzZ28c4tp7E2ukBgMFAa7sprRaE631dcqW32pxTooyTRiUAEVy6XQpSt2U
         kS6ph/p21Qtne4pBw1u1SEA9dkSEXY0kRO3KUrFQFRYF2nsyXJsw7kh77B6XywCrmCjI
         pUDBLz1lFuUxi0+RcciFkHJd9CXgxkcLk56pYx7YwJq7KWbxiVWOWEhurpBwyL5JI8/S
         mlsrs0fGWcijs2Q1LZgI3nBdINr3qT4GXSIjje3CJQioPhVrsdtfg9Tfxrv+0vx6UoLY
         +cBg8ArpTsIFh5sB7M8HW+fDz9AdeEk1mspaFiItUMUanHS/BZmLA1bePQlbb5jOZujV
         0h5w==
X-Gm-Message-State: APjAAAXCCn5vpQlc8rKhukFntT6HOkFNJjyLeNFkS0vhis4xu8bQ2BnX
        NWesO07trcJoBbMu1AvLmRoab3V3g65PxW/x
X-Google-Smtp-Source: APXvYqy1m69WCYdOYXWEnMpikQ9jG7ZoLkJpwh41mDFaVYDbbtOju/Wg+LXKZdFH9OxwdWvNjba1Kw==
X-Received: by 2002:adf:f18e:: with SMTP id h14mr10606428wro.348.1574066364683;
        Mon, 18 Nov 2019 00:39:24 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id z14sm21700530wrl.60.2019.11.18.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 00:39:24 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [Patch v2 3/3] firmware: google: Probe for a GSMI handler in firmware
Date:   Mon, 18 Nov 2019 09:39:00 +0100
Message-Id: <20191118083903.19311-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118083903.19311-1-patrick.rudolph@9elements.com>
References: <20191118083903.19311-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Heymans <arthur@aheymans.xyz>

Currently this driver is loaded if the DMI string matches coreboot
and has a proper smi_command in the ACPI FADT table, but a GSMI handler in
SMM is an optional feature in coreboot.

So probe for a SMM GSMI handler before initializing the driver.
If the smihandler leaves the calling argument in %eax in the SMM save state
untouched that generally means the is no handler for GSMI.

Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 drivers/firmware/google/gsmi.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 974c769b75cf..5b2011ebbe26 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -76,6 +76,7 @@
 #define GSMI_CMD_LOG_S0IX_RESUME	0x0b
 #define GSMI_CMD_CLEAR_CONFIG		0x20
 #define GSMI_CMD_HANDSHAKE_TYPE		0xC1
+#define GSMI_CMD_RESERVED		0xff
 
 /* Magic entry type for kernel events */
 #define GSMI_LOG_ENTRY_TYPE_KERNEL     0xDEAD
@@ -746,6 +747,7 @@ MODULE_DEVICE_TABLE(dmi, gsmi_dmi_table);
 static __init int gsmi_system_valid(void)
 {
 	u32 hash;
+	u16 cmd, result;
 
 	if (!dmi_check_system(gsmi_dmi_table))
 		return -ENODEV;
@@ -780,6 +782,23 @@ static __init int gsmi_system_valid(void)
 		return -ENODEV;
 	}
 
+	/* Test the smihandler with a bogus command. If it leaves the
+	 * calling argument in %ax untouched, there is no handler for
+	 * GSMI commands.
+	 */
+	cmd = GSMI_CALLBACK | GSMI_CMD_RESERVED << 8;
+	asm volatile (
+		"outb %%al, %%dx\n\t"
+		: "=a" (result)
+		: "0" (cmd),
+		  "d" (acpi_gbl_FADT.smi_command)
+		: "memory", "cc"
+		);
+	if (cmd == result) {
+		pr_info("gsmi: no gsmi handler in firmware\n");
+		return -ENODEV;
+	}
+
 	/* Found */
 	return 0;
 }
-- 
2.21.0

