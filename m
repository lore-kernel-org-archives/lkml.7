Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE222C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810CE20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FCvja2RR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfH3Auu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:50:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33080 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfH3Auq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id z17so4856682ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LKaVdiULHZHeM3qmwqXGbS3W/6JSevNYH66TL2VqMJs=;
        b=FCvja2RR0Kl7bYsDQOOUQUjMRFvKXGR7eNe2NgdFDmbxw/n8dJHTjUoGSI+mau6Y+4
         Nur0MR6ogMXxJ5zfyi7m9Wy9jxTs0li83IAoNnO3od01GnS9Hqlng6pvxCjHf6xEnMyr
         augAVWdm8PjLCzmGgLHygy3NIRgFB7JySVZRBQN0s3ZKjzbUAEdFIJqIzM5lHjreRvGG
         snI7tdFTUKcqaa8IwauSlZkbGJE8QEkzS8ZNg5oOiKBIMrKDtwadtIdeZ6JwNYKeJIn3
         tKv1ox5CdWMtkIaJu0sJl+tRU4qXmxLrhXLswctpqbwRgon6CnOE9jLR+4q5IXCY6JhA
         KYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LKaVdiULHZHeM3qmwqXGbS3W/6JSevNYH66TL2VqMJs=;
        b=CeW4oKIS7cH2A31Q63MZBsi4uv7Hpd2MUe5+BfpDQ8RUH++PQydPTMfyrhp4FgJol4
         VMDXvK/qZfvZqH9roUhleJJzHrCPWD4tTW3NMxx5xKWKhIExHgyQkV1gChTMJcpytrNj
         qKt9QZjs++nn8GOcTyP0BbxEEUu0KbRQgEEvVHgXt8ZTpNyraXhUGXNBzOIsBzmIQuHy
         gdivpzjCtNZXtvtv+a7IkBhNViGBIFgJFwpt1ycwvgFzrTFRFUaCaN5jzW0lIJUdLBsY
         Fl2nJeKrm42nkkB82GW1QwJcDtH32umg0ADt49khVVb8/uayyhR4h37AvsBJhvQoQ1tI
         NaLQ==
X-Gm-Message-State: APjAAAUaFHADK7JrpzeL9yDixcmG8oS1UYgpbgqXJ1M6rRWVBou0jGBS
        6HgRD/UsszTDHgZ16ZKn9xddoQ==
X-Google-Smtp-Source: APXvYqwr9VPhPuNlVvj3eJbScYt62A3rntuEmrXbOlRiE2Zq78tGV5NynWDZnJoUv/97mud2fxSftg==
X-Received: by 2002:a2e:970e:: with SMTP id r14mr6839936lji.204.1567126244471;
        Thu, 29 Aug 2019 17:50:44 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 02/10] samples: bpf: Makefile: remove target for native build
Date:   Fri, 30 Aug 2019 03:50:29 +0300
Message-Id: <20190830005037.24004-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to set --target for native build, at least for arm, the
default target will be used anyway. In case of arm, for at least
clang 5 - 10 it causes error like:

clang: warning: unknown platform, assuming -mfloat-abi=soft
LLVM ERROR: Unsupported calling convention
make[2]: *** [/home/root/snapshot/samples/bpf/Makefile:299:
/home/root/snapshot/samples/bpf/sockex1_kern.o] Error 1

To make the platform to be known, only set to real triple helps:
--target=arm-linux-gnueabihf
or just drop the target key to use default one. Decision to just drop
it and thus default target will be used, looks better.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 61b7394b811e..a2953357927e 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -197,8 +197,6 @@ BTF_PAHOLE ?= pahole
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
 CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
-else
-CLANG_ARCH_ARGS = -target $(ARCH)
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

