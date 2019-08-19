Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED79C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665F922D37
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="oL/mhIYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfHSUYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:24:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbfHSUYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:24:06 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JKNrTP024579
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:24:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=4uPRcfWIdxQT6d1P8qbqaHfwG/PGyQALK4Vs/32HQ4E=;
 b=oL/mhIYuKsQpAYcIY7prKMhLgupuJ1rfJWPd0wgTM++sUDVUASsG+cbKJ0kSmd+fB+Cg
 IvZkHF/RTfQEzhG6K5zik/XwULA7QlKu8eR3OEPkvyq/vbBqgUD2Qm6ky+PhXFRkxsQP
 dm44+m7Te/Nuz6AYXsqQBnu0OR4TA+xll2E= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ufxcp17je-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 13:24:05 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Mon, 19 Aug 2019 13:23:48 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 451A3168A8ACE; Mon, 19 Aug 2019 13:23:47 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v2 0/3] vmstats/vmevents flushing
Date:   Mon, 19 Aug 2019 13:23:35 -0700
Message-ID: <20190819202338.363363-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=849 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190207
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of the patchset (v1 has been sent as a set of separate patches).
Kbuild test robot reported build issues:
memcg_flush_percpu_vmstats() and memcg_flush_percpu_vmevents() were
accidentally placed under CONFIG_MEMCG_KMEM, and caused
!CONFIG_MEMCG_KMEM build to fail.

V2 contains a trivial fix: both function were moved out of
the CONFIG_MEMCG_KMEM section.

Also, the add-comments-to-slab-enums-definition patch were merged into
patch 2.

Andrew, can you, please, drop the following 4 patches from the
mm tree and replaces them with this updated version?
  1) mm: memcontrol: flush percpu vmevents before releasing memcg
  2) mm-memcontrol-flush-percpu-slab-vmstats-on-kmem-offlining-fix
  3) mm: memcontrol: flush percpu slab vmstats on kmem offlining
  4) mm: memcontrol: flush percpu vmstats before releasing memcg

Thanks!

Roman Gushchin (3):
  mm: memcontrol: flush percpu vmstats before releasing memcg
  mm: memcontrol: flush percpu slab vmstats on kmem offlining
  mm: memcontrol: flush percpu vmevents before releasing memcg

 include/linux/mmzone.h |  5 +--
 mm/memcontrol.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

-- 
2.21.0

