Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6DBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E3820B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfDHI1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:27:02 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:45294 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfDHI1C (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 8 Apr 2019 04:27:02 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 08 Apr 2019 10:27:00 +0200
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Mon, 08 Apr 2019 09:26:45 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 0/2] Preparing memhotplug for allocating memmap from hot-added range
Date:   Mon,  8 Apr 2019 10:26:31 +0200
Message-Id: <20190408082633.2864-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2: Added David's feedback and his Reviewed-by

Hi,

these patches were posted as part of patchset [1], but it was agreed that
patch#3 must be further discussed.
Whole discussion can be seen in the cover letter.

But the first two patches make sense by themselves, as the first one is a nice
code cleanup, and the second one sets up the interface that the feature implemented
in [1] will use.

We decided to go this way because there are other people working on the same area,
and conflicts can arise easily, so better merge it now.
Also, it is safe as they do not implement any functional changes.

[1] https://patchwork.kernel.org/cover/10875017/

Michal Hocko (2):
  mm, memory_hotplug: cleanup memory offline path
  mm, memory_hotplug: provide a more generic restrictions for memory
    hotplug

 arch/arm64/mm/mmu.c            |  6 ++---
 arch/ia64/mm/init.c            |  6 ++---
 arch/powerpc/mm/mem.c          |  6 ++---
 arch/s390/mm/init.c            |  6 ++---
 arch/sh/mm/init.c              |  6 ++---
 arch/x86/mm/init_32.c          |  6 ++---
 arch/x86/mm/init_64.c          | 10 ++++----
 include/linux/memory_hotplug.h | 32 ++++++++++++++++++------
 kernel/memremap.c              | 12 ++++++---
 mm/memory_hotplug.c            | 56 ++++++++++++++----------------------------
 mm/page_alloc.c                | 11 +++++++--
 11 files changed, 84 insertions(+), 73 deletions(-)

-- 
2.13.7

