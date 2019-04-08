Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5322C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91821904
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je+jL6gP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfDHQdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:33:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44851 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfDHQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:33:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id i2so7611304pgj.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C300X2ejQ0xFADjlLWpFw9mFDk88hw+DVLLPDxl1UTY=;
        b=Je+jL6gPURZDjEEQ3d0+o0FZ6LjEoRC2hFwg0ImYPEdFJtIWK9cVTl2kvkf5G6FEhY
         ZFoDWeyDOwIJ4qAmRq7A/UK59G/Hd2UMv4nFoR2+sw8mhS1G8ODTa/gS4QQJ6q1H5ePk
         2cEQEypAdbxH7WRmppypIeFdFn/0aSqYTPNmGniexC67+opupNaKWwMFH2DwJlzsaH8r
         DgzlWADC8aGGxqbNcrlWNEcTY1ofR4iQtRjU1RUc5UZ/hW0NX9hsmG6zfpXGBomZKdU7
         f8tXiDG1Ap7Eccsb4tfnmbzU1xlaGhrdVxhlIuY54O2sU00Rw1C9npVdUnde8ORJ5TN8
         t3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C300X2ejQ0xFADjlLWpFw9mFDk88hw+DVLLPDxl1UTY=;
        b=KtUh89mP/lTRjYnntMlWF7nmrpMIek3UDnILHuA4vE/8iJrApCkalSv1dHvqRI8w/f
         eybUsntbmESmIivQ6ewpm2eEKWjIhvk8DHX+r0OUUZ7dqwl53mBemAeq/4tnCDk1hPEc
         ggSYyybjnW50zImn33cNeEjfjH2EDc19mLO7u+mIy6CDwj6m/e6pbgEdq2PjaYe/W9RV
         9q+fdnLa01ZY8xDkwn1omqdci8L87oW0TyMN3PkhnYcteM5RTPTpT3DxBzeMv0+BkZZ7
         d4HJC0H6a14vyvimjaEsOoGXrQwYbSAjzZonea7qqiOoRRSskRPxM+p5UYVciZ/yZ6kV
         IexQ==
X-Gm-Message-State: APjAAAVu3xtktr/Hm7ywbTHewEU1vfaPU02QE+vJUEqC7+YXGLtE1/Di
        /Lc4Nxkmyt7BfKi2pfeQPws=
X-Google-Smtp-Source: APXvYqy0kUXps/GeV9TXWv3PEQyG1DnlMKuVeb/qB7cTSHPZbIECRmNWBNJmI9gWz+4BTeqKqLtabg==
X-Received: by 2002:a63:465b:: with SMTP id v27mr29906732pgk.165.1554741221982;
        Mon, 08 Apr 2019 09:33:41 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e3a7-6c70-b197-cec7-ec88-495a.emome-ip6.hinet.net. [2001:b400:e3a7:6c70:b197:cec7:ec88:495a])
        by smtp.gmail.com with ESMTPSA id 143sm62117103pge.50.2019.04.08.09.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 09:33:41 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     will.deacon@arm.com
Cc:     catalin.marinas@arm.com, steven.price@arm.com,
        f.fainelli@gmail.com, ard.biesheuvel@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vichy.kuo@gmail.com
Subject: [PATCH v3 2/2] initrd: move initrd_start calculate within linear mapping range check
Date:   Tue,  9 Apr 2019 00:33:19 +0800
Message-Id: <20190408163319.10382-2-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190408163319.10382-1-vichy.kuo@gmail.com>
References: <20190408163319.10382-1-vichy.kuo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in the previous case, initrd_start and initrd_end can be successfully
returned either (base < memblock_start_of_DRAM()) or (base + size >
memblock_start_of_DRAM() + linear_region_size).

That means even linear mapping range check fail for initrd_start and
initrd_end, it still can get virtual address. Here we put
initrd_start/initrd_end to be calculated only when linear mapping check
pass.

Fixes: c756c592e442 ("arm64: Utilize phys_initrd_start/phys_initrd_size")
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: pierre Kuo <vichy.kuo@gmail.com>
---
Changes in v2:
- add Fixes tag

Changes in v3:
- adding patch of shifting linear region randomization ahead of
 memory_limit

 arch/arm64/mm/init.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 5142020fc146..566761da5719 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -442,6 +442,9 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+			/* the generic initrd code expects virtual addresses */
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = initrd_start + phys_initrd_size;
 		}
 	}
 
@@ -451,11 +454,6 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_initrd_size) {
-		/* the generic initrd code expects virtual addresses */
-		initrd_start = __phys_to_virt(phys_initrd_start);
-		initrd_end = initrd_start + phys_initrd_size;
-	}
 
 	early_init_fdt_scan_reserved_mem();
 
-- 
2.17.1

