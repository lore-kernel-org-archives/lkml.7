Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42C1C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F77206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CfIA+lbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbfHAQFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:05:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbfHAQFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:05:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x71G5gol009537
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 1 Aug 2019 09:05:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x71G5gol009537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564675543;
        bh=tga51mINMNrP10iEFLJhoXFXKVrnYM7dWPoprfH2WHg=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=CfIA+lbhWgAYSIVHdW49t4mkn0d4xo78fL/VYFFTVeITHN+7kGCz1IS1yPYqu8Wte
         EN955FRFfj3lW00Ci6EVSHLJzzSIn6Oj2K0IXFgWyaVHhupKLmhgiAMMoUiGEqxXvS
         m44u2zysEGTl6MMyJQE0p98plp8qvU5uWXfaZDdjNmjxPUrPJhQjRyzoOWjco3oTm0
         pLRLDeJ0dbxhZ1Pk7ZlNRgXu7rpj0HH9MYhBZ5jaHl/JpED4qymjnysQuXDoJRpZZG
         iUjJkmHBpkzhSmzqfg5cTb4gqlD8nVgD1Ec2gxufFUcpATQfKKJMbDbxmXXWWsfzdd
         Hc//4WuEHumTA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x71G5fiT009534;
        Thu, 1 Aug 2019 09:05:41 -0700
Date:   Thu, 1 Aug 2019 09:05:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Anna-Maria Gleixner <tipbot@zytor.com>
Message-ID: <tip-cab46ec655eec1b5dbb0c17a25e19f67c539f00b@git.kernel.org>
Cc:     bigeasy@linutronix.de, anna-maria@linutronix.de, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        peterz@infradead.org, hpa@zytor.com
Reply-To: bigeasy@linutronix.de, anna-maria@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <20190730223828.690771827@linutronix.de>
References: <20190730223828.690771827@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] itimers: Prepare for PREEMPT_RT
Git-Commit-ID: cab46ec655eec1b5dbb0c17a25e19f67c539f00b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  cab46ec655eec1b5dbb0c17a25e19f67c539f00b
Gitweb:     https://git.kernel.org/tip/cab46ec655eec1b5dbb0c17a25e19f67c539f00b
Author:     Anna-Maria Gleixner <anna-maria@linutronix.de>
AuthorDate: Wed, 31 Jul 2019 00:33:51 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Aug 2019 17:46:41 +0200

itimers: Prepare for PREEMPT_RT

Use the hrtimer_cancel_wait_running() synchronization mechanism to prevent
priority inversion and live locks on PREEMPT_RT.

As a benefit the retry loop gains the missing cpu_relax() on !RT.

[ tglx: Split out of combo patch ]

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20190730223828.690771827@linutronix.de

---
 kernel/time/itimer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/itimer.c b/kernel/time/itimer.c
index 02068b2d5862..9d26fd4ba4c0 100644
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -213,6 +213,7 @@ again:
 		/* We are sharing ->siglock with it_real_fn() */
 		if (hrtimer_try_to_cancel(timer) < 0) {
 			spin_unlock_irq(&tsk->sighand->siglock);
+			hrtimer_cancel_wait_running(timer);
 			goto again;
 		}
 		expires = timeval_to_ktime(value->it_value);
