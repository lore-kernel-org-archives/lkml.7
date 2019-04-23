Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6450BC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC09218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfuEeI/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfDWWt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46699 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfDWWtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so12985435lfj.13;
        Tue, 23 Apr 2019 15:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJ3xwWJXog1KPx7zXkBt+0FT1onV4wm00T3cYGUdK8o=;
        b=dfuEeI/xqrZujHXykgX4UeKXjmUGMkHpprck0gZu6b9Bl+E4QQtmhiG0xc2Hno05dN
         8NwdxoNghrzZa9uBXrKYxfALB8W0i2pkIt9A6r8VGoZIp4MJw/gte2dfoBfDvQaE9YoX
         5qKAZfvywTQAZJ1LFEqWlqlbkL7uAqlkt/3kzxq16ZwCtG2CH8rNUjnacYPTjQHY4Q4T
         5MBHpcQ6QrTZXh1oLEDtsPMmOGPJaHaSRO4wKCk389PNku/iR15uRauOVW2a/qWln0/y
         ScMdJNPbgjTei27drIJdmMnqPBQgtP3o4YsBPActjbdsufmqVipYWtTnNySptsptVU2V
         rvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJ3xwWJXog1KPx7zXkBt+0FT1onV4wm00T3cYGUdK8o=;
        b=bAGyEwtIF9JKMFfYJxnIqf/kbgITNZycpdv3ZWK2dDIkPK4u+d+sMvY6xyaTtQTBIf
         33qCDv6PcskbPqRnxVIbKCob4WX6t/YOMhobcsLqmCdHLe124a5bh4ASFb2U/Of3uiTb
         pUoBplqTda/Jge84aJ0+YS5wcshNESiqp4dhlI8667HUr+EURMeOJbF/6sgelsmL4uEV
         IHqK8QDXnPZQZGgYN1IFZNtnmuSPYMw3Hd1IoRaJL7D0P2IU8Alcdm0jOknXJGaahJx8
         fqUSCB/VwGx27Z8OYWs4aTAz/vcCskdPhyGApR8SuD9GrVWy8LfLzypjoRtsH13AxcV7
         6ouA==
X-Gm-Message-State: APjAAAWcYMTmqnJ9BDf+c7Z1hhaC/jK7xNoi/F9C0Hjnzo3sSMfQLUxD
        G4CLol9d6E/Xov9PP1MdkdM=
X-Google-Smtp-Source: APXvYqyST+f6mO8FvKsw8ef7ytV8eNa4Hb8jVjd1N5jWDJW1Qzvmq1+c+eepJUlQYzYSmUbWjijskQ==
X-Received: by 2002:a19:c216:: with SMTP id l22mr14887697lfc.112.1556059779541;
        Tue, 23 Apr 2019 15:49:39 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:38 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Huacai Chen <chenhc@lemote.com>,
        Stefan Agner <stefan@agner.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Juergen Gross <jgross@suse.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 11/12] mips: Make sure dt memory regions are valid
Date:   Wed, 24 Apr 2019 01:47:47 +0300
Message-Id: <20190423224748.3765-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are situations when memory regions coming from dts may be
too big for the platform physical address space. It especially
concerns XPA-capable systems. Bootleader may determine more than 4GB
memory available and pass it to the kernel over dts memory node, while
kernel is built without XPA support. In this case the region
may either simply be truncated by add_memory_region() method
or by u64->phys_addr_t type casting. But in worst case the method
can even drop the memory region if it exceedes PHYS_ADDR_MAX size.
So lets make sure the retrieved from dts memory regions are valid,
and if some of them isn't just manually truncate it with a warning
printed out.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/prom.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/prom.c b/arch/mips/kernel/prom.c
index 437a174e3ef9..28bf01961bb2 100644
--- a/arch/mips/kernel/prom.c
+++ b/arch/mips/kernel/prom.c
@@ -41,7 +41,19 @@ char *mips_get_machine_name(void)
 #ifdef CONFIG_USE_OF
 void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 {
-	return add_memory_region(base, size, BOOT_MEM_RAM);
+	if (base >= PHYS_ADDR_MAX) {
+		pr_warn("Trying to add an invalid memory region, skipped\n");
+		return;
+	}
+
+	/* Truncate the passed memory region instead of type casting */
+	if (base + size - 1 >= PHYS_ADDR_MAX || base + size < base) {
+		pr_warn("Truncate memory region %llx @ %llx to size %llx\n",
+			size, base, PHYS_ADDR_MAX - base);
+		size = PHYS_ADDR_MAX - base;
+	}
+
+	add_memory_region(base, size, BOOT_MEM_RAM);
 }
 
 int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
-- 
2.21.0

