Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F6C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E4F2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfCRQgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:36:13 -0400
Received: from foss.arm.com ([217.140.101.70]:37352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726806AbfCRQgM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:36:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEC7B174E;
        Mon, 18 Mar 2019 09:36:11 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9F083F614;
        Mon, 18 Mar 2019 09:36:05 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Graeme Barnes <Graeme.Barnes@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kostya Serebryany <kcc@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v2 3/4] arm64: Relax Documentation/arm64/tagged-pointers.txt
Date:   Mon, 18 Mar 2019 16:35:32 +0000
Message-Id: <20190318163533.26838-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318163533.26838-1-vincenzo.frascino@arm.com>
References: <cover.1552679409.git.andreyknvl@google.com>
 <20190318163533.26838-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64 the TCR_EL1.TBI0 bit has been always enabled hence
the userspace (EL0) is allowed to set a non-zero value in the
top byte but the resulting pointers are not allowed at the
user-kernel syscall ABI boundary.

With the relaxed ABI proposed in this set, it is now possible to pass
tagged pointers to the syscalls, when these pointers are in memory
ranges obtained by an anonymous (MAP_ANONYMOUS) mmap() or sbrk().

Relax the requirements described in tagged-pointers.txt to be compliant
with the behaviours guaranteed by the ABI deriving from the introduction
of the ARM64_AT_FLAGS_SYSCALL_TBI flag.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
CC: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/arm64/tagged-pointers.txt | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..df27188b9433 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -18,7 +18,8 @@ Passing tagged addresses to the kernel
 --------------------------------------
 
 All interpretation of userspace memory addresses by the kernel assumes
-an address tag of 0x00.
+an address tag of 0x00, unless the ARM64_AT_FLAGS_SYSCALL_TBI flag is
+set by the kernel.
 
 This includes, but is not limited to, addresses found in:
 
@@ -31,18 +32,23 @@ This includes, but is not limited to, addresses found in:
  - the frame pointer (x29) and frame records, e.g. when interpreting
    them to generate a backtrace or call graph.
 
-Using non-zero address tags in any of these locations may result in an
-error code being returned, a (fatal) signal being raised, or other modes
-of failure.
+Using non-zero address tags in any of these locations when the
+ARM64_AT_FLAGS_SYSCALL_TBI flag is not set by the kernel, may result in
+an error code being returned, a (fatal) signal being raised, or other
+modes of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
-strongly discouraged.
+For these reasons, when the flag is not set, passing non-zero address
+tags to the kernel via system calls is forbidden, and using a non-zero
+address tag for sp is strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
 address tags may suffer impaired or inaccurate debug and profiling
 visibility.
 
+A definition of the meaning of ARM64_AT_FLAGS_SYSCALL_TBI and of the
+guarantees that the ABI provides when the flag is set by the kernel can
+be found in: Documentation/arm64/elf_at_flags.txt.
+
 
 Preserving tags
 ---------------
@@ -57,6 +63,9 @@ be preserved.
 The architecture prevents the use of a tagged PC, so the upper byte will
 be set to a sign-extension of bit 55 on exception return.
 
+This behaviours are preserved even when the ARM64_AT_FLAGS_SYSCALL_TBI flag
+is set by the kernel.
+
 
 Other considerations
 --------------------
-- 
2.21.0

