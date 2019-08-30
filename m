Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53385C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2103E21726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kCLWWa8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfH3Auw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:50:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46674 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfH3Aup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:45 -0400
Received: by mail-lj1-f195.google.com with SMTP id f9so4756354ljc.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Uyna4IYOJol121SLmRwAZvx/NaOoPDVjYK6GTYbGUpc=;
        b=kCLWWa8CrxMwJCc3us4OMb8Z4KxeYvEnIDyQFEEyN+J2uzU3tej/3tlqELGg51s510
         Hx6FevFLPM/rW9mn0TSPGLrFyZdU6GgtFt0G6VlDwBwg2z9T4kV5uiNUBxi6zOGGGkJi
         EM8Wepqm3ulk4jB04e2UspjIt0F9jNtMphdz7dcZNmhdaQOLOKo4Ib3a8U488jLM5PK4
         f+21fUenLBmLcDN/uGf5mOGRC8y6460M/FviJOCMebLC2pF4tXTUBvvZhDmDPVSv28Mk
         BI73jiSk0NojKt3fQTjexjSwQHhZf+i/x5gkVDbVmTy1jSWDE1mgCJu/E1vKe4LXDflk
         cS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Uyna4IYOJol121SLmRwAZvx/NaOoPDVjYK6GTYbGUpc=;
        b=QeKTep21twesdi2iTKqra0EGC3mlqsCt1HFYpE7bgpx5ma0O3d21jNAVa8HJ/Mg7Qy
         AUH+qWV2iJE7O/Ws2tNx1UTcXngHQRP/u+9SQZ/MD3IB7Mn3ihIa7p7mVNzVfoUkWpsK
         eKrcCyvzvGEGgQYdhOZbSySZX6KSvls3M5MHlpAZVVLKnPtp1ShY/h3A91/J/p+IKN+y
         r3zY+I7x8NC75mrgdnC9RVl4RqpFNSwUF6KMZBDNsAbFilQYsYoaa7ERTowhY8TWLCnO
         BlCo22+PscGC3tjnBwLKhY5GoEJJvczzkqC1nM15DPF5E6OJYqBIPOpT0elxoZt8R80h
         W7hg==
X-Gm-Message-State: APjAAAWelsDl3PBzH5FJvRNh4alYagdlNFoXvmG8loPI/64bTUm/mRa1
        1/gx3wXo+H5vd8F8TYb5RV/WGg==
X-Google-Smtp-Source: APXvYqwczd6nt8u3EfpPxDPMTye3gjY7N3FR/dqe8OYgFULHyQXUnfqd7PQD/tD94qNCi+yyNnGlYQ==
X-Received: by 2002:a2e:8455:: with SMTP id u21mr6903469ljh.20.1567126243059;
        Thu, 29 Aug 2019 17:50:43 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:42 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 01/10] samples: bpf: Makefile: use --target from cross-compile
Date:   Fri, 30 Aug 2019 03:50:28 +0300
Message-Id: <20190830005037.24004-2-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 1d9be26b4edd..61b7394b811e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -196,6 +196,8 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
+else
 CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
-- 
2.17.1

