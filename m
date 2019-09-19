Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A1C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1595C21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="XNpK6sD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388540AbfISJY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:24:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38758 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfISJY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:24:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id x10so1532913pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Em5t6EauVU0sVfuGE/WQJbJCwK78aKFv2CRbjaBHg78=;
        b=XNpK6sD84uDyGoEet5+aP4u5D9SrABBaNu7mQmk3wqDZyY2FJAvaYouW0RJze56+/4
         u2FyIWD/1woLw4N2C9dNvPlQ48PhVVf500U1a22LF2GTcNKLnJi2f3ecsGnXzAhmtyCw
         hvw1jwwwk5utSSiqmljGqb13mC8AVinOkPqjw4YXhTV2PmiUR9vPVOWt4OC7KIxKuxnS
         0Ioe2XbUDsHJNh0VpfDD+reFOwlzlM8rGrsbcOUwdHRnzEukOcjg+DblZL53IQQQ//0T
         8U7M0oYqDjIUGJ8aC9sHPNlQXvcddu+csaRHrs0PT/LqK0eOOl57h3k7aRoWIK97sbaD
         IXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Em5t6EauVU0sVfuGE/WQJbJCwK78aKFv2CRbjaBHg78=;
        b=C1NzvfZB6Uk6ix0dWcrD8NjhvJBsMtYCqllt4zRU16XpJbgooZOAUgZPegF+SkMxXB
         9KADggrXuVHuyY7inJAd3OhaZwXJPvEaOTWXrpaecN+K+85uuR8zNTbEXtzUDpwMoyPh
         PW9jiCGuCNXKw8Ao2YNoNQoYJeIy2dErQWJjOa00L2x8k1mhMi3FUq5INYBO0rQL72xb
         bkihTkyErflKy9O8vazfCgYTUTSOpYNdAp+yoSMYIIvPInrzRUYKNUfmx6qmzvumKKog
         vD129x24S090R0TgOXvecgHoxPrjXhqhSSwEtlZaTWAZb1VctL8pKz5dT0cvtEzf99hQ
         UVEQ==
X-Gm-Message-State: APjAAAWxFCHrmk/785DIlqwMeeNfdKXQs6yt3XSyYhGVsvR5VOxzJzUS
        6jL0c27pQwwzv6otmjzdjpxDcQ==
X-Google-Smtp-Source: APXvYqz6XDwzdrsaDrWccJyY0LG2FMNErzKhxv4IReDifWCzG2NutSEjvt/JjZpO9qyPwtZgk259PA==
X-Received: by 2002:a62:7c4d:: with SMTP id x74mr9086260pfc.95.1568885066049;
        Thu, 19 Sep 2019 02:24:26 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id s19sm9749108pfe.86.2019.09.19.02.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:24:24 -0700 (PDT)
From:   hev <r@hev.cc>
To:     linux-fsdevel@vger.kernel.org
Cc:     Heiher <r@hev.cc>, Al Viro <viro@ZenIV.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davide Libenzi <davidel@xmailserver.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Eric Wong <e@80x24.org>, Jason Baron <jbaron@akamai.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Roman Penyaev <rpenyaev@suse.de>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] fs/epoll: Remove unnecessary wakeups of nested epoll that in ET mode
Date:   Thu, 19 Sep 2019 17:24:13 +0800
Message-Id: <20190919092413.11141-1-r@hev.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiher <r@hev.cc>

Take the case where we have:

        t0
         | (ew)
        e0
         | (et)
        e1
         | (lt)
        s0

t0: thread 0
e0: epoll fd 0
e1: epoll fd 1
s0: socket fd 0
ew: epoll_wait
et: edge-trigger
lt: level-trigger

When s0 fires an event, e1 catches the event, and then e0 catches an event from
e1. After this, There is a thread t0 do epoll_wait() many times on e0, it should
only get one event in total, because e1 is a dded to e0 in edge-triggered mode.

This patch only allows the wakeup(&ep->poll_wait) in ep_scan_ready_list under
two conditions:

 1. depth == 0.
 2. There have event is added to ep->ovflist during processing.

Test code:
 #include <unistd.h>
 #include <sys/epoll.h>
 #include <sys/socket.h>

 int main(int argc, char *argv[])
 {
 	int sfd[2];
 	int efd[2];
 	struct epoll_event e;

 	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sfd) < 0)
 		goto out;

 	efd[0] = epoll_create(1);
 	if (efd[0] < 0)
 		goto out;

 	efd[1] = epoll_create(1);
 	if (efd[1] < 0)
 		goto out;

 	e.events = EPOLLIN;
 	if (epoll_ctl(efd[1], EPOLL_CTL_ADD, sfd[0], &e) < 0)
 		goto out;

 	e.events = EPOLLIN | EPOLLET;
 	if (epoll_ctl(efd[0], EPOLL_CTL_ADD, efd[1], &e) < 0)
 		goto out;

 	if (write(sfd[1], "w", 1) != 1)
 		goto out;

 	if (epoll_wait(efd[0], &e, 1, 0) != 1)
 		goto out;

 	if (epoll_wait(efd[0], &e, 1, 0) != 0)
 		goto out;

 	close(efd[0]);
 	close(efd[1]);
 	close(sfd[0]);
 	close(sfd[1]);

 	return 0;

 out:
 	return -1;
 }

More tests:
 https://github.com/heiher/epoll-wakeup

Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Davide Libenzi <davidel@xmailserver.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Wong <e@80x24.org>
Cc: Jason Baron <jbaron@akamai.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roman Penyaev <rpenyaev@suse.de>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: hev <r@hev.cc>
---
 fs/eventpoll.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..fa71468dbd51 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -685,6 +685,9 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	if (!ep_locked)
 		mutex_lock_nested(&ep->mtx, depth);
 
+	if (!depth || list_empty_careful(&ep->rdllist))
+		pwake++;
+
 	/*
 	 * Steal the ready list, and re-init the original one to the
 	 * empty list. Also, set ep->ovflist to NULL so that events
@@ -755,7 +758,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		mutex_unlock(&ep->mtx);
 
 	/* We have to call this outside the lock */
-	if (pwake)
+	if (pwake == 2)
 		ep_poll_safewake(&ep->poll_wait);
 
 	return res;
-- 
2.23.0

