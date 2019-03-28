Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EE4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752D421872
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rM0vdUjU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfC1Ten (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:34:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfC1Tek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:34:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so24390134wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=veeM4ZlKnlch+gefwAyRK7UAExOJ9TXLKyPKjPAv7yU=;
        b=rM0vdUjUx1GHCMeG94p6laganR+8CegPEC1lTi+rY3QdBX3L38Ol187aSgEGgi9C1k
         AvjdjfknFY3Q71YzsQdxtKakLvKwdtKRSaU3oqQF+O4nyC8Nn6n0npZz52JPsYc9+TtQ
         bL2hhgTvg3CoUA6pSfMlAVWDMCF4WedoTLTzTcoPM2M9cOUu0EJntaRp3BxBD6U5x2hI
         pzZsySwqN6BiqFgoPa/L/a3K9LvJv8vaxUhpBjvSiB5OnfWOc5gMhauHq0bVUowfo2vy
         qgGa3cLZRz75W4t9XmThKajjXsZ4MdVsXo9e3rTDTHwhTYSALYG6O1tqyttOXxJ13Uo6
         ah+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=veeM4ZlKnlch+gefwAyRK7UAExOJ9TXLKyPKjPAv7yU=;
        b=CYBW5B4XeE9tlPCdHpJYo3+NE/CpSqrQsVkbl0UvFj8enbih9pvos/XhUeSWKR+8El
         7GU7jpkkR/fQ7BM1iQePVQEmQ6/c8LjjajQ/lT2z5P8eje+2jP5WLHzNL2tU40+sGRQp
         H/6fT0PT6umc7GChBHEwvNkPevk3Djlpb1qVgZCkUx64CrdakgBplcVPGcI1eROOKWaZ
         tcb/ouMYUs/fTZMbZj79XAoh4mK1Mtd5VtLCYAaMlaAPI0BY6OWTu0iD3LA+JEnZuTWi
         KMDIJ21aJiSm6L/5DBILDfs1doLoAsj4SPtVkHHuRv9UNgxgjCYgAvn5WO+tJ6C318tl
         9Eug==
X-Gm-Message-State: APjAAAV29GvqX8oxI8UnvgdqmqZb9R4xBuDKuNuqgw6t6nfBKA2v4drr
        IxchLqzw9idWCaG9/cUZXpWaAA==
X-Google-Smtp-Source: APXvYqz6lI3v60ZKAk42ha/hvVNQgTMD5lAC7GoDSVtbw17WJGjW1gMNeE7A3FilZpKnS9UCEJRzqg==
X-Received: by 2002:adf:afd0:: with SMTP id y16mr27436030wrd.328.1553801678526;
        Thu, 28 Mar 2019 12:34:38 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:dd62:8a50:1468:989d])
        by smtp.gmail.com with ESMTPSA id d6sm27739186wrx.62.2019.03.28.12.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 12:34:37 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] efi/libstub: refactor cmd_stubcopy
Date:   Thu, 28 Mar 2019 20:34:25 +0100
Message-Id: <20190328193429.21373-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
References: <20190328193429.21373-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>

It took me a while to understand what is going on in the nested
if-blocks.

Simplify it by removing unneeded code.

  - if_changed automatically adds 'set -e', so any failure in the
    series of commands makes it immediately fail as a whole.
    So, the outer if block is entirely redundant.

  - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
    target"), GNU Make automatically deletes the target on any failure
    in its recipe. The explicit 'rm -f $@' is redundant.

  - surrounding commands with ( ) will spawn a subshell to execute them
    in it, but it is rarely useful to do so.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index b0103e16fc1b..ae9081988c88 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -86,12 +86,13 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 # this time, use objcopy and leave all sections in place.
 #
 quiet_cmd_stubcopy = STUBCPY $@
-      cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
-		     then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
-		     then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
-			   rm -f $@; /bin/false);			  \
-		     else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi	  \
-		     else /bin/false; fi
+      cmd_stubcopy =							\
+	$(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;		\
+	if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then		\
+		echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
+		/bin/false;						\
+	fi;								\
+	$(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
 
 #
 # ARM discards the .data section because it disallows r/w data in the
-- 
2.20.1

