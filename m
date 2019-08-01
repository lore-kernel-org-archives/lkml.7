Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAAFBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BAE2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TNptSZZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfHASsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:48:32 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:4108 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730581AbfHASsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:48:32 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x71IhorF008325
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 11:48:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Ciezm0wiC/csO7UfdWXZ7gdzaa76ViA5xD+oUSRsxJA=;
 b=TNptSZZ9Cm/6Xu+L84EkdVGb6XQdPvaFcfpvwLEjrzdvVTpOYbgbDk+9OJlsMYOTNz+z
 pZ+DuveXikv0CVPNeHfVDar+faXgAH3YwLUhw8KYASkVYgvGWLiVcVR/EcAbImOZfiPH
 hyOSaNg9l7LH5/8iIBtQ4cY6Tta8obP+asw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2u43h7rkgs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 11:48:30 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 1 Aug 2019 11:48:30 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AAF5062E1FCA; Thu,  1 Aug 2019 11:48:27 -0700 (PDT)
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
Subject: [PATCH v3 0/2] khugepaged: collapse pmd for pte-mapped THP
Date:   Thu, 1 Aug 2019 11:48:21 -0700
Message-ID: <20190801184823.3184410-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=623 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010194
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/khugepaged.c            | 140 +++++++++++++++++++++++++++++++++++++
 3 files changed, 161 insertions(+)

--
2.17.1
