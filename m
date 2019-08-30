Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E5EC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5921726
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEYfqXzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfH3Aux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:50:53 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37007 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfH3Aut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:50:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id w67so3981330lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q+vZM4cZektdF572TqWkVl3QkOoJAXjpmJXjWwwbKzE=;
        b=LEYfqXzZUPeIuy93SH8GAssQsvlBou/hIWteBhvmXq1F9JVWj2wTkzeZdfRJclvOXa
         Ml9kVrTIeDyM2A/3eaEvzVK9/pGt5qEqzLTWvJqdBmLcHkvvh07Ut09wAvSKXrIMNobx
         r2RNchETr9Z4KWTcRDbMNJ6rLBGv3sDWxx1Z8Z5O54FYC/zPoXMdoQJR1eWto+H3GBER
         DlMphrpkhbPZGMzNxrWnt0/mC94HVFKOY0k+/6wVxcaRK9ftaqDrp/Dypqjz3DpeV74s
         5LHndEkamECTgyLl93XSkTDSnp9E79AvMzRJuicO+St87f2BsjM+kyYugZH0KcXkbFhW
         G9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q+vZM4cZektdF572TqWkVl3QkOoJAXjpmJXjWwwbKzE=;
        b=inT0L6vcY7IasPlXxu3RoFvYD+axgCnflXGjcKJyVSNMqzH2wNpOHSS6TaAzRSUjOV
         bj83n4Plv6nUOn2G1AnmDaLsQAdt+faugVPBFDFkgv3CmbDucYqmA2q2/fixBzJDTT9d
         /9ArLRFlfAzpacl6HvwbawoHGYIY+KeAltMc51mT/7WVKWJLRd+gjGcqe2XUF4B/uboI
         AdlTSeysWjdVVqtu2IEuGq6BAfNzTuS1XRzqwM/fbHoPat4RdPSgMDrZKKEMVTrwQuJS
         sQ3s6plygFWoVGJI5FAwmFkiK6x3+yXWCgvIJlK56N7yXlM/sDPJ7krSaNzomhDVoCfs
         VXZA==
X-Gm-Message-State: APjAAAUctDAmMIlrgk/w7Rvdkhc4fgCPo37ZWT/4O9ULvqYnQjoCDarX
        0zhtfirZIGMGppkot3RCmJh0JYEiuQY=
X-Google-Smtp-Source: APXvYqyihXTROPMaQ2wywc9lmAKFZbgnRCz1760bakTi1cPbibvD2WXzoa2W4G39kM/s/BUv/T280g==
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr2637945lfc.28.1567126246924;
        Thu, 29 Aug 2019 17:50:46 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id f19sm628149lfk.43.2019.08.29.17.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:50:46 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     linux@armlinux.org.uk, ast@kernel.org, daniel@iogearbox.net,
        yhs@fb.com, davem@davemloft.net, jakub.kicinski@netronome.com,
        hawk@kernel.org, john.fastabend@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH RFC bpf-next 04/10] samples: bpf: use own EXTRA_CFLAGS for clang commands
Date:   Fri, 30 Aug 2019 03:50:31 +0300
Message-Id: <20190830005037.24004-5-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
References: <20190830005037.24004-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can overlap with CFLAGS used for libraries built with gcc if
not now then in following patches. Correct it here for simplicity.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a2953357927e..cdd742c05200 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -219,10 +219,10 @@ BTF_LLVM_PROBE := $(shell echo "int main() { return 0; }" | \
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
@@ -281,8 +281,8 @@ $(obj)/hbm_edt_kern.o: $(src)/hbm.h $(src)/hbm_kern.h
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

