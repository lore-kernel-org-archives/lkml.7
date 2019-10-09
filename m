Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8FBC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FED20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbfJIOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:24:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfJIOYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:24:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ADD4333027C;
        Wed,  9 Oct 2019 14:24:42 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5258D60BF4;
        Wed,  9 Oct 2019 14:24:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pankaj gupta <pagupta@redhat.com>, Qian Cai <cai@lca.pw>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
Subject: [PATCH v2 0/2] mm: Don't access uninitialized memmaps in PFN walkers
Date:   Wed,  9 Oct 2019 16:24:33 +0200
Message-Id: <20191009142435.3975-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 09 Oct 2019 14:24:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up of:
  [PATCH v1] mm: Fix access of uninitialized memmaps in fs/proc/page.c

We have multiple places where we might access uninitialized memmaps and
trigger kernel BUGs. Make sure to only access initialized memmaps.

Some of these places got easier to trigger with:
  [PATCH v6 00/10] mm/memory_hotplug: Shrink zones before removing memory
As memmaps are now also poisoned when memory is offlined, before it is
actually removed.

v1 -> v2:
- Drop ZONE_DEVICE support from the /proc/k... files as requested by Michal
- Further simplify the code
- Split up into two patches

David Hildenbrand (2):
  mm: Don't access uninitialized memmaps in fs/proc/page.c
  mm/memory-failure.c: Don't access uninitialized memmaps in
    memory_failure()

 fs/proc/page.c      | 28 ++++++++++++++++------------
 mm/memory-failure.c | 14 ++++++++------
 2 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.21.0

