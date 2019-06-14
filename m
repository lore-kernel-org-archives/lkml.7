Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10501C31E49
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED4120850
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="kQ2GFJNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfFNAqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:46:54 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:38822 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725778AbfFNAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:46:53 -0400
Received: from pps.filterd (m0122333.ppops.net [127.0.0.1])
        by mx0a-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5E0gObF017019;
        Fri, 14 Jun 2019 01:46:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=QEm53Dc4Fmq5I94pF3I1VW9A99lM4x3o6RgZU3TFGhI=;
 b=kQ2GFJNivoCLSkgGXwxBemQXKp7vrVADmvaxFplAmIy3dEb5le+lC0WhhSjjZQdY9Dnj
 lh+ghXNJS2hgQs6Jv4nscw2zMios4rSrTx8FR1gPX0AjYvs7L+Vh/Kup+EYtXUN9qael
 dzNCKuE9PsNbaESToffDVdFaw0/csK5t+W8zf5VPSlT1fo/hLrC28OtZfa72oh9Fklmz
 GQct3kbP0SfZXrwxQMpAOwZBjP2YWv2Xh0s2xDSKND6ZWsoUk9VEZY6oEvOELHM+roZH
 zpoSzjRpxfx/1kMa11gBaINy4O2cG0DwTUTtqF5e8SXRiK0QxnvgjLkvAfZkq3jnoJMP eg== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by mx0a-00190b01.pphosted.com with ESMTP id 2t3mapjgh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jun 2019 01:46:19 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x5E0WhhZ003866;
        Thu, 13 Jun 2019 20:46:18 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.31])
        by prod-mail-ppoint2.akamai.com with ESMTP id 2t08bxh9km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 13 Jun 2019 20:46:13 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb6.msg.corp.akamai.com (172.27.123.65) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Thu, 13 Jun 2019 20:45:21 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Thu, 13 Jun 2019 17:45:21 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 5170C62BDF; Thu, 13 Jun 2019 20:45:21 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>,
        <linux-security-module@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Igor Lubashev <ilubashe@akamai.com>
Subject: [RFC PATCH 1/1] security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve
Date:   Thu, 13 Jun 2019 20:44:47 -0400
Message-ID: <1560473087-27754-2-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
References: <1560473087-27754-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906140003
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-13_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=909 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906140005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many kernel interfaces require real and/or effective root uid instead
of relying solely of capabilities. An executable that uses such
interfaces has to be set-uid-root or be executed by a thread with
effective root uid. Presently, fsuid and saved uid will reset to the
effective uid during execve. As a result, it is not possible to
execute a binary such that it has effective root uid but retains
fsuid/fsgid of the actual user. Retaining fsuid/fsgid of the actual
user could be required if the executable needs to access the
filesystem. It may also be desired from the security perspective of
delegating the minimal set of privileges.

Setting SECURE_KEEP_FSUID bit ensures that the current fsuid/fsgiud is
retained by execve.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 include/uapi/linux/securebits.h | 10 +++++++++-
 security/commoncap.c            |  9 +++++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..6c20b2287d6f 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,10 +52,18 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/* When set, execve does not reset fsuid/fsgid to euid/egid */
+#define SECURE_KEEP_FSUID		8
+#define SECURE_KEEP_FSUID_LOCKED	9  /* make bit-8 immutable */
+
+#define SECBIT_KEEP_FSUID	 (issecure_mask(SECURE_KEEP_FSUID))
+#define SECBIT_KEEP_FSUID_LOCKED (issecure_mask(SECURE_KEEP_FSUID_LOCKED))
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
+				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
+				 issecure_mask(SECURE_KEEP_FSUID))
 #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
 
 #endif /* _UAPI_LINUX_SECUREBITS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index c0b9664ee49e..e4de823a1d4e 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -847,8 +847,13 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
 						   old->cap_permitted);
 	}
 
-	new->suid = new->fsuid = new->euid;
-	new->sgid = new->fsgid = new->egid;
+	new->suid = new->euid;
+	new->sgid = new->egid;
+
+	if (!issecure(SECURE_KEEP_FSUID)) {
+		new->fsuid = new->euid;
+		new->fsgid = new->egid;
+	}
 
 	/* File caps or setid cancels ambient. */
 	if (has_fcap || is_setid)
-- 
2.7.4

