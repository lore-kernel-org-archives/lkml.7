Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB1C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C71A20840
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnGWQoRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbfCAMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:21:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42034 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbfCAMVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:21:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id r5so25629200wrg.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 04:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=38/jcoVFhI+GrkLYgu5+QiVqi29dF5lxx3nQO3MwqEo=;
        b=GnGWQoRI+9BwxfgLGtm94BoNL3lbygSD6PXoA8VMk050YRDlrh6sA1K4JEWktnrIty
         /6erybR/rPDcHpcn/32b+3a17I8BDzH0ReZWhovoqKVQx14qD3GEtiv94g1jhA214BH6
         P1idZx81K2Sxya50t2UAO3+lFF4IjYd1e82g9k/VFfgwOu9AThtkHEc8hMdvuZ0TAxgG
         CFo2Np+lK7EwCUaBcZgYZbbmpisKia8VjoxlPvf57M5hHAYn1hiI6qKrWgZu5eE8+YxZ
         b64jUumF8g3ZOBF8hqs1JeK9vbDQ+w1CFoF7KlKkQ1v3cwGByzfWNGcU2aGVVgNGRpnq
         Ddrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=38/jcoVFhI+GrkLYgu5+QiVqi29dF5lxx3nQO3MwqEo=;
        b=raTsHdhf8B8H/nmalcl1zEyjNRlZcGPZsq3C6dEWG0Ssznm8V4vNJJPiKmgSvUZdgL
         qJFMqjdaWfONpH6QxHkAmfahqsdaPzumGE4YLprlZ0ACAEH2dOlG80h342w6YqAWewo2
         yySksmgH7Nr50aqhtiTbBrlZXzXgetlX40wLTK1czlmvxo+Zkik6GCVAZfqqH4/7WT6e
         EbBbRTLdgax7VvOaZvXLaLJXEAc+FR/J7h2pQx7G55WofWQB4CQvPYQitpREM+EUrvgV
         kj0dt3YAQJ+CyJ9htKCjIWKgv2rR0hBS/KDyoawjri7Q/cCZrP1nKE9XVF1naQTDCJxu
         ZVqw==
X-Gm-Message-State: APjAAAUryykP4rsH76a9OD0gvKHhFaEQ8+mJeynk8YWMZKCjKGxJ3Eoi
        OD2N+/S9u1AF0t5iMk11RnWDyo5w
X-Google-Smtp-Source: APXvYqwOnB9NEtnWUzDIncaU427XQawucdoN4FNDA0HZlEqx81gG53nVMXZDt77linnfqjKea+sQig==
X-Received: by 2002:adf:f786:: with SMTP id q6mr3084157wrp.125.1551442873789;
        Fri, 01 Mar 2019 04:21:13 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id 203sm9467923wme.30.2019.03.01.04.21.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Mar 2019 04:21:13 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: use do_div for 64-bit divisions
Date:   Fri,  1 Mar 2019 14:21:11 +0200
Message-Id: <20190301122111.941-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix compilation error in 32-bit ARM architecture regarding
division of 2 64-bit variables.

Use the kernel do_div() macro, which is implemented per architecture, for
doing these divisions instead of using the / operator.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/mmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index ce404e6cc9a9..2f2e99cb2743 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -261,9 +261,9 @@ int hl_mmu_ctx_init(struct hl_ctx *ctx)
 			!hdev->dram_default_page_mapping)
 		return 0;
 
-	num_of_hop3 = (prop->dram_size_for_default_page_mapping /
-			prop->dram_page_size) /
-			PTE_ENTRIES_IN_HOP;
+	num_of_hop3 = prop->dram_size_for_default_page_mapping;
+	do_div(num_of_hop3, prop->dram_page_size);
+	do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
 
 	/* add hop1 and hop2 */
 	total_hops = num_of_hop3 + 2;
@@ -378,9 +378,9 @@ void hl_mmu_ctx_fini(struct hl_ctx *ctx)
 	if (hdev->dram_supports_virtual_memory &&
 			hdev->dram_default_page_mapping) {
 
-		num_of_hop3 = (prop->dram_size_for_default_page_mapping /
-				prop->dram_page_size) /
-				PTE_ENTRIES_IN_HOP;
+		num_of_hop3 = prop->dram_size_for_default_page_mapping;
+		do_div(num_of_hop3, prop->dram_page_size);
+		do_div(num_of_hop3, PTE_ENTRIES_IN_HOP);
 
 		/* add hop1 and hop2 */
 		total_hops = num_of_hop3 + 2;
-- 
2.17.1

