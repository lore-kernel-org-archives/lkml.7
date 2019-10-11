Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A80FC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA06214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgPdUOsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfJKA3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:29:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42479 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbfJKA2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so5709976lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=03GhUEVVPKzA4TMKrHg2hN3Csg5CX1o2irsu+gSocso=;
        b=lgPdUOsdWvm3NrU+k0qDkNxtB02GwhSc5KwzTrCweHYaxGN3NwSL194iDLlMKbHnkv
         HQsLrmFRtK/MtY3s/t6lnF+dn79c9z+krOQUQchJEDuQ1x5wj40QtHKQGOOzwMr6pRkZ
         m5Vkk9C5vFXa/NWObQzlISQO4YdbJs44MBjE2Xjous5QWHXDZlr5DcIOTBFHkyeEGG61
         WF5Q7LTNZe3DrJVHzyS/VSxTW8rou+w2JR/RdhCDReKxj3Ac/8BRWjvZzNJle1gTsy0r
         gvhuogyNpORJ/IMHS8eJ+Y6UViz1GyjAt2gUp2tjQrsb1BfdiOFJaLYy7NLhBHyRChj0
         y2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=03GhUEVVPKzA4TMKrHg2hN3Csg5CX1o2irsu+gSocso=;
        b=Z55REVOcbJQPNMFU+LI6jVZes/kxzgG8NZIAQHWhErPV7UfOFI67pHeTp1OL3Bqpmf
         i+DgiENvbwkky9USSM/xi8uLh+i/UFeAonKOEBf4tB8brB4Nyyi9a8OKqvoYr23IB91N
         rN8Jd1mblAhT9gVnilULh77RjfCy1BqkHh81sg0GIRrnZKYs2t3l54JFF+b7FrZ4dXo5
         jRjzsSLMUjcouDiDDt7iANlJiGAC+zELC+p26HZ5EOH83zMlRLVG+3Rud52jDxXiBmdX
         gsdjatMlE4PmewtlwfA66qnKZTFjZqaujseWOO/9jGIiu0pPKjZUmvzVjx3HlFYKXs+z
         Gt1Q==
X-Gm-Message-State: APjAAAVEwQXQv1i5+2PNAN/kcR1Ntcvdyu4cTDPt70xw3zSuu/y0FAg9
        Rx2p4A1sOw0BMLXnv82/9KnHzw==
X-Google-Smtp-Source: APXvYqy0DvtjgGiKI7+n5Ix8WqhnukzK5KufDqlv4+eYNhjK3Y4l+UKA9J1K50qMit1NFTou4C7DEA==
X-Received: by 2002:ac2:43d9:: with SMTP id u25mr7678515lfl.142.1570753713044;
        Thu, 10 Oct 2019 17:28:33 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:32 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 09/15] samples/bpf: use own flags but not HOSTCFLAGS
Date:   Fri, 11 Oct 2019 03:28:02 +0300
Message-Id: <20191011002808.28206-10-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling natively, the host's cflags and ldflags are equal to
ones used from HOSTCFLAGS and HOSTLDFLAGS. When cross compiling it
should have own, used for target arch. While verification, for arm,
arm64 and x86_64 the following flags were used always:

-Wall -O2
-fomit-frame-pointer
-Wmissing-prototypes
-Wstrict-prototypes

So, add them as they were verified and used before adding
Makefile.target and lets omit "-fomit-frame-pointer" as were proposed
while review, as no sense in such optimization for samples.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 91bfb421c278..57a15ff938a6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,8 +176,10 @@ BPF_EXTRA_CFLAGS := $(ARM_ARCH_SELECTOR)
 TPROGS_CFLAGS += $(ARM_ARCH_SELECTOR)
 endif
 
-TPROGS_LDLIBS := $(KBUILD_HOSTLDLIBS)
-TPROGS_CFLAGS += $(KBUILD_HOSTCFLAGS) $(HOST_EXTRACFLAGS)
+TPROGS_CFLAGS += -Wall -O2
+TPROGS_CFLAGS += -Wmissing-prototypes
+TPROGS_CFLAGS += -Wstrict-prototypes
+
 TPROGS_CFLAGS += -I$(objtree)/usr/include
 TPROGS_CFLAGS += -I$(srctree)/tools/lib/bpf/
 TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
-- 
2.17.1

