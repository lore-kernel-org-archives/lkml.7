Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347BCC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D52B214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 00:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARrbso8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbfJKA23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:28:29 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33566 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfJKA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:28 -0400
Received: by mail-lj1-f195.google.com with SMTP id a22so8065594ljd.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 17:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=ARrbso8csUYbUgve+g7WykoFNP9+JXtn6BeuhwqYVd6l3bO+5ocRcfxrg2hjs5aX1O
         kCWylnHErMmzxClr+POVIg8M1lPp7KN3gxCF1uVOjnOK1BxmLEGhmNRudGKKRPwlBMy/
         temn0HLI8auoXxI/j87dHFM9xgNijn66PJ6QxUeBdzNMFwU6unVq/DNffXJc75oeqmVn
         8I1tZ39dO/T+So8R65flnQR8Rx0t8xDfe7phHglv2e5RHy/L2/4h54VLvgCN3PwYEz7+
         +nHyT22x7znMK259QnoduZ64Qzoz3Y1ro3y8xWIN3Lg0BuCVq2E+DrZha4QllJgFZKFe
         ys4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=Rezj+m0E9arPlDBi9O3q5PsQe2O+OfaakYvSFGfS8+HzGCkLpUWrkAkIsmvwvrCQ6r
         em7GsZUP25/3Y6RSc0QIo0FhmPbC1qOOhOZQm8QV1x16EknH8JFuoKD05mEHonXMV1uJ
         YzCa/XTrgBZnRCO8IMrFZP+oFVc2z1eE3QIlAG54Aj65cqbj/GOZ8/Rabuj4n0XTwQFH
         X5cK7CuCjHYszRtlCDR58E+kHPI+uHPKge2o0Ung4LqcvyxQkGl7dwDTeCqGVBn3V9Y7
         V8G5ULsGX5cpyNACpysNnCnicguZplo4Av0+25ZEaQw5nJy6wMmhWNUf8CQzikHpzpV4
         og0g==
X-Gm-Message-State: APjAAAUITKjT1qzQyD69+llJHDwCc0vwzfCdYm1q3uPIeAe4XioQb/VK
        JwEyC4r2G6YScPXoRNBsf517+A==
X-Google-Smtp-Source: APXvYqyrgXNBl8ebnFf7ufkSfNlgGt8OIp6Eb8TBem0W1vxjEfJgjYa6gtwUgCQPiHdokoJvnWzDrQ==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr7876486ljg.14.1570753706383;
        Thu, 10 Oct 2019 17:28:26 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:25 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 04/15] samples/bpf: use own EXTRA_CFLAGS for clang commands
Date:   Fri, 11 Oct 2019 03:27:57 +0300
Message-Id: <20191011002808.28206-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in next patches. Correct it here for simplicity.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 9c8c9872004d..cf882e43648a 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -218,10 +218,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
 			  /bin/rm -f ./llvm_btf_verify.o)
 
 ifneq ($(BTF_LLVM_PROBE),)
-	EXTRA_CFLAGS += -g
+	BPF_EXTRA_CFLAGS += -g
 else
 ifneq ($(and $(BTF_LLC_PROBE),$(BTF_PAHOLE_PROBE),$(BTF_OBJCOPY_PROBE)),)
-	EXTRA_CFLAGS += -g
+	BPF_EXTRA_CFLAGS += -g
 	LLC_FLAGS += -mattr=dwarfris
 	DWARF2BTF = y
 endif
@@ -280,8 +280,9 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
 # useless for BPF samples.
 $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
-	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(EXTRA_CFLAGS) -I$(obj) \
-		-I$(srctree)/tools/testing/selftests/bpf/ -I$(srctree)/tools/lib/bpf/ \
+	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
+		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
+		-I$(srctree)/tools/lib/bpf/ \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.17.1

