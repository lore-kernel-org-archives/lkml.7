Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3833CC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09ECB2089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1NV8iFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436590AbfIJKjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:39:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42879 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfIJKim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id u13so13015520lfm.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKgtTI57zCb7K8E5dLif5y6EhTQqVERMGZla7VwIMYQ=;
        b=d1NV8iFC+6tOZEpE1Idxar1syxxTv7LcaRQZKlN8lQ6UWNIM+VsrSFW8OJhzp+yrJK
         TZnEJUUlCmzujYSIfmSrXIvuC5fOAhvtLMtyZs64Tv3BRrt8188Rowio4LxF2nev6JL6
         WtXExT6UHvUlF0qokmozbnE1v4hSBPLFKR4wranRRPVQkNiRuzUt4ZlMLhNkSXBcitw8
         O+rliVg8fS3f/5eYtq3Q8msGYQ9HqgzAhaCLrLmKBPO6NQNVOX9ydpNZY7TyJySLox4V
         mMlqKXBF3zWTks+rpEwMVOtIrdl3id63UjM+3DgC7rvSV53qIOnh0AkSuuj788gMPWqh
         JspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UKgtTI57zCb7K8E5dLif5y6EhTQqVERMGZla7VwIMYQ=;
        b=IwjngiGgmporXk0t/rjpQUjhMYYTjlvv+gZ5DwRnkvYdOnUCHvH5fdeQJ9pVFGd/U9
         DEoOKhWbVmWwrpqR7VCyVFLnxkJO1RX5Rf0cVyP+rJqVvopiSCq4b4QNT4dH/MVts/Xa
         ISShFcH3YqCoLQhmDDuO1EXuP1TuneMaD4X+GAEbobDK3bSMq6rBP7ghC/YZhjism7FG
         hmcNpqAuLCiL807e+3aP+m3vu44D3Ssc2Rh1K/JOGHAgkVKJIioRDHBWy5YManezUH4H
         VJlPn/NhxQlkPzCdShqYSHY5NaQ4PGfbI0jxwZM2iUx63CUbxBepMJ3fs6+GwBix0Pi5
         bFOw==
X-Gm-Message-State: APjAAAVkKiZQUrkbyTh0KvPU+bK1gZRbMpORq/QRPm2xOs/ggmsZpmmk
        7phz7McbEXcaYkLwB02BZWq9BA==
X-Google-Smtp-Source: APXvYqz2mYmX/pvzBkBIdA4NYnBJ5t7j3x5hjGDrz0jhNnKsne9ciovRreZ3Y5mkP7CXX46T5ofEvw==
X-Received: by 2002:ac2:5090:: with SMTP id f16mr20575559lfm.66.1568111920122;
        Tue, 10 Sep 2019 03:38:40 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:39 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 02/11] samples: bpf: makefile: fix cookie_uid_helper_example obj build
Date:   Tue, 10 Sep 2019 13:38:21 +0300
Message-Id: <20190910103830.20794-3-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't list userspace "cookie_uid_helper_example" object in list for
bpf objects.

per_socket_stats_example-opjs is used to list additional dependencies
for user space binary from hostprogs-y list. Kbuild system creates
rules for objects listed this way anyway and no need to worry about
this. Despite on it, the samples bpf uses logic that hostporgs-y are
build for userspace with includes needed for this, but "always"
target, if it's not in hostprog-y list, uses CLANG-bpf rule and is
intended to create bpf obj but not arch obj and uses only kernel
includes for that. So correct it, as it breaks cross-compiling at
least.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index f50ca852c2a8..43dee90dffa4 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -145,7 +145,6 @@ always += sampleip_kern.o
 always += lwt_len_hist_kern.o
 always += xdp_tx_iptunnel_kern.o
 always += test_map_in_map_kern.o
-always += cookie_uid_helper_example.o
 always += tcp_synrto_kern.o
 always += tcp_rwnd_kern.o
 always += tcp_bufs_kern.o
-- 
2.17.1

