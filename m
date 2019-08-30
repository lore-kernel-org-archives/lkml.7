Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E4020673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OmaVkDBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbfH3Avb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:51:31 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35888 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfH3Auu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id u15so4828826ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XM+El1wyypVfaXfQc7FxTfECR5DYv9zUGiXmgC/VC5g=;
        b=OmaVkDBxJbEbiNuH6B/lkHNi7X3Ced5VCYrN4v0FOemALIxV7B1RR9GTxi+wIA+o7S
         SBNyfehZvn7LwSQMr71oX1EDAOy9VvdgFs/9kHugoMQYd2qS/DSS2mvw8yXRcG/xHDV5
         0mJnXZcKmURGOdcozYB23tdigAAVVt6MHRP2J5RqtdSKEIJwvommRUF3YZCu8WcJ+ZRQ
         9xYKzJ+pyiAczzLTKz6YMx84NzIkCgZakeJ1s58kckrg9aSB/Vdpg5FlpqJZCT257v3w
         UK5VqvNfJ4lXH3Sy/1qHZ5bEXEsMC6tIogRp0+fgccQf0ld0ru8mbbg+8L8dATJfDqle
         zUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XM+El1wyypVfaXfQc7FxTfECR5DYv9zUGiXmgC/VC5g=;
        b=cpwXuoLkQW1TRo9GnsYBm0V9ifkVhg5AgTnMK6Hpdq0A63z7prt/KKFOwaEOxBfZ8t
         XfX+6LSbCsSDD4nsglGQY6+3OXXNTnD2PTJ1+e76QrpbbTIMDBfdED0fLWM1v6WIEi0Q
         yYrZyK/VLoiWiH2fsAHfcCuVwv6aN0ehxcXdVkL8K4JT/cUsqMtz2T8GEDtr0yAAq+x6
         pydEz9VBVV/lOagl4lwX49dYUoYQSUTWc6r6DpBp1Gyv6R/Y0yYt9AIoQiQACDgftHRl
         EEfogrXQ+oGceJU1rSOXKbRZKUQKxuey8fZBVD6OFhNO3ETLZMrVg+zu3gYsTzjZaeD0
         hr7w==
X-Gm-Message-State: APjAAAXpSXOkQJmxoMtxNu4QNoMDBv4pRNNM6E0NG2HLQh5RtKB/8OTg
        YdbWcJzOTEbgq5vFXjOtftP1A2xLtso=
X-Google-Smtp-Source: APXvYqzmBCVvXKFOXoBDuj58+fjrCfnA51PDqBxjQDtiM9x+Qz3HalHYI72Y8f2Nsv+B0cm1QW0ySg==
X-Received: by 2002:a2e:85d4:: with SMTP id h20mr7058874ljj.134.1567126248121;
        Thu, 29 Aug 2019 17:50:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 05/10] samples: bpf: Makefile: use vars from KBUILD_CFLAGS to handle linux headers
Date:   Fri, 30 Aug 2019 03:50:32 +0300
Message-Id: <20190830005037.24004-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel headers are reused from samples bpf, and autoconf.h is not
enough to reflect complete configuration for clang. One of such
configurations is __LINUX_ARM_ARCH__ min version used as instruction
set selector. In another case an error like "SMP is not
supported" for arm and others errors are issued and final object is
not correct.
---
 samples/bpf/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cdd742c05200..9232efa2b1b3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -186,6 +186,13 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+# Strip all expet -D options needed to handle linux headers
+# for arm it's __LINUX_ARM_ARCH__ and potentially others fork vars
+D_OPTIONS = $(shell echo "$(KBUILD_CFLAGS) " | sed 's/[[:blank:]]/\n/g' | \
+	sed '/^-D/!d' | tr '\n' ' ')
+
+CLANG_EXTRA_CFLAGS += $(D_OPTIONS)
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

