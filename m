Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC101C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F47321928
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569344454;
	bh=EwefwZg1gkRd5D8AdLXuQmAzwpk0VAcJjXwCvpznLlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KQKJ8tDHzhWI3nG3GyhTkvTP1/jYaXF/mcORvl12P0a0Z+fUaqu0eW4AnJBpfdvTP
	 olqaKsehnDhBik0cJAC6EQid+lwXXZCEc0MUdOfibvboc7qqgUEaZlohGYXPMH11mA
	 cXWM9+i7CykcaQjEgN7Taxtyl6eQDbI0RRR/TiIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfIXRAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:00:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409894AbfIXQos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 12:44:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18E5222C1;
        Tue, 24 Sep 2019 16:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569343487;
        bh=EwefwZg1gkRd5D8AdLXuQmAzwpk0VAcJjXwCvpznLlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZD+ydD/7E2nc+0SXG7CgdsMDOfF2TjypMfqOhFMtjETqNIBo3coO6n8ezXtTrFHU
         uTEijIiW5VgIYA7mtygsJ+F4Ilev0rbAJB4rG93GSsgc7D7+Hom9hwSqA9CK/qamry
         9UWLbD0DpWswBOa2hlykB6aejC/VbaC/6kX7UrcM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.3 66/87] powerpc/64s/exception: machine check use correct cfar for late handler
Date:   Tue, 24 Sep 2019 12:41:22 -0400
Message-Id: <20190924164144.25591-66-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 0b66370c61fcf5fcc1d6901013e110284da6e2bb ]

Bare metal machine checks run an "early" handler in real mode before
running the main handler which reports the event.

The main handler runs exactly as a normal interrupt handler, after the
"windup" which sets registers back as they were at interrupt entry.
CFAR does not get restored by the windup code, so that will be wrong
when the handler is run.

Restore the CFAR to the saved value before running the late handler.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20190802105709.27696-8-npiggin@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/exceptions-64s.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 6ba3cc2ef8abc..36c8a3652cf3a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1211,6 +1211,10 @@ FTR_SECTION_ELSE
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
 9:
 	/* Deliver the machine check to host kernel in V mode. */
+BEGIN_FTR_SECTION
+	ld	r10,ORIG_GPR3(r1)
+	mtspr	SPRN_CFAR,r10
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	MACHINE_CHECK_HANDLER_WINDUP
 	EXCEPTION_PROLOG_0 PACA_EXMC
 	b	machine_check_pSeries_0
-- 
2.20.1

