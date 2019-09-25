Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75848C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BCDF214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hev-cc.20150623.gappssmtp.com header.i=@hev-cc.20150623.gappssmtp.com header.b="sn99UHj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633708AbfIYB4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 21:56:24 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39229 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633689AbfIYB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 21:56:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id w144so3496415oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XF6jmOvtyrBMaqdt7hPfORfmiOBGH0e252B9Q5r9KVc=;
        b=sn99UHj6vmUiCfF9Qt2YuozEa4TDgMGJD/uVFjfTtYh4ZBdfL+L3vsmeWsIyb0s/Zk
         Fol14MrBW5JV9dZoUnG9YTyoj336NdpOjNiZ7wHC7B1QUWn++yotMppCp6AWKoE916/W
         mmJHjzktF6EdtXLr/Mlm8iBJ4rnweuQcgISHw6UfuucYKLhwF2KQAi/6e4qDOVnWLW5y
         6iyyVyot/AsDAl0rNPuMXe395vmBETZnnMu0dsM0DvDI2wnlg84IlRLkLvje45q8FA5X
         TpcM2ecwMpX/fE3CLVZUTGw8miu8l+zU6PcIoa4jikL9XMmSmMCE2QdzQJR8jpnQl+rl
         3eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XF6jmOvtyrBMaqdt7hPfORfmiOBGH0e252B9Q5r9KVc=;
        b=bTzviv9rq8WJ276IVM4eXG3n6wJPKWgaPvzR8XJkFPJYbNJNv+b6kHtL0vJCy/bJLJ
         47d+Aac55blO6dKTu0wWMVitQR+8vzhZ3dnyNUpD14Qv3tvo8LAmbpQASXVnOfnKADfz
         ruy0ezD2JPqOPvrJFPsIG6vNL/H+XGkGr+t7VOsDNqBvMTBZnWOFq9Wyec4VjDWMRJj7
         +F3DoYdkniGKQIoOdthyI2p+LGGNQokqhMK3EG7SMTDa+IVR1CCu9EOgxzxH1VobOdb5
         nXCODW+l7Sp7z8IP5PJrryU5jiQ0zOIlFR+G5sj8Gxd4adtxFpvLw1ysk+BVEzPS2X7U
         QzQw==
X-Gm-Message-State: APjAAAVjfMWfSfSbxla3KFbx8f0+WPq95z5ZHO+CBHmFGtTn2hs1bQTU
        vT/gwtYT9Tt+8gviQNBJR7RLpQ==
X-Google-Smtp-Source: APXvYqwGBbXTEYK5C2Hbguwh+VdqRHGF60tBAQvGahQtP0nrTkCZgjD6jITalyFPVcrsj+IFq2iRNA==
X-Received: by 2002:a05:6808:302:: with SMTP id i2mr2804825oie.176.1569376581500;
        Tue, 24 Sep 2019 18:56:21 -0700 (PDT)
Received: from hev-sbc.hz.ali.com ([47.89.83.40])
        by smtp.gmail.com with ESMTPSA id d69sm1190658oig.32.2019.09.24.18.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 18:56:20 -0700 (PDT)
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
Subject: [PATCH RESEND v4] fs/epoll: Remove unnecessary wakeups of nested epoll that in ET mode
Date:   Wed, 25 Sep 2019 09:56:03 +0800
Message-Id: <20190925015603.10939-1-r@hev.cc>
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

We only need to wakeup nested epoll fds if something has been queued to the
overflow list, since the ep_poll() traverses the rdllist during recursive poll
and thus events on the overflow list may not be visible yet.

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
 fs/eventpoll.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index c4159bcc05d9..a0c07f6653c6 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -704,12 +704,21 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 	res = (*sproc)(ep, &txlist, priv);
 
 	write_lock_irq(&ep->lock);
+	nepi = READ_ONCE(ep->ovflist);
+	/*
+	 * We only need to wakeup nested epoll fds if something has been queued
+	 * to the overflow list, since the ep_poll() traverses the rdllist
+	 * during recursive poll and thus events on the overflow list may not be
+	 * visible yet.
+	 */
+	if (nepi != NULL)
+		pwake++;
 	/*
 	 * During the time we spent inside the "sproc" callback, some
 	 * other events might have been queued by the poll callback.
 	 * We re-insert them inside the main ready-list here.
 	 */
-	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
+	for (; (epi = nepi) != NULL;
 	     nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
 		/*
 		 * We need to check if the item is already in the list.
@@ -755,7 +764,7 @@ static __poll_t ep_scan_ready_list(struct eventpoll *ep,
 		mutex_unlock(&ep->mtx);
 
 	/* We have to call this outside the lock */
-	if (pwake)
+	if (pwake == 2)
 		ep_poll_safewake(&ep->poll_wait);
 
 	return res;
-- 
2.23.0

