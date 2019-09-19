Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83778C4CEC9
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F9620644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbfISB2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:28:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfISB2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:28:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC5578AC6F9;
        Thu, 19 Sep 2019 01:28:34 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34B625D9CC;
        Thu, 19 Sep 2019 01:28:32 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v7 02/12] AUDIT_CONTAINER_ID message type basic support
Date:   Wed, 18 Sep 2019 21:27:42 -0400
Message-Id: <1568856472-10173-3-git-send-email-rgb@redhat.com>
In-Reply-To: <1568856472-10173-1-git-send-email-rgb@redhat.com>
References: <1568856472-10173-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Thu, 19 Sep 2019 01:28:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This defines the message number for the audit container identifier
information record should the kernel headers not be up to date and gives
the record number a name for printing.

See: https://github.com/linux-audit/audit-userspace/issues/51
See: https://github.com/linux-audit/audit-kernel/issues/90
See: https://github.com/linux-audit/audit-testsuite/issues/64
See: https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Container-ID
Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 lib/libaudit.h    | 4 ++++
 lib/msg_typetab.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/lib/libaudit.h b/lib/libaudit.h
index 06d2e59c55aa..077847587dca 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -294,6 +294,10 @@ extern "C" {
 #define AUDIT_TIME_ADJNTPVAL	1333 /* NTP value adjustment */
 #endif
 
+#ifndef AUDIT_CONTAINER_ID
+#define AUDIT_CONTAINER_ID	1334 /* Container ID */
+#endif
+
 #ifndef AUDIT_MAC_CALIPSO_ADD
 #define AUDIT_MAC_CALIPSO_ADD	1418 /* NetLabel: add CALIPSO DOI entry */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 00cb5c134bf6..54fca1193a30 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -126,6 +126,7 @@ _S(AUDIT_KERN_MODULE,                "KERN_MODULE"                   )
 _S(AUDIT_FANOTIFY,                   "FANOTIFY"                      )
 _S(AUDIT_TIME_INJOFFSET,             "TIME_INJOFFSET"                )
 _S(AUDIT_TIME_ADJNTPVAL,             "TIME_ADJNTPVAL"                )
+_S(AUDIT_CONTAINER_ID,               "CONTAINER_ID"                  )
 _S(AUDIT_AVC,                        "AVC"                           )
 _S(AUDIT_SELINUX_ERR,                "SELINUX_ERR"                   )
 _S(AUDIT_AVC_PATH,                   "AVC_PATH"                      )
-- 
1.8.3.1

