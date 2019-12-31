Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD26C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9772C2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkoD++QM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfLaT7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:54 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56790 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727275AbfLaT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DTC/ogIRMHiyfR0MfjZDkZTau54M1IXyDoVX0amxuUA=;
        b=FkoD++QMcY/mMrffCBTBqo9tTBJCsB8W5+2BZ4zQ/prXI9u7VTqSQl7fyAKit4Vz8KRBoM
        VgzvMXHT4hnlRk5YebtbIdQ3rWNv7N7odtNOt5IkgVdRJu0JHgfDH9gT813pPPk6HiKZht
        FiIEvghOzW6tZ6MglofeZ3zZr1uyV7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-nJ1siW9eN32JbfOmJ5VsoA-1; Tue, 31 Dec 2019 14:59:48 -0500
X-MC-Unique: nJ1siW9eN32JbfOmJ5VsoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CBBC107ACCC;
        Tue, 31 Dec 2019 19:59:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24B6760BEC;
        Tue, 31 Dec 2019 19:59:41 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 12/14] auditctl: add a config parameter to limit the contid nesting depth
Date:   Tue, 31 Dec 2019 14:58:19 -0500
Message-Id: <1577822301-19760-13-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the auditctl option "--contid-depth-limit" that takes one
argument.

Please see kernel patch ("audit: check contid depth and add limit config
param").

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 configure.ac                        |  1 +
 docs/Makefile.am                    |  2 +-
 docs/audit_set_contid_depth_limit.3 | 26 ++++++++++++++++++++++++++
 docs/auditctl.8                     |  3 +++
 lib/libaudit.c                      | 21 +++++++++++++++++++++
 lib/libaudit.h                      |  1 +
 src/auditctl-listing.c              |  4 ++++
 src/auditctl.c                      | 33 +++++++++++++++++++++++++++++++++
 8 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 docs/audit_set_contid_depth_limit.3

diff --git a/configure.ac b/configure.ac
index a9cad7ff8985..bb73d5631e62 100644
--- a/configure.ac
+++ b/configure.ac
@@ -67,6 +67,7 @@ AC_CHECK_DECLS([AUDIT_FEATURE_VERSION], [], [], [[#include <linux/audit.h>]])
 AC_CHECK_MEMBERS([struct audit_status.feature_bitmap], [], [], [[#include <linux/audit.h>]])
 AC_CHECK_DECLS([AUDIT_VERSION_BACKLOG_WAIT_TIME], [], [], [[#include <linux/audit.h>]])
 AC_CHECK_DECLS([AUDIT_STATUS_BACKLOG_WAIT_TIME], [], [], [[#include <linux/audit.h>]])
+AC_CHECK_DECLS([AUDIT_STATUS_CONTID_DEPTH_LIMIT], [], [], [[#include <linux/audit.h>]])
 AC_CHECK_DECLS([ADDR_NO_RANDOMIZE],,, [#include <sys/personality.h>])
 dnl; posix_fallocate is used in audisp-remote
 AC_CHECK_FUNCS([posix_fallocate])
diff --git a/docs/Makefile.am b/docs/Makefile.am
index 209789bb2051..fc386d4155c2 100644
--- a/docs/Makefile.am
+++ b/docs/Makefile.am
@@ -60,6 +60,6 @@ ausearch_add_timestamp_item_ex.3 ausearch_clear.3 \
 ausearch_next_event.3 ausearch_set_stop.3 \
 autrace.8 get_auditfail_action.3 set_aumessage_mode.3 \
 audispd-zos-remote.8 libaudit.conf.5 \
-augenrules.8 audit_set_backlog_wait_time.3 \
+augenrules.8 audit_set_backlog_wait_time.3 audit_set_contid_depth_limit.3 \
 zos-remote.conf.5 
 
diff --git a/docs/audit_set_contid_depth_limit.3 b/docs/audit_set_contid_depth_limit.3
new file mode 100644
index 000000000000..7be7f9fbcdd2
--- /dev/null
+++ b/docs/audit_set_contid_depth_limit.3
@@ -0,0 +1,26 @@
+.TH "AUDIT_SET_CONTID_DEPTH_LIMIT" "9" "Dec 2019" "Linux Audit API"
+.SH NAME
+audit_set_contid_depth_limit \- Set the audit container identifier nesting depth limit
+.SH "SYNOPSIS"
+
+.B #include <libaudit.h>
+.sp
+int audit_set_contid_depth_limit (int fd, int limit);
+
+.SH "DESCRIPTION"
+
+audit_set_contid_depth_limit sets the audit container identifier nesting depth limit that the kernel will permit before preventing any further nesting.  This prevents the contid field in AUDIT_CONTAINER_OP and AUDIT_CONTAINER_ID messages from overflowing and limits the netlink and disk bandwidth these messages can use.  The default value is 4 in the kernel with a maximum of 20.  This parameter must be balanced with the maximum number of audit container identifiers used in any network namespace.  The two parameters multiplied cannot exceed 400.  If set to zero, there is no limit.
+
+
+.SH "RETURN VALUE"
+
+The return value is <= 0 on error, otherwise it is the netlink sequence id number. This function can have any error that sendto would encounter.
+
+.SH "SEE ALSO"
+
+.BR audit_open (3),
+.BR auditd (8),
+.BR auditctl (8).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/docs/auditctl.8 b/docs/auditctl.8
index daed435f03af..d5585192ed16 100644
--- a/docs/auditctl.8
+++ b/docs/auditctl.8
@@ -13,6 +13,9 @@ Set max number (limit) of outstanding audit buffers allowed (Kernel Default=64)
 .BI \-\-backlog_wait_time \ \fIwait_time\fP
 Set the time for the kernel to wait (Kernel Default 60*HZ) when the backlog limit is reached before queuing more audit events to be transferred to auditd. The number must be greater than or equal to zero and less that 10 times the default value.
 .TP
+.BI \-\-contid-depth-limit \ \fIlimit\fP
+Set the limit for the kernel container nesting depth (Kernel Default 4).  This prevents overflowing the contid field in CONTAINER_OP and CONTAINER_ID messages and limits netlink and disk bandwidth usage by those messages.  The default value is 4 in the kernel with a maximum of 20.  This parameter must be balanced with the maximum number of audit container identifiers used in any network namespace.  The two parameters multiplied cannot exceed 400.  If set to zero, there is no limit.
+.TP
 .B \-c
 Continue loading rules in spite of an error. This summarizes the results of loading the rules. The exit code will not be success if any rule fails to load.
 .TP
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 7737e7f7f30c..afc7dab599dc 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -539,6 +539,27 @@ int audit_reset_lost(int fd)
 	return rc;
 }
 
+int audit_set_contid_depth_limit(int fd, uint32_t limit)
+{
+	int rc = -1;
+#if HAVE_DECL_AUDIT_STATUS_CONTID_DEPTH_LIMIT == 1
+	struct audit_status s;
+
+	if ((audit_get_features() & AUDIT_FEATURE_BITMAP_CONTAINERID) == 0)
+		return -EAU_FIELDNOSUPPORT;
+
+	memset(&s, 0, sizeof(s));
+	s.mask = AUDIT_STATUS_CONTID_DEPTH_LIMIT;
+	s.contid_depth_limit = limit;
+	rc = audit_send(fd, AUDIT_SET, &s, sizeof(s));
+	if (rc < 0)
+		audit_msg(audit_priority(errno),
+			"Error sending contid depth limit request (%s)", 
+			strerror(-rc));
+#endif
+	return rc;
+}
+
 int audit_set_feature(int fd, unsigned feature, unsigned value, unsigned lock)
 {
 #if defined(HAVE_DECL_AUDIT_FEATURE_VERSION) && \
diff --git a/lib/libaudit.h b/lib/libaudit.h
index 7cbdf58166cd..9d2e3553649e 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -652,6 +652,7 @@ extern int  audit_set_rate_limit(int fd, uint32_t limit);
 extern int  audit_set_backlog_limit(int fd, uint32_t limit);
 int audit_set_backlog_wait_time(int fd, uint32_t bwt);
 int audit_reset_lost(int fd);
+extern int  audit_set_contid_depth_limit(int fd, uint32_t limit);
 extern int  audit_set_feature(int fd, unsigned feature, unsigned value, unsigned lock);
 extern int  audit_set_loginuid_immutable(int fd);
 
diff --git a/src/auditctl-listing.c b/src/auditctl-listing.c
index a62454f88b2c..7737001aa2c8 100644
--- a/src/auditctl-listing.c
+++ b/src/auditctl-listing.c
@@ -586,6 +586,10 @@ int audit_print_reply(struct audit_reply *rep, int fd)
 			printf("backlog_wait_time %u\n",
 				rep->status->backlog_wait_time);
 #endif
+#if HAVE_DECL_AUDIT_STATUS_CONTID_DEPTH_LIMIT == 1
+			printf("contid_depth_limit %u\n",
+				rep->status->contid_depth_limit);
+#endif
 			printed = 1;
 			break;
 #if defined(HAVE_DECL_AUDIT_FEATURE_VERSION) && \
diff --git a/src/auditctl.c b/src/auditctl.c
index 1150911e9591..b46f9772651e 100644
--- a/src/auditctl.c
+++ b/src/auditctl.c
@@ -144,6 +144,9 @@ static void usage(void)
 #if defined(HAVE_STRUCT_AUDIT_STATUS_FEATURE_BITMAP)
      "    --reset-lost         Reset the lost record counter\n"
 #endif
+#if HAVE_DECL_AUDIT_STATUS_CONTID_DEPTH_LIMIT
+     "    --contid-depth-limit Set the kernel audit container identifier depth limit\n"
+#endif
      );
 }
 
@@ -458,6 +461,9 @@ struct option long_opts[] =
 #if defined(HAVE_STRUCT_AUDIT_STATUS_FEATURE_BITMAP)
   {"reset-lost", 0, NULL, 3},
 #endif
+#if HAVE_DECL_AUDIT_STATUS_CONTID_DEPTH_LIMIT == 1
+  {"contid-depth-limit", 1, NULL, 4},
+#endif
   {NULL, 0, NULL, 0}
 };
 
@@ -1007,6 +1013,33 @@ process_keys:
 			retval = -1;
 		}
 		break;
+	case 4:
+#if HAVE_DECL_AUDIT_STATUS_CONTID_DEPTH_LIMIT == 1
+		if (optarg && isdigit(optarg[0])) {
+			uint32_t limit;
+			errno = 0;
+			limit = strtoul(optarg,NULL,0);
+			if (errno) {
+				audit_msg(LOG_ERR,
+					"Error converting contid-depth-limit");
+				return -1;
+			}
+			if (audit_set_contid_depth_limit(fd, limit) > 0)
+				audit_request_status(fd);
+			else
+				return -1;
+		} else {
+			audit_msg(LOG_ERR, 
+			    "contid-depth-limit must be a numeric value was %s", 
+				optarg);
+			retval = -1;
+		}
+#else
+		audit_msg(LOG_ERR,
+			"contid-depth-limit is not supported on your kernel");
+		retval = -1;
+#endif
+		break;
         default: 
 		usage();
 		retval = -1;
-- 
1.8.3.1

