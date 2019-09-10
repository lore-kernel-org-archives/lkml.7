Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B263C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F179B2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RTYn6wq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393872AbfIJKjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:39:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39955 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436566AbfIJKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id 7so15869790ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Ec4H0Qe1jdzuqdUWFKh+P+h2+Aff+D7k9SQeZ/p30E=;
        b=RTYn6wq8HZB0SSigIWSrQkukTm2rdfngleNyu72MpsqM1lASZH9QE0Y6SHFkcdPW6t
         SUOlRyMvW63YiViGvW+w5uk9hhQHo6nROk5fexs4TrYZfHMoghxAmfs8Fi4tYH5bhdAr
         H016Wcl9zaGW2Qpi1EEMaMjyWk9fKH9Fhqh8Z4QDBgavFL0xuFAaOgfeMMcsQXpirM/U
         /hK3lqrFAb7/Jgtpp0I4jcHmrSqHFOf/1N5hxkhhF3nYHCoFtapOmz5fR/J9tPgo5aHB
         vvWGKjSkJB1FQ4JwvfFF2A/Grho+rsOw6/naVUBStw26OlIwGjwsmVM6X3/T103Kh1kT
         rUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Ec4H0Qe1jdzuqdUWFKh+P+h2+Aff+D7k9SQeZ/p30E=;
        b=B4SKrdK8y15djAQ+N2GobalcHZQo/zLmotYQemRefQ6HdxXz1P3um1265oT6FCzwB5
         HiKzglLh7bogupbvVzFisx9OI4osNOXXdnFOWcCcYlUNZjfhjRcT60nJwpj8O3Uie8pz
         Xo2yKa0VWVCPVz5FAdVQ9Px5F58ecOZUaTgIGt9v3DV0NjCSxMxDXESTcl1qccOMsipn
         f2H12dw/+o/t9YZBaQj+l22OjElchjKF1oXYcw8d1mU7gens4HhKGdKDXlFBBiPA/vut
         lDc7v8rRxl1ggQQLqaNh0CKDxEwuZuhUyFHffQMD+oES1bogRXuR5SYAN0lMd60LqQ/O
         I5zA==
X-Gm-Message-State: APjAAAUUT0/MrkbMV6B2WAtlOPENLzIzNK23vA75PpZXIGruE14H8Xx9
        3DIaz8Wr0IFFQrxEze+7kPGkEQ==
X-Google-Smtp-Source: APXvYqzPB+B0bg5nLoDm5HKJeXxgAipfRshWy6+hrgOhOjmn58JdlEAIpXk1Ak2vmtOsyQpizW3Efg==
X-Received: by 2002:a2e:7210:: with SMTP id n16mr19306668ljc.235.1568111928714;
        Tue, 10 Sep 2019 03:38:48 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:47 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 09/11] samples: bpf: makefile: use CC environment for HDR_PROBE
Date:   Tue, 10 Sep 2019 13:38:28 +0300
Message-Id: <20190910103830.20794-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need in hacking HOSTCC to be cross-compiler any more, so drop
this trick and use CC for HDR_PROBE

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 625a71f2e9d2..79c9aa41832e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -209,15 +209,14 @@ BTF_PAHOLE ?= pahole
 
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
+	$(CC) $(PROGS_CFLAGS) $(PROGS_LDFLAGS) -x c - -o /dev/null 2>/dev/null \
+	&& echo okay)
 
 ifeq ($(HDR_PROBE),)
 $(warning WARNING: Detected possible issues with include path.)
-- 
2.17.1

