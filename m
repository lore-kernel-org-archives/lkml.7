Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0934C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D5020872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhMAYukP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393860AbfIJKjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:39:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37282 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406095AbfIJKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id y5so5078153lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DyCC3oN5QH71JUakHHjEAPConBRmS2tSFKyztM41paE=;
        b=FhMAYukPpvDv7/gtjvzMVffNFIcDir8P7lhYYYuvZqn4IPk+26vo++/gi2+Fav2lWS
         2w0rg43pR85xehveQr2y20Sf/xWGy45hcqxm7n5KfvKC2PdHKZ6azaDS0+iYJZHWv1/+
         zMwP5U8nJdDKd8kvKct4XQscyL1qzi10v+C7XVeZ/0iF69+cTYXeXEAhfbRNBY468TnA
         VezYYJjJ+KsPBLPpikBZqQ6oUaHLKB+BF6InRcmk7Ytt+iqa3y4EEVs9FZpRxH5cotkr
         7Ef3YwV3rL6+eb+gar6COnTsoDiKOZ25XOCDZqnqyhZkiIwjkVECAFNb9X0bDFAcZPXG
         yNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DyCC3oN5QH71JUakHHjEAPConBRmS2tSFKyztM41paE=;
        b=AnNVIGdBpPSvq1RSUV89ImrOj9iO6riL2saoD4THCIpO506GL/H0OY5kIFxm2o6vZn
         woo7IIMZIIJgr4JQWd0guOKP+/f4WrjHi7z87PC4mKn/Jh+r5Vish61nfdzoJ+J+k7kW
         xTebzZodfgb9YP8nZ6mEd9EEmm6cEfqKLyUxCpgnbcg7zC9j8xLfkAR5gj5c4ByBq3pj
         UYK7ZaBO9iYEfPEzC5O07tsjKvr0v7tBvj60zLMu45oHrOwqTyS4tKdsER9agaDC00uY
         eh6jMrIOUwe73ChKaJ5V7amcGfO8+3AOayuWpg8Bluw3ygxyJO+vekMIIhP+rk1Jrr+b
         l+JA==
X-Gm-Message-State: APjAAAU+nAH4xKQGBUqrdGfHtyrFfCoU7JAnbXQuFqtoN4PJl+9oW9YT
        oi0o/AFErim+uau3Ualf6YLjPQ==
X-Google-Smtp-Source: APXvYqxOsqB5Qrm2bZatpQr6CyMgppZz7Iosl+BJ7mcaALwpPlhPC6d/y2pyG5m6T3FhlNsd6UsZ9A==
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr19550313ljk.39.1568111929860;
        Tue, 10 Sep 2019 03:38:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:49 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 10/11] libbpf: makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf targets
Date:   Tue, 10 Sep 2019 13:38:29 +0300
Message-Id: <20190910103830.20794-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of LDFLAGS and EXTRA_CC/CXX flags there is no way to pass them
correctly to build command, for instance when --sysroot is used or
external libraries are used, like -lelf, wich can be absent in
toolchain. This is used for samples/bpf cross-compiling allowing to
get elf lib from sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile   |  8 +++++++-
 tools/lib/bpf/Makefile | 11 ++++++++---
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 79c9aa41832e..4edc5232cfc1 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -186,6 +186,10 @@ ccflags-y += -I$(srctree)/tools/perf
 ccflags-y += $(D_OPTIONS)
 ccflags-y += -Wall
 ccflags-y += -fomit-frame-pointer
+
+EXTRA_CXXFLAGS := $(ccflags-y)
+
+# options not valid for C++
 ccflags-y += -Wmissing-prototypes
 ccflags-y += -Wstrict-prototypes
 
@@ -252,7 +256,9 @@ clean:
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
+	$(MAKE) -C $(dir $@) RM='rm -rf' EXTRA_CFLAGS="$(PROGS_CFLAGS)" \
+		EXTRA_CXXFLAGS="$(EXTRA_CXXFLAGS)" LDFLAGS=$(PROGS_LDFLAGS) \
+		srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index c6f94cffe06e..bccfa556ef4e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -94,6 +94,10 @@ else
   CFLAGS := -g -Wall
 endif
 
+ifdef EXTRA_CXXFLAGS
+  CXXFLAGS := $(EXTRA_CXXFLAGS)
+endif
+
 ifeq ($(feature-libelf-mmap), 1)
   override CFLAGS += -DHAVE_LIBELF_MMAP_SUPPORT
 endif
@@ -176,8 +180,9 @@ $(BPF_IN): force elfdep bpfdep
 $(OUTPUT)libbpf.so: $(OUTPUT)libbpf.so.$(LIBBPF_VERSION)
 
 $(OUTPUT)libbpf.so.$(LIBBPF_VERSION): $(BPF_IN)
-	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
-				    -Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
+	$(QUIET_LINK)$(CC) $(LDFLAGS) \
+		--shared -Wl,-soname,libbpf.so.$(LIBBPF_MAJOR_VERSION) \
+		-Wl,--version-script=$(VERSION_SCRIPT) $^ -lelf -o $@
 	@ln -sf $(@F) $(OUTPUT)libbpf.so
 	@ln -sf $(@F) $(OUTPUT)libbpf.so.$(LIBBPF_MAJOR_VERSION)
 
@@ -185,7 +190,7 @@ $(OUTPUT)libbpf.a: $(BPF_IN)
 	$(QUIET_LINK)$(RM) $@; $(AR) rcs $@ $^
 
 $(OUTPUT)test_libbpf: test_libbpf.cpp $(OUTPUT)libbpf.a
-	$(QUIET_LINK)$(CXX) $(INCLUDES) $^ -lelf -o $@
+	$(QUIET_LINK)$(CXX) $(CXXFLAGS) $(LDFLAGS) $(INCLUDES) $^ -lelf -o $@
 
 $(OUTPUT)libbpf.pc:
 	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
-- 
2.17.1

