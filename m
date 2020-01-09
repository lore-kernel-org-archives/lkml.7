Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B77C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC3320721
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KQnPmDwb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgAIR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388126AbgAIR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:26 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 009HS8F6025262
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=KF+G+5MGSSib1j/y16MoaGVIL2x224fhh1Xrxl1wcBY=;
 b=KQnPmDwbLfhDBLXNEa5tidPjixsL3mnuvchCjmWjfVZ/BpF1bzNXWkfkol/tRDDw9bLI
 LbUtHH1sNAyC/O/xao+8ICOxvCi2qfh83BSZ2dbx9Gn2QbObIsQABjAURj7JSTYGX8Fc
 l6sq610ugdCxJc6vfUgwX4Qq+rf2+pZRt+w= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 2xdrhwvg2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:25 -0800
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 9 Jan 2020 09:28:23 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 728CE1D2DC5D4; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 0/7] mm: memcg: kmem API cleanup
Date:   Thu, 9 Jan 2020 09:27:38 -0800
Message-ID: <20200109172745.285585-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=589 malwarescore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to clean up the kernel memory charging API.
It doesn't bring any functional changes, just removes unused
arguments, duplicate definitions, renames some functions and
fixes some comments.

Currently it's not obvious which functions are most basic
(memcg_kmem_(un)charge_memcg()) and which are based on them
(memcg_kmem_(un)charge()). The patchset renames these functions
and removes unused arguments:

TL;DR:
was:
  memcg_kmem_charge_memcg(page, gfp, order, memcg)
  memcg_kmem_uncharge_memcg(memcg, nr_pages)
  memcg_kmem_charge(page, gfp, order)
  memcg_kmem_uncharge(page, order)

now:
  memcg_kmem_charge(memcg, gfp, nr_pages)
  memcg_kmem_uncharge(memcg, nr_pages)
  memcg_kmem_charge_page(page, gfp, order)
  memcg_kmem_uncharge_page(page, order)


Roman Gushchin (7):
  mm: kmem: remove duplicate definitions of __memcg_kmem_(un)charge()
  mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments
  mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments
  mm: kmem: rename memcg_kmem_(un)charge() into
    memcg_kmem_(un)charge_page()
  mm: kmem: switch to nr_pages in (__)memcg_kmem_charge_memcg()
  mm: memcg/slab: cache page number in memcg_(un)charge_slab()
  mm: kmem: rename (__)memcg_kmem_(un)charge_memcg() to
    __memcg_kmem_(un)charge()

 fs/pipe.c                  |  2 +-
 include/linux/memcontrol.h | 46 ++++++++++++++------------------
 kernel/fork.c              |  9 ++++---
 mm/memcontrol.c            | 54 ++++++++++++++++++--------------------
 mm/page_alloc.c            |  4 +--
 mm/slab.h                  | 22 +++++++++-------
 6 files changed, 65 insertions(+), 72 deletions(-)

-- 
2.21.1

