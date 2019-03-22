Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1169BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB6C21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbfCVBN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:13:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfCVBN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:13:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 530DD308FF14;
        Fri, 22 Mar 2019 01:13:27 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-121-16.rdu2.redhat.com [10.10.121.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 254E65D6B3;
        Fri, 22 Mar 2019 01:13:26 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: [PATCH v2 0/1] Use HMM for ODP v2
Date:   Thu, 21 Mar 2019 21:13:16 -0400
Message-Id: <20190322011317.6585-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 22 Mar 2019 01:13:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This is just a rebase with minor changes and better comments in the code.

Previous cover letter (slightly improved):

This patchset convert RDMA ODP to use HMM underneath this is motivated
by stronger code sharing for same feature (share virtual memory SVM or
Share Virtual Address SVA) and also stronger integration with mm code to
achieve that. It depends on HMM patchset [1].

Moreover they are some features of HMM in the works like peer to peer
support, fast CPU page table snapshot, fast IOMMU mapping update ...
It will be easier for RDMA devices with ODP to leverage those if they
use HMM underneath.

Quick summary of what HMM is:
    HMM is a toolbox for device driver to implement software support for
    Share Virtual Memory (SVM). Not only it provides helpers to mirror a
    process address space on a device (hmm_mirror). It also provides
    helper to allow to use device memory to back regular valid virtual
    address of a process (any valid mmap that is not an mmap of a device
    or a DAX mapping). They are two kinds of device memory. Private memory
    that is not accessible to CPU because it does not have all the expected
    properties (this is for all PCIE devices) or public memory which can
    also be access by CPU without restriction (with OpenCAPI or CCIX or
    similar cache-coherent and atomic inter-connect).

    Device driver can use each of HMM tools separatly. You do not have to
    use all the tools it provides.

For RDMA device i do not expect a need to use the device memory support
of HMM. This device memory support is geared toward accelerator like GPU.


You can find a branch [1] with all the prerequisite in. This patch is on
top of 5.1rc1+ but i can rebase it on any specific branch once HMM pre-
requisite is upstream.

[1] https://cgit.freedesktop.org/~glisse/linux/log/?h=odp-hmm
[2] https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-odp-v2

Cc: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Artemy Kovalyov <artemyko@mellanox.com>
Cc: Moni Shoua <monis@mellanox.com>,
Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
Cc: Kaike Wan <kaike.wan@intel.com>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>

Jérôme Glisse (1):
  RDMA/odp: convert to use HMM for ODP v2

 drivers/infiniband/core/umem_odp.c | 488 ++++++++---------------------
 drivers/infiniband/hw/mlx5/mem.c   |  20 +-
 drivers/infiniband/hw/mlx5/mr.c    |   2 +-
 drivers/infiniband/hw/mlx5/odp.c   | 106 ++++---
 include/rdma/ib_umem_odp.h         |  48 ++-
 5 files changed, 217 insertions(+), 447 deletions(-)

-- 
2.17.2

