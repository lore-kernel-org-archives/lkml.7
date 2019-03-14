Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434A20643
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 09:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kmpsjWob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfCNJRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 05:17:54 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:12873 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbfCNJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 05:17:53 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190314091749epoutp03de47191e54d5240d04427bb476f695f1~LyJw0NAyL3116231162epoutp03I
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:17:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190314091749epoutp03de47191e54d5240d04427bb476f695f1~LyJw0NAyL3116231162epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552555069;
        bh=TBSPacjDBRt29WucItJ+ryEabDmz+yHuIehAMKg0jHA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=kmpsjWobsQk2PjMSJylV3etuL8/T7Gmx6taet1ynrlRzrh5mN0qByIs5D725vYOVG
         dYZkcaGPdP8Otr17XrUGVjKtPMNPY9kFaVlBRm9OSP4N19VlwexOHVa9EK59K+9Gy/
         2+KlvZZxdZspaBzudET5y5vf+cnPnF4/yeI5ucnw=
Received: from epsmges5p1new.samsung.com (unknown [182.195.40.192]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190314091747epcas5p39411e191292171081ea989b3911a8d6b~LyJup2w3k1805618056epcas5p3C;
        Thu, 14 Mar 2019 09:17:47 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.55.04071.B3C1A8C5; Thu, 14 Mar 2019 18:17:47 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe~LyJTLQWIi1805618056epcas5p3l;
        Thu, 14 Mar 2019 09:17:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190314091717epsmtrp1e3cea31c7d38c43f29abbc815134123c~LyJTKhjbD1916019160epsmtrp1Q;
        Thu, 14 Mar 2019 09:17:17 +0000 (GMT)
X-AuditID: b6c32a49-5b7ff70000000fe7-f9-5c8a1c3b019b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.EF.03662.D1C1A8C5; Thu, 14 Mar 2019 18:17:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190314091716epsmtip14c762596c22bf4db200763ca28e66e97~LyJSAg2Hw0289902899epsmtip16;
        Thu, 14 Mar 2019 09:17:16 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] Smack: Create smack_rule cache to optimize memory usage
Date:   Thu, 14 Mar 2019 14:36:33 +0530
Message-Id: <1552554393-11691-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXe241GaHZbR4/LWsT5oqJs2m+VMSGqVH+wCkVnzoC+btJ2N
        nc1LEBhE0MxLNgssxYooxAy0zAtSaWaZKWKXiWliahc0TCtBwdo8k/r2ey5//n/e96EI2aBE
        TuVwNmzlWCND+ombOiMio3YGOTIUrg65eqANq0ebFkn1YOt1Uj17cZxUj04/FKnrh1+hZFJb
        8qAWabse3yS18w0haUS6MdGA2WxsDcNcljk7h9NrmAOHdbt1qniFMkqZoN7OhHGsCWuYlNS0
        qD05RrctE5bLGu3uVhrL80xMUqLVbLfhMIOZt2kYbMk2WpSxlmieNfF2Th+dZTbtUCoUsSr3
        ZqbR0Na5SFimIb9xqF9SiFoCHMiXAnobvO9/QTqQHyWj2xCM/vkuFoo5BL3PXBKh+I2geP49
        WpXMzEwhYdCOYP7ZVa/kJ4Ifj52EZ4ukt0Jx9YjIwwE0C7MTzT4eJuhjsPhoifTwOjoV+p4U
        uS0oSkxvgRbnMU9bSu+FBec1r1kIvHx+eSUF0DMSmHsySQiDFHB0d4kEXgffuh/4CCyHr6Xn
        fQRBEYLJ2V4kFE4ENz6XedW7YMzV5eNxJugIuN8aI7SDoaKnXiQE9YfipQmvgRSaq1d5C1SU
        F3nNNkKnq1cssBZGlmtWUsvoEzB+5R5ZhoIr/znUIFSLArGFN+kxr7IoOZz3/1c1oJWDitzX
        jCr7UjsQTSFmjbSQuJAhk7C5fIGpAwFFMAFSCHRkyKTZbMFpbDXrrHYj5juQyv2Clwj5+iyz
        +zw5m06pio2PVyQoVHHqeCWzQVoVXHVcRutZGz6FsQVbV3UiyldeiPRVZ8ma9PDUkoUqF+eI
        g7zmsYEhOqn90/CHsU2HHG8GojaX66gzUs1RTeiQ6Qsrar2bf3vyyDgT2hJysm7SWvwwqC43
        SKLzX95fXdd9JWeq0m9t+NupqYiP2tLGfEf1HT/Xu4M9o8Ovnb80hqVbx88lz/XX5T0N+mDv
        0x7qaspkxLyBVUYSVp79C0OuLOBmAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSnK6sTFeMwYvNJhYXd6da3Nv2i83i
        8q45bBYfeh6xWdx7s5XJYt3t04wObB59W1Yxehzdv4jN4/MmuQDmKC6blNSczLLUIn27BK6M
        3Yd/MRe8kajYfPM8awPjTpEuRk4OCQETibdvnzF2MXJxCAnsZpQ4/ek9M0RCWmJJ5xt2CFtY
        YuW/5+wQRZ8YJR5cWgZWxCagLdE77y4TiC0ikCyxu3k6I4jNLBAtMe1ZFwuILSzgI3HuQDdr
        FyMHB4uAqsTOKZEgYV4Bd4nvU2YzQsyXkzh5bDLrBEaeBYwMqxglUwuKc9Nziw0LjPJSy/WK
        E3OLS/PS9ZLzczcxgoNES2sH44kT8YcYBTgYlXh4NRg7Y4RYE8uKK3MPMUpwMCuJ8EpIdsUI
        8aYkVlalFuXHF5XmpBYfYpTmYFES55XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNSujTS51TZ3
        i0MHz6z28ES95NoNO7l+7uwtv7DqwHSDi5uOPxMNO1axyNfyzckXds45DcqJ53O7rEI63i6e
        Yzp983en0g19dr1lnr31OTExERGJKTPn5vzWZtQ9cK1c22idRqXxtqWLS86JN///eZjrifMG
        to9/Zjzhdb50KK/+RNeM6Nk75ZRYijMSDbWYi4oTAdjTYmEOAgAA
X-CMS-MailID: 20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe
References: <CGME20190314091717epcas5p34ec02dc48347e76c2ba7a9d9c6fa9abe@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows for small memory optimization by creating the
kmem cache for "struct smack_rule" instead of using kzalloc.
For adding new smack rule, kzalloc is used to allocate the memory
for "struct smack_rule". kzalloc will always allocate 32 or 64 bytes
for 1 structure depending upon the kzalloc cache sizes available in
system. Although the size of structure is 20 bytes only, resulting
in memory wastage per object in the default pool.

For e.g., if there are 20000 rules, then it will save 240KB(20000*12)
which is crucial for small memory targets.

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 security/smack/smack.h     |  1 +
 security/smack/smack_lsm.c | 12 ++++++++++--
 security/smack/smackfs.c   |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/security/smack/smack.h b/security/smack/smack.h
index 6a71fc7..a5d7461 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -354,6 +354,7 @@ int smk_tskacc(struct task_smack *, struct smack_known *,
 
 #define SMACK_HASH_SLOTS 16
 extern struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
+extern struct kmem_cache *smack_rule_cache;
 
 /*
  * Is the directory transmuting?
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 319add3..16b6cf5 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -56,6 +56,7 @@
 static LIST_HEAD(smk_ipv6_port_list);
 #endif
 static struct kmem_cache *smack_inode_cache;
+struct kmem_cache *smack_rule_cache;
 int smack_enabled;
 
 static const match_table_t smk_mount_tokens = {
@@ -349,7 +350,7 @@ static int smk_copy_rules(struct list_head *nhead, struct list_head *ohead,
 	int rc = 0;
 
 	list_for_each_entry_rcu(orp, ohead, list) {
-		nrp = kzalloc(sizeof(struct smack_rule), gfp);
+		nrp = kmem_cache_zalloc(smack_rule_cache, gfp);
 		if (nrp == NULL) {
 			rc = -ENOMEM;
 			break;
@@ -1995,7 +1996,7 @@ static void smack_cred_free(struct cred *cred)
 	list_for_each_safe(l, n, &tsp->smk_rules) {
 		rp = list_entry(l, struct smack_rule, list);
 		list_del(&rp->list);
-		kfree(rp);
+		kmem_cache_free(smack_rule_cache, rp);
 	}
 	kfree(tsp);
 }
@@ -4788,10 +4789,17 @@ static __init int smack_init(void)
 	if (!smack_inode_cache)
 		return -ENOMEM;
 
+	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
+	if (!smack_rule_cache) {
+		kmem_cache_destroy(smack_inode_cache);
+		return -ENOMEM;
+	}
+
 	tsp = new_task_smack(&smack_known_floor, &smack_known_floor,
 				GFP_KERNEL);
 	if (tsp == NULL) {
 		kmem_cache_destroy(smack_inode_cache);
+		kmem_cache_destroy(smack_rule_cache);
 		return -ENOMEM;
 	}
 
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index 2a8a1f5..d8a0e25 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -236,7 +236,7 @@ static int smk_set_access(struct smack_parsed_rule *srp,
 	}
 
 	if (found == 0) {
-		sp = kzalloc(sizeof(*sp), GFP_KERNEL);
+		sp = kmem_cache_zalloc(smack_rule_cache, GFP_KERNEL);
 		if (sp == NULL) {
 			rc = -ENOMEM;
 			goto out;
-- 
1.9.1

