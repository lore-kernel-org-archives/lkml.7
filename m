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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E02C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C4C20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJcLAGgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733109AbfJOOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36817 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733002AbfJOOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id y19so24268002wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zLfyJeA9wa/YShlK3MTXpdAT71OVQlJTB0HHADMFohY=;
        b=jJcLAGgH3KuOU3eX27h1xp0fXk+FeZtURkHP/vua0EHtKL9+eYSnWolQZeqH7OkkHO
         d3bdzGyReUjNjy8cA66+kS5qLgIK1m4Wj374o0S6jdVR8ToTUbKv2oukynUtiUcmRvpc
         yjsLOGm1sciv3p2FzABejkzNm8JhpEfhm8JmqGGE7CjDtvXwfnpb8rHJhU/OJJKd6Q9g
         n/MCGzKLmRCZQ7nDEVMBJIlWjxmJoko2/SD8wQSD0KWuRKeFHsiktCMlEI5W0o8jAwgs
         EfqvcN1tGtFxsaGX3XRsf7LhOEstrVD3IKcEq9R+IrtUQW2ZgvPX0XPiuk8G/gvD6sem
         We6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zLfyJeA9wa/YShlK3MTXpdAT71OVQlJTB0HHADMFohY=;
        b=VDaU0qpuyyMTOSocSEukf4U1Ninluap3TOJkqGhY9VYy8UybfZWY93hCymyDgRK/o1
         /f0tdbDv4JEjzo+UZu7ibA3WMn2SwHj/NqCWBzguUzVZyIT9E6t9k3CTAknjCNjoq2tI
         T+H1Hw2Quw3msMDqEovv1C0SCdvbKiATI2xxB5NjXNWNI6NgF+hgGqfWkBy0sWKcrQh8
         vI0m2sZCN3O54XHsxnAeGtqa/C/CcuoCyJ1jWR2ed6/o8CwnXIDNeZaadMdPtur2z8bv
         pIVy4eBsUFoaUvJoYhe6BPRI94nHbJPgbOZ7I809YDXcZ/k7akGD1dxqgG/VgpgD+5a3
         c8wQ==
X-Gm-Message-State: APjAAAWtmZm1duOVpJcQBPRF+ry6KZEzrpSFnqbTV1TmaGQPbj4R0Rvk
        i1kAJ147yviEplL3AacPT/M=
X-Google-Smtp-Source: APXvYqyK0W3enqiUQRAcQi/YcLuvRxhG58xq5BuRJanN1ASn+Veb4bXPmLK+LGenLNx+s652oa4pHw==
X-Received: by 2002:a5d:46cb:: with SMTP id g11mr17438319wrs.346.1571151118976;
        Tue, 15 Oct 2019 07:51:58 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id o4sm52925154wre.91.2019.10.15.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:51:57 -0700 (PDT)
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
Subject: [PATCH 3/6] drivers: firmware: psci: Register with kernel restart handler
Date:   Tue, 15 Oct 2019 16:51:44 +0200
Message-Id: <20191015145147.1106247-4-thierry.reding@gmail.com>
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

Register with kernel restart handler instead of setting arm_pm_restart
directly. This enables support for replacing the PSCI restart handler
with a different handler if necessary for a specific board.

Select a priority of 129 to indicate a higher than default priority, but
keep it as low as possible since PSCI reset is known to fail on some
boards.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/firmware/psci/psci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 84f4ff351c62..a41c6ba043a2 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -250,7 +250,8 @@ static int get_set_conduit_method(struct device_node *np)
 	return 0;
 }
 
-static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
+static int psci_sys_reset(struct notifier_block *nb, unsigned long action,
+			  void *data)
 {
 	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
 	    psci_system_reset2_supported) {
@@ -263,8 +264,15 @@ static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 	} else {
 		invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 	}
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block psci_sys_reset_nb = {
+	.notifier_call = psci_sys_reset,
+	.priority = 129,
+};
+
 static void psci_sys_poweroff(void)
 {
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_OFF, 0, 0, 0);
@@ -431,7 +439,7 @@ static void __init psci_0_2_set_functions(void)
 
 	psci_ops.migrate_info_type = psci_migrate_info_type;
 
-	arm_pm_restart = psci_sys_reset;
+	register_restart_handler(&psci_sys_reset_nb);
 
 	pm_power_off = psci_sys_poweroff;
 }
-- 
2.23.0

