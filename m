Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18625C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE97F21874
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYu84DUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730339AbfIBIe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:34:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34477 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729602AbfIBIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:34:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so7145227pgc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uFmY0zGFn+EQnA57VOg3VeO9qiRTqjJoOe1gdV98IwA=;
        b=cYu84DUjPTKSgEfeLZtea5ZEO+oEaJLALl1KB7muOH5m/fFs57yP+LCBWA6ArhPio2
         WkWh2wrJ47bV5YbLwT4iwCqb0Ai/rODNnzr2DLp/L4oyyVLmYnl8diGTiWZcLmPts4RT
         Fvycb5VDcIqhCDQUwOkf5B/KrPFRGEDMpFQ0ye36mXAuIE2ktSav4aoIKXNO5UKgjCs9
         XeRU/NPTPSKO6SIsAXPP6l9CAopbF2aMh6wQABGv4Bll8xPxRW8O0MHHWhR31XaYpl8N
         rSDNcLd/VdJKmITmEkdXcJB0iI2uADXabuFqj6oUAtUumdu4JVui5i97iRe4w4fSGhL9
         VORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uFmY0zGFn+EQnA57VOg3VeO9qiRTqjJoOe1gdV98IwA=;
        b=Wb1oMuwOUaojbCGhCkokGzPqaDtdrE/wHiwtR4O0IB6wrnz/CyvwTjt8ua48dyE2+V
         DE+BJFGtNmTaHzaB/F9RhHpEXHuyjvlie++f81x6tcD5nt+LtEPBzIpQtNFEphzUPy4y
         HadX+Y/Ws0zoukU7UcaIVwNBa4Dgv5B0s6/7VuXDfmKqCVIzFTZhMX4d1jbK2MIbaPGB
         SNmT8XYWVJkALdL3QVwsV8mpBgmA1vb6XFaEKxlxD5GOAeGZk7WxnjxsCDnTfL1Y9n0m
         Xpp5CxlnBEHolGlRLx5dRfRiudUG5v/qXwqRINNPa7GhhcwqpdzOJ+6RWsskYzuhR69+
         TSbA==
X-Gm-Message-State: APjAAAU5kh67rT4WpYGjEaYYT7JR5PvK4DBPM2Hr6GLrlf5m3rw0BDz0
        dQ5xKmsa6m4UAuKa5s78ENw=
X-Google-Smtp-Source: APXvYqykyTr1V1UXoAhEng9PvF5ygE64bFW8pzDF90EN8gbWoiWOHtdCIKRzyJWgs9NYY7KHzCPF3A==
X-Received: by 2002:a63:184b:: with SMTP id 11mr25468636pgy.112.1567413294974;
        Mon, 02 Sep 2019 01:34:54 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([49.207.50.39])
        by smtp.gmail.com with ESMTPSA id g9sm6977813pjl.0.2019.09.02.01.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 02 Sep 2019 01:34:53 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sabyasachi.linux@gmail.com,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH v2] swiotlb-xen: Convert to use macro
Date:   Mon,  2 Sep 2019 14:09:58 +0530
Message-Id: <1567413598-4477-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than using static int max_dma_bits, this
can be coverted to use as macro.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index ae1df49..d1eced5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -38,6 +38,7 @@
 #include <asm/xen/page-coherent.h>
 
 #include <trace/events/swiotlb.h>
+#define MAX_DMA_BITS 32
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
@@ -114,8 +115,6 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 	return 0;
 }
 
-static int max_dma_bits = 32;
-
 static int
 xen_swiotlb_fixup(void *buf, size_t size, unsigned long nslabs)
 {
@@ -135,7 +134,7 @@ static int is_xen_swiotlb_buffer(dma_addr_t dma_addr)
 				p + (i << IO_TLB_SHIFT),
 				get_order(slabs << IO_TLB_SHIFT),
 				dma_bits, &dma_handle);
-		} while (rc && dma_bits++ < max_dma_bits);
+		} while (rc && dma_bits++ < MAX_DMA_BITS);
 		if (rc)
 			return rc;
 
-- 
1.9.1

