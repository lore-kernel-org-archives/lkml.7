Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624FCC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EB4233FF
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 08:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8MZ1xKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfH2Ic1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 04:32:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfH2IcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 04:32:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so1578801pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SzjF5M9g3WPXVWBsvcy5widTSQF3uJNdH6VsFHR6lrs=;
        b=Z8MZ1xKNSqg+nd/90PqV8/iLqE7VK7Rs0Jrn2ruzfEBMZeOTpeisIYlAc+vlR9wl54
         JLH9d436AphLFTp/l768GhAF5nRF+h7189GhU1H5nd8Dbi+iwNWVuRt0YWgbOnn3OlP6
         Q/yHmUoeSYyvjU3GZAT1ZmXViTV1kuNeSbOKO1HiP4+Z6yIx6giKhE7RKKOycyROwswh
         DLnxVaWGFD9xl69ygebDBzgXfMbK9XCJBpCXE/36UMo4BKoX19wPaEbppj3+cDi3iOcb
         jx90RIqUuoLtzAwlr2kKRxArCj1DDOIVJrESqoaCx4pWxJEhrFi1X7ZDPp0wfePdF1Pv
         GP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SzjF5M9g3WPXVWBsvcy5widTSQF3uJNdH6VsFHR6lrs=;
        b=MygJQIa97UI0Nl54bGH+e8cYziehIf7pk7/tnP7l2C4qmrhScTdtcQgvzLV/CREJcU
         4aL/YD30MVG/8G9x4jgG3L0/fdaFZ0bmvCEtb1QddjhTrWoNvnjQruFcru+1FGCD0yoB
         cTiKqSTJPzGMwMU7CSqmoidwm2TJv8XMf9uR+OQ55t1fkZjoMg5m0KISV4Fy7wpm9q97
         eM51CnzfUMRN3yQT2J14ZTZAEMkCJLJXZe3zI4rqcT1ZSoSBJWF7VYMnTw25EEvvDNXE
         FcTVNfbTqRmL5n4KQibqQKyEynkbbAIEOUrdMiTG7sXcERNBBMyiIYAMSWnapSaJW9Ga
         KTRQ==
X-Gm-Message-State: APjAAAVbV1tEHxEEGfNNutHexDyceYcwnZ5Udws8XMDgqMcEWZhNrUGZ
        qmjxCtF4jdocvRXnWpDdpCc=
X-Google-Smtp-Source: APXvYqzFN0sWcJLt5oUxarsRsGwSfkJ5Ku1LBz98f0IDYgsITc/pWAPUFhQAXsWbsb/0rb/f9VUkVg==
X-Received: by 2002:aa7:8b46:: with SMTP id i6mr9620294pfd.190.1567067544258;
        Thu, 29 Aug 2019 01:32:24 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v22sm1260155pgk.69.2019.08.29.01.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 01:32:23 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        longman@redhat.com, paulmck@linux.vnet.ibm.com,
        boqun.feng@gmail.com, Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v4 10/30] locking/lockdep: Remove useless lock type assignment
Date:   Thu, 29 Aug 2019 16:31:12 +0800
Message-Id: <20190829083132.22394-11-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190829083132.22394-1-duyuyang@gmail.com>
References: <20190829083132.22394-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next lock to acquire has its lock type set already, so there is no
need to reassign it regardless of whether it is recursive read.

No functional change.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e8ebb64..acbd538 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2919,13 +2919,6 @@ static int validate_chain(struct task_struct *curr, struct held_lock *hlock,
 		if (!ret)
 			return 0;
 		/*
-		 * Mark recursive read, as we jump over it when
-		 * building dependencies (just like we jump over
-		 * trylock entries):
-		 */
-		if (ret == 2)
-			hlock->read = 2;
-		/*
 		 * Add dependency only if this lock is not the head
 		 * of the chain, and if it's not a secondary read-lock:
 		 */
-- 
1.8.3.1

