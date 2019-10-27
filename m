Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C79ACA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 15:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB71020873
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 15:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="d+drrxti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJ0Pq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 11:46:29 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:43748 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727301AbfJ0Pq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:46:29 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 24DB52E0985;
        Sun, 27 Oct 2019 18:46:21 +0300 (MSK)
Received: from sas2-62907d92d1d8.qloud-c.yandex.net (sas2-62907d92d1d8.qloud-c.yandex.net [2a02:6b8:c08:b895:0:640:6290:7d92])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id VfJizSzZVs-kKlqE0Dk;
        Sun, 27 Oct 2019 18:46:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572191181; bh=1vRFlA2ZVXXgq2L2DDGrOfUqAJRPHMdjSGUR/FoiYWc=;
        h=Message-ID:Date:To:From:Subject;
        b=d+drrxtiJ2dcUCB61GPKZEmN7IJNJTslyzaI4Vc2EvaUQg8qo+zKvneLLnrQFEWoB
         rBsIzKO52O/NSV4tiTOf36y0NxpYmnyL8+TMStqUrgd4cpRXlNyYuKNIHC+mCYDMge
         mwmZ/U23iouHCKHRGpqsXmZoqVXfZAznMGBX8W5o=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7710::1:0])
        by sas2-62907d92d1d8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 7hBFG86ADV-kKV40bI4;
        Sun, 27 Oct 2019 18:46:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH] pipe: wakeup writer only if pipe buffer is at least half
 empty
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     David Howells <dhowells@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Sun, 27 Oct 2019 18:46:20 +0300
Message-ID: <157219118016.7078.16223055699799396042.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to wakeup writer if pipe has only one empty page.
This means reader consumes data slower then writer produces it.

This patch waits until buffer is at least half empty before waking writer.
This lets him produce more data at once. In general, this change should
increase data batching and decrease rate of context switches.

perf stat bash -c 'seq 50000000 | wc' shows decreasing count of context
switches from 26k to 13k. Execution time stays the same.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 fs/pipe.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 8a2ab2f974bd..14754c9095ce 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -324,7 +324,8 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
 				curbuf = (curbuf + 1) & (pipe->buffers - 1);
 				pipe->curbuf = curbuf;
 				pipe->nrbufs = --bufs;
-				do_wakeup = 1;
+				/* Wakeup writer if buffer is half empty */
+				do_wakeup = bufs <= pipe->buffers / 2;
 			}
 			total_len -= chars;
 			if (!total_len)
@@ -555,7 +556,9 @@ pipe_poll(struct file *filp, poll_table *wait)
 	}
 
 	if (filp->f_mode & FMODE_WRITE) {
-		mask |= (nrbufs < pipe->buffers) ? EPOLLOUT | EPOLLWRNORM : 0;
+		/* Wakeup writer if buffer is half empty */
+		if (nrbufs <= pipe->buffers / 2)
+			mask |= EPOLLOUT | EPOLLWRNORM;
 		/*
 		 * Most Unices do not set EPOLLERR for FIFOs but on Linux they
 		 * behave exactly like pipes for poll().

