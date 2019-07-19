Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286D4C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E948E21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563510058;
	bh=4C3GOrjknXPI85zfXqF36miPxIgMOCcb0/OZJSd8Rqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ag0Fu31Hm5pgU09voB23Wp+Hyaq7CfyRb1DDY5KjBEytafCXaWVRZXR28W4YlBVDP
	 DUAZyrFs4X7YrK9eO43qfmTZ2tz3SpZtmQ0SsvX8aUlxjQX1xnSiiCzERO41E2ueiy
	 HhKkB8JS/Vgyskfoo1fD09DoY8ZPeCca6LtgfjbM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfGSEU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387878AbfGSEMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:12:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6892189D;
        Fri, 19 Jul 2019 04:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563509536;
        bh=4C3GOrjknXPI85zfXqF36miPxIgMOCcb0/OZJSd8Rqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fP/r4FYgi8ckdxTszqGLR2JZsc8bbvCJ9UELZRHAmmDO5OUHgntHdmasG2/WAa+l0
         78YvbmplVR6B0A6sLg8Ew8wqccuzN77DeiPb7j7Zx7PwoQIpgi88CDqsrluUjqtxEG
         p7MHzcddf1dsJZXwnbTPuwdwLrdx8FngzccVbH28=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christian Lamparter <chunkeey@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 37/60] powerpc/4xx/uic: clear pending interrupt after irq type/pol change
Date:   Fri, 19 Jul 2019 00:10:46 -0400
Message-Id: <20190719041109.18262-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719041109.18262-1-sashal@kernel.org>
References: <20190719041109.18262-1-sashal@kernel.org>
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
 arch/powerpc/platforms/4xx/uic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/4xx/uic.c b/arch/powerpc/platforms/4xx/uic.c
index 8b4dd0da0839..9e27cfe27026 100644
--- a/arch/powerpc/platforms/4xx/uic.c
+++ b/arch/powerpc/platforms/4xx/uic.c
@@ -158,6 +158,7 @@ static int uic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 
 	mtdcr(uic->dcrbase + UIC_PR, pr);
 	mtdcr(uic->dcrbase + UIC_TR, tr);
+	mtdcr(uic->dcrbase + UIC_SR, ~mask);
 
 	raw_spin_unlock_irqrestore(&uic->lock, flags);
 
-- 
2.20.1

