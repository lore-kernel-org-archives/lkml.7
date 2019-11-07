Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CEBC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707D21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k+BoMVv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388394AbfKGLyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:54:43 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59286 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfKGLyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:54:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7BsGS5065558;
        Thu, 7 Nov 2019 11:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=NfAYcg+x2BRWdeKjZp6DmQCHJxccvsCiuX38sXcbKfQ=;
 b=k+BoMVv2VPzauh3dpUT209wHIhNZmkCO2vmj17B5OqMefort5Sd3At75HW7qtM+lZZlL
 qj49U2nbMRZDil62piSCTleg1YicOicQWOdbFULnDQjpK/DB+hWbMScYDrmga/6qKl76
 ww4tforsylneI+f8Ei1TN2GcgKxKxhrQ182DMnnkrNAt7ygfT2rEnpzjmpfCr4p7rTk0
 ikDtQUccaCw6cqbVkleOfHCxpKEHqXYL3TH5h/tppeVflVc4tPna3wnVY/d9SFYwvKhi
 qr0H9stV8m3FQcBZ2A/70mVx6pGeOSVpKZ5Cf7WWi9lCPimrsqlucfXKKUO1SrrWf+Zh qA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2w41w0wj46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:54:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA7Bs86B063177;
        Thu, 7 Nov 2019 11:54:28 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2w41w9m8h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Nov 2019 11:54:28 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA7BsQfc014595;
        Thu, 7 Nov 2019 11:54:27 GMT
Received: from abi.no.oracle.com (/10.172.144.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Nov 2019 03:54:26 -0800
From:   Knut Omang <knut.omang@oracle.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Knut Omang <knut.omang@oracle.com>
Subject: [PATCH] mm: provide interface for retrieving kmem_cache name
Date:   Thu,  7 Nov 2019 12:54:04 +0100
Message-Id: <20191107115404.3030723-1-knut.omang@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911070122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9433 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911070122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the restructuring done in commit 9adeaa226988
("mm, slab: move memcg_cache_params structure to mm/slab.h")

it is no longer possible for code external to mm to access
the name of a kmem_cache as struct kmem_cache has effectively become
opaque. Having access to the cache name is helpful to kernel testing
infrastructure.

Expose a new function kmem_cache_name to mitigate that.

Signed-off-by: Knut Omang <knut.omang@oracle.com>
---
 include/linux/slab.h | 1 +
 mm/slab_common.c     | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 4d2a2fa55ed5..3298c9db6e46 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -702,6 +702,7 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
 }
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
+const char *kmem_cache_name(struct kmem_cache *s);
 void __init kmem_cache_init_late(void);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f9fb27b4c843..269a99dc8214 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -82,6 +82,15 @@ unsigned int kmem_cache_size(struct kmem_cache *s)
 }
 EXPORT_SYMBOL(kmem_cache_size);
 
+/*
+ * Get the name of a slab object
+ */
+const char *kmem_cache_name(struct kmem_cache *s)
+{
+	return s->name;
+}
+EXPORT_SYMBOL(kmem_cache_name);
+
 #ifdef CONFIG_DEBUG_VM
 static int kmem_cache_sanity_check(const char *name, unsigned int size)
 {
-- 
2.20.1

