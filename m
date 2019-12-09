Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E90C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87960207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQU+mceG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfLIQWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:22:42 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42166 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfLIQWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:22:41 -0500
Received: by mail-pl1-f196.google.com with SMTP id x13so6002958plr.9;
        Mon, 09 Dec 2019 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxCCKK6EbTljivQeXfzc5xr/RzcnsI4Myx01Zz/zBfw=;
        b=cQU+mceGpsWaoTO3m+Fi0YxKvpce+Z6P/uDX6T0zHFnz85nwH3tiu5RRmygUwSXCf7
         TEh3q6eAhHAucqtHpWDyBHjWC85IsLAa/jxREnhhRrwqjF2HT+SFWeM2PFTQ1Hkb22uQ
         DdvO3G/CM3lU+dZdwWHLIhRrhQKzCPTEN2yDVbWeevbFQYTrwe13uU1QVEJyTkekKeNv
         xSdfwa0VYbW+oSFwYuB8M0BCAIK2FDPDWlnfjueQ9UEoaR4i+RArgRtfudeluV30dgkV
         7UcyiW5dIfvP7LYTARsxo5gbc5PF4c+AYSKVStmz3nOb3/mbJOHTVYuDVj8vO76TACPF
         aVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rxCCKK6EbTljivQeXfzc5xr/RzcnsI4Myx01Zz/zBfw=;
        b=JSC5qEEMZEvdy+bQzvTgag8w34vx4PsGkPBodubNk80lgIpFCw9uujhk3lo6GuuVNt
         diBxLHX44L5Ts3Z5IbqMqzPriCuLLq3cFoOjLr9x+XTjFJVSjmf7Ni9pHGedxRjh8jO0
         Pzz0DrJRIbQ0KB5Who8IJIzFSCRl3eO78Sq2z6FHiWqpckvjMHn0BTxZiicsfYKB57ez
         RSvOuGwuEIg8qgbBWyHGGXoXAXwSyw5nKQq7Z+b/IIjc2S/ygL2SdjfkrGpRYoC0jgOZ
         vgCZgGcxLwkmE/JX3MRV+m8W2XtIF0O9Q65vtY6g/eaL1kVX8BJMjYMUWewdw2pB+s0W
         kTyw==
X-Gm-Message-State: APjAAAUsOfUxt3wxBGHzZUSjovEjd+xhEuHJeJUHH56KY7S35XAA6LAH
        kiqWhOJKuVpn8NrRBg8BSdo=
X-Google-Smtp-Source: APXvYqwmTxa/n1SRZwfjfU0EtpbVQwa9rTCwUJjQsyj0HpbQUeqo/X8PJPcCdGY6LwsPqm2kEONJjg==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr33242359pjn.61.1575908561176;
        Mon, 09 Dec 2019 08:22:41 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id n26sm46000pgd.46.2019.12.09.08.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 08:22:40 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@linux.intel.com>, x86@kernel.org,
        Bruce Beare <bruce.j.beare@intel.com>,
        Sheng Yang <sheng@linux.intel.com>,
        Yunhong Jiang <yunhong.jiang@intel.com>,
        Alan Cox <alan@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] x86/platform/goldfish: add a check for platform_device_register_simple
Date:   Tue, 10 Dec 2019 00:22:30 +0800
Message-Id: <20191209162230.14991-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goldfish_init() misses a check for platform_device_register_simple().
Add a check to fix it.

Fixes: ddd70cf93d78 ("goldfish: platform device for x86")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 arch/x86/platform/goldfish/goldfish.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/goldfish/goldfish.c b/arch/x86/platform/goldfish/goldfish.c
index 6b6f8b4360dd..e9694baf6e72 100644
--- a/arch/x86/platform/goldfish/goldfish.c
+++ b/arch/x86/platform/goldfish/goldfish.c
@@ -44,11 +44,16 @@ __setup("goldfish", goldfish_setup);
 
 static int __init goldfish_init(void)
 {
+	struct platform_device *pdev;
+
 	if (!goldfish_enable)
 		return -ENODEV;
 
-	platform_device_register_simple("goldfish_pdev_bus", -1,
-					goldfish_pdev_bus_resources, 2);
+	pdev =  platform_device_register_simple("goldfish_pdev_bus", -1,
+					goldfish_pdev_bus_resources, 2);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
 	return 0;
 }
 device_initcall(goldfish_init);
-- 
2.24.0

