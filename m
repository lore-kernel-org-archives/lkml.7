Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B7EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15EAD20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJ5Vhr7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfCNDVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:21:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43456 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCNDVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:21:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so2833125pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 20:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ccAeTLQBdIVAFjTPGt6RXumwLGC6PlH3sQ70vUsR9Gc=;
        b=qJ5Vhr7NaYOZCTOrqsEMP0xuKedlfAVu/AcWGo1mtWZpE8DdW0UR8LBe6g6f3Jkm7F
         b3TnGn3R9eqZOwQDXe/ft16SQvDbsLiNG6Jchww8aBHb/3bQbAKbUI7Z0O/8weRsKYak
         OBC2P/FoLWQRe7hUoxY6Vgr+ZMhBvL37uql7WQIysftP4V392D97frV0nHUlzsWzCZfy
         xrjOEuauYOnTQIouaed0NUd17ube6yCwj2SYLsfSARcgOSalONCwCOqFNN9ozmmeXkHZ
         A8cs27/ZZpcxBv6MonidoCRbfS9F7qzrpctxnAqPN7uUhfbMrVI45CbJXLRsHKPyFTLl
         2SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ccAeTLQBdIVAFjTPGt6RXumwLGC6PlH3sQ70vUsR9Gc=;
        b=lqmh0BztS9oVxdTfVS+Cc8GabyhYwS9FmF2RaMoAfduBmhbX3KrqA4ueJNHV2aSrZb
         LrY//5paEw/iu81Ua3J93lCujvKv5s90AHmbxKu1pjPDAfObggUIVznoPHCZpdInx+iZ
         Fl/NbX79KruMVUKC4nHwmbCFuO4oNOez9dvF1B45zYdsIW77XRN6Dc87RTvAMINrcZxr
         XdbZSiMgV+Z7yTg4emkiLJ3q5j7iTRJQq/JCBIDK4M4Jx3DZ7Nz67b4B4zIodTnLhdBQ
         srF6Qn4RV7erWNnvjlkjNXsNdppfpw9/GW8BHuoS+PiH0EaSGXn6EzvJDTksIJUeTzF9
         nvhQ==
X-Gm-Message-State: APjAAAUljcnRUPFS1qNFmajcjLghRUiUSrUEQpgzGoFLOhSy9BcB7lK4
        +CDFO04mj+VixSU1JuQJgFoc8UXd4eM=
X-Google-Smtp-Source: APXvYqwNBOCf+zxKuePzfJX1TgnaqQiLZ3rNd/PuIziuO2iDt+lL44cbIy+QuyfsM4znNoYaE3aUxw==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr42681148pgp.275.1552533661385;
        Wed, 13 Mar 2019 20:21:01 -0700 (PDT)
Received: from ubuntu14_04.bitmain.com (61-220-100-83.HINET-IP.hinet.net. [61.220.100.83])
        by smtp.gmail.com with ESMTPSA id p5sm19215693pfn.154.2019.03.13.20.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 20:21:00 -0700 (PDT)
From:   pierre Kuo <vichy.kuo@gmail.com>
To:     steven.price@arm.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        vichy.kuo@gmail.com
Subject: [PATCH v2 1/1] initrd: move initrd_start calculate within linear mapping range check
Date:   Thu, 14 Mar 2019 11:20:47 +0800
Message-Id: <20190314032047.15790-1-vichy.kuo@gmail.com>
X-Mailer: git-send-email 2.17.1
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

 arch/arm64/mm/init.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 7205a9085b4d..1adf418de685 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -425,6 +425,9 @@ void __init arm64_memblock_init(void)
 			memblock_remove(base, size); /* clear MEMBLOCK_ flags */
 			memblock_add(base, size);
 			memblock_reserve(base, size);
+			/* the generic initrd code expects virtual addresses */
+			initrd_start = __phys_to_virt(phys_initrd_start);
+			initrd_end = initrd_start + phys_initrd_size;
 		}
 	}
 
@@ -450,11 +453,6 @@ void __init arm64_memblock_init(void)
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

