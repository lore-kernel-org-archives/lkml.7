Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A985CA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0790D207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KqzOYL/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729365AbfJUOTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:19:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729084AbfJUOTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571667580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=kZ6Mcix+9m7WQGIN9HWJzI4Ey3gZshb2QTgwDgYGF+c=;
        b=KqzOYL/qCyqzqcUG/CX4cw148e6xMXiHcPRSmKsCa1PVxhSx1ZzvhwShFoPfxJLRxhxQ1B
        HN0xaCtcuqVUPiIVBISehM3YZV1Fk38YELKY6CCkmbz+AMggkdCZqv1VtyXHSMBj+cKbyj
        Lsi2awEEFOsrE2co2+/1Ly6qS7wtrWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-OXzbBYdzN_Ksazgk459aew-1; Mon, 21 Oct 2019 10:19:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185EA80183E;
        Mon, 21 Oct 2019 14:19:34 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBEE35D6A5;
        Mon, 21 Oct 2019 14:19:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Pingfan Liu <kernelfans@gmail.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/2] mm: Memory offlining + page isolation cleanups
Date:   Mon, 21 Oct 2019 16:19:24 +0200
Message-Id: <20191021141927.10252-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OXzbBYdzN_Ksazgk459aew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two cleanups that popped up while working on (and discussing) virtio-mem:
=09https://lkml.org/lkml/2019/9/19/463

Tested with DIMMs on x86.

David Hildenbrand (2):
  mm/page_alloc.c: Don't set pages PageReserved() when offlining
  mm/page_isolation.c: Convert SKIP_HWPOISON to MEMORY_OFFLINE

 include/linux/page-isolation.h |  4 ++--
 mm/memory_hotplug.c            |  8 +++++---
 mm/page_alloc.c                |  9 +++------
 mm/page_isolation.c            | 12 ++++++------
 4 files changed, 16 insertions(+), 17 deletions(-)

--=20
2.21.0

