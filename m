Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20492C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F414E208C4
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 22:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbfHIW6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 18:58:50 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:47251 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729533AbfHIW6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:58:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BC25C1801C4F4;
        Fri,  9 Aug 2019 22:58:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: net87_4c35b90f10723
X-Filterd-Recvd-Size: 3471
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Aug 2019 22:58:43 +0000 (UTC)
Message-ID: <7c4db60a2b1976a92b5c824c7d24c4c77aa57278.camel@perches.com>
Subject: Re: checkpatch.pl should suggest __section
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 09 Aug 2019 15:58:41 -0700
In-Reply-To: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
References: <CAKwvOdmNdvgv=+P1CU36fG+trETojmPEXSMmAmX2TY0e67X-Wg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 15:21 -0700, Nick Desaulniers wrote:
> Hi Joe,
> While debugging:
> https://github.com/ClangBuiltLinux/linux/issues/619
> we found a bunch of places where __section is not used but could be,
> and uses a string literal when it probably should not be.
> 
> Just a thought that maybe checkpatch.pl could warn if
> `__attribute__((section` appeared in the added diff, and suggest
> __section? Then further warn to not use `""` for the section name?

Hmm, that makes me wonder about the existing __section uses
_with_ a quote are actually in the proper sections.

$ git grep -n -P '\b__section\s*\(\s*"'
arch/arm64/kernel/smp_spin_table.c:22:volatile unsigned long __section(".mmuoff.data.read")
arch/s390/boot/startup.c:49:static struct diag210 _diag210_tmp_dma __section(".dma.data");
include/linux/compiler.h:27:                            __section("_ftrace_annotated_branch")   \
include/linux/compiler.h:63:            __section("_ftrace_branch")             \
include/linux/compiler.h:121:#define __annotate_jump_table __section(".rodata..c_jump_table")
include/linux/compiler.h:158:   __section("___kentry" "+" #sym )                        \
include/linux/compiler.h:301:   static void * __section(".discard.addressable") __used \
include/linux/export.h:107:     static int __ksym_marker_##sym[0] __section(".discard.ksym") __used
include/linux/srcutree.h:127:           __section("___srcu_struct_ptrs") = &name

Maybe there should also be a __section("<foo>") test too.

Anyway, how about:
---
 scripts/checkpatch.pl | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1cdacb4fd207..8e6693ca772c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5901,6 +5901,15 @@ sub process {
 			     "__aligned(size) is preferred over __attribute__((aligned(size)))\n" . $herecurr);
 		}
 
+# Check for __attribute__ section, prefer __section (without quotes)
+		if ($realfile !~ m@\binclude/uapi/@ &&
+		    $line =~ /\b__attribute__\s*\(\s*\(.*_*section_*\s*\(\s*("[^"]*")/) {
+			my $old = substr($rawline, $-[1], $+[1] - $-[1]);
+			my $new = substr($old, 1, -1);
+			WARN("PREFER_SECTION",
+			     "__section($new) is preferred over __attribute__((section($old)))\n" . $herecurr);
+		}
+
 # Check for __attribute__ format(printf, prefer __printf
 		if ($realfile !~ m@\binclude/uapi/@ &&
 		    $line =~ /\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf/) {



