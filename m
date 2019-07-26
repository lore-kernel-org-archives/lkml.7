Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AC5C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EED622CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/lqe97a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfGZL12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:27:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36077 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfGZL11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:27:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so51173692ljj.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 04:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mD75t+URGZsK68zObcoQDgfEcM4EggmUqFsamz8uvA8=;
        b=v/lqe97aY/6DKYSisz+Bh2DOxmrmfqzDS78mI5csTH9jAkHOsQf3u/nQHsbpw6wuAR
         bMIIYx1fPDpnl3RkTb4wAx50nibsu3pMG3MYUzUX1qaqyy5QzU784Z/rxIp2Hs3i7Z2/
         JGvxNlWagTD1QUHKl1n/cx6w1ei6w0SlS5IlDrMUXjfcqn0d9fhA+3gSJ33IQ4H6YSpW
         MDfW5F/MG4dpu8ozAK5L5RxmRx+lzrsoLICfH8V2EWH83o9rfP4uTHnxHp428YRXL0LL
         jP4u4B9D5If5HLU5D4h+FgCmFq4bEx7gwQ+OOIanHaMGdYIeCPvqox1hd4jukUHDmmG8
         7wSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mD75t+URGZsK68zObcoQDgfEcM4EggmUqFsamz8uvA8=;
        b=KVeRC5IUoccF31slE9DM1zi61GzzKR9UAMhnZZJQ/95ArDdEeka3w5wK7Jp4XJFJ3Q
         U37mLdOkyl7EG4SvVII8v0SCSrFc0fJT+sTi2UbB4h+w7Kfb6fljvJDs3L7/MajO3G9j
         K4xlyEBdu2b3ubsk/clyYWea0jriatw21C0kbBYP1w28Ax/e55AlA8mjUClelcIxGsiy
         BoQJAPdZfbsSsFFNOt91oY9WptCesWI4WRmjjF7lOAm5x10O00hrtxn+KGsMHjJwk8Cd
         vxNiQba8yV9ZTn/mLFIX+SNqpbvwWxg7AOoR6pcg0iY1n66LhGWwqOdJn9Fr+9eB+YjA
         lGfw==
X-Gm-Message-State: APjAAAUfljdAJuRFaOy5tM2M+FGXu9B3GSz0tBQw66+iGutKrTVDcA5d
        5MSiS9AsNK95htdS/YVaSbuyMg==
X-Google-Smtp-Source: APXvYqy1Iy6b2yOwjFSIa/VBUa/31LvNZNgxAzQlPOq9T/Kdpd5y1geOUuOJ4C07BdR6g4ervbZ1PQ==
X-Received: by 2002:a2e:8396:: with SMTP id x22mr50602259ljg.135.1564140445364;
        Fri, 26 Jul 2019 04:27:25 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id i9sm8365620lfl.10.2019.07.26.04.27.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 04:27:24 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 2/3] arm64: module: Mark expected switch fall-through
Date:   Fri, 26 Jul 2019 13:27:21 +0200
Message-Id: <20190726112721.19154-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When fall-through warnings was enabled by default the following warnings
was starting to show up:

../arch/arm64/kernel/module.c: In function ‘apply_relocate_add’:
../arch/arm64/kernel/module.c:316:19: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
../arch/arm64/kernel/module.c:317:3: note: here
   case R_AARCH64_MOVW_UABS_G0:
   ^~~~
../arch/arm64/kernel/module.c:322:19: warning: this statement may fall
 through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
../arch/arm64/kernel/module.c:323:3: note: here
   case R_AARCH64_MOVW_UABS_G1:
   ^~~~

Rework so that the compiler doesn't warn about fall-through.

Fixes: d93512ef0f0e ("Makefile: Globally enable fall-through warning")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 arch/arm64/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 46e643e30708..03ff15bffbb6 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -314,18 +314,21 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* MOVW instruction relocations. */
 		case R_AARCH64_MOVW_UABS_G0_NC:
 			overflow_check = false;
+			/* Fall through */
 		case R_AARCH64_MOVW_UABS_G0:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
 					      AARCH64_INSN_IMM_MOVKZ);
 			break;
 		case R_AARCH64_MOVW_UABS_G1_NC:
 			overflow_check = false;
+			/* Fall through */
 		case R_AARCH64_MOVW_UABS_G1:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
 					      AARCH64_INSN_IMM_MOVKZ);
 			break;
 		case R_AARCH64_MOVW_UABS_G2_NC:
 			overflow_check = false;
+			/* Fall through */
 		case R_AARCH64_MOVW_UABS_G2:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
 					      AARCH64_INSN_IMM_MOVKZ);
@@ -393,6 +396,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			break;
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
+			/* Fall through */
 		case R_AARCH64_ADR_PREL_PG_HI21:
 			ovf = reloc_insn_adrp(me, sechdrs, loc, val);
 			if (ovf && ovf != -ERANGE)
-- 
2.20.1

