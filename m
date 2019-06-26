Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4292C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE2620663
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 04:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1VTP7Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfFZEUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 00:20:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44208 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFZEUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 00:20:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so1146539edr.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 21:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Cl6yVigkJvzoVrHwes9kSjc7pM4VSMZ/+3LWRXp8II=;
        b=P1VTP7Pj84OsQis7x1uKS38d7izOAewPCuxClFsIh3Q8xGkm2w4RgYFl/ekzoDot/d
         RTQkeWGv2/mJmfDBEZycoPXx/VnVCV+bKYezE/Jp05k1ZV98lV/XSNH1ReTqSAqkI20x
         0fZ34XTKKdzC7dzKT/7nFE2cFuOfUyyMGoR/Um+LfVodvd3Gp63yidTSlEfLjrzHsbPd
         /UQ/WYvvB6r1cqCXUZ3bdQ3qTR7MZW+0EpeXUfSuzT0BfIQoQOPN+zazD0Wed/sVNy1Y
         ISzB4OmUR8YRywE4m0HoB4hYbglqSbD24bv6xGQtupOSojegFam/ztLkKtRyy/84s5l1
         pwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Cl6yVigkJvzoVrHwes9kSjc7pM4VSMZ/+3LWRXp8II=;
        b=pXKrKtBYXLzeHRyvJK1DeR58/rp1KBoKBuUgYUVDNYICuAq36mYkUk1DMrOOsT0nk4
         Bg6DymO/S7p/HLjbsS9da3QPOqOKAXuhtBeQSGcyNOi8Npo/oTP+sNBhErcBIRPcrMOU
         /OJaEr8s4Cj4UqkgjVk7V1rULi/yxsGkrpO7Z/oMJTJqaje4dLUgaxDCFb6VmY3FaDcN
         jeE66kmdKRJ7LbUm8CzYTDLuxv/i0679wsrZA0tVDFIAA2FyUel/PwxytP6vVS+NUrte
         2Acre+BoJN4vPBkAfqI4B5jZvPRihgxfPqkSrmuGjqy9iSEVVkQLKH5AgwzaFBSZq6Ge
         azLg==
X-Gm-Message-State: APjAAAXNAzk4QL0cjCS6RgSSsX7W2vbUPGJq3Y7bT1G9ewOPrDAqBe8t
        qKlvZFn+1q3OngjKJLobuLk=
X-Google-Smtp-Source: APXvYqwXqs1HEBueWWQka/6CMFwu/lhK03HSxnd+VHGfUzx+yhV/PAHnMwGpK/7LqQHSt0mldLz/Og==
X-Received: by 2002:a50:b6c7:: with SMTP id f7mr2392320ede.275.1561522834286;
        Tue, 25 Jun 2019 21:20:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id a3sm5180717edr.48.2019.06.25.21.20.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 21:20:33 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@linaro.org>
Subject: [PATCH] arm64/efi: Mark __efistub_stext_offset as an absolute symbol explicitly
Date:   Tue, 25 Jun 2019 21:20:17 -0700
Message-Id: <20190626042017.54773-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After r363059 and r363928 in LLVM, a build using ld.lld as the linker
with CONFIG_RANDOMIZE_BASE enabled fails like so:

ld.lld: error: relocation R_AARCH64_ABS32 cannot be used against symbol
__efistub_stext_offset; recompile with -fPIC

Fangrui and Peter figured out that ld.lld is incorrectly considering
__efistub_stext_offset as a relative symbol because of the order in
which symbols are evaluated. _text is treated as an absolute symbol
and stext is a relative symbol, making __efistub_stext_offset a
relative symbol.

Adding ABSOLUTE will force ld.lld to evalute this expression in the
right context and does not change ld.bfd's behavior. ld.lld will
need to be fixed but the developers do not see a quick or simple fix
without some research (see the linked issue for further explanation).
Add this simple workaround so that ld.lld can continue to link kernels.

Link: https://github.com/ClangBuiltLinux/linux/issues/561
Link: https://github.com/llvm/llvm-project/commit/025a815d75d2356f2944136269aa5874721ec236
Link: https://github.com/llvm/llvm-project/commit/249fde85832c33f8b06c6b4ac65d1c4b96d23b83
Debugged-by: Fangrui Song <maskray@google.com>
Debugged-by: Peter Smith <peter.smith@linaro.org>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm64/kernel/image.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/image.h b/arch/arm64/kernel/image.h
index 04ca08086d35..9a2d2227907c 100644
--- a/arch/arm64/kernel/image.h
+++ b/arch/arm64/kernel/image.h
@@ -67,7 +67,7 @@
 
 #ifdef CONFIG_EFI
 
-__efistub_stext_offset = stext - _text;
+__efistub_stext_offset = ABSOLUTE(stext - _text);
 
 /*
  * The EFI stub has its own symbol namespace prefixed by __efistub_, to
-- 
2.22.0

