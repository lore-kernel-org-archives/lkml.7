Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBB3C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F38032082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054248;
	bh=x3DQAm9fBik+KczsyNcMttT72qr4M0hPWQmDCAH5ZlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WryXg9EJMGWrFZ7l4ZoRqO7IHG769xCjlzMvcAYNCo9MTjUP+axLZKlA5a3CChM5r
	 hYqvCdzrhyLIXCBkTxuKQQKft1MyJGH3Q1Mu023w1hoI2tcq/aygRyj7swkJq8bciC
	 ObRnkZmkJ6wVBr/lQPeJyBrwFpYaoGMgZzE5Hg88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbfFTSKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFTSKo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:10:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FE4214AF;
        Thu, 20 Jun 2019 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054243;
        bh=x3DQAm9fBik+KczsyNcMttT72qr4M0hPWQmDCAH5ZlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UiTisMHdizKcSos307nWxd6wS2eabA4klcSg+wZbimY+kQvgyuMmylLoBQZDuhXWA
         ajK4aG8LOl0nUQIcaMWwmcxi1xkY3N9TuxEDk2YIB2wyW+BSsnq3EoI99eSJScPkLT
         ArYuTWMHSV/nW2C8CFMgZ3PDQItXcTq+t2Tixjs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavaman Subramaniyam <pavsubra@in.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/61] powerpc/powernv: Return for invalid IMC domain
Date:   Thu, 20 Jun 2019 19:57:18 +0200
Message-Id: <20190620174341.289176449@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit b59bd3527fe3c1939340df558d7f9d568fc9f882 ]

Currently init_imc_pmu() can fail either because we try to register an
IMC unit with an invalid domain (i.e an IMC node not supported by the
kernel) or something went wrong while registering a valid IMC unit. In
both the cases kernel provides a 'Register failed' error message.

For example when trace-imc node is not supported by the kernel, but
skiboot advertises a trace-imc node we print:

  IMC Unknown Device type
  IMC PMU (null) Register failed

To avoid confusion just print the unknown device type message, before
attempting PMU registration, so the second message isn't printed.

Fixes: 8f95faaac56c ("powerpc/powernv: Detect and create IMC device")
Reported-by: Pavaman Subramaniyam <pavsubra@in.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
[mpe: Reword change log a bit]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/opal-imc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/opal-imc.c b/arch/powerpc/platforms/powernv/opal-imc.c
index 3d27f02695e4..828f6656f8f7 100644
--- a/arch/powerpc/platforms/powernv/opal-imc.c
+++ b/arch/powerpc/platforms/powernv/opal-imc.c
@@ -161,6 +161,10 @@ static int imc_pmu_create(struct device_node *parent, int pmu_index, int domain)
 	struct imc_pmu *pmu_ptr;
 	u32 offset;
 
+	/* Return for unknown domain */
+	if (domain < 0)
+		return -EINVAL;
+
 	/* memory for pmu */
 	pmu_ptr = kzalloc(sizeof(*pmu_ptr), GFP_KERNEL);
 	if (!pmu_ptr)
-- 
2.20.1



