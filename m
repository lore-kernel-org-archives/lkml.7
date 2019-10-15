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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9BCC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D0B2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je+bnMh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbfJOOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:51:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733002AbfJOOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:51:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so24196227wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVU/godtoQv4DaTv3SteCyrdF1xeYmNG3gGjlOL2mBY=;
        b=je+bnMh2iMgS8RPyMgkQZFclubihcMqnvxo7F9+r8I5QkRFOV4XODNkmLpjkmgBW86
         qbfMe8B4hwFU3dD7OtnrJchUzMPBRoUug5/nt+ulQAgqZHkPeI8AS2toLFd6uR63EKwY
         wJzr/UxIQGuH/Y62uIk2LtXSgcYNqtc/kQlCiTZQKrcIEaRv7ov5O7tFCaxGXjLBFxGf
         2r4a3rpNdGCSb0j+FwnIlToL5XZQ0qcRKnEV0LiMJi3rbWevOQvGFSkFuFlSzvh/S4tn
         /gFhFHOUsjym8CGJGmoWUFhn1WJRJt1CXnq9L0h9ZpD3J1BTL+jEBT7pJr1P0d1YWhop
         vDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVU/godtoQv4DaTv3SteCyrdF1xeYmNG3gGjlOL2mBY=;
        b=BKSVPSBuu0MGTsUgEbEl6AuaJIYHkjWybmFQbGbj7PAzli5ZrnrS1CGP4ebUT8h08p
         vhs4lQxMRpX+he2JOuC+u0kf4stoEOztYDJcouIzubNRQZ01S9m18DjB8whKRK4q9gS6
         vUptufoYMrd/1iupgq+kmoU/SLhvm5JzlQqk8ZcSmY1YJSRXy5CFpfP3SR68M2QtlZeE
         +7iqmtiBBRS/jAtZbgiIAQtNs4eFG+D3EPeoeiKrKPpJjrtBUEhMf1W7ZUlMi+JECdLs
         I6EWdowyPH+77H760gtKZ1s6MVGQ/6UtqMmr36w5g8reVJNfjhneDtUGeGipkjPvMSOs
         rSoQ==
X-Gm-Message-State: APjAAAWcvWzC25kOFsXNSCFV0rQfEpoyzvqHiKml3VMFFguIkpJFfitI
        D3yk6bLvoxfM/1ULEjBdzvg=
X-Google-Smtp-Source: APXvYqzxyrmF8m6jp6CA2DOs+xMZnw2mPPE30sPyfOc1/Lkdhzai01UBp+PivWAtSTN8LV4o8dciYA==
X-Received: by 2002:adf:eb0f:: with SMTP id s15mr29275926wrn.97.1571151115705;
        Tue, 15 Oct 2019 07:51:55 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id c21sm15940495wmb.46.2019.10.15.07.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:51:53 -0700 (PDT)
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
Subject: [PATCH 2/6] ARM: xen: Register with kernel restart handler
Date:   Tue, 15 Oct 2019 16:51:43 +0200
Message-Id: <20191015145147.1106247-3-thierry.reding@gmail.com>
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
directly.

Select a high priority of 192 to ensure that default restart handlers
are replaced if Xen is running.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/xen/enlighten.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 1e57692552d9..eb0a0edb9909 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -30,6 +30,7 @@
 #include <linux/cpu.h>
 #include <linux/console.h>
 #include <linux/pvclock_gtod.h>
+#include <linux/reboot.h>
 #include <linux/time64.h>
 #include <linux/timekeeping.h>
 #include <linux/timekeeper_internal.h>
@@ -181,11 +182,18 @@ void xen_reboot(int reason)
 	BUG_ON(rc);
 }
 
-static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
+static int xen_restart(struct notifier_block *nb, unsigned long action,
+		       void *data)
 {
 	xen_reboot(SHUTDOWN_reboot);
+
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block xen_restart_nb = {
+	.notifier_call = xen_restart,
+	.priority = 192,
+};
 
 static void xen_power_off(void)
 {
@@ -406,7 +414,7 @@ static int __init xen_pm_init(void)
 		return -ENODEV;
 
 	pm_power_off = xen_power_off;
-	arm_pm_restart = xen_restart;
+	register_restart_handler(&xen_restart_nb);
 	if (!xen_initial_domain()) {
 		struct timespec64 ts;
 		xen_read_wallclock(&ts);
-- 
2.23.0

