Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE721C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18DA20848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578005941;
	bh=lIgnPbZoi6opNBmtNTCpIV0Nr11jwcGg5uA+Bg96oEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=svSMxNAFLsoDEhqGgukWsQXwB/55H/FYXj1Fd8wz0DnrgHAMIQe6PbJkmx9zV9z30
	 4pIZpaa3oSVfLsye+ThUwtJEHDlLTXPsRz0u6JITVpSHxad80Z9kHDqaRyr1U7qgzW
	 ZUq3S2JqI+sgkNXUmBcZH1HP5D2bXoIYxkjZivsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgABW7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbgABWO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:14:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1C11227BF;
        Thu,  2 Jan 2020 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003299;
        bh=lIgnPbZoi6opNBmtNTCpIV0Nr11jwcGg5uA+Bg96oEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpR9S7hMa5lacvlprLCcNElzhFCzXVrq/hGN2QnYLIMc5u28BgcJRt2Xb7RlpmwJQ
         M8KV/V6Q3fTYqXO7zz23RYk0HPORtZiKTLA9JlWVOMlP65ggCaOKJkHQ2aMF+vLQ4P
         b4X4HWHa8+mP9qzeDHORK+E9+kxY8ClolZJluSHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 103/191] Drivers: hv: vmbus: Fix crash handler reset of Hyper-V synic
Date:   Thu,  2 Jan 2020 23:06:25 +0100
Message-Id: <20200102215840.970579601@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 7a1323b5dfe44a9013a2cc56ef2973034a00bf88 ]

The crash handler calls hv_synic_cleanup() to shutdown the
Hyper-V synthetic interrupt controller.  But if the CPU
that calls hv_synic_cleanup() has a VMbus channel interrupt
assigned to it (which is likely the case in smaller VM sizes),
hv_synic_cleanup() returns an error and the synthetic
interrupt controller isn't shutdown.  While the lack of
being shutdown hasn't caused a known problem, it still
should be fixed for highest reliability.

So directly call hv_synic_disable_regs() instead of
hv_synic_cleanup(), which ensures that the synic is always
shutdown.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 53a60c81e220..05ead1735c6e 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2308,7 +2308,7 @@ static void hv_crash_handler(struct pt_regs *regs)
 	vmbus_connection.conn_state = DISCONNECTED;
 	cpu = smp_processor_id();
 	hv_stimer_cleanup(cpu);
-	hv_synic_cleanup(cpu);
+	hv_synic_disable_regs(cpu);
 	hyperv_cleanup();
 };
 
-- 
2.20.1



