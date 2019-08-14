Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88FCC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2AC214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802539;
	bh=fllYO8klzVBu/v/RKi/Wr7MUFDeaUMeXiVuI1JnUge0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u2mTFWT5H/tp1CdbQczlMHkHl6V8UQ1nrCovJFJapkXWOm2WxiiuzMPdcTjyFjuKh
	 KPLf6I7foBxyAsbnWzMuFQbqjYeWs3E3+6iWQVj32GLtAJM60zHvjjfTRnXuqgPwew
	 Lk9M+A894MRXHtTLx2qFCw73h+f6kT1XvzAJyU6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbfHNRI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:08:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:59118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbfHNRIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:08:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 618E721721;
        Wed, 14 Aug 2019 17:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802533;
        bh=fllYO8klzVBu/v/RKi/Wr7MUFDeaUMeXiVuI1JnUge0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZRyMb+QhZ5l1qOOUu7dDHKs5kMKbGikggXm0DItWTI0BtogkEVHvF6E87/PSSZ8IG
         lUeY25iDTDQ6sFZ39umXU4Ilz4nYCxh0/0Uug5/9KXSKSxqnuhawsghCvKx5mq8LbM
         ttrj/MUvv76/I6rd0ybEF+AGqHpD3KftYX1wa2HY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4.19 19/91] mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()
Date:   Wed, 14 Aug 2019 19:00:42 +0200
Message-Id: <20190814165750.551462071@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165748.991235624@linuxfoundation.org>
References: <20190814165748.991235624@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

commit 3f8fd02b1bf1d7ba964485a56f2f4b53ae88c167 upstream.

On x86-32 with PTI enabled, parts of the kernel page-tables are not shared
between processes. This can cause mappings in the vmalloc/ioremap area to
persist in some page-tables after the region is unmapped and released.

When the region is re-used the processes with the old mappings do not fault
in the new mappings but still access the old ones.

This causes undefined behavior, in reality often data corruption, kernel
oopses and panics and even spontaneous reboots.

Fix this problem by activly syncing unmaps in the vmalloc/ioremap area to
all page-tables in the system before the regions can be re-used.

Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-4-joro@8bytes.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmalloc.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1752,6 +1752,12 @@ void *__vmalloc_node_range(unsigned long
 		return NULL;
 
 	/*
+	 * First make sure the mappings are removed from all page-tables
+	 * before they are freed.
+	 */
+	vmalloc_sync_all();
+
+	/*
 	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
 	 * flag. It means that vm_struct is not fully initialized.
 	 * Now, it is fully initialized, so remove this flag here.
@@ -2296,6 +2302,9 @@ EXPORT_SYMBOL(remap_vmalloc_range);
 /*
  * Implement a stub for vmalloc_sync_all() if the architecture chose not to
  * have one.
+ *
+ * The purpose of this function is to make sure the vmalloc area
+ * mappings are identical in all page-tables in the system.
  */
 void __weak vmalloc_sync_all(void)
 {


