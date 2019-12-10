Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6DEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB2207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyUwBS4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfLJXfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:35:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41978 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLJXfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:21 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so22032923wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G+wCCxELpXTMTODBtQxVzlpdhMD07gWVo3Cm9lJtjRg=;
        b=KyUwBS4pGPDF7wvXMOV4I8Bbg7GmXjcDAQLZx0u8OVKG64bmRKIGHYBBXSJc8Xworg
         hsnIATXlUfKzWMusOYK+x4+C0foj4yr1wsGXOLiY4expytTXmErFF2bUihjVFmYonXCS
         a0ghcSjKfN8sAheTzFtJ2axa3UtGlHelsw6sTqiL2J5e9uJw7UGcJecxsAzRi6+aKolu
         uI2QLs+Qog0RponIvXvV5GRYZ0OU7QAOw3zX7llKtT2S4XeaJ2Ga4IodKo9aT0FoxMeW
         0T7NuSNoLHv0sfBTm82knjIfLB/Y3NY5fpSCTwJN3fKD+wqvkEv8TD/Zi7WQYqpW/TWV
         AOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G+wCCxELpXTMTODBtQxVzlpdhMD07gWVo3Cm9lJtjRg=;
        b=UZTlPHhwuwDWqMYvUi7PMAklVjS31arjl3FFBNfxz0F5hpVKMgC9eS1UAx7DfOHZLG
         YwgwDjRn1Y1DhsvQ7EvEjoSFVntaJ/Qpqvfu5AeH3iooHmehHTackqw9RNWGrTO06yyM
         gt6nXgPBh4fiNcEUtlGyg84EwlNOCnTAgdOsgGkF/8oe9ERgzcdgTEb/ys4ZwnL87c5G
         vZZP7Cxhn//ywUUFJPM2dIqcG0RbtacM/IypEfcmrbtFrh2SPtzwnFjsv01m4ZLRP6qy
         o6RL8xrzhoKW+6zdmnmMgmYqrDgG4lFI/TvF50OzGPv/kaOqNW9Um6ERMBXTOX1okhrH
         RNHQ==
X-Gm-Message-State: APjAAAVo/vPocaLV3loCKb/QNAG9cYnLFV/a5GftX8Ndl8MJX1uQ+cjX
        VBBtN3PpsjFzgcVPx2A2VXo=
X-Google-Smtp-Source: APXvYqwyWZunvJHNmDlzFLYRDzl6HUS6mGqymy/cjcjhWsvhQk9251cWu6yixsBoNAwx5r6W26Vjbg==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr120700wrm.394.1576020919711;
        Tue, 10 Dec 2019 15:35:19 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm59478wro.88.2019.12.10.15.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:35:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] soc: bcm: brcmstb: biuctrl: Tune 7260 BIU interface
Date:   Tue, 10 Dec 2019 15:30:40 -0800
Message-Id: <20191210233043.15193-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210233043.15193-1-f.fainelli@gmail.com>
References: <20191210233043.15193-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7260A0 and B0 are both supported, and 7260A0 has a small difference in
that it does not support the write-back control register, which is why
we have a different array of registers. Update the comment above
b53_cpubiuctrl_no_wb_regs to denote that difference.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index d326915e0f40..6be975392590 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -63,7 +63,7 @@ static const int b15_cpubiuctrl_regs[] = {
 	[CPU_WRITEBACK_CTRL_REG] = -1,
 };
 
-/* Odd cases, e.g: 7260 */
+/* Odd cases, e.g: 7260A0 */
 static const int b53_cpubiuctrl_no_wb_regs[] = {
 	[CPU_CREDIT_REG] = 0x0b0,
 	[CPU_MCP_FLOW_REG] = 0x0b4,
@@ -102,6 +102,7 @@ static int __init mcp_write_pairing_set(void)
 }
 
 static const u32 b53_mach_compat[] = {
+	0x7260,
 	0x7268,
 	0x7271,
 	0x7278,
@@ -157,6 +158,7 @@ static void __init mcp_b53_set(void)
 static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 {
 	struct device_node *cpu_dn;
+	u32 family_id;
 	int ret = 0;
 
 	cpubiuctrl_base = of_iomap(np, 0);
@@ -185,7 +187,8 @@ static int __init setup_hifcpubiuctrl_regs(struct device_node *np)
 	}
 	of_node_put(cpu_dn);
 
-	if (BRCM_ID(brcmstb_get_family_id()) == 0x7260)
+	family_id = brcmstb_get_family_id();
+	if (BRCM_ID(family_id) == 0x7260 && BRCM_REV(family_id) == 0)
 		cpubiuctrl_regs = b53_cpubiuctrl_no_wb_regs;
 out:
 	of_node_put(np);
-- 
2.17.1

