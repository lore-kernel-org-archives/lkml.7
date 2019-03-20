Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71389C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6C92184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCTPXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:23:43 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:48923 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbfCTPXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:23:42 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 20 Mar 2019 08:23:37 -0700
Received: from fedoratest.localdomain (unknown [10.30.24.114])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 1115B4199D;
        Wed, 20 Mar 2019 08:23:37 -0700 (PDT)
From:   Thomas Hellstrom <thellstrom@vmware.com>
To:     <dri-devel@lists.freedesktop.org>
CC:     <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 0/3] mm modifications / helpers for emulated GPU coherent memory
Date:   Wed, 20 Mar 2019 16:23:12 +0100
Message-ID: <20190320152315.82758-1-thellstrom@vmware.com>
X-Mailer: git-send-email 2.19.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: thellstrom@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Hi,
This is an early RFC to make sure I don't go too far in the wrong direction.

Non-coherent GPUs that can't directly see contents in CPU-visible memory,
like VMWare's SVGA device, run into trouble when trying to implement
coherent memory requirements of modern graphics APIs. Examples are
Vulkan and OpenGL 4.4's ARB_buffer_storage.

To remedy, we need to emulate coherent memory. Typically when it's detected
that a buffer object is about to be accessed by the GPU, we need to
gather the ranges that have been dirtied by the CPU since the last operation,
apply an operation to make the content visible to the GPU and clear the
the dirty tracking.

Depending on the size of the buffer object and the access pattern there are
two major possibilities:

1) Use page_mkwrite() and pfn_mkwrite(). (GPU buffer objects are backed
either by PCI device memory or by driver-alloced pages).
The dirty-tracking needs to be reset by write-protecting the affected ptes
and flush tlb. This has a complexity of O(num_dirty_pages), but the
write page-fault is of course costly.

2) Use hardware dirty-flags in the ptes. The dirty-tracking needs to be reset
by clearing the dirty bits and flush tlb. This has a complexity of
O(num_buffer_object_pages) and dirty bits need to be scanned in full before
each gpu-access.

So in practice the two methods need to be interleaved for best performance.

So to facilitate this, I propose two new helpers, apply_as_wrprotect() and
apply_as_clean() ("as" stands for address-space) both inspired by
unmap_mapping_range(). Users of these helpers are in the making, but needs
some cleaning-up.

There's also a change to x_mkwrite() to allow dropping the mmap_sem while
waiting.

Any comments or suggestions appreciated.

Thanks,
Thomas



