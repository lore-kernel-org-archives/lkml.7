Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC5D20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 20:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9WblPuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbfJIUmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 16:42:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43604 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731976AbfJIUlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 16:41:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id n14so3849054ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=u9WblPuD1rsm0jyX6rOP8LRDXId4vkuFAucoTNQKldbU28hMIlJ4Ye49sY+S9r4GVw
         FZlnYg+q4HiKAE96sVNakxmBf34Y9mWy3RWPbEpycFz6xT78/mZDLFsz7FEXaIXy1EXt
         XrgaMdZhH+hP/js5F/dJ3Em5ta0eRVre0FAswR5FWcDfAnxpFAk1mWdRFBtU+/IJF0Ty
         TBQ4ItMejqowBuKLezbZXsMP0uNYRa5YzBKTB7STXrYiiISY8jmZs0OxMlAXJTxMw2Uo
         ah+j28+8X6x/K5OMYVKofwMOJqb+8KuBfI6BQFyAyyrKkwdciKWqLYwXUnPM8odBEyds
         lLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9oehlPvbpQ/3mUr7ILsjkWG9P4RuU3Cq2akh+BGeG4=;
        b=E1YwYiv8eiVoCobwl4Nmf45W3UZJRxhhaS+BoEexPo54GbRI89yYaz1QeWTOBFUJam
         AQUgZmQem+kBEhutmrPPl5aMzHPdCQupknEn8niDMhVYIVB6kXdX+nOMYOG9YUgW6cjX
         ezMPjvTJ4cJM1WZuQ+NULlc2Y3V3YFxLIwJ/m0VPpXkzZW/Mwz7X/bFz/SPs9smwzAod
         eWV2DjEvL3YkRvT0SBNgoJwLZAZfCgtUmArL0Bw4objXCgVkh9P/ALn+9Vo+yoy1Mpa+
         zy2b9A29d6Dxyu6BMtf3vkfC+I/Ewl8t8pPkhLQjg7hYcV95WGjUwen9GuxETwjmGqTT
         hU1Q==
X-Gm-Message-State: APjAAAVOTRHws9aG853DpCpnHOQ53EKblnfqGcn40Lm9YCEbScnsIMXA
        7kyJKAQoSxyRIe34osGZe1aMVQ==
X-Google-Smtp-Source: APXvYqymIdgfyxgRoHuT7kBxL0jS3aNb/nX8NZ5SezJ6vkjCDt5qlasTpcF9WFmXN/+gsv58UvFtuw==
X-Received: by 2002:a2e:9b12:: with SMTP id u18mr3696925lji.142.1570653705253;
        Wed, 09 Oct 2019 13:41:45 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id h3sm730871ljf.12.2019.10.09.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 13:41:44 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v4 bpf-next 04/15] samples/bpf: use own EXTRA_CFLAGS for clang commands
Date:   Wed,  9 Oct 2019 23:41:23 +0300
Message-Id: <20191009204134.26960-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
References: <20191009204134.26960-1-ivan.khoronzhuk@linaro.org>
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

