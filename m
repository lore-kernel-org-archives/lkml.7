Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BBD020B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YKc0wBOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfJKA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:29:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39235 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfJKA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:28 -0400
Received: by mail-lf1-f65.google.com with SMTP id 72so5725524lfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=YKc0wBOK5kw1DdbXCuiOee6bbytIkRtP7xcVtvuTLj4UdL6r5TUv6DcZgG/ZDsLP69
         ulWquw4+7tsUAsKSiFy2Cfty4cW+bXLlKps9odJRuCeWnw/lGdGvLR5rkISefH9Phe91
         /CAtfzmy5wtryrSDvREOHdPKvSRLjAPu5s7+k7zxv+jQtm2PN0fja1E8kM5N4INyKxLu
         /Vf7ncX5Q0YaTUYo17CjLST2nR75D+SCZ8tWLmJkPS9ENAAQArYJ0M+MYo6mSMcqEXu7
         Tnhwc+jAV+FrQNEWwOXtNudFWCGl6uLf0ZpPNG8Nqh7N9/l5U6zwHP+DruNqbB9COdF4
         akmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=a3b1aM3+uhHLMhJbogNVPG5d78SNr/MAl455ONTCsTxYeNczeJ2iXAGPpWuuU6LKfy
         PQzM/1tUPnUH+KNd1ECMZlmDvop6WPI0P9m2jcsv4xYyhHD8ZAVVicQ0ZsN/DtKabi1X
         LBYKhURfXj7Pbvt9x2ohryQfk5ul+OmAnLTj9FJTkg0K/XIANvTpkg9pfQ54XG4zkn0M
         QB6QKZUeRBLWWHq+TOgOtq38177xciyEGoCy1W73LH9g7/RRcb+3Z8grHt67A1RRX92s
         4tHUKj+de8Ah/g2Zsgr7MOPqoypDk7rfK/GYQol1gx3Risfli7FPHvDA5Utdn6xNQzKG
         Ecyg==
X-Gm-Message-State: APjAAAW4Y7VTKhFa/7Hhg01/OqparMLzun6k/Z2rQbN1Ug8dPDS1xais
        bpRsGYgDQbFCcssK8aYS9AVuuQ==
X-Google-Smtp-Source: APXvYqzxfrVPEHNBW9hrD6Av/hCkqGzGXRR9boh0fDIihTSKCgluCdKMc7ty+RTqXr4lDuRPE/0FPQ==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr7390173lfi.24.1570753705056;
        Thu, 10 Oct 2019 17:28:25 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:24 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 03/15] samples/bpf: use --target from cross-compile
Date:   Fri, 11 Oct 2019 03:27:56 +0300
Message-Id: <20191011002808.28206-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For cross compiling the target triple can be inherited from
cross-compile prefix as it's done in CLANG_FLAGS from kernel makefile.
So copy-paste this decision from kernel Makefile.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 045fa43842e6..9c8c9872004d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -195,7 +195,7 @@ BTF_PAHOLE ?= pahole
 # Detect that we're cross compiling and use the cross compiler
 ifdef CROSS_COMPILE
 HOSTCC = $(CROSS_COMPILE)gcc
-CLANG_ARCH_ARGS = -target $(ARCH)
+CLANG_ARCH_ARGS = --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
-- 
2.17.1

