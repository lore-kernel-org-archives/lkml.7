Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF21C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C032C20644
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 23:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="a2YqjvGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfHSXBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 19:01:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14952 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728123AbfHSXBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:01:02 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JMxm2N014502
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:01:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=VpSPCuRkw9YjLy32A3fG7gTdrUBWo/zGfrtLtIVsUJs=;
 b=a2YqjvGnN7k9OvLr3eaEijYPfALwKTQQWZYMzAE5fcR8UqOvu1Y1+XLC8q5QaI6WloAl
 wUdK2Nv58TnHBYKNUa/KWlfZRSDKXoJyMl+uwhzg4sCZR0wWFEdKwFmILl/GDSnenV9g
 GpQ+A6BDw9PpmEGaS6JrCS+LvuWULIoYEug= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ug45p87a6-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 16:01:01 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 19 Aug 2019 16:00:57 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 6D0D8168C4889; Mon, 19 Aug 2019 16:00:56 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH v3 0/3] vmstats/vmevents flushing
Date:   Mon, 19 Aug 2019 16:00:51 -0700
Message-ID: <20190819230054.779745-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=555 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190227
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
  1) rearranged patches [2/3] and [3/3] to make [1/2] and [2/2] suitable
  for stable backporting

v2:
  1) fixed !CONFIG_MEMCG_KMEM build by moving memcg_flush_percpu_vmstats()
  and memcg_flush_percpu_vmevents() out of CONFIG_MEMCG_KMEM
  2) merged add-comments-to-slab-enums-definition patch in

Thanks!

Roman Gushchin (3):
  mm: memcontrol: flush percpu vmstats before releasing memcg
  mm: memcontrol: flush percpu vmevents before releasing memcg
  mm: memcontrol: flush percpu slab vmstats on kmem offlining

 include/linux/mmzone.h |  5 +--
 mm/memcontrol.c        | 79 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+), 2 deletions(-)

-- 
2.21.0

