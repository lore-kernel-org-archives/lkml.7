Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1426C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D15F2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688384;
	bh=b17AQjrOxuWBqAhElYwJexwzZndwmv8K5uNqRmGs54k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TeyckBGu41FujUnvp0Umrg1zDy69R6+aTnYHoy/tZG3CGArzohHjv0g19NJwA+3v3
	 5l+h0gQR2AdUWca5dQ09HxkbD2k+01anqPFa9O+tzV6cl5pQBTHuTsh7xbVSnisRWk
	 4T6u/sOQN1jvbnxopp9zIf0CPIpU+TqvrJoBC0cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbfCDIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:33:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727651AbfCDIdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:33:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F2E821019;
        Mon,  4 Mar 2019 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688378;
        bh=b17AQjrOxuWBqAhElYwJexwzZndwmv8K5uNqRmGs54k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOviQA7wuf9eCbv2P1XloyvFkY+SJ8s8i/S8ErOabcUqxMr35Jk61We6P15EjHlu7
         hQ+L8wVeUTYcdy1pyOXkN1jIyhkljmtj6p6v5sOOLGKJWR2v94A7YiiiztNPsGxuzg
         mUGKUCUEdQUGa6J0CnRUS+CHnkYwj4/+39zadtog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fathi Boudra <fathi.boudra@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 27/88] selftests: seccomp: use LDLIBS instead of LDFLAGS
Date:   Mon,  4 Mar 2019 09:22:10 +0100
Message-Id: <20190304081631.681569982@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5bbc73a841d7f0bbe025a342146dde462a796a5a ]

seccomp_bpf fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc --sysroot=/build/tmp-rpb-glibc/sysroots/hikey
 -O2 -pipe -g -feliminate-unused-debug-types -Wl,-no-as-needed -Wall
 -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -lpthread seccomp_bpf.c -o
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf
 /tmp/ccrlR3MW.o: In function `tsync_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1920: undefined reference to `sem_post'
 /tmp/ccrlR3MW.o: In function `TSYNC_setup':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1863: undefined reference to `sem_init'
 /tmp/ccrlR3MW.o: In function `TSYNC_teardown':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1904: undefined reference to `sem_destroy'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1897: undefined reference to `pthread_kill'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1898: undefined reference to `pthread_cancel'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1899: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_siblings_fail_prctl':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1978: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1990: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1992: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_ancestor':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2016: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2032: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2034: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_sibling_want_nnp':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2046: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2058: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2060: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_no_filter':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2073: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2098: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2100: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_with_one_divergence':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2125: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2143: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2145: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'
 /tmp/ccrlR3MW.o: In function `TSYNC_two_siblings_not_under_filter':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2169: undefined reference to `sem_wait'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2202: undefined reference to `pthread_join'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:2227: undefined reference to `pthread_join'
 /tmp/ccrlR3MW.o: In function `tsync_start_sibling':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/seccomp/seccomp_bpf.c:1941: undefined reference to `pthread_create'

It's GNU Make and linker specific.

The default Makefile rule looks like:

$(CC) $(CFLAGS) $(LDFLAGS) $@ $^ $(LDLIBS)

When linking is done by gcc itself, no issue, but when it needs to be passed
to proper ld, only LDLIBS follows and then ld cannot know what libs to link
with.

More detail:
https://www.gnu.org/software/make/manual/html_node/Implicit-Variables.html

LDFLAGS
Extra flags to give to compilers when they are supposed to invoke the linker,
‘ld’, such as -L. Libraries (-lfoo) should be added to the LDLIBS variable
instead.

LDLIBS
Library flags or names given to compilers when they are supposed to invoke the
linker, ‘ld’. LOADLIBES is a deprecated (but still supported) alternative to
LDLIBS. Non-library linker flags, such as -L, should go in the LDFLAGS
variable.

https://lkml.org/lkml/2010/2/10/362

tools/perf: libraries must come after objects

Link order matters, use LDLIBS instead of LDFLAGS to properly link against
libpthread.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/seccomp/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index fce7f4ce06925..1760b3e397306 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -9,7 +9,7 @@ BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
 
 seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) -lpthread $< -o $@
+	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
 
 TEST_PROGS += $(BINARIES)
 EXTRA_CLEAN := $(BINARIES)
-- 
2.19.1



