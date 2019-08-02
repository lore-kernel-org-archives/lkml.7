Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ECAC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81D62087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 23:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zc85Mvjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437343AbfHBXS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 19:18:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392601AbfHBXS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 19:18:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x72NHvfA026581
        for <linux-kernel@vger.kernel.org>; Fri, 2 Aug 2019 16:18:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=zP/oZCNmT3XfZ0O8wKdyr35FShYUm1XHrIrNthNeVsc=;
 b=Zc85MvjfmG7XFnhSGb9Y4KWBA8FVB+sNukkhmkmldF0TKh2dn/XSvkzKkQL8ppraWqo1
 hxH0rWzIMH1Uvok2GE1ZjqL630ak/Mcbt8xb6wy19ixrKtqahVpbugp1EoSqzQiGL0fg
 j8Zs22FgFDZyZVciTRaxIcgDTFoO3WLriUY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u4py09vqs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 16:18:22 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 2 Aug 2019 16:18:21 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6514562E2BEF; Fri,  2 Aug 2019 16:18:19 -0700 (PDT)
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
Subject: [PATCH v4 0/2] khugepaged: collapse pmd for pte-mapped THP
Date:   Fri, 2 Aug 2019 16:18:15 -0700
Message-ID: <20190802231817.548920-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=649 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908020241
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes v3 => v4:
1. Simplify locking for pte_mapped_thp (Oleg).
2. Improve checks for the page in collapse_pte_mapped_thp() (Oleg).
3. Move HPAGE_PMD_MASK to collapse_pte_mapped_thp() (kbuild test robot).

Changes v2 => v3:
1. Update vma/pmd check in collapse_pte_mapped_thp() (Oleg).
2. Add Acked-by from Kirill

Changes v1 => v2:
1. Call collapse_pte_mapped_thp() directly from uprobe_write_opcode();
2. Add VM_BUG_ON() for addr alignment in khugepaged_add_pte_mapped_thp()
   and collapse_pte_mapped_thp().

This set is the newer version of 5/6 and 6/6 of [1]. Newer version of
1-4 of the work [2] was recently picked by Andrew.

Patch 1 enables khugepaged to handle pte-mapped THP. These THPs are left
in such state when khugepaged failed to get exclusive lock of mmap_sem.

Patch 2 leverages work in 1 for uprobe on THP. After [2], uprobe only
splits the PMD. When the uprobe is disabled, we get pte-mapped THP.
After this set, these pte-mapped THP will be collapsed as pmd-mapped.

[1] https://lkml.org/lkml/2019/6/23/23
[2] https://www.spinics.net/lists/linux-mm/msg185889.html

Song Liu (2):
  khugepaged: enable collapse pmd for pte-mapped THP
  uprobe: collapse THP pmd after removing all uprobes

 include/linux/khugepaged.h |  12 ++++
 kernel/events/uprobes.c    |   9 +++
 mm/khugepaged.c            | 125 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 145 insertions(+), 1 deletion(-)

--
2.17.1
