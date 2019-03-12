Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B402087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412409;
	bh=ouXu/OaX7uOn5kPU0xE4f69+pGek/rqm+AkfMfMK3yc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRpYUawnv8hFg12xrMObq63u8nnxQ8M8Sk9haNa/O497+5UIP0iGmH0ZsL5E9qfGx
	 9Q6kVQFUbCJHDx98AfASRmn+irx+nKQAS0nraOTe1toryxaQgpfR2OfU3a6zrBDS0a
	 4op/HnBhtPYFxSawrW3ioNEpYJ/EBbZfw5jUvGf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbfCLRkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729045AbfCLRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:16:16 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D213E217D4;
        Tue, 12 Mar 2019 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410974;
        bh=ouXu/OaX7uOn5kPU0xE4f69+pGek/rqm+AkfMfMK3yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgdFInIhQHmtlsej5yrfFUUebZAz3ha+4GmbvHU5u+zXt8HyBS344iSe3an6DXwh/
         Wlc0AubO9UTL25K21xgYxlfndBImo8KRMXd5037BtcgVdo5JOHLumvmT2nNiOpoAB7
         yG97b4oJzZp8B79AQeA5yiqciTybCNrSbuDAF3rw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denys Dmytriyenko <denys@ti.com>,
        Fathi Boudra <fathi.boudra@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/135] selftests: timers: use LDLIBS instead of LDFLAGS
Date:   Tue, 12 Mar 2019 10:08:32 -0700
Message-Id: <20190312170347.289415475@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7d4e591bc051d3382c45caaa2530969fb42ed23d ]

posix_timers fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc --sysroot=/build/tmp-rpb-glibc/sysroots/hikey
 -O2 -pipe -g -feliminate-unused-debug-types -O3 -Wl,-no-as-needed -Wall
 -DKTEST  -Wl,-O1 -Wl,--hash-style=gnu -Wl,--as-needed -lrt -lpthread
 posix_timers.c
 -o /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers
 /tmp/cc1FTZzT.o: In function `check_timer_create':
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers.c:157:
 undefined reference to `timer_create'
 /usr/src/debug/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/timers/posix_timers.c:170:
 undefined reference to `timer_settime'
 collect2: error: ld returned 1 exit status

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

Signed-off-by: Denys Dmytriyenko <denys@ti.com>
Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/timers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 3496680981f2..d937e45532d8 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -O3 -Wl,-no-as-needed -Wall
-LDFLAGS += -lrt -lpthread -lm
+LDLIBS += -lrt -lpthread -lm
 
 # these are all "safe" tests that don't modify
 # system time or require escalated privileges
-- 
2.19.1



