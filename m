Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D736DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC75217F4
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 18:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfHYS33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 14:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:37440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728828AbfHYS33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 14:29:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E90B9ADAA;
        Sun, 25 Aug 2019 18:29:27 +0000 (UTC)
Date:   Sun, 25 Aug 2019 20:29:22 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pu Wen <puwen@hygon.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190825182922.GC20639@zn.tnic>
References: <156672618029.19810.8479315461492191933.tglx@nanos.tec.linutronix.de>
 <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic>
 <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:37:47AM -0700, Linus Torvalds wrote:
> On Sun, Aug 25, 2019 at 10:30 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > Should we do that somewhere in the early boot code by adding a WARN_ON()
> > or so and see who screams?
> 
> It might be a good idea, just to see if it ever happens (again).
> 
> It doesn't even have to be early boot. It's probably more important to
> let the user _know_, than it is to then disable the rdrand
> instruction.
> 
> Particularly since we might as well just do it in general, and in the
> general case we don't even know how to hide it in cpuid. So maybe just
> something like "read the rdrand value a few times, make sure it
> actually changes" at CPU bring-up (both boot and resume)
> 
> It sounds like a stupid test, but considering that AMD has had this
> particular bug now several times over at least three different
> generations, maybe it's not a stupid test after all.

My lazy, sticky Sunday brain could come up only with this:

---
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 5c900f9527ff..0130a4f4f836 100644
--- a/arch/x86/kernel/cpu/rdrand.c
+++ b/arch/x86/kernel/cpu/rdrand.c
@@ -29,7 +29,8 @@ __setup("nordrand", x86_rdrand_setup);
 #ifdef CONFIG_ARCH_RANDOM
 void x86_init_rdrand(struct cpuinfo_x86 *c)
 {
-	unsigned long tmp;
+	unsigned int changed = 0;
+	unsigned long tmp, prev;
 	int i;
 
 	if (!cpu_has(c, X86_FEATURE_RDRAND))
@@ -42,5 +43,24 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
 			return;
 		}
 	}
+
+	/*
+	 * Stupid sanity-check whether RDRAND does *actually* generate
+	 * some at least random-looking data.
+	 */
+	prev = tmp;
+	for (i = 0; i < SANITY_CHECK_LOOPS; i++) {
+		if (rdrand_long(&tmp)) {
+			if (prev != tmp)
+				changed++;
+
+			prev = tmp;
+		}
+	}
+
+	if (!changed)
+		WARN(1,
+"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
+
 }
 #endif

---

> Who knows what the Chinese CPU's that use the AMD core do? Hygon?
> Whatever. Did they get the firmware fixes?

Pu Wen?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München
