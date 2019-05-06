Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C862DC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B7D7206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 23:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LwG+Z+Iy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfEFXaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 19:30:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15211 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFXaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 19:30:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd0c36d0000>; Mon, 06 May 2019 16:29:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 May 2019 16:30:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 May 2019 16:30:23 -0700
Received: from rcampbell-dev.nvidia.com (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 May
 2019 23:30:23 +0000
From:   <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/5] mm/hmm: HMM documentation updates and code fixes
Date:   Mon, 6 May 2019 16:29:37 -0700
Message-ID: <20190506232942.12623-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557185389; bh=mta6lvER55pJmKi6odFyptVYcK5PuHqcwXSPKJWVRbY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:X-Originating-IP:
         X-ClientProxiedBy:Content-Transfer-Encoding:Content-Type;
        b=LwG+Z+IypCu/9CAOnvaVu10/3zZeMNdtntNmkP+Wy9zH5AuV3pgXklp6x/VXDiVk1
         pYvpjypSdkVh+WcZIQl+58wbS96p8vDHAzxD53/XRb2U9b4AlIFACrbdgXXSMbmnvl
         xpdZT8dE2iQqRPBgOxKL0bTLcpPJPsvtIFtqXSRzkEDD4DGXZbqaX07jX+hb6GIAQN
         cxBONRH7a7Avcam0YtnIBN7ysG+Wky5nPcDfovDeHcqrKL8eg5BY/URsbjy5RxzqWp
         Kkhxv8o3+AM1C6szZ4TDWZ846ybHWGxTpOPVMHMXGwT92Iqani0qWBab2YbsrOO5D7
         Wknzcx03wK0qg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

I hit a use after free bug in hmm_free() with KASAN and then couldn't
stop myself from cleaning up a bunch of documentation and coding style
changes. So the first two patches are clean ups, the last three are
the fixes.

Ralph Campbell (5):
  mm/hmm: Update HMM documentation
  mm/hmm: Clean up some coding style and comments
  mm/hmm: Use mm_get_hmm() in hmm_range_register()
  mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
  mm/hmm: Fix mm stale reference use in hmm_free()

 Documentation/vm/hmm.rst | 139 ++++++++++++++++++-----------------
 include/linux/hmm.h      |  84 ++++++++++------------
 mm/hmm.c                 | 151 ++++++++++++++++-----------------------
 3 files changed, 174 insertions(+), 200 deletions(-)

--=20
2.20.1

