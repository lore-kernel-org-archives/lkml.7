Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31640C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080ED2229A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="d5YgKXtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfGVIXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:23:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50289 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfGVIXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:23:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8Nat33738684
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:23:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8Nat33738684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563783816;
        bh=UnylQ2uIKauxwDTMbH02wxKZYqGV7EC4IvB+0V+WZ5g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=d5YgKXtn7tTEDdQmzXUyng6+FfttbaRGYKhDd8pH3VA+ECBYQcsIG7VSMb8yfFK6u
         QH8295Z0VAojeqrqEEu8xRo/hjlrbAzT872cbrvqgMjlfgSTOZwivQbFcuDxJs4OPB
         w5A4rL3/qLuP9wlbcpbkUFAF92/RnhYUbp0i3OzMW8Rqyu6m6RtnHP3DqsJPxSZsqa
         F6rsSMejUKNvzUCny2/iC6otKDtIIK+cTi8Ry287qPOIbcUJ2S/1PTR3EUa1K0fNd2
         9mwNqg7iOgqp04xhEBS7QIyi/XuksWqkXWMUcjSiHOM5G1lyLZKPx8X0aU8+6rv7Az
         gq5jTYVSHCc4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8NZZO3738680;
        Mon, 22 Jul 2019 01:23:35 -0700
Date:   Mon, 22 Jul 2019 01:23:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-3f8fd02b1bf1d7ba964485a56f2f4b53ae88c167@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, jroedel@suse.de,
        dave.hansen@linux.intel.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: dave.hansen@linux.intel.com, tglx@linutronix.de,
          mingo@kernel.org, jroedel@suse.de, linux-kernel@vger.kernel.org,
          hpa@zytor.com
In-Reply-To: <20190719184652.11391-4-joro@8bytes.org>
References: <20190719184652.11391-4-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] mm/vmalloc: Sync unmappings in
 __purge_vmap_area_lazy()
Git-Commit-ID: 3f8fd02b1bf1d7ba964485a56f2f4b53ae88c167
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3f8fd02b1bf1d7ba964485a56f2f4b53ae88c167
Gitweb:     https://git.kernel.org/tip/3f8fd02b1bf1d7ba964485a56f2f4b53ae88c167
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Fri, 19 Jul 2019 20:46:52 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:18:30 +0200

mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()

On x86-32 with PTI enabled, parts of the kernel page-tables are not shared
between processes. This can cause mappings in the vmalloc/ioremap area to
persist in some page-tables after the region is unmapped and released.

When the region is re-used the processes with the old mappings do not fault
in the new mappings but still access the old ones.

This causes undefined behavior, in reality often data corruption, kernel
oopses and panics and even spontaneous reboots.

Fix this problem by activly syncing unmaps in the vmalloc/ioremap area to
all page-tables in the system before the regions can be re-used.

References: https://bugzilla.suse.com/show_bug.cgi?id=1118689
Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20190719184652.11391-4-joro@8bytes.org

---
 mm/vmalloc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4fa8d84599b0..e0fc963acc41 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1258,6 +1258,12 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 	if (unlikely(valist == NULL))
 		return false;
 
+	/*
+	 * First make sure the mappings are removed from all page-tables
+	 * before they are freed.
+	 */
+	vmalloc_sync_all();
+
 	/*
 	 * TODO: to calculate a flush range without looping.
 	 * The list can be up to lazy_max_pages() elements.
@@ -3038,6 +3044,9 @@ EXPORT_SYMBOL(remap_vmalloc_range);
 /*
  * Implement a stub for vmalloc_sync_all() if the architecture chose not to
  * have one.
+ *
+ * The purpose of this function is to make sure the vmalloc area
+ * mappings are identical in all page-tables in the system.
  */
 void __weak vmalloc_sync_all(void)
 {
