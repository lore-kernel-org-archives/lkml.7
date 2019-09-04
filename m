Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B02C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F99F22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qrn6kZhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbfIDVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 17:23:27 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44687 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730435AbfIDVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 17:23:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id u14so158401ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XM+El1wyypVfaXfQc7FxTfECR5DYv9zUGiXmgC/VC5g=;
        b=Qrn6kZhSPCRIfWPLbZQrXvK6lt7Iv2mnBJ9fLUFe1bB8d3A93TcSi0pQ7aJIbrRhRF
         VqBxOcqXvHmwM6B4nLPwZFInG3Lbs0ucLsOPQ7EWJ2SK5XqHUKTssZhdnQhNplsuEwSY
         x5Svyb5v24/nMZRgCDOGvj1X2TKa9ghB3bZt/+JUncKf7znkKi7UrsFYe2VfXlLM1Pw6
         NdwK4iRuxsJnwFPInX7J5KfhCI19YZdPS/RrG1yxKH0/a/oOXRnDwEqfffdjpoAtOtZK
         I3CsCCXI734MGwDY9NZOTAFvNZ0ReU4TmWIEZK55u9m5rg9WFEW+C4nVp1ngSBNzeEKQ
         AHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XM+El1wyypVfaXfQc7FxTfECR5DYv9zUGiXmgC/VC5g=;
        b=XLmJtx1uwf1ZMqp+KHlQHkVzvEjq5YogDiy9E/laODYyr/I6cromg1IOoKIx+L0MCH
         1sNCPaVELaVP9P7ocDAVI20xziNt0KM3phKnXNgu7NN5QsNR89UFZxCfnO0mdl9DJYS1
         MRTgDcKodkt0rxZdAFIH/XWXfw6GHfYLMaWpVY+UIPm5uYmGNH83YtEVoFDA7MEalj+s
         AehONhSuKchSqdaxJ8clS+PP0nDk1uYkCGoAtlExhmMInOiPwTQYr5VcAgoTwgP/rRWM
         Kz7DkfIEpOj8TavIZ4cZ1mX7QkDhLkEXsZmGuQiEVPiVdvuTva+uHtBIyF296MgMre5j
         mdTw==
X-Gm-Message-State: APjAAAXzHnmk4IYnZBGOAMX5BBFjSKMUNNmLyhQd/HQgiYxes/aqgraw
        7tPIDhdkarOk/yiB3Pf8CA0r9w==
X-Google-Smtp-Source: APXvYqwIOnqTkM1LhhufRjTOuTPHB2CyE/gtuygYAHmjcLBABKdvZsgxu+PbqoUb8CLszPPiRIjm+w==
X-Received: by 2002:a2e:9a82:: with SMTP id p2mr24383354lji.64.1567632187076;
        Wed, 04 Sep 2019 14:23:07 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id s8sm3540836ljd.94.2019.09.04.14.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:23:06 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 5/8] samples: bpf: Makefile: use vars from KBUILD_CFLAGS to handle linux headers
Date:   Thu,  5 Sep 2019 00:22:09 +0300
Message-Id: <20190904212212.13052-6-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
References: <20190904212212.13052-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel headers are reused from samples bpf, and autoconf.h is not
enough to reflect complete configuration for clang. One of such
configurations is __LINUX_ARM_ARCH__ min version used as instruction
set selector. In another case an error like "SMP is not
supported" for arm and others errors are issued and final object is
not correct.
---
 samples/bpf/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cdd742c05200..9232efa2b1b3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -186,6 +186,13 @@ HOSTLDLIBS_map_perf_test	+= -lrt
 HOSTLDLIBS_test_overhead	+= -lrt
 HOSTLDLIBS_xdpsock		+= -pthread
 
+# Strip all expet -D options needed to handle linux headers
+# for arm it's __LINUX_ARM_ARCH__ and potentially others fork vars
+D_OPTIONS = $(shell echo "$(KBUILD_CFLAGS) " | sed 's/[[:blank:]]/\n/g' | \
+	sed '/^-D/!d' | tr '\n' ' ')
+
+CLANG_EXTRA_CFLAGS += $(D_OPTIONS)
+
 # Allows pointing LLC/CLANG to a LLVM backend with bpf support, redefine on cmdline:
 #  make samples/bpf/ LLC=~/git/llvm/build/bin/llc CLANG=~/git/llvm/build/bin/clang
 LLC ?= llc
-- 
2.17.1

