Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A607C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F83243CF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:04:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="EvdA7zmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfE3BEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:04:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43540 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbfE3BEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:04:12 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4U0x9XD005915
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 18:04:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=W7mXSzFJmpTIGoX10F4q0oy7Gwk05FCas4SOMrrW6Lo=;
 b=EvdA7zmA60hMMfmn6aBL+OBI69VbwHvQBd2YLvYhKmi3venFWcfTo9lQCf+3ZvjUrJrv
 p1o/DePZmWgkRz+bgBpxYlRy2iDAU1DeBQY9tXAY/5resluPc1XV1qVr9m+B+44lMoY3
 bt86smyrvpqiZg2Pk2UlPGxAzQCM6GCRXEg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2ssvdut0x2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 18:04:10 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 29 May 2019 18:04:09 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A4DB5129321E1; Wed, 29 May 2019 18:04:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 1/5] bpf: add memlock precharge check for cgroup_local_storage
Date:   Wed, 29 May 2019 18:03:55 -0700
Message-ID: <20190530010359.2499670-2-guro@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530010359.2499670-1-guro@fb.com>
References: <20190530010359.2499670-1-guro@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300006
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgroup local storage maps lack the memlock precharge check,
which is performed before the memory allocation for
most other bpf map types.

Let's add it in order to unify all map types.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/local_storage.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index 980e8f1f6cb5..e48302ecb389 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -272,6 +272,8 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 {
 	int numa_node = bpf_map_attr_numa_node(attr);
 	struct bpf_cgroup_storage_map *map;
+	u32 pages;
+	int ret;
 
 	if (attr->key_size != sizeof(struct bpf_cgroup_storage_key))
 		return ERR_PTR(-EINVAL);
@@ -290,13 +292,18 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 		/* max_entries is not used and enforced to be 0 */
 		return ERR_PTR(-EINVAL);
 
+	pages = round_up(sizeof(struct bpf_cgroup_storage_map), PAGE_SIZE) >>
+		PAGE_SHIFT;
+	ret = bpf_map_precharge_memlock(pages);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
 	map = kmalloc_node(sizeof(struct bpf_cgroup_storage_map),
 			   __GFP_ZERO | GFP_USER, numa_node);
 	if (!map)
 		return ERR_PTR(-ENOMEM);
 
-	map->map.pages = round_up(sizeof(struct bpf_cgroup_storage_map),
-				  PAGE_SIZE) >> PAGE_SHIFT;
+	map->map.pages = pages;
 
 	/* copy mandatory map attributes */
 	bpf_map_init_from_attr(&map->map, attr);
-- 
2.20.1

