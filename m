Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D24C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 03:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B97T+c1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfHLDbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 23:31:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHLDbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 23:31:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id u25so10453813wmc.4;
        Sun, 11 Aug 2019 20:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GrCFpyZQs6ZZ7O7d1Qhq+Unb0hfalC6XSsvlDHakE4Y=;
        b=B97T+c1I1vatW4tiiitsJZHGgKkqj1IPibjG98ElVQTjSQbyiiT11RUFtWCnTlzmj0
         oIddJjbFaRgCT3ZWBGy4eHkPsZI1US0lqWapGeF/nq/AsnCRYYcy8+n7LZg6JKQyCZDD
         YKwpDHv4w1gMdaBjwfUNEIKzhRuxDiDSzMOVY3W+wap9xY+hWszZd94QJj9KB5uio1dx
         h9Oo2MwKHk33NtD2uHGzeGJqDo96x0geSMFaGeUF7rWTJipqnXQEMZRo6qqoewPPDnOg
         zZxPLNA01zyM2Oc0jS+zS1Pz+41cN8BY7mkOIbJEheSWemp7hfY1DJx8D8mzDqLVpK1F
         wZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GrCFpyZQs6ZZ7O7d1Qhq+Unb0hfalC6XSsvlDHakE4Y=;
        b=mWekkriKKZh4u/mjTn40mgWf50C9EgsV7GWH8bZnT/Gdb+DhH8c95xV7zf3AJ9Jqi3
         g3omKad/+ewSdoj6Nbierx9fDJkwjmKcVMupvQDAqGBl9lHlGlABbCdNoTEMiiOHOxZg
         qq12W1JOFUumxm9dUk7y7wu9pxO2D2ypvYzimGtkTnCYd0ETVYJERbOH+K/hk8BRhz/T
         TQkH/CpjZRFJ2BtcTWsMk8+HCCN2bdZC6DeUYa/p3gpXgHBwMcS6E+m7Ab4GL2jfSsVL
         ym7/71/9PTpHPkV2ayX14vK4nd70zR6DvDZoluwUJB6Ra37a4jAYeDka/YeagvFjBp5r
         uUtg==
X-Gm-Message-State: APjAAAWq40dPxa8DA8SiCN8AZxI6a/OBWj9CkA921PEILYd2acH1IAcZ
        QndYCAlA36kUesK2Bvhbckk=
X-Google-Smtp-Source: APXvYqwHzHLvP7jzbcZ7GguxbaQufHwAcSthXLU14mLGLeTK6o86gecLOX3PCLCxQA6I2ZObCXhS+Q==
X-Received: by 2002:a1c:9a4b:: with SMTP id c72mr24779104wme.102.1565580697186;
        Sun, 11 Aug 2019 20:31:37 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:222:2f1b::2])
        by smtp.gmail.com with ESMTPSA id f12sm117299330wrg.5.2019.08.11.20.31.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 20:31:36 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 5/5] MIPS: tlbex: Explicitly cast _PAGE_NO_EXEC to a boolean
Date:   Sun, 11 Aug 2019 20:31:20 -0700
Message-Id: <20190812033120.43013-6-natechancellor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
In-Reply-To: <20190812033120.43013-1-natechancellor@gmail.com>
References: <20190812033120.43013-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns:

arch/mips/mm/tlbex.c:634:19: error: use of logical '&&' with constant
operand [-Werror,-Wconstant-logical-operand]
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^  ~~~~~~~~~~~~~
arch/mips/mm/tlbex.c:634:19: note: use '&' for a bitwise operation
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                         ^~
                         &
arch/mips/mm/tlbex.c:634:19: note: remove constant to silence this
warning
        if (cpu_has_rixi && _PAGE_NO_EXEC) {
                        ~^~~~~~~~~~~~~~~~
1 error generated.

Explicitly cast this value to a boolean so that clang understands we
intend for this to be a non-zero value.

Fixes: 00bf1c691d08 ("MIPS: tlbex: Avoid placing software PTE bits in Entry* PFN fields")
Link: https://github.com/ClangBuiltLinux/linux/issues/609
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/mips/mm/tlbex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
index eb21277f4141..071d48593464 100644
--- a/arch/mips/mm/tlbex.c
+++ b/arch/mips/mm/tlbex.c
@@ -629,7 +629,7 @@ static __maybe_unused void build_convert_pte_to_entrylo(u32 **p,
 		return;
 	}
 
-	if (cpu_has_rixi && _PAGE_NO_EXEC) {
+	if (cpu_has_rixi && !!_PAGE_NO_EXEC) {
 		if (fill_includes_sw_bits) {
 			UASM_i_ROTR(p, reg, reg, ilog2(_PAGE_GLOBAL));
 		} else {
-- 
2.23.0.rc2

