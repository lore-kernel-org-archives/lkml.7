Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71C7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57B72184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfH0RkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 13:40:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727306AbfH0RkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 13:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 490C7AF93;
        Tue, 27 Aug 2019 17:40:00 +0000 (UTC)
Date:   Tue, 27 Aug 2019 19:39:55 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Pu Wen <puwen@hygon.cn>, Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/urgent for 5.3-rc5
Message-ID: <20190827173955.GI29752@zn.tnic>
References: <CAHk-=wiV54LwvWcLeATZ4q7rA5Dd9kE0Lchx=k023kgxFHySNQ@mail.gmail.com>
 <20190825182922.GC20639@zn.tnic>
 <CAHk-=wjhyg-MndXHZGRD+ZKMK1UrcghyLH32rqQA=YmcxV7Z0Q@mail.gmail.com>
 <20190825193218.GD20639@zn.tnic>
 <CAHk-=wiBqmHTFYJWOehB=k3mC7srsx0DWMCYZ7fMOC0T7v1KHA@mail.gmail.com>
 <20190825194912.GF20639@zn.tnic>
 <CAHk-=wjcUQjK=SqPGdZCDEKntOZEv34n9wKJhBrPzcL6J7nDqQ@mail.gmail.com>
 <20190825201723.GG20639@zn.tnic>
 <20190826125342.GC28610@zn.tnic>
 <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wj_E58JskechbJyWwpzu5rwKFHEABr4dCZjS+JBvv67Uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 09:55:08AM -0700, Linus Torvalds wrote:
> Side note: I'd suggest
> 
>         if (WARN_ON_ONCE(!changed))
>                 pr_emerg("RDRAND gives funky smelling output, might
> consider not using it by booting with \"nordrand\"");
> 
> instead.

Done, final result with a proper commit message below.

Do you want it this weekend, after some smoke testing on boxes or should
I leave it a couple of weeks in tip until the merge window opens, and
then queue it for 5.4 for longer exposure in linux-next?

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Sun, 25 Aug 2019 22:50:18 +0200
Subject: [PATCH] x86/rdrand: Sanity-check RDRAND output

It turned out recently that on certain AMD F15h and F16h machines, due
to the BIOS dropping the ball after resume, yet again, RDRAND would not
function anymore:

  c49a0a80137c ("x86/CPU/AMD: Clear RDRAND CPUID bit on AMD family 15h/16h")

Add a silly test to the CPU bringup path, to sanity-check the random
data RDRAND returns and scream as loudly as possible if that returned
random data doesn't change.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/CAHk-=wjWPDauemCmLTKbdMYFB0UveMszZpcrwoUkJRRWKrqaTw@mail.gmail.com
---
 arch/x86/kernel/cpu/rdrand.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/rdrand.c b/arch/x86/kernel/cpu/rdrand.c
index 5c900f9527ff..c4be62058dd9 100644
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
+	if (WARN_ON_ONCE(!changed))
+		pr_emerg(
+"RDRAND gives funky smelling output, might consider not using it by booting with \"nordrand\"");
+
 }
 #endif
-- 
2.21.0

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)
-- 
