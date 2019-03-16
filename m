Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AEEC10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C89218D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 12:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCPMK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 08:10:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfCPMK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 08:10:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8FACFC049D67;
        Sat, 16 Mar 2019 12:10:57 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-22.phx2.redhat.com [10.3.112.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B8255D6B3;
        Sat, 16 Mar 2019 12:10:50 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, eparis@parisplace.org, serge@hallyn.com,
        zohar@linux.ibm.com, mjg59@google.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak109 V1] audit: link integrity evm_write_xattrs record to syscall event
Date:   Sat, 16 Mar 2019 08:10:08 -0400
Message-Id: <81d0122d14c4fbb3a2ad33d25fdf2dd001c7dcc7.1552737854.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sat, 16 Mar 2019 12:10:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fa516b66a1bf ("EVM: Allow runtime modification of the set of
verified xattrs"), the call to audit_log_start() is missing a context to
link it to an audit event. Since this event is in user context, add
the process' syscall context to the record.

In addition, the orphaned keyword "locked" appears in the record.
Normalize this by changing it to "xattr=(locked)".

Please see the github issue
https://github.com/linux-audit/audit-kernel/issues/109

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 security/integrity/evm/evm_secfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
index 015aea8fdf1e..4171d174e9da 100644
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
 
@@ -222,7 +223,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
 		inode_lock(inode);
 		err = simple_setattr(evm_xattrs, &newattrs);
 		inode_unlock(inode);
-		audit_log_format(ab, "locked");
+		audit_log_format(ab, "xattr=(locked)");
 		if (!err)
 			err = count;
 		goto out;
-- 
1.8.3.1

