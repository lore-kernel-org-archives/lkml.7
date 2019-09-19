Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC20CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA9E420644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbfISB2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:28:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfISB2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:28:49 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7FE9A86679;
        Thu, 19 Sep 2019 01:28:49 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0F7D5D9CC;
        Thu, 19 Sep 2019 01:28:41 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v7 05/12] start normalization containerid support
Date:   Wed, 18 Sep 2019 21:27:45 -0400
Message-Id: <1568856472-10173-6-git-send-email-rgb@redhat.com>
In-Reply-To: <1568856472-10173-1-git-send-email-rgb@redhat.com>
References: <1568856472-10173-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 19 Sep 2019 01:28:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 auparse/auparse-defs.h           |  3 ++-
 auparse/interpret.c              | 10 ++++++++++
 auparse/normalize_record_map.h   |  2 ++
 auparse/typetab.h                |  2 ++
 bindings/python/auparse_python.c |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/auparse/auparse-defs.h b/auparse/auparse-defs.h
index 27bfa943612c..a9b144df3462 100644
--- a/auparse/auparse-defs.h
+++ b/auparse/auparse-defs.h
@@ -87,7 +87,8 @@ typedef enum {  AUPARSE_TYPE_UNCLASSIFIED,  AUPARSE_TYPE_UID, AUPARSE_TYPE_GID,
 	AUPARSE_TYPE_PROCTITLE, AUPARSE_TYPE_HOOK,
 	AUPARSE_TYPE_NETACTION, AUPARSE_TYPE_MACPROTO,
 	AUPARSE_TYPE_IOCTL_REQ, AUPARSE_TYPE_ESCAPED_KEY,
-	AUPARSE_TYPE_ESCAPED_FILE, AUPARSE_TYPE_FANOTIFY } auparse_type_t;
+	AUPARSE_TYPE_ESCAPED_FILE, AUPARSE_TYPE_FANOTIFY, AUPARSE_TYPE_CONTID
+} auparse_type_t;
 
 /* This type determines what escaping if any gets applied to interpreted fields */
 typedef enum { AUPARSE_ESC_RAW, AUPARSE_ESC_TTY, AUPARSE_ESC_SHELL,
diff --git a/auparse/interpret.c b/auparse/interpret.c
index 42014ee4ddea..e251384136bc 100644
--- a/auparse/interpret.c
+++ b/auparse/interpret.c
@@ -2842,6 +2842,13 @@ static const char *print_seccomp_code(const char *val)
 	return out;
 }
 
+static const char *print_contid(const char *val)
+{
+	if (strcmp(val, "18446744073709551615") == 0)
+		return strdup("unset");
+	return strdup(val);
+}
+
 int lookup_type(const char *name)
 {
 	int i;
@@ -3082,6 +3089,9 @@ unknown:
 		case AUPARSE_TYPE_FANOTIFY:
 			out = print_fanotify(id->val);
 			break;
+		case AUPARSE_TYPE_CONTID:
+			out = print_contid(id->val);
+			break;
 		case AUPARSE_TYPE_MAC_LABEL:
 		case AUPARSE_TYPE_UNCLASSIFIED:
 		default:
diff --git a/auparse/normalize_record_map.h b/auparse/normalize_record_map.h
index fee778e76db7..7332249c7b34 100644
--- a/auparse/normalize_record_map.h
+++ b/auparse/normalize_record_map.h
@@ -25,6 +25,7 @@
 
 _S(AUDIT_USER, "sent-message")
 _S(AUDIT_LOGIN, "changed-login-id-to")
+_S(AUDIT_CONTAINER_OP, "changed-container-id-to")
 _S(AUDIT_USER_AUTH, "authenticated")
 _S(AUDIT_USER_ACCT, "was-authorized")
 _S(AUDIT_USER_MGMT, "modified-user-account")
@@ -84,6 +85,7 @@ _S(AUDIT_FEATURE_CHANGE, "changed-audit-feature")
 //_S(AUDIT_REPLACE,"")
 _S(AUDIT_KERN_MODULE, "loaded-kernel-module")
 _S(AUDIT_FANOTIFY, "accessed-policy-controlled-file")
+_S(AUDIT_CONTAINER_ID, "has-container-id")
 _S(AUDIT_AVC, "accessed-mac-policy-controlled-object")
 _S(AUDIT_MAC_POLICY_LOAD, "loaded-selinux-policy")
 _S(AUDIT_MAC_STATUS, "changed-selinux-enforcement-to")
diff --git a/auparse/typetab.h b/auparse/typetab.h
index 0391e87f731c..0c160bb56c3b 100644
--- a/auparse/typetab.h
+++ b/auparse/typetab.h
@@ -142,3 +142,5 @@ _S(AUPARSE_TYPE_IOCTL_REQ,	"ioctlcmd"	)
 _S(AUPARSE_TYPE_FANOTIFY,	"resp"		)
 _S(AUPARSE_TYPE_ESCAPED,	"sw"		)
 _S(AUPARSE_TYPE_ESCAPED,	"root_dir"	)
+_S(AUPARSE_TYPE_CONTID,		"contid"	)
+_S(AUPARSE_TYPE_CONTID,		"old-contid"	)
diff --git a/bindings/python/auparse_python.c b/bindings/python/auparse_python.c
index 0099ca2ceb82..9f53b6d373a1 100644
--- a/bindings/python/auparse_python.c
+++ b/bindings/python/auparse_python.c
@@ -2391,6 +2391,7 @@ initauparse(void)
     PyModule_AddIntConstant(m, "AUPARSE_ESC_TTY", AUPARSE_ESC_TTY);
     PyModule_AddIntConstant(m, "AUPARSE_ESC_SHELL", AUPARSE_ESC_SHELL);
     PyModule_AddIntConstant(m, "AUPARSE_ESC_SHELL_QUOTE", AUPARSE_ESC_SHELL_QUOTE);
+    PyModule_AddIntConstant(m, "AUPARSE_TYPE_CONTID", AUPARSE_TYPE_CONTID);
 
 #ifdef IS_PY3K
     return m;
-- 
1.8.3.1

