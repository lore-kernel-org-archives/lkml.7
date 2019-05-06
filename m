Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EB1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287332087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 16:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RZP1gxQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfEFQpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 12:45:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36199 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfEFQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 12:45:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so1343203qth.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 09:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw1CQVY/cHhWeaEwQ2kRf2lUFBfYFKrqRbosS5HnbMc=;
        b=RZP1gxQmoEfNa/deQD18cJwQgEfXJRmrQWv0Ssqt34FWc2aR7Dhb4/bECvxQfXslf+
         dJw4zZWSHbXQ4K6kIzgBHAeWW1DC6xFBz+HSqgdF/ISVJQFqXSxs1HMJ5tb9ZZggPjDy
         fYUJNOn6pEM5q+1Vwm9gGBmrs4+3a1sd37ofGvKHNvmzCw9NexyXPWh94J7/W9cu4LoF
         bG7PEHtVyrkqr90hP9lDiebLsXgtxsrz6cNmpY6D0WE722vzneTQIFCXczmFsSFDqkbK
         dmoLNLCg2urZRskZWZwUK9RxKFw5wDbn5q3MEpeKUW6fgcTBzDsglobV4j5fUjKEpQkj
         hBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yw1CQVY/cHhWeaEwQ2kRf2lUFBfYFKrqRbosS5HnbMc=;
        b=VPJmBB1/n1enY5sVCFOPT3uMie1KAFiUt2O/6Gvwul8NrJrjVP16iK+NWbrRuP4VJb
         pla1GVl8fEIoKM7Axm9b0/YD3eLyH6EFuqNjgZDKDh8na6enHkGq3/JrsXuAak9cUTCc
         Fyjir9s+kPj+Lla+hywqAJKicOeNMY0tcmWOiWw3RzRwzpWHrZNoCpfFNka+8Z5IXEx0
         2rKRCXV6eMXd2+nj6HfjnGLnwfdNuAAgYsh8hwmypF35Puj0ayfQh84AlncKjFkY8YrL
         xslZOdRN2SNudifGWmt6s09ABpXbqk3fZzwti6MJEsdoKogUCUOyP1+e2xP0fVNx+Y7A
         Pk0Q==
X-Gm-Message-State: APjAAAXNY4deLbzoQ1FXHf1JWfYsNS5RDCcFpCMwAL1AMUfh8tuXbK6K
        2U1xUHHc34giHicxjm4zuWPXnA==
X-Google-Smtp-Source: APXvYqyd5uChF7QMQOSWLYqOgUB9e0Y4zz58txydcoExvh6WOCf+olrM0YBjhpcw7agtARUorcMbDg==
X-Received: by 2002:a0c:c491:: with SMTP id u17mr20558041qvi.70.1557161116586;
        Mon, 06 May 2019 09:45:16 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 20sm7221212qtu.51.2019.05.06.09.45.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:45:15 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     tmurphy@arista.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] iommu/amd: fix a null-ptr-deref in map_sg()
Date:   Mon,  6 May 2019 12:44:40 -0400
Message-Id: <20190506164440.37399-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 1a1079011da3 ("iommu/amd: Flush not present cache in
iommu_map_page") added domain_flush_np_cache() in map_sg() which
triggered a crash below during boot. sg_next() could return NULL if
sg_is_last() is true, so after for_each_sg(sglist, s, nelems, i), "s"
could be NULL which ends up deferencing a NULL pointer later here,

domain_flush_np_cache(domain, s->dma_address, s->dma_length);

so move domain_flush_np_cache() call inside for_each_sg() to loop over
each sg element.

BUG: kernel NULL pointer dereference, address: 0000000000000018
PGD 0 P4D 0
Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
CPU: 8 PID: 659 Comm: kworker/8:1 Tainted: G    B
5.1.0-rc7-next-20190506+ #20
Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40
01/25/2019
Workqueue: events work_for_cpu_fn
RIP: 0010:map_sg+0x297/0x2e0
Call Trace:
 scsi_dma_map+0xc6/0x160
 pqi_raid_submit_scsi_cmd_with_io_request+0x3b4/0x470 [smartpqi]
 pqi_scsi_queue_command+0x791/0xdd0 [smartpqi]
 scsi_queue_rq+0x79c/0x1200
 blk_mq_dispatch_rq_list+0x4dc/0xb70
 blk_mq_sched_dispatch_requests+0x2e1/0x310
 __blk_mq_run_hw_queue+0x128/0x200
 __blk_mq_delay_run_hw_queue+0x2b7/0x2d0
 blk_mq_run_hw_queue+0x127/0x1d0
 blk_mq_sched_insert_request+0x25c/0x320
 __scsi_scan_target+0x14d/0x790
 scsi_scan_target+0x115/0x120
 sas_rphy_add+0x1d1/0x280 [scsi_transport_sas]
 pqi_add_sas_device+0x187/0x1e0 [smartpqi]
 pqi_update_device_list+0x1227/0x1460 [smartpqi]
 pqi_update_scsi_devices+0x755/0x1980 [smartpqi]
 pqi_scan_scsi_devices+0x57/0xf0 [smartpqi]
 pqi_ctrl_init+0x149e/0x14df [smartpqi]
 pqi_pci_probe.cold.49+0x808/0x818 [smartpqi]
 local_pci_probe+0x7a/0xc0
 work_for_cpu_fn+0x2e/0x50
 process_one_work+0x522/0xa10
 worker_thread+0x363/0x5b0
 kthread+0x1d2/0x1f0
 ret_from_fork+0x22/0x40

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Call domain_flush_np_cache() inside for_each_sg().

 drivers/iommu/amd_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 867f8b155000..b7132812ce59 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2576,9 +2576,9 @@ static int map_sg(struct device *dev, struct scatterlist *sglist,
 		 */
 		s->dma_address += address + (s->offset & ~PAGE_MASK);
 		s->dma_length   = s->length;
-	}
 
-	domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+		domain_flush_np_cache(domain, s->dma_address, s->dma_length);
+	}
 
 	return nelems;
 
-- 
2.20.1 (Apple Git-117)

