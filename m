Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6735AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AD221726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 22:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3nTx7+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDEWMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:12:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35093 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfDEWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 18:12:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id g8so3764393pgf.2;
        Fri, 05 Apr 2019 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RFlyHVCvfroOhB2uXylkan752Y+bFRMjZlocuMb6szU=;
        b=b3nTx7+CUxVUlQscReM8Uk0JVZUKeHtdrGfJ+wUfk33PvUsvBzQAIzRc0Ik1qHli+/
         zTx/G00PbwkkS0GfK1dhoOcSSY3F5ZNAqhIl5zI6blFbjIrCcDlPlYKyHamM5/T0GfJX
         RHUbjorVVLWuSmbEbsexEY6xUYeP0iGnIeMgZ8QDwGvBBm8SDRV2POijtZccOQP/ae7d
         pfq9ekZoa6baUfaKVE9wTeoBy1a/zegQwxayKkYT1XwadVo/t3hEXPUAaFlz/j3lM36W
         DD85qcu4vx4fHBvmm6bDEDvE7zIn1c3CpVX3eS2RVq5DdVpJj/zOzz8O3cKBug+QAMC4
         JXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=RFlyHVCvfroOhB2uXylkan752Y+bFRMjZlocuMb6szU=;
        b=SkBc4YuO0V5HlHjjPYGScW1J7gYsnPMaDzv6wp25ZpDly63+SIBYqqfEBxdIZsoTha
         BU65lnAA0Wsrt+esDWNbQRQEzWMwfWE+zPy3fl+SVvz2xRrfhv0t+RqCqbBIsnJ5U5CT
         P9gEAlAYyE5/uSvquZd9+BjQFdTf1jsipt3nmE1NkXh5673RO1ni5yCBiPU8i/SAc6pn
         Jr9z9ASG8+/F3adSJztAkNItYjHCYtSsPz+2v6fyDY94ulaLhCZBFYCZH2sE3GgZxKri
         AaqoIUQ7twBpxaySCxUahIJrGPKWMNVHvZ24paLliDt3fofAx9JQkuGuCcH95m8ZQ/QT
         q1kA==
X-Gm-Message-State: APjAAAWX/Gy4LndXo1AWQDmx8u2U7YmDXx8Y2hICJSiY3gbywprtermr
        qinWVUzRhSs1AHDdNGhUIXg=
X-Google-Smtp-Source: APXvYqzcZRP6M2t/f+TFS8bfJasWfrNHx5XYhr8s6AbPgY9grB0g7CJ3SNDhP2NHNMThRf34AJUEoQ==
X-Received: by 2002:aa7:82d6:: with SMTP id f22mr15222497pfn.190.1554502328079;
        Fri, 05 Apr 2019 15:12:08 -0700 (PDT)
Received: from localhost.localdomain (50-126-100-225.drr01.csby.or.frontiernet.net. [50.126.100.225])
        by smtp.gmail.com with ESMTPSA id q81sm42013500pfi.102.2019.04.05.15.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 15:12:07 -0700 (PDT)
Subject: [mm PATCH v7 0/4] Deferred page init improvements
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, mingo@kernel.org, yi.z.zhang@linux.intel.com,
        khalid.aziz@oracle.com, rppt@linux.vnet.ibm.com, vbabka@suse.cz,
        sparclinux@vger.kernel.org, dan.j.williams@intel.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        davem@davemloft.net, kirill.shutemov@linux.intel.com
Date:   Fri, 05 Apr 2019 15:12:06 -0700
Message-ID: <20190405221043.12227.19679.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is essentially a refactor of the page initialization logic
that is meant to provide for better code reuse while providing a
significant improvement in deferred page initialization performance.

In my testing on an x86_64 system with 384GB of RAM I have seen the
following. In the case of regular memory initialization the deferred init
time was decreased from 3.75s to 1.38s on average. This amounts to a 172%
improvement for the deferred memory initialization performance.

I have called out the improvement observed with each patch.

v1->v2:
    Fixed build issue on PowerPC due to page struct size being 56
    Added new patch that removed __SetPageReserved call for hotplug
v2->v3:
    Rebased on latest linux-next
    Removed patch that had removed __SetPageReserved call from init
    Added patch that folded __SetPageReserved into set_page_links
    Tweaked __init_pageblock to use start_pfn to get section_nr instead of pfn
v3->v4:
    Updated patch description and comments for mm_zero_struct_page patch
        Replaced "default" with "case 64"
        Removed #ifndef mm_zero_struct_page
    Fixed typo in comment that ommited "_from" in kerneldoc for iterator
    Added Reviewed-by for patches reviewed by Pavel
    Added Acked-by from Michal Hocko
    Added deferred init times for patches that affect init performance
    Swapped patches 5 & 6, pulled some code/comments from 4 into 5
v4->v5:
    Updated Acks/Reviewed-by
    Rebased on latest linux-next
    Split core bits of zone iterator patch from MAX_ORDER_NR_PAGES init
v5->v6:
    Rebased on linux-next with previous v5 reverted
    Drop the "This patch" or "This change" from patch descriptions.
    Cleaned up patch descriptions for patches 3 & 4
    Fixed kerneldoc for __next_mem_pfn_range_in_zone
    Updated several Reviewed-by, and incorporated suggestions from Pavel
    Added __init_single_page_nolru to patch 5 to consolidate code
    Refactored iterator in patch 7 and fixed several issues
v6->v7:
    Updated MAX_ORDER_NR_PAGES patch to stop on section aligned boundaries
    Dropped patches 5-7
        Will follow-up later with reserved bit rework before resubmitting

---

Alexander Duyck (4):
      mm: Use mm_zero_struct_page from SPARC on all 64b architectures
      mm: Drop meminit_pfn_in_nid as it is redundant
      mm: Implement new zone specific memblock iterator
      mm: Initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections


 arch/sparc/include/asm/pgtable_64.h |   30 -----
 include/linux/memblock.h            |   41 +++++++
 include/linux/mm.h                  |   41 ++++++-
 mm/memblock.c                       |   64 ++++++++++
 mm/page_alloc.c                     |  218 ++++++++++++++++++++++-------------
 5 files changed, 277 insertions(+), 117 deletions(-)

--
