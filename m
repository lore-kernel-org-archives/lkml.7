Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16220C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D43220851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uz6ZVji5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGLg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:36:29 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:25117 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:36:29 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190307113624epoutp043eac9f5d76300a9cf12ea876a599111e~Jqhw83MeZ2913329133epoutp04S
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 11:36:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190307113624epoutp043eac9f5d76300a9cf12ea876a599111e~Jqhw83MeZ2913329133epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551958584;
        bh=7xxfmV34r5JHHrd85oa46z4MjrNb757ejbgfbztK/9c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=uz6ZVji5oYGOCOeKoJI4Xr4P+Y80SzT68+l3tKgCeMvVpQcUtHzREyds1/wsjN+Fj
         XRmUU1WnIiKey9oApnaQ4CxtRoqW2FfwqKgtm2bsPdnRpeJn8Xa4ia7QyRY6PLktYg
         IqcJCtbrFYJcRI7F1By51W982aKKz9RCFC1ahxZ0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20190307113623epcas5p483f6811e22e0dc8e7fe08c80c8f31476~JqhvXPH9F0758607586epcas5p4D;
        Thu,  7 Mar 2019 11:36:23 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.26.04136.732018C5; Thu,  7 Mar 2019 20:36:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20190307113608epcas5p1be102a5a4592055ab3c97df8a8339d98~JqhhkjLQ90264802648epcas5p18;
        Thu,  7 Mar 2019 11:36:08 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190307113608epsmtrp10fadf1e5717eb4e0512ca47ba2df140d~Jqhhjo1bA2434324343epsmtrp1F;
        Thu,  7 Mar 2019 11:36:08 +0000 (GMT)
X-AuditID: b6c32a4b-4afff70000001028-1d-5c810237f53e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.38.03601.822018C5; Thu,  7 Mar 2019 20:36:08 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190307113607epsmtip17441ee87a381740dfd267b9ec9159752~JqhgW8e_21183011830epsmtip1a;
        Thu,  7 Mar 2019 11:36:06 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] smack: removal of global rule list
Date:   Thu,  7 Mar 2019 16:55:24 +0530
Message-Id: <1551957924-25113-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCKsWRmVeSWpSXmKPExsWy7bCmhq45U2OMwdOTLBYXd6da3Nv2i83i
        8q45bBYfeh6xWdx7s5XJYt3t04wObB59W1Yxehzdv4jN4/MmuQDmqBybjNTElNQihdS85PyU
        zLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKC1SgpliTmlQKGAxOJiJX07m6L8
        0pJUhYz84hJbpdSClJwCQ6MCveLE3OLSvHS95PxcK0MDAyNToMqEnIxv0y8xFsxTr/iwr5up
        gfG1fBcjJ4eEgInEnkf/WboYuTiEBHYzSpzfd4kNwvnEKDHhyBp2COcbo8SMJx/YYVrO/PrB
        CpHYyyixfMMWRgjnC6PEs9/NTCBVbALaEr3z7oLZIgKJEh+e7ADrZhaIlPi1/TcbiC0sYC7x
        9/lSRhCbRUBVYuLpLhYQm1fAXWLXlWNsENvkJE4emwy2TULgJavEir+PWSESLhJnmhcwQdjC
        Eq+Ob4E6T0riZX8bO0RDN6PE0w9nGCGcKYwSC59PYIaospd4cOMoUBUH0EmaEut36UOEZSWm
        nlrHBHEpn0Tv7ydQC3gldsyDsVUlpk7qhlomLXH4xhkWCNtDYtuPc2DjhQRiJfoXf2WewCg7
        C2HDAkbGVYySqQXFuempxaYFxnmp5chxtYkRnKK0vHcwbjrnc4hRgINRiYc34nR9jBBrYllx
        Ze4hRgkOZiUR3pOvG2KEeFMSK6tSi/Lji0pzUosPMZoCg3Ais5Rocj4wfeaVxBuaGpmZGVga
        mBpbmBkqifPOlZ0bLSSQnliSmp2aWpBaBNPHxMEp1cDIIxeWGcl9u31h2iV5vaspx9qmFa/+
        +dHHavvvF8UfD/Su3HZ2tn5t4K1XWdd53y94e37d7vgsx9WrTbdvNS0KFd7d8dw1ROXuPaVH
        Z3oSb/ed23tzH/fOlQbVTKrC4oXHhU3PqYj6ezPs2JPRaieuNS3QcZ7f2S6tS2zrFJrX1uj8
        nl+sXjpdiaU4I9FQi7moOBEA4Seqy2cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDJMWRmVeSWpSXmKPExsWy7bCSnK4GU2OMwf4OPouLu1Mt7m37xWZx
        edccNosPPY/YLO692cpkse72aUYHNo++LasYPY7uX8Tm8XmTXABzFJdNSmpOZllqkb5dAlfG
        t+mXGAvmqVd82NfN1MD4Wr6LkZNDQsBE4syvH6xdjFwcQgK7GSUefVrNBpGQlljS+YYdwhaW
        WPnvOTtE0SdGia8/T4IVsQloS/TOu8sEYosIJEvsbp7OCGIzC0RLTHvWxQJiCwuYS/x9vhQs
        ziKgKjHxNEScV8BdYteVY1DL5CROHpvMOoGRZwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8
        dL3k/NxNjOAw0dLawXjiRPwhRgEORiUe3ojT9TFCrIllxZW5hxglOJiVRHhPvm6IEeJNSays
        Si3Kjy8qzUktPsQozcGiJM4rn38sUkggPbEkNTs1tSC1CCbLxMEp1cCo/fNAqX2mw+2d6b5M
        rgorw341taxX3OM7wef8xV089+98qux+X+4XsKTLqLjqnHr7zxmafwJWnRUuXpvurjHxZd/r
        jXe+mc19+DHS4OMspklzzVe3zGf5l1y0ZeKClfs/1cmFvC0Kq2/o1P995cm6DlbHfQvmTLiY
        JFGu6R123aH5wYEX+QfclViKMxINtZiLihMBfq/naQ8CAAA=
X-CMS-MailID: 20190307113608epcas5p1be102a5a4592055ab3c97df8a8339d98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190307113608epcas5p1be102a5a4592055ab3c97df8a8339d98
References: <CGME20190307113608epcas5p1be102a5a4592055ab3c97df8a8339d98@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, global rule list has been removed. Now all
smack rules will be read using "smack_known_list". This list contains
all the smack labels and internally each smack label structure
maintains the list of smack rules corresponding to that smack label.
So there is no need to maintain extra list.

1) Small Memory Optimization
For eg. if there are 20000 rules, then it will save 625KB(20000*32),
which is critical for small embedded systems.
2) Reducing the time taken in writing rules on load/load2 interface
3) Since global rule list is just used to read the rules, so there
will be no performance impact on system

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 security/smack/smackfs.c | 53 ++++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index f6482e5..2a8a1f5 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -67,7 +67,6 @@ enum smk_inos {
 /*
  * List locks
  */
-static DEFINE_MUTEX(smack_master_list_lock);
 static DEFINE_MUTEX(smack_cipso_lock);
 static DEFINE_MUTEX(smack_ambient_lock);
 static DEFINE_MUTEX(smk_net4addr_lock);
@@ -134,15 +133,7 @@ enum smk_inos {
 
 /*
  * Rule lists are maintained for each label.
- * This master list is just for reading /smack/load and /smack/load2.
  */
-struct smack_master_list {
-	struct list_head	list;
-	struct smack_rule	*smk_rule;
-};
-
-static LIST_HEAD(smack_rule_list);
-
 struct smack_parsed_rule {
 	struct smack_known	*smk_subject;
 	struct smack_known	*smk_object;
@@ -211,7 +202,6 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
  * @srp: the rule to add or replace
  * @rule_list: the list of rules
  * @rule_lock: the rule list lock
- * @global: if non-zero, indicates a global rule
  *
  * Looks through the current subject/object/access list for
  * the subject/object pair and replaces the access that was
@@ -223,10 +213,9 @@ static void smk_netlabel_audit_set(struct netlbl_audit *nap)
  */
 static int smk_set_access(struct smack_parsed_rule *srp,
 				struct list_head *rule_list,
-				struct mutex *rule_lock, int global)
+				struct mutex *rule_lock)
 {
 	struct smack_rule *sp;
-	struct smack_master_list *smlp;
 	int found = 0;
 	int rc = 0;
 
@@ -258,22 +247,6 @@ static int smk_set_access(struct smack_parsed_rule *srp,
 		sp->smk_access = srp->smk_access1 & ~srp->smk_access2;
 
 		list_add_rcu(&sp->list, rule_list);
-		/*
-		 * If this is a global as opposed to self and a new rule
-		 * it needs to get added for reporting.
-		 */
-		if (global) {
-			mutex_unlock(rule_lock);
-			smlp = kzalloc(sizeof(*smlp), GFP_KERNEL);
-			if (smlp != NULL) {
-				smlp->smk_rule = sp;
-				mutex_lock(&smack_master_list_lock);
-				list_add_rcu(&smlp->list, &smack_rule_list);
-				mutex_unlock(&smack_master_list_lock);
-			} else
-				rc = -ENOMEM;
-			return rc;
-		}
 	}
 
 out:
@@ -540,9 +513,9 @@ static ssize_t smk_write_rules_list(struct file *file, const char __user *buf,
 
 		if (rule_list == NULL)
 			rc = smk_set_access(&rule, &rule.smk_subject->smk_rules,
-				&rule.smk_subject->smk_rules_lock, 1);
+				&rule.smk_subject->smk_rules_lock);
 		else
-			rc = smk_set_access(&rule, rule_list, rule_lock, 0);
+			rc = smk_set_access(&rule, rule_list, rule_lock);
 
 		if (rc)
 			goto out;
@@ -636,21 +609,23 @@ static void smk_rule_show(struct seq_file *s, struct smack_rule *srp, int max)
 
 static void *load2_seq_start(struct seq_file *s, loff_t *pos)
 {
-	return smk_seq_start(s, pos, &smack_rule_list);
+	return smk_seq_start(s, pos, &smack_known_list);
 }
 
 static void *load2_seq_next(struct seq_file *s, void *v, loff_t *pos)
 {
-	return smk_seq_next(s, v, pos, &smack_rule_list);
+	return smk_seq_next(s, v, pos, &smack_known_list);
 }
 
 static int load_seq_show(struct seq_file *s, void *v)
 {
 	struct list_head *list = v;
-	struct smack_master_list *smlp =
-		list_entry_rcu(list, struct smack_master_list, list);
+	struct smack_rule *srp;
+	struct smack_known *skp =
+		list_entry_rcu(list, struct smack_known, list);
 
-	smk_rule_show(s, smlp->smk_rule, SMK_LABELLEN);
+	list_for_each_entry_rcu(srp, &skp->smk_rules, list)
+		smk_rule_show(s, srp, SMK_LABELLEN);
 
 	return 0;
 }
@@ -2352,10 +2327,12 @@ static ssize_t smk_write_access(struct file *file, const char __user *buf,
 static int load2_seq_show(struct seq_file *s, void *v)
 {
 	struct list_head *list = v;
-	struct smack_master_list *smlp =
-		list_entry_rcu(list, struct smack_master_list, list);
+	struct smack_rule *srp;
+	struct smack_known *skp =
+		list_entry_rcu(list, struct smack_known, list);
 
-	smk_rule_show(s, smlp->smk_rule, SMK_LONGLABEL);
+	list_for_each_entry_rcu(srp, &skp->smk_rules, list)
+		smk_rule_show(s, srp, SMK_LONGLABEL);
 
 	return 0;
 }
-- 
1.9.1

