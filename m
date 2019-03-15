Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E9DC10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E337218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfCOSiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42744 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbfCOSiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 92807300308F;
        Fri, 15 Mar 2019 18:38:00 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D3D625C21F;
        Fri, 15 Mar 2019 18:37:53 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v5 6/6] libaudit: add support to get the task audit container identifier
Date:   Fri, 15 Mar 2019 14:37:07 -0400
Message-Id: <1552675027-11635-7-git-send-email-rgb@redhat.com>
In-Reply-To: <1552675027-11635-1-git-send-email-rgb@redhat.com>
References: <1552675027-11635-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Fri, 15 Mar 2019 18:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the audit_get_containerid() call analogous to audit_getloginuid()
and audit_get_session() calls to get our own audit container identifier.

This is intended as a debug patch, not to be upstreamed.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/Makefile.am             |  2 +-
 docs/audit_get_containerid.3 | 25 +++++++++++++++++++++++++
 lib/libaudit.c               | 29 +++++++++++++++++++++++++++++
 lib/libaudit.h               |  1 +
 4 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 docs/audit_get_containerid.3

diff --git a/docs/Makefile.am b/docs/Makefile.am
index 8fb030c6e5e4..209789bb2051 100644
--- a/docs/Makefile.am
+++ b/docs/Makefile.am
@@ -28,7 +28,7 @@ man_MANS = audit_add_rule_data.3 audit_add_watch.3 auditctl.8 auditd.8 \
 auditd.conf.5 auditd-plugins.5 \
 audit_delete_rule_data.3 audit_detect_machine.3 \
 audit_encode_nv_string.3 audit_getloginuid.3 \
-audit_get_reply.3 audit_get_session.3 \
+audit_get_reply.3 audit_get_session.3 audit_get_containerid.3 \
 audit_log_acct_message.3 audit_log_user_avc_message.3 \
 audit_log_user_command.3 audit_log_user_comm_message.3 \
 audit_log_user_message.3 audit_log_semanage_message.3 \
diff --git a/docs/audit_get_containerid.3 b/docs/audit_get_containerid.3
new file mode 100644
index 000000000000..7d11b9fa747b
--- /dev/null
+++ b/docs/audit_get_containerid.3
@@ -0,0 +1,25 @@
+.TH "AUDIT_GET_CONTAINERID" "3" "Feb 2018" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_get_containerid \- Get a program's container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+uin32_t audit_get_containerid(void);
+
+.SH DESCRIPTION
+This function returns the task's audit container identifier attribute.
+
+.SH "RETURN VALUE"
+
+This function returns the audit container identifier value if it was set. It will return a \-1 if the audit container identifier is unset. However, since uint64_t is an unsigned type, you will see the converted value instead of \-1.
+
+.SH "ERRORS"
+
+This function returns \-2 on failure. Additionally, in the event of a real error, errno would be set. The function can set errno based on failures of open, read, or strtoul.
+
+.SH "SEE ALSO"
+
+.BR audit_getloginuid (3).
+
+.SH AUTHOR
+Steve Grubb
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 5df5ddf85430..a1727f1a321a 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -931,6 +931,35 @@ uint32_t audit_get_session(void)
 		return ses;
 }
 
+/*
+ * This function will retrieve the audit container identifier or -2 if
+ * there is an error.
+ */
+uint64_t audit_get_containerid(void)
+{
+	uint64_t containerid;
+	int len, in;
+	char buf[32];
+
+	errno = 0;
+	in = open("/proc/self/audit_containerid", O_NOFOLLOW|O_RDONLY);
+	if (in < 0)
+		return -2;
+	do {
+		len = read(in, buf, sizeof(buf));
+	} while (len < 0 && errno == EINTR);
+	close(in);
+	if (len < 0 || len >= sizeof(buf))
+		return -2;
+	buf[len] = 0;
+	errno = 0;
+	containerid = strtoull(buf, 0, 10);
+	if (errno)
+		return -2;
+	else
+		return containerid;
+}
+
 int audit_rule_syscall_data(struct audit_rule_data *rule, int scall)
 {
 	int word = AUDIT_WORD(scall);
diff --git a/lib/libaudit.h b/lib/libaudit.h
index e7256a328c45..348b50b525be 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -575,6 +575,7 @@ extern int  audit_get_reply(int fd, struct audit_reply *rep, reply_t block,
 extern uid_t audit_getloginuid(void);
 extern int  audit_setloginuid(uid_t uid);
 extern uint32_t audit_get_session(void);
+extern uint64_t audit_get_containerid(void);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
 
-- 
1.8.3.1

