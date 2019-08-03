Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63357C0650F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366962087E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 00:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RVsqMgpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392754AbfHCAe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 20:34:26 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43720 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390153AbfHCAeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 20:34:25 -0400
Received: by mail-qk1-f194.google.com with SMTP id m14so30492817qka.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 17:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLAKxpLqE2JOG7T+4J6lk0YiDfUhZaobxgsE/XldIXY=;
        b=RVsqMgpnRHWgwALhBHcVBGnndl/VzSoDlmqfgWib57Zn0jcxSkd4XD4yxzObfMd0YS
         Fqn03M75MC1Tog9d1nkglRUddOa+o9mJlbW/oeA31Spb7WXXefVfqkZrLoYrPA0PxhfA
         30hljXRwqx54SDSSv/8sA37zDBP1jZub9MQaa9+GHURn2RwEBWGHDY2WZq3KSTAPh6SD
         7sup0nhV9TM1BplSL6IiZHj3JS+uNFxQ59lcN9P0xyu+Qsa3rKayi3yNJXjMYerwil57
         5wO20fH9vM36kQQN1SaZW9XjdJdRMbLN4g2ehDEs1kmj4hz1djUrdcUCBJT+ug/e++GJ
         4Zrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LLAKxpLqE2JOG7T+4J6lk0YiDfUhZaobxgsE/XldIXY=;
        b=ax88qjZItufl+b6h6d5qc7TSMqm99Zpcq0ymOnXrTR3RhKLA6oUPVG/wQz+0BKomeN
         GrM7h4RyiyhTTZwMYk0ndEO+zwTeU60dhvgPpWa9fRSNdDe34R8qYunUPJhIqrg2h+gJ
         +VP6CFhYTlb/JwXDXY7DOGjnTJ94QXsCbk/LCGxS7s7rr3C/vODdULOOZbcRQbsj6mc9
         2ZfqZl63azGt8kUBB9Iepf5tt4aJAmV1R4bPkSLRLAEjUthgV4G08CaWYPTAWk9OXo2s
         gsAjhgS7m8EY7XvXMObodUwPWBrt+PbHixW9cX9pm5/FUDOF2M0GAEAdLHZ5hwKM2Tu+
         b54Q==
X-Gm-Message-State: APjAAAWZrtcy10c6vXaFbTe1f43uy3T2JQlBVvCyDsT7AOumf3uzE4KT
        BTN1klF2LvQbP0KwjncQhVU1KQ==
X-Google-Smtp-Source: APXvYqzjSg+1MrgBmSDT/gk953+I4OZ78rE7huZlzArJoL7LkO6N1WmtVgfdsM5tvVCVXs4eUpsfXw==
X-Received: by 2002:a37:9506:: with SMTP id x6mr95149436qkd.107.1564792464729;
        Fri, 02 Aug 2019 17:34:24 -0700 (PDT)
Received: from ovpn-120-69.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x46sm45986742qtx.96.2019.08.02.17.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Aug 2019 17:34:23 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     will@kernel.org, catalin.marinas@arm.com
Cc:     rrichter@cavium.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH v2] arm64/prefetch: fix a -Wtype-limits warning
Date:   Fri,  2 Aug 2019 20:33:58 -0400
Message-Id: <20190803003358.992-1-cai@lca.pw>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit d5370f754875 ("arm64: prefetch: add alternative pattern for
CPUs without a prefetcher") introduced MIDR_IS_CPU_MODEL_RANGE() to be
used in has_no_hw_prefetch() with rv_min=0 which generates a compilation
warning from GCC,

In file included from ./arch/arm64/include/asm/cache.h:8,
                from ./include/linux/cache.h:6,
                from ./include/linux/printk.h:9,
                from ./include/linux/kernel.h:15,
                from ./include/linux/cpumask.h:10,
                from arch/arm64/kernel/cpufeature.c:11:
arch/arm64/kernel/cpufeature.c: In function 'has_no_hw_prefetch':
./arch/arm64/include/asm/cputype.h:59:26: warning: comparison of
unsigned expression >= 0 is always true [-Wtype-limits]
 _model == (model) && rv >= (rv_min) && rv <= (rv_max);  \
                         ^~
arch/arm64/kernel/cpufeature.c:889:9: note: in expansion of macro
'MIDR_IS_CPU_MODEL_RANGE'
 return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX,
        ^~~~~~~~~~~~~~~~~~~~~~~

Fix it by making "rv" a "s32".

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: Use "s32" for "rv", so "variant 0/revision 0" can be covered.

 arch/arm64/include/asm/cputype.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index e7d46631cc42..d52fe8651c2d 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -54,7 +54,7 @@
 #define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		\
 ({									\
 	u32 _model = (midr) & MIDR_CPU_MODEL_MASK;			\
-	u32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
+	s32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
 									\
 	_model == (model) && rv >= (rv_min) && rv <= (rv_max);		\
  })
-- 
2.20.1 (Apple Git-117)

