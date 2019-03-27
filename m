Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B382082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSBcKdpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbfC0Nls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:41:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38012 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfC0Nlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:41:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id 10so9741008pfo.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=g64NzOYHhFaeLQNMRHtCoZ/wUSvowjY4eT4QLVZOk5M=;
        b=BSBcKdpJJCrXUjnoptIA+TlIulw+CJnhVw1MrAGaIXgATaDnns+m79mb8U91VGup2t
         0SootiOv0xgF1vlqFjZG49Vqxvq1y0wBGd1W3hmhObAOSJlJeUorNYJ/YFOCVck1Evbq
         KO305+EyiAxdMBdmyWkzNiypnM+Sy9LD5RxfCsnXbfgIAZgzJuEfMfYlUycBWZeTiPDw
         F8ylPjjWFj+kqalzPn5i0idLSaAHpgSTbQkhND8Y5xy6VvSQLlLmZmhWG+YT+AabJj1p
         dQO6qLIkYisGpltWVV0y+GRE1BMrf3XCV7zjB01PM0pGRXDlMTMmfT3cb8Q5S3t3bc5w
         Bm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=g64NzOYHhFaeLQNMRHtCoZ/wUSvowjY4eT4QLVZOk5M=;
        b=MAN1yMJExY7f89dKeB/mEfg7p+nT8q0XA8Mki+Cjw+031K1LO2zQiDbpf1veZsJoRw
         FXd85ciAo/SsctzO7Q9VRmQigxv00HSbh/rAAtNTnS7Udm0MDw5Eag3ueclt8O4VYcF4
         Uvf1cEsqwmewF8StlGquLZrbqzsftTlV6CI/Cj+GZG0cVbme6CdWVfKdW5dLkjV1PrNG
         YId5oqYsjy8OLDkHyxivJ7uMS6SjuJKl/a+VkbsyVuQ449CLPzrGzwTO7ItyjCO7avZB
         gCtF5jsxFCTTb82z4H2cxHKgEI9FzOrqwNXhwKwf/v54iUpoTf+EDPvaIEkbd9IIYwl4
         I59w==
X-Gm-Message-State: APjAAAW9Hr9D5n9oXp48qK1/o2RqxFwGr/Wf3uCIeZ1EH/XoL62+VWxV
        BUrCfI5CiX3jSNd9ozHMeeBbKKw8
X-Google-Smtp-Source: APXvYqxfvv1JXWxWUiUzaQoZLUvdLLN/UVZs9I2Qdf32Qsbfl2hNyQEhnU6bcT0RugfLlBApfEzMXQ==
X-Received: by 2002:aa7:8a87:: with SMTP id a7mr36509717pfc.252.1553694107263;
        Wed, 27 Mar 2019 06:41:47 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([49.205.222.128])
        by smtp.gmail.com with ESMTPSA id 71sm18759471pfs.36.2019.03.27.06.41.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 06:41:46 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     linux@armlinux.org.uk, paul.burton@mips.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] arm:mach-sa1100/hackkit.c :  Remove duplicate header
Date:   Thu, 28 Mar 2019 00:41:36 +0530
Message-Id: <1553713896-25575-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2..0016d25 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -22,7 +22,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
1.8.3.1

