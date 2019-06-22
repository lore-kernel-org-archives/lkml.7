Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23699C48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7882089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 09:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y2FnanyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFVJeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 05:34:23 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59219 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfFVJeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 05:34:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M9Y2tr2080749
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 02:34:02 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M9Y2tr2080749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561196043;
        bh=BNZf+xBD+0Bx+gTD9x7yNRgd6NKkCEDR+0JWVEn1+X8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y2FnanyDDWzWjrtpB6mWnu2D8/Ai/2niCAtfji2y94Z9/3UDDDqPW5ybFF1C3so6e
         qD42dz/L9MtD3aXjcLvIN0rG5ZxJ4r2r3qZ3GUKKvwixU3IZRuccpFoN9/oc2O09aY
         XSyYY14hXtICMJK6JvsLWqg4mqNux3ce5Lo05tZGp/ugHb7ytaHkTlxP+Dc5XGVFJd
         cOfmq6js5ZJjXjQPMklE6SiOaPQXZVurCn/4O4CxZph+q2j3WJFBEbWRUIVn1xSeFZ
         5i7OLZs0dCjRKXqZ6vGqTO0sCQwKt1zJJV0Tn/2ocZpsWskZoS43+473iLpc6tIEJt
         HFqizA0eM2dXw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M9Y2eV2080746;
        Sat, 22 Jun 2019 02:34:02 -0700
Date:   Sat, 22 Jun 2019 02:34:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Miroslav Lichvar <tipbot@zytor.com>
Message-ID: <tip-d897a4ab11dc8a9fda50d2eccc081a96a6385998@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        prarit@redhat.com, mlichvar@redhat.com, richardcochran@gmail.com,
        mingo@kernel.org, hpa@zytor.com, sboyd@kernel.org,
        john.stultz@linaro.org, swkhack@gmail.com
Reply-To: sboyd@kernel.org, swkhack@gmail.com, john.stultz@linaro.org,
          prarit@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
          richardcochran@gmail.com, mlichvar@redhat.com
In-Reply-To: <20190618154713.20929-1-mlichvar@redhat.com>
References: <20190618154713.20929-1-mlichvar@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] ntp: Limit TAI-UTC offset
Git-Commit-ID: d897a4ab11dc8a9fda50d2eccc081a96a6385998
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

Commit-ID:  d897a4ab11dc8a9fda50d2eccc081a96a6385998
Gitweb:     https://git.kernel.org/tip/d897a4ab11dc8a9fda50d2eccc081a96a6385998
Author:     Miroslav Lichvar <mlichvar@redhat.com>
AuthorDate: Tue, 18 Jun 2019 17:47:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:28:53 +0200

ntp: Limit TAI-UTC offset

Don't allow the TAI-UTC offset of the system clock to be set by adjtimex()
to a value larger than 100000 seconds.

This prevents an overflow in the conversion to int, prevents the CLOCK_TAI
clock from getting too far ahead of the CLOCK_REALTIME clock, and it is
still large enough to allow leap seconds to be inserted at the maximum rate
currently supported by the kernel (once per day) for the next ~270 years,
however unlikely it is that someone can survive a catastrophic event which
slowed down the rotation of the Earth so much.

Reported-by: Weikang shi <swkhack@gmail.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Link: https://lkml.kernel.org/r/20190618154713.20929-1-mlichvar@redhat.com

---
 kernel/time/ntp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8de4f789dc1b..65eb796610dc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -43,6 +43,7 @@ static u64			tick_length_base;
 #define MAX_TICKADJ		500LL		/* usecs */
 #define MAX_TICKADJ_SCALED \
 	(((MAX_TICKADJ * NSEC_PER_USEC) << NTP_SCALE_SHIFT) / NTP_INTERVAL_FREQ)
+#define MAX_TAI_OFFSET		100000
 
 /*
  * phase-lock loop variables
@@ -691,7 +692,8 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 		time_constant = max(time_constant, 0l);
 	}
 
-	if (txc->modes & ADJ_TAI && txc->constant >= 0)
+	if (txc->modes & ADJ_TAI &&
+			txc->constant >= 0 && txc->constant <= MAX_TAI_OFFSET)
 		*time_tai = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET)
