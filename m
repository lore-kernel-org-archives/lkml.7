Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF2B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDITR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:17:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbfDITRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:17:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC57F307EABE;
        Tue,  9 Apr 2019 19:17:51 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-16.phx2.redhat.com [10.3.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 82B035C666;
        Tue,  9 Apr 2019 19:17:49 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v6 7/7] add support for audit_signal_info2
Date:   Tue,  9 Apr 2019 15:16:58 -0400
Message-Id: <1554837418-25278-8-git-send-email-rgb@redhat.com>
In-Reply-To: <1554837418-25278-1-git-send-email-rgb@redhat.com>
References: <1554837418-25278-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 09 Apr 2019 19:17:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since a process in a container could potentially signal the audit daemon
(reconfig, terminate, roll log, resume), that audit container identifier
information should be made available to the audit daemon to report the
full provenance of the signal.  It is not possible to add it to the
existing audit_signal_info struct without causing a kABI change.
Introduce a new audit message type AUDIT_SIGNAL_INFO2 using a new
audit_sig_info2 struct to be able to transfer this information from
kernel to userspace.

struct audit_sig_info2 {
       uid_t           uid;
       pid_t           pid;
       uint64_t        cid;
       char            ctx[0];
};

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/auditd-config.c          |  1 +
 docs/audit_request_signal_info.3 |  3 ++-
 lib/libaudit.c                   | 53 +++++++++++++++++++++++++++++++++++++++-
 lib/libaudit.h                   | 15 ++++++++++++
 lib/msg_typetab.h                |  1 +
 lib/netlink.c                    |  4 +++
 src/auditd-config.c              |  1 +
 src/auditd-config.h              |  1 +
 src/auditd-event.c               | 23 ++++++++++++-----
 src/auditd-reconfig.c            | 32 +++++++++++++++---------
 src/auditd.c                     | 33 ++++++++++---------------
 11 files changed, 127 insertions(+), 40 deletions(-)

diff --git a/auparse/auditd-config.c b/auparse/auditd-config.c
index 59984b47bd5a..b328f3523c02 100644
--- a/auparse/auditd-config.c
+++ b/auparse/auditd-config.c
@@ -77,6 +77,7 @@ void clear_config(struct daemon_conf *config)
 	config->sender_uid = 0;
 	config->sender_pid = 0;
 	config->sender_ctx = NULL;
+	config->sender_cid = 0;
 	config->write_logs = 1;
 	config->log_file = strdup("/var/log/audit/audit.log");
 	config->log_format = LF_RAW;
diff --git a/docs/audit_request_signal_info.3 b/docs/audit_request_signal_info.3
index 873deb58bef3..2461940f6622 100644
--- a/docs/audit_request_signal_info.3
+++ b/docs/audit_request_signal_info.3
@@ -8,12 +8,13 @@ int audit_request_signal_info(int fd);
 
 .SH "DESCRIPTION"
 
-audit_request_signal_info requests that the kernel send information about the sender of a signal to the audit daemon. The sinal info structure is as follows:
+audit_request_signal_info requests that the kernel send information about the sender of a signal to the audit daemon. The signal info structure is as follows:
 
 .nf
 struct audit_sig_info {
         uid_t           uid;
         pid_t           pid;
+        uint64_t        cid;
         char            ctx[0];
 };
 .fi
diff --git a/lib/libaudit.c b/lib/libaudit.c
index a1727f1a321a..63273ab5bbb1 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -25,6 +25,7 @@
 #include "config.h"
 #include <stdio.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -666,7 +667,11 @@ int audit_request_rules_list_data(int fd)
 
 int audit_request_signal_info(int fd)
 {
-	int rc = audit_send(fd, AUDIT_SIGNAL_INFO, NULL, 0);
+	int rc;
+	if (audit_get_containerid() == (long long)-2)
+		rc = audit_send(fd, AUDIT_SIGNAL_INFO, NULL, 0);
+	else
+		rc = audit_send(fd, AUDIT_SIGNAL_INFO2, NULL, 0);
 	if (rc < 0)
 		audit_msg(LOG_WARNING,
 			"Error sending signal_info request (%s)",
@@ -674,6 +679,52 @@ int audit_request_signal_info(int fd)
 	return rc;
 }
 
+bool audit_signal_info_is_baremsg(struct audit_reply *rep)
+{
+	if (rep->type == AUDIT_SIGNAL_INFO) {
+		if (rep->len == 24)
+			return true;
+	} else {
+		if(rep->len == 24 + sizeof(uint64_t))
+			return true;
+	}
+	return false;
+}
+
+char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res)
+{
+	if (rep->type == AUDIT_SIGNAL_INFO)
+		snprintf(buf, len,
+ 			 "op=%s auid=%u pid=%d subj=%s res=%s",
+			 op,
+			 rep->signal_info->uid, 
+	 		 rep->signal_info->pid,
+	 		 audit_signal_info_is_baremsg(rep) ? "?" :
+				rep->signal_info->ctx,
+			 res);
+	else
+		if (rep->signal_info2->cid == (uint64_t)-1)
+			snprintf(buf, len,
+ 				 "op=%s auid=%u pid=%d subj=%s res=%s",
+				 op,
+				 rep->signal_info2->uid, 
+	 			 rep->signal_info2->pid,
+				 audit_signal_info_is_baremsg(rep) ? "?" :
+					rep->signal_info2->ctx,
+				 res);
+		else
+			snprintf(buf, len,
+ 				 "op=%s auid=%u pid=%d subj=%s res=%s contid=%llu",
+				 op,
+	 			 rep->signal_info2->uid, 
+				 rep->signal_info2->pid,
+	 			 audit_signal_info_is_baremsg(rep) ? "?" :
+					rep->signal_info2->ctx,
+				 res,
+	 			 (unsigned long long)rep->signal_info2->cid);
+	return buf;
+}
+
 int audit_update_watch_perms(struct audit_rule_data *rule, int perms)
 {
 	unsigned int i, done=0;
diff --git a/lib/libaudit.h b/lib/libaudit.h
index 348b50b525be..a473c8d46d51 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -34,6 +34,7 @@ extern "C" {
 #include <linux/netlink.h>
 #include <linux/audit.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <syslog.h>
 
 
@@ -247,6 +248,10 @@ extern "C" {
 #define AUDIT_CONTAINER_OP	1020    /* Container creation notice */
 #endif
 
+#ifndef AUDIT_SIGNAL_INFO2
+#define AUDIT_SIGNAL_INFO2	1021    /* auditd signal sender info */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
@@ -476,6 +481,13 @@ struct audit_sig_info {
 	char		ctx[0];
 };
 
+struct audit_sig_info2 {
+	uid_t		uid;
+	pid_t		pid;
+	uint64_t	cid;
+	char		ctx[0];
+};
+
 /* defines for audit subsystem */
 #define MAX_AUDIT_MESSAGE_LENGTH    8970 // PATH_MAX*2+CONTEXT_SIZE*2+11+256+1
 struct audit_message {
@@ -501,6 +513,7 @@ struct audit_reply {
 	char                    *message;
 	struct nlmsgerr         *error;
 	struct audit_sig_info   *signal_info;
+	struct audit_sig_info2  *signal_info2;
 	struct daemon_conf      *conf;
 #ifdef AUDIT_FEATURE_BITMAP_ALL
 	struct audit_features	*features;
@@ -578,6 +591,8 @@ extern uint32_t audit_get_session(void);
 extern uint64_t audit_get_containerid(void);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
+extern bool audit_signal_info_is_baremsg(struct audit_reply *rep);
+extern char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res);
 
 /* Translation functions */
 extern int        audit_name_to_field(const char *field);
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 44d594d46de8..5c8f991f9516 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -44,6 +44,7 @@ _S(AUDIT_LOGIN,                      "LOGIN"                         )
 //_S(AUDIT_TTY_SET,                    "TTY_SET"                       )
 //_S(AUDIT_SET_FEATURE,                "SET_FEATURE"                   )
 //_S(AUDIT_GET_FEATURE,                "GET_FEATURE"                   )
+//_S(AUDIT_SIGNAL_INFO2,               "SIGNAL_INFO2"                  )
 _S(AUDIT_CONTAINER_OP,               "CONTAINER_OP"                  )
 _S(AUDIT_USER_AUTH,                  "USER_AUTH"                     )
 _S(AUDIT_USER_ACCT,                  "USER_ACCT"                     )
diff --git a/lib/netlink.c b/lib/netlink.c
index caa963b1ddb2..66a3a3b7e83c 100644
--- a/lib/netlink.c
+++ b/lib/netlink.c
@@ -146,6 +146,7 @@ static int adjust_reply(struct audit_reply *rep, int len)
 	rep->message  = NULL;
 	rep->error    = NULL;
 	rep->signal_info = NULL;
+	rep->signal_info2 = NULL;
 	rep->conf     = NULL;
 #if defined(HAVE_DECL_AUDIT_FEATURE_VERSION) && \
     defined(HAVE_STRUCT_AUDIT_STATUS_FEATURE_BITMAP)
@@ -194,6 +195,9 @@ static int adjust_reply(struct audit_reply *rep, int len)
 		case AUDIT_SIGNAL_INFO:
 			rep->signal_info = NLMSG_DATA(rep->nlh);
 			break;
+		case AUDIT_SIGNAL_INFO2:
+			rep->signal_info2 = NLMSG_DATA(rep->nlh);
+			break;
 	}
 	return len;
 }
diff --git a/src/auditd-config.c b/src/auditd-config.c
index ce260de5025a..931bbed22199 100644
--- a/src/auditd-config.c
+++ b/src/auditd-config.c
@@ -307,6 +307,7 @@ void clear_config(struct daemon_conf *config)
 	config->sender_uid = 0;
 	config->sender_pid = 0;
 	config->sender_ctx = NULL;
+	config->sender_cid = 0;
 	config->write_logs = 1;
 	config->log_file = strdup("/var/log/audit/audit.log");
 	config->log_format = LF_ENRICHED;
diff --git a/src/auditd-config.h b/src/auditd-config.h
index 50ed3507d34c..c3f8941713e2 100644
--- a/src/auditd-config.h
+++ b/src/auditd-config.h
@@ -49,6 +49,7 @@ struct daemon_conf
 	uid_t sender_uid;	/* the uid for sender of sighup */
 	pid_t sender_pid;	/* the pid for sender of sighup */
 	const char *sender_ctx;	/* the context for the sender of sighup */
+	uint64_t sender_cid;		/* the contid for sender of sighup */
 	unsigned int write_logs;
 	const char *log_file;
 	logging_formats log_format;
diff --git a/src/auditd-event.c b/src/auditd-event.c
index ef2828d8df94..016e96d8fe1b 100644
--- a/src/auditd-event.c
+++ b/src/auditd-event.c
@@ -1315,15 +1315,21 @@ static void reconfigure(struct auditd_event *e)
 	uid_t uid = nconf->sender_uid;
 	pid_t pid = nconf->sender_pid;
 	const char *ctx = nconf->sender_ctx;
+	uint64_t cid = nconf->sender_cid;
 	struct timeval tv;
 	char txt[MAX_AUDIT_MESSAGE_LENGTH];
 	char date[40];
 	unsigned int seq_num;
 	int need_size_check = 0, need_reopen = 0, need_space_check = 0;
 
-	snprintf(txt, sizeof(txt),
-		"config change requested by pid=%d auid=%u subj=%s",
-		pid, uid, ctx);
+	if (cid == -1)
+		snprintf(txt, sizeof(txt),
+			"config change requested by pid=%d auid=%u subj=%s",
+			pid, uid, ctx);
+	else
+		snprintf(txt, sizeof(txt),
+			"config change requested by pid=%d auid=%u subj=%s contid=%llu",
+			pid, uid, ctx, (unsigned long long)cid);
 	audit_msg(LOG_NOTICE, "%s", txt);
 
 	/* Do the reconfiguring. These are done in a specific
@@ -1571,9 +1577,14 @@ static void reconfigure(struct auditd_event *e)
         }
 
 	e->reply.type = AUDIT_DAEMON_CONFIG;
-	e->reply.len = snprintf(e->reply.msg.data, MAX_AUDIT_MESSAGE_LENGTH-2, 
-	"%s op=reconfigure state=changed auid=%u pid=%d subj=%s res=success",
-		date, uid, pid, ctx );
+	if (cid == -1)
+		e->reply.len = snprintf(e->reply.msg.data, MAX_AUDIT_MESSAGE_LENGTH-2, 
+		"%s op=reconfigure state=changed auid=%u pid=%d subj=%s res=success",
+			date, uid, pid, ctx);
+	else
+		e->reply.len = snprintf(e->reply.msg.data, MAX_AUDIT_MESSAGE_LENGTH-2, 
+		"%s op=reconfigure state=changed auid=%u pid=%d subj=%s res=success contid=%llu",
+			date, uid, pid, ctx, (unsigned long long)cid);
 	e->reply.message = e->reply.msg.data;
 	free((char *)ctx);
 }
diff --git a/src/auditd-reconfig.c b/src/auditd-reconfig.c
index a03e29aa57ab..490400de5bd3 100644
--- a/src/auditd-reconfig.c
+++ b/src/auditd-reconfig.c
@@ -101,13 +101,24 @@ static void *config_thread_main(void *arg)
 
 	if (load_config(&new_config, TEST_AUDITD) == 0) {
 		/* We will re-use the current reply */
-		new_config.sender_uid = e->reply.signal_info->uid;
-		new_config.sender_pid = e->reply.signal_info->pid;
-		if (e->reply.len > 24)
-			new_config.sender_ctx = 
-				strdup(e->reply.signal_info->ctx);
-		else
+		if (e->reply.type == AUDIT_SIGNAL_INFO) {
+			new_config.sender_uid = e->reply.signal_info->uid;
+			new_config.sender_pid = e->reply.signal_info->pid;
+			new_config.sender_cid = (uint64_t)-1;
+		} else {
+			new_config.sender_uid = e->reply.signal_info2->uid;
+			new_config.sender_pid = e->reply.signal_info2->pid;
+			new_config.sender_cid = e->reply.signal_info2->cid;
+		}
+		if (audit_signal_info_is_baremsg(&e->reply)) {
 			new_config.sender_ctx = strdup("?"); 
+		} else	if (e->reply.type == AUDIT_SIGNAL_INFO)
+				new_config.sender_ctx = 
+					strdup(e->reply.signal_info->ctx);
+			else {
+				new_config.sender_ctx = 
+					strdup(e->reply.signal_info2->ctx);
+			}
 		memcpy(e->reply.msg.data, &new_config, sizeof(new_config));
 		e->reply.conf = (struct daemon_conf *)e->reply.msg.data;
 		e->reply.type = AUDIT_DAEMON_RECONFIG;
@@ -115,12 +126,9 @@ static void *config_thread_main(void *arg)
 	} else {
 		// need to send a failed event message
 		char txt[MAX_AUDIT_MESSAGE_LENGTH];
-		snprintf(txt, sizeof(txt),
-	    "op=reconfigure state=no-change auid=%u pid=%d subj=%s res=failed",
-			e->reply.signal_info->uid,
-			e->reply.signal_info->pid,
-			(e->reply.len > 24) ? 
-				e->reply.signal_info->ctx : "?");
+		audit_format_signal_info(txt, sizeof(txt),
+					 "reconfigure-no-change",
+				         &e->reply, "failed");
 		// FIXME: need to figure out sending this
 		//send_audit_event(AUDIT_DAEMON_CONFIG, txt);
 		free_config(&new_config);
diff --git a/src/auditd.c b/src/auditd.c
index 8aa5be9b88a9..f03ed7505676 100644
--- a/src/auditd.c
+++ b/src/auditd.c
@@ -514,6 +514,7 @@ static void netlink_handler(struct ev_loop *loop, struct ev_io *io,
 		case AUDIT_FIRST_DAEMON...AUDIT_LAST_DAEMON:
 			break;
 		case AUDIT_SIGNAL_INFO:
+		case AUDIT_SIGNAL_INFO2:
 			if (hup_info_requested) {
 				audit_msg(LOG_DEBUG,
 				    "HUP detected, starting config manager");
@@ -528,31 +529,28 @@ static void netlink_handler(struct ev_loop *loop, struct ev_io *io,
 				hup_info_requested = 0;
 			} else if (usr1_info_requested) {
 				char usr1[MAX_AUDIT_MESSAGE_LENGTH];
-				if (cur_event->reply.len == 24) {
+				if (audit_signal_info_is_baremsg(&cur_event->reply)) {
 					snprintf(usr1, sizeof(usr1),
 					"op=rotate-logs auid=-1 pid=-1 subj=?");
 				} else {
-					snprintf(usr1, sizeof(usr1),
-				 "op=rotate-logs auid=%u pid=%d subj=%s",
-					 cur_event->reply.signal_info->uid, 
-					 cur_event->reply.signal_info->pid,
-					 cur_event->reply.signal_info->ctx);
+					audit_format_signal_info(usr1, sizeof(usr1),
+							         "rotate-logs",
+							         &cur_event->reply,
+							         "success");
 				}
 				send_audit_event(AUDIT_DAEMON_ROTATE, usr1);
 				usr1_info_requested = 0;
 			} else if (usr2_info_requested) {
 				char usr2[MAX_AUDIT_MESSAGE_LENGTH];
-				if (cur_event->reply.len == 24) {
+				if (audit_signal_info_is_baremsg(&cur_event->reply)) {
 					snprintf(usr2, sizeof(usr2), 
 						"op=resume-logging auid=-1 "
 						"pid=-1 subj=? res=success");
 				} else {
-					snprintf(usr2, sizeof(usr2),
-						"op=resume-logging "
-					"auid=%u pid=%d subj=%s res=success",
-					 cur_event->reply.signal_info->uid, 
-					 cur_event->reply.signal_info->pid,
-					 cur_event->reply.signal_info->ctx);
+					audit_format_signal_info(usr2, sizeof(usr2),
+							         "resume-logging",
+							         &cur_event->reply,
+							         "success");
 				}
 				resume_logging();
 				libdisp_resume();
@@ -993,12 +991,7 @@ int main(int argc, char *argv[])
 		rc = get_reply(fd, &trep, rc);
 		if (rc > 0) {
 			char txt[MAX_AUDIT_MESSAGE_LENGTH];
-			snprintf(txt, sizeof(txt),
-				"op=terminate auid=%u "
-				"pid=%d subj=%s res=success",
-				 trep.signal_info->uid,
-				 trep.signal_info->pid, 
-				 trep.signal_info->ctx); 
+			audit_format_signal_info(txt, sizeof(txt), "terminate", &trep, "success");
 			send_audit_event(AUDIT_DAEMON_END, txt);
 		} 
 	} 
@@ -1091,7 +1084,7 @@ static int get_reply(int fd, struct audit_reply *rep, int seq)
 				continue;
 
 			/* If its not what we are expecting, keep looping */
-			if (rep->type == AUDIT_SIGNAL_INFO)
+			if (rep->type == AUDIT_SIGNAL_INFO || rep->type == AUDIT_SIGNAL_INFO2)
 				return 1;
 
 			/* If we get done or error, break out */
-- 
1.8.3.1

