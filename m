Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A35C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84770218FC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5Z0Eri1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfDWWtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:49:35 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36973 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfDWWtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:49:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id h126so2367687lfh.4;
        Tue, 23 Apr 2019 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrbxXCzbduE6bxqzUV5O8VcSJ/8bNCEge0K7+QXqWcw=;
        b=C5Z0Eri1E/MgiwW5s2hJ0I1+mpTOAalvY1gdEQyVcQyh4k+SOdcbvwPxE/PwmN+QEI
         6L5RaXXhRNFfMEXXelOg9V8ff+GNNUNB5C40hqDz4G3Q8Djt0uRDxI/WKSP1cFdit0PI
         fUlugbB+qa0GPzP4IFVCeqRQV/h8ikqJ8erozIB8Ox/8stkwW3YGwHHuv0vjfGFOurMw
         ryncVMimSMKti+L1l0/QyZufwrnCCDY+aMc3X0oGHwajcD6vwD/0GidUyJwf1A1OPpqs
         6x84dc+Z39ecs9vxLaVKwJospMybQWYrIoUmyohkvCAo8y4mDNYX9qZiF4rKrdic6hUi
         hqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrbxXCzbduE6bxqzUV5O8VcSJ/8bNCEge0K7+QXqWcw=;
        b=Cy9wh4o1vzU1fQMt8WDaDiCwjt2zro2KDcorfi8q2hzGqwlVZzWN3i8cK3fKbFMNIE
         ELojqGAKAKk3/PdoPCS1KqfdUt04SXBT66mhIcTRSgHuayXUY1DD9VDTGgWk4KB7m9iG
         /J65sa/G3aNaPjnrjF/LcfqOYmevOXS6swYX8fNtafB1rCviNoT5pn4Iq282JDFzPTaA
         DHK9JagLrNi7cnLeM4kpN+/m6V/m9h58X+foaa7vRg1hHyfvqyJHk3AsG+oO64KgcgPu
         BvbosEAOyP1YvN0OHuEqm6IeXH4SGl86DYZqe0tqfx0a5IyI33XT5G74Cw44THBjtIgv
         YcYg==
X-Gm-Message-State: APjAAAUmTvFxl6mLEBo1YGfoRhdnBtZu9IWb1mQYDxDl/60kwkGSPrbN
        U54HUEe9TPczdAaQVaVidCU=
X-Google-Smtp-Source: APXvYqyCSnXCGC9FnalNaC5sKIc9QmhN7maCues08BcUfbwk7TStnH3zAzRnlwt60y5xL5hD2JrT3w==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr7455057lfk.129.1556059770067;
        Tue, 23 Apr 2019 15:49:30 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id w2sm4904722lfa.63.2019.04.23.15.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:49:29 -0700 (PDT)
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
Subject: [PATCH 05/12] mips: Discard post-CMA-init foreach loop
Date:   Wed, 24 Apr 2019 01:47:41 +0300
Message-Id: <20190423224748.3765-6-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423224748.3765-1-fancer.lancer@gmail.com>
References: <20190423224748.3765-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Really the loop is pointless, since it walks over memblock-reserved
memory regions and mark them as reserved in memblock. Before
bootmem was removed from the kernel, this loop had been
used to map the memory reserved by CMA into the legacy bootmem
allocator. But now the early memory allocator is memblock,
which is used by CMA for reservation, so we don't need any mapping
anymore.

Reviewed-by: Matt Redfearn <matt.redfearn@mips.com>
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f71a7d32a687..2ae6b02b948f 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -708,7 +708,6 @@ static void __init request_crashkernel(struct resource *res)
  */
 static void __init arch_mem_init(char **cmdline_p)
 {
-	struct memblock_region *reg;
 	extern void plat_mem_setup(void);
 
 	/*
@@ -814,10 +813,6 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
-	/* Tell bootmem about cma reserved memblock section */
-	for_each_memblock(reserved, reg)
-		if (reg->size != 0)
-			memblock_reserve(reg->base, reg->size);
 
 	reserve_bootmem_region(__pa_symbol(&__nosave_begin),
 			__pa_symbol(&__nosave_end)); /* Reserve for hibernation */
-- 
2.21.0

