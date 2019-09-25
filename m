Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A864C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F046921D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="WANrQ3Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392467AbfIYT40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:56:26 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36734 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731229AbfIYT4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:56:25 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PJmV8r016820
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:56:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=ofCa75SVwrrk9TV45ZJF/7e5KFYqn8OqLVCsplE8mxc=;
 b=WANrQ3JbuqFkb99Ne+C1HvGYLcODZehbh8insmZR2ZyC5XmdfjelmOUFbjZXm5g1UKFm
 VRVKO5NgL54GFZcBeLeooM20+9t/VQ5JwjXYhs82ybs35qIHPZkmS7BubjiXujk9TpZ5
 xW1skNRsnUqgYsHYq4/r4TIY4xXNtDF2ZRM= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2v7tdww0c5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:56:24 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 25 Sep 2019 12:56:21 -0700
Received: by devvm1362.cln1.facebook.com (Postfix, from userid 167109)
        id 99EFE242D061D; Wed, 25 Sep 2019 12:56:19 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Jon Haslam <jonhaslam@fb.com>
Smtp-Origin-Hostname: devvm1362.cln1.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-doc@vger.kernel.org>, <corbet@lwn.net>,
        <hannes@cmpxchg.org>, <tj@kernel.org>, <guro@fb.com>,
        Jon Haslam <jonhaslam@fb.com>
Smtp-Origin-Cluster: cln1c09
Subject: [PATCH] docs: fix memory.low description in cgroup-v2.rst
Date:   Wed, 25 Sep 2019 12:56:04 -0700
Message-ID: <20190925195604.2153529-1-jonhaslam@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_09:2019-09-25,2019-09-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1011 suspectscore=1
 lowpriorityscore=0 mlxlogscore=826 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909250162
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current cgroup-v2.rst file contains an incorrect description of when
memory is reclaimed from a cgroup that is using the 'memory.low'
mechanism. This fix simply corrects the text to reflect the actual
implementation.

Fixes: 7854207fe954 ("mm/docs: describe memory.low refinements")
Signed-off-by: Jon Haslam <jonhaslam@fb.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0fa8c0e615c2..26d1cde6b34a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1117,8 +1117,8 @@ PAGE_SIZE multiple when read back.
 
 	Best-effort memory protection.  If the memory usage of a
 	cgroup is within its effective low boundary, the cgroup's
-	memory won't be reclaimed unless memory can be reclaimed
-	from unprotected cgroups.
+	memory won't be reclaimed unless there is no reclaimable
+	memory available in unprotected cgroups.
 
 	Effective low boundary is limited by memory.low values of
 	all ancestor cgroups. If there is memory.low overcommitment
@@ -1914,7 +1914,7 @@ Cpuset Interface Files
 
         It accepts only the following input values when written to.
 
-        "root"   - a paritition root
+        "root"   - a partition root
         "member" - a non-root member of a partition
 
 	When set to be a partition root, the current cgroup is the
-- 
2.17.1

