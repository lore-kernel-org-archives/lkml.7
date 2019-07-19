Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DCC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7676C21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 19:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f1zyVgL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfGSTaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 15:30:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12405 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfGSTaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 15:30:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d321a400000>; Fri, 19 Jul 2019 12:30:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 19 Jul 2019 12:30:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 19 Jul 2019 12:30:01 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 19 Jul
 2019 19:30:01 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 19 Jul 2019 19:30:01 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d321a380008>; Fri, 19 Jul 2019 12:30:00 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v2 0/3] mm/hmm: fixes for device private page migration
Date:   Fri, 19 Jul 2019 12:29:52 -0700
Message-ID: <20190719192955.30462-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1563564608; bh=lzvQpqIVeAPQspf/bNGxauqHX/fDBWVwZY/7PMGCtIU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=f1zyVgL62a6J62vELNsAkF8adZRIJsmhjhNt9ae9hmswAqZgPy7W34pHtD0IjtTCt
         JEpnm9W+2O2A+ET/L2emFffOjibWenG+ZqkQ5f+ICrC08wFEfGrs8bvTsKn0teCnIK
         S6Vw/R3nqhKWiviB/BXyi0+pfFyxbpyFuE2Oc+sSxTGJHOZu7cBAtwPdz87YPKgqpO
         uFEQ/g5xHRvQm++75knbg+2DioQw4unpiDzwwYCe6J2CwZ+f4aoHf/oOTuIbeNCaJM
         2C7JFDt0xjZcSb7NXI2cJDhSv+2EmmNF2tR2XCrYGTRhBS7yhr6QIl5PLmyUR6B0Zp
         zVr0JtVpfU3fQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing the latest linux git tree turned up a few bugs with page
migration to and from ZONE_DEVICE private and anonymous pages.
Hopefully it clarifies how ZONE_DEVICE private struct page uses
the same mapping and index fields from the source anonymous page
mapping.

Changes from v1 to v2:

Patch #1 merges ZONE_DEVICE page struct into a union of lru and
a struct for ZONE_DEVICE fields. So, basically a new patch.

Patch #2 updates the code comments for clearing page->mapping as
suggested by John Hubbard.

Patch #3 is unchanged from the previous posting but note that
Andrew Morton has v1 queued in v5.2-mmotm-2019-07-18-16-08.

Ralph Campbell (3):
  mm: document zone device struct page reserved fields
  mm/hmm: fix ZONE_DEVICE anon page mapping reuse
  mm/hmm: Fix bad subpage pointer in try_to_unmap_one

 include/linux/mm_types.h | 9 ++++++++-
 kernel/memremap.c        | 4 ++++
 mm/rmap.c                | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

--=20
2.20.1

