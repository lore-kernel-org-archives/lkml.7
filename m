Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D43C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD0C206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 05:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="IrK2xQsm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfCKFRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 01:17:01 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:56070 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfCKFRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 01:17:01 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id D4C1198E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 05:16:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zbiZdeoJbMh2 for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 00:16:59 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id A7103946
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:16:59 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id 68so3313725iov.7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 22:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=sFQqMw+CIxYODoYrDQQdwDV/DtoasZxKDJyV3/grnMM=;
        b=IrK2xQsmoO45CDwtM1uoBN/Y0uGt1wll138+G1XJ8buahLAsNNurpBQ2qPrp1Ehd9H
         vA++qVEy6veOmNBkBdBzIMHO4WhJtd7mRwnCl7Jadk11z09B6nVwDe3kapKqPiRShmwB
         wpczcrFencxGaS++bIiHXoiJZ0xm5wTveAXV8Y23cz4m+Oqs/zahcub9myT5d7MEiNwm
         KqJ2ZoH/boi9/THxMc4xPlo+4dg1sNUxJs+UjHCflnpm7hQXXdTj0EFvrOiakdE9SHAZ
         783BeY0vLk7YUyXrnGTaF9CzIYAdtXQW5s7uDTqpqA2R85WD4cWiEDAlmZxMVefAS5XI
         flvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sFQqMw+CIxYODoYrDQQdwDV/DtoasZxKDJyV3/grnMM=;
        b=EdSfHseizsAiLKWtSNjCwibTWRvTUc4HC/10Ptfi726CfWuh4VaRCQJJOmd0oRXNVa
         sTQgWLdtudMUqa6bcTxthvCmTltoFbRIdaxDZeklneQXHWKjTKig311wGaTmVwydEXMc
         QjDTsGenhA4z3GTk2jwW4q4qFcOGE4SXTe4gEmCQIIW5FQI5eELI+KsonuEXQ07A2uEU
         tFgeq/hweuDQ3skLqZXotB2gC7USNb/3yf0gfLR0f/cfSsZalNJzeFhGYaDbVuejtf5N
         ERjwuen8NjvJ96F1/5IcgJPFjRjGr4XzJO5U6/wsNeb2+vTnzCRmVQHzXYIh45Jgy9U/
         GGvQ==
X-Gm-Message-State: APjAAAUuyMAA0AODPj39Wr7JVSkPDS8x8EVKfJOUhPyoStNRDM6wtvRZ
        QOX/ffCuWjWlfMUEqwZoWUpu8oYGLkk78X8kEWWdbIuUmD+BViFrmOFtBHeYwbe+nIUjw/+69nX
        pwQoqrIg7NVpTLUjG9t6fhUREVBjR
X-Received: by 2002:a6b:7f09:: with SMTP id l9mr408264ioq.207.1552281419053;
        Sun, 10 Mar 2019 22:16:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAOck4m2XR/BJicm1qpCMoe1FuOfoUNJr5c3PsYMCX6lKVJJbPp2FSUMiPVIqGIqwPQxmsqQ==
X-Received: by 2002:a6b:7f09:: with SMTP id l9mr408254ioq.207.1552281418825;
        Sun, 10 Mar 2019 22:16:58 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e10sm1214753iok.85.2019.03.10.22.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 22:16:57 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: 8390: fix potential NULL pointer dereferences
Date:   Mon, 11 Mar 2019 00:16:51 -0500
Message-Id: <20190311051653.6377-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix returns to avoid NULL pointer
dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/8390/pcnet_cs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 61e43802b9a5..e2b69e214fad 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -289,6 +289,9 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
 
     virt = ioremap(link->resource[2]->start,
 	    resource_size(link->resource[2]));
+    if (unlikely(!virt))
+	    return NULL;
+
     for (i = 0; i < NR_INFO; i++) {
 	pcmcia_map_mem_page(link, link->resource[2],
 		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
@@ -1423,6 +1426,11 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
     /* Try scribbling on the buffer */
     info->base = ioremap(link->resource[3]->start,
 			resource_size(link->resource[3]));
+    if (unlikely(!info->base)) {
+	    ret = -ENOMEM;
+	    goto failed;
+    }
+
     for (i = 0; i < (TX_PAGES<<8); i += 2)
 	__raw_writew((i>>1), info->base+offset+i);
     udelay(100);
-- 
2.17.1

