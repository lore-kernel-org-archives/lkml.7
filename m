Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723C0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4479120673
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="rip4MRuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfJIGGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:06:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33006 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfJIGGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:06:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id a15so798780oic.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+9GPoOhQkd1vjT/R/kfNbg6XiPOzhDYEx2wXKpxJ7A=;
        b=rip4MRuLxRKbEYLy1YE4w3O3PPOi7w2wSYKOiqasHNPIh/Ev8/EDOSEviq9tC1lug+
         o/pV3taf7p5JEHK1yy79jNzaAqTSg9QKRS9MW7vi6Sg2eScp8OPiJyeeVafKYQh+pbl0
         ASC6U6fCo00dER/kiPFcR+p99aMDTw/7whu5tCPOUFxJz33HcgTh58eQ2y/Lenh6IX/N
         qek4qqAbUyk8B0UApQWXA7AN0/4eQeGPUmPSjrd6bJL4TS4ii8RzPDwBpL0kF/aTpwj6
         PwgxqiSoRhBimXrUpLSuKg6G+l+bJXH9BI/0gNmhs6cLPdX8sHGEhS6nKpGeKfVlZMOl
         t3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y+9GPoOhQkd1vjT/R/kfNbg6XiPOzhDYEx2wXKpxJ7A=;
        b=BKJNRbGyN3fbfEm8rH50YUv1AeFzIn0qQ6FJuRRk+dlBTYCpla6wT8QQenA/kZRxsC
         XBZJvOQJ/+zqJqdNepLRPbKMOcpv+UGaASkn+VwxDL387muO2cwlH+nOA/KxKgyYbFvA
         CVLUNZDPlf0n4ENQ6eLdxlDfEQdrzPiw8zgMnF+oJWD672PzwbHS/SQYT/zEMAWsT4yG
         X/i3UevxQKI9ou+F5jzYKBCdpaqoWzHa9dVa2ZdogNazWQAe5V8FwJmjnrpAC0nWds+s
         4du7Y7C+WiiWcwNJvQEUIjrpsSsgRxYdlMAzv6QhAazr28ydzcFzsGq+/PL5MXksvcDP
         NDHw==
X-Gm-Message-State: APjAAAUQQZqGaSaSOVIMhLajBDRjrJewHbfeqgUeVhi4amZ5pj85A36v
        49sj5pq4NXmicMwDRlTbGos1XA==
X-Google-Smtp-Source: APXvYqzMqRRhxCkaJC5ejgVi3EFrI3LKlZiFtWlEAqcprwyaDmtuspogFJWg189veCgcyPO3oVjuoA==
X-Received: by 2002:aca:882:: with SMTP id 124mr1020541oii.54.1570601181711;
        Tue, 08 Oct 2019 23:06:21 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id o23sm396444ote.67.2019.10.08.23.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 23:06:20 -0700 (PDT)
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
Subject: [PATCH RESEND v5] fs/epoll: Remove unnecessary wakeups of nested epoll
Date:   Wed,  9 Oct 2019 14:05:16 +0800
Message-Id: <20191009060516.3577-1-r@hev.cc>
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

We remove unnecessary wakeups to prevent the nested epoll that working in edge-
triggered mode to waking up continuously.

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
 fs/eventpoll.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..75fccae100b5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -671,7 +671,6 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 			      void *priv, int depth, bool ep_locked)
 {
 	__poll_t res;
-	int pwake = 0;
 	struct epitem *epi, *nepi;
 	LIST_HEAD(txlist);
 
@@ -738,26 +737,11 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	 */
 	list_splice(&txlist, &ep->rdllist);
 	__pm_relax(ep->ws);
-
-	if (!list_empty(&ep->rdllist)) {
-		/*
-		 * Wake up (if active) both the eventpoll wait list and
-		 * the ->poll() wait list (delayed after we release the lock).
-		 */
-		if (waitqueue_active(&ep->wq))
-			wake_up(&ep->wq);
-		if (waitqueue_active(&ep->poll_wait))
-			pwake++;
-	}
 	write_unlock_irq(&ep->lock);
 
 	if (!ep_locked)
 		mutex_unlock(&ep->mtx);
 
-	/* We have to call this outside the lock */
-	if (pwake)
-		ep_poll_safewake(&ep->poll_wait);
-
 	return res;
 }
 
-- 
2.23.0

