Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4850C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5148206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0MA5gdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfLaT70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45017 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfLaT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=lzZzJOjhjgMD2g50QZ+FBomwZbu8Cm+TQ8Vx1Q+UcI0=;
        b=Q0MA5gdTY3hhu48TW5HpxCEmZjxA5bUnP0DpVdC1l5QCfKVx6OTquIYspcC/31O/gwxcg7
        +S+jqVkWYTB2dK1U2XdSv/fb/bsFLQ8b5C8GjsL6h8NbDmaL8CeIaOLkK4A8CxOEYO+N8n
        i0AiVIaw4DJ5312+okZ1QwinnyZY5GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-2w6vL4JoOkqIHHcsdLck3g-1; Tue, 31 Dec 2019 14:59:23 -0500
X-MC-Unique: 2w6vL4JoOkqIHHcsdLck3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6038DB24;
        Tue, 31 Dec 2019 19:59:21 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B30D60BEC;
        Tue, 31 Dec 2019 19:59:19 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 06/14] libaudit: add support to get the task audit container identifier
Date:   Tue, 31 Dec 2019 14:58:13 -0500
Message-Id: <1577822301-19760-7-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 000000000000..ef62a25db970
--- /dev/null
+++ b/docs/audit_get_containerid.3
@@ -0,0 +1,25 @@
+.TH "AUDIT_GET_CONTAINERID" "3" "Feb 2018" "Red Hat" "Linux Audit API"
+.SH NAME
+audit_get_containerid \- Get a program's container id value
+.SH SYNOPSIS
+.B #include <libaudit.h>
+.sp
+uin64_t audit_get_containerid(void);
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
+This function returns \-2 on failure. Additionally, in the event of a real error, errno would be set. The function can set errno based on failures of open, read, or strtoull.
+
+.SH "SEE ALSO"
+
+.BR audit_getloginuid (3).
+
+.SH AUTHOR
+Richard Guy Briggs
diff --git a/lib/libaudit.c b/lib/libaudit.c
index 0d03cca18aa8..a8c321cb3c86 100644
--- a/lib/libaudit.c
+++ b/lib/libaudit.c
@@ -944,6 +944,35 @@ uint32_t audit_get_session(void)
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
index 77ce494f79fb..5076be0f92e5 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -593,6 +593,7 @@ extern int  audit_get_reply(int fd, struct audit_reply *rep, reply_t block,
 extern uid_t audit_getloginuid(void);
 extern int  audit_setloginuid(uid_t uid);
 extern uint32_t audit_get_session(void);
+extern uint64_t audit_get_containerid(void);
 extern int  audit_detect_machine(void);
 extern int audit_determine_machine(const char *arch);
 extern char *audit_format_signal_info(char *buf, int len, char *op, struct audit_reply *rep, char *res);
-- 
1.8.3.1

