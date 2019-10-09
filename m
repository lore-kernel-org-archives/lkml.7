Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D99ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E88B218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A3gY6o7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732280AbfJIUm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:42:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40775 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732082AbfJIUlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:55 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so3868827ljw.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=A3gY6o7HgTJ8YPTLbW0H4/UT2ZFoBSmF3dt74q0EUM3FTy6EnbqRwhaISluNSdHvUX
         CIawMYyGoTlYyjuuN/AxQM4IG/BMqNKUl+BPKvdsxEq50+r7fA4jI4lTQ1TO+R066sXk
         e7QCppCoKQ++RV9uKddTSrIyVbHD2INrvkF3Ffu2ISQMHRpqp9w9ljJoIeEPfbKLAWxQ
         urHJWqszpXSN4THwBKlG9/N/woZ8qllhLGFCX1DeT/IzKtBd20H2eeFSdY0HTEnbS6N9
         rw4DTH0s5ogzG+ZqTmvII3XMHWFfRIYNURW5r9/hOhHoiOYH598aERl9cfycrKxgW4gA
         9eQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wbL2nu6acnton90gIbsX5qxq9tLlNkmN4RUryN8fm7M=;
        b=Q9rYiJsassnoWhbUp4spr4dNi7vy5rlPebSde8ZjzahugwtVFTbJpTtzB4U5FGyhlm
         MpF9WiNsnCty2oD/QjeCCTmkJq/ux5xpSZVbAiByV3lULv+mvyBQmwY9tj78PRr6TsRd
         YYxh3+n7dd9cxFeCtIZLSA7bA9Bp6EoH5QSvH6g+JtsXzna7s4GSpRJvjt96Tu7YWe4c
         lH2AAtapKoOx8PaFQqds8ORP4HLLDXKb7iUpsuiceyAF+DvgVai5NZvFaN4MjiM6li2s
         LWGsbPbDJLNk9TpxlCyKIhsJYIuR51TTtB3OluDfZetEJ7+pNGb9r2fYIvzYy/qhvck8
         7cmg==
X-Gm-Message-State: APjAAAVMaAoIEp/LkMCB9KxvsWLdz/pD2DRn1aBlC5yFNv62k6nhKWK4
        k1aZ7IYlkqkRrt19OihDq6EmSQ==
X-Google-Smtp-Source: APXvYqzzMJ/Xt+QwJqqo7iV2M9ovOX+F48KIoP3wwDBFtBp5+MeCB0SWdgoowUD7hVsKgWLwjOX1yw==
X-Received: by 2002:a2e:9449:: with SMTP id o9mr3534903ljh.110.1570653713531;
        Wed, 09 Oct 2019 13:41:53 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:52 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 10/15] samples/bpf: use target CC environment for HDR_PROBE
Date:   Wed,  9 Oct 2019 23:41:29 +0300
Message-Id: <20191009204134.26960-11-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
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

