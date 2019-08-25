Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BFDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D42206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 20:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfHYURb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 16:17:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:51840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728730AbfHYURa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 16:17:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 88870AE12;
        Sun, 25 Aug 2019 20:17:29 +0000 (UTC)
Date:   Sun, 25 Aug 2019 22:17:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190825201723.GG20639@zn.tnic>
References: <156672618029.19810.9732807383797358917.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic>
 <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
 <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 12:59:25PM -0700, Linus Torvalds wrote:
> I think WARN_ONCE() is good. It's big enough that it will show up in
> dmesg if anybody looks, and if nobody looks I think distros still have
> logging for things like that, don't they?

Probably. Lemme research that.

> Hopefully this never actually triggers in practice, thanks to rdrand
> being turned off on known-bad machines now, and Zen 2 being fixed.

Right. Here's v2, will do a proper patch tomorrow:

---
diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 5c900f9527ff..00a9d13c0a92 100644
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
+		WARN_ONCE(1,
+"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
+
 }
 #endif


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München
