Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412FC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A462206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 10:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrB84xhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfIPKyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 06:54:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45316 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732442AbfIPKyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:54:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id q64so22747244ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H+Oq4KltqpOb9wzu+L9OzY4bSDO7cEMe/MUjYdSZoPU=;
        b=UrB84xhNOOGhDmRHN4tEy21BxZte/v8W4CZVHuwaeoMKZensFssyvROhnk9udXZAWz
         JReS0yZSuYH5mPKKBCWNIaMerRcfSF+DPnCTQVKPlPwrFyp5Oe8NoO4Y9InriRYX05eg
         QrgslNhgph2Jw9DXJ5YHj96hldOtquP1+z33zTZKJDg+32Gxz59xznVRAdUl+l7//C2/
         eatPjrGBSFUM3gi0Ov7oJ1/yjdBVMoMGc38yUqD6zyZH446H0JDswC/cboiHLROsjxj2
         MaiWKvwY0xGH+DLg6A40H0Ta+e6uQZ9fGECdAQkuo2REdw7Cn/aEzLOnuAzM66wputxt
         6IAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H+Oq4KltqpOb9wzu+L9OzY4bSDO7cEMe/MUjYdSZoPU=;
        b=qrTRcUTNyugU7BGR/Xj1K5YuGurvE3dKjGidZicKTXN22uDbcIonmru49oC+Fh0B/d
         9dborPT4SKq9HAAMrOEuexcb0xOXiXv9atP71v8pF6R/sVN1HEahxnpPDk6JKWivEuI1
         7DzTcVfhfidslOjnQWuMH1P35shnVAZZebENPeLB9JEQvfImfimwxaQUmjxLDvZQSli4
         iJtHtpMFjDhu7l0I105kW/GbZsdD8So3/dXhYMUirPm8Bai7xvKeN6J3wxWJcirYR/SM
         PfHriaS54RI23xQ4Z7dcXHzFm4YfMM5JuGhZpeKx2rmKBc/4EPdFAxrqJdn1WCYdacq5
         Hnog==
X-Gm-Message-State: APjAAAWQSx5GmX4kMwFA+f+8UK2EAc3NvHYsJ5iVKljbn7iQseXaBImR
        fzsUyAdhmpnvOKSapGqop0Sq4Q==
X-Google-Smtp-Source: APXvYqzehclWxfpO6zGFERHqTFpvyu1X5/iPG4IUz0R9DZwRIntmp9r0WOUCcHs2ED3kNz6p/LBsig==
X-Received: by 2002:a2e:2bdb:: with SMTP id r88mr36236050ljr.82.1568631286844;
        Mon, 16 Sep 2019 03:54:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id v1sm8987737lfq.89.2019.09.16.03.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:54:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v3 bpf-next 05/14] samples: bpf: makefile: use __LINUX_ARM_ARCH__ selector for arm
Date:   Mon, 16 Sep 2019 13:54:24 +0300
Message-Id: <20190916105433.11404-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
References: <20190916105433.11404-1-ivan.khoronzhuk@linaro.org>
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
 samples/bpf/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 8ecc5d0c2d5b..d3c8db3df560 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -185,6 +185,16 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+ifeq ($(ARCH), arm)
+# Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
+# headers when arm instruction set identification is requested.
+ARM_ARCH_SELECTOR = $(shell echo "$(KBUILD_CFLAGS) " | \
+		    sed 's/[[:blank:]]/\n/g' | sed '/^-D__LINUX_ARM_ARCH__/!d')
+
+CLANG_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
+KBUILD_HOSTCFLAGS := $(ARM_ARCH_SELECTOR)
+endif
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

