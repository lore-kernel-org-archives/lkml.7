Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65F8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA9820673
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240192;
	bh=FmP9XTOThCf9edZjXuK00ofv3vQ4dyHYewdZPqO1gm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YlqLJOHCXRpSMAOYpd/z6931qlUd0pvAWc70+H2LznX4QCquUjacYyx8PfqZg2a0L
	 r8W/kBm+L0zh7Ll3kIjdTOidVpF6uMchnmO0BZGFg7qh/JQ1tAu8n3k4bnPnhEz7z4
	 XRH1Dggieami1VMCbVUA25+ksheno8k2BNxGlR0w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbfKHTJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:09:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391795AbfKHTJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:09:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D51D820673;
        Fri,  8 Nov 2019 19:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573240186;
        bh=FmP9XTOThCf9edZjXuK00ofv3vQ4dyHYewdZPqO1gm4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eH+HPnDXO8Yo3C6ErCuw8/dbpyq7lVWIyWTAZJc2JCl+jlh9/F3fDlnLp9gpBW1HF
         vvCH2In5gPGamnBW5mXjZNNhg7e+lz1MPvsrFSLwAp1P7YSmKKOTxR/THpyY5b87A7
         kWPy+fvswhjusRMdmf7Gtgf0UW43vu+cBfw1BrKQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Mikhak <alan.mikhak@sifive.com>,
        Marc Zyngier <maz@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH 5.3 076/140] irqchip/sifive-plic: Skip contexts except supervisor in plic_init()
Date:   Fri,  8 Nov 2019 19:50:04 +0100
Message-Id: <20191108174909.904490504@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

[ Upstream commit 41860cc447045c811ce6d5a92f93a065a691fe8e ]

Modify plic_init() to skip .dts interrupt contexts other
than supervisor external interrupt.

The .dts entry for plic may specify multiple interrupt contexts.
For example, it may assign two entries IRQ_M_EXT and IRQ_S_EXT,
in that order, to the same interrupt controller. This patch
modifies plic_init() to skip the IRQ_M_EXT context since
IRQ_S_EXT is currently the only supported context.

If IRQ_M_EXT is not skipped, plic_init() will report "handler
already present for context" when it comes across the IRQ_S_EXT
context in the next iteration of its loop.

Without this patch, .dts would have to be edited to replace the
value of IRQ_M_EXT with -1 for it to be skipped.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Paul Walmsley <paul.walmsley@sifive.com> # arch/riscv
Link: https://lkml.kernel.org/r/1571933503-21504-1-git-send-email-alan.mikhak@sifive.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-sifive-plic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index daefc52b0ec55..7d0a12fe2714a 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -252,8 +252,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		/* skip context holes */
-		if (parent.args[0] == -1)
+		/* skip contexts other than supervisor external interrupt */
+		if (parent.args[0] != IRQ_S_EXT)
 			continue;
 
 		hartid = plic_find_hart_id(parent.np);
-- 
2.20.1



