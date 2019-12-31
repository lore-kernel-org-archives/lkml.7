Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDEAC2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA6F206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctXdN1DF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfLaT7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727075AbfLaT7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Qvklenbh17MP0CWLP3lwkt3MDXrP392oXp8eBxrl3ok=;
        b=ctXdN1DFq0rn4BtAKnEGG3KbsktexinrSVXNMoxMQ+/lzmG6e2W4YJ1nL+Prn/S1MUq42C
        17btNubCip01rxYnEIv14uEDEPFp3zqDB/UqUPMLjrbJeuSIw3nvoeP8LtiwwD6xTTy8rQ
        F6t5rAHYoix46l9le/MMh5KELKUhGQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-8CcEYYoDOru9036_hnhXcg-1; Tue, 31 Dec 2019 14:59:02 -0500
X-MC-Unique: 8CcEYYoDOru9036_hnhXcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BCD6800D48;
        Tue, 31 Dec 2019 19:59:01 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0E4460BEC;
        Tue, 31 Dec 2019 19:58:58 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 02/14] AUDIT_CONTAINER_ID message type basic support
Date:   Tue, 31 Dec 2019 14:58:09 -0500
Message-Id: <1577822301-19760-3-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index a5fef424d3ae..ee56e7c158c7 100644
--- a/lib/libaudit.h
+++ b/lib/libaudit.h
@@ -298,6 +298,10 @@ extern "C" {
 #define AUDIT_BPF		1334 /* BPF load/unload */
 #endif
 
+#ifndef AUDIT_CONTAINER_ID
+#define AUDIT_CONTAINER_ID	1335 /* Container ID */
+#endif
+
 #ifndef AUDIT_MAC_CALIPSO_ADD
 #define AUDIT_MAC_CALIPSO_ADD	1418 /* NetLabel: add CALIPSO DOI entry */
 #endif
diff --git a/lib/msg_typetab.h b/lib/msg_typetab.h
index 56c5bb18f706..a11f761e8990 100644
--- a/lib/msg_typetab.h
+++ b/lib/msg_typetab.h
@@ -127,6 +127,7 @@ _S(AUDIT_FANOTIFY,                   "FANOTIFY"                      )
 _S(AUDIT_TIME_INJOFFSET,             "TIME_INJOFFSET"                )
 _S(AUDIT_TIME_ADJNTPVAL,             "TIME_ADJNTPVAL"                )
 _S(AUDIT_BPF,                        "BPF"                           )
+_S(AUDIT_CONTAINER_ID,               "CONTAINER_ID"                  )
 _S(AUDIT_AVC,                        "AVC"                           )
 _S(AUDIT_SELINUX_ERR,                "SELINUX_ERR"                   )
 _S(AUDIT_AVC_PATH,                   "AVC_PATH"                      )
-- 
1.8.3.1

