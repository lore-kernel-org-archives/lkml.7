Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613ABC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C7D21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbfISB3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:29:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387395AbfISB3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:29:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDBB330821BF;
        Thu, 19 Sep 2019 01:29:16 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6EC95D9CC;
        Thu, 19 Sep 2019 01:29:13 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v7 11/12] loginuid/sessionid: switch from /proc to netlink
Date:   Wed, 18 Sep 2019 21:27:51 -0400
Message-Id: <1568856472-10173-12-git-send-email-rgb@redhat.com>
In-Reply-To: <1568856472-10173-1-git-send-email-rgb@redhat.com>
References: <1568856472-10173-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 19 Sep 2019 01:29:17 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to get and set the login uid and to get the session
id using an audit netlink message using message types AUDIT_GET_LOGINUID
1024, AUDIT_SET_LOGINUID 1025 and AUDIT_GET_SESSIONID 1026 in addition
to using the proc filesystem.

This switches over the audit_setloginuid(), audit_getloginuid() and
audit_get_session() functions to use the new audit netlink message
method if it exists rather than the /proc method.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.c    | 176 ++++++++++++++++++++++++++++++++++--------------------
 lib/libaudit.h    |  12 ++++
 lib/msg_typetab.h |   3 +
 3 files changed, 127 insertions(+), 64 deletions(-)

diff --git a/lib/libaudit.c b/lib/libaudit.c
index fdba6301e7f0..62e1a2a64ee5 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -890,27 +890,42 @@ int audit_make_equivalent(int fd, const char *mount_point,
  */
 uid_t audit_getloginuid(void)
 {
-	uid_t uid;
-	int len, in;
-	char buf[16];
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
+		uid_t uid;
+		int len, in;
+		char buf[16];
+
+		errno = 0;
+		in = open("/proc/self/loginuid", O_NOFOLLOW|O_RDONLY);
+		if (in < 0)
+			return -1;
+		do {
+			len = read(in, buf, sizeof(buf));
+		} while (len < 0 && errno == EINTR);
+		close(in);
+		if (len < 0 || len >= sizeof(buf))
+			return -1;
+		buf[len] = 0;
+		errno = 0;
+		uid = strtol(buf, 0, 10);
+		if (errno)
+			return -1;
+		else
+			return uid;
+	} else {
+		int rc;
+		int seq;
+                int fd = audit_open();
 
-	errno = 0;
-	in = open("/proc/self/loginuid", O_NOFOLLOW|O_RDONLY);
-	if (in < 0)
-		return -1;
-	do {
-		len = read(in, buf, sizeof(buf));
-	} while (len < 0 && errno == EINTR);
-	close(in);
-	if (len < 0 || len >= sizeof(buf))
-		return -1;
-	buf[len] = 0;
-	errno = 0;
-	uid = strtol(buf, 0, 10);
-	if (errno)
-		return -1;
-	else
-		return uid;
+		if (fd < 0) {
+                        audit_msg(audit_priority(errno), "Error openning get loginuid req (%s)", strerror(-rc));
+			return -2;
+		}
+		rc = __audit_send(fd, AUDIT_GET_LOGINUID, NULL, 0, &seq);
+		if (rc < 0)
+			audit_msg(audit_priority(errno), "Error sending get loginuid request (%s)", strerror(-rc));
+		return rc;
+	}
 }
 
 /*
@@ -918,34 +933,52 @@ uid_t audit_getloginuid(void)
  */
 int audit_setloginuid(uid_t uid)
 {
-	char loginuid[16];
-	int o, count, rc = 0;
-
-	errno = 0;
-	count = snprintf(loginuid, sizeof(loginuid), "%u", uid);
-	o = open("/proc/self/loginuid", O_NOFOLLOW|O_WRONLY|O_TRUNC);
-	if (o >= 0) {
-		int block, offset = 0;
-
-		while (count > 0) {
-			block = write(o, &loginuid[offset], (unsigned)count);
-
-			if (block < 0) {
-				if (errno == EINTR)
-					continue;
-				audit_msg(LOG_ERR, "Error writing loginuid");
-				close(o);
-				return 1;
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
+		char loginuid[16];
+		int o, count, rc = 0;
+	
+		errno = 0;
+		count = snprintf(loginuid, sizeof(loginuid), "%u", uid);
+		o = open("/proc/self/loginuid", O_NOFOLLOW|O_WRONLY|O_TRUNC);
+		if (o >= 0) {
+			int block, offset = 0;
+	
+			while (count > 0) {
+				block = write(o, &loginuid[offset], (unsigned)count);
+	
+				if (block < 0) {
+					if (errno == EINTR)
+						continue;
+					audit_msg(LOG_ERR, "Error writing loginuid");
+					close(o);
+					return 1;
+				}
+				offset += block;
+				count -= block;
 			}
-			offset += block;
-			count -= block;
+			close(o);
+		} else {
+			audit_msg(LOG_ERR, "Error opening /proc/self/loginuid");
+			rc = 1;
 		}
-		close(o);
+		return rc;
 	} else {
-		audit_msg(LOG_ERR, "Error opening /proc/self/loginuid");
-		rc = 1;
+		int rc;
+		int seq;
+                int fd = audit_open();
+		struct audit_loginuid_status { uid_t uid; } ls = { uid };
+
+		if (fd < 0) {
+                        audit_msg(audit_priority(errno), "Error openning set loginuid req (%s)", strerror(-rc));
+			return 1;
+		}
+		rc = audit_send(fd, AUDIT_SET_LOGINUID, &ls, sizeof(ls));
+		if (rc < 0) {
+			audit_msg(audit_priority(errno), "Error sending set loginuid request (%s)", strerror(-rc));
+			return 1;
+		}
+		return 0;
 	}
-	return rc;
 }
 
 /*
@@ -954,27 +987,42 @@ int audit_setloginuid(uid_t uid)
  */
 uint32_t audit_get_session(void)
 {
-	uint32_t ses;
-	int len, in;
-	char buf[16];
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
+		uint32_t ses;
+		int len, in;
+		char buf[16];
 
-	errno = 0;
-	in = open("/proc/self/sessionid", O_NOFOLLOW|O_RDONLY);
-	if (in < 0)
-		return -2;
-	do {
-		len = read(in, buf, sizeof(buf));
-	} while (len < 0 && errno == EINTR);
-	close(in);
-	if (len < 0 || len >= sizeof(buf))
-		return -2;
-	buf[len] = 0;
-	errno = 0;
-	ses = strtoul(buf, 0, 10);
-	if (errno)
-		return -2;
-	else
-		return ses;
+		errno = 0;
+		in = open("/proc/self/sessionid", O_NOFOLLOW|O_RDONLY);
+		if (in < 0)
+			return -2;
+		do {
+			len = read(in, buf, sizeof(buf));
+		} while (len < 0 && errno == EINTR);
+		close(in);
+		if (len < 0 || len >= sizeof(buf))
+			return -2;
+		buf[len] = 0;
+		errno = 0;
+		ses = strtoul(buf, 0, 10);
+		if (errno)
+			return -2;
+		else
+			return ses;
+	} else {
+		int rc;
+		int seq;
+                int fd = audit_open();
+
+		if (fd < 0) {
+                        audit_msg(audit_priority(errno), "Error openning set contid req (%s)", strerror(-rc));
+			return -2;
+		}
+		rc = __audit_send(fd, AUDIT_GET_SESSIONID, NULL, 0, &seq);
+		if (rc < 0)
+			audit_msg(audit_priority(errno), "Error sending get session request (%s)", strerror(-rc));
+		return rc;
+	}
 }
 
 /*
diff --git a/lib/libaudit.h b/lib/libaudit.h
index af58ef563987..717724e8fbbb 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -263,6 +263,18 @@ extern "C" {
 #define AUDIT_SET_CONTID	1023    /* set contid of specified pid */
 #endif
 
+#ifndef AUDIT_GET_LOGINUID
+#define AUDIT_GET_LOGINUID	1024    /* get current process loginuid */
+#endif
+
+#ifndef AUDIT_SET_LOGINUID
+#define AUDIT_SET_LOGINUID	1025    /* get current process loginuid */
+#endif
+
+#ifndef AUDIT_GET_SESSIONID
+#define AUDIT_GET_SESSIONID	1026    /* get current process sessionid */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index e37070cd82e2..9f2b137dc7f8 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -47,6 +47,9 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_SIGNAL_INFO2,               "SIGNAL_INFO2"                  )
 //_S(AUDIT_GET_CONTID,                 "GET_CONTID"                    )
 //_S(AUDIT_SET_CONTID,                 "SET_CONTID"                    )
+//_S(AUDIT_GET_LOGINUID,               "GET_LOGINUID"                  )
+//_S(AUDIT_SET_LOGINUID,               "SET_LOGINUID"                  )
+//_S(AUDIT_GET_SESSIONID,              "GET_SESSIONID"                 )
 _S(AUDIT_CONTAINER_OP,               "CONTAINER_OP"                  )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
-- 
1.8.3.1

