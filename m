Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336FC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F27205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCiGWSZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfLEClF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:41:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38944 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbfLEClF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:41:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id o9so575665plk.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 18:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=X+lqgHIiRLBY7DQHCQbM7VobhB8S+PBBkbBvINIo7h4=;
        b=uCiGWSZSL2YSHomU4B+jTR89AljcueykPHFPG9k/9p0HQdJGXdOrTdJ9b0hzyLqz5W
         o8lRCYsSFVDNREt4sAEH/McuWNVCE73GLLwCbCoa41jnHZH7efgqOr1RKrLVerDeCH1T
         VNx2BX2nGCgJRX8wBCcah6N4x68SQKvKt91rkF+V8QI+E/n4bv3EGB9MDdGZGoh6qf4N
         hOkcbtg4UaFOlgn9RVLsCnK/VhIxFRcmeE5Kqf88DbW0UwUZMOhdle5NyE5+TOq35RYS
         5nfXdIh8qOnxiuWzJ2JdXmMPbazRnZWyyYQ/BKkW+REnqlLYXz9wASKTMwsTcRMdkqGJ
         tg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=X+lqgHIiRLBY7DQHCQbM7VobhB8S+PBBkbBvINIo7h4=;
        b=MiZA0imC7vvL3d5AoWViYQXYfBDiWYR/ox7ETC/mxXiLGqYNfqNeoZUPHNvPGavsii
         Ox2HC9oOzXP7yRE8r0nNfIb1xgQ8/N8UTghSqOapW0r6E4qBJVm1SErH+GIcXj7jZ7xt
         l6mGwDt0mSAo1JES7+/7/3J92tCeLjtVOL8+tQcvO4DYqLW21t+aN/DQXzSh8ehBrKus
         /K6QqFZ2gtzMaDnB2r4p33Ib9e4hh9BioMpdFhWg9/RC2h5XX3wbWumW1YEeQRzpiNDY
         /pnwKe+NRmveml+gtAnR0YJ/yhI5muv/miFCEvK4igv4HgjIfSBdg6Ny5kAhDavH/dm7
         H6tA==
X-Gm-Message-State: APjAAAVY8La5LOQCX7XVRYT2bxkchhrpKGaQ8JTiZQa1h6hCgE8GkIBp
        iTFKdMHVlOL5mFeVqTrd6BQ=
X-Google-Smtp-Source: APXvYqzu6O2DqKF873cvUST7UP6Ab9oVXV7IFyak+mrZq5h56vxW/Ax/Z6g669Xbbkh1MiIQAFWVYw==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr6993893pjz.116.1575513664637;
        Wed, 04 Dec 2019 18:41:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t65sm9635566pfd.178.2019.12.04.18.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Dec 2019 18:41:03 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ley Foon Tan <lftan@altera.com>
Cc:     nios2-dev@lists.rocketboards.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nios2: Fix ioremap
Date:   Wed,  4 Dec 2019 18:41:00 -0800
Message-Id: <20191205024100.1066-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5ace77e0b41a ("nios2: remove __ioremap") removed the following code,
with the argument that cacheflag is always 0 and the expression would
therefore always be false.

	if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
	    IS_MAPPABLE_UNCACHEABLE(last_addr) &&
	    !(cacheflag & _PAGE_CACHED))
		return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE + phys_addr);

This did not take the "!" in the expression into account. Result is that
nios2 images no longer boot. Restoring the removed code fixes the problem.

Fixes: 5ace77e0b41a ("nios2: remove __ioremap")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/nios2/mm/ioremap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/nios2/mm/ioremap.c b/arch/nios2/mm/ioremap.c
index b56af759dcdf..819bdfcc2e71 100644
--- a/arch/nios2/mm/ioremap.c
+++ b/arch/nios2/mm/ioremap.c
@@ -138,6 +138,14 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 				return NULL;
 	}
 
+	/*
+	 * Map uncached objects in the low part of address space to
+	 * CONFIG_NIOS2_IO_REGION_BASE
+	 */
+	if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
+	    IS_MAPPABLE_UNCACHEABLE(last_addr))
+		return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE + phys_addr);
+
 	/* Mappings have to be page-aligned */
 	offset = phys_addr & ~PAGE_MASK;
 	phys_addr &= PAGE_MASK;
-- 
2.17.1

