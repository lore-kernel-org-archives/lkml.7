Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A38ECE58C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A2A218AC
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pfrCF401"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbfJIUmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:42:49 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:40764 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731952AbfJIUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:48 -0400
Received: by mail-lj1-f178.google.com with SMTP id 7so3868528ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8GViA3rslKXoIblVB14HOdim3G08AtxcYrIekVeHcE=;
        b=pfrCF401TvMKnGGNl+mGcNqDCp2vUaNFpxEHOZUq1XK5MSPm3P1fYAf7wPUa+ETpQy
         VOVS4CBzr+1pxsUk6OaY9H5cdbJJGJ79afBvAVM7dhtqB3p/rgd3mhnIdLqFLvDK0mTd
         g0BL+HT0f/ysat5klwdZ82W7ujyD7W84PDhXsN3PpZ6AVA+ItryF/xgSXb9ZFPZ0XQH8
         bbDmHihjaFmyodxwsKWZK1D9NAxKeEqJpo8wMBZLQH4UaAtgHRCn4mApNkvdxUcnXGbV
         DQg/S8s66IiuaM28TVfm+AHtC3W49BgIRvSedebxXVHbJ/nrr4jh4KffMFSzscaK04Ud
         MiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8GViA3rslKXoIblVB14HOdim3G08AtxcYrIekVeHcE=;
        b=iTSMGegNcGmV5ZL2s1ta3rW9GHUzoFzqkgco1l6qKEFzCQavWvI9CzYEPGr+7jK4BB
         kUOClbnpFlNHl5Xg4+WYb3PlGJycX52wIAhtR7++b5IDhxvXaKGVXjd3i7hxQtODE4Ok
         XlnYpruxGrcsHyRYILR414BIsTZjdjXQC8COajQFyeyhp/uYjmPA8PMtWjilv0PzI5ZG
         P3Wj48oqKeiakN2TXm9MD3rxQ194iNTn558NSPkctgfPop8ot5UGfgcPhGt0uM0mC8+b
         Zi1wkbPLKkBA/tpWfmZH7i1VrmfWH1/olN+LwU7Nm91NY05xL31sJXJEZgLB0UGyFapd
         aZJA==
X-Gm-Message-State: APjAAAWgRLHUk4kvMmlh4uHtxpDjy8u/AXkVINFDazrLZrdQDBbSjJMR
        qXZurlCZmcOufczeXhFHAo9WHQ==
X-Google-Smtp-Source: APXvYqxuctn/aA7ZrMAT8XQt+9VdRu1DrxUiAKw6n2hPLrMceayMK9zf2VM0qBBS8IA1Bb4098YjEA==
X-Received: by 2002:a2e:9890:: with SMTP id b16mr3652941ljj.4.1570653706617;
        Wed, 09 Oct 2019 13:41:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 05/15] samples/bpf: use __LINUX_ARM_ARCH__ selector for arm
Date:   Wed,  9 Oct 2019 23:41:24 +0300
Message-Id: <20191009204134.26960-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For arm, -D__LINUX_ARM_ARCH__=X is min version used as instruction
set selector and is absolutely required while parsing some parts of
headers. It's present in KBUILD_CFLAGS but not in autoconf.h, so let's
retrieve it from and add to programs cflags. In another case errors
like "SMP is not supported" for armv7 and bunch of other errors are
issued resulting to incorrect final object.
---
 samples/bpf/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cf882e43648a..9b33e7395eac 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -185,6 +185,14 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+ifeq ($(ARCH), arm)
+# Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
+# headers when arm instruction set identification is requested.
+ARM_ARCH_SELECTOR := $(filter -D__LINUX_ARM_ARCH__%, $(KBUILD_CFLAGS))
+BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
+KBUILD_HOSTCFLAGS += $(ARM_ARCH_SELECTOR)
+endif
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

