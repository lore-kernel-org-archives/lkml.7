Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6B3C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994892082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 10:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557139938;
	bh=hd51lSSHcS286wvucOKNkZuzuMqENBtAL2XFjXQMhLA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rp20wBqkVF9hKjrdbbCw7dpqTYtdpNIVGr8eIL1aTjDg8jyemi1+NuPBP84pbc0DT
	 HL47YWU8A6dixBPI2b/KLCdewXwR7PAEeWeUVbwMv+dPgYvZsAsOjZBwB5RHuY4vsz
	 qWnO5FcaXXHP7WkVGqtVR/emU0qvfRHCEDB/Vf0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEFKwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 06:52:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33932 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfEFKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 06:52:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id f7so6315907wrq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/UP/QGQaXaqsK7SEwrO4ciu6HJVg07eV/I+BRaRipSE=;
        b=h74GtJiAfRSa2jbRA5L1EgKsJs2jN20oRYg9rrK9UGTwKw69t8DHd++EUU/0olzrPJ
         EQ+ErzP9L8ZvcAXO0pwacB6fY1GWd045ikXqo2A2bGVo6BkwvBw5pE4yCFEhi++s48dS
         neRqwiP5BdW3uMWa+5RCYAJhf4vpjGo1Df76HYhxl6cAkvuxpW4rM209tBJ6fPAx7/pe
         sirX2WfiODq7Tb0JW62ESsaMh8Uof12ydv+jD1/7s3j3IpYQIHwhIwO/08WJH2xqvIqB
         iyg4bOVVO3o+2VGIpg2bRle9+qbJUJFNT0QPulJPfN/GCkrofzFdP/gSImM/e+WcdwYp
         IGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=/UP/QGQaXaqsK7SEwrO4ciu6HJVg07eV/I+BRaRipSE=;
        b=bT5fNp+OetYYxiocFDiimFTg8jvLQ20scldrBIGF+MhDgOgQEcZ/nxAOf2XKd1LHxc
         4RP4xsDRylOVILUz8jZLkR7paPHcgP5VDrln0PF4VcbPY2xFqK9U51s6QlhPTw/Arfkb
         SQxE1XEbIzpCiYXcQWWtmUsAzX+kToar0nDZzCJ3aTdHusXoa7T4t9qCPruCDQFQvuFJ
         2tN/IDmmE1nKkKE6OFDFfmMWVFnlhCxQl+AOCHsWv392FAPmWWz94SP9HO5Er5oqAHvc
         0PD2o77D3w9cTXXMDeyHXm52JknXQS2iO17hgoT6nRvWHSQJRt46PVjkpCvoKZ/88F2x
         K/4Q==
X-Gm-Message-State: APjAAAUaop0wSay+Zo8jT3Uan8KQ02kKykt5xH2yKvQgpBM3BkUaH5Hj
        NVbguEkseIuI5O51rgqE66mB8xNF
X-Google-Smtp-Source: APXvYqySu1Xg3vUt+QjrsudMVgl3Uua99qYPXxbWk7GpPpalZvFuhg7qtNZ9MdIZ8IL7VEBH9wTqUw==
X-Received: by 2002:a5d:424a:: with SMTP id s10mr5771643wrr.327.1557139935494;
        Mon, 06 May 2019 03:52:15 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r9sm9307363wrv.82.2019.05.06.03.52.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 May 2019 03:52:14 -0700 (PDT)
Date:   Mon, 6 May 2019 12:52:12 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/timers updates for v5.2
Message-ID: <20190506105212.GA45768@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-timers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-for-linus

   # HEAD: 81423c37415fe45057d64196ae0ce8e17a9c7148 x86/timer: Don't inline __const_udelay()

Two changes: an LTO improvement, plus the new 'nowatchdog' boot option to 
disable the clocksource watchdog.

 Thanks,

	Ingo

------------------>
Andi Kleen (1):
      x86/timer: Don't inline __const_udelay()

Juri Lelli (1):
      x86/tsc: Add option to disable tsc clocksource watchdog


 Documentation/admin-guide/kernel-parameters.txt | 4 ++++
 arch/x86/kernel/tsc.c                           | 5 ++++-
 arch/x86/lib/delay.c                            | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2b8ee90bb644..c4d830003b21 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4703,6 +4703,10 @@
 			[x86] unstable: mark the TSC clocksource as unstable, this
 			marks the TSC unconditionally unstable at bootup and
 			avoids any further wobbles once the TSC watchdog notices.
+			[x86] nowatchdog: disable clocksource watchdog. Used
+			in situations with strict latency requirements (where
+			interruptions from clocksource watchdog are not
+			acceptable).
 
 	turbografx.map[2|3]=	[HW,JOY]
 			TurboGraFX parallel port interface
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 3fae23834069..aab0c82e0a0d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -283,6 +283,7 @@ int __init notsc_setup(char *str)
 __setup("notsc", notsc_setup);
 
 static int no_sched_irq_time;
+static int no_tsc_watchdog;
 
 static int __init tsc_setup(char *str)
 {
@@ -292,6 +293,8 @@ static int __init tsc_setup(char *str)
 		no_sched_irq_time = 1;
 	if (!strcmp(str, "unstable"))
 		mark_tsc_unstable("boot parameter");
+	if (!strcmp(str, "nowatchdog"))
+		no_tsc_watchdog = 1;
 	return 1;
 }
 
@@ -1349,7 +1352,7 @@ static int __init init_tsc_clocksource(void)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (tsc_clocksource_reliable)
+	if (tsc_clocksource_reliable || no_tsc_watchdog)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
 
 	if (boot_cpu_has(X86_FEATURE_NONSTOP_TSC_S3))
diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index f5b7f1b3b6d7..b7375dc6898f 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -162,7 +162,7 @@ void __delay(unsigned long loops)
 }
 EXPORT_SYMBOL(__delay);
 
-void __const_udelay(unsigned long xloops)
+noinline void __const_udelay(unsigned long xloops)
 {
 	unsigned long lpj = this_cpu_read(cpu_info.loops_per_jiffy) ? : loops_per_jiffy;
 	int d0;
