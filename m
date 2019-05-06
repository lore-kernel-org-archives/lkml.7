Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F5CC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1902082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557135083;
	bh=ohEk3Mjmd5Jsei+A/3V9wX1D8v9dgEMwZhUdVU0q0Tc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=YQbiKGJEXEeqrh2Rc4Tq0N8MzKlQ6DMO12PVCNz08W+RTrq09W2LqLPxwdXrsw5UU
	 V842dWwCkmJmLWGLjySYMaorpfpw9NOVb+tmobSI1Fr36+cAY9UpQ9C05qNQeCc+I3
	 UPIY/9vjv+tumD/l2UCBU6Q9XdPHV6lX2/Phm4dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfEFJbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:31:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41769 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:31:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id c12so16330436wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jtRFjy/ehRAYk//LfsI+2USZzRiCd7GC507WcuG6cc4=;
        b=UFaUSzZKG/jnxKSFfWj1nOjpXy5SuG3q30YGpMx2iSti0UAACL0LINWH2jjPvXg/BM
         UTmzGdJua3Xh+1bMezhsKScY6Kx3emYbaP50oquNLFsja6iZBAbvul1zSWfQns30FxeI
         OWoNZTy7pVTCjx7eT5NsmZM3bDCK5/dGVlCrwP7sjCJvs+4TrDqA7sK4i5pZ/pxnBqoG
         zyAIP6uZ2DE5A/rJvcxSWICsQUWTWmfcGQFhY9K+JamelKfsPvde/9tMvlGrDU7VlQWz
         sH1jfV64wFu4bdhbQvRA+mQH99XsiYmfw/mmN2063lk7PGa7AKzIPjrDZwS88416LVxI
         PCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=jtRFjy/ehRAYk//LfsI+2USZzRiCd7GC507WcuG6cc4=;
        b=r4YH5dnJxkyxzArJAWaSIH5XXRE6UYGH7NB2ffCORZRJGo4yIUJ1EEY8Isn+Y4pfsn
         s1ARCQRtYue4XahRcl9gMDvgWfHSQiGxEuGnhFxEqH1EUTvjK4WgNlR3vqNCkePpH8s7
         5WZmifrjEwBBYQv8fAA7JoNuooYbcX7vkLMb5z6BT2APmhz+o0v3lTCu0GWbiHqnok6W
         Kvi4A+oSW5a1sqy0E1Wn7m49zK+uT+Odf9EzCfAzPGcZKXSyLthiw+LgN7eB+tk5N2F4
         yMQBchd5MfY7poTASC4H2KwZsMM64daNt0WixtI/WAA6Inn4eUym2fZLk3bA9mMnWumZ
         vsRw==
X-Gm-Message-State: APjAAAVQqVnEPjfTYD1SpaWsCRwi7cda46CZpL6OruzBSuXKOTmRi+qz
        Bjq3fWbLOS+c+dr6ZYO4CEI=
X-Google-Smtp-Source: APXvYqyqyJjvKE3f1MF4k0J6gibvL6wj1hkzMkP5RDvwZ0qcuYRSXDn1DiKJPVAnTvUpw5cnsTVEQQ==
X-Received: by 2002:adf:eac6:: with SMTP id o6mr7399170wrn.222.1557135078459;
        Mon, 06 May 2019 02:31:18 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id f6sm8804992wmh.13.2019.05.06.02.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 02:31:17 -0700 (PDT)
Date:   Mon, 6 May 2019 11:31:15 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/apic change for v5.2
Message-ID: <20190506093115.GA48027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-apic-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-for-linus

   # HEAD: 6eb4f08293e971cb1b7b867c7fe994c244b91460 x86/apic: Unify duplicated local apic timer clockevent initialization

Contains a single commit which unifies the unnecessarily diverged 
implementations of APIC timer initialization. As a result the max_delta 
parameter is now consistently taken into account.

 Thanks,

	Ingo

------------------>
Jacob Pan (1):
      x86/apic: Unify duplicated local apic timer clockevent initialization


 arch/x86/kernel/apic/apic.c | 57 ++++++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b7bcdd781651..ab6af775f06c 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -802,6 +802,24 @@ calibrate_by_pmtimer(long deltapm, long *delta, long *deltatsc)
 	return 0;
 }
 
+static int __init lapic_init_clockevent(void)
+{
+	if (!lapic_timer_frequency)
+		return -1;
+
+	/* Calculate the scaled math multiplication factor */
+	lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
+					TICK_NSEC, lapic_clockevent.shift);
+	lapic_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
+	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
+	lapic_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xF, &lapic_clockevent);
+	lapic_clockevent.min_delta_ticks = 0xF;
+
+	return 0;
+}
+
 static int __init calibrate_APIC_clock(void)
 {
 	struct clock_event_device *levt = this_cpu_ptr(&lapic_events);
@@ -810,25 +828,21 @@ static int __init calibrate_APIC_clock(void)
 	long delta, deltatsc;
 	int pm_referenced = 0;
 
-	/**
-	 * check if lapic timer has already been calibrated by platform
-	 * specific routine, such as tsc calibration code. if so, we just fill
+	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER))
+		return 0;
+
+	/*
+	 * Check if lapic timer has already been calibrated by platform
+	 * specific routine, such as tsc calibration code. If so just fill
 	 * in the clockevent structure and return.
 	 */
-
-	if (boot_cpu_has(X86_FEATURE_TSC_DEADLINE_TIMER)) {
-		return 0;
-	} else if (lapic_timer_frequency) {
+	if (!lapic_init_clockevent()) {
 		apic_printk(APIC_VERBOSE, "lapic timer already calibrated %d\n",
-				lapic_timer_frequency);
-		lapic_clockevent.mult = div_sc(lapic_timer_frequency/APIC_DIVISOR,
-					TICK_NSEC, lapic_clockevent.shift);
-		lapic_clockevent.max_delta_ns =
-			clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
-		lapic_clockevent.max_delta_ticks = 0x7FFFFF;
-		lapic_clockevent.min_delta_ns =
-			clockevent_delta2ns(0xF, &lapic_clockevent);
-		lapic_clockevent.min_delta_ticks = 0xF;
+			    lapic_timer_frequency);
+		/*
+		 * Direct calibration methods must have an always running
+		 * local APIC timer, no need for broadcast timer.
+		 */
 		lapic_clockevent.features &= ~CLOCK_EVT_FEAT_DUMMY;
 		return 0;
 	}
@@ -869,17 +883,8 @@ static int __init calibrate_APIC_clock(void)
 	pm_referenced = !calibrate_by_pmtimer(lapic_cal_pm2 - lapic_cal_pm1,
 					&delta, &deltatsc);
 
-	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(delta, TICK_NSEC * LAPIC_CAL_LOOPS,
-				       lapic_clockevent.shift);
-	lapic_clockevent.max_delta_ns =
-		clockevent_delta2ns(0x7FFFFFFF, &lapic_clockevent);
-	lapic_clockevent.max_delta_ticks = 0x7FFFFFFF;
-	lapic_clockevent.min_delta_ns =
-		clockevent_delta2ns(0xF, &lapic_clockevent);
-	lapic_clockevent.min_delta_ticks = 0xF;
-
 	lapic_timer_frequency = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+	lapic_init_clockevent();
 
 	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %u\n", lapic_clockevent.mult);
