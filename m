Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F6C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754C32082F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563509710;
	bh=CzhaAv+1g3tc7icQWTPDGHo0swJkwJI0NH1Fk+Xz0mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TT0xObJQ1/tFLm2uIKvveLryxZFpbnZXHvC0Lxlxj8rzhdCbnm8IQqNJ0huCxM4bf
	 fnUnAyusZAfG8ITqJVzcNMnGlbYsuSY92ftLwuD+AQoNmjD3WFVVTD3KrfNZTFHIaR
	 bi0/ur8K2PZ6Sb3wjfdfqd0VHpZOh7lTdrKwrW3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390048AbfGSEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbfGSEPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:15:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36ACA21873;
        Fri, 19 Jul 2019 04:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509706;
        bh=CzhaAv+1g3tc7icQWTPDGHo0swJkwJI0NH1Fk+Xz0mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Parq9vliu2E8RZWglf6Nfxc4x/O0C7FoF14VAI8gBHTdyABLBhaJ68j2FJN9JLCxK
         CG2umtLTrwlT2CZwFdmTcgkGsjX3E2ArjqquVbY0ivAnAwhW5Xqy6fZZQoa419MYpU
         oyZran+7QGQUV2td598BNKoaUd7PxQWssBN3h61U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.4 23/35] powerpc/4xx/uic: clear pending interrupt after irq type/pol change
Date:   Fri, 19 Jul 2019 00:14:11 -0400
Message-Id: <20190719041423.19322-23-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041423.19322-1-sashal@kernel.org>
References: <20190719041423.19322-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

[ Upstream commit 3ab3a0689e74e6aa5b41360bc18861040ddef5b1 ]

When testing out gpio-keys with a button, a spurious
interrupt (and therefore a key press or release event)
gets triggered as soon as the driver enables the irq
line for the first time.

This patch clears any potential bogus generated interrupt
that was caused by the switching of the associated irq's
type and polarity.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/sysdev/uic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/sysdev/uic.c
index 6893d8f236df..225346dda151 100644
--- a/arch/powerpc/sysdev/uic.c
+++ b/arch/powerpc/sysdev/uic.c
@@ -158,6 +158,7 @@ static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 
 	mtdcr(uic->dcrbase + UIC_PR, pr);
 	mtdcr(uic->dcrbase + UIC_TR, tr);
+	mtdcr(uic->dcrbase + UIC_SR, ~mask);
 
 	raw_spin_unlock_irqrestore(&uic->lock, flags);
 
-- 
2.20.1

