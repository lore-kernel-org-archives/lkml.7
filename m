Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C69C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A0420730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="f+I6TTus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKRKUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:20:02 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42884 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:20:01 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so18721198wrf.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aIG1Xs8CximUshNbJxyPtBPvFKjMVJbgnvYEwuyYulk=;
        b=f+I6TTusrhAY+d8zDvsW6jwhr4o3NBdDCpVDnHlk7Xeao//1HsuBCmUKwMlv98y6uT
         0p31Zx4T/uuA6abVzMfXF8fBo/8wdCvVUDBA5fI091Q7x3uQFL3QN/5Q5rhefqRx2+kX
         r6ICtK/lYal5xdxn7THRquofYsDYCWyx9jNQbgBJAGR7tgIX1ZSUniZo5lt0WNi4Mkcp
         SaiXkad658ezrWJtR4ThFLZHP49WW2ZpgbpHiWjf3pLZ1du6Loza7iQto7gr1Ml83/zu
         v1UXD72JdwuBKf1nwniYX+c6EsKeHUgDVqy3W+5psLmdQneCa5uQRqVxQGqEQdnSaekf
         JI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aIG1Xs8CximUshNbJxyPtBPvFKjMVJbgnvYEwuyYulk=;
        b=QUpHuaPAjBpaW6QRdSOObVp4+CQwXmV8ljiUlGkRsFgPZwJn/+ie+TJ1bZRnkrl7GX
         +M5d7PT8SsMHaQU4emQF/s/5oKlePBKtOBdP/x0WTHD+ZjEIysPkHcWiV6Z2MwWnBmZO
         tR2Qt6HbcAw72iWDQLbkySpO+2CdO66QXFU+QgejZG5Wndljw4FKVCmXoKhYc+/q5Hy4
         VDsXcRMOAUi9RiQomsawEho29nyJAyCQURsHtw+KGre81AZb8mEvgbNHQkdmfSDYXht0
         7XLJl2in6cJpeFYEoLU24Zgoj5Ni0+Prw5NtY6QAwwXLHtA5kpODF1S2MdDDYzrZ63lf
         9xMQ==
X-Gm-Message-State: APjAAAVtVNr2g4wTL/pyk1Jss1qjOA2OcGyw9vV3bmtHj9gOafUXr79E
        0OiCB036qQCQTWrtRX6nfhR7+MMJLp0QZ1CT
X-Google-Smtp-Source: APXvYqxj5yb4+Yzg5YMxHvCcq+thT7DVcUMNY61ucJB9VnPgIZyyfSKghJEosLTGYt9vfMdTpncBow==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr30430983wrq.109.1574072397612;
        Mon, 18 Nov 2019 02:19:57 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t134sm20766740wmt.24.2019.11.18.02.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:19:56 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v3 3/3] firmware: google: Probe for a GSMI handler in firmware
Date:   Mon, 18 Nov 2019 11:19:31 +0100
Message-Id: <20191118101934.22526-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118101934.22526-1-patrick.rudolph@9elements.com>
References: <20191118101934.22526-1-patrick.rudolph@9elements.com>
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
-v2:
	Add missing s-o-b and add define for reserved command.
-v3:
	No changes.
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

