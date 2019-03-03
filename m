Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB7CC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C534206B8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 17:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVN0WZ1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCCROE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 12:14:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39131 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfCCROE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 12:14:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id i20so1284174pfo.6;
        Sun, 03 Mar 2019 09:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JuH8Ap/N0CCqMGuBFEsBfvavZHslxZuq0RCbP2Dsuc4=;
        b=GVN0WZ1ccz4yXnERhF3aF4XTdfhZOFD5UTa9Gh1U05Xzr3VKrZ27x9IFApDU/gL3p2
         Fm6uRDwZsrKxlpjQX6Kaas0xGkHOkhpjrDDCR7JuMpAtzewy5GTGjjcXm2NNPYhTliTG
         Y1uo40O5E33d4vd6PLZakHaYDk6keeQo9m4lJffR9ZDCRXLoM0DvezWjjm2kljcnaFve
         Ch0p67BJwrzpwOx/VzB4GC7P8d9nmqKh9jM/2s+zKHbR5Btc+7zo/mbSBYp813PKSUFs
         m+3PDhqkFzPQ5zsRovZP+nuPJe9YpS3SEu26c2jQMLHtZx33L1J0O3bJFSlrozIGgZXz
         t0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JuH8Ap/N0CCqMGuBFEsBfvavZHslxZuq0RCbP2Dsuc4=;
        b=iH1rWigFz6wNNixsXOkq4YJ6WxD0wVTuSgZbL2QSNuSWNE+P0QpvHfYrTdUk2g5fsA
         53rwoj0DpMzw+ij6zj3z9tECVGWilqW7eBWHBDDCWsZm7eouFErFzAeLR/o3qTK0508b
         0mrtoyo/HltXoL6wcKAv58ogIwHen4/drnNz1GGyFHu3Ag8sc3ikzEV7elpW0XqMyvhy
         dPL55z6KCtpzI6vhYzahIGuxpc++PlXGYC4QpDb/jU/zQtpHi1z7UxrxQM8jFAe/g53f
         sTdMt/MIR2x6GTno7vJEp27e6iYEnf+AIE6Cvx+ZkU6LeB5WBrYG2+01hpCvn8vo56/0
         GKTA==
X-Gm-Message-State: APjAAAV1B7c9yo+YtSrrFMvNHAj2O2y0AwL1cII/wV4xlIq/dDfe5LCq
        G5QYU0xRBnnSjjIlBiWqkBs=
X-Google-Smtp-Source: APXvYqzbLlxWyEhg2eojea5F2ZLAM3FNNjHl1s50wR70kAVK5vJ98/a7OtAFTLrsCDN5nS1pIxnvNw==
X-Received: by 2002:a62:39c5:: with SMTP id u66mr15648749pfj.245.1551633243840;
        Sun, 03 Mar 2019 09:14:03 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.gmail.com with ESMTPSA id e22sm5349412pfi.126.2019.03.03.09.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Mar 2019 09:14:03 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Robert Yang <decatf@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date:   Sun,  3 Mar 2019 20:12:13 +0300
Message-Id: <20190303171214.24821-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190303171214.24821-1-digetx@gmail.com>
References: <20190303171214.24821-1-digetx@gmail.com>
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
index 809fbc200cef..31fb53f9ce13 100644
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

