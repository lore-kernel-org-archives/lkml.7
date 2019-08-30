Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD652C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B33F20673
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWeUz6Fu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfH3AvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:51:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41595 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfH3Auv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id m24so4807813ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jGmbuQhjfybpgV20Mr6h/vZA852gJhY9ROLsc2sx8l8=;
        b=pWeUz6Fu6QfaqIpkcQ5NkN8S1IH2Rw5H5SVVq3jN6Pe8GO4Z0AVQ8kjAJ1nWq/suUY
         iy5IGz6OJY/dKJgiOzw4G0pKMu1jIKXgSEsnZrYt8T+GOll/c7PoRUL0YOgbZSy9nloJ
         xQxd5OltyxyzW8UXtE9De6EMr0kC0GBlbZxjYBn+ldgJ4QDJW8JzaEcfhzz1wiSK9Dz5
         oXvnGjkb0/kodZDij7wbzY6bjZCsk+fZ1wdt4Hs8Okzlc+qRp1IHk7T8NLEWCvIR0xTc
         MloaK1lal5Wj6DiZQlLT3eOYVu3I68zMpgnlI+8rf0f0TnmBXaCq/zCKadOxwP6syzE7
         hEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jGmbuQhjfybpgV20Mr6h/vZA852gJhY9ROLsc2sx8l8=;
        b=i2AZQPLmlvS8Hj4EBbtDFB5iUwO8Vrn5Yqi9R1gjGwhSGuXPpebavHkaPlQN2fulxZ
         MJxGocRDas7ml6JF0CQllU9G9VxJmlgomQaG4xgm/aGr7onLO0YEaOeyN9Ko+7u80F6C
         qGOU/9xc1eHMcru2Q/pF3FpjSzCYElUoV2T026y+w4dli2RGnGD3JmSuL18IrBurFln0
         Vxdmbjtl9bU6rP085EKr60IcGN8ce0AeTbNdx3rCR37JM7kMPvpu7NW3BX703/2QOflX
         Q4fLYsZ4q5wluirooAys90UUq1KNbqEdonc/vyjC4qzxCQaX7mvmYIJeRLad1fjMVEVA
         SCzw==
X-Gm-Message-State: APjAAAUflFnKRu0QX/i26zx1kPhJkYuhkk3gimzBUEfQbGuNmANTJpsn
        QEr9AIC+v5y5h1LtEaGmVlbmTg==
X-Google-Smtp-Source: APXvYqzI74aR/DPSKUQJi5BEbDzth7mLHwQxtSOpKT4d/woWDnrSZxBkUNITdgyD5sT4M1zqAQ6tfw==
X-Received: by 2002:a2e:b004:: with SMTP id y4mr6683248ljk.124.1567126249466;
        Thu, 29 Aug 2019 17:50:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:48 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 06/10] samples: bpf: makefile: fix HDR_PROBE
Date:   Fri, 30 Aug 2019 03:50:33 +0300
Message-Id: <20190830005037.24004-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

echo should be replace on echo -e to handle \n correctly, but instead,
replace it on printf as some systems can't handle echo -e.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9232efa2b1b3..043f9cc14cdd 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -208,7 +208,7 @@ endif
 
 # Don't evaluate probes and warnings if we need to run make recursively
 ifneq ($(src),)
-HDR_PROBE := $(shell echo "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
+HDR_PROBE := $(shell printf "\#include <linux/types.h>\n struct list_head { int a; }; int main() { return 0; }" | \
 	$(HOSTCC) $(KBUILD_HOSTCFLAGS) -x c - -o /dev/null 2>/dev/null && \
 	echo okay)
 
-- 
2.17.1

