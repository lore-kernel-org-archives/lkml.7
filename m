Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03897C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55882173B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573497001;
	bh=8TCRa5j57pe7+Mx5RkLfWcn+fZoJqmv6pWa/XoPllB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DF0SOvvASW9xMrwj6rNtEFyDJqXN3B6kOcc9MAafHKkEbq+F3RsIuAlVLOv3EKc5f
	 u5rH/kuDkRQ/pTmX1mXFg+HaxVf2MboRBcIW7oFcNEgbj6SvlMwNqz5KD8mGsHYO3j
	 2VvBKIIrbXfuVtocyrBzNXEdiOYrF6JAtprUcPEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKKSaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfKKS36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:29:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260A62173B;
        Mon, 11 Nov 2019 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573496997;
        bh=8TCRa5j57pe7+Mx5RkLfWcn+fZoJqmv6pWa/XoPllB8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrNzNK/3RNk28pUryZ4DI/k3p2Ct5xBHXochrq5DjdwQZ0FcytUgkPx8WQ/+lnJeX
         zASNEbCgpzLVg0N3bxFlUTKlyvDozROdFOs5TqkBU8vN+FDi4QlQ6Z4teYLLp9vIaN
         iL9+ugsLvtSzRGUcKP2atbAPqJMgcTLD6+y4Bg5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Hao <haokexin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.4 11/43] dump_stack: avoid the livelock of the dump_lock
Date:   Mon, 11 Nov 2019 19:28:25 +0100
Message-Id: <20191111181300.050698565@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181246.772983347@linuxfoundation.org>
References: <20191111181246.772983347@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Hao <haokexin@gmail.com>

commit 5cbf2fff3bba8d3c6a4d47c1754de1cf57e2b01f upstream.

In the current code, we use the atomic_cmpxchg() to serialize the output
of the dump_stack(), but this implementation suffers the thundering herd
problem.  We have observed such kind of livelock on a Marvell cn96xx
board(24 cpus) when heavily using the dump_stack() in a kprobe handler.
Actually we can let the competitors to wait for the releasing of the
lock before jumping to atomic_cmpxchg().  This will definitely mitigate
the thundering herd problem.  Thanks Linus for the suggestion.

[akpm@linux-foundation.org: fix comment]
Link: http://lkml.kernel.org/r/20191030031637.6025-1-haokexin@gmail.com
Fixes: b58d977432c8 ("dump_stack: serialize the output from dump_stack()")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/dump_stack.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -44,7 +44,12 @@ retry:
 		was_locked = 1;
 	} else {
 		local_irq_restore(flags);
-		cpu_relax();
+		/*
+		 * Wait for the lock to release before jumping to
+		 * atomic_cmpxchg() in order to mitigate the thundering herd
+		 * problem.
+		 */
+		do { cpu_relax(); } while (atomic_read(&dump_lock) != -1);
 		goto retry;
 	}
 


