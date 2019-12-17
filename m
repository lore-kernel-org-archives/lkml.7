Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B14C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A0872082E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 12:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB47TxYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbfLQMjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:39:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbfLQMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 07:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576586344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6/+/rP4yVcVCmqqAdPWGNeQB+QcVV+9W2swAIqchAZ8=;
        b=OB47TxYSprW5Yde5WgyM8wlNbGzrv2aCwbrquu2D6i/tUovsEIBGBuyn4V9PmNnwqhVqzi
        /S0g58mUdlo12lPGnnyB9MaFJnR+0P9T+2Gy36dxS/90iCnghX8OgG1ClGxB7mBTJ7ALd4
        qraVvsrEijFkxdTWuFA0wqk3txNr6Js=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-69guOL_oM8Ge5FQcEp_K6A-1; Tue, 17 Dec 2019 07:39:01 -0500
X-MC-Unique: 69guOL_oM8Ge5FQcEp_K6A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07544800D4E;
        Tue, 17 Dec 2019 12:38:58 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E50671000329;
        Tue, 17 Dec 2019 12:38:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RFC v1 0/3] powerpc/memtrace: Don't offline memory blocks via offline_pages()
Date:   Tue, 17 Dec 2019 13:38:48 +0100
Message-Id: <20191217123851.8854-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC is based on linux-next and
- 2 patches from "PATCH RFC v4 00/13] virtio-mem: paravirtualized memory"
 -> "mm: Allow to offline unmovable PageOffline() pages via
     MEM_GOING_OFFLINE" [1]
 -> "mm/memory_hotplug: Introduce offline_and_remove_memory()" [2]
- "mm/memory_hotplug: Don't free usage map when removing a re-added early
   section" [3]

A branch with all patches (kept updated) is available at:
	https://github.com/davidhildenbrand/linux.git memtrace

Stop using offline_pages() to offline memory blocks. Allocate the memory
blocks using alloc_contig_pages() first and offline+remove the allcoated
memory blocks using a clean MM interface. Offlining of allocated memory i=
s
made possible by using PageOffline() in combination with a memory notifie=
r
(similar to virto-mem).

Note: In the future, we might want to switch to only removing/readding th=
e
page tables of the allocated memory (while still marking it PageOffline()=
).
However, that might have other implications, and requires work from PPC
people (IOW, I won't fiddle with that :) ).

[1] https://lkml.kernel.org/r/20191212171137.13872-8-david@redhat.com
[2] https://lkml.kernel.org/r/20191212171137.13872-10-david@redhat.com
[3] https://lkml.kernel.org/r/20191217104637.5509-1-david@redhat.com


David Hildenbrand (3):
  powerpc/memtrace: Enforce power of 2 for memory buffer size
  powerpc/memtrace: Factor out readding memory into memtrace_free_node()
  powerpc/memtrace: Don't offline memory blocks via offline_pages()

 arch/powerpc/platforms/powernv/Kconfig    |   1 +
 arch/powerpc/platforms/powernv/memtrace.c | 217 ++++++++++++++--------
 2 files changed, 136 insertions(+), 82 deletions(-)

--=20
2.23.0

