Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1414C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AF2206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Xci64heN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbgAIR2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48254 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730111AbgAIR2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:31 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009HQZv6015920
        for <linux-kernel@vger.kernel.org>; Thu, 9 Jan 2020 09:28:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=jnlgsDdtYVJveaI0G6Q7dmewjsI31Dp2x/oUOXsEp0g=;
 b=Xci64heNvHp7/gmXUk5+Uzkig0u46Vd6/Gt2x3k8ZiufYiQNyh5ma26pXDmYFZ0Kz4U/
 a+LaLjJvE/v4beM/6k3M8Sd04UtXorYhpKAl+401BWfqP5MZvzILS+1IwiZRjfMSIx8u
 WJg98a9jPyEO/YRa9WZnKrudgBh1SCQs31c= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2xdtwdbwdb-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 09:28:30 -0800
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 9 Jan 2020 09:28:20 -0800
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 74D281D2DC5D6; Thu,  9 Jan 2020 09:28:18 -0800 (PST)
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
Subject: [PATCH 1/7] mm: kmem: remove duplicate definitions of __memcg_kmem_(un)charge()
Date:   Thu, 9 Jan 2020 09:27:39 -0800
Message-ID: <20200109172745.285585-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200109172745.285585-1-guro@fb.com>
References: <20200109172745.285585-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-09_03:2020-01-09,2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 mlxlogscore=730 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001090143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason these inline functions are defined twice. Remove
the second identical copy.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 include/linux/memcontrol.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a7a0a1a5c8d5..9745d172ba18 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1438,15 +1438,6 @@ static inline void memcg_kmem_uncharge(struct page *page, int order)
 {
 }
 
-static inline int __memcg_kmem_charge(struct page *page, gfp_t gfp, int order)
-{
-	return 0;
-}
-
-static inline void __memcg_kmem_uncharge(struct page *page, int order)
-{
-}
-
 #define for_each_memcg_cache_index(_idx)	\
 	for (; NULL; )
 
-- 
2.21.1

