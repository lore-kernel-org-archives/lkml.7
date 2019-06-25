Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E95C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B0F21655
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="wxbzTAZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfFYITa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:19:30 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:38083 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfFYIT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:19:29 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dd2a6a86;
        Tue, 25 Jun 2019 07:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=6AhJklfhAlrrPr4iFlW6cSyKn
        9g=; b=wxbzTAZzfeJMO5yikXjo33XmrOOOrvW9zvzUN2wlDmd9dcQLdyTN6kaPp
        F7/BoBGmiH6QdGIzjqqo/GAd2KlTqqiZAiErX82LC62TrRMpKOmlB7x7AnKRmvPa
        6HyXJtnd3i4JVvty6nbErfK4iJrhzzy03nzk1qf6P6GdtCTWrGV65rlMYgxoIYf6
        LnG936mY0JWAfT7zu0sdwMO0gtRxw4FbNpg9uFoU2LXOwKNRRvnV3sy1iVOvGFkl
        /jjs3W6J0FE0esRbcTiffDwedGaWb8ByE0SQDpVmzBDDxpCx5Zmd7WrdBh5VBSdK
        OSq3CaXn6RKWvl6BnkjU5sPv2CzsA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fd7a8702 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Tue, 25 Jun 2019 07:45:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/2] timekeeping: add missing non-_ns functions for fast accessors
Date:   Tue, 25 Jun 2019 10:19:11 +0200
Message-Id: <20190625081912.14813-2-Jason@zx2c4.com>
In-Reply-To: <20190625081912.14813-1-Jason@zx2c4.com>
References: <20190625081912.14813-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously there was no analogue to get proper ktime_t versions of the
fast variety of ktime invocations. This commit makes the interface
uniform with the other accessors.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst |  7 +++-
 include/linux/timekeeping.h            | 28 ++++++++++++--
 kernel/time/timekeeping.c              | 52 +++++++++++++-------------
 3 files changed, 55 insertions(+), 32 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 20ee447a50f3..29d38a86faac 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -94,7 +94,7 @@ different format depending on what is required by the user:
 	down the seconds to the full seconds of the last timer tick
 	using the respective reference.
 
-Coarse and fast_ns access
+Coarse and fast access
 -------------------------
 
 Some additional variants exist for more specialized cases:
@@ -129,6 +129,11 @@ Some additional variants exist for more specialized cases:
 	up to several microseconds on older hardware with an external
 	clocksource.
 
+.. c:function:: ktime_t ktime_get_mono_fast( void )
+		ktime_t ktime_get_raw_fast( void )
+		ktime_t ktime_get_boottime_fast( void )
+		ktime_t ktime_get_real_fast( void )
+
 .. c:function:: u64 ktime_get_mono_fast_ns( void )
 		u64 ktime_get_raw_fast_ns( void )
 		u64 ktime_get_boot_fast_ns( void )
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b27e2ffa96c1..b8a3a129258c 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -174,10 +174,30 @@ static inline u64 ktime_get_raw_ns(void)
 	return ktime_to_ns(ktime_get_raw());
 }
 
-extern u64 ktime_get_mono_fast_ns(void);
-extern u64 ktime_get_raw_fast_ns(void);
-extern u64 ktime_get_boot_fast_ns(void);
-extern u64 ktime_get_real_fast_ns(void);
+extern ktime_t ktime_get_mono_fast(void);
+extern ktime_t ktime_get_raw_fast(void);
+extern ktime_t ktime_get_boottime_fast(void);
+extern ktime_t ktime_get_real_fast(void);
+
+static inline u64 ktime_get_mono_fast_ns(void)
+{
+	return ktime_to_ns(ktime_get_mono_fast());
+}
+
+static inline u64 ktime_get_raw_fast_ns(void)
+{
+	return ktime_to_ns(ktime_get_raw_fast());
+}
+
+static inline u64 ktime_get_boot_fast_ns(void)
+{
+	return ktime_to_ns(ktime_get_boottime_fast());
+}
+
+static inline u64 ktime_get_real_fast_ns(void)
+{
+	return ktime_to_ns(ktime_get_real_fast());
+}
 
 /*
  * timespec64/time64_t interfaces utilizing the ktime based ones
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d911c8470149..db0081a14b90 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -443,41 +443,40 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
  * of the following timestamps. Callers need to be aware of that and
  * deal with it.
  */
-static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
+static __always_inline ktime_t __ktime_get_fast(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
 	unsigned int seq;
-	u64 now;
+	ktime_t now;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base);
-
-		now += timekeeping_delta_to_ns(tkr,
+		now = ktime_add_ns(tkr->base,
+			timekeeping_delta_to_ns(tkr,
 				clocksource_delta(
 					tk_clock_read(tkr),
 					tkr->cycle_last,
-					tkr->mask));
+					tkr->mask)));
 	} while (read_seqcount_retry(&tkf->seq, seq));
 
 	return now;
 }
 
-u64 ktime_get_mono_fast_ns(void)
+ktime_t ktime_get_mono_fast(void)
 {
-	return __ktime_get_fast_ns(&tk_fast_mono);
+	return __ktime_get_fast(&tk_fast_mono);
 }
-EXPORT_SYMBOL_GPL(ktime_get_mono_fast_ns);
+EXPORT_SYMBOL_GPL(ktime_get_mono_fast);
 
-u64 ktime_get_raw_fast_ns(void)
+ktime_t ktime_get_raw_fast(void)
 {
-	return __ktime_get_fast_ns(&tk_fast_raw);
+	return __ktime_get_fast(&tk_fast_raw);
 }
-EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
+EXPORT_SYMBOL_GPL(ktime_get_raw_fast);
 
 /**
- * ktime_get_boot_fast_ns - NMI safe and fast access to boot clock.
+ * ktime_get_boottime_fast - NMI safe and fast access to boot clock.
  *
  * To keep it NMI safe since we're accessing from tracing, we're not using a
  * separate timekeeper with updates to monotonic clock and boot offset
@@ -497,47 +496,46 @@ EXPORT_SYMBOL_GPL(ktime_get_raw_fast_ns);
  * partially updated.  Since the tk->offs_boot update is a rare event, this
  * should be a rare occurrence which postprocessing should be able to handle.
  */
-u64 notrace ktime_get_boot_fast_ns(void)
+ktime_t notrace ktime_get_boottime_fast(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 
-	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
+	return ktime_add(ktime_get_mono_fast(), tk->offs_boot);
 }
-EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
+EXPORT_SYMBOL_GPL(ktime_get_boottime_fast);
 
 
 /*
- * See comment for __ktime_get_fast_ns() vs. timestamp ordering
+ * See comment for __ktime_get_fast() vs. timestamp ordering
  */
-static __always_inline u64 __ktime_get_real_fast_ns(struct tk_fast *tkf)
+static __always_inline ktime_t __ktime_get_real_fast(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
 	unsigned int seq;
-	u64 now;
+	ktime_t now;
 
 	do {
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
-		now = ktime_to_ns(tkr->base_real);
-
-		now += timekeeping_delta_to_ns(tkr,
+		now = ktime_add_ns(tkr->base_real,
+			timekeeping_delta_to_ns(tkr,
 				clocksource_delta(
 					tk_clock_read(tkr),
 					tkr->cycle_last,
-					tkr->mask));
+					tkr->mask)));
 	} while (read_seqcount_retry(&tkf->seq, seq));
 
 	return now;
 }
 
 /**
- * ktime_get_real_fast_ns: - NMI safe and fast access to clock realtime.
+ * ktime_get_real_fast: - NMI safe and fast access to clock realtime.
  */
-u64 ktime_get_real_fast_ns(void)
+ktime_t ktime_get_real_fast(void)
 {
-	return __ktime_get_real_fast_ns(&tk_fast_mono);
+	return __ktime_get_real_fast(&tk_fast_mono);
 }
-EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
+EXPORT_SYMBOL_GPL(ktime_get_real_fast);
 
 /**
  * halt_fast_timekeeper - Prevent fast timekeeper from accessing clocksource.
-- 
2.21.0

