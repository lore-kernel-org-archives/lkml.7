Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07336C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DB322BF5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 00:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YuFWjX01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGZA44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 20:56:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11306 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfGZA44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 20:56:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d3a4fd70000>; Thu, 25 Jul 2019 17:56:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 17:56:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 17:56:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:56:55 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jul
 2019 00:56:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jul 2019 00:56:54 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d3a4fd60000>; Thu, 25 Jul 2019 17:56:54 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Subject: [PATCH v2 0/7] mm/hmm: more HMM clean up
Date:   Thu, 25 Jul 2019 17:56:43 -0700
Message-ID: <20190726005650.2566-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564102616; bh=5+MT9OBADQ1SPlqa4lbGtzxIR+MyjShmpHu800z/6QY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Type:
         Content-Transfer-Encoding;
        b=YuFWjX012+NgjLM9Bm4Tl9N6DrjrA2qBJ8XfMLtek1xIKcwAlW2zTR7ZBopoYELCY
         qq0y0XlrVhbGJ6bBZHliXVLop7L0xtDhK3U8CINQGLzvkB5pD+o97C6FGz3F6w/Y+V
         7Aw/qj+1tk977HV5Pp/V8fHOawl344UIfDB5VagbgnrLiYsock1yoxRDIWMnvtcIiV
         7yN6j2R9JWSd4G+IyKVyK7+jmk/6h9RlvhGC+nkCxxT7SIa8eHwU2SzryIf1Ql82Qa
         L3F083tLofkQ7gF9r/Wy3jeqyW8Q8xLCmPBJzzzv7BUC1SgdLrE5m0tn2mPCebXchj
         lGqghDh3XCyJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are seven more patches for things I found to clean up.
This was based on top of Christoph's seven patches:
"hmm_range_fault related fixes and legacy API removal v3".
I assume this will go into Jason's tree since there will likely be
more HMM changes in this cycle.

Changes from v1 to v2:

Added AMD GPU to hmm_update removal.
Added 2 patches from Christoph.
Added 2 patches as a result of Jason's suggestions.

Christoph Hellwig (2):
  mm/hmm: replace the block argument to hmm_range_fault with a flags
    value
  mm: merge hmm_range_snapshot into hmm_range_fault

Ralph Campbell (5):
  mm/hmm: replace hmm_update with mmu_notifier_range
  mm/hmm: a few more C style and comment clean ups
  mm/hmm: make full use of walk_page_range()
  mm/hmm: remove hugetlbfs check in hmm_vma_walk_pmd
  mm/hmm: remove hmm_range vma

 Documentation/vm/hmm.rst                |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  13 +-
 include/linux/hmm.h                     |  47 ++--
 mm/hmm.c                                | 340 ++++++++----------------
 6 files changed, 150 insertions(+), 277 deletions(-)

--=20
2.20.1

