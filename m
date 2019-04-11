Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3576C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42A42184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="elk2/kKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfDKKav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:30:51 -0400
Received: from mail.codeweavers.com ([173.240.25.211]:55692 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfDKKat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:30:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=References:In-Reply-To:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fiZwMOxZNP1T8poRh7ieIncoauGMz7Ca4oi6t3rzcg8=; b=elk2/kKBI9Nmr+IbPOGs8UQQT
        7agj4B27liDCjJUHzqYU5RmJQIWzEbucuYkLb7MWsjj+ZQBpHb/Jur4Zok0VUwpeg44VFlAFhUIl8
        Q8/HKrKRBzw6AoyMi7wt0418rW4UbDumgsX30D+ISSY1aMRWkTW7xirGfCR1VBIHlPagE=;
Received: from vpn42.vpn.mn.codeweavers.com ([10.69.139.42] helo=merlot)
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgi-0000mx-TY; Thu, 11 Apr 2019 05:12:10 -0500
Received: from daviesh by merlot with local (Exim 4.90_1)
        (envelope-from <huw@codeweavers.com>)
        id 1hEWgf-0002cu-9K; Thu, 11 Apr 2019 11:12:05 +0100
From:   Huw Davies <huw@codeweavers.com>
To:     linux kernel <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 2/3] x86/vdso: Allow clock specific mult and shift values
Date:   Thu, 11 Apr 2019 11:12:04 +0100
Message-Id: <20190411101205.10006-3-huw@codeweavers.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411101205.10006-1-huw@codeweavers.com>
References: <20190411101205.10006-1-huw@codeweavers.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will allow clocks with different mult and shift values,
e.g. CLOCK_MONOTONIC_RAW, to be supported in the vDSO.

The coarse clocks do not require these data so the values are not
copied for these clocks.

One could add potential new values of mult and shift alongside the
existing values in struct vsyscall_gtod_data, but it seems more
natural to group them with the actual clock data in the basetime array
at the expense of a few more cycles in update_vsyscall().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Huw Davies <huw@codeweavers.com>
---
 arch/x86/entry/vdso/vclock_gettime.c    | 4 ++--
 arch/x86/entry/vsyscall/vsyscall_gtod.c | 8 ++++++--
 arch/x86/include/asm/vgtod.h            | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 007b3fe9d727..a4199b846d77 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -153,8 +153,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 		if (unlikely((s64)cycles < 0))
 			return vdso_fallback_gettime(clk, ts);
 		if (cycles > last)
-			ns += (cycles - last) * gtod->mult;
-		ns >>= gtod->shift;
+			ns += (cycles - last) * base->mult;
+		ns >>= base->shift;
 		sec = base->sec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_gtod.c b/arch/x86/entry/vsyscall/vsyscall_gtod.c
index e4ee83018279..ddc6a71df87c 100644
--- a/arch/x86/entry/vsyscall/vsyscall_gtod.c
+++ b/arch/x86/entry/vsyscall/vsyscall_gtod.c
@@ -43,16 +43,18 @@ void update_vsyscall(struct timekeeper *tk)
 	/* copy vsyscall data */
 	vdata->vclock_mode	= vclock_mode;
 	vdata->cycle_last	= tk->tkr_mono.cycle_last;
-	vdata->mult		= tk->tkr_mono.mult;
-	vdata->shift		= tk->tkr_mono.shift;
 
 	base = &vdata->basetime[CLOCK_REALTIME];
 	base->sec = tk->xtime_sec;
 	base->nsec = tk->tkr_mono.xtime_nsec;
+	base->mult = tk->tkr_mono.mult;
+	base->shift = tk->tkr_mono.shift;
 
 	base = &vdata->basetime[CLOCK_TAI];
 	base->sec = tk->xtime_sec + (s64)tk->tai_offset;
 	base->nsec = tk->tkr_mono.xtime_nsec;
+	base->mult = tk->tkr_mono.mult;
+	base->shift = tk->tkr_mono.shift;
 
 	base = &vdata->basetime[CLOCK_MONOTONIC];
 	base->sec = tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
@@ -63,6 +65,8 @@ void update_vsyscall(struct timekeeper *tk)
 		base->sec++;
 	}
 	base->nsec = nsec;
+	base->mult = tk->tkr_mono.mult;
+	base->shift = tk->tkr_mono.shift;
 
 	base = &vdata->basetime[CLOCK_REALTIME_COARSE];
 	base->sec = tk->xtime_sec;
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index daf69a25e46b..ae0d76491595 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -20,11 +20,13 @@ typedef unsigned long gtod_long_t;
  * clocks, this encodes the actual time.
  *
  * To confuse the reader, for high-resolution clocks, nsec is left-shifted
- * by vsyscall_gtod_data.shift.
+ * by shift.
  */
 struct vgtod_ts {
 	u64		sec;
 	u64		nsec;
+	u32		mult;
+	u32		shift;
 };
 
 #define VGTOD_BASES	(CLOCK_TAI + 1)
@@ -40,8 +42,6 @@ struct vsyscall_gtod_data {
 
 	int		vclock_mode;
 	u64		cycle_last;
-	u32		mult;
-	u32		shift;
 
 	struct vgtod_ts	basetime[VGTOD_BASES];
 
-- 
2.17.1

