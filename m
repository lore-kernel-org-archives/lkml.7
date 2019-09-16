Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A10C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B27B206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9WHFu0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfIPKzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:55:24 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33541 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732547AbfIPKy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so33277842ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MLJcNNJZkagwGK0zIyaqmigCmuc2QO9sJ0CkQCG94a8=;
        b=E9WHFu0TVM9YPIg7e9FZQRJiw7GUUX46qDnJ7XJhp3tzqNkGIEkdZ/VfJkd5CiXCIu
         soL1+mGe5drovecAMdpE93IRIhgR5mqv5Inm7FMZtz3sR+ufpAD/Vj+CYguj9jaX979F
         eFqpi/6RF90/XKCxiwnqHbTubyY2+/Q2q7UmsEzAUVdYX0iubLOvOOMtNb6rLhLftlI8
         LGDNDWirLx7qPTGiEj+xYJs+l+TAonQmkRLwyJcjWSOCrpnM1a9qakwXyDalWaCOcOpj
         avbgMt/cu6EWydrCF+LYQy6vWHBc6xfHcI6HCINSXEg03CYbhAha+4hat/DwPB08BSH0
         IXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MLJcNNJZkagwGK0zIyaqmigCmuc2QO9sJ0CkQCG94a8=;
        b=ixgkfsE1g5RJNWxjTltbkwxOr/hsB9566bs0uEt1MHmsEXgTnVIZogiqTnSbExnGvW
         wB22/PZNbGTI2zXB4P8yp6/iTC4mm99d8g0Y8o+7MQt2xGC+oRRg/v4iFmCLER5Hpt1a
         0Cy2QCoHUpJC7zJJODSHFHt5C+fvHCVI0LH0Z6oN5Bm0VV6RhjtR6iFZ7lIXptabBklC
         vuoPhz6uX0Aw3/JsnmZra/I11xeLmqRr2cTIHUt6SZZY8m7uDC6dpcGAbOH6mkEu7Dsi
         6UVw4Ze0j9NPAUArO5B858buyjR1+fB9oX1VDK18hyGD2YK4p4+0mRpRZpT/7sJMQ/vs
         1M7w==
X-Gm-Message-State: APjAAAU/khHl0nLWuGTcCg7Xqy+jYcAP0byAizMHOhIVADChJBVmBg7/
        LjgqWLCszfKikdEdL5L+CiU6WA==
X-Google-Smtp-Source: APXvYqwG3Sc5PdJ1BDI/ndJboxqwuppsJ0jjMTGaqjlVv0sD9MuujWpRu2ErqSb6ATwnfxiTcaiRgQ==
X-Received: by 2002:a2e:9f17:: with SMTP id u23mr2122827ljk.241.1568631294682;
        Mon, 16 Sep 2019 03:54:54 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:54 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 11/14] libbpf: makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf targets
Date:   Mon, 16 Sep 2019 13:54:30 +0300
Message-Id: <20190916105433.11404-12-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of LDFLAGS and EXTRA_CC/CXX flags there is no way to pass them
correctly to build command, for instance when --sysroot is used or
external libraries are used, like -lelf, wich can be absent in
toolchain. This can be used for samples/bpf cross-compiling allowing
to get elf lib from sysroot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 tools/lib/bpf/Makefile | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

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

