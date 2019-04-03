Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D18C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5632084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCTda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:33:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34415 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCTd3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 15AEC3092667;
        Wed,  3 Apr 2019 19:33:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D211360156;
        Wed,  3 Apr 2019 19:33:27 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH v3 00/12] Improve HMM driver API v3
Date:   Wed,  3 Apr 2019 15:33:06 -0400
Message-Id: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 03 Apr 2019 19:33:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Changes since v2:
    - Improved the documentations
    - Added more comments in the code to explain things
    - Renamed bunch of functions from popular demands


This patchset improves the HMM driver API and add support for mirroring
virtual address that are mmap of hugetlbfs or of a file in a filesystem
on a DAX block device. You can find a tree with all the patches [1]

This patchset is necessary for converting ODP to HMM and patch to do so
as been posted [2]. All new functions introduced by this patchset are use
by the ODP patch. The ODP patch will be push through the RDMA tree the
release after this patchset is merged.

Moreover all HMM functions are use by the nouveau driver starting in 5.1.

The last patch in the serie add helpers to directly dma map/unmap pages
for virtual addresses that are mirrored on behalf of device driver. This
has been extracted from ODP code as it is is a common pattern accross HMM
device driver. It will be first use by the ODP RDMA code and will latter
get use by nouveau and other driver that are working on including HMM
support.

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-for-5.2.v3
[2] https://cgit.freedesktop.org/~glisse/linux/log/?h=odp-hmm
[3] https://lkml.org/lkml/2019/1/29/1008

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>

Jérôme Glisse (12):
  mm/hmm: select mmu notifier when selecting HMM v2
  mm/hmm: use reference counting for HMM struct v3
  mm/hmm: do not erase snapshot when a range is invalidated
  mm/hmm: improve and rename hmm_vma_get_pfns() to hmm_range_snapshot()
    v2
  mm/hmm: improve and rename hmm_vma_fault() to hmm_range_fault() v3
  mm/hmm: improve driver API to work and wait over a range v3
  mm/hmm: add default fault flags to avoid the need to pre-fill pfns
    arrays v2
  mm/hmm: mirror hugetlbfs (snapshoting, faulting and DMA mapping) v3
  mm/hmm: allow to mirror vma of a file on a DAX backed filesystem v3
  mm/hmm: add helpers to test if mm is still alive or not
  mm/hmm: add an helper function that fault pages and map them to a
    device v3
  mm/hmm: convert various hmm_pfn_* to device_entry which is a better
    name

 Documentation/vm/hmm.rst |   94 +++-
 include/linux/hmm.h      |  310 ++++++++---
 mm/Kconfig               |    2 +-
 mm/hmm.c                 | 1077 ++++++++++++++++++++++++++------------
 4 files changed, 1054 insertions(+), 429 deletions(-)

-- 
2.17.2

