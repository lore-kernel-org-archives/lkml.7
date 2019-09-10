Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6415C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3C120872
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXCPyNiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393887AbfIJKj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:39:29 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44481 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406062AbfIJKip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:38:45 -0400
Received: by mail-lf1-f68.google.com with SMTP id l26so1330247lfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4FRJ5Ph8qMbMU6/W3VLuGrqprbT0bDHz0d1WvLmMb4M=;
        b=TXCPyNiEYJm+z3P9BrsgCARerEq9GOj2cQ11CYeYMNRuDkg/mY0M0tQui+vUdL1k87
         8+ECvYjDRTCIoulo93XPu0RXJvzn/1Nz7YG2evAYLUkNhWIqO7VIZZ0QYmn63vEKS+8G
         fn70QxPlntFDMw950+14w5b79yXsySEIlftqcIt9K+GAVfYjfmsfhQRDGCiQjDqcenl/
         4Jq9v5fuFPTeUqaF4pzLPWOcipfkFql5KD6lqmjwOEZpE2e5y+2S8Fs5jznuqUTZGezp
         RQQM60F5JHcdeChUHuytyct8VKXIhAVM7CZetbmTUFxRt208i+TlHTzDlk4C2rVJorC3
         SQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4FRJ5Ph8qMbMU6/W3VLuGrqprbT0bDHz0d1WvLmMb4M=;
        b=SWWHaPvAcEHnhDvPdJxQIhSCFdv0MDOMnxyJBNB4Ioc4zHPHktvnYiQDFoWytuhoFk
         Lczp6cIWsdcaJ6V4cshdb9HMryzv0qeFVX0yywrtl52jF+PH17q5k5hmV3ualulh8fgZ
         Bwod9nSjcwPg5uLxIHoeLOJyzA7fbCEFIcFvOBR9iCrH1a9rstSRBFPHA9OTv/rf4Ito
         AdRXmW6Bdob1uXr1NIIlTEm5T5RoH/I6EH1JPs9ct4NBwWtug7zdeyRJkuTnTZn0eXI7
         9eqC22cGouWa+FXNwExQ0rv7Q+ZX/hALGKQHQlj5nZCXLab9EMTtmOAmqAD9zJQKqvMo
         5mEA==
X-Gm-Message-State: APjAAAVDXhPimCtVJTb33H8G8CAUGNeaT2kKwdTCsrog9XDf14o6a7Ht
        qzqc7bUG9QfWyHSDMyPukBXl5Q==
X-Google-Smtp-Source: APXvYqyi9xbnW2cDVsf94j9SbXL0HuQTM0QgoSbYxkUUySDf5SoWfA/fbnNV0o4lAKaHKbnMi4LeIQ==
X-Received: by 2002:a19:14f:: with SMTP id 76mr19346797lfb.92.1568111922493;
        Tue, 10 Sep 2019 03:38:42 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id g5sm4005563lfh.2.2019.09.10.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 03:38:41 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 04/11] samples: bpf: use own EXTRA_CFLAGS for clang commands
Date:   Tue, 10 Sep 2019 13:38:23 +0300
Message-Id: <20190910103830.20794-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
References: <20190910103830.20794-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in next patches. Correct it here for simplicity.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index b59e77e2250e..8ecc5d0c2d5b 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -218,10 +218,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 else
 ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
-	EXTRA_CFLAGS += -g
+	CLANG_EXTRA_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -280,8 +280,8 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # useless for BPF samples.
 $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
-	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
-		-I$(srctree)/tools/testing/selftests/bpf/ \
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(CLANG_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.17.1

