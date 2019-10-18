Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AACCA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4EDB21D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nOPSo1zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406997AbfJRA2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:28:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55036 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405004AbfJRA2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:28:38 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9I0ONdI002666
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=nOordKf0fXrBOx3atNeexqICGFlyz2QswU+/WEJB+fI=;
 b=nOPSo1zXMejNXJGruS+xfNy2y5DMPVIkm6EgjUJLxYYrEaUVkBZdJGBvI0lH9sx+Aedg
 2G0IwK4Hp6dG1blN+aaItGOaMr7Z78gxUdLMTz0wRrXJOD/SiPmfiSEQ3C2g+bekJ96z
 LHQcjig3SdvhFz0LK9Ouay+sqePa5xesJhc= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vq2nkr1pf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 17:28:37 -0700
Received: from 2401:db00:30:6012:face:0:17:0 (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Thu, 17 Oct 2019 17:28:36 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id 2382218CE8493; Thu, 17 Oct 2019 17:28:34 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     <linux-mm@kvack.org>
CC:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH 16/16] mm: slab: remove redundant check in memcg_accumulate_slabinfo()
Date:   Thu, 17 Oct 2019 17:28:20 -0700
Message-ID: <20191018002820.307763-17-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191018002820.307763-1-guro@fb.com>
References: <20191018002820.307763-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-17_07:2019-10-17,2019-10-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=705
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910180001
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_accumulate_slabinfo() is never called with a non-root
kmem_cache as a first argument, so the is_root_cache(s) check
is redundant and can be removed without any functional change.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 mm/slab_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3dcd90ba7525..1c10c94343f6 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1105,9 +1105,6 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
 	struct kmem_cache *c;
 	struct slabinfo sinfo;
 
-	if (!is_root_cache(s))
-		return;
-
 	c = memcg_cache(s);
 	if (c) {
 		memset(&sinfo, 0, sizeof(sinfo));
-- 
2.21.0

