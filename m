Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53794C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22084206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610569;
	bh=jZfIlhtk7Gdo4MAfLMYeE7SN7iTZrZVxqIPsk8LJThA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eFWXtd+1Hyn0t0I/SN6T7+RtjOnnH5oO1ptL3OMa5wWt5+8562GUjDz0z+KOQnYx8
	 hnOyqG/httrYCO8yO/bfMZFMA4mv6H3pgPQVI+kBsLmAZZcGrZPT+BuudP+fzujQgh
	 qWkuR2hLSh/rihSKa1RhAEW8tv7LJyEHiSjpkTJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390807AbfDRSCr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390394AbfDRSCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:02:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7C6E218AF;
        Thu, 18 Apr 2019 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610562;
        bh=jZfIlhtk7Gdo4MAfLMYeE7SN7iTZrZVxqIPsk8LJThA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dytKgtOVgL5VqVaTYwpYkz39segvm63Bfkc09z2we3p5w8hJ/MPZBrF4hrxC+3WIN
         BGN1mnC9rAjfnrI4V4gKbkIVyJBLhMXd+YdCsZZkufAQizySIZgN7vzLBoVxBtTESK
         JVz2oKOGoOaWsJjnIeghZ1sOF+mMYffx3nayxsEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yongqin Liu <yongqin.liu@linaro.org>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 109/110] mm: hide incomplete nr_indirectly_reclaimable in /proc/zoneinfo
Date:   Thu, 18 Apr 2019 19:57:38 +0200
Message-Id: <20190418160447.799614106@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Gushchin <guro@fb.com>

[fixed differently upstream, this is a work-around to resolve it for 4.19.y]

Yongqin reported that /proc/zoneinfo format is broken in 4.14
due to commit 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable
in /proc/vmstat")

Node 0, zone      DMA
  per-node stats
      nr_inactive_anon 403
      nr_active_anon 89123
      nr_inactive_file 128887
      nr_active_file 47377
      nr_unevictable 2053
      nr_slab_reclaimable 7510
      nr_slab_unreclaimable 10775
      nr_isolated_anon 0
      nr_isolated_file 0
      <...>
      nr_vmscan_write 0
      nr_vmscan_immediate_reclaim 0
      nr_dirtied   6022
      nr_written   5985
                   74240
      ^^^^^^^^^^
  pages free     131656

The problem is caused by the nr_indirectly_reclaimable counter,
which is hidden from the /proc/vmstat, but not from the
/proc/zoneinfo. Let's fix this inconsistency and hide the
counter from /proc/zoneinfo exactly as from /proc/vmstat.

BTW, in 4.19+ the counter has been renamed and exported by
the commit b29940c1abd7 ("mm: rename and change semantics of
nr_indirectly_reclaimable_bytes"), so there is no such a problem
anymore.

Cc: <stable@vger.kernel.org> # 4.14.x-4.18.x
Fixes: 7aaf77272358 ("mm: don't show nr_indirectly_reclaimable in /proc/vmstat")
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/vmstat.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1547,6 +1547,10 @@ static void zoneinfo_show_print(struct s
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			/* Skip hidden vmstat items. */
+			if (*vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
+					 NR_VM_NUMA_STAT_ITEMS] == '\0')
+				continue;
 			seq_printf(m, "\n      %-12s %lu",
 				vmstat_text[i + NR_VM_ZONE_STAT_ITEMS +
 				NR_VM_NUMA_STAT_ITEMS],


