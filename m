Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA2AC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACF3206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Opwlen3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfLaT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34680 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfLaT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pEIY3l73Z2h9avG2tO+EO/JNmoSv4Wbv0tKsKZXjhdI=;
        b=Opwlen3ozoxQI3w4nhyE4k7E+/9SZZrLXYUc6MsH9NmVNX/iH54sdOVCDINE9p2samrzSn
        9Anc0sAeip02u0XZsUto82kOE9OOyjpLvGjaBu66mi0+rWyQw1hR35t4KFsIRi326jTS3Q
        gyhacLwjXFESdrlQ0pkiqwJ99FcQGzA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-_btO3jHVOLGJtYE9L7yUJg-1; Tue, 31 Dec 2019 14:59:29 -0500
X-MC-Unique: _btO3jHVOLGJtYE9L7yUJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0D51800EB8;
        Tue, 31 Dec 2019 19:59:27 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6212360BEC;
        Tue, 31 Dec 2019 19:59:25 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 08/14] add support for audit_signal_info2
Date:   Tue, 31 Dec 2019 14:58:15 -0500
Message-Id: <1577822301-19760-9-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 docs/audit_request_signal_info.3 | 11 +++++++++
 lib/libaudit.c                   | 49 +++++++++++++++++++++++++++++++++-------
 lib/libaudit.h                   | 14 ++++++++++++
 lib/msg_typetab.h                |  1 +
 lib/netlink.c                    |  4 ++++
 src/auditd-config.c              |  1 +
 src/auditd-config.h              |  1 +
 src/auditd-event.c               | 10 +++++++-
 src/auditd-reconfig.c            | 23 ++++++++++++++-----
 src/auditd.c                     |  3 ++-
 11 files changed, 102 insertions(+), 16 deletions(-)

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
index b68d7bbefeed..6905fe7c566d 100644
--- a/docs/audit_request_signal_info.3
+++ b/docs/audit_request_signal_info.3
@@ -18,6 +18,17 @@ struct audit_sig_info {
 };
 .fi
 
+If the process has an audit container identifier, the signal info structure is as follows:
+
+.nf
+struct audit_sig_info2 {
+        uid_t           uid;
+        pid_t           pid;
+        uint64_t        cid;
+        char            ctx[0];
+};
+.fi
+
 This function is likely to be used only by audit daemons and shouldn't be called by any other kind of program.
 
 .SH "RETURN VALUE"
diff --git a/lib/libaudit.c b/lib/libaudit.c
index a8c321cb3c86..7737e7f7f30c 100644
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
@@ -667,7 +668,11 @@ int audit_request_rules_list_data(int fd)
 
 int audit_request_signal_info(int fd)
 {
-	int rc = audit_send(fd, AUDIT_SIGNAL_INFO, NULL, 0);
+	int rc;
+	if (audit_get_containerid() == (uint64_t)-2)
+		rc = audit_send(fd, AUDIT_SIGNAL_INFO, NULL, 0);
+	else
+		rc = audit_send(fd, AUDIT_SIGNAL_INFO2, NULL, 0);
 	if (rc < 0)
 		audit_msg(LOG_WARNING,
 			"Error sending signal_info request (%s)",
@@ -675,15 +680,43 @@ int audit_request_signal_info(int fd)
 	return rc;
 }
 
+bool audit_signal_info_has_ctx(struct audit_reply *rep)
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
 char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res)
 {
-	if (rep->len == 24)
-		snprintf(buf, len, "op=%s auid=%u pid=%d res=%s", op,
-		 	rep->signal_info->uid, rep->signal_info->pid, res);
-	else
-		snprintf(buf, len, "op=%s auid=%u pid=%d subj=%s res=%s",
-		 	op, rep->signal_info->uid, rep->signal_info->pid,
-		 	rep->signal_info->ctx, res);
+	int c = 0;
+	if (rep->type == AUDIT_SIGNAL_INFO) {
+		c += snprintf(buf + c, len - c, "op=%s auid=%u pid=%d",
+			      op,
+			      rep->signal_info->uid, 
+	 		      rep->signal_info->pid);
+		if (audit_signal_info_has_ctx(rep))
+			c += snprintf(buf + c, len - c, " subj=%s",
+				      rep->signal_info->ctx);
+		c += snprintf(buf + c, len - c, " res=%s", res);
+	} else {
+		c += snprintf(buf + c, len - c, "op=%s auid=%u pid=%d",
+			      op,
+			      rep->signal_info2->uid, 
+	 		      rep->signal_info2->pid);
+		if (audit_signal_info_has_ctx(rep))
+			c += snprintf(buf + c, len - c, " subj=%s",
+				      rep->signal_info2->ctx);
+		c += snprintf(buf + c, len - c, " res=%s", res);
+		if (rep->signal_info2->cid == (uint64_t)-1)
+			c += snprintf(buf + c, len - c, " contid=%llu",
+	 			      rep->signal_info2->cid);
+	}
 	return buf;
 }
 
diff --git a/lib/libaudit.h b/lib/libaudit.h
index 5076be0f92e5..7cbdf58166cd 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -34,6 +34,7 @@ extern "C" {
 #include <linux/netlink.h>
 #include <linux/audit.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <syslog.h>
 
 
@@ -250,6 +251,10 @@ extern "C" {
 #define AUDIT_CONTAINER_OP	1020    /* Container creation notice */
 #endif
 
+#ifndef AUDIT_SIGNAL_INFO2
+#define AUDIT_SIGNAL_INFO2	1021    /* auditd signal sender info */
+#endif
+
 #ifndef AUDIT_MMAP
 #define AUDIT_MMAP		1323 /* Descriptor and flags in mmap */
 #endif
@@ -494,6 +499,13 @@ struct audit_sig_info {
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
@@ -519,6 +531,7 @@ struct audit_reply {
 	char                    *message;
 	struct nlmsgerr         *error;
 	struct audit_sig_info   *signal_info;
+	struct audit_sig_info2  *signal_info2;
 	struct daemon_conf      *conf;
 #ifdef AUDIT_FEATURE_BITMAP_ALL
 	struct audit_features	*features;
@@ -596,6 +609,7 @@ extern uint32_t audit_get_session(void);
 extern uint64_t audit_get_containerid(void);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
+extern bool audit_signal_info_has_ctx(struct audit_reply *rep);
 extern char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res);
 
 /* Translation functions */
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index a11f761e8990..6502cdfa96d4 100644
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
index 85b647014154..0474454e942f 100644
--- a/src/auditd-event.c
+++ b/src/auditd-event.c
@@ -1321,6 +1321,7 @@ static void reconfigure(struct auditd_event *e)
 	uid_t uid = nconf->sender_uid;
 	pid_t pid = nconf->sender_pid;
 	const char *ctx = nconf->sender_ctx;
+	uint64_t cid = nconf->sender_cid;
 	struct timeval tv;
 	char txt[MAX_AUDIT_MESSAGE_LENGTH];
 	int txt_len;
@@ -1331,8 +1332,11 @@ static void reconfigure(struct auditd_event *e)
 	txt_len = snprintf(txt, sizeof(txt),
 		"config change requested by pid=%d auid=%u", pid, uid);
 	if (ctx)
+		txt_len += snprintf(txt + txt_len, sizeof(txt) - txt_len,
+				    " subj=%s", ctx);
+	if (cid != -1)
 		snprintf(txt + txt_len, sizeof(txt) - txt_len,
-			 " subj=%s", ctx);
+			 " contid=%llu", (unsigned long long)cid);
 	audit_msg(LOG_NOTICE, "%s", txt);
 
 	/* Do the reconfiguring. These are done in a specific
@@ -1590,6 +1594,10 @@ static void reconfigure(struct auditd_event *e)
 	e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
 				 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len, 
 				 " res=success");
+	if (cid != -1)
+		e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
+					 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len, 
+					 "contid=%llu", (unsigned long long)cid);
 	e->reply.message = e->reply.msg.data;
 	free((char *)ctx);
 }
diff --git a/src/auditd-reconfig.c b/src/auditd-reconfig.c
index 1af402526c4e..5d8e4627ddeb 100644
--- a/src/auditd-reconfig.c
+++ b/src/auditd-reconfig.c
@@ -101,11 +101,23 @@ static void *config_thread_main(void *arg)
 
 	if (load_config(&new_config, TEST_AUDITD) == 0) {
 		/* We will re-use the current reply */
-		new_config.sender_uid = e->reply.signal_info->uid;
-		new_config.sender_pid = e->reply.signal_info->pid;
-		if (e->reply.len > 24)
-			new_config.sender_ctx = 
-				strdup(e->reply.signal_info->ctx);
+		if (e->reply.type == AUDIT_SIGNAL_INFO) {
+			new_config.sender_uid = e->reply.signal_info->uid;
+			new_config.sender_pid = e->reply.signal_info->pid;
+			new_config.sender_cid = (uint64_t)-1;
+		} else {
+			new_config.sender_uid = e->reply.signal_info2->uid;
+			new_config.sender_pid = e->reply.signal_info2->pid;
+			new_config.sender_cid = e->reply.signal_info2->cid;
+		}
+		if (audit_signal_info_has_ctx(&e->reply)) {
+			if (e->reply.type == AUDIT_SIGNAL_INFO)
+				new_config.sender_ctx = 
+					strdup(e->reply.signal_info->ctx);
+			else
+				new_config.sender_ctx = 
+					strdup(e->reply.signal_info2->ctx);
+		}
 		memcpy(e->reply.msg.data, &new_config, sizeof(new_config));
 		e->reply.conf = (struct daemon_conf *)e->reply.msg.data;
 		e->reply.type = AUDIT_DAEMON_RECONFIG;
@@ -125,4 +137,3 @@ static void *config_thread_main(void *arg)
 	pthread_mutex_unlock(&config_lock);
 	return NULL;		
 }
-
diff --git a/src/auditd.c b/src/auditd.c
index 164016eac00c..6b0f822b9a65 100644
--- a/src/auditd.c
+++ b/src/auditd.c
@@ -516,6 +516,7 @@ static void netlink_handler(struct ev_loop *loop, struct ev_io *io,
 		case AUDIT_FIRST_DAEMON...AUDIT_LAST_DAEMON:
 			break;
 		case AUDIT_SIGNAL_INFO:
+		case AUDIT_SIGNAL_INFO2:
 			if (hup_info_requested) {
 				char hup[MAX_AUDIT_MESSAGE_LENGTH];
 				audit_msg(LOG_DEBUG,
@@ -1077,7 +1078,7 @@ static int get_reply(int fd, struct audit_reply *rep, int seq)
 				continue;
 
 			/* If its not what we are expecting, keep looping */
-			if (rep->type == AUDIT_SIGNAL_INFO)
+			if (rep->type == AUDIT_SIGNAL_INFO || rep->type == AUDIT_SIGNAL_INFO2)
 				return 1;
 
 			/* If we get done or error, break out */
-- 
1.8.3.1

