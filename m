Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C4BC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3622082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFMQrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:47:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37968 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfFME70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 00:59:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so10192055pgl.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 21:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWbRTeKmk5ocrJn/P4BuehWbTRxhuHcLDK7hkAZEDEA=;
        b=R2gk/FTBEuK304RkzmAKn45dHCWfYf3oEWYxVlBvsPJxdRaQhCTuPh8/yKxcQaMy83
         M8sHQKrhDwWtTBsrKCMAsCI83K+hurTyE8GdWDXGeoxUvkj4+NU6XKOCP9aXSd0CBYQe
         nnVUDL4qPZ//nFJlAygeCJRXOUM8jwUygML+oJMRrnTxjb0SCd4iL2RKLjgBl9CNFMz7
         rUFjGSkgv8S1hiTQCa+CEB0w+ebpkZgy+U9QTCEYDiSyfBeJdv3vfbqZdwb+UWww0o1c
         VeoewSJdd9FhY9OjZFc61JCy+Jqx83j0d7cwY0Ndpn0hKtbf9pvi8OWiGyj1wLU3V5QX
         XqmQ==
X-Gm-Message-State: APjAAAUWc9TtOf2A4GKBnVSgLjykUEQcLKwAj322Uzn/pA6S1K0aPFET
        nQnM9gXaHrdcBG38MMRUSP0=
X-Google-Smtp-Source: APXvYqwCQm6gLcdRRcYK2xTfhCK2MrbIoP91Gi9S+Cs6b/ef29pEkcDQcvyOOdRbZyZAsTpULU1JNA==
X-Received: by 2002:a63:2355:: with SMTP id u21mr27787140pgm.205.1560401965903;
        Wed, 12 Jun 2019 21:59:25 -0700 (PDT)
Received: from htb-2n-eng-dhcp405.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id o66sm1215327pfb.86.2019.06.12.21.59.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 21:59:25 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <namit@vmware.com>, Borislav Petkov <bp@suse.de>,
        Toshi Kani <toshi.kani@hpe.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/3] resource: Avoid unnecessary lookups in find_next_iomem_res()
Date:   Wed, 12 Jun 2019 21:59:02 -0700
Message-Id: <20190613045903.4922-3-namit@vmware.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613045903.4922-1-namit@vmware.com>
References: <20190613045903.4922-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find_next_iomem_res() shows up to be a source for overhead in dax
benchmarks.

Improve performance by not considering children of the tree if the top
level does not match. Since the range of the parents should include the
range of the children such check is redundant.

Running sysbench on dax (pmem emulation, with write_cache disabled):

  sysbench fileio --file-total-size=3G --file-test-mode=rndwr \
   --file-io-mode=mmap --threads=4 --file-fsync-mode=fdatasync run

Provides the following results:

		events (avg/stddev)
		-------------------
  5.2-rc3:	1247669.0000/16075.39
  w/patch:	1286320.5000/16402.72	(+3%)

Cc: Borislav Petkov <bp@suse.de>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 kernel/resource.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index c0f7ba0ece52..51c3bf6d9b98 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -342,6 +342,7 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
 			       bool first_lvl, struct resource *res)
 {
+	bool siblings_only = true;
 	struct resource *p;
 
 	if (!res)
@@ -352,17 +353,31 @@ static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 
 	read_lock(&resource_lock);
 
-	for (p = iomem_resource.child; p; p = next_resource(p, first_lvl)) {
-		if ((p->flags & flags) != flags)
-			continue;
-		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
-			continue;
+	for (p = iomem_resource.child; p; p = next_resource(p, siblings_only)) {
+		/* If we passed the resource we are looking for, stop */
 		if (p->start > end) {
 			p = NULL;
 			break;
 		}
-		if ((p->end >= start) && (p->start <= end))
-			break;
+
+		/* Skip until we find a range that matches what we look for */
+		if (p->end < start)
+			continue;
+
+		/*
+		 * Now that we found a range that matches what we look for,
+		 * check the flags and the descriptor. If we were not asked to
+		 * use only the first level, start looking at children as well.
+		 */
+		siblings_only = first_lvl;
+
+		if ((p->flags & flags) != flags)
+			continue;
+		if ((desc != IORES_DESC_NONE) && (desc != p->desc))
+			continue;
+
+		/* Found a match, break */
+		break;
 	}
 
 	if (p) {
-- 
2.20.1

