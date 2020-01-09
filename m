Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7116C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6562077B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="H6lqO3hx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgAIU1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:27:17 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38920 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728661AbgAIU1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:27:15 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009KPj7s008585
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 12:27:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=wvt7sOKddWl0OpvJUtFtaN/ehHbunwfiqpNcAec1a6Y=;
 b=H6lqO3hxvV/U1RtFT580/PVf9JAYUvevGXleupjBwf4TSFSvd3DmHlULkNbxzNwACWVx
 0CZrea7aVieHwV7pH1Iy0o10whSr2MjRaOAKWAksCnnWWZweQodEu/m4bS4fmJmEtbeg
 kFItkSiyPWv8NOBrM3gO0XWnje1/RWQhwd0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xe2exu210-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 12:27:13 -0800
Received: from intmgw001.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 12:27:12 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 24D471D2F0DC2; Thu,  9 Jan 2020 12:27:07 -0800 (PST)
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
Subject: [PATCH v2 0/6] mm: memcg: kmem API cleanup
Date:   Thu, 9 Jan 2020 12:26:53 -0800
Message-ID: <20200109202659.752357-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_04:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=659 mlxscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090168
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset aims to clean up the kernel memory charging API.
It doesn't bring any functional changes, just removes unused
arguments, renames some functions and fixes some comments.

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


v2:
1) Dropped the first patch, which was incorrect. Thanks, Andrew!


Roman Gushchin (6):
  mm: kmem: cleanup (__)memcg_kmem_charge_memcg() arguments
  mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments
  mm: kmem: rename memcg_kmem_(un)charge() into
    memcg_kmem_(un)charge_page()
  mm: kmem: switch to nr_pages in (__)memcg_kmem_charge_memcg()
  mm: memcg/slab: cache page number in memcg_(un)charge_slab()
  mm: kmem: rename (__)memcg_kmem_(un)charge_memcg() to
    __memcg_kmem_(un)charge()

 fs/pipe.c                  |  2 +-
 include/linux/memcontrol.h | 42 +++++++++++++++--------------
 kernel/fork.c              |  9 ++++---
 mm/memcontrol.c            | 54 ++++++++++++++++++--------------------
 mm/page_alloc.c            |  4 +--
 mm/slab.h                  | 22 +++++++++-------
 6 files changed, 68 insertions(+), 65 deletions(-)

-- 
2.21.1

