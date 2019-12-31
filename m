Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA484C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777FC2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5akmDnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfLaT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21106 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727275AbfLaT7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=UNZKHX48PvzGUGtCvg8U6VxiqmQycaIOrQBrBNjiCuc=;
        b=Z5akmDnunG/ohkoXpsd6T2Flc9R5WUzCWkQLiASLSfBeqe8X6tAKbJzq6k9p0488ozfyfi
        BZgEp+SySBfUSMW8gqlKXITb1GjQMPXr7ojudp5YsUIXT+3e+bz70lw0eOW+anQx2scp5I
        Ry3T6/VVahyJ1nNs/jHx33Vn5KxmV3A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-LLrahf4LPD6nXHxDWA0uKg-1; Tue, 31 Dec 2019 14:59:43 -0500
X-MC-Unique: LLrahf4LPD6nXHxDWA0uKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C320B18031D5;
        Tue, 31 Dec 2019 19:59:41 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1989160BEC;
        Tue, 31 Dec 2019 19:59:38 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 11/14] ausearch: convert contid to comma/carrat-sep cnode/clist
Date:   Tue, 31 Dec 2019 14:58:18 -0500
Message-Id: <1577822301-19760-12-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the contid list from a list of strings to a list of contids for
faster and more efficient processing.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/Makefile.am        |   6 +-
 src/ausearch-contid.c  | 171 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/ausearch-contid.h  |  61 ++++++++++++++++++
 src/ausearch-llist.c   |   2 +-
 src/ausearch-llist.h   |   3 +-
 src/ausearch-match.c   |  36 +++++------
 src/ausearch-options.c |  26 ++++----
 src/ausearch-options.h |   3 +-
 src/ausearch-parse.c   | 127 +++++++++++++-----------------------
 9 files changed, 313 insertions(+), 122 deletions(-)
 create mode 100644 src/ausearch-contid.c
 create mode 100644 src/ausearch-contid.h

diff --git a/src/Makefile.am b/src/Makefile.am
index fda612b1ccb0..91c29cfbe52e 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -25,7 +25,7 @@ SUBDIRS = test
 AM_CPPFLAGS = -I${top_srcdir} -I${top_srcdir}/lib -I${top_srcdir}/src/libev -I${top_srcdir}/auparse -I${top_srcdir}/audisp -I${top_srcdir}/common
 sbin_PROGRAMS = auditd auditctl aureport ausearch autrace
 AM_CFLAGS = -D_GNU_SOURCE -Wno-pointer-sign
-noinst_HEADERS = auditd-config.h auditd-event.h auditd-listen.h ausearch-llist.h ausearch-options.h auditctl-llist.h aureport-options.h ausearch-parse.h aureport-scan.h ausearch-lookup.h ausearch-int.h auditd-dispatch.h ausearch-string.h ausearch-nvpair.h ausearch-common.h ausearch-avc.h ausearch-time.h ausearch-lol.h auditctl-listing.h ausearch-checkpt.h
+noinst_HEADERS = auditd-config.h auditd-event.h auditd-listen.h ausearch-llist.h ausearch-options.h auditctl-llist.h aureport-options.h ausearch-parse.h aureport-scan.h ausearch-lookup.h ausearch-int.h auditd-dispatch.h ausearch-string.h ausearch-nvpair.h ausearch-common.h ausearch-avc.h ausearch-time.h ausearch-lol.h auditctl-listing.h ausearch-checkpt.h ausearch-contid.h
 
 auditd_SOURCES = auditd.c auditd-event.c auditd-config.c auditd-reconfig.c auditd-sendmail.c auditd-dispatch.c
 if ENABLE_LISTENER
@@ -41,10 +41,10 @@ auditctl_CFLAGS = -fPIE -DPIE -g -D_GNU_SOURCE
 auditctl_LDFLAGS = -pie -Wl,-z,relro -Wl,-z,now
 auditctl_LDADD = -L${top_builddir}/lib -laudit -L${top_builddir}/auparse -lauparse -L${top_builddir}/common -laucommon
 
-aureport_SOURCES = aureport.c auditd-config.c ausearch-llist.c aureport-options.c ausearch-string.c ausearch-parse.c aureport-scan.c aureport-output.c ausearch-lookup.c ausearch-int.c ausearch-time.c ausearch-nvpair.c ausearch-avc.c ausearch-lol.c
+aureport_SOURCES = aureport.c auditd-config.c ausearch-llist.c aureport-options.c ausearch-string.c ausearch-parse.c aureport-scan.c aureport-output.c ausearch-lookup.c ausearch-int.c ausearch-time.c ausearch-nvpair.c ausearch-avc.c ausearch-lol.c ausearch-contid.c
 aureport_LDADD = -L${top_builddir}/lib -laudit -L${top_builddir}/auparse -lauparse -L${top_builddir}/common -laucommon
 
-ausearch_SOURCES = ausearch.c auditd-config.c ausearch-llist.c ausearch-options.c ausearch-report.c ausearch-match.c ausearch-string.c ausearch-parse.c ausearch-int.c ausearch-time.c ausearch-nvpair.c ausearch-lookup.c ausearch-avc.c ausearch-lol.c ausearch-checkpt.c
+ausearch_SOURCES = ausearch.c auditd-config.c ausearch-llist.c ausearch-options.c ausearch-report.c ausearch-match.c ausearch-string.c ausearch-parse.c ausearch-int.c ausearch-time.c ausearch-nvpair.c ausearch-lookup.c ausearch-avc.c ausearch-lol.c ausearch-checkpt.c ausearch-contid.c
 ausearch_LDADD = -L${top_builddir}/lib -laudit -L${top_builddir}/auparse -lauparse -L${top_builddir}/common -laucommon
 
 autrace_SOURCES = autrace.c delete_all.c auditctl-llist.c
diff --git a/src/ausearch-contid.c b/src/ausearch-contid.c
new file mode 100644
index 000000000000..ad50edb5a29c
--- /dev/null
+++ b/src/ausearch-contid.c
@@ -0,0 +1,171 @@
+/*
+* ausearch-contid.c - Minimal linked list library for contid
+* adapted from ausearch-string.c
+* Copyright (c) 2005,2008,2014,2019 Red Hat Inc., Durham, North Carolina.
+* All Rights Reserved. 
+*
+* This software may be freely redistributed and/or modified under the
+* terms of the GNU General Public License as published by the Free
+* Software Foundation; either version 2, or (at your option) any
+* later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; see the file COPYING. If not, write to the
+* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor 
+* Boston, MA 02110-1335, USA.
+*
+* Authors:
+*   Steve Grubb <sgrubb@redhat.com>
+*   Richard Guy Briggs <rgb@redhat.com>
+*/
+
+#include "ausearch-contid.h"
+#include <stdlib.h>
+
+
+void clist_create(clist *l)
+{
+	l->head = NULL;
+	l->cur = NULL;
+	l->cnt = 0;
+}
+
+void clist_last(clist *l)
+{
+        register cnode* cur;
+	
+	if (l->head == NULL)
+		return;
+
+	// Try using cur so that we don't have to start at beginnning
+	if (l->cur)
+		cur = l->cur;
+	else
+	        cur = l->head;
+
+	// Loop until no next value
+	while (cur->next)
+		cur = cur->next;
+	l->cur = cur;
+}
+
+cnode *clist_next(clist *l)
+{
+	if (l->cur == NULL)
+		return NULL;
+	l->cur = l->cur->next;
+	return l->cur;
+}
+
+void clist_append(clist *l, cnode *node)
+{
+	cnode* newnode;
+
+	newnode = malloc(sizeof(cnode));
+
+	newnode->id = node->id;
+	newnode->hits = node->hits;
+	newnode->next = NULL;
+
+	// Make sure cursor is at the end
+	clist_last(l);
+
+	// if we are at top, fix this up
+	if (l->head == NULL)
+		l->head = newnode;
+	else	// Otherwise add pointer to newnode
+		l->cur->next = newnode;
+
+	// make newnode current
+	l->cur = newnode;
+	l->cnt++;
+}
+
+void clist_clear(clist* l)
+{
+	cnode* nextnode;
+	register cnode* current;
+
+	current = l->head;
+	while (current) {
+		nextnode=current->next;
+		free(current);
+		current=nextnode;
+	}
+	l->head = NULL;
+	l->cur = NULL;
+	l->cnt = 0;
+}
+
+/* This function dominates the timing of aureport. Needs to be more efficient */
+int clist_add_if_uniq(clist *l, const unsigned long long id)
+{
+	cnode cn;
+        register cnode *cur;
+
+	if (id == (unsigned long long)-1)
+		return -1;
+
+       	cur = l->head;
+	while (cur) {
+		if (id == cur->id) {
+			cur->hits++;
+			l->cur = cur;
+			return 0;
+		} else 
+			cur = cur->next;
+	}
+
+	/* No matches, append to the end */
+	cn.id = id;
+	cn.hits = 1;
+	clist_append(l, &cn);
+	return 1;
+}
+
+// If lprev would be NULL, use l->head
+static void swap_nodes(cnode *lprev, cnode *left, cnode *right)
+{
+	cnode *t = right->next;
+	if (lprev)
+		lprev->next = right;
+	right->next = left;
+	left->next = t;
+}
+
+// This will sort the list from most hits to least
+void clist_sort_by_hits(clist *l)
+{
+	register cnode* cur, *prev;
+
+	if (l->cnt <= 1)
+		return;
+
+	prev = cur = l->head;
+
+	while (cur && cur->next) {
+		/* If the next node is bigger */
+		if (cur->hits < cur->next->hits) {
+			if (cur == l->head) {
+				// Update the actual list head
+				l->head = cur->next;
+				prev = NULL;
+			}
+			swap_nodes(prev, cur, cur->next);
+
+			// start over
+			prev = cur = l->head;
+			continue;
+		}
+		prev = cur;
+		cur = cur->next;
+	}
+	// End with cur pointing at first record
+	l->cur = l->head;
+}
+
diff --git a/src/ausearch-contid.h b/src/ausearch-contid.h
new file mode 100644
index 000000000000..d728791d3a56
--- /dev/null
+++ b/src/ausearch-contid.h
@@ -0,0 +1,61 @@
+/*
+* ausearch-contid.h - Header file for ausearch-contid.c
+* adapted from ausearch-string.h
+* Copyright (c) 2005,2008,2019 Red Hat Inc., Durham, North Carolina.
+* All Rights Reserved.
+*
+* This software may be freely redistributed and/or modified under the
+* terms of the GNU General Public License as published by the Free
+* Software Foundation; either version 2, or (at your option) any
+* later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; see the file COPYING. If not, write to the
+* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor 
+* Boston, MA 02110-1335, USA.
+*
+* Authors:
+*   Steve Grubb <sgrubb@redhat.com>
+*   Richard Guy Briggs <rgb@redhat.com>
+*/
+
+#ifndef AUCONTID_HEADER
+#define AUCONTID_HEADER
+
+#include "config.h"
+
+/* This is the node of the linked list. message & item are the only elements
+ * at this time. Any data elements that are per item goes here. */
+typedef struct _cnode{
+  unsigned long long id;		// The audit container id
+  unsigned int hits;	// Number of times this contid was attempted to be added
+  struct _cnode* next;	// Next contid node pointer
+} cnode;
+
+/* This is the linked list head. Only data elements that are 1 per
+ * event goes here. */
+typedef struct {
+  cnode *head;		// List head
+  cnode *cur;		// Pointer to current node
+  unsigned int cnt;	// How many items in this list
+} clist;
+
+void clist_create(clist *l);
+static inline void clist_first(clist *l) { l->cur = l->head; }
+void clist_last(clist *l);
+cnode *clist_next(clist *l);
+static inline cnode *clist_get_cur(clist *l) { return l->cur; }
+void clist_append(clist *l, cnode *node);
+void clist_clear(clist* l);
+
+/* append a contid if its not already on the list */
+int clist_add_if_uniq(clist *l, const unsigned long long id);
+void clist_sort_by_hits(clist *l);
+
+#endif
+
diff --git a/src/ausearch-llist.c b/src/ausearch-llist.c
index 525ddf67464b..6624398a1b5c 100644
--- a/src/ausearch-llist.c
+++ b/src/ausearch-llist.c
@@ -213,7 +213,7 @@ void list_clear(llist* l)
 	l->s.syscall = 0;
 	l->s.session_id = -2;
 	if (l->s.contid) {
-		slist_clear(l->s.contid);
+		clist_clear(l->s.contid);
 		free(l->s.contid);
 		l->s.contid = NULL;
 	}
diff --git a/src/ausearch-llist.h b/src/ausearch-llist.h
index c652b4ca06c0..f2f004b09630 100644
--- a/src/ausearch-llist.h
+++ b/src/ausearch-llist.h
@@ -31,6 +31,7 @@
 #include <sys/types.h>
 #include "ausearch-string.h"
 #include "ausearch-avc.h"
+#include "ausearch-contid.h"
 #include "ausearch-common.h"
 
 
@@ -56,7 +57,7 @@ typedef struct
   int arch;             // arch
   int syscall;          // syscall
   uint32_t session_id;  // Login session id
-  slist *contid;        // Container id
+  clist *contid;        // Container id
   long long exit;       // Syscall exit code
   int exit_is_set;      // Syscall exit code is valid
   char *hostname;       // remote hostname
diff --git a/src/ausearch-match.c b/src/ausearch-match.c
index ae03b670b762..1aa6503e59c2 100644
--- a/src/ausearch-match.c
+++ b/src/ausearch-match.c
@@ -424,32 +424,28 @@ static int context_match(llist *l)
 static int contid_match(llist *l)
 {
 	if (event_contid) {
-		int found = 0;
-		const snode *ecn;
-		slist *ecptr = event_contid;
+		const cnode *ecn;
+		clist *ecptr = event_contid;
 
-		slist_first(ecptr);
-		ecn = slist_get_cur(ecptr);
+		clist_first(ecptr);
+		ecn = clist_get_cur(ecptr);
 		if (l->s.contid) {
-			while (ecn && !found) {
-				const snode *sn;
-				slist *sptr = l->s.contid;
+			while (ecn) {
+				const cnode *cn;
+				clist *cptr = l->s.contid;
 	
-				slist_first(sptr);
-				sn = slist_get_cur(sptr);
-				while (sn && !found) {
-					if (!strcmp(sn->str, ecn->str))
-						found++;
-					else
-						sn = slist_next(sptr);
+				clist_first(cptr);
+				cn = clist_get_cur(cptr);
+				while (cn) {
+					if (cn->id == ecn->id)
+						return 1;
+					cn = clist_next(cptr);
 				}
-				if (found)
-					return found;
-				ecn = slist_next(ecptr);
+				ecn = clist_next(ecptr);
 			}
-			return found;
 		}
+		return 0;
 	}
-	return 0;
+	return 1;
 }
 
diff --git a/src/ausearch-options.c b/src/ausearch-options.c
index f4d0f308eddb..1536b5c7ab42 100644
--- a/src/ausearch-options.c
+++ b/src/ausearch-options.c
@@ -60,7 +60,7 @@ int event_syscall = -1, event_machine = -1;
 int event_ua = 0, event_ga = 0, event_se = 0;
 int just_one = 0;
 uint32_t event_session_id = -2;
-const char *event_contid = NULL;
+clist *event_contid = NULL;
 long long event_exit = 0;
 int event_exit_is_set = 0;
 int line_buffered = 0;
@@ -1201,6 +1201,7 @@ int check_params(int count, char *vars[])
 			size_t len = strlen(optarg);
 			if (isdigit(optarg[0])) {
 				__u64 contid;
+				cnode cn;
 
 				errno = 0;
 				contid = strtoull(optarg,NULL,0);
@@ -1211,21 +1212,21 @@ int check_params(int count, char *vars[])
 					retval = -1;
 				} else {
 					if (!event_contid) {
-						event_contid = malloc(sizeof(slist));
+						event_contid = malloc(sizeof(clist));
 						if (!event_contid) {
 							retval = -1;
 							break;
 						}
-						slist_create(event_contid);
+						clist_create(event_contid);
 					}
-					sn.str = strdup(optarg);
-					sn.key = NULL;
-					sn.hits = 0;
-					slist_append(event_contid, &sn);
+					cn.id = contid;
+					cn.hits = 0;
+					clist_append(event_contid, &cn);
 				}
 			} else if (len >= 2 && *(optarg)=='-' &&
 					(isdigit(optarg[1]))) {
 				__u64 contid;
+				cnode cn;
 
 				errno = 0;
 				contid = strtoll(optarg, NULL, 0);
@@ -1235,17 +1236,16 @@ int check_params(int count, char *vars[])
 						optarg);
 				} else {
 					if (!event_contid) {
-						event_contid = malloc(sizeof(slist));
+						event_contid = malloc(sizeof(clist));
 						if (!event_contid) {
 							retval = -1;
 							break;
 						}
-						slist_create(event_contid);
+						clist_create(event_contid);
 					}
-					sn.str = strdup(optarg);
-					sn.key = NULL;
-					sn.hits = 0;
-					slist_append(event_contid, &sn);
+					cn.id = contid;
+					cn.hits = 0;
+					clist_append(event_contid, &cn);
 				}
 			} else {
 				fprintf(stderr, 
diff --git a/src/ausearch-options.h b/src/ausearch-options.h
index a49d2400ff0d..ac4f97d00a83 100644
--- a/src/ausearch-options.h
+++ b/src/ausearch-options.h
@@ -29,6 +29,7 @@
 #include <stdint.h>
 #include "ausearch-common.h"
 #include "ausearch-int.h"
+#include "ausearch-contid.h"
 
 /* Global variables that describe what search is to be performed */
 extern const char *event_key;
@@ -40,7 +41,7 @@ extern int line_buffered;
 extern int event_debug;
 extern pid_t event_ppid;
 extern uint32_t event_session_id;
-extern const char *event_contid;
+extern clist *event_contid;
 extern ilist *event_type;
 
 /* Data type to govern output format */
diff --git a/src/ausearch-parse.c b/src/ausearch-parse.c
index 1b58bbc05a57..0949024e680f 100644
--- a/src/ausearch-parse.c
+++ b/src/ausearch-parse.c
@@ -81,10 +81,10 @@ static int audit_contid_init(search_items *s)
 {
 	if (s->contid == NULL) {
 		//create
-		s->contid = malloc(sizeof(slist));
+		s->contid = malloc(sizeof(clist));
 		if (s->contid == NULL)
 			return -1;
-		slist_create(s->contid);
+		clist_create(s->contid);
 	}
 	return 0;
 }
@@ -1471,24 +1471,8 @@ static int parse_container_op(const lnode *n, search_items *s)
 	// skip op
 	// skip opid
 	// get contid
-/*
-	if (event_contid != -1) {
-		str = strstr(term, "contid=");
-		if (str == NULL)
-			return 46;
-		ptr = str + 7;
-		term = strchr(ptr, ' ');
-		if (term == NULL)
-			return 47;
-		*term = 0;
-		errno = 0;
-		s->contid = strtoull(ptr, NULL, 10);
-		if (errno)
-			return 48;
-		*term = ' ';
- */
 	if (event_contid) {
-		snode sn;
+		cnode cn;
 		char *comma, *carrat;
 
 		str = strstr(term, "contid=");
@@ -1498,21 +1482,18 @@ static int parse_container_op(const lnode *n, search_items *s)
 			return 48;
 		str += 7;
 		term = strchr(str, ' ');
-		if (term == NULL)
+		if (!term)
 			return 47;
 		*term = 0;
-		sn.str = strdup(str);
-		sn.key = NULL;
-		sn.hits = 1;
-		slist_append(s->contid, &sn);
+		cn.id = strtoull(str, NULL, 10);
+		cn.hits = 1;
+		clist_append(s->contid, &cn);
 		if (term)
 			*term = ' ';
 	// old-contid
 		str = strstr(term, "old-contid=");
 		if (!str)
-			return 46;
-		if (audit_contid_init(s) < 0)
-			return 48;
+			return 49;
 		str += 11;
 		term = strchr(str, ' ');
 		if (term)
@@ -1525,11 +1506,9 @@ static int parse_container_op(const lnode *n, search_items *s)
 			if (carrat)
 				*carrat = 0;
 			do {
-				sn.str = strdup(str);
-				sn.key = NULL;
-				sn.hits = 1;
-				slist_append(s->contid, &sn);
-
+				cn.id = strtoull(str, NULL, 10);
+				cn.hits = 1;
+				clist_append(s->contid, &cn);
 				if (carrat) {
 					str = carrat + 1;
 					*carrat = '^';
@@ -1553,63 +1532,45 @@ static int parse_container_id(const lnode *n, search_items *s)
 	char *ptr, *str, *term = n->message;
 
 	// get contid
-/*
-	if (event_contid != -1) {
+	if (event_contid) {
+		cnode cn;
+		char *comma, *carrat;
+
 		str = strstr(term, "contid=");
-		if (str == NULL)
-			return 49;
-		ptr = str + 7;
-		term = strchr(ptr, ' ');
-		if (term)
+		if (!str)
 			return 50;
-		*term = 0;
-		errno = 0;
-		s->contid = strtoull(ptr, NULL, 10);
-		if (errno)
+		if (audit_contid_init(s) < 0)
 			return 51;
-		*term = ' ';
- */
-	if (event_contid) {
-		str = strstr(term, "contid=");
-		if (str) {
-			snode sn;
-			char *comma, *carrat;
-
-			if (audit_contid_init(s) < 0)
-				return 50;
-			str += 7;
-			term = strchr(str, ' ');
-			if (term)
-				*term = 0;
-			comma = strchr(str, ',');
-			if (comma)
-				*comma = 0;
+		str += 7;
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
 			do {
-				carrat = strchr(str, '^');
-				if (carrat)
-					*carrat = 0;
-				do {
-					sn.str = strdup(str);
-					sn.key = NULL;
-					sn.hits = 1;
-					slist_append(s->contid, &sn);
+				cn.id = strtoull(str, NULL, 10);
+				cn.hits = 1;
+				clist_append(s->contid, &cn);
 
-					if (carrat) {
-						str = carrat + 1;
-						*carrat = '^';
-						carrat = strchr(str, '^');
-					}
-				} while (carrat);
-				if (comma) {
-					str = comma + 1;
-					*comma = ',';
-					comma = strchr(str, ',');
+				if (carrat) {
+					str = carrat + 1;
+					*carrat = '^';
+					carrat = strchr(str, '^');
 				}
-			} while (comma);
-			if (term)
-				*term = ' ';
-		} else
-			return 49;
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
 	return 0;
 }
-- 
1.8.3.1

