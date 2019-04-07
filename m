Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6FFC10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637702083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSF8OCru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfDGVTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:19:33 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43076 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfDGVTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:19:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so3178360pgu.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1wRxZi157ucc3Qwp4VzctEHqrT2ggmt9hyXEywPrUtI=;
        b=lSF8OCrus69WaTflBXryG6fzIiNsIsmIWeIjgTIKFAmqac3Mu+2niO1Vw1oQMSIDYS
         aA6EGoMwBO1CZahRksBcY30Iecx31WFakQm22Plr/WBajh4nQdXs5d743TL2E+K7OIGQ
         AD/ug+Oa7GqMEaxfaoznPzF3g7GdP1VzzDIwetqPLVyjFWM7Mcih0M5a6PD96NgQC2Cv
         x0w9GyJmNE+dvtZi5C73V6RWXnwLkCph2oA7MvM7SfU2uacawatBJyb8kbkqnZ9rBeDp
         p3KduyIjvn5LjDCrnURZWBc6fcpUX4z+9uJ7B6jLS7ZqBt/OL/GY/zcN3zSCU4tko/fb
         rewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1wRxZi157ucc3Qwp4VzctEHqrT2ggmt9hyXEywPrUtI=;
        b=SM5IlGZjnq8VY3d9FY1U9hVnXxGzCKR7fiBfFdJyCrsj/q4fM5TjVwSF7nMSfEGqRS
         lt5t3aDdiIKvcNIoki49jUWQMiIqkLZWAqazW86FFI+Q1xqCSrYmrlHRLzcdRGzX9SGu
         dHq+VN2cysLeNp8IWzPDso6M5+WYMM/Jbr6WLp22a2nCxH/nNHhkmimVSMHFk5eFxxSL
         dSipfat6I20AwsPKsb5cCkIErIoA+ATUIyp1wmHJbECPBst0rVEafIWkhk0D8TLIOczT
         FzfqoLQZ4F2JD9TJLJuFmXM6qS1T541DwCaSatmwV2GTA6Py+X1hMdiI5alU8/vhye9q
         bR1A==
X-Gm-Message-State: APjAAAWRNSp6qBBSVh6uwpNOPFrYgK+JtjPIjxKfGo5R+yecqONjO79C
        5l5dHOFfr1vBej+Jj/9R3os=
X-Google-Smtp-Source: APXvYqxxR0iwcHq/bMqt61CzuW/M3+MfYKbc9SnjXws65zipRpgam5IqqjBz8fPEIFia5JUnPWGPtA==
X-Received: by 2002:a63:195f:: with SMTP id 31mr24847237pgz.116.1554671972662;
        Sun, 07 Apr 2019 14:19:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i15sm9105077pfr.8.2019.04.07.14.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 14:19:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] soc: brcmstb: Fix error path for unsupported CPUs
Date:   Sun,  7 Apr 2019 14:19:07 -0700
Message-Id: <20190407211910.8744-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case setup_hifcpubiuctrl_regs() returns an error, because of e.g:
an unsupported CPU type, just catch that error and return instead of
blindly continuing with the initialization. This fixes a NULL pointer
de-reference with the code continuing without having a proper array of
registers to use.

Fixes: 22f7a9116eba ("soc: brcmstb: Correct CPU_CREDIT_REG offset for Brahma-B53 CPUs")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/soc/bcm/brcmstb/biuctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/brcmstb/biuctrl.c b/drivers/soc/bcm/brcmstb/biuctrl.c
index 6d89ebf13b8a..c16273b31b94 100644
--- a/drivers/soc/bcm/brcmstb/biuctrl.c
+++ b/drivers/soc/bcm/brcmstb/biuctrl.c
@@ -246,7 +246,9 @@ static int __init brcmstb_biuctrl_init(void)
 	if (!np)
 		return 0;
 
-	setup_hifcpubiuctrl_regs(np);
+	ret = setup_hifcpubiuctrl_regs(np);
+	if (ret)
+		return ret;
 
 	ret = mcp_write_pairing_set();
 	if (ret) {
-- 
2.17.1

