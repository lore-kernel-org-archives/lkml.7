Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E205C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F062080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="DLIRdcZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbfCZAKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:10:21 -0400
Received: from mx0b-00190b01.pphosted.com ([67.231.157.127]:57952 "EHLO
        mx0b-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfCZAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:10:20 -0400
X-Greylist: delayed 3707 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Mar 2019 20:10:19 EDT
Received: from pps.filterd (m0122330.ppops.net [127.0.0.1])
        by mx0b-00190b01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PN1txP014442;
        Mon, 25 Mar 2019 23:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=0S5EZ2CZDM+bvFFmyhyPue+BljJixs0+paTHWPwXJQc=;
 b=DLIRdcZs6CER7q1OhpuCEAEcay+JtpAJNuj9Yl4pQhOu60gLZLvZ+k+z8rlnk2zVT0P5
 DSFWOzsCNxYgGH/aIGpgBLr6T0CTu+17TQd62ippp1atWSv2pwNqnQbcGLW5mjDEnh8H
 eDu/AZ4ZCo1MwKW7LavP/en1JjX/g4HAqxBJXK4x5QJTS89xLW+Z8cy/2TtkfcRQpGzg
 Qqt8ZN9Z+k0O5DmAsHWLXNjSloXn7HqflpfJCIE51knRwhKVgBTUP9Lhmh7Ps76nOa7X
 Tcmk/RAcO2ythjiBmNEmozOpZvlSJLXa4/mCx1UmQCdSRMaXGHAGpAtv84Z827FDeKVu Fw== 
Received: from prod-mail-ppoint4 (a96-6-114-87.deploy.static.akamaitechnologies.com [96.6.114.87] (may be forged))
        by mx0b-00190b01.pphosted.com with ESMTP id 2rf3r98s5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 23:08:23 +0000
Received: from pps.filterd (prod-mail-ppoint4.akamai.com [127.0.0.1])
        by prod-mail-ppoint4.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x2PN2Ow4005728;
        Mon, 25 Mar 2019 19:08:22 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.57])
        by prod-mail-ppoint4.akamai.com with ESMTP id 2rdg4v4b59-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 19:08:22 -0400
Received: from usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) by
 usma1ex-dag1mb3.msg.corp.akamai.com (172.27.123.103) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Mon, 25 Mar 2019 19:08:14 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.123) by
 usma1ex-cas4.msg.corp.akamai.com (172.27.123.57) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Mon, 25 Mar 2019 16:08:15 -0700
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id 369C262BE9; Mon, 25 Mar 2019 19:08:14 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     Serge Hallyn <serge@hallyn.com>, James Morris <jmorris@namei.org>,
        Igor Lubashev <ilubashe@akamai.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CAPABILITIES" <linux-security-module@vger.kernel.org>
Subject: [PATCH 1/1] RFC: security: add SECURE_KEEP_FSUID to preserve fsuid/fsgid across execve
Date:   Mon, 25 Mar 2019 19:07:58 -0400
Message-ID: <1553555278-19153-2-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553555278-19153-1-git-send-email-ilubashe@akamai.com>
References: <1553555278-19153-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=885
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1903250161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=919 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250161
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
index d6d9887..6c20b22 100644
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
index c477fb6..490a7b4 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -852,8 +852,13 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
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

