Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57529C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36250206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732659AbfCZStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46730 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731467AbfCZStw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 621073086201;
        Tue, 26 Mar 2019 18:49:52 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8A4E65C226;
        Tue, 26 Mar 2019 18:49:44 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org, serge@hallyn.com,
        zohar@linux.ibm.com, mjg59@google.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak109 V2] audit: link integrity evm_write_xattrs record to syscall event
Date:   Tue, 26 Mar 2019 14:49:20 -0400
Message-Id: <087489b21e50bcda65c6af3e038394d5bfe09e00.1553626080.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 26 Mar 2019 18:49:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
verified xattrs"), the call to audit_log_start() is missing a context to
link it to an audit event. Since this event is in user context, add
the process' syscall context to the record.

In addition, the orphaned keyword "locked" appears in the record.
Normalize this by changing it to logging the locking string "." as any
other user input in the "xattr=" field.

Please see the github issue
https://github.com/linux-audit/audit-kernel/issues/109

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Changelog:
v2
- switch from "(locked)" to printing the "." verbatim, untrusted.

 security/integrity/evm/evm_secfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 015aea8fdf1e..3f7cbb238923 100644
--- a/security/integrity/evm/evm_secfs.c
+++ b/security/integrity/evm/evm_secfs.c
@@ -192,7 +192,8 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 	if (count > XATTR_NAME_MAX)
 		return -E2BIG;
 
-	ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
+	ab = audit_log_start(audit_context(), GFP_KERNEL,
+			     AUDIT_INTEGRITY_EVM_XATTR);
 	if (!ab)
 		return -ENOMEM;
 
@@ -214,6 +215,9 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 	if (len && xattr->name[len-1] == '\n')
 		xattr->name[len-1] = '\0';
 
+	audit_log_format(ab, "xattr=");
+	audit_log_untrustedstring(ab, xattr->name);
+
 	if (strcmp(xattr->name, ".") == 0) {
 		evm_xattrs_locked = 1;
 		newattrs.ia_mode = S_IFREG | 0440;
@@ -222,15 +226,11 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		inode_lock(inode);
 		err = simple_setattr(evm_xattrs, &newattrs);
 		inode_unlock(inode);
-		audit_log_format(ab, "locked");
 		if (!err)
 			err = count;
 		goto out;
 	}
 
-	audit_log_format(ab, "xattr=");
-	audit_log_untrustedstring(ab, xattr->name);
-
 	if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
 		    XATTR_SECURITY_PREFIX_LEN) != 0) {
 		err = -EINVAL;
-- 
1.8.3.1

