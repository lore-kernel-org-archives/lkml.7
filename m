Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A74C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F372089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7UfO+FT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436559AbfIJKir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:38:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45123 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406052AbfIJKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:45 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so13001641lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2CISuDOqpRrytITzE2bzjW1/55vOTPEJWp8ToeKeR/s=;
        b=P7UfO+FTl1bnzu58ITbd2c6ZsAqQrt8Qa1tZHEKjiRiiGqt4NsWRiu1jKrm7bdxgfl
         ORiWhKn4HTpMA7X/BlerAFmJfDj66KexpV3883rEICKB3oibNnHNbMTriwzuasJhOwhd
         6U5eZvYvHKZgO3w6I4GkuD+ksR0NvR+5nMNkTwqMzO6QQF+QyIKbyxt8DPDSgk4ELsis
         hJxSS1nCRfzKd2XnW/zsh1U5A0kDPAUV2sEDRbeyjjB7JiOZsE6gxdVD5RVR5LrE2XNf
         d7CAthgXfH5bWJ5MBh3D+HX10ChBb/Sobj2KWiGwXwVb086DHwlDeknb9+lb07r3Ec3D
         PktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2CISuDOqpRrytITzE2bzjW1/55vOTPEJWp8ToeKeR/s=;
        b=DbR194JWppXOEDgkib4t5ygrJbN5aqen4r+afVySCU1RzKKvj9fdycqEy1J0RS659o
         g0IWHlW5NZmKhTd3WBxyvpEvGdm8oXNlf/yiCQ7R4eQliAuGGDtmeLdnIyu+GtDjPA4e
         qir6Z4meD4yuHhi/0JFz13zUtf8VD8bGC5ElGJfpwVtGritnW8Bn6CO6Naj1dW+gkpXt
         YOMAAYfhwWDz7zGXiYzQXJ39V+MqRLYAxOhiLyjkhgqcY1vEvlG13LRSlb9uC5dEKJqq
         Loabl4l6VOXf2WAkgUSvwIjkm/M35ONWBkW0Wl+lhtjONhNo4vjrccUq4aVvtKBTo3g3
         Bf/w==
X-Gm-Message-State: APjAAAXrQJNGPEhj2lsqoALvmw+hVhhEyIzT2E61csdUezWRW1FlP6zL
        wv0aevkVSJhMPzVmuBiTZsBCSQ==
X-Google-Smtp-Source: APXvYqwxnFgrMvinHMpD4LTIH77NFShlAyEJYi+fa1UnKTZm5JEDz3B85lz/FeukiyyOX8a6q+WR7g==
X-Received: by 2002:a19:381a:: with SMTP id f26mr19784105lfa.168.1568111923667;
        Tue, 10 Sep 2019 03:38:43 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 05/11] samples: bpf: makefile: use D vars from KBUILD_CFLAGS to handle headers
Date:   Tue, 10 Sep 2019 13:38:24 +0300
Message-Id: <20190910103830.20794-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel headers are reused from samples bpf, and autoconf.h is not
enough to reflect complete arch configuration for clang. But CLANG-bpf
cmds are sensitive for assembler part taken from linux headers and -D
vars, usually used in CFLAGS, should be carefully added for each arch.
For that, for CLANG-bpf, lets filter them only for arm arch as it
definitely requires __LINUX_ARM_ARCH__ to be set, but ignore for
others till it's really needed. For arm, -D__LINUX_ARM_ARCH__ is min
version used as instruction set selector. In another case errors
like "SMP is not supported" for arm and bunch of other errors are
issued resulting to incorrect final object.

Later D_OPTIONS can be used for gcc part.
---
 samples/bpf/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 8ecc5d0c2d5b..6492b7e65c08 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -185,6 +185,15 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+# Strip all expet -D options needed to handle linux headers
+# for arm it's __LINUX_ARM_ARCH__ and potentially others fork vars
+D_OPTIONS = $(shell echo "$(KBUILD_CFLAGS) " | sed 's/[[:blank:]]/\n/g' | \
+	sed '/^-D/!d' | tr '\n' ' ')
+
+ifeq ($(ARCH), arm)
+CLANG_EXTRA_CFLAGS := $(D_OPTIONS)
+endif
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

