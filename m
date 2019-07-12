Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2ABC742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59DA21670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934059;
	bh=AyMrDlvK9JOOsXx47vtxuqCDRX8Yg+Jq+LLv0NVejhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uwalJEm+gu6FarNX00vwCe1xj8evKQMkknGVWy8E6QCaBAWnDvr7zxP5AwRwvSkR1
	 KIlPimoVDPsmwjlUoC0QIQFVP2Eh/ypWmiwreFo07pRY5dQLPzOHRoxsMAJFV7pAGw
	 OPCMlJazG3hMn/JEltVYyDFB9gFy/QMfYmUGPMyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfGLMU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727482AbfGLMU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D31208E4;
        Fri, 12 Jul 2019 12:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934055;
        bh=AyMrDlvK9JOOsXx47vtxuqCDRX8Yg+Jq+LLv0NVejhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2n+iyTbdl3wElYHCXQAuyDVu22w1mpU+gE9IM9XvY/5dQ7D0ZdNhFNWdKjiKJhZ9H
         q97Sh9Xo9oX7ZTTd3eaMSJo1C8dJKycHM0ZAt+HUTSGkCu/txcqTvXHpQClqReoyye
         Gfr6LN9xvPTsG+DP2sFk1w2EBB9GoAOGA+O8KS9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/91] riscv: Fix udelay in RV32.
Date:   Fri, 12 Jul 2019 14:18:33 +0200
Message-Id: <20190712121622.986765867@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit d0e1f2110a5eeb6e410b2dd37d98bc5b30da7bc7 ]

In RV32, udelay would delay the wrong cycle. When it shifts right
"UDELAY_SHIFT" bits, it either delays 0 cycle or 1 cycle. It only works
correctly in RV64. Because the 'ucycles' always needs to be 64 bits
variable.

Signed-off-by: Nick Hu <nickhu@andestech.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
[paul.walmsley@sifive.com: fixed minor spelling error]
Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/riscv/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/lib/delay.c b/arch/riscv/lib/delay.c
index dce8ae24c6d3..ee6853c1e341 100644
--- a/arch/riscv/lib/delay.c
+++ b/arch/riscv/lib/delay.c
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(__delay);
 
 void udelay(unsigned long usecs)
 {
-	unsigned long ucycles = usecs * lpj_fine * UDELAY_MULT;
+	u64 ucycles = (u64)usecs * lpj_fine * UDELAY_MULT;
 
 	if (unlikely(usecs > MAX_UDELAY_US)) {
 		__delay((u64)usecs * riscv_timebase / 1000000ULL);
-- 
2.20.1



