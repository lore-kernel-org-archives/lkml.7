Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65144C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8AE217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUjtyZ4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733125AbfJOOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50964 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbfJOOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id 5so21245848wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEZBP16nHW2RPcRxavfdMwmjl1huY8K+6hT/6zFfEzs=;
        b=ZUjtyZ4ZeuWmh4zTLAG2FyIShRg7/OsCE25XJV+7YoQUzX6v3dSVaLIW6XVZQhKp2o
         afgFeVzkwjFJRFFqoyIvnX7/7PrQglJLmyZHy8cxnlw2kafXEyBpO4z+kFoOLG0dAxkY
         H40uVdG4/mJFb3dNs8LRX2fXFx1bHGDFoD9DbJ6Oly9r9gHXzQ8zpLhhfb+GhnSTBvaN
         /hzuZIhsgNFHQYUY/Ppu8Aqw2rYzXiq16RX91ShOfv/kXEK+3a1Nv7Ld8bPPJa7de+mG
         lcrAT7bLioSA4ZPUUrwLI9nWR4X/p1EEhZyuQ8blUWlUnsQwuXu0D/xHff5FQDC6uIDu
         ZcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yEZBP16nHW2RPcRxavfdMwmjl1huY8K+6hT/6zFfEzs=;
        b=RIeJ4DfS2jRtaEqXjerow8WrEHr4ObMq80lC7fnKG+82nk+YUuZGCOVz1QJ3C+WQrx
         WDgmDRKYmbcPNz0+r70q+pcdhz/cyvZc5IMT1JhpEiSOg7MbSplT/v1Aa3OUc3bohtnc
         FUDS7N7y6/YRMwMGhWfWmp62PpeE+nFbQqmFqsqp0fV8d3RDxXWg6or33f4wBL7D8QSw
         cBhwo59stGKXuMWyFMUN/mA1gt4QpSxI6XcgWfg4SjdzsBiv82yZHFWv5rkGWujkSRet
         FgII6qdDcK9g4Wt8uzMh7yL+/YpaEZ3r+QqBrBuj2SLDBgFt9LbcnNGIBKJIY9eIo6Z1
         k7Tg==
X-Gm-Message-State: APjAAAWHpJhskttNSjwnJre2GV13nfGs35J60T8sThHlfGraka2xWdvT
        dx+xS6k5G+/uG+RJTSMySnjIUPvP
X-Google-Smtp-Source: APXvYqyJfag8Rywn8xKOzMaRcnGItNxyVt4QbdJ54reFHlzPLxgGyeV667E9ugpTZWtOcXSEEOS8lw==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr19511255wmj.125.1571151121269;
        Tue, 15 Oct 2019 07:52:01 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r10sm24764805wml.46.2019.10.15.07.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:52:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARM: Register with kernel restart handler
Date:   Tue, 15 Oct 2019 16:51:45 +0200
Message-Id: <20191015145147.1106247-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015145147.1106247-1-thierry.reding@gmail.com>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

By making use of the kernel restart handler, board specific restart
handlers can be prioritized amongst available mechanisms for a particular
board or system.

Select the default priority of 128 to indicate that the restart callback
in the machine description is the default restart mechanism.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/kernel/setup.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index d0a464e317ea..d403648195de 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1073,6 +1073,20 @@ void __init hyp_mode_check(void)
 #endif
 }
 
+static void (*__arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
+
+static int arm_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
+{
+	__arm_pm_restart(action, data);
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block arm_restart_nb = {
+	.notifier_call = arm_restart,
+	.priority = 128,
+};
+
 void __init setup_arch(char **cmdline_p)
 {
 	const struct machine_desc *mdesc;
@@ -1132,8 +1146,10 @@ void __init setup_arch(char **cmdline_p)
 	paging_init(mdesc);
 	request_standard_resources(mdesc);
 
-	if (mdesc->restart)
-		arm_pm_restart = mdesc->restart;
+	if (mdesc->restart) {
+		__arm_pm_restart = mdesc->restart;
+		register_restart_handler(&arm_restart_nb);
+	}
 
 	unflatten_device_tree();
 
-- 
2.23.0

