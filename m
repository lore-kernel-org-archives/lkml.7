Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA05C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165B221929
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZ4g7bs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfJKA3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:29:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38076 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfJKA2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id b20so8033543ljj.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=KZ4g7bs4fOSGzk9FRyjF0hoqEh7hKsbUdY26yluEIfz8HrbcVogNxnuyoe/hxPcvfY
         TkU3hAUOhkLrtq5AzSARGyoZtpIAwa6YiJutpgj2IfhDFd7rccQbQb6TXAJO3UHkSoTS
         KVLv4z+Y+wn1/bGde0X3XLQCzqxwzgrKWEYXuOOv5w100VI2wuVg8Z1pJWKOOw2QGMIu
         xAD92jGqtR5FbkoIFvEdmTYUmuUV51K4APESpxgabNPn1RethPshg4jMreKr/ZBPFC6Z
         mKPdfQ4ukG2GmYFcT5pC+tXxG/DwLE1KaehHzD/wBCkNIFKCnOdDqIYiyjJkoVevysU6
         FEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=Z9u/qxDhqulgJYEhEtLbx7KvmYuKqGcb6Qs2Kf3pAcusjexfFsuE4n1fjTbIQc8lWQ
         OG8dpu4fSjJJMeMLH2YAdTMN04H0B05kQ5HS/5gBM3NhOoUNYArLxQF2a1PZKGzzh38e
         SPuDizg4zsG8E3sL4R7AGjpp11yXYRWQT75IUuQbG7aBVDJs+CRTCqBBLm+KFU7eNiC2
         qkLVqvks05fGL9am7SmyCYORHhw9MgjXUeJnf+AkS+XR2qEeZhBvc3PatzPdU4WS6HiL
         f8INVDR4y8ZTeyytoxYsLaOo8FnJji0OQ0xijWc1i8Qczu+PlePCoiz4F7PrtN77Ej4V
         z4cQ==
X-Gm-Message-State: APjAAAVTZUapbbf+XRz8JKYMsRj3rpHUs/+7WHntbwqrsoBVdZjXvCUJ
        /9GGdsNNi4VVxZ9hx3YBNn/pDg==
X-Google-Smtp-Source: APXvYqy9hnP8VV2RBY2j/1IOquHYPBvEdhG4CzJDaEV75yWkYlbvEM/9W8Q+EDRq2LWuZlNNlkmCxg==
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr7438097ljk.65.1570753714541;
        Thu, 10 Oct 2019 17:28:34 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:33 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 10/15] samples/bpf: use target CC environment for HDR_PROBE
Date:   Fri, 11 Oct 2019 03:28:03 +0300
Message-Id: <20191011002808.28206-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need in hacking HOSTCC to be cross-compiler any more, so drop
this trick and use target CC for HDR_PROBE.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 57a15ff938a6..a6c33496e8ca 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -205,15 +205,14 @@ BTF_PAHOLE ?= pahole
 
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
-HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
 HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
-	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
-	echo okay)
+	$(CC) $(TPROGS_CFLAGS) $(TPROGS_LDFLAGS) -x c - \
+	-o /dev/null 2>/dev/null && echo okay)
 
 ifeq ($(HDR_PROBE),)
 $(warning WARNING: Detected possible issues with include path.)
-- 
2.17.1

