Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D8CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C4F22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kerBQVkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfH1VkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:40:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35981 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1VkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:40:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id d23so1162343qko.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EmTT1pcCHOo3mELkDkITKYJZl7OtTPiDcR2k8eCL0AE=;
        b=kerBQVkWoaLKOuaN5C0EeFfDfBmhedtWjA/6EuWLPDeK0IXyfY3ifMPGc38ncPlDQW
         1HRTfUaHDM/gL9vDo/Tb2lk6GosB/UH43GB/lzCLwJM8jUtfflf1jxq/KlyMvkcNrrIG
         up7O5A79KguoaieH5rUwP46b9gyPG2rCb7/hogh41hnfL8U1Ksv2uq9uJUu3EBllYoyt
         jnKXcZPHVS9ObYNdpC6F7yWv4JvNacVwcEqNvKu2oI8lKZSMhq2LoPExhToVntelF6wj
         ktwgih9i2yMvsMRjDGSaAebTUhMLA+HeaNiwGMJ2nxBmorGpaeZ/HI13A40SBZMpk5Sw
         Sq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EmTT1pcCHOo3mELkDkITKYJZl7OtTPiDcR2k8eCL0AE=;
        b=YH9GwsuRTel8jvcINN4ZihZEz0wgSf42Gb4TtY37/EYDBC6Pvwrhf9ro9S/avwwmuP
         SaTz3VrwH8PwgJTcLlSuoKyY9pxXEMa0xc3zST4wDlawTRaMvEETtkVNhqAdBvhxQSyf
         AA9ZQ+MnpuxSmZW1aePW/JdbVGX2ghkUCbdTqoYQMrsomRNv7WLExYA0ZCCXhA02SYJM
         ppvrXIWf3d4rHWDEKlxtV+sCf27c/l23cL+DkmrB5CH4UtTjUdrGzQZh+DNbBxqkV30o
         ivKRUu8AYf7tfssmMkgUNfznmotZ3KHuz028vt3iruxDrqftfKjGP1Z73wPvQf/uzqh+
         w8PA==
X-Gm-Message-State: APjAAAWKIhxR5VMiE8rgMI0l+KMxnINRowMe4cB9hzq4VLKngbUdb0ZX
        eLEQwQb1PCjBdom6DRimjKc2LLqtnrA=
X-Google-Smtp-Source: APXvYqynvZd1tC0QzKBhqumYU9ToK5PK+egw85h4ro5wfmFlMYgX830omiwHI+ghfNzm9NerCLZRig==
X-Received: by 2002:a37:a0c2:: with SMTP id j185mr6211520qke.123.1567028402940;
        Wed, 28 Aug 2019 14:40:02 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r4sm273053qta.93.2019.08.28.14.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:40:02 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/amd: silence warnings under memory pressure
Date:   Wed, 28 Aug 2019 17:39:43 -0400
Message-Id: <1567028383-29325-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running heavy memory pressure workloads, the system is throwing
endless warnings,

smartpqi 0000:23:00.0: AMD-Vi: IOMMU mapping error in map_sg (io-pages:
5 reason: -12)
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
07/10/2019
swapper/10: page allocation failure: order:0, mode:0xa20(GFP_ATOMIC),
nodemask=(null),cpuset=/,mems_allowed=0,4
Call Trace:
 <IRQ>
 dump_stack+0x62/0x9a
 warn_alloc.cold.43+0x8a/0x148
 __alloc_pages_nodemask+0x1a5c/0x1bb0
 get_zeroed_page+0x16/0x20
 iommu_map_page+0x477/0x540
 map_sg+0x1ce/0x2f0
 scsi_dma_map+0xc6/0x160
 pqi_raid_submit_scsi_cmd_with_io_request+0x1c3/0x470 [smartpqi]
 do_IRQ+0x81/0x170
 common_interrupt+0xf/0xf
 </IRQ>

because the allocation could fail from iommu_map_page(), and the volume
of this call could be huge which may generate a lot of serial console
output and cosumes all CPUs.

Fix it by silencing the warning in this call site, and there is still a
dev_err() later to notify the failure.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/amd_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b607a92791d3..19eef1edf8ed 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2547,7 +2547,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 
 			bus_addr  = address + s->dma_address + (j << PAGE_SHIFT);
 			phys_addr = (sg_phys(s) & PAGE_MASK) + (j << PAGE_SHIFT);
-			ret = iommu_map_page(domain, bus_addr, phys_addr, PAGE_SIZE, prot, GFP_ATOMIC);
+			ret = iommu_map_page(domain, bus_addr, phys_addr,
+					     PAGE_SIZE, prot,
+					     GFP_ATOMIC | __GFP_NOWARN);
 			if (ret)
 				goto out_unmap;
 
-- 
1.8.3.1

