Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8A8C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 961F220715
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="dkMZ06Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfKONuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:50:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39787 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbfKONuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:50:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so11057154wrp.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DtCOEoZRvpiL2rtE2jADoSIb5UZYsHBk9Ic+0WuGsEY=;
        b=dkMZ06SgPhrsq6gUthMe0A6DP/sxLf9qgqvpMW8/xIjR6YVyRPoUbKP9JSSAGeZLWU
         yjrmOWbmvsPXMO5ko+ray5ZTJiEQmqnz061hXRxQZNEppxa5XwhpzYsmKjMxf8Xa4nFw
         9mS05FGShWEauyzrrpVHuaS91cCkJpgAQ8TntZgaLymN//3kwZYRFn2fDZLBoIFdj2a+
         AaZ3Qc3ZGdizZm0juc9icEhXetmzuJxahRjH6+gsT7UJZlVjFluhgYErLecSWLkRHlDA
         8IKq60u5Ns1A2w6LU4gKz/g7558dW4hKyU7+44aaYzg9wTWOlkcXii1CohCThFy7drn3
         f47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DtCOEoZRvpiL2rtE2jADoSIb5UZYsHBk9Ic+0WuGsEY=;
        b=nORkie/TWjFUFpsdP3T7BCYbuq5PaBIhrS2EV9poJvjRU5rMozVlOoLzK19Dobjcl9
         gWDADQBeB8v0Trdm6aMRukQ8G/GY5GK3BeoS7jkd+FEyhH8G1JmYS+V+lrO+tpyOoWpL
         ltf9umc/Ws2O3Cl1/sj1x5R0jB/kX4YUTcryn8wPPYd4K7L/QRngdOC43gAjRQM9RaQ8
         4CAXcn9BxT/UC3J8z61/3MapRCqc4nGekp3DXxXKGIMm+gkPcJHmMVByOawFXwLVgGAa
         Bhi/eFs0HyHQx4psvs43vU/4lXI21Rh5X5xTITT/11hdo+WARGTqSaUMUeHvFHEyeTkH
         30HQ==
X-Gm-Message-State: APjAAAUCTks+znuQHZS+PBogppQKxj7Ung2QNguv/E8VfvWOZRC84/lN
        HJSLLUECY26cNS6CBgVEyP8A1eCF8sfnA9aP
X-Google-Smtp-Source: APXvYqzo/+Va6gr7I/rbvxNNvbAxYiP9krGdhyDgy4RKEAo1BBGSaT3vkX7r8S94dVA/o4FpAjFs2w==
X-Received: by 2002:adf:f985:: with SMTP id f5mr15230637wrr.364.1573825815656;
        Fri, 15 Nov 2019 05:50:15 -0800 (PST)
Received: from localhost.localdomain (ip-94-114-101-228.unity-media.net. [94.114.101.228])
        by smtp.gmail.com with ESMTPSA id f14sm11119906wrv.17.2019.11.15.05.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:50:15 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, patrick.rudolph@9elements.com,
        Arthur Heymans <arthur@aheymans.xyz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [PATCH 3/3] firmware: google: Probe for a GSMI handler in firmware
Date:   Fri, 15 Nov 2019 14:48:39 +0100
Message-Id: <20191115134842.17013-4-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115134842.17013-1-patrick.rudolph@9elements.com>
References: <20191115134842.17013-1-patrick.rudolph@9elements.com>
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
---
 drivers/firmware/google/gsmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 974c769b75cf..a3eaa9f41125 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -746,6 +746,7 @@ MODULE_DEVICE_TABLE(dmi, gsmi_dmi_table);
 static __init int gsmi_system_valid(void)
 {
 	u32 hash;
+	u16 cmd, result;
 
 	if (!dmi_check_system(gsmi_dmi_table))
 		return -ENODEV;
@@ -780,6 +781,23 @@ static __init int gsmi_system_valid(void)
 		return -ENODEV;
 	}
 
+	/* Test the smihandler with a bogus command. If it leaves the
+	 * calling argument in %ax untouched, there is no handler for
+	 * GSMI commands.
+	 */
+	cmd = GSMI_CALLBACK | 0xff << 8;
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

