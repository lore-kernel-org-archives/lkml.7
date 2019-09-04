Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1762C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7E872339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cyv0J+ys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbfIDVXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:23:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38389 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbfIDVXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id h3so194422ljb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yAjuHlaJV4iM+XkUvTeUDNJ1TAXGjdj3xJMvNO0S43o=;
        b=Cyv0J+ysGE8GlcBy84R0TU6rZdMLzrvRQiwpquEiozDeaAQQQbYdykncSxj9SDvUie
         8cgkYnKiR0ReAyi40NULGieV75yTwmLbqtUC8erbl75yzlcUtht7eSCMcD96oSjQ6M48
         na1DMKbDpuTpTnG6pBKnr8wpjHOb3yRIBcWZofhCezWk3TBniFS5nn7vx0YuyOh6Lmdh
         HWKQEzLvfpoT2NyKmWajaXus8qX7m3kiia7NxEwBexwDarrjZLHJ3aFVDEsLsVgZRvb9
         Ba6Q8Da00IG4GVsd36zqBgKddkHbNRYPDGnrTw0kpAnEYfpgEDkKlGd7hMCJzVM7iMuK
         Jj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yAjuHlaJV4iM+XkUvTeUDNJ1TAXGjdj3xJMvNO0S43o=;
        b=oZejzdDjS/AgENo20cvd4SscjZV8en2PfpeRno9nLB6cwo+8I/+TmaCKkcmXfz46r0
         cF/QCeNU9DEEd5C3yxeu9htV5xGoLb0e3qLPABO9zHJ3OawAfoP197+NcJiOpJuPaq2y
         +GrfRqtGDTnXD3UWiSfBD2Zn9J8eJ/VMS103AhZmb1BUF82PeRcr3YKRVRUdx9sONtml
         4fe5asG+Gg5IpR+pxd8HRvyXGaN/bDDh3WP027fJpUe/HtiZ2FzXfzy5U+hwhUxbOA5w
         IDk6pVmSeloFmcLGKmFgamLfJM8urd06vUAISn48GTCqosoxtmWQWi0Fqb3C4Qlfqqqs
         LAYg==
X-Gm-Message-State: APjAAAVNqnsBec1qCsjCBZaCg7tcqr3MEVlEexFevBUBGAumQkzAj5dT
        D78Xn75xvSbapUlG916VK6AKGw==
X-Google-Smtp-Source: APXvYqzs66qskiSXGEU5/HciBF3rdsatWJNxMWMs4uZDfI+qll5yZQLR0JCw95Quh2W/sgGTkyh7xg==
X-Received: by 2002:a05:651c:1ba:: with SMTP id c26mr4261123ljn.154.1567632184814;
        Wed, 04 Sep 2019 14:23:04 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:04 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 3/8] libbpf: Makefile: add C/CXX/LDFLAGS to libbpf.so and test_libpf targets
Date:   Thu,  5 Sep 2019 00:22:07 +0300
Message-Id: <20190904212212.13052-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of LDFLAGS and EXTRA_CC flags there is no way to pass them
correctly to build command, for instance when --sysroot is used or
external libraries are used, like -lelf. In follow up patches this is
used for samples/bpf cross-compiling getting elf lib from sysroot.

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

