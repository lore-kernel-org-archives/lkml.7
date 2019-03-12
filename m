Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 814C1214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="olOt2URj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCLHYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:24:18 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:45552 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfCLHYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:24:17 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E2A6DA68
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5HX-OEHLOA5l for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:24:15 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id BA2AB84D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:24:15 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id k5so1163145ioh.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6O1Sb4xWjsBgAXHnqqrrJLBr6fSvpPeltfRGwQnhiwY=;
        b=olOt2URj4YAUG7UyAirA+bajFmKySHwb2dueR912x6oyh+xdttgHEVgU4sAWWNe+0C
         KBwIi0GIZErqoWw4s4YY5PtSLolN8F3Ksp7bZh8dKoul/tbpFaqE0YnsevjrTSdAAdmY
         KpWEIi7LTrJT/P51s6knqQ6JUvAf72ElKVZgupaqtAqFb8A1jOylsodbZIyDirKcsD74
         bGcu/fmu8781oGmRbbh8coEb3YwiyE1xT1equoKEZekda7xla6HxYMMVd0NljP3XKB8b
         TEf5VlFN66tYX8Lei4t3t5I4FESTmsrqZPFo9t/dGRExhvo3mBgnXvwL/yZHD9bloZYf
         tmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6O1Sb4xWjsBgAXHnqqrrJLBr6fSvpPeltfRGwQnhiwY=;
        b=lBJveHJBTkzI4c7NzKqjNe6z64/6Nh0aGl6u2B5devgx04FauIwo/LEdJDyM5uoPYY
         D4Gmbiy2m6WXfGFqZthpryxFElF6hcsvaVYfv6TU0uMduLFkXn6PgMktSrL/bmuV7kgS
         mNy/Hk9I0Ov11RyKqMIHLlopvhUhDR7yuprK/RdIqDA+UgeNSCH8jsI8qqRzpqiEk/6u
         lb+CRjxMrdov5DlFx1yM8yk6RZfyYF8UV5JixBMezOI1o6La48US/O9W94ZeyGpMRMOg
         Pbf6L9qJHL/k8CS3t0N8ljnAjm4Ee80RisylidHzk4mnSTB0nMcohFF29Furamu/udY3
         dHIQ==
X-Gm-Message-State: APjAAAVA9lOUEl2/F5SifK7M8jlfd085e+N57DXs/z+gKCaK29sSTGHH
        QPVhxP3+kfE9N6tzrBHl2Rgq7DO1y/kdV1Clfv6Hf8nTb3QhjnYWMPAS0srl5YHQkjc+JkuqOjs
        S6jgrLtOzQsyB6aMVEdjCgOZcx/vz
X-Received: by 2002:a02:241d:: with SMTP id f29mr19036491jaa.30.1552375455364;
        Tue, 12 Mar 2019 00:24:15 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxsdgjyNYTJ+3xzAT+Grf6qNbxt8o07Fd9BV72UGkrXBAYUsndC6/CBzdEqYHtblqWHmtvDRw==
X-Received: by 2002:a02:241d:: with SMTP id f29mr19036483jaa.30.1552375455123;
        Tue, 12 Mar 2019 00:24:15 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id w8sm953972ita.21.2019.03.12.00.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:24:14 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: 8390: fix potential NULL pointer dereferences
Date:   Tue, 12 Mar 2019 02:24:07 -0500
Message-Id: <20190312072408.26462-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case ioremap fails, the fix releases resources and returns
to avoid NULL pointer dereferences.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/8390/pcnet_cs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
index 61e43802b9a5..645efac6310d 100644
--- a/drivers/net/ethernet/8390/pcnet_cs.c
+++ b/drivers/net/ethernet/8390/pcnet_cs.c
@@ -289,6 +289,11 @@ static struct hw_info *get_hwinfo(struct pcmcia_device *link)
 
     virt = ioremap(link->resource[2]->start,
 	    resource_size(link->resource[2]));
+    if (unlikely(!virt)) {
+	    pcmcia_release_window(link, link->resource[2]);
+	    return NULL;
+    }
+
     for (i = 0; i < NR_INFO; i++) {
 	pcmcia_map_mem_page(link, link->resource[2],
 		hw_info[i].offset & ~(resource_size(link->resource[2])-1));
@@ -1423,6 +1428,11 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
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

