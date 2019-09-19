Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE319C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD78F20644
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 01:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfISB26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 21:28:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387553AbfISB24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 21:28:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7E993DE31;
        Thu, 19 Sep 2019 01:28:55 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-19.phx2.redhat.com [10.3.112.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E26D5D9CC;
        Thu, 19 Sep 2019 01:28:52 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     eparis@parisplace.org, Steve Grubb <sgrubb@redhat.com>,
        omosnace@redhat.com, Paul Moore <paul@paul-moore.com>,
        nhorman@redhat.com, dwalsh@redhat.com, mpatel@redhat.com,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghau51/ghau40 v7 07/12] signal_info: only print context if it is available.
Date:   Wed, 18 Sep 2019 21:27:47 -0400
Message-Id: <1568856472-10173-8-git-send-email-rgb@redhat.com>
In-Reply-To: <1568856472-10173-1-git-send-email-rgb@redhat.com>
References: <1568856472-10173-1-git-send-email-rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 19 Sep 2019 01:28:55 +0000 (UTC)
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
index 1c93173fb30e..45f12fb31f01 100644
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

