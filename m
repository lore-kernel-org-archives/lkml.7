Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5296621871
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Fjpy76Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfHGXhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:37:37 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20760 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729920AbfHGXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:37:36 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x77NXfmZ023061
        for <linux-kernel@vger.kernel.org>; Wed, 7 Aug 2019 16:37:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=op9v1bVVFyuCK4u6NbEw0zfrPrC4P/eMblGeVRptrhg=;
 b=Fjpy76Tr41SY5eWxo7uw80Txt9dJsyzDbgh2qw1uUtsXYrV2Xt+Fl1POFbOb6TBp8MZc
 hvqlHKZBq1TyG0pXcuwWsWUDqVTVBBelYIik92dLiG36wIsgDm+WqHZ7b31uKf55JN5M
 V0h/JOb3EDMi5QYi3ZmO72amDRtbt6AkrMs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2u87ue83xw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 16:37:35 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Aug 2019 16:37:34 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id E08D762E2D9E; Wed,  7 Aug 2019 16:37:32 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kirill.shutemov@linux.intel.com>,
        <oleg@redhat.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <srikar@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v12 0/6] THP aware uprobe
Date:   Wed, 7 Aug 2019 16:37:23 -0700
Message-ID: <20190807233729.3899352-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-07_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908070208
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set makes uprobe aware of THPs.

Currently, when uprobe is attached to text on THP, the page is split by
FOLL_SPLIT. As a result, uprobe eliminates the performance benefit of THP.

This set makes uprobe THP-aware. Instead of FOLL_SPLIT, we introduces
FOLL_SPLIT_PMD, which only split PMD for uprobe.

After all uprobes within the THP are removed, the PTE-mapped pages are
regrouped as huge PMD.

This set (plus a few THP patches) is also available at

   https://github.com/liu-song-6/linux/tree/uprobe-thp


Changes v11.4 => v12
1. Combine the first 4 patches with the rest 2 patches again in the same
   set.
2. Improve checks for the page in collapse_pte_mapped_thp() (Oleg).
3. Fixed build error w/o CONFIG_SHMEM.

v11.1 to v11.4 are only the last two patches.

Changes v11.3 => v11.4:
1. Simplify locking for pte_mapped_thp (Oleg).
2. Improve checks for the page in collapse_pte_mapped_thp() (Oleg).
3. Move HPAGE_PMD_MASK to collapse_pte_mapped_thp() (kbuild test robot).

Changes v11.2 => v11.3:
1. Update vma/pmd check in collapse_pte_mapped_thp() (Oleg).
2. Add Acked-by from Kirill

Changes v11.1 => v11.2:
1. Call collapse_pte_mapped_thp() directly from uprobe_write_opcode();
2. Add VM_BUG_ON() for addr alignment in khugepaged_add_pte_mapped_thp()
   and collapse_pte_mapped_thp().

Changes v9 => v10:
1. 2/4 incorporate suggestion by Oleg Nesterov.
2. Reword change log of 4/4.

Changes v8 => v9:
1. To replace with orig_page, only unmap old_page. Let the orig_page fault
   in (Oleg Nesterov).

Changes v7 => v8:
1. check PageUptodate() for orig_page (Oleg Nesterov).

Changes v6 => v7:
1. Include Acked-by from Kirill A. Shutemov for the first 4 patches;
2. Keep only the first 4 patches (while I working on improving the last 2).

Changes v5 => v6:
1. Enable khugepaged to collapse pmd for pte-mapped THP
   (Kirill A. Shutemov).
2. uprobe asks khuagepaged to collaspe pmd. (Kirill A. Shutemov)

Note: Theast two patches in v6 the set apply _after_ v7 of set "Enable THP
      for text section of non-shmem files"

Changes v4 => v5:
1. Propagate pte_alloc() error out of follow_pmd_mask().

Changes since v3:
1. Simplify FOLL_SPLIT_PMD case in follow_pmd_mask(), (Kirill A. Shutemov)
2. Fix try_collapse_huge_pmd() to match change in follow_pmd_mask().

Changes since v2:
1. For FOLL_SPLIT_PMD, populated the page table in follow_pmd_mask().
2. Simplify logic in uprobe_write_opcode. (Oleg Nesterov)
3. Fix page refcount handling with FOLL_SPLIT_PMD.
4. Much more testing, together with THP on ext4 and btrfs (sending in
   separate set).
5. Rebased.

Changes since v1:
1. introduces FOLL_SPLIT_PMD, instead of modifying split_huge_pmd*();
2. reuse pages_identical() from ksm.c;
3. rewrite most of try_collapse_huge_pmd().

Song Liu (6):
  mm: move memcmp_pages() and pages_identical()
  uprobe: use original page when all uprobes are removed
  mm, thp: introduce FOLL_SPLIT_PMD
  uprobe: use FOLL_SPLIT_PMD instead of FOLL_SPLIT
  khugepaged: enable collapse pmd for pte-mapped THP
  uprobe: collapse THP pmd after removing all uprobes

 include/linux/khugepaged.h |  12 ++++
 include/linux/mm.h         |   8 +++
 kernel/events/uprobes.c    |  81 ++++++++++++++++-----
 mm/gup.c                   |   8 ++-
 mm/khugepaged.c            | 140 ++++++++++++++++++++++++++++++++++++-
 mm/ksm.c                   |  18 -----
 mm/util.c                  |  13 ++++
 7 files changed, 240 insertions(+), 40 deletions(-)

--
2.17.1
