Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B74C433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 00:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B2F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 00:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfHEAjg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 20:39:36 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:42205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726764AbfHEAjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 20:39:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 766B38368EF9;
        Mon,  5 Aug 2019 00:39:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: month02_52fa7dd9df92b
X-Filterd-Recvd-Size: 7568
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Aug 2019 00:39:30 +0000 (UTC)
Message-ID: <49b659d8f88f67c736881224203418f59a5d29ac.camel@perches.com>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Date:   Sun, 04 Aug 2019 17:39:28 -0700
In-Reply-To: <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com>
         <c0669a7130645a20e99915385b7e712360c31ed9.camel@perches.com>
         <CAHk-=wg1PAJR6ChVXE7O_H2wEG=1mWxi2uc0fH5bthOC_81uTA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-04 at 11:09 -0700, Linus Torvalds wrote:
> On Sun, Aug 4, 2019 at 11:01 AM Joe Perches <joe@perches.com> wrote:
> > Linus?  Do you have an opinion about this RFC/patch?
> 
> So my only real concern is that the comment approach has always been
> the really traditional one, going back all the way to 'lint' days.
> 
> And you obviously cannot use a #define to create a comment, so this
> whole keyword model will never be able to do that.
> 
> At the same time, all the modern tools we care about do seem to be
> happy with it, either through the gcc attribute, the clang
> [[clang:fallthrough]] or the (eventual) standard C [[fallthrough]]
> model.

(adding Nick Desaulniers and clang-built-linux to cc's)

As far as I can tell, clang 10 (and it took hours to compile
and link the most current version here) does not support
	-Wimplicit-fallthrough=3
and using just -Wimplicit-fallthrough with clang 10 does not emit
a fallthrough warning even with -Wextra and -Wimplicit-fallthrough
using switch / case code blocks like:
---
 lib/test_module.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/lib/test_module.c b/lib/test_module.c
index debd19e35198..30c835178c7c 100644
--- a/lib/test_module.c
+++ b/lib/test_module.c
@@ -14,6 +14,21 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 
+static int switch_case(int val)
+{
+	int i = 0;
+
+	switch (val) {
+	case 1:
+		i |= 1;
+	case 2:
+		i |= 2;
+		break;
+	}
+
+	return i;
+}
+
 static int __init test_module_init(void)
 {
 	pr_warn("Hello, world\n");
---

Given:

$ clang -v
clang version 10.0.0 (git://github.com/llvm/llvm-project.git 305b961f64b75e73110e309341535f6d5a48ed72)

and the compilation command line:
$ clang -Wp,-MD,lib/.test_module.o.d  -nostdinc -isystem /usr/local/lib/clang/10.0.0/include -I./arch/x86/include -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi -I./arch/x86/include/generated/uapi -I./include/uapi -I./include/generated/uapi -include ./include/linux/kconfig.h -include ./include/linux/compiler_types.h -D__KERNEL__ -Qunused-arguments -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE -Werror=implicit-function-declaration -Werror=implicit-int -Wno-format-security -std=gnu89 -no-integrated-as -Werror=unknown-warning-option -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -m64 -mno-80387 -mstack-alignment=8 -mtune=generic -mno-red-zone -mcmodel=kernel -DCONFIG_X86_X32_ABI -DCONFIG_AS_CFI=1 -DCONFIG_AS_CFI_SIGNAL_FRAME=1 -DCONFIG_AS_CFI_SECTIONS=1 -DCONFIG_AS_SSSE3=1 -DCONFIG_AS_AVX=1 -DCONFIG_AS_AVX2=1 -DCONFIG_AS_AVX512=1 -DCONFIG_AS_SHA1_NI=1 -DCONFIG_AS_SHA256_NI=1 -Wno-sign-compare -fno-a
 synchronous-unwind-tables -mretpoline-external-thunk -fno-delete-null-pointer-checks -Wno-address-of-packed-member -O2 -Wframe-larger-than=2048 -fstack-protector-strong -Wno-format-invalid-specifier -Wno-gnu -Wno-tautological-compare -mno-global-merge -Wno-unused-const-variable -DCC_USING_FENTRY -Wdeclaration-after-statement -Wvla -Wno-pointer-sign -fno-strict-overflow -fno-merge-all-constants -fno-stack-check -Werror=date-time -Werror=incompatible-pointer-types -fcf-protection=none -Wno-initializer-overrides -Wno-format -Wno-sign-compare -Wno-format-zero-length     -fsanitize=kernel-address -mllvm -asan-mapping-offset=0xdffffc0000000000  -mllvm -asan-globals=1  -mllvm -asan-instrumentation-with-call-threshold=0  -mllvm -asan-stack=0   --param asan-instrument-allocas=1   -fsanitize-coverage=trace-pc -fsanitize-coverage=trace-cmp  -DMODULE  -DKBUILD_BASENAME='"test_module"' -DKBUILD_MODNAME='"test_module"' -Wextra -Wimplicit-fallthrough -c -o lib/test_module.o lib/test_module.c

> So I'm ok with just saying "the comment model may be traditional, but
> it's not very good".
> 
> I didn't look at all the patches, but the one I *did* see had a few issues:
> 
>  - it didn't seem to handle clang

The __has_attribute use is at least clang compatible.
https://releases.llvm.org/3.7.0/tools/clang/docs/LanguageExtensions.html
even if it doesn't (seem to?) work.

>  - we'd need to make -Wimplicit-fallthrough be dependent on the
> compiler actually supporting the attribute, not just on supporting the
> flag.

I believe that also needs work if ever clang works,

Makefile:KBUILD_CFLAGS += $(call cc-option,-Wimplicit-fallthrough=3,)

this will have to be changed for clang as the =<val> isn't (yet?) supported.

> without those changes, nobody can actually start doing any
> conversions. But I assume such patches exist somewhere, and I've just
> missed them.

I haven't sent any patches for any comment conversions.
nor would I until the RFC is acceptable.

Just this RFC and the necessary conversion of the one use
of fallthrough as a label (which David Miller did not apply)

Some people reasonably feel that Coverity should recognize
fallthrough; style annotations before changing the existing
/* fallthrough */ comment uses.  I think lint doesn't matter
much.

I do have a script that does a reasonable job of converting
most of the /* fallthrough */ style comments to fallthrough;
while realigning to the last indentation.

That script still needs more work before I will post it.

Lastly:

I think using the pseudo-keyword
	fallthrough;
reads better than
	__fallthrough;
to end case blocks.

Do you have an opinion here?


