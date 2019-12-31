Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69679C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 351AA206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjGQuVrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLaT7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfLaT7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=5r4ppkOhB6H5NS85QdFE555yzOdq/M/4os0+z0d1X6Q=;
        b=VjGQuVrr3v7G2ShWUI1sxJBx0NeCdZFaf/hCqKxflWS5n7WkfZN4cHrGVeQuXwzuQBuBsn
        3IPfYPLowIvrKqcg/sB/ZZseUD31AcJ4FwAnL+n+4EF7IihhRi86820rJOt0N95qsf7IBL
        aHNArQ9cgvVAJl4t4jEwPq+gV9LoJU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-311DZPASPpyaAE27MftS1w-1; Tue, 31 Dec 2019 14:59:17 -0500
X-MC-Unique: 311DZPASPpyaAE27MftS1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF1B1100550E;
        Tue, 31 Dec 2019 19:59:15 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B55E060BEC;
        Tue, 31 Dec 2019 19:59:08 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 04/14] add ausearch containerid support
Date:   Tue, 31 Dec 2019 14:58:11 -0500
Message-Id: <1577822301-19760-5-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to ausearch for searching on the containerid field in
records.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/aureport-options.c |  1 +
 src/ausearch-llist.c   |  2 ++
 src/ausearch-llist.h   |  1 +
 src/ausearch-match.c   |  3 +++
 src/ausearch-options.c | 47 ++++++++++++++++++++++++++++++++++++++++-
 src/ausearch-options.h |  1 +
 src/ausearch-parse.c   | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/src/aureport-options.c b/src/aureport-options.c
index bd847d7d57f0..679c36c00985 100644
--- a/src/aureport-options.c
+++ b/src/aureport-options.c
@@ -62,6 +62,7 @@ const char *event_vmname = NULL;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int event_ppid = -1, event_session_id = -2;
+unsigned long long int event_contid = -1;
 int event_debug = 0, event_machine = -1;
 
 /* These are used by aureport */
diff --git a/src/ausearch-llist.c b/src/ausearch-llist.c
index ef5503c34fd9..ade727a9e102 100644
--- a/src/ausearch-llist.c
+++ b/src/ausearch-llist.c
@@ -60,6 +60,7 @@ void list_create(llist *l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
+	l->s.contid = -1;
 	l->s.uuid = NULL;
 	l->s.vmname = NULL;
 	l->s.tuid = NULL;
@@ -211,6 +212,7 @@ void list_clear(llist* l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
+	l->s.contid = -1;
 	free(l->s.uuid);
 	l->s.uuid = NULL;
 	free(l->s.vmname);
diff --git a/src/ausearch-llist.h b/src/ausearch-llist.h
index 64e4ee1f3694..2d1f52237ce6 100644
--- a/src/ausearch-llist.h
+++ b/src/ausearch-llist.h
@@ -56,6 +56,7 @@ typedef struct
   int arch;             // arch
   int syscall;          // syscall
   uint32_t session_id;  // Login session id
+  __u64 contid;         // Container id
   long long exit;       // Syscall exit code
   int exit_is_set;      // Syscall exit code is valid
   char *hostname;       // remote hostname
diff --git a/src/ausearch-match.c b/src/ausearch-match.c
index 61a11d30a09b..47c12581a963 100644
--- a/src/ausearch-match.c
+++ b/src/ausearch-match.c
@@ -113,6 +113,9 @@ int match(llist *l)
 				if ((event_session_id != -2) &&
 					(event_session_id != l->s.session_id))
 					return 0;
+				if ((event_contid != -1) &&
+					(event_contid != l->s.contid))
+					return 0;
 				if (event_exit_is_set) {
 					if (l->s.exit_is_set == 0)
 						return 0;
diff --git a/src/ausearch-options.c b/src/ausearch-options.c
index 5363fdace73c..550f47ed20e4 100644
--- a/src/ausearch-options.c
+++ b/src/ausearch-options.c
@@ -60,6 +60,7 @@ int event_syscall = -1, event_machine = -1;
 int event_ua = 0, event_ga = 0, event_se = 0;
 int just_one = 0;
 uint32_t event_session_id = -2;
+unsigned long long int event_contid = -1;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int line_buffered = 0;
@@ -88,7 +89,7 @@ struct nv_pair {
 
 enum { S_EVENT, S_COMM, S_FILENAME, S_ALL_GID, S_EFF_GID, S_GID, S_HELP,
 S_HOSTNAME, S_INTERP, S_INFILE, S_MESSAGE_TYPE, S_PID, S_SYSCALL, S_OSUCCESS,
-S_TIME_END, S_TIME_START, S_TERMINAL, S_ALL_UID, S_EFF_UID, S_UID, S_LOGINID,
+S_TIME_END, S_TIME_START, S_TERMINAL, S_ALL_UID, S_EFF_UID, S_UID, S_LOGINID, S_CONTID,
 S_VERSION, S_EXACT_MATCH, S_EXECUTABLE, S_CONTEXT, S_SUBJECT, S_OBJECT,
 S_PPID, S_KEY, S_RAW, S_NODE, S_IN_LOGS, S_JUST_ONE, S_SESSION, S_EXIT,
 S_LINEBUFFERED, S_UUID, S_VMNAME, S_DEBUG, S_CHECKPOINT, S_ARCH, S_FORMAT,
@@ -100,6 +101,7 @@ static struct nv_pair optiontab[] = {
 	{ S_EVENT, "--event" },
 	{ S_COMM, "-c" },
 	{ S_COMM, "--comm" },
+	{ S_CONTID, "--contid" },
 	{ S_CHECKPOINT, "--checkpoint" },
 	{ S_DEBUG, "--debug" },
 	{ S_EXIT, "-e" },
@@ -197,6 +199,7 @@ static void usage(void)
 	"\t-a,--event <Audit event id>\tsearch based on audit event id\n"
 	"\t--arch <CPU>\t\t\tsearch based on the CPU architecture\n"
 	"\t-c,--comm  <Comm name>\t\tsearch based on command line name\n"
+	"\t--contid <audit container id>\tsearch based on the task's audit container id\n"
 	"\t--checkpoint <checkpoint file>\tsearch from last complete event\n"
 	"\t--debug\t\t\tWrite malformed events that are skipped to stderr\n"
 	"\t-e,--exit  <Exit code or errno>\tsearch based on syscall exit code\n"
@@ -1182,6 +1185,48 @@ int check_params(int count, char *vars[])
 			}
 			c++;
 			break;
+		case S_CONTID:
+			if (!optarg) {
+				if ((c+1 < count) && vars[c+1])
+					optarg = vars[c+1];
+				else {
+					fprintf(stderr,
+						"Argument is required for %s\n",
+						vars[c]);
+					retval = -1;
+					break;
+				}
+			}
+			{
+			size_t len = strlen(optarg);
+			if (isdigit(optarg[0])) {
+				errno = 0;
+				event_contid = strtoull(optarg,NULL,0);
+				if (errno) {
+					fprintf(stderr, 
+			"Numeric container ID conversion error (%s) for %s\n",
+						strerror(errno), optarg);
+					retval = -1;
+				}
+			} else if (len >= 2 && *(optarg)=='-' &&
+					(isdigit(optarg[1]))) {
+				errno = 0;
+				event_contid = strtoll(optarg, NULL, 0);
+				if (errno) {
+					retval = -1;
+					fprintf(stderr, "Error converting %s\n",
+						optarg);
+				}
+			} else {
+				fprintf(stderr, 
+			"Container ID is non-numeric and unknown (%s)\n",
+						optarg);
+				retval = -1;
+				break;
+			}
+			}
+			c++;
+			break;
 		case S_UUID:
 			if (!optarg) {
 				fprintf(stderr,
diff --git a/src/ausearch-options.h b/src/ausearch-options.h
index 1372762b4b3e..c03256e36495 100644
--- a/src/ausearch-options.h
+++ b/src/ausearch-options.h
@@ -40,6 +40,7 @@ extern int line_buffered;
 extern int event_debug;
 extern pid_t event_ppid;
 extern uint32_t event_session_id;
+extern unsigned long long int event_contid;
 extern ilist *event_type;
 
 /* Data type to govern output format */
diff --git a/src/ausearch-parse.c b/src/ausearch-parse.c
index 497306dde070..a3932ae07eee 100644
--- a/src/ausearch-parse.c
+++ b/src/ausearch-parse.c
@@ -52,6 +52,8 @@ static int parse_path(const lnode *n, search_items *s);
 static int parse_user(const lnode *n, search_items *s, anode *avc);
 static int parse_obj(const lnode *n, search_items *s);
 static int parse_login(const lnode *n, search_items *s);
+static int parse_container_op(const lnode *n, search_items *s);
+static int parse_container_id(const lnode *n, search_items *s);
 static int parse_daemon1(const lnode *n, search_items *s);
 static int parse_daemon2(const lnode *n, search_items *s);
 static int parse_sockaddr(const lnode *n, search_items *s);
@@ -113,6 +115,9 @@ int extract_search_items(llist *l)
 			case AUDIT_LOGIN:
 				ret = parse_login(n, s);
 				break;
+			case AUDIT_CONTAINER_OP:
+				ret = parse_container_op(n, s);
+				break;
 			case AUDIT_IPC:
 			case AUDIT_OBJ_PID:
 				ret = parse_obj(n, s);
@@ -179,6 +184,9 @@ int extract_search_items(llist *l)
 			case AUDIT_TTY:
 				ret = parse_tty(n, s);
 				break;
+			case AUDIT_CONTAINER_ID:
+				ret = parse_container_id(n, s);
+				break;
 			default:
 				if (event_debug)
 					fprintf(stderr,
@@ -1444,6 +1452,55 @@ static int parse_login(const lnode *n, search_items *s)
 	return 0;
 }
 
+static int parse_container_op(const lnode *n, search_items *s)
+{
+	char *ptr, *str, *term = n->message;
+
+	// skip op
+	// skip opid
+	// get contid
+	if (event_contid != -1) {
+		str = strstr(term, "contid=");
+		if (str == NULL)
+			return 46;
+		ptr = str + 7;
+		term = strchr(ptr, ' ');
+		if (term == NULL)
+			return 47;
+		*term = 0;
+		errno = 0;
+		s->contid = strtoull(ptr, NULL, 10);
+		if (errno)
+			return 48;
+		*term = ' ';
+	}
+	// skip old-contid
+	return 0;
+}
+
+static int parse_container_id(const lnode *n, search_items *s)
+{
+	char *ptr, *str, *term = n->message;
+
+	// get contid
+	if (event_contid != -1) {
+		str = strstr(term, "contid=");
+		if (str == NULL)
+			return 49;
+		ptr = str + 7;
+		term = strchr(ptr, ' ');
+		if (term)
+			return 50;
+		*term = 0;
+		errno = 0;
+		s->contid = strtoull(ptr, NULL, 10);
+		if (errno)
+			return 51;
+		*term = ' ';
+	}
+	return 0;
+}
+
 static int parse_daemon1(const lnode *n, search_items *s)
 {
 	char *ptr, *str, *term, saved, *mptr;
-- 
1.8.3.1

