Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2583C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794902089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TacAjaCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436569AbfIJKjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:39:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45127 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406085AbfIJKiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:46 -0400
Received: by mail-lf1-f68.google.com with SMTP id r134so13001677lff.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jcy7fNNZJS0bHfCAktRnVFRPdGNhHeHDFWh1+uGNMgg=;
        b=TacAjaChlFJ4KM27SSs7dVz9hlSYEhjkfawLkkkl48IIQQ1wSVIYRQqMrlaTvwl5CP
         DLad2TxLl1dIZdNnUCsQoUzGEzjSHzGAoJfGcjZM4FTLbfHDJDLxnG5DAEJV3cr2Dy8K
         NohR7qiDvztBEtRRhN+sI9gFBal1gTt0bC+OvHCKzOtDlFYiVB5XXrYtgW94qEUhkp2h
         3v8a3c01/ol6w+U0kIUEzHlnI0iBQYa+7bJiSI6L+/2JnZTArU2V7S1yzvcDNRFO1VxI
         N2wy/iUyP3CgCFvDn8yQRk+j1Mob2gdE9ZGzqU5ILV7gLlW6lFvbvv5sRg6nA13I38pN
         V0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jcy7fNNZJS0bHfCAktRnVFRPdGNhHeHDFWh1+uGNMgg=;
        b=UDsS0X0j3N0Wlu3ay75qX64zgzC5FieDH72FvX1I8b3TIUHFowsygVbnG17Hh2f1Js
         z6FqN5uMqGENiE/d9oGaVsJcX+k0M6D05OCzZMRHOTrRv1aXcmN4rEE6tD8Uo2JOQPOi
         frg88rGEkPU4SBQebeY/8pq3S1LPI87M38noUcacADydELbMxiSZWm5BkRWFO+YNtLVi
         BwgV+QcR4xSByBBIGo3M22696n9Of7RQMO4XF+efpkg9OwlKzVK5UxhJy7EFMfZQ7VMk
         FG+qd1T5akAOJkiNvV7S6T0hwAvwYdBt8U5LiotQgjpdFFTT5lq8N2G+PSGKOMYd4dEJ
         fyGw==
X-Gm-Message-State: APjAAAWoXkoyWSNpRLp8/1TyCBXnI/rWA1nT6GSFolQm2dHFixntMgcD
        Ymct2CX5uTN5/S9KEDzCJ7dBnQ==
X-Google-Smtp-Source: APXvYqxX7XFT8xCd+TWq4vlEfFVMcJ0HVWrjeAbjcVLZkGDyrKGcSAfl5dWOTqsxAy0ogJoKl4C1Sg==
X-Received: by 2002:a19:2d19:: with SMTP id k25mr20950410lfj.76.1568111924828;
        Tue, 10 Sep 2019 03:38:44 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:44 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 06/11] samples: bpf: makefile: drop unnecessarily inclusion for bpf_load
Date:   Tue, 10 Sep 2019 13:38:25 +0300
Message-Id: <20190910103830.20794-7-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop inclusion for bpf_load -I$(objtree)/usr/include as it
is included for all objects anyway, with above line:
KBUILD_HOSTCFLAGS += -I$(objtree)/usr/include

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 6492b7e65c08..f5dbf3d0c5f3 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -176,7 +176,7 @@ KBUILD_HOSTCFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/lib/ -I$(srctree)/tools/include
 KBUILD_HOSTCFLAGS += -I$(srctree)/tools/perf
 
-HOSTCFLAGS_bpf_load.o += -I$(objtree)/usr/include -Wno-unused-variable
+HOSTCFLAGS_bpf_load.o += -Wno-unused-variable
 
 KBUILD_HOSTLDLIBS		+= $(LIBBPF) -lelf
 HOSTLDLIBS_tracex4		+= -lrt
-- 
2.17.1

