Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83515C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C66F2071F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaqAJpF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKNNT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:19:29 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24857 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726190AbfKNNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573737567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DzLYkRszegqqW9y6TySH5Na1v7DLZhrGRv6iPZCzz2w=;
        b=HaqAJpF0g6OeRsy2h/3DJje95H7lTyaScHoDzWz+MMy6RvUp+3LxAsBt6Rn0f+Fx+DXoav
        0+2m7W4+ahPA0csY9JHHTCpD90DuXKeaR+46x1ERQmp8HYJxcfoahDBjOgm9YRAhSzhyea
        rMftONrAd0/6colxAOSUbv5NHZKjtSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-yhF_a1gEMSSlfy_JVwRXzg-1; Thu, 14 Nov 2019 08:19:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A114184B9F1;
        Thu, 14 Nov 2019 13:19:21 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-13.ams2.redhat.com [10.36.117.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 488E310375FC;
        Thu, 14 Nov 2019 13:19:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arun KS <arunks@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v2 0/2] mm: remove the memory isolate notifier
Date:   Thu, 14 Nov 2019 14:19:09 +0100
Message-Id: <20191114131911.11783-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yhF_a1gEMSSlfy_JVwRXzg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the MM part of
=09https://lkml.org/lkml/2019/10/31/487

"We can get rid of the memory isolate notifier by switching to balloon
compaction in powerpc's CMM (Collaborative Memory Management). The memory
isolate notifier was only necessary to allow to offline memory blocks that
contain inflated/"loaned" pages - which also possible when the inflated
pages are movable (via balloon compaction). [...]"

Michael queued the POWERPC bits that remove the single user, but I am
missing ACKs for the MM bits. I think it makes sense to let these two
patches also go via Michael's tree, to avoid collissions. Thoughts?

v1 -> v2: (MM bits)
- "mm: remove the memory isolate notifier"
-- Remove another stale comment
-- Minor code cleanup

David Hildenbrand (2):
  mm: remove the memory isolate notifier
  mm: remove "count" parameter from has_unmovable_pages()

 drivers/base/memory.c          | 19 -----------------
 include/linux/memory.h         | 27 ------------------------
 include/linux/page-isolation.h |  4 ++--
 mm/memory_hotplug.c            |  2 +-
 mm/page_alloc.c                | 21 +++++++------------
 mm/page_isolation.c            | 38 ++++------------------------------
 6 files changed, 14 insertions(+), 97 deletions(-)

--=20
2.21.0

