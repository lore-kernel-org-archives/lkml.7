Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2C8CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72C120873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7ppMjOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfJaOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:30:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34729 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728096AbfJaOaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572532199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1vLA2aaSbsVZTqJYFKSssRBFqJQhInsNJX02oeyquPQ=;
        b=I7ppMjOTvHzgHzw2g8uHzAbyfZJOE1jMQQbI7TNF44+SKe/JjJaUcLCX2bLWa18vHVmY4/
        NapkEMhp7Evmp73qcJHZbbHm7X48BOy3ip6mE64HtCqal+eEshcjpKOK+nN055YwQPnlnB
        hpXhPYmt6s1xx6bmB3AEnvj+ScIvAEY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-LkKy19_aPp-1GGbtKKuzMQ-1; Thu, 31 Oct 2019 10:29:55 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20B9C800D49;
        Thu, 31 Oct 2019 14:29:45 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB6D15D6D6;
        Thu, 31 Oct 2019 14:29:33 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Allison Randal <allison@lohutok.net>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Arun KS <arunks@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Brauner <christian@brauner.io>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Gao Xiang <xiang@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Hackmann <ghackmann@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Richard Fontana <rfontana@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v1 00/12] powerpc/pseries: CMM: Implement balloon compaction and remove isolate notifier
Date:   Thu, 31 Oct 2019 15:29:21 +0100
Message-Id: <20191031142933.10779-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: LkKy19_aPp-1GGbtKKuzMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up of:
=09https://lkml.org/lkml/2019/9/10/711

We can get rid of the memory isolate notifier by switching to balloon
compaction in powerpc's CMM (Collaborative Memory Management). The memory
isolate notifier was only necessary to allow to offline memory blocks that
contain inflated/"loaned" pages - which also possible when the inflated
pages are movable (via balloon compaction). Having movable pages implies
that memory will also no longer get fragmented when CMM is active.

While I do have access to a LPAR, it does not have CMM active and I have np
clue how to enable it. Instead, I implemented a simple simulation mode. I
did some tests and the whole infrastructure, including page migration,
seems to work fine (e.g., I can still offline memory blocks that contain
inflated pages). Of course, I cannot tell if HW will like the changes,
especially:

1. I now use page_to_phys() to come up with the addresses to report to
   the hypervisor. Hope that's correct.
2. When migrating a page, I first inflate/"loan" the new page and then
   deflate the old page. I have no idea if HW accepts to set pages loaned
   if it didn't request a loan. I assume it does.
3. We might now inflate/deflate pages in parallel (of course, not the
   same page). I have no idea if HW likes that.

It would be good if somebody could either point me at the spec of the
hypervisor interface or verify directly. Also, it would be good if somebody
could test with actual HW that has this feature.

Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Arun KS <arunks@codeaurora.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Christian Brauner <christian@brauner.io>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: Gao Xiang <xiang@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Hackmann <ghackmann@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Qian Cai <cai@lca.pw>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Todd Kjos <tkjos@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richardw.yang@linux.intel.com>

David Hildenbrand (12):
  powerpc/pseries: CMM: Implement release() function for sysfs device
  powerpc/pseries: CMM: Report errors when registering notifiers fails
  powerpc/pseries: CMM: Cleanup rc handling in cmm_init()
  powerpc/pseries: CMM: Drop page array
  powerpc/pseries: CMM: Use adjust_managed_page_count() insted of
    totalram_pages_*
  powerpc/pseries: CMM: Rip out memory isolate notifier
  powerpc/pseries: CMM: Convert loaned_pages to an atomic_long_t
  powerpc/pseries: CMM: Implement balloon compaction
  powerpc/pseries: CMM: Switch to balloon_page_alloc()
  powerpc/pseries: CMM: Simulation mode
  mm: remove the memory isolate notifier
  mm: remove "count" parameter from has_unmovable_pages()

 arch/powerpc/platforms/pseries/Kconfig |   1 +
 arch/powerpc/platforms/pseries/cmm.c   | 430 +++++++++++--------------
 drivers/base/memory.c                  |  19 --
 include/linux/memory.h                 |  27 --
 include/linux/page-isolation.h         |   4 +-
 include/uapi/linux/magic.h             |   1 +
 mm/memory_hotplug.c                    |   2 +-
 mm/page_alloc.c                        |  21 +-
 mm/page_isolation.c                    |  27 +-
 9 files changed, 204 insertions(+), 328 deletions(-)

--=20
2.21.0

