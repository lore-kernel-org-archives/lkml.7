Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216EF218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256864;
	bh=EUTQYl1C+28xN5VV3/tEDJEvWiCe25V60rs5vj9EMYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PI4s3ykqJfe6nrOx1oRN57YzsOAkElaB9m5NX8Smd0yzc88RMzjL0qs89vJaprXWA
	 OOXq88Vt9bpVRuZ4rdzCULZz/IOqbrn/zmuFJrp62Cp+JYPh+kf+TjxHFTpOhlh2fr
	 S/wK2DJll4ifJQebyLa715zpBxmbOon9Z9WniGNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389709AbfCVMOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389275AbfCVMOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:14:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F67E2083D;
        Fri, 22 Mar 2019 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256856;
        bh=EUTQYl1C+28xN5VV3/tEDJEvWiCe25V60rs5vj9EMYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UbAwpCgtZqhPN1UG22YIi2p+CO4f/82KjFIFw0IQQT2qgkxcWKyoAxP92F2qIw8LQ
         DlgBEDJ++L0UI3ktyXqiIMleHS4AAM+iVsT2fa+5GrvGknNwpxCxnXLulETyMU/T9v
         eCQLZ3xafm0Jc+9FhCgx0a8sctgkJP2c8U55s4M8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Piotr Balcer <piotr.balcer@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5.0 025/238] dax: Flush partial PMDs correctly
Date:   Fri, 22 Mar 2019 12:14:04 +0100
Message-Id: <20190322111259.667020813@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Wilcox <willy@infradead.org>

commit e4b3448bc346fedf36db64124a664a959995b085 upstream.

The radix tree would rewind the index in an iterator to the lowest index
of a multi-slot entry.  The XArray iterators instead leave the index
unchanged, but I overlooked that when converting DAX from the radix tree
to the XArray.  Adjust the index that we use for flushing to the start
of the PMD range.

Fixes: c1901cd33cf4 ("page cache: Convert find_get_entries_tag to XArray")
Cc: <stable@vger.kernel.org>
Reported-by: Piotr Balcer <piotr.balcer@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/dax.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

--- a/fs/dax.c
+++ b/fs/dax.c
@@ -843,9 +843,8 @@ unlock_pte:
 static int dax_writeback_one(struct xa_state *xas, struct dax_device *dax_dev,
 		struct address_space *mapping, void *entry)
 {
-	unsigned long pfn;
+	unsigned long pfn, index, count;
 	long ret = 0;
-	size_t size;
 
 	/*
 	 * A page got tagged dirty in DAX mapping? Something is seriously
@@ -894,17 +893,18 @@ static int dax_writeback_one(struct xa_s
 	xas_unlock_irq(xas);
 
 	/*
-	 * Even if dax_writeback_mapping_range() was given a wbc->range_start
-	 * in the middle of a PMD, the 'index' we are given will be aligned to
-	 * the start index of the PMD, as will the pfn we pull from 'entry'.
+	 * If dax_writeback_mapping_range() was given a wbc->range_start
+	 * in the middle of a PMD, the 'index' we use needs to be
+	 * aligned to the start of the PMD.
 	 * This allows us to flush for PMD_SIZE and not have to worry about
 	 * partial PMD writebacks.
 	 */
 	pfn = dax_to_pfn(entry);
-	size = PAGE_SIZE << dax_entry_order(entry);
+	count = 1UL << dax_entry_order(entry);
+	index = xas->xa_index & ~(count - 1);
 
-	dax_entry_mkclean(mapping, xas->xa_index, pfn);
-	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), size);
+	dax_entry_mkclean(mapping, index, pfn);
+	dax_flush(dax_dev, page_address(pfn_to_page(pfn)), count * PAGE_SIZE);
 	/*
 	 * After we have flushed the cache, we can clear the dirty tag. There
 	 * cannot be new dirty data in the pfn after the flush has completed as
@@ -917,8 +917,7 @@ static int dax_writeback_one(struct xa_s
 	xas_clear_mark(xas, PAGECACHE_TAG_DIRTY);
 	dax_wake_entry(xas, entry, false);
 
-	trace_dax_writeback_one(mapping->host, xas->xa_index,
-			size >> PAGE_SHIFT);
+	trace_dax_writeback_one(mapping->host, index, count);
 	return ret;
 
  put_unlocked:


