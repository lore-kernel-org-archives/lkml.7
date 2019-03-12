Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72039C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4249121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413176;
	bh=pniqlRoheXg6hb/eAq/S/qpd27Zij8udGK7C6KeXT+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TLsyCdgCpy3Sru9MoN27pwiKMSd7eNSpT515vfvlXceJZrRypG/+Yw8EEzkIluffT
	 l3psBgsdps9im84ALG+a4mS24x8pd8qplwoUywTqKe9TmBvqtxAsGC33UpsxxjPwir
	 lcz3MSsmDQdlCawreDN0SVMVtqv4Gxy7P5aI6ec8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbfCLRwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbfCLROY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:24 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F9D021741;
        Tue, 12 Mar 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410863;
        bh=pniqlRoheXg6hb/eAq/S/qpd27Zij8udGK7C6KeXT+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2ZTJWUchnpjdktgWFZKPo3XOAaFQEGWZpSYOmGovhCEi+dz+pSblthElndmE372Tz
         1w1jEIC3L2c/xnTQj8ud0NBUpH1fz7lFwFXAntH7UbUOp9TR5FiNt9l05ACHUkpXvX
         4NAu5015G26Lfi9TknhxA+Utu2fQG13+YUrMYU1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fathi Boudra <fathi.boudra@linaro.org>,
        Shuah Khan <shuah@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/149] selftests: net: use LDLIBS instead of LDFLAGS
Date:   Tue, 12 Mar 2019 10:07:30 -0700
Message-Id: <20190312170352.392258552@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 870f193d48c25a97d61a8e6c04e3c29a2c606850 ]

reuseport_bpf_numa fails to build due to undefined reference errors:

 aarch64-linaro-linux-gcc
 --sysroot=/build/tmp-rpb-glibc/sysroots/hikey -Wall
 -Wl,--no-as-needed -O2 -g -I../../../../usr/include/  -Wl,-O1
 -Wl,--hash-style=gnu -Wl,--as-needed -lnuma  reuseport_bpf_numa.c
 -o
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa
 /tmp/ccfUuExT.o: In function `send_from_node':
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:138:
 undefined reference to `numa_run_on_node'
 /tmp/ccfUuExT.o: In function `main':
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:230:
 undefined reference to `numa_available'
 /build/tmp-rpb-glibc/work/hikey-linaro-linux/kselftests/4.12-r0/linux-4.12-rc7/tools/testing/selftests/net/reuseport_bpf_numa.c:233:
 undefined reference to `numa_max_node'

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
libnuma.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 919aa2ac00af..9a3764a1084e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -18,6 +18,6 @@ TEST_GEN_PROGS += reuseport_dualstack reuseaddr_conflict tls
 KSFT_KHDR_INSTALL := 1
 include ../lib.mk
 
-$(OUTPUT)/reuseport_bpf_numa: LDFLAGS += -lnuma
+$(OUTPUT)/reuseport_bpf_numa: LDLIBS += -lnuma
 $(OUTPUT)/tcp_mmap: LDFLAGS += -lpthread
 $(OUTPUT)/tcp_inq: LDFLAGS += -lpthread
-- 
2.19.1



