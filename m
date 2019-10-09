Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A12ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23AA2190F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfJRZwLz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfJIUls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:41:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36354 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbfJIUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id x80so2684101lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=tfJRZwLztmeYnFVdBAyxDdd+TZuqCcbbHvU5t2tVbgAMeD89v9awCNcvPek+HEsinA
         K1LAR52j6GCLiPMmHzsyATIhO8GEAHwsq1kzMxTb+kqnSKYNYd/61S+suugTWtGL+xYl
         hYzte2ORZ6ds9SEIuh1GeM64BiH81APaqQ8DuaBD1dx9qk2i1Er8JYdmwhNet5xJn8FY
         UA4s3/ng5TBA92c8PW22hDa8b8CpZzr4neRtwwxFfBh7XCXe0ywARrnUdf3onmDwFKSE
         KtyiZ5pt88z1zElieeXhqhh6EmSJxDY15JKWCgIFMyvdMpMSehHPchYNTgjgh1TOKi7m
         700g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X+OYdLBkIYv08X2eKXt3TCPXQ11so0VYCO7f1mswfR4=;
        b=K1DeJgI9onsXRcbPTH+qyAhJW3FmOUzCTJ43pgBsC3cQRto15Vvub0oeFO4VwgXYNx
         WzwnVexGSYwvAcoZIKmnKDkLO/5t2fnCUq5m/77TrzqL5srPgRwk9wpZAqPi3CcRZW+5
         AI/DJyrSw+6CoSVfrw+1wjY0SGa7ivy4rd425kw9K9dChVM1JWLZuje2bG/F/fvONBRW
         IDReUqHzrnewWEnTtU5WJFok5OJp4fG9d+wKOcxyjovKjpv6LNilJozUn3n/ydnCttI/
         bFgWsXn8hkoYngWwewlj6S1VNpvuUyUZuh00+C8vmRS+f9nvW5J7kx8DdYIeDDUvh/eY
         saOQ==
X-Gm-Message-State: APjAAAVZcR/gGfcCJqN9qMm/6DHrjYPNylPNm0T530/0cGQcT2ojUa5q
        IzmwuPrDmzg3IxxllxMGyK347g==
X-Google-Smtp-Source: APXvYqz1bKEUNoy2hw6TiSEtk/s+AI2BPUnSPgf5bemrwMHPwBezXWN9I4nngequORm4JiAuSncpjg==
X-Received: by 2002:a19:380b:: with SMTP id f11mr637307lfa.81.1570653703810;
        Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:43 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 03/15] samples/bpf: use --target from cross-compile
Date:   Wed,  9 Oct 2019 23:41:22 +0300
Message-Id: <20191009204134.26960-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
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

