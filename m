Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72E2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B8D20700
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384962;
	bh=z9UtvtB1+9egErQtQisaNM4KXdtr1rv4rpMpXyL4+Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2Ze5VL6+4DIrUI5ch/+PiXKnCycYWJCies4o4yIyUzp3nAX4tCY7FOdB6LWMLFlQR
	 bur5Yo2YIORSpRYPEVplZ7Zp/ZwSCU6IrGdD/wKnXaNCY1WAjHEhdxQtJhOHbmGY3U
	 uMjN/8cGzn6kgsx/cwUngw8gvarUt21jZiROCecg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfJFSCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 14:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728096AbfJFRZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:25:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1ACDA2077B;
        Sun,  6 Oct 2019 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382743;
        bh=z9UtvtB1+9egErQtQisaNM4KXdtr1rv4rpMpXyL4+Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xbU42G/IcSzBVv/2TasmUUZSC/AuwERGqrkLgxSsFcSdCfHc9RqpfFSxWRrvw03gp
         hIEcHRJ6u/ImWdQRTOLzEoYX+SBuuT53ZmvFmXmroPvrjItd6RMPr8OAtbRl8f3/Iw
         J0hbcLrUPlU+lEiLuNkLkG51FBrQ+4bZ7lfavHrY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 23/68] powerpc/64s/exception: machine check use correct cfar for late handler
Date:   Sun,  6 Oct 2019 19:20:59 +0200
Message-Id: <20191006171118.849635053@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 43cde6c602795..cdc53fd905977 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -464,6 +464,10 @@ EXC_COMMON_BEGIN(machine_check_handle_early)
 	RFI_TO_USER_OR_KERNEL
 9:
 	/* Deliver the machine check to host kernel in V mode. */
+BEGIN_FTR_SECTION
+	ld	r10,ORIG_GPR3(r1)
+	mtspr	SPRN_CFAR,r10
+END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	MACHINE_CHECK_HANDLER_WINDUP
 	b	machine_check_pSeries
 
-- 
2.20.1



