Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9657CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F75C22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 19:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E3V36Igk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbfIDTyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 15:54:31 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37574 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbfIDTy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 15:54:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id b10so41614plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=/fcTM79WZf6aDvSyEB7v9KgQnwaVScj2r1F/kgx7mCM=;
        b=E3V36Igk37DlL+J+dNYTpk/5GulrcMjXTraH6Ngs+1wvAnXOx31Cox17KsuPBS7LwS
         /EwobeVXzDpp5HZRc6SYmYbcJ8PFJ6kTVzu86VTyAp2FJl2PsaajqWu2hY4sWkvGts+a
         SgmZuJHXD58+tgFD+VMwSmk0P7tTVZwYiBNn3CfSxtIRzkKNJhSkYUVNiPZiJmS/bclx
         lY9UzFHAaQDRht4CDe8lp9VOmP8kK/Vd/Md1apXnk23QxeYAYkiOH88Isx85bfdS0va9
         qZqc3Pab7GpN9kcL1nLhYDiS0u71EEyedAHOTAWzT807RgsRB/1r9nH30uSry4hIh6lp
         ndjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=/fcTM79WZf6aDvSyEB7v9KgQnwaVScj2r1F/kgx7mCM=;
        b=L+gmiR8Uv+LTUmqrQvJ5fIrFkAKefg9ZXvQVegAkx0Vqap36eu9nwcLH2+uaNxQudH
         8ndDejP1dYBRb0TiNbkznhfLO7cGsIrqPrWMtCUv9hmf9QXnkqDiM/ceKtYDHCkCFb6g
         oOj0PpcfDRWvDea03x4PyvbGmaYZtz+smzX3z+LwNCNHmKE+3cfnJJLlQIWk/WgmEgDi
         lponTzKxsTTL0nYh+axIa31RKQudjVGqivACXre6OG5iaEFcLOpurVvoCloqcQov10W5
         qcUyjf1Uhzn4NqKEWruhVOIOpvexdbo4Z81/8CHgMkyuQGyeLN5VrdBM8kEcZp2gOd+v
         bonQ==
X-Gm-Message-State: APjAAAXYraH76VrrkCrYEzChN/qc1qtGTnQx8IMkNuE1+F7gUr4kG/27
        H2dZVk6KP8Egtta6P07LtDgbaQ==
X-Google-Smtp-Source: APXvYqyev6JUD7Cgpq+QD6BsUkX6hZCGFvGo0usW/rNEhRfV/oQEPsa1k3RR3apalU7SCOTsPntQdQ==
X-Received: by 2002:a17:902:b7cb:: with SMTP id v11mr23076612plz.153.1567626866334;
        Wed, 04 Sep 2019 12:54:26 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id j2sm6631739pfe.130.2019.09.04.12.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 12:54:25 -0700 (PDT)
Date:   Wed, 4 Sep 2019 12:54:25 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [rfc 4/4] mm, page_alloc: allow hugepage fallback to remote nodes
 when madvised
Message-ID: <alpine.DEB.2.21.1909041253560.94813@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For systems configured to always try hard to allocate transparent
hugepages (thp defrag setting of "always") or for memory that has been
explicitly madvised to MADV_HUGEPAGE, it is often better to fallback to
remote memory to allocate the hugepage if the local allocation fails
first.

The point is to allow the initial call to __alloc_pages_node() to attempt
to defragment local memory to make a hugepage available, if possible,
rather than immediately fallback to remote memory.  Local hugepages will
always have a better access latency than remote (huge)pages, so an attempt
to make a hugepage available locally is always preferred.

If memory compaction cannot be successful locally, however, it is likely
better to fallback to remote memory.  This could take on two forms: either
allow immediate fallback to remote memory or do per-zone watermark checks.
It would be possible to fallback only when per-zone watermarks fail for
order-0 memory, since that would require local reclaim for all subsequent
faults so remote huge allocation is likely better than thrashing the local
zone for large workloads.

In this case, it is assumed that because the system is configured to try
hard to allocate hugepages or the vma is advised to explicitly want to try
hard for hugepages that remote allocation is better when local allocation
and memory compaction have both failed.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/mempolicy.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2133,6 +2133,17 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 			mpol_cond_put(pol);
 			page = __alloc_pages_node(hpage_node,
 						gfp | __GFP_THISNODE, order);
+
+			/*
+			 * If hugepage allocations are configured to always
+			 * synchronous compact or the vma has been madvised
+			 * to prefer hugepage backing, retry allowing remote
+			 * memory as well.
+			 */
+			if (!page && (gfp & __GFP_DIRECT_RECLAIM))
+				page = __alloc_pages_node(hpage_node,
+						gfp | __GFP_NORETRY, order);
+
 			goto out;
 		}
 	}
