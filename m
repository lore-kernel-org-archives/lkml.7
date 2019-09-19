Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC67C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FEB21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbfISB3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:29:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387395AbfISB3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:29:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E329307D847;
        Thu, 19 Sep 2019 01:29:13 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8FB685D9CC;
        Thu, 19 Sep 2019 01:29:02 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v7 10/12] contid: switch from /proc to netlink
Date:   Wed, 18 Sep 2019 21:27:50 -0400
Message-Id: <1568856472-10173-11-git-send-email-rgb@redhat.com>
In-Reply-To: <1568856472-10173-1-git-send-email-rgb@redhat.com>
References: <1568856472-10173-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 19 Sep 2019 01:29:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to get and set the audit container identifier using an
audit netlink message using message types AUDIT_SET_CONTID 1023 and
AUDIT_GET_CONTID 1022 in addition to using the proc filesystem.  The
message format includes the data structure:

struct audit_contid_status {
	pid_t   pid;
	u64     id;
};

This switches over the audit_set_containerid() and
audit_get_containerid() to use this method if it exists.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/Makefile.am             |  2 +-
 docs/audit_get_containerid.3 |  6 +--
 docs/audit_set_containerid.3 | 24 +++++++++++
 lib/libaudit.c               | 96 +++++++++++++++++++++++++++++++++++---------
 lib/libaudit.h               | 19 ++++++++-
 lib/msg_typetab.h            |  2 +
 lib/netlink.c                |  6 +++
 7 files changed, 130 insertions(+), 25 deletions(-)
 create mode 100644 docs/audit_set_containerid.3

diff --git a/docs/Makefile.am b/docs/Makefile.am
index 209789bb2051..821182315806 100644
--- a/docs/Makefile.am
+++ b/docs/Makefile.am
@@ -28,7 +28,7 @@ man_MANS = audit_add_rule_data.3 audit_add_watch.3 auditctl.8 auditd.8 \
 auditd.conf.5 auditd-plugins.5 \
 audit_delete_rule_data.3 audit_detect_machine.3 \
 audit_encode_nv_string.3 audit_getloginuid.3 \
-audit_get_reply.3 audit_get_session.3 audit_get_containerid.3 \
+audit_get_reply.3 audit_get_session.3 audit_get_containerid.3 audit_set_containerid.3 \
 audit_log_acct_message.3 audit_log_user_avc_message.3 \
 audit_log_user_command.3 audit_log_user_comm_message.3 \
 audit_log_user_message.3 audit_log_semanage_message.3 \
diff --git a/docs/audit_get_containerid.3 b/docs/audit_get_containerid.3
index ef62a25db970..5f485c987993 100644
--- a/docs/audit_get_containerid.3
+++ b/docs/audit_get_containerid.3
@@ -4,10 +4,10 @@ audit_get_containerid \- Get a program's container id value
 .SH SYNOPSIS
 .B #include <libaudit.h>
 .sp
-uin64_t audit_get_containerid(void);
+uin64_t audit_get_containerid(pid_t pid);
 
 .SH DESCRIPTION
-This function returns the task's audit container identifier attribute.
+This function returns the pid task's audit container identifier attribute.
 
 .SH "RETURN VALUE"
 
@@ -19,7 +19,7 @@ This function returns \-2 on failure. Additionally, in the event of a real error
 
 .SH "SEE ALSO"
 
-.BR audit_getloginuid (3).
+.BR audit_set_containerid (3).
 
 .SH AUTHOR
 Richard Guy Briggs
diff --git a/docs/audit_set_containerid.3 b/docs/audit_set_containerid.3
new file mode 100644
index 000000000000..e4e884eea4a9
--- /dev/null
+++ b/docs/audit_set_containerid.3
@@ -0,0 +1,24 @@
+.TH "AUDIT_SET_CONTAINERID" "4" "Aug 2019" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_set_containerid \- Set a program's container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+int audit_set_containerid(pid_t pid, uin64_t contid);
+
+.SH "DESCRIPTION"
+
+This function sets the pid task's attribute audit_containerid with the value of contid. The audit_containerid value may only be set by programs with the CAP_AUDIT_CONTROL capability. This normally means the root account.
+.sp
+The audit_containerid value is part of the task structure and is inheritted by child processes. It is used to track in which container a task has been placed. All container orchestrator/engines should set this value right before launching a process after setting up its resources.
+
+.SH "RETURN VALUE"
+
+This function returns 0 on success and non-zero otherwise.
+
+.SH "SEE ALSO"
+
+.BR audit_get_containerid (3).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/lib/libaudit.c b/lib/libaudit.c
index c142a60c52a2..fdba6301e7f0 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -669,7 +669,7 @@ int audit_request_rules_list_data(int fd)
 int audit_request_signal_info(int fd)
 {
 	int rc;
-	if (audit_get_containerid() == (long long)-2)
+	if (audit_get_containerid(0) == (long long)-2)
 		rc = audit_send(fd, AUDIT_SIGNAL_INFO, NULL, 0);
 	else
 		rc = audit_send(fd, AUDIT_SIGNAL_INFO2, NULL, 0);
@@ -981,29 +981,85 @@ uint32_t audit_get_session(void)
  * This function will retrieve the audit container identifier or -2 if
  * there is an error.
  */
-uint64_t audit_get_containerid(void)
+uint64_t audit_get_containerid(pid_t pid)
 {
-	uint64_t containerid;
-	int len, in;
-	char buf[32];
-
-	errno = 0;
-	in = open("/proc/self/audit_containerid", O_NOFOLLOW|O_RDONLY);
-	if (in < 0)
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
 		return -2;
-	do {
-		len = read(in, buf, sizeof(buf));
-	} while (len < 0 && errno == EINTR);
-	close(in);
-	if (len < 0 || len >= sizeof(buf))
+	} else {
+                struct audit_reply rep;
+                int i;
+                int timeout = 40; /* tenths of seconds */
+                struct pollfd pfd[1];
+                int fd = audit_open();
+		struct audit_cont_status cs;
+                int rc;
+
+		if (fd < 0) {
+                        audit_msg(audit_priority(errno), "Error openning get contid req (%s)", strerror(-rc));
+			return -2;
+		}
+		cs.pid = pid;
+                rc = audit_send(fd, AUDIT_GET_CONTID, &cs, sizeof(cs));
+                if (rc < 0 && rc != -EINVAL) {
+			audit_close(fd);
+                        audit_msg(audit_priority(errno), "Error sending set contid req (%s)", strerror(-rc));
+                        return -2;
+                }
+                pfd[0].fd = fd;
+                pfd[0].events = POLLIN;
+
+                for (i = 0; i < timeout; i++) {
+                        do {
+                                rc = poll(pfd, 1, 100);
+                        } while (rc < 0 && errno == EINTR);
+                        rc = audit_get_reply(fd, &rep, GET_REPLY_NONBLOCKING,0); 
+                        if (rc > 0) {
+                                /* If we get done or error, break out */
+                                if (rep.type == NLMSG_DONE ||
+                                        rep.type == NLMSG_ERROR)
+                                        break;
+
+                                /* If its not get_contid, keep looping */
+                                if (rep.type != AUDIT_GET_CONTID)
+                                        continue;
+
+                                /* Found it... */
+				audit_close(fd);
+				if (rep.cont->pid == pid)
+                                	return rep.cont->id;
+				else
+					return -2;
+			}
+		}
+		audit_close(fd);
 		return -2;
-	buf[len] = 0;
-	errno = 0;
-	containerid = strtoull(buf, 0, 10);
-	if (errno)
+	}
+}
+
+/*
+ * This function returns 0 on success and 1 on failure
+ */
+int audit_set_containerid(pid_t pid, uint64_t contid)
+{
+        if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0) {
 		return -2;
-	else
-		return containerid;
+	} else {
+		int rc;
+		int seq;
+                int fd = audit_open();
+		struct audit_cont_status cs = { pid, contid };
+
+		if (fd < 0) {
+                        audit_msg(audit_priority(errno), "Error openning set audit_containerid req (%s)", strerror(-rc));
+			return 1;
+		}
+		rc = audit_send(fd, AUDIT_SET_CONTID, &cs, sizeof(cs));
+		if (rc < 0) {
+			audit_msg(audit_priority(errno), "Error sending set audit_containerid request (%s)", strerror(-rc));
+			return 1;
+		}
+		return 0;
+	}
 }
 
 int audit_rule_syscall_data(struct audit_rule_data *rule, int scall)
diff --git a/lib/libaudit.h b/lib/libaudit.h
index 29e61c876e4c..af58ef563987 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -255,6 +255,14 @@ extern "C" {
 #define AUDIT_SIGNAL_INFO2	1021    /* auditd signal sender info */
 #endif
 
+#ifndef AUDIT_GET_CONTID
+#define AUDIT_GET_CONTID	1022    /* get contid of specified pid */
+#endif
+
+#ifndef AUDIT_SET_CONTID
+#define AUDIT_SET_CONTID	1023    /* set contid of specified pid */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
@@ -512,6 +520,11 @@ struct audit_message {
 // internal - forward declaration
 struct daemon_conf;
 
+struct audit_cont_status {
+	pid_t		pid;
+	uint64_t	id;
+};
+
 struct audit_reply {
 	int                      type;
 	int                      len;
@@ -532,6 +545,9 @@ struct audit_reply {
 #ifdef AUDIT_FEATURE_BITMAP_ALL
 	struct audit_features	*features;
 #endif
+#ifdef AUDIT_FEATURE_BITMAP_CONTAINERID
+	struct audit_cont_status	*cont;
+#endif
 	};
 };
 
@@ -602,7 +618,8 @@ extern int  audit_get_reply(int fd, struct audit_reply *rep, reply_t block,
 extern uid_t audit_getloginuid(void);
 extern int  audit_setloginuid(uid_t uid);
 extern uint32_t audit_get_session(void);
-extern uint64_t audit_get_containerid(void);
+extern uint64_t audit_get_containerid(pid_t pid);
+extern int audit_set_containerid(pid_t pid, uint64_t);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
 extern bool audit_signal_info_has_ctx(struct audit_reply *rep);
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 6c786933b63e..e37070cd82e2 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -45,6 +45,8 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_SET_FEATURE,                "SET_FEATURE"                   )
 //_S(AUDIT_GET_FEATURE,                "GET_FEATURE"                   )
 //_S(AUDIT_SIGNAL_INFO2,               "SIGNAL_INFO2"                  )
+//_S(AUDIT_GET_CONTID,                 "GET_CONTID"                    )
+//_S(AUDIT_SET_CONTID,                 "SET_CONTID"                    )
 _S(AUDIT_CONTAINER_OP,               "CONTAINER_OP"                  )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
diff --git a/lib/netlink.c b/lib/netlink.c
index 66a3a3b7e83c..d177b865a79e 100644
--- a/lib/netlink.c
+++ b/lib/netlink.c
@@ -152,6 +152,9 @@ static int adjust_reply(struct audit_reply *rep, int len)
     defined(HAVE_STRUCT_AUDIT_STATUS_FEATURE_BITMAP)
 	rep->features = NULL;
 #endif
+#ifdef AUDIT_FEATURE_BITMAP_CONTAINERID
+	rep->cont     = NULL;
+#endif
 	if (!NLMSG_OK(rep->nlh, (unsigned int)len)) {
 		if (len == sizeof(rep->msg)) {
 			audit_msg(LOG_ERR, 
@@ -198,6 +201,9 @@ static int adjust_reply(struct audit_reply *rep, int len)
 		case AUDIT_SIGNAL_INFO2:
 			rep->signal_info2 = NLMSG_DATA(rep->nlh);
 			break;
+		case AUDIT_GET_CONTID:
+			rep->cont = NLMSG_DATA(rep->nlh);
+			break;
 	}
 	return len;
 }
-- 
1.8.3.1

