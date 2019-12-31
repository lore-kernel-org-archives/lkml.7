Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BE5C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997B1206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLHYZL/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLaT7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727275AbfLaT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Bbiggj2kUi4mqqH4Dlukyfv0IxMOBQqK5QQf6EXEx2U=;
        b=SLHYZL/quX9GJTtn2p5vj4RvgFRGuVRLb2kt/VyUfMERrwJLns9TzrKzIRy1BHjOGYKzsE
        M+uHfzOkEEdvC0noNbj23NcelXRsGXU4W537x7Aq1HGNrdSxyF3UM5W9/kZuW0Bnk/5sD9
        DA3TGuaPm+ED0p5u0v/ln9Ku/FHkf4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-n3S4gojKPiWh9ZLtMEEJtg-1; Tue, 31 Dec 2019 14:59:39 -0500
X-MC-Unique: n3S4gojKPiWh9ZLtMEEJtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0D18800D4E;
        Tue, 31 Dec 2019 19:59:38 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 045F160BEC;
        Tue, 31 Dec 2019 19:59:35 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 10/14] ausearch: convert contid to comma/carrat-sep list
Date:   Tue, 31 Dec 2019 14:58:17 -0500
Message-Id: <1577822301-19760-11-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the kernel is able to track container nesting ("audit: track
container nesting"), convert the ausearch internals to parse and track
the compound list of contids.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/aureport-options.c |   2 +-
 src/ausearch-llist.c   |   8 +++-
 src/ausearch-llist.h   |   2 +-
 src/ausearch-match.c   |  40 ++++++++++++++++-
 src/ausearch-options.c |  36 ++++++++++++++--
 src/ausearch-options.h |   2 +-
 src/ausearch-parse.c   | 115 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/ausearch-report.c  |   2 +-
 8 files changed, 195 insertions(+), 12 deletions(-)

diff --git a/src/aureport-options.c b/src/aureport-options.c
index 679c36c00985..69e2d18519b8 100644
--- a/src/aureport-options.c
+++ b/src/aureport-options.c
@@ -62,7 +62,7 @@ const char *event_vmname = NULL;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int event_ppid = -1, event_session_id = -2;
-unsigned long long int event_contid = -1;
+const char *event_contid = NULL;
 int event_debug = 0, event_machine = -1;
 
 /* These are used by aureport */
diff --git a/src/ausearch-llist.c b/src/ausearch-llist.c
index ade727a9e102..525ddf67464b 100644
--- a/src/ausearch-llist.c
+++ b/src/ausearch-llist.c
@@ -60,7 +60,7 @@ void list_create(llist *l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
-	l->s.contid = -1;
+	l->s.contid = NULL;
 	l->s.uuid = NULL;
 	l->s.vmname = NULL;
 	l->s.tuid = NULL;
@@ -212,7 +212,11 @@ void list_clear(llist* l)
 	l->s.arch = 0;
 	l->s.syscall = 0;
 	l->s.session_id = -2;
-	l->s.contid = -1;
+	if (l->s.contid) {
+		slist_clear(l->s.contid);
+		free(l->s.contid);
+		l->s.contid = NULL;
+	}
 	free(l->s.uuid);
 	l->s.uuid = NULL;
 	free(l->s.vmname);
diff --git a/src/ausearch-llist.h b/src/ausearch-llist.h
index 2d1f52237ce6..c652b4ca06c0 100644
--- a/src/ausearch-llist.h
+++ b/src/ausearch-llist.h
@@ -56,7 +56,7 @@ typedef struct
   int arch;             // arch
   int syscall;          // syscall
   uint32_t session_id;  // Login session id
-  __u64 contid;         // Container id
+  slist *contid;        // Container id
   long long exit;       // Syscall exit code
   int exit_is_set;      // Syscall exit code is valid
   char *hostname;       // remote hostname
diff --git a/src/ausearch-match.c b/src/ausearch-match.c
index 47c12581a963..ae03b670b762 100644
--- a/src/ausearch-match.c
+++ b/src/ausearch-match.c
@@ -37,6 +37,7 @@ static int strmatch(const char *needle, const char *haystack);
 static int user_match(llist *l);
 static int group_match(llist *l);
 static int context_match(llist *l);
+static int contid_match(llist *l);
 
 static void load_interpretations(const llist *l)
 {
@@ -113,8 +114,7 @@ int match(llist *l)
 				if ((event_session_id != -2) &&
 					(event_session_id != l->s.session_id))
 					return 0;
-				if ((event_contid != -1) &&
-					(event_contid != l->s.contid))
+				if (contid_match(l) == 0)
 					return 0;
 				if (event_exit_is_set) {
 					if (l->s.exit_is_set == 0)
@@ -417,3 +417,39 @@ static int context_match(llist *l)
 	return 1;
 }
 
+/*
+ * This function compares container ids. It returns a 0 if no match and a 1 if
+ * there is a match 
+ */
+static int contid_match(llist *l)
+{
+	if (event_contid) {
+		int found = 0;
+		const snode *ecn;
+		slist *ecptr = event_contid;
+
+		slist_first(ecptr);
+		ecn = slist_get_cur(ecptr);
+		if (l->s.contid) {
+			while (ecn && !found) {
+				const snode *sn;
+				slist *sptr = l->s.contid;
+	
+				slist_first(sptr);
+				sn = slist_get_cur(sptr);
+				while (sn && !found) {
+					if (!strcmp(sn->str, ecn->str))
+						found++;
+					else
+						sn = slist_next(sptr);
+				}
+				if (found)
+					return found;
+				ecn = slist_next(ecptr);
+			}
+			return found;
+		}
+	}
+	return 0;
+}
+
diff --git a/src/ausearch-options.c b/src/ausearch-options.c
index 550f47ed20e4..f4d0f308eddb 100644
--- a/src/ausearch-options.c
+++ b/src/ausearch-options.c
@@ -60,7 +60,7 @@ int event_syscall = -1, event_machine = -1;
 int event_ua = 0, event_ga = 0, event_se = 0;
 int just_one = 0;
 uint32_t event_session_id = -2;
-unsigned long long int event_contid = -1;
+const char *event_contid = NULL;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int line_buffered = 0;
@@ -1200,22 +1200,52 @@ int check_params(int count, char *vars[])
 			{
 			size_t len = strlen(optarg);
 			if (isdigit(optarg[0])) {
+				__u64 contid;
+
 				errno = 0;
-				event_contid = strtoull(optarg,NULL,0);
+				contid = strtoull(optarg,NULL,0);
 				if (errno) {
 					fprintf(stderr, 
 			"Numeric container ID conversion error (%s) for %s\n",
 						strerror(errno), optarg);
 					retval = -1;
+				} else {
+					if (!event_contid) {
+						event_contid = malloc(sizeof(slist));
+						if (!event_contid) {
+							retval = -1;
+							break;
+						}
+						slist_create(event_contid);
+					}
+					sn.str = strdup(optarg);
+					sn.key = NULL;
+					sn.hits = 0;
+					slist_append(event_contid, &sn);
 				}
 			} else if (len >= 2 && *(optarg)=='-' &&
 					(isdigit(optarg[1]))) {
+				__u64 contid;
+
 				errno = 0;
-				event_contid = strtoll(optarg, NULL, 0);
+				contid = strtoll(optarg, NULL, 0);
 				if (errno) {
 					retval = -1;
 					fprintf(stderr, "Error converting %s\n",
 						optarg);
+				} else {
+					if (!event_contid) {
+						event_contid = malloc(sizeof(slist));
+						if (!event_contid) {
+							retval = -1;
+							break;
+						}
+						slist_create(event_contid);
+					}
+					sn.str = strdup(optarg);
+					sn.key = NULL;
+					sn.hits = 0;
+					slist_append(event_contid, &sn);
 				}
 			} else {
 				fprintf(stderr, 
diff --git a/src/ausearch-options.h b/src/ausearch-options.h
index c03256e36495..a49d2400ff0d 100644
--- a/src/ausearch-options.h
+++ b/src/ausearch-options.h
@@ -40,7 +40,7 @@ extern int line_buffered;
 extern int event_debug;
 extern pid_t event_ppid;
 extern uint32_t event_session_id;
-extern unsigned long long int event_contid;
+extern const char *event_contid;
 extern ilist *event_type;
 
 /* Data type to govern output format */
diff --git a/src/ausearch-parse.c b/src/ausearch-parse.c
index a3932ae07eee..1b58bbc05a57 100644
--- a/src/ausearch-parse.c
+++ b/src/ausearch-parse.c
@@ -77,6 +77,18 @@ static int audit_avc_init(search_items *s)
 	return 0;
 }
 
+static int audit_contid_init(search_items *s)
+{
+	if (s->contid == NULL) {
+		//create
+		s->contid = malloc(sizeof(slist));
+		if (s->contid == NULL)
+			return -1;
+		slist_create(s->contid);
+	}
+	return 0;
+}
+
 /*
  * This function will take the list and extract the searchable fields from it.
  * It returns 0 on success and 1 on failure.
@@ -1459,6 +1471,7 @@ static int parse_container_op(const lnode *n, search_items *s)
 	// skip op
 	// skip opid
 	// get contid
+/*
 	if (event_contid != -1) {
 		str = strstr(term, "contid=");
 		if (str == NULL)
@@ -1473,8 +1486,65 @@ static int parse_container_op(const lnode *n, search_items *s)
 		if (errno)
 			return 48;
 		*term = ' ';
+ */
+	if (event_contid) {
+		snode sn;
+		char *comma, *carrat;
+
+		str = strstr(term, "contid=");
+		if (!str)
+			return 46;
+		if (audit_contid_init(s) < 0)
+			return 48;
+		str += 7;
+		term = strchr(str, ' ');
+		if (term == NULL)
+			return 47;
+		*term = 0;
+		sn.str = strdup(str);
+		sn.key = NULL;
+		sn.hits = 1;
+		slist_append(s->contid, &sn);
+		if (term)
+			*term = ' ';
+	// old-contid
+		str = strstr(term, "old-contid=");
+		if (!str)
+			return 46;
+		if (audit_contid_init(s) < 0)
+			return 48;
+		str += 11;
+		term = strchr(str, ' ');
+		if (term)
+			*term = 0;
+		comma = strchr(str, ',');
+		if (comma)
+			*comma = 0;
+		do {
+			carrat = strchr(str, '^');
+			if (carrat)
+				*carrat = 0;
+			do {
+				sn.str = strdup(str);
+				sn.key = NULL;
+				sn.hits = 1;
+				slist_append(s->contid, &sn);
+
+				if (carrat) {
+					str = carrat + 1;
+					*carrat = '^';
+					carrat = strchr(str, '^');
+				}
+			} while (carrat);
+			if (comma) {
+				str = comma + 1;
+				*comma = ',';
+				comma = strchr(str, ',');
+			}
+		} while (comma);
+		if (term)
+			*term = ' ';
 	}
-	// skip old-contid
 	return 0;
 }
 
@@ -1483,6 +1553,7 @@ static int parse_container_id(const lnode *n, search_items *s)
 	char *ptr, *str, *term = n->message;
 
 	// get contid
+/*
 	if (event_contid != -1) {
 		str = strstr(term, "contid=");
 		if (str == NULL)
@@ -1497,6 +1568,48 @@ static int parse_container_id(const lnode *n, search_items *s)
 		if (errno)
 			return 51;
 		*term = ' ';
+ */
+	if (event_contid) {
+		str = strstr(term, "contid=");
+		if (str) {
+			snode sn;
+			char *comma, *carrat;
+
+			if (audit_contid_init(s) < 0)
+				return 50;
+			str += 7;
+			term = strchr(str, ' ');
+			if (term)
+				*term = 0;
+			comma = strchr(str, ',');
+			if (comma)
+				*comma = 0;
+			do {
+				carrat = strchr(str, '^');
+				if (carrat)
+					*carrat = 0;
+				do {
+					sn.str = strdup(str);
+					sn.key = NULL;
+					sn.hits = 1;
+					slist_append(s->contid, &sn);
+
+					if (carrat) {
+						str = carrat + 1;
+						*carrat = '^';
+						carrat = strchr(str, '^');
+					}
+				} while (carrat);
+				if (comma) {
+					str = comma + 1;
+					*comma = ',';
+					comma = strchr(str, ',');
+				}
+			} while (comma);
+			if (term)
+				*term = ' ';
+		} else
+			return 49;
 	}
 	return 0;
 }
diff --git a/src/ausearch-report.c b/src/ausearch-report.c
index 82fa9579f972..7b597b5f3be0 100644
--- a/src/ausearch-report.c
+++ b/src/ausearch-report.c
@@ -293,7 +293,7 @@ no_print:
 			} else if (str && (val == NULL)) {
 			// Goes all the way to the end. Done parsing
 			// Known: MCS context in PATH rec obj=u:r:t:s0:c2,c7
-			// Known: CONTAINER_ID contid can be a comma-separated list
+			// Known: CONTAINER_ID contid can be a comma/carrat-separated list
 				int ftype = auparse_interp_adjust_type(n->type,
 								name, ptr);
 				if (ftype == AUPARSE_TYPE_MAC_LABEL
-- 
1.8.3.1

