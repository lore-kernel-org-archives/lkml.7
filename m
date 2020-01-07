Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B486C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D2206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578432204;
	bh=AK1AVXO5ClegKvysWc2GyWGCDLaaS1BUynmfwuiEd7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FXEfXWwaDWqVydjNKu8gY/PG0YxyqmwMKQKUuoJjD+7NUgmwb9OkIdcWlFIonYREU
	 m2emxmaMUeRSmYYsMCH35NF20Qvxw9KVU1Z+W/f0Z/UTom+JCmBOreKp8+8OEccFjk
	 3Q4SQoxq7VygUWAGG6xkkfwp7X39Lw03iR4ESbZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbgAGVXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728568AbgAGVB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:01:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E2202087F;
        Tue,  7 Jan 2020 21:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578430886;
        bh=AK1AVXO5ClegKvysWc2GyWGCDLaaS1BUynmfwuiEd7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pePvFFxhWMhYHSHq6c85p29Mo2rMITnokw9KLIF0BgSYGXlKeotwpM5viHHsTBA4i
         pGPDwUlUixiPtobvLBnoQBciRpzSFRBiBIrRH14AyE/JF8bO20hJRDWO4hq7K6ERjg
         LrmItUUygOSuATUVxIegnULZPRV269PMlyAPIIOI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alastair DSilva <alastair@d-silva.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 138/191] powerpc: Chunk calls to flush_dcache_range in arch_*_memory
Date:   Tue,  7 Jan 2020 21:54:18 +0100
Message-Id: <20200107205340.358424692@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200107205332.984228665@linuxfoundation.org>
References: <20200107205332.984228665@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alastair D'Silva <alastair@d-silva.org>

commit 076265907cf9633bbef861c7c2a1c26a8209f283 upstream.

When presented with large amounts of memory being hotplugged
(in my test case, ~890GB), the call to flush_dcache_range takes
a while (~50 seconds), triggering RCU stalls.

This patch breaks up the call into 1GB chunks, calling
cond_resched() inbetween to allow the scheduler to run.

Fixes: fb5924fddf9e ("powerpc/mm: Flush cache on memory hot(un)plug")
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191104023305.9581-6-alastair@au1.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/mm/mem.c |   27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -104,6 +104,27 @@ int __weak remove_section_mapping(unsign
 	return -ENODEV;
 }
 
+#define FLUSH_CHUNK_SIZE SZ_1G
+/**
+ * flush_dcache_range_chunked(): Write any modified data cache blocks out to
+ * memory and invalidate them, in chunks of up to FLUSH_CHUNK_SIZE
+ * Does not invalidate the corresponding instruction cache blocks.
+ *
+ * @start: the start address
+ * @stop: the stop address (exclusive)
+ * @chunk: the max size of the chunks
+ */
+static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
+				       unsigned long chunk)
+{
+	unsigned long i;
+
+	for (i = start; i < stop; i += chunk) {
+		flush_dcache_range(i, min(stop, start + chunk));
+		cond_resched();
+	}
+}
+
 int __ref arch_add_memory(int nid, u64 start, u64 size,
 			struct mhp_restrictions *restrictions)
 {
@@ -120,7 +141,8 @@ int __ref arch_add_memory(int nid, u64 s
 			start, start + size, rc);
 		return -EFAULT;
 	}
-	flush_dcache_range(start, start + size);
+
+	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
 
 	return __add_pages(nid, start_pfn, nr_pages, restrictions);
 }
@@ -136,7 +158,8 @@ void __ref arch_remove_memory(int nid, u
 
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
-	flush_dcache_range(start, start + size);
+	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
+
 	ret = remove_section_mapping(start, start + size);
 	WARN_ON_ONCE(ret);
 


