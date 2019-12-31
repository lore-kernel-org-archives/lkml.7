Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A0C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B022053B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 20:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQakxEBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLaUAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 15:00:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60974 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbfLaUAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 15:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=exbt1MWttbxq7Ry/5OLpfQOuFKOTHnX2x3HFTYvpcII=;
        b=DQakxEByxTfdGCpWmRjjmNDQJPh4Usg0ZlDcL6jvFMkXebSJCO5QuVckRTD7UalLxbzQdm
        kyueBx8qMToDfhLQSVBiQeODc1WpC0Au4chca9ZYmxkojarW2Ukh2GXIohQQf8IlQe8J0C
        agqHLvC4xXKx4P+arjHw8VFU+8/ty78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-2DWvQk4yNLm2cZ08B99Ucw-1; Tue, 31 Dec 2019 14:59:58 -0500
X-MC-Unique: 2DWvQk4yNLm2cZ08B99Ucw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5C4800D48;
        Tue, 31 Dec 2019 19:59:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E93E060BEC;
        Tue, 31 Dec 2019 19:59:54 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 14/14] libaudit: add support to get and set capcontid on a task
Date:   Tue, 31 Dec 2019 14:58:21 -0500
Message-Id: <1577822301-19760-15-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to be able to set a capability to allow a task to set the
audit container identifier of descendants.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID

Add the audit_get_capcontid() and audit_set_capcontid() calls analogous
to CAP_AUDIT_CONTROL for descendant user namespaces.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/Makefile.am           |  1 +
 docs/audit_get_capcontid.3 | 25 ++++++++++++++++
 docs/audit_set_capcontid.3 | 24 +++++++++++++++
 lib/libaudit.c             | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 lib/libaudit.h             |  4 +++
 lib/msg_typetab.h          |  1 +
 6 files changed, 129 insertions(+)
 create mode 100644 docs/audit_get_capcontid.3
 create mode 100644 docs/audit_set_capcontid.3

diff --git a/docs/Makefile.am b/docs/Makefile.am
index 8ba92dbd74ab..c517046fd183 100644
--- a/docs/Makefile.am
+++ b/docs/Makefile.am
@@ -29,6 +29,7 @@ auditd.conf.5 auditd-plugins.5 \
 audit_delete_rule_data.3 audit_detect_machine.3 \
 audit_encode_nv_string.3 audit_getloginuid.3 \
 audit_get_reply.3 audit_get_session.3 audit_get_containerid.3 \
+audit_get_capcontid.3 audit_set_capcontid.3 \
 audit_log_acct_message.3 audit_log_user_avc_message.3 \
 audit_log_user_command.3 audit_log_user_comm_message.3 \
 audit_log_user_message.3 audit_log_semanage_message.3 \
diff --git a/docs/audit_get_capcontid.3 b/docs/audit_get_capcontid.3
new file mode 100644
index 000000000000..652a4960a020
--- /dev/null
+++ b/docs/audit_get_capcontid.3
@@ -0,0 +1,25 @@
+.TH "AUDIT_GET_CAPCONTID" "26" "Aug 2019" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_get_capcontid \- Get a program's capability container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+int audit_get_capcontid(pid_t pid);
+
+.SH DESCRIPTION
+This function returns the pid task's audit capability container identifier attribute.
+
+.SH "RETURN VALUE"
+
+This function returns the audit capability container identifier value if it is implemented. It will return a \-1 if the audit capability container identifier is unavailable.
+
+.SH "ERRORS"
+
+This function returns \-2 on failure. Additionally, in the event of a real error, errno would be set. The function can set errno based on failures of open, read, or strtoull.
+
+.SH "SEE ALSO"
+
+.BR audit_set_capcontid (3).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/docs/audit_set_capcontid.3 b/docs/audit_set_capcontid.3
new file mode 100644
index 000000000000..70ac8c7a4e95
--- /dev/null
+++ b/docs/audit_set_capcontid.3
@@ -0,0 +1,24 @@
+.TH "AUDIT_SET_CAPCONTID" "26" "Aug 2019" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_set_capcontid \- Set a program's capability container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+int audit_set_capcontid(pid_t pid, uint32_t capcontid);
+
+.SH "DESCRIPTION"
+
+This function sets the pid task's attribute capability container id with the value of capcontid. The capcontid value may only be set by programs with the CAP_AUDIT_CONTROL capability in the initial user namespace or with capcontid. This normally means the root account or root in a container.
+.sp
+The capcontid value is part of the task structure and is inheritted by child processes within a user namespace. It is used to enable the capability to set container identifier of a child task in a descendent user namespace.  Container orchestrator/engines should set this value only on children it wishes to be able to set audit container identifiers.
+
+.SH "RETURN VALUE"
+
+This function returns 0 on success and non-zero otherwise.
+
+.SH "SEE ALSO"
+
+.BR audit_get_capcontid (3).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 37e0c35ada18..7e20d0c83823 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -1020,6 +1020,80 @@ uint32_t audit_get_session(void)
 }
 
 /*
+ * This function will retrieve the capability container identifier or -2 if
+ * there is an error.
+ */
+uint32_t audit_get_capcontid(pid_t pid)
+{
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
+		return -2;
+	} else {
+		int capcontid;
+		int len, in;
+		char buf[16], fnbuf[48];
+
+		errno = 0;
+		snprintf(fnbuf, sizeof(fnbuf), "/proc/%d/audit_capcontainerid", pid);
+		in = open(fnbuf, O_NOFOLLOW|O_RDONLY);
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
+		capcontid = strtol(buf, 0, 10);
+		if (errno)
+			return -2;
+		else
+			return capcontid;
+	}
+}
+
+/*
+ * This function returns 0 on success and 1 on failure
+ */
+int audit_set_capcontid(pid_t pid, uint32_t capcontid)
+{
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
+		return -2;
+	} else {
+		char capcontidbuf[16], fnbuf[48];
+		int o, count, rc = 0;
+
+		errno = 0;
+		count = snprintf(capcontidbuf, sizeof(capcontidbuf), "%u", capcontid);
+		snprintf(fnbuf, sizeof(fnbuf), "/proc/%d/audit_capcontainerid", pid);
+		o = open(fnbuf, O_NOFOLLOW|O_WRONLY|O_TRUNC);
+		if (o >= 0) {
+			int block, offset = 0;
+
+			while (count > 0) {
+				block = write(o, &capcontidbuf[offset], (unsigned)count);
+
+				if (block < 0) {
+					if (errno == EINTR)
+						continue;
+					audit_msg(LOG_ERR, "Error writing capcontid");
+					close(o);
+					return 1;
+				}
+				offset += block;
+				count -= block;
+			}
+			close(o);
+		} else {
+			audit_msg(LOG_ERR, "Error opening %s", fnbuf);
+			rc = 1;
+		}
+		return rc;
+	}
+}
+
+/*
  * This function will retrieve the audit container identifier or -2 if
  * there is an error.
  */
diff --git a/lib/libaudit.h b/lib/libaudit.h
index c97ee8b957d3..620fbbebbd45 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -255,6 +255,10 @@ extern "C" {
 #define AUDIT_SIGNAL_INFO2	1021    /* auditd signal sender info */
 #endif
 
+#ifndef AUDIT_SET_CAPCONTID
+#define AUDIT_SET_CAPCONTID	1022    /* set capcontid of specified pid */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 6502cdfa96d4..5cfe45117c7a 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -45,6 +45,7 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_SET_FEATURE,                "SET_FEATURE"                   )
 //_S(AUDIT_GET_FEATURE,                "GET_FEATURE"                   )
 //_S(AUDIT_SIGNAL_INFO2,               "SIGNAL_INFO2"                  )
+_S(AUDIT_SET_CAPCONTID,              "SET_CAPCONTID"                 )
 _S(AUDIT_CONTAINER_OP,               "CONTAINER_OP"                  )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
-- 
1.8.3.1

