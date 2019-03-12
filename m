Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6486C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82A52054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411666;
	bh=YdFE62X/kOG4YsuzA6E0MHrF1dcChtd2+jp0/vI8tMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jeJge43MBZ9SuONv2PsuGC2JI90EiOTVZiqcO6NsxR/fpaYRkLWKSV74eXODRoBwv
	 gu64N6EqK1Fu/+1kB5AXD5bP5AchO9p2ccme+WvQeTrsd2X2Z9xpb0JtsknnWipSAU
	 VvVdo7o+5hTaJ5bZEWtQmrIRdoXcuX0DGC5i8RE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbfCLRRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729145AbfCLRQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86C62171F;
        Tue, 12 Mar 2019 17:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410987;
        bh=YdFE62X/kOG4YsuzA6E0MHrF1dcChtd2+jp0/vI8tMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lf/tDmwJmPV3v0+LLIUrHNteVBNhHS6JU5shExYVWPBMqFaDXF4wy+6wmMoGVjlC8
         VA/En17PBF1MU7fpMJonrOKKg5ESBhdn7OVCiHcNsjrv9TJtIJRe9G6GDRPGSVOTMB
         2DXkhjz3cxSSA1H2pRXTdC27Dfmkyz7MSO4pdeYo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 082/135] mm, memory_hotplug: test_pages_in_a_zone do not pass the end of zone
Date:   Tue, 12 Mar 2019 10:08:49 -0700
Message-Id: <20190312170348.732008948@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 24feb47c5fa5b825efb0151f28906dfdad027e61 ]

If memory end is not aligned with the sparse memory section boundary,
the mapping of such a section is only partly initialized.  This may lead
to VM_BUG_ON due to uninitialized struct pages access from
test_pages_in_a_zone() function triggered by memory_hotplug sysfs
handlers.

Here are the the panic examples:
 CONFIG_DEBUG_VM_PGFLAGS=y
 kernel parameter mem=2050M
 --------------------------
 page:000003d082008000 is uninitialized and poisoned
 page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
 Call Trace:
   test_pages_in_a_zone+0xde/0x160
   show_valid_zones+0x5c/0x190
   dev_attr_show+0x34/0x70
   sysfs_kf_seq_show+0xc8/0x148
   seq_read+0x204/0x480
   __vfs_read+0x32/0x178
   vfs_read+0x82/0x138
   ksys_read+0x5a/0xb0
   system_call+0xdc/0x2d8
 Last Breaking-Event-Address:
   test_pages_in_a_zone+0xde/0x160
 Kernel panic - not syncing: Fatal exception: panic_on_oops

Fix this by checking whether the pfn to check is within the zone.

[mhocko@suse.com: separated this change from http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
Link: http://lkml.kernel.org/r/20190128144506.15603-3-mhocko@kernel.org

[mhocko@suse.com: separated this change from
http://lkml.kernel.org/r/20181105150401.97287-2-zaslonko@linux.ibm.com]
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Tested-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memory_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 39db89f3df65..c9d3a49bd4e2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1297,6 +1297,9 @@ int test_pages_in_a_zone(unsigned long start_pfn, unsigned long end_pfn,
 				i++;
 			if (i == MAX_ORDER_NR_PAGES || pfn + i >= end_pfn)
 				continue;
+			/* Check if we got outside of the zone */
+			if (zone && !zone_spans_pfn(zone, pfn + i))
+				return 0;
 			page = pfn_to_page(pfn + i);
 			if (zone && page_zone(page) != zone)
 				return 0;
-- 
2.19.1



