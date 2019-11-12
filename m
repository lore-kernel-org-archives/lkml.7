Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0044C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82B73222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 07:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfKLHWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 02:22:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60944 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfKLHWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 02:22:47 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUQVg-0005d6-So; Tue, 12 Nov 2019 08:22:44 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6DB031C0084;
        Tue, 12 Nov 2019 08:22:44 +0100 (CET)
Date:   Tue, 12 Nov 2019 07:22:44 -0000
From:   "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Optimize ns_to_timespec64()
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191108203435.112759-3-arnd@arndb.de>
References: <20191108203435.112759-3-arnd@arndb.de>
MIME-Version: 1.0
Message-ID: <157354336402.29376.17172070392776098039.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     20d087368d38c7350a4519a3b316ef7eb2504692
Gitweb:        https://git.kernel.org/tip/20d087368d38c7350a4519a3b316ef7eb2504692
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Fri, 08 Nov 2019 21:34:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 08:15:15 +01:00

time: Optimize ns_to_timespec64()

ns_to_timespec64() calls div_s64_rem(), which is a rather slow function on
32-bit architectures, as it cannot take advantage of the do_div()
optimizations for constant arguments.

Open-code the div_s64_rem() function in ns_to_timespec64(), so a constant
divider can be passed into the optimized div_u64_rem() function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191108203435.112759-3-arnd@arndb.de
---
 kernel/time/time.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 5c54ca6..45a3589 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -550,18 +550,21 @@ EXPORT_SYMBOL(set_normalized_timespec64);
  */
 struct timespec64 ns_to_timespec64(const s64 nsec)
 {
-	struct timespec64 ts;
+	struct timespec64 ts = { 0, 0 };
 	s32 rem;
 
-	if (!nsec)
-		return (struct timespec64) {0, 0};
-
-	ts.tv_sec = div_s64_rem(nsec, NSEC_PER_SEC, &rem);
-	if (unlikely(rem < 0)) {
-		ts.tv_sec--;
-		rem += NSEC_PER_SEC;
+	if (likely(nsec > 0)) {
+		ts.tv_sec = div_u64_rem(nsec, NSEC_PER_SEC, &rem);
+		ts.tv_nsec = rem;
+	} else if (nsec < 0) {
+		/*
+		 * With negative times, tv_sec points to the earlier
+		 * second, and tv_nsec counts the nanoseconds since
+		 * then, so tv_nsec is always a positive number.
+		 */
+		ts.tv_sec = -div_u64_rem(-nsec - 1, NSEC_PER_SEC, &rem) - 1;
+		ts.tv_nsec = NSEC_PER_SEC - rem - 1;
 	}
-	ts.tv_nsec = rem;
 
 	return ts;
 }
