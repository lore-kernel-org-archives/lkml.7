Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B6C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59A2189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 23:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mHFm/5BS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfGXX1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 19:27:07 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15280 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbfGXX1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 19:27:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d38e94a0000>; Wed, 24 Jul 2019 16:27:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 24 Jul 2019 16:27:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 24 Jul 2019 16:27:06 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jul
 2019 23:27:05 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 24 Jul 2019 23:27:05 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d38e9490001>; Wed, 24 Jul 2019 16:27:05 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH v3 0/3] mm/hmm: fixes for device private page migration
Date:   Wed, 24 Jul 2019 16:26:57 -0700
Message-ID: <20190724232700.23327-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564010826; bh=gTLfLpBBgzH14pN0OishW6D/G2zPoxenwkGRe8J45rs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=mHFm/5BSNkpiIizmFlxJBFlZ5AY3WiRyFEePDr9oWQ473aDpCVLOrRoB6nx0KwvjS
         HYxtHV5bRdS23e6YHjzo2c+4shRrFMHOLx4DXn/XfeN/VXzFHKHJ3KcmukN5izfPyb
         pHTAlnOE1JXeN8ZEnA8uY3CFSvD4vUReVd21A/cehRYjo7rr8nZkwkZRgNDX5nKtok
         smxmGyZ/IUUAmmt6AVIAeIi1avYMjafvV4pQGVOwa3mtrI0if+Hf3GfcoNiNEivQgW
         LI/+XnVIJppguZ69lKQjgs9cAKna0rPAqcb1junJAQrye8vz3mCYu4dXF/xVJyE7xv
         JySHepvCjAlrA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing the latest linux git tree turned up a few bugs with page
migration to and from ZONE_DEVICE private and anonymous pages.
Hopefully this series clarifies how ZONE_DEVICE private struct page
uses the same mapping and index fields from the source anonymous page
mapping.

Changes from v2 to v3:

Patch #1 is basically new (like v1 but with comments from v2) to
accommodate Matthew Wilcox's NAK of v2 and Christoph's objection to
adding _zd_pad fields in v1.

Patch #2 adds reviewed-by

Patch #3 adds comments explaining the reason for setting "subpage".

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

