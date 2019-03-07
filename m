Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF17C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAD22085A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o5ELAHzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfCGLUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:20:53 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20601 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:20:52 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190307112047epoutp044e2be62048c89fdadefa1459ac3ef44f~JqUIAGcxl1631816318epoutp04N
        for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2019 11:20:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190307112047epoutp044e2be62048c89fdadefa1459ac3ef44f~JqUIAGcxl1631816318epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1551957647;
        bh=KVhH1l9CGo/3tXGzL/9KY/4rmMejZB5ce/CWD+RBhOQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=o5ELAHzXrDbjnbifbWh8MIaGQVC3OpBi6nY3IXmD0/byML7hbRU8ILBylFg9B5U5H
         YYJaQ/bqdVU1+0puZe2UOwrN04qRMEXzlNVP35KngJp0sVGO4ujY/SdreNm5tiU0K6
         pSjFYX4SGoTV1gbYx1P0xXjixf9FG4Gd39xg5P/o=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.194]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190307112044epcas5p391062bd1ae338323d3b084f1afe099d2~JqUFg-pqN0473304733epcas5p3Q;
        Thu,  7 Mar 2019 11:20:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.B3.04136.C8EF08C5; Thu,  7 Mar 2019 20:20:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190307093333epcas5p25cc50478585532ea2f7c4a1275b04279~Jo2fzJ8Wq2554325543epcas5p27;
        Thu,  7 Mar 2019 09:33:33 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190307093333epsmtrp21f9e6309b56f127149337362729705a9~Jo2fyILZx1332713327epsmtrp2R;
        Thu,  7 Mar 2019 09:33:33 +0000 (GMT)
X-AuditID: b6c32a4b-4afff70000001028-28-5c80fe8cac53
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.83.03601.D65E08C5; Thu,  7 Mar 2019 18:33:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190307093332epsmtip2e98a6ac077f3acd72465acde167860f1~Jo2es1WgP2367923679epsmtip2p;
        Thu,  7 Mar 2019 09:33:32 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pankaj.m@samsung.com, a.sahrawat@samsung.com,
        Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] Smack :- In this patch, global rule list has been
 removed. Now all smack rules will be read using "smack_known_list". This
 list contains all the smack labels and internally each smack label structure
 maintains the list of smack rules corresponding to that smack label. So
 there is no need to maintain extra list.
Date:   Thu,  7 Mar 2019 14:53:23 +0530
Message-Id: <1551950603-15570-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmlm7Pv4YYg2c/+C0u7k61uLftF5vF
        5V1z2Cw+9Dxis7j3ZiuTxbrbpxkd2Dz6tqxi9Di6fxGbx+dNcgHMUTk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFhkYFesWJucWleel6yfm5VoYGBkamQJUJORk7vwUXPFep6H21mLWB
        8Z1sFyMnh4SAicS+5gZGEFtIYDejxJxNHl2MXED2J0aJ688PMUE43xglfv26wA7Tsfv7ZnaI
        xF5Gib/TjrJCOF8YJWbtWssCUsUmoC3RO+8uE4gtIpAo8eHJDrBuZoFIiV/bf7OB2MICV5kk
        5nQKdDFycLAIqEp83JsAEuYVcJdoXPaeGWKZnMTJY5PB5ksIfGSVaDr0FirhIjH3yDRWCFtY
        4tXxLVDXSUl8freXDaKhm1Hi6YczjBDOFEaJhc8nQHXbSzy4cZQdZDOzgKbE+l36EGFZiamn
        1jFBHMon0fv7CRNEnFdixzwYW1Vi6qRuqGXSEodvnGGBsD0kJrz5zAYJyFiJA/tmME5glJ2F
        sGEBI+MqRsnUguLc9NRi0wLjvNRy5IjaxAhOTlreOxg3nfM5xCjAwajEwxtxuj5GiDWxrLgy
        9xCjBAezkgjvydcNMUK8KYmVValF+fFFpTmpxYcYTYEhOJFZSjQ5H5g480riDU2NzMwMLA1M
        jS3MDJXEeefKzo0WEkhPLEnNTk0tSC2C6WPi4JRqYEwNufX8dnrhxOkHAs7nu8RxaFSauk60
        DVFqmHBSuGDiKy+R5LkZeWrvFp8T3n5sC4Np5taDH8W5Dd5qsJamBancuhvWL6xw+8TX+j3W
        v7ZNspnRvVHfJ+Cy9NHuG/ViWq28ghvr7/w2uhanFXTljXN0xDWhlWJ7FF+Kv2A3nBBzfoYC
        L+OF2UosxRmJhlrMRcWJAEIQ3sVkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNJMWRmVeSWpSXmKPExsWy7bCSvG7u04YYg4dzJS0u7k61uLftF5vF
        5V1z2Cw+9Dxis7j3ZiuTxbrbpxkd2Dz6tqxi9Di6fxGbx+dNcgHMUVw2Kak5mWWpRfp2CVwZ
        O78FFzxXqeh9tZi1gfGdbBcjJ4eEgInE7u+b2bsYuTiEBHYzSnw53cUGkZCWWNL5hh3CFpZY
        +e85VNEnRom5rzpZQRJsAtoSvfPuMoHYIgLJErubpzOC2MwC0RLTnnWxgDQIC5xlkmhceIu5
        i5GDg0VAVeLj3gSQGl4Bd4nGZe+ZIRbISZw8Npl1AiPPAkaGVYySqQXFuem5xYYFRnmp5XrF
        ibnFpXnpesn5uZsYwUGipbWD8cSJ+EOMAhyMSjy8EafrY4RYE8uKK3MPMUpwMCuJ8DY+aogR
        4k1JrKxKLcqPLyrNSS0+xCjNwaIkziuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwLjmSqo9u6TU
        lpWy9exTJcSqan4/WPtEyD9iYZqrUImd83aLDeb9cSoz1t66eO5hHPvNrXFclwRM9z124t9z
        L+PM69XF81zXnbhcwLhg4oek26lnhSu3K/XI/lyXreJjISLnvixM4jLH8YSCHGlO3dK9as8c
        VuqseLWtynrHii8/7erVbyks+6DEUpyRaKjFXFScCAANWrbjDgIAAA==
X-CMS-MailID: 20190307093333epcas5p25cc50478585532ea2f7c4a1275b04279
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190307093333epcas5p25cc50478585532ea2f7c4a1275b04279
References: <CGME20190307093333epcas5p25cc50478585532ea2f7c4a1275b04279@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

