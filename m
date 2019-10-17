Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6654FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890F221835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iQ8REaZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409166AbfJQQmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:42:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40070 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbfJQQmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:42:39 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9HGX19f032097
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=5IKBSWNWLYlihFA44gFxxhrEU6DLltroRzqjX+u2NXU=;
 b=iQ8REaZ8XEqVGUbxjdhwF62J8w6O7NW607y82D9vGtFOECWTk2bpmPaobnB9hyPZS79K
 Kgl6J7wWFopVK91dOUkzaqCkZy1lTP1s/Wty9LpjbsazY5GzrImc8MrF/d0UmUXFnWLl
 yEzqzhHC+ZW8nK784FfIA+SoUbwBUKLM7JE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vp3udefm7-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 09:42:38 -0700
Received: from 2401:db00:2050:5076:face:0:1f:0 (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 17 Oct 2019 09:42:35 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6A11762E1477; Thu, 17 Oct 2019 09:42:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <akpm@linux-foundation.org>
CC:     <matthew.wilcox@oracle.com>, <kernel-team@fb.com>,
        <william.kucharski@oracle.com>, <kirill.shutemov@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 0/5] Fixes for THP in page cache
Date:   Thu, 17 Oct 2019 09:42:17 -0700
Message-ID: <20191017164223.2762148-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_05:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=747
 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910170149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set includes a few fixes for THP in page cache. They are based on
Linus's master branch.

Thanks,
Song

Changes v1 -> v2:
1. Return -EINVAL if the WARN() triggers. (Oleg Nesterov)
2. Include William Kucharski's fix to vmscan.c, which replaces half of
   original (3/4).

Kirill A. Shutemov (3):
  proc/meminfo: fix output alignment
  mm/thp: fix node page state in split_huge_page_to_list()
  mm/thp: allow drop THP from page cache

Song Liu (1):
  uprobe: only do FOLL_SPLIT_PMD for uprobe register

William Kucharski (1):
  mm: Support removing arbitrary sized pages from mapping

 fs/proc/meminfo.c       |  4 ++--
 kernel/events/uprobes.c | 13 +++++++++++--
 mm/huge_memory.c        |  9 +++++++--
 mm/truncate.c           | 12 ++++++++++++
 mm/vmscan.c             |  5 +----
 5 files changed, 33 insertions(+), 10 deletions(-)

--
2.17.1
