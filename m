Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62963C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DFC20685
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0c5OEuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfC1Ter (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53671 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfC1Teq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so56618wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JaJrMwXMbqfybcRUS11Ps0vcG+jaWoUIDyHOkmGA5GE=;
        b=I0c5OEuY68J+FznI02PCWUijbJH/VbFB/z3m2fTABTNS2oQskKrdva/5gnBM3A0oNL
         +PtdEVTUFg3M1q+z3R9KlOjdxdDcRacl23THG2lEfBaCb9sP/0/JnL87zBuDPmZW3Qtz
         jflNBy6/qGsUAhT6bEw/3v/2dH4PNAgy11dRtns6eVc60Zsmb82z+/8WMETVM2evPO3e
         VJxJmDOyKbp4YarHuvK240Uu8bcj/peJRLG2av9nKjrSE/g2db0+ogr3/9C4BU84TlEM
         sbAzYzqBwa4SqAymGeLdmbf3Nmk26tUhN2T0ophTiKheTQZYXVqHFWulYynlIyfYXV9U
         VlmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JaJrMwXMbqfybcRUS11Ps0vcG+jaWoUIDyHOkmGA5GE=;
        b=DJXUXjGIlISH0xnHy9c8Wn+qmaVUYCkdaxef7E26BWbgApPn/b+jSg5iHMP8B7N/dF
         0CLJc9HXzTOvlVUDVRUcoEkHvY2/xbq6IolSHOEjB4/Oeg5YuZUAD2anY858jlhOP3ri
         sYCY9vTJNOxUesNHlxYHjg2ierwYlmdEMNkmoZa9MgZYhW+BiHxMJEgthiLS+aNQr3UC
         nC6atrpoM+DiIEkVAHMF6FVRNBqrd7K+3P/TB2Bqd36wuH5DeuTrNA0dcoobb2jhS0qy
         bhuxDeTCD8X9C1kcShwkVklgBtGfPLywnaBRn1abXifYsJzx18YXkqYS605JS+6gYSOu
         NCNQ==
X-Gm-Message-State: APjAAAUexYcorbtZQ6aTaSTNtyPV7CQMbfvg2Q1UYn2xJ7CEAj+KuTBZ
        Iq7Nzcvea6IsmCOIwk4r4sZ9BA==
X-Google-Smtp-Source: APXvYqzrNK0gghjFgPO/2GJeu4qQsMm/g2+ECfXkIQLcodE1iNtl1Rf1vRf4rmLjC5wCyy3IHPYEMw==
X-Received: by 2002:a1c:7f10:: with SMTP id a16mr1069150wmd.30.1553801684490;
        Thu, 28 Mar 2019 12:34:44 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:43 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 5/5] efi/libstub/arm: omit unneeded stripping of ksymtab/kcrctab sections
Date:   Thu, 28 Mar 2019 20:34:29 +0100
Message-Id: <20190328193429.21373-6-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f922c4abdf764 ("module: allow symbol exports to be disabled")
introduced a way to inhibit generation of kcrctab/ksymtab sections
when building ordinary kernel code to be used in a different execution
context (decompressor, EFI stub, etc)

That means we no longer have to strip those sections explicitly when
building the EFI libstub objects, so drop this from the Makefile.

Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index ae9081988c88..b1f7b64652db 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -71,7 +71,6 @@ CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 extra-$(CONFIG_EFI_ARMSTUB)	:= $(lib-y)
 lib-$(CONFIG_EFI_ARMSTUB)	:= $(patsubst %.o,%.stub.o,$(lib-y))
 
-STUBCOPY_RM-y			:= -R *ksymtab* -R *kcrctab*
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
 STUBCOPY_RELOC-$(CONFIG_ARM64)	:= R_AARCH64_ABS
@@ -87,7 +86,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 #
 quiet_cmd_stubcopy = STUBCPY $@
       cmd_stubcopy =							\
-	$(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;		\
+	$(STRIP) --strip-debug -o $@ $<;				\
 	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
 		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
 		/bin/false;						\
-- 
2.20.1

