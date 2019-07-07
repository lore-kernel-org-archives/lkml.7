Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CA7C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619A220659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGGTiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 15:38:24 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:56956 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727485AbfGGTiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 15:38:03 -0400
Received: from 94.197.121.43.threembb.co.uk ([94.197.121.43] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz2-0006dx-DF; Sun, 07 Jul 2019 20:38:00 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hkCz0-0005Y2-Td; Sun, 07 Jul 2019 20:37:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>, "NeilBrown" <neilb@suse.de>
Date:   Sun, 07 Jul 2019 17:54:17 +0100
Message-ID: <lsq.1562518457.895426084@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 022/129] security/selinux: pass 'flags' arg to
 avc_audit() and avc_has_perm_flags()
In-Reply-To: <lsq.1562518456.876074874@decadent.org.uk>
X-SA-Exim-Connect-IP: 94.197.121.43
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.70-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neilb@suse.de>

commit 7b20ea2579238f5e0da4bc93276c1b63c960c9ef upstream.

This allows MAY_NOT_BLOCK to be passed, in RCU-walk mode, through
the new avc_has_perm_flags() to avc_audit() and thence the slow_avc_audit.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
[bwh: Backported to 3.16 as dependency of commit 3a28cff3bd4b
 "selinux: avoid silent denials in permissive mode under RCU walk"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 security/selinux/avc.c         | 18 +++++++++++++++++-
 security/selinux/hooks.c       |  2 +-
 security/selinux/include/avc.h |  9 +++++++--
 3 files changed, 25 insertions(+), 4 deletions(-)

--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -768,7 +768,23 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
 
 	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
 
-	rc2 = avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata);
+	rc2 = avc_audit(ssid, tsid, tclass, requested, &avd, rc, auditdata, 0);
+	if (rc2)
+		return rc2;
+	return rc;
+}
+
+int avc_has_perm_flags(u32 ssid, u32 tsid, u16 tclass,
+		       u32 requested, struct common_audit_data *auditdata,
+		       int flags)
+{
+	struct av_decision avd;
+	int rc, rc2;
+
+	rc = avc_has_perm_noaudit(ssid, tsid, tclass, requested, 0, &avd);
+
+	rc2 = avc_audit(ssid, tsid, tclass, requested, &avd, rc,
+			auditdata, flags);
 	if (rc2)
 		return rc2;
 	return rc;
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1569,7 +1569,7 @@ static int cred_has_capability(const str
 
 	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
 	if (audit == SECURITY_CAP_AUDIT) {
-		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
+		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad, 0);
 		if (rc2)
 			return rc2;
 	}
--- a/security/selinux/include/avc.h
+++ b/security/selinux/include/avc.h
@@ -130,7 +130,8 @@ static inline int avc_audit(u32 ssid, u3
 			    u16 tclass, u32 requested,
 			    struct av_decision *avd,
 			    int result,
-			    struct common_audit_data *a)
+			    struct common_audit_data *a,
+			    int flags)
 {
 	u32 audited, denied;
 	audited = avc_audit_required(requested, avd, result, 0, &denied);
@@ -138,7 +139,7 @@ static inline int avc_audit(u32 ssid, u3
 		return 0;
 	return slow_avc_audit(ssid, tsid, tclass,
 			      requested, audited, denied, result,
-			      a, 0);
+			      a, flags);
 }
 
 #define AVC_STRICT 1 /* Ignore permissive mode. */
@@ -150,6 +151,10 @@ int avc_has_perm_noaudit(u32 ssid, u32 t
 int avc_has_perm(u32 ssid, u32 tsid,
 		 u16 tclass, u32 requested,
 		 struct common_audit_data *auditdata);
+int avc_has_perm_flags(u32 ssid, u32 tsid,
+		       u16 tclass, u32 requested,
+		       struct common_audit_data *auditdata,
+		       int flags);
 
 u32 avc_policy_seqno(void);
 

