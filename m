Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B5C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710621773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfFNKB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:01:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727447AbfFNKBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:01:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B670308FBB4;
        Fri, 14 Jun 2019 10:01:33 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-252.ams2.redhat.com [10.36.116.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22F6D5D9C3;
        Fri, 14 Jun 2019 10:01:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juergen Gross <jgross@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Len Brown <lenb@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Oscar Salvador <osalvador@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Qian Cai <cai@lca.pw>, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/6] mm: Further memory block device cleanups
Date:   Fri, 14 Jun 2019 12:01:08 +0200
Message-Id: <20190614100114.311-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 14 Jun 2019 10:01:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some further cleanups around memory block devices. Especially, clean up
and simplify walk_memory_range(). Including some other minor cleanups.

Based on: linux-next

Minor conflict with Dan's subsection hot-add series.
Compiled + tested on x86 with DIMMs under QEMU.

David Hildenbrand (6):
  mm: Section numbers use the type "unsigned long"
  drivers/base/memory: Use "unsigned long" for block ids
  mm: Make register_mem_sect_under_node() static
  mm/memory_hotplug: Rename walk_memory_range() and pass start+size
    instead of pfns
  mm/memory_hotplug: Move and simplify walk_memory_blocks()
  drivers/base/memory.c: Get rid of find_memory_block_hinted()

 arch/powerpc/platforms/powernv/memtrace.c | 22 +++---
 drivers/acpi/acpi_memhotplug.c            | 19 ++----
 drivers/base/memory.c                     | 81 +++++++++++++++++------
 drivers/base/node.c                       |  8 ++-
 include/linux/memory.h                    |  5 +-
 include/linux/memory_hotplug.h            |  2 -
 include/linux/mmzone.h                    |  4 +-
 include/linux/node.h                      |  7 --
 mm/memory_hotplug.c                       | 57 +---------------
 mm/sparse.c                               | 12 ++--
 10 files changed, 92 insertions(+), 125 deletions(-)

-- 
2.21.0

