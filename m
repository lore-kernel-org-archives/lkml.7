Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93877C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B45621874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 15:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbfCUPMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 11:12:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:56032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbfCUPMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 11:12:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 68874AEE6;
        Thu, 21 Mar 2019 15:12:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6A0161E0CE4; Thu, 21 Mar 2019 16:12:00 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Orion Poplawski <orion@nwra.com>,
        Vivek Trivedi <t.vivek@samsung.com>,
        Amir Goldstein <amir73il@gmail.com>,
        <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] fanotify: Make wait for permission events interruptible
Date:   Thu, 21 Mar 2019 16:11:42 +0100
Message-Id: <20190321151142.17104-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch waiting for response to fanotify permission events interruptible.
This allows e.g. the system to be suspended while there are some
fanotify permission events pending (which is reportedly pretty common
when for example AV solution is in use). However just making the wait
interruptible can result in e.g. open(2) returning -EINTR where
previously such error code never happened in practice. To avoid
confusion of userspace due to this error code, return -ERESTARTNOINTR
instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

Orion, can you give this patch some testing with your usecase? Also if anybody
sees any issue with returning -ERESTARTNOINTR I have missed, please speak up.

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..eb790853844b 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -92,10 +92,17 @@ static int fanotify_get_response(struct fsnotify_group *group,
 
 	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
 
-	ret = wait_event_killable(group->fanotify_data.access_waitq,
-				  event->state == FAN_EVENT_ANSWERED);
+	ret = wait_event_interruptible(group->fanotify_data.access_waitq,
+				       event->state == FAN_EVENT_ANSWERED);
 	/* Signal pending? */
 	if (ret < 0) {
+		/*
+		 * Force restarting a syscall so that this is mostly invisible
+		 * for userspace which is not prepared for handling EINTR e.g.
+		 * from open(2).
+		 */
+		if (ret == -ERESTARTSYS)
+			ret = -ERESTARTNOINTR;
 		spin_lock(&group->notification_lock);
 		/* Event reported to userspace and no answer yet? */
 		if (event->state == FAN_EVENT_REPORTED) {
-- 
2.16.4

