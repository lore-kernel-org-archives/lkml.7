Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9186CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 22:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C7D206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 22:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PpBFfsX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbfJMWL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 18:11:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18606 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfJMWL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 18:11:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da3a12f0000>; Sun, 13 Oct 2019 15:11:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 13 Oct 2019 15:11:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 13 Oct 2019 15:11:57 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 13 Oct
 2019 22:11:56 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 13 Oct 2019 22:11:56 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5da3a12c0003>; Sun, 13 Oct 2019 15:11:56 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/2] gup.c, gup_benchmark.c trivial fixes before the storm
Date:   Sun, 13 Oct 2019 15:11:53 -0700
Message-ID: <20191013221155.382378-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571004719; bh=GJdEuFRyn6Ii7YSSUijkjSCPq8I7gGArrxywqXqoEAA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=PpBFfsX9B4HfnOaGSL/BiWDrv6XyjJ1dSSBDSchj2M1LMbkH6cQKnoHVw6DKOzhoF
         sJBZb3aDE8UuKBOn+p4GyGWoMbIpdH9/6UGCxvu4I2jNTriO8e9eXkowThVqPtLdi1
         esRT4MPczoAeGERSy6Japc2jSyZgg2lgfczEz8vp4wypsxR6T2LAbKTI175euuTb9Z
         NhXtgo+wKg+O3chtgcnBKE1JuYbWk4i0lt5dMDZkct1kOA+uURWI71tm8sLaDWQtxP
         WDeyuIYd9fMIBU4M+o2i39kXP/16Evksp7wCYIxtzk3Bk53BmPZOcxX11HkBvJCx2M
         BJeCUzQW0nkHA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These trivial fixes apply to today's linux.git (5.4-rc3, or maybe -rc4, by
the time I send this).

I found these while polishing up the Next And Final get_user_pages()+dma
tracking patchset (which is in final testing and passing nicely...so far).

Anyway, as these two patches apply cleanly both before and after the larger
gup/dma upcoming patchset, I thought it best to send this out separately,
in order to avoid muddying the waters more than usual.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org


John Hubbard (2):
  mm/gup_benchmark: add a missing "w" to getopt string
  mm/gup: fix a misnamed "write" argument: should be "flags"

 mm/gup.c                                   | 12 +++++++-----
 tools/testing/selftests/vm/gup_benchmark.c |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

--=20
2.23.0

