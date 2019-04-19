Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD41BC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA404222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfDSSVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:35 -0400
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:46885 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727374AbfDSSVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:19 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id 5855C1C333A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 09:51:35 +0100 (IST)
Received: (qmail 14374 invoked from network); 19 Apr 2019 08:51:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.225.79])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Apr 2019 08:51:35 -0000
Date:   Fri, 19 Apr 2019 09:51:33 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Wang <liwang@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, page_alloc: Always use a captured page regardless of
 compaction result
Message-ID: <20190419085133.GH18914@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the development of commit 5e1f0f098b46 ("mm, compaction: capture
a page under direct compaction"), a paranoid check was added to ensure
that if a captured page was available after compaction that it was
consistent with the final state of compaction. The intent was to catch
serious programming bugs such as using a stale page pointer and causing
corruption problems.

However, it is possible to get a captured page even if compaction was
unsuccessful if an interrupt triggered and happened to free pages in
interrupt context that got merged into a suitable high-order page. It's
highly unlikely but Li Wang did report the following warning on s390
occuring when testing OOM handling. Note that the warning is slightly
edited for clarity.

[ 1422.124060] WARNING: CPU: 0 PID: 9783 at mm/page_alloc.c:3777 __alloc_pages_direct_compact+0x182/0x190
[ 1422.124065] Modules linked in: rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver
 nfs lockd grace fscache sunrpc pkey ghash_s390 prng xts aes_s390 des_s390
 des_generic sha512_s390 zcrypt_cex4 zcrypt vmur binfmt_misc ip_tables xfs
 libcrc32c dasd_fba_mod qeth_l2 dasd_eckd_mod dasd_mod qeth qdio lcs ctcm
 ccwgroup fsm dm_mirror dm_region_hash dm_log dm_mod
[ 1422.124086] CPU: 0 PID: 9783 Comm: copy.sh Kdump: loaded Not tainted 5.1.0-rc 5 #1

This patch simply removes the check entirely instead of trying to be
clever about pages freed from interrupt context. If a serious programming
error was introduced, it is highly likely to be caught by prep_new_page()
instead.

Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/page_alloc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d96ca5bc555b..cfaba3889fa2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3773,11 +3773,6 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
 
-	if (*compact_result <= COMPACT_INACTIVE) {
-		WARN_ON_ONCE(page);
-		return NULL;
-	}
-
 	/*
 	 * At least in one zone compaction wasn't deferred or skipped, so let's
 	 * count a compaction stall
