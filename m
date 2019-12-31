Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36592C2D0DC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101CD206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVpqG+Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfLaT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 14:59:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727075AbfLaT72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 14:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577822368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=JgnvP58fakJMjNBulRLYVIko4BxwquFEkvi5MfZ17iI=;
        b=CVpqG+ZpAfMxT5iYDKdFvAyhh+j1PGepoZzd0hyC2zwK8xJqPBAs2114dUJ+9XxxneabQQ
        105pEdVkAfNpzmNGo09B5GBFjT9LyD7YHmoDcEgIf9YaHykOHQZ2ThvL16vxIymx8lqi21
        cn0A7ZUdio0eEOzAp5IYOJ+Pve/0Ltk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-s-tAyMPJOx6J-L8_xdalIg-1; Tue, 31 Dec 2019 14:59:26 -0500
X-MC-Unique: s-tAyMPJOx6J-L8_xdalIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0467218031D5;
        Tue, 31 Dec 2019 19:59:25 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-15.phx2.redhat.com [10.3.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F22B60BEC;
        Tue, 31 Dec 2019 19:59:22 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v8 07/14] signal_info: only print context if it is available.
Date:   Tue, 31 Dec 2019 14:58:14 -0500
Message-Id: <1577822301-19760-8-git-send-email-rgb@redhat.com>
In-Reply-To: <1577822301-19760-1-git-send-email-rgb@redhat.com>
References: <1577822301-19760-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 src/auditd-event.c    | 20 +++++++++++++++-----
 src/auditd-reconfig.c |  2 --
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/auditd-event.c b/src/auditd-event.c
index 68eacd5cb028..85b647014154 100644
--- a/src/auditd-event.c
+++ b/src/auditd-event.c
@@ -1323,13 +1323,16 @@ static void reconfigure(struct auditd_event *e)
 	const char *ctx = nconf->sender_ctx;
 	struct timeval tv;
 	char txt[MAX_AUDIT_MESSAGE_LENGTH];
+	int txt_len;
 	char date[40];
 	unsigned int seq_num;
 	int need_size_check = 0, need_reopen = 0, need_space_check = 0;
 
-	snprintf(txt, sizeof(txt),
-		"config change requested by pid=%d auid=%u subj=%s",
-		pid, uid, ctx);
+	txt_len = snprintf(txt, sizeof(txt),
+		"config change requested by pid=%d auid=%u", pid, uid);
+	if (ctx)
+		snprintf(txt + txt_len, sizeof(txt) - txt_len,
+			 " subj=%s", ctx);
 	audit_msg(LOG_NOTICE, "%s", txt);
 
 	/* Do the reconfiguring. These are done in a specific
@@ -1578,8 +1581,15 @@ static void reconfigure(struct auditd_event *e)
 
 	e->reply.type = AUDIT_DAEMON_CONFIG;
 	e->reply.len = snprintf(e->reply.msg.data, MAX_AUDIT_MESSAGE_LENGTH-2, 
-	"%s: op=reconfigure state=changed auid=%u pid=%d subj=%s res=success",
-		date, uid, pid, ctx );
+				"%s: op=reconfigure state=changed auid=%u pid=%d",
+				date, uid, pid);
+	if (ctx)
+		e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
+					 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len,
+					 " subj=%s", ctx);
+	e->reply.len += snprintf(e->reply.msg.data + e->reply.len,
+				 MAX_AUDIT_MESSAGE_LENGTH-2 - e->reply.len, 
+				 " res=success");
 	e->reply.message = e->reply.msg.data;
 	free((char *)ctx);
 }
diff --git a/src/auditd-reconfig.c b/src/auditd-reconfig.c
index f5b00e6d1dc7..1af402526c4e 100644
--- a/src/auditd-reconfig.c
+++ b/src/auditd-reconfig.c
@@ -106,8 +106,6 @@ static void *config_thread_main(void *arg)
 		if (e->reply.len > 24)
 			new_config.sender_ctx = 
 				strdup(e->reply.signal_info->ctx);
-		else
-			new_config.sender_ctx = strdup("?"); 
 		memcpy(e->reply.msg.data, &new_config, sizeof(new_config));
 		e->reply.conf = (struct daemon_conf *)e->reply.msg.data;
 		e->reply.type = AUDIT_DAEMON_RECONFIG;
-- 
1.8.3.1

