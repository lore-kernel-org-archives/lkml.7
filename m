Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C7D9218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfCOShv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfCOSht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:37:49 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8244D3001244;
        Fri, 15 Mar 2019 18:37:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B9E35C28D;
        Fri, 15 Mar 2019 18:37:46 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v5 3/6] auditctl: add support for AUDIT_CONTID filter
Date:   Fri, 15 Mar 2019 14:37:04 -0400
Message-Id: <1552675027-11635-4-git-send-email-rgb@redhat.com>
In-Reply-To: <1552675027-11635-1-git-send-email-rgb@redhat.com>
References: <1552675027-11635-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 15 Mar 2019 18:37:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A u64 container identifier has been added to the kernel view of tasks.
This allows container orchestrators to label tasks with a unique
tamperproof identifier that gets inherited by its children to be able to
track the provenance of actions by a container.

Add support to libaudit and auditctl for the AUDIT_CONTID field to
filter based on audit container identifier.  This field is specified
with the "contid" field name on the command line.

Since it is a u64 and larger than any other numeric field, send it as a
string but do the appropriate conversions on each end in each direction.

See: https://github.com/linux-audit/audit-userspace/issues/40
See: https://github.com/linux-audit/audit-kernel/issues/91
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 docs/auditctl.8        |  3 +++
 lib/fieldtab.h         |  1 +
 lib/libaudit.c         | 36 ++++++++++++++++++++++++++++++++++++
 lib/libaudit.h         |  7 +++++++
 src/auditctl-listing.c | 21 +++++++++++++++++++++
 5 files changed, 68 insertions(+)

diff --git a/docs/auditctl.8 b/docs/auditctl.8
index 924884d67799..cb62ae4e7f02 100644
--- a/docs/auditctl.8
+++ b/docs/auditctl.8
@@ -210,6 +210,9 @@ Parent's Process ID
 .B sessionid
 User's login session ID
 .TP
+.B contid
+Process' audit container ID
+.TP
 .B subj_user
 Program's SE Linux User
 .TP
diff --git a/lib/fieldtab.h b/lib/fieldtab.h
index c425d5b86049..4224e60bb37b 100644
--- a/lib/fieldtab.h
+++ b/lib/fieldtab.h
@@ -47,6 +47,7 @@ _S(AUDIT_OBJ_TYPE,     "obj_type"     )
 _S(AUDIT_OBJ_LEV_LOW,  "obj_lev_low"  )
 _S(AUDIT_OBJ_LEV_HIGH, "obj_lev_high" )
 _S(AUDIT_SESSIONID,    "sessionid"    )
+_S(AUDIT_CONTID,       "contid"       )
 
 _S(AUDIT_DEVMAJOR,     "devmajor"     )
 _S(AUDIT_DEVMINOR,     "devminor"     )
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 393d5bcdc030..5df5ddf85430 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -1742,6 +1742,42 @@ int audit_rule_fieldpair_data(struct audit_rule_data **rulep, const char *pair,
 			else if (strcmp(v, "unset") == 0)
 				rule->values[rule->field_count] = UINT_MAX;
 			break;
+		case AUDIT_CONTID: {
+			unsigned long long val;
+
+			if ((audit_get_features() &
+				AUDIT_FEATURE_BITMAP_CONTAINERID) == 0)
+				return -EAU_FIELDNOSUPPORT;
+			if (flags != AUDIT_FILTER_EXCLUDE &&
+			    flags != AUDIT_FILTER_USER &&
+			    flags != AUDIT_FILTER_EXIT)
+				return -EAU_FIELDNOFILTER;
+			if (isdigit((char)*(v))) 
+				val = strtoull(v, NULL, 0);
+			else if (strlen(v) >= 2 && *(v)=='-' && 
+						(isdigit((char)*(v+1)))) 
+				val = strtoll(v, NULL, 0);
+			else if (strcmp(v, "unset") == 0)
+				val = ULLONG_MAX;
+			else
+				return -EAU_FIELDVALNUM;
+			if (errno)
+				return -EAU_FIELDVALNUM;
+			vlen = sizeof(unsigned long long);
+			rule->values[rule->field_count] = vlen;
+			offset = rule->buflen;
+			rule->buflen += vlen;
+			*rulep = realloc(rule, sizeof(*rule) + rule->buflen);
+			if (*rulep == NULL) {
+				free(rule);
+				audit_msg(LOG_ERR, "Cannot realloc memory!\n");
+				return -3;
+			} else {
+				rule = *rulep;
+			}
+			*(unsigned long long*)(&rule->buf[offset]) = val;
+			break;
+		}
 		case AUDIT_DEVMAJOR...AUDIT_INODE:
 		case AUDIT_SUCCESS:
 			if (flags != AUDIT_FILTER_EXIT)
diff --git a/lib/libaudit.h b/lib/libaudit.h
index b3ff8bdaa649..e7256a328c45 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -339,6 +339,9 @@ extern "C" {
 #ifndef AUDIT_FEATURE_BITMAP_FILTER_FS
 #define AUDIT_FEATURE_BITMAP_FILTER_FS		0x00000040
 #endif
+#ifndef AUDIT_FEATURE_BITMAP_CONTAINERID
+#define AUDIT_FEATURE_BITMAP_CONTAINERID	0x00000080
+#endif
 
 /* Defines for interfield comparison update */
 #ifndef AUDIT_OBJ_UID
@@ -362,6 +365,10 @@ extern "C" {
 #define AUDIT_FSTYPE 26
 #endif
 
+#ifndef AUDIT_CONTID
+#define AUDIT_CONTID 27
+#endif
+
 #ifndef AUDIT_COMPARE_UID_TO_OBJ_UID
 #define AUDIT_COMPARE_UID_TO_OBJ_UID   1
 #endif
diff --git a/src/auditctl-listing.c b/src/auditctl-listing.c
index f670ff9bd6e8..a62454f88b2c 100644
--- a/src/auditctl-listing.c
+++ b/src/auditctl-listing.c
@@ -25,6 +25,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <limits.h>
 #include "auditctl-listing.h"
 #include "private.h"
 #include "auditctl-llist.h"
@@ -460,6 +461,26 @@ static void print_rule(const struct audit_rule_data *r)
 						audit_operator_to_symbol(op),
 						audit_fstype_to_name(
 						r->values[i]));
+			} else if (field == AUDIT_CONTID) {
+				unsigned long long val;
+
+				if (r->values[i] == sizeof(unsigned long long)) {
+					val = *(unsigned long long*)(&r->buf[boffset]);
+
+					if (val != ULLONG_MAX)
+						printf(" -F %s%s%llu", name,
+							audit_operator_to_symbol(op),
+							val);
+					else
+						printf(" -F %s%s%s", name,
+							audit_operator_to_symbol(op),
+							"unset");
+				} else {
+					printf(" -F %s%s%s", name,
+						audit_operator_to_symbol(op),
+						"inval");
+				}
+				boffset += r->values[i];
 			} else {
 				// The default is signed decimal
 				printf(" -F %s%s%d", name, 
-- 
1.8.3.1

