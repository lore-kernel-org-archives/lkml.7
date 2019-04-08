Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB729C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B1220880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDHKMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:12:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHKMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:12:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BF2D30821C0;
        Mon,  8 Apr 2019 10:12:34 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E39319C57;
        Mon,  8 Apr 2019 10:12:27 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Banman <andrew.banman@hpe.com>, mike.travis@hpe.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>, linux-mm@kvack.org,
        dan.j.williams@intel.com, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 0/3] mm/memory_hotplug: Factor out memory block device handling
Date:   Mon,  8 Apr 2019 12:12:23 +0200
Message-Id: <20190408101226.20976-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 08 Apr 2019 10:12:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only want memory block devices for memory to be onlined/offlined
(add/remove from the buddy). This is required so user space can
online/offline memory and kdump gets notified about newly onlined memory.

Only such memory has the requirement of having to span whole memory blocks.
Let's factor out creation/removal of memory block devices.

This not only allows to clean up arch_add_memory() to get rid of
want_memblock, but also reduces locking overhead and eventually allows
us to handle errors while adding memory in a nicer fashion.

Only did a quick sanity test with DIMM plug/unplug. This should be
sufficient to discuss the general approach. Patches are against
next/master.

David Hildenbrand (3):
  mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
  mm/memory_hotplug: Create memory block devices after arch_add_memory()
  mm/memory_hotplug: Remove memory block devices before
    arch_remove_memory()

 drivers/base/memory.c  | 108 +++++++++++++++++++++--------------------
 drivers/base/node.c    |   7 ++-
 include/linux/memory.h |   4 +-
 include/linux/node.h   |   6 +--
 mm/memory_hotplug.c    |  38 +++++++--------
 5 files changed, 81 insertions(+), 82 deletions(-)

-- 
2.17.2

