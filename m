Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF6FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1387C217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 12:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfHZMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 08:53:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:58254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728053AbfHZMxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 08:53:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F0EF5AD69;
        Mon, 26 Aug 2019 12:53:49 +0000 (UTC)
Date:   Mon, 26 Aug 2019 14:53:42 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190826125342.GC28610@zn.tnic>
References: <CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com>
 <20190825173000.GB20639@zn.tnic>
 <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
 <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190825201723.GG20639@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:17:23PM +0200, Borislav Petkov wrote:
> > I think WARN_ONCE() is good. It's big enough that it will show up in
> > dmesg if anybody looks, and if nobody looks I think distros still have
> > logging for things like that, don't they?
> 
> Probably. Lemme research that.

So there's a whole bunch of daemons doing desktop notifications along with a
desktop notifications spec, yadda yadda:

https://wiki.archlinux.org/index.php/Desktop_notifications

but installing an openSUSE Leap 15.1 in a guest and that is a default
desktop installation doesn't give me any notifications. I installed
notification-daemon and whatnot but nada.

Which means, that we cannot guarantee that every user would see it.
There might be installations which miss it.

So the only thing I can think of right now is to make that single line
pr_emerg() so that it atleast spews into the terminals when suspending:

linux-6qfo:~ # echo "suspend" > /sys/power/disk
linux-6qfo:~ # echo "mem" > /sys/power/state

<--- resume guest.

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.416145] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.423091] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.427426] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.434699] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.442587] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.449047] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.456328] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.462198] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.470120] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.477302] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.484605] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.490115] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.497508] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.505350] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

Message from syslogd@linux-6qfo at Aug 26 14:48:05 ...
 kernel:[   40.513336] RDRAND gives funky smelling output, might consider not using it by booting with "nordrand"

---

Assuming the user has at least a single terminal open. But someone might
have a better idea.

Current diff:

---
commit d46b23c4be1b4acae7d21c97be189131e200f6d0 (HEAD -> refs/heads/rc5+1-rdrand)
Author: Borislav Petkov <bp@suse.de>
Date:   Sun Aug 25 22:50:18 2019 +0200

    WIP

    Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
    Signed-off-by: Borislav Petkov <bp@suse.de>

diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 5c900f9527ff..b02d1ce91081 100644
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
@@ -42,5 +43,27 @@ void x86_init_rdrand(struct cpuinfo_x86 *c)
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
+	if (!changed) {
+		pr_emerg(
+"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
+		WARN_ON_ONCE(1);
+	}
+
+
 }
 #endif
---

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München
