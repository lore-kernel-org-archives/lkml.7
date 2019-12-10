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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402CC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08661206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 23:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMiO3uR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfLJXfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:35:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37658 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfLJXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 18:35:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so22109824wru.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 15:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bz/VQlnz1v5AapS+5W6yfHgO6/GtfVjJurkUMo3Qj+c=;
        b=XMiO3uR/UOvB8/0OkYcGo0WzEqQthD3zK9VQDl1SgddDSMaOSCwhiuLqBrm5kd2LDq
         LCvn5ToNLJXtSnw1XMcptooNxusKlNCtsIbm3VgOfIx3Z/Rs6/KdC9/f67x8YYFarIJY
         8AiQIBM2DvN+jLNA+pMpQoJ0m6Ruj3zlMSM+/vDcKu25b97NDbSG4TOJp7dqJKkT4I3I
         Vz7nvOQ8ZvgLcUTFUY4d75hKbjjUYtL1y09agbpek9YYyq9xH/ozZskvupcHIMOCaCRa
         kjNR1yRdDlw8Ow4sorCd+JTxm0+OAyVPZtRTYaZKE5G1Stk8SEAvE0z/ul2rGUl0uqBF
         O1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bz/VQlnz1v5AapS+5W6yfHgO6/GtfVjJurkUMo3Qj+c=;
        b=rh75pJW9wBRPdWVUwwsDTDrUO2L9/lRCU5PflRm7ycqmu+oNiiVBbX8UCh2iVt8oGY
         4hIYddq330cu97d5bsvMfrJtlwaKbd//SMrK11Rx7YTnYUn5GKF8/igHF4bhUfI14B47
         Gx3vRj8C2q+ofntoGxJTBu5LGdOfAFSMWyB2jzCj7Z6N6FqH5asdkdXiLm9KdfcV12lH
         P3QrxLsk0dvr1I0sXKq0jliMdVlDIU2q2bRi/KYiKUDbfw7g/A6oNxhIitQvR2oT8Gvh
         VUkqR5MBeyC5c2550JdzSQaT/6yI3G/KHUszpJkttTm81lgBdv4lxDGwkbAqwbmBwKdo
         3iPQ==
X-Gm-Message-State: APjAAAUwJ4cYd1VAQO+vkbyOkSz7yhtUJmfbcMG3RqT/80XwrI9lbSQH
        Fspv3R4kV7s+rucZwxBxjUY=
X-Google-Smtp-Source: APXvYqwIv3ahhcp5oA0qthC+C2oIZVWxnkywGlQdzWkYiCi0KoHVvw+BTTuKL/H1IUVai4VYIn36Uw==
X-Received: by 2002:adf:ebc1:: with SMTP id v1mr85673wrn.351.1576020925098;
        Tue, 10 Dec 2019 15:35:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n16sm59478wro.88.2019.12.10.15.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 15:35:24 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/4] soc: bcm: brcmstb: biuctrl: Update programming for 7211
Date:   Tue, 10 Dec 2019 15:30:43 -0800
Message-Id: <20191210233043.15193-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210233043.15193-1-f.fainelli@gmail.com>
References: <20191210233043.15193-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a matching entry for 7211 which can be programmed with the same
BIUCTRL settings as other Brahma-B53 based SoCs. While at it, rename the
function to include a72 in the name to reflect this applies to both
types of 64-bit capable CPUs that we support (Brahma-B53 and
Cortex-A72).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index d766577bc5d4..61731e01f94b 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -107,7 +107,8 @@ static int __init mcp_write_pairing_set(void)
 	return 0;
 }
 
-static const u32 b53_mach_compat[] = {
+static const u32 a72_b53_mach_compat[] = {
+	0x7211,
 	0x7216,
 	0x7255,
 	0x7260,
@@ -116,19 +117,19 @@ static const u32 b53_mach_compat[] = {
 	0x7278,
 };
 
-static void __init mcp_b53_set(void)
+static void __init mcp_a72_b53_set(void)
 {
 	unsigned int i;
 	u32 reg;
 
 	reg = brcmstb_get_family_id();
 
-	for (i = 0; i < ARRAY_SIZE(b53_mach_compat); i++) {
-		if (BRCM_ID(reg) == b53_mach_compat[i])
+	for (i = 0; i < ARRAY_SIZE(a72_b53_mach_compat); i++) {
+		if (BRCM_ID(reg) == a72_b53_mach_compat[i])
 			break;
 	}
 
-	if (i == ARRAY_SIZE(b53_mach_compat))
+	if (i == ARRAY_SIZE(a72_b53_mach_compat))
 		return;
 
 	/* Set all 3 MCP interfaces to 8 credits */
@@ -261,7 +262,7 @@ static int __init brcmstb_biuctrl_init(void)
 		return ret;
 	}
 
-	mcp_b53_set();
+	mcp_a72_b53_set();
 #ifdef CONFIG_PM_SLEEP
 	register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
 #endif
-- 
2.17.1

