Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60CC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E63A208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141714;
	bh=rOUJTLLDLcIrzkoJgb4s/aQqCIxC8gU62BXczugNZz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Kf313N8vGSXW1ia7U5/BJQdPfP2atsCPPGOSW1vc0WvKLvbnawDqI13QRevWCfwcx
	 G+zYa9gMXtxc0LzBwFG64Wwkiwbl1maN6Y6d+WiiylRTnzlKDxz5Pzk/AUcQbmGEPx
	 nAEFtqabsjxdNblOEABs54LtzHrI7BglxG7YqTzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfKSFfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:35:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbfKSFfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:35:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB48208C3;
        Tue, 19 Nov 2019 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141706;
        bh=rOUJTLLDLcIrzkoJgb4s/aQqCIxC8gU62BXczugNZz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDN/PTmsq+WJFUURyGrEf1BsmYj5P8tLjiFYBqG+agBO6h7T/XGprzlN7F7nttIkM
         NtdVvrUdw0UlUsIX5i+qBKkW5bWz6hZdUEalh1BDH3uQB0b/lPIIz2bNYgWFiNVIyZ
         w4auzy2+zlyKVKQa5FJtFYH2XdELSpnuzNXdXEwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 253/422] ipmi_si_pci: fix NULL device in ipmi_si error message
Date:   Tue, 19 Nov 2019 06:17:30 +0100
Message-Id: <20191119051415.383023929@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>

[ Upstream commit 01508d9ebf4fc863f2fc4561c390bf4b7c3301a6 ]

I noticed that 4.17.0 logs the follwing during ipmi_si setup:

 ipmi_si 0000:01:04.6: probing via PCI
 (NULL device *): Could not setup I/O space
 ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21

Fix the "NULL device *) by moving io.dev assignment before its potential
use by ipmi_pci_probe_regspacing().

Result:
 ipmi_si 0000:01:04.6: probing via PCI
 ipmi_si 0000:01:04.6: Could not setup I/O space
 ipmi_si 0000:01:04.6: [mem 0xf5ef0000-0xf5ef00ff] regsize 1 spacing 1 irq 21

Signed-off-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/ipmi/ipmi_si_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_pci.c b/drivers/char/ipmi/ipmi_si_pci.c
index f54ca6869ed2c..022e03634ce2a 100644
--- a/drivers/char/ipmi/ipmi_si_pci.c
+++ b/drivers/char/ipmi/ipmi_si_pci.c
@@ -120,6 +120,8 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	}
 	io.addr_data = pci_resource_start(pdev, 0);
 
+	io.dev = &pdev->dev;
+
 	io.regspacing = ipmi_pci_probe_regspacing(&io);
 	io.regsize = DEFAULT_REGSIZE;
 	io.regshift = 0;
@@ -128,8 +130,6 @@ static int ipmi_pci_probe(struct pci_dev *pdev,
 	if (io.irq)
 		io.irq_setup = ipmi_std_irq_setup;
 
-	io.dev = &pdev->dev;
-
 	dev_info(&pdev->dev, "%pR regsize %d spacing %d irq %d\n",
 		&pdev->resource[0], io.regsize, io.regspacing, io.irq);
 
-- 
2.20.1



