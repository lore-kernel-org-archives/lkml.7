Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98941C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345B20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8sS501G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDHIH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:07:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38479 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfDHIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:07:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so13611886wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eETP41IES64G6d2VWh0CccmMhh0+VN/BPxiIdaxr2eA=;
        b=X8sS501GmNUqzyl+5ai0554WhNdS2Jc0hME8tsmlN1G9IC8v+V1g9YVNBhC9yIuLV8
         0NoG+SwDnovFf/cwZOoG3cjMPSfwpaybXZNil8BUd4DyDzKxVNhdo7G73xlKMbG/DvlF
         4VptigRC3aEtrq85svw16JPq8JRqZYpSbm/+cSl0un8+HgFiA64LrbxM6Vkn7NL6oGui
         CnV3wbCXJncZWPsJ9Q3ylYSAV71aus13T5/EuCztWIvY8cdljoLMCr+Lc2BdpZ/16LUn
         CiRKoFkg/EM9OmAukX6hozLhlx0Q6jqvxx7vVLI/aZmyaI8VDcwqqw6q3zFYmOtWhyim
         YDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eETP41IES64G6d2VWh0CccmMhh0+VN/BPxiIdaxr2eA=;
        b=QTUBVSEB5WKv/tnYJrjsQD34A7XEiGhuxMvs0uJ3XdxFUGpg82Z5WOXeWLHlXmBhs1
         TAr3W8WXx4rWUNFjZ19u/Y0iHek+slnjRQ3p6vs8ZObT4rwWozU0LAzug5h8SWPLxlbz
         rTldykgCiFNdXePx8dKMusDP7f3rfEDKAhMIyKR7r5CDkg7GKDur4uF31JnrQ+cJJ8+k
         pYTA9D49k9ty7W5zofYSqOrhIp5F0HznaDftRcHQQs64AteKUBIsYLO3j7TzP1K1L3BZ
         gicp5JfrYxIF5XsiJvFKrZeYpktnFDjaSxKuw5FY9c29N1AnvhKEFz5cohrPCQKgThQD
         s2LQ==
X-Gm-Message-State: APjAAAWzh2vMUFC1j4qr+tIzIHS/kB1De0j+7VcMs93pUdYdxecQ91gI
        qCWpIA6hhXT8GfsJc1HvlD0=
X-Google-Smtp-Source: APXvYqy9iQfQfvl1k59ZpNTJQUfNEXnw10Npx2Un6xLvqEzF380fEGrMQ4YAQOsbFaEkaFGp0QDnGw==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr17362775wmi.7.1554710873376;
        Mon, 08 Apr 2019 01:07:53 -0700 (PDT)
Received: from localhost.localdomain (85-169-74-166.rev.numericable.fr. [85.169.74.166])
        by smtp.gmail.com with ESMTPSA id f1sm8374450wml.28.2019.04.08.01.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 01:07:52 -0700 (PDT)
From:   David Abdurachmanov <david.abdurachmanov@gmail.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Subject: [PATCH v2] Add COMPILE_TEST to CONFIG_ARM_TIMER_SP804
Date:   Mon,  8 Apr 2019 10:07:45 +0200
Message-Id: <20190408080745.22012-1-david.abdurachmanov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is only used on arm and arm64 platforms. Add COMPILE_TEST option.

Tested with 5.1-rc3+ on Fedora/RISCV. CONFIG_ARM_TIMER_SP804 no more shows
up in riscv config.

Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 171502a356aa..ede5d20299b9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -379,7 +379,7 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module"
+	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
-- 
2.20.1

