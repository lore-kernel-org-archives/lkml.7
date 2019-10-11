Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA273ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C833F214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3MFZlp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfJKA2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46740 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbfJKA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:39 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so5685196lfc.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=t3MFZlp7JrKOCwmfn7u1hOiMi68CPBBmhejF5DP7FCApB0OUHnL1e1Vz0PnjgoLIqj
         wAkQ0GsgS4/ldLyAt8/zw9mgK+sFqHd4lVWktvbzEARep/C0sshXBBKSEaDAGcVo0/6V
         8BTYD9LaGz/q/C5QeVOsLb/AKAwgJehXdhpIyM/J8HjfAaW5Btm4K7VJtZpNYWUEfCbY
         V7wShmtXIoIbmuXnBXoESSkwV7otaZ4ffWiRKF6rodq/UYfP4y6E9PWlD7sMelgEXZIG
         kjdyeC45fhvQOlabnZHkFElf7V9BeT+hBH7v0X8MgAM1mpO27+xgEXiqHAKtawGnSvK1
         yzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dPicZ6dKiXggVDaTmZsHbexmmGF0NBX0XkLCl2NE9e8=;
        b=G/jd0FJGo2pW3POHlZiHx6z21dqm0irLv/xz/VcaGSkCZuOfnPUaCw3VMe3MP57kwn
         VqwxoZ+eDdQVa2kxucjDtCBFLgk06+KjPYLfFRTre+okrTccEgFYUjaoKQKX15o4V89K
         VAq1sL7AdEQ5p8b1KdLNJDrvH+XH7zC295cyxVak7Q/MLh9azH9kxhvVnD26pg4Rc5fr
         Ld3V/Id6w93zSKqMDSdApjIwG739u2A8Xe89B1U5qYLIQbF9lZ4sVJGzij86/z0b1nbL
         so5Q4c6sLZvDnrMDhnNBIMxbMBDjqg7ffvtBHsl6rsyRAjPFziz2JFler07CVMjoPxBF
         OTeA==
X-Gm-Message-State: APjAAAUBcvRICIvIoCIBMTlJaPO5wYfbSPdUmnsqj79p6nqAyhyFveDH
        yNW6gM2fcR8vMpPtzpgNT8HGtw==
X-Google-Smtp-Source: APXvYqzLwdRMPb489Yj1aqW3Q1PJbqbKOk1Y8p49pmLW2Luy9x6kzXc2gUyxjMp2Ov4+EzwjU94LOg==
X-Received: by 2002:a19:c392:: with SMTP id t140mr7564752lff.156.1570753717149;
        Thu, 10 Oct 2019 17:28:37 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:36 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 12/15] libbpf: add C/LDFLAGS to libbpf.so and test_libpf targets
Date:   Fri, 11 Oct 2019 03:28:05 +0300
Message-Id: <20191011002808.28206-13-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of C/LDFLAGS there is no way to pass them correctly to build
command, for instance when --sysroot is used or external libraries
are used, like -lelf, wich can be absent in toolchain. This can be
used for samples/bpf cross-compiling allowing to get elf lib from
sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 46280b5ad48d..75b538577c17 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -174,8 +174,9 @@ bpf_helper_defs.h: $(srctree)/include/uapi/linux/bpf.h
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -183,7 +184,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.c $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CC) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

