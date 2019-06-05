Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE243C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A833D20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 11:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X02Atdsy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfFELcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 07:32:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51819 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfFELcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 07:32:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so1899639wmb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fq/0HsgXoB1nRHLPZXI7UXo7HjgNA7LU3koFGqmSqD0=;
        b=X02Atdsy3C681HA7JnuQxaqDhg61yuUhbr8iS1xU6xK+Arr2PqhvIuh0WycWfVgIhp
         HmrNAkepa0D4UruAwoYD6EvA9JmlnIaXHR1XLpWZDu75Lcg3CwlqgBJejRxutBGv5XhP
         T1XbiftNpigtfyb3COuKo+NQanxEeWFTOzTJWw4NKIhVobdYpn1zApSPeXOFrURdVsh0
         e0fR05EKOF07GGAdl21KTimoDxpqElfFAHVGJIhczTCt5IcWUea4X1I7Gq5gqhxEtBcL
         MF/pU0i9YHCRNLhjg0gMeYyafrUg4yCSn75JEFT9olxNwTzhmrt/7Vwy/I9T5mhKgrL8
         L/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=fq/0HsgXoB1nRHLPZXI7UXo7HjgNA7LU3koFGqmSqD0=;
        b=RpTlbq5I8K6orQ+qv+m0yiGTozXcauBV3VPvFzFT5Fq7fkhPg4RyTDKJX8DmohieQv
         A+dHu7S43PeN4lK33otzMPtQMi5/szEGLD9MP8WLTAi5AdZMkAhG4sRmrP1wFPZsH0Lm
         4LYnHcn1nDz1XFHBPWDvF+Ff8oDAoazM1CdjQBcRGSV7BcrOTeu8MZZJfslxoo7pV3/S
         4GPmLkMiIqBanSgIQAZwufgQlYTXrbLZ+sFVEsqsZPW2Bp2BzIhHXzOjyg1Fw2Qhi17P
         PxiKIlOKUZdR4MGB03FCteAmbKR3n+EP12sTl+FLKHHLYAquVqMfbUFKPOS7SgUv31ul
         76fw==
X-Gm-Message-State: APjAAAUdChvzD4WoeItZ8jx5sEwFPv1W5rZQpAkLH7v8N4b7bvdM5tWY
        S91z9vtXYJxFzVmWApy5vziKejUH
X-Google-Smtp-Source: APXvYqzWt6QuVEa1032Ix8EW1hazJDm93XbWIDyaTHSiw9pvdPOjaH0uOtFp0SxILKZ2uRhwdIc8wA==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr21075203wmb.110.1559734373241;
        Wed, 05 Jun 2019 04:32:53 -0700 (PDT)
Received: from macbookpro.malat.net ([2a01:e34:ee1e:860:6f23:82e6:aa2d:bbd1])
        by smtp.gmail.com with ESMTPSA id b8sm15985257wrr.88.2019.06.05.04.32.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 04:32:52 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 07434114590C; Wed,  5 Jun 2019 13:32:51 +0200 (CEST)
From:   Mathieu Malaterre <malat@debian.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/32: Add .data..LASAN* sections explicitly
Date:   Wed,  5 Jun 2019 13:32:49 +0200
Message-Id: <20190605113249.6393-1-malat@debian.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When both `CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y` and `CONFIG_KASAN=y`
are set, link step typically produce numberous warnings about orphan
section:

  powerpc-linux-gnu-ld: warning: orphan section `.data..LASAN0' from `net/core/filter.o' being placed in section `.data..LASAN0'
  powerpc-linux-gnu-ld: warning: orphan section `.data..LASANLOC1' from `net/core/filter.o' being placed in section `.data..LASANLOC1'

This commit remove those warnings produced at W=1.

Reported-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 060a1acd7c6d..c74f4cb6ec3a 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -307,6 +307,9 @@ SECTIONS
 #ifdef CONFIG_PPC32
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
+#ifdef CONFIG_KASAN
+		*(.data..LASAN*)
+#endif
 #ifdef CONFIG_UBSAN
 		*(.data..Lubsan_data*)
 		*(.data..Lubsan_type*)
-- 
2.20.1

