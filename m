Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8549EC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5193020665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890197;
	bh=sJJLiwpOvgcSG95me1xpezoQaHq1vBEc0vPQTntpyhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C1mdXsujv652y/syOdXjaE0zJ1mGHKDxxf68kkuAnixA91gqS7UDVSCMkOwrq+i1P
	 8/k56JyMftldhFe8fBa0txbFFqyriBPEO02jLTx391IBg5Gil9ZB/02TQjMB4B2bwA
	 4lm6Ul524s6UJfcG+ENEME5MPKwTBHr9UXO/r8Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfK0U43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfK0U40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:56:26 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 149102084D;
        Wed, 27 Nov 2019 20:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888185;
        bh=sJJLiwpOvgcSG95me1xpezoQaHq1vBEc0vPQTntpyhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHTudNyMPGeKm/lvJ6ktBklyc7N7JMBefFta3cBH/AnkBR77ZuYaNqTAw2OnWDZks
         ZChbePjSbXOwMzvNRqgcPIXN3SrSQSJy5thVDQaTW47diSesfxo6g+GudHqKgWlosY
         GkoZbuWZpW58BuhigZ4OHYoBHhpS0nD2KZd4cvn4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Borislav Petkov <bp@suse.de>,
        David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 036/306] EDAC, thunderx: Fix memory leak in thunderx_l2c_threaded_isr()
Date:   Wed, 27 Nov 2019 21:28:06 +0100
Message-Id: <20191127203117.470390146@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit d8c27ba86a2fd806d3957e5a9b30e66dfca2a61d ]

Fix memory leak in L2c threaded interrupt handler.

 [ bp: Rewrite commit message. ]

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
CC: David Daney <david.daney@cavium.com>
CC: Jan Glauber <jglauber@cavium.com>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>
CC: Sergey Temerkhanov <s.temerkhanov@gmail.com>
CC: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20181013102843.GG16086@mwanda
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/thunderx_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index c009d94f40c52..34be60fe68922 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1884,7 +1884,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 	default:
 		dev_err(&l2c->pdev->dev, "Unsupported device: %04x\n",
 			l2c->pdev->device);
-		return IRQ_NONE;
+		goto err_free;
 	}
 
 	while (CIRC_CNT(l2c->ring_head, l2c->ring_tail,
@@ -1906,7 +1906,7 @@ static irqreturn_t thunderx_l2c_threaded_isr(int irq, void *irq_id)
 		l2c->ring_tail++;
 	}
 
-	return IRQ_HANDLED;
+	ret = IRQ_HANDLED;
 
 err_free:
 	kfree(other);
-- 
2.20.1



