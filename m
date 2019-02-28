Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5241218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfX95nbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbfB1PAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45513 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732644AbfB1PAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:00:02 -0500
Received: by mail-lf1-f66.google.com with SMTP id h10so15456263lfc.12;
        Thu, 28 Feb 2019 07:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnxVFjv0sJZsDhiPW9qc3IgJCRO74aOC680wPGEHp64=;
        b=MfX95nbZZ0XHuXMwK/7/BscyvQyC/bbD+2xbf9d+h4hzxIGNhVvvaL/GBCxRBeN0ig
         24Ba0uus+RLusNOvdFwhySUTxoTAAp/Anv4z4RAajPiMMOWZYq04oyycpW4slE9GCVWT
         hga/5SuGkjSsTUMkEm+CFWTfkyF8XxO7nLPQMw/Uk0MngqTSV7ThMdgm05MB7iysPPxw
         g198pp7HmtRHNT2FNT/qR5dbUVVNEB+3uYdI4QjEUpVVHBbuJILxp4diw+5SCDQ/psRJ
         452PuetAyA4M2l9JMsqXJIv95vMAxv8pPSe4zKBeuG5lX7ZCP1kpUQsnQeG2J9IQPXpX
         O7+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnxVFjv0sJZsDhiPW9qc3IgJCRO74aOC680wPGEHp64=;
        b=CqaPWC7cPp06pCbrF473P45s4/+DHTcPPXGl5wcw5L8RoqhpHmJDSqLXdTHwD4+2zD
         bdTgBsz6LMDyGYqE6WVqgwuDXeFVLKLqPtkbg345LDrCj74Ur8sN8tgrifxhdpO9Dmvu
         FyFgiyfCvp9kCROFepeG1tfGZpo8yYmAP6mFUG5gbbBm2IrVNl3I6HHVkUJhEtfJkGnU
         KibrTTOioW1q8aVbrYJJKGSn7K68PPM8pooRQErHUweNHoO+HjdqQXKqB2zj9pGE1bYF
         0peI7jRx8b899+HOXOGRrFwh2EwVPEkwVh9yjdPuvUmhpGg0zugXVZD9CJfyUqCCy/y+
         LxoA==
X-Gm-Message-State: AHQUAuZycFqRTazaH9GDmC5Unp1h1FQfPTOQHHNhBsgOopClYFgRptw9
        zgoxC4UV5t1zkUFOaQuYqVc=
X-Google-Smtp-Source: AHgI3IY0zRY9X8UGQ4wJ8cYEmj3o5MhDTL9yUEHR+orYUg2Qk/cqky8zAMhA5nrAORGPOujtUJO/Sg==
X-Received: by 2002:a19:cbc6:: with SMTP id b189mr4504553lfg.34.1551366000298;
        Thu, 28 Feb 2019 07:00:00 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id z20sm4728309lff.87.2019.02.28.06.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 06:59:59 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date:   Thu, 28 Feb 2019 17:59:36 +0300
Message-Id: <20190228145937.27725-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190228145937.27725-1-digetx@gmail.com>
References: <20190228145937.27725-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Tested-by: Robert Yang <decatf@gmail.com>
Tested-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1

