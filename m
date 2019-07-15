Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDC7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B9B20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563198483;
	bh=VRgrytHTVCFlT5csoh3aKEF0uzbhluzYmPoRtKfok/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JQPVgVAn/MyDj9kIwoGtwtvSOQcKL9+gFvnYYvfnP2SoYwzXmVSLmqdNHGbYIS5lZ
	 IlgASXyz9IDsDXvTOOujY5jTjUVKuypYjABO//HuHcvUqyQ+5IP2uYNdPPtVzwvvlw
	 CSeUyv1/8goBn0kloGnxA9lK81iJfYHIlYZVlk34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731341AbfGONsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731215AbfGONsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:48:00 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B0302067C;
        Mon, 15 Jul 2019 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198479;
        bh=VRgrytHTVCFlT5csoh3aKEF0uzbhluzYmPoRtKfok/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rll7xxbJTZjnIm9uFaR8A3LosHlX8FVHv18cUFpdVg65ahv8ba+XmxrnMvDvBeJul
         ObzYbA0m7yRfQU5cZlViB0xG3ZCUb8IhhwvEKZ6jjtrdOh3w8xiHnjiiceLMJhDh+1
         4s+P7eZmUl0GEXFswtRswFhcOa6gqQMqx4UprYsw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 020/249] media: spi: IR LED: add missing of table registration
Date:   Mon, 15 Jul 2019 09:43:05 -0400
Message-Id: <20190715134655.4076-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 24e4cf770371df6ad49ed873f21618d9878f64c8 ]

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias

After this patch:
modinfo drivers/media/rc/ir-spi.ko  | grep alias
alias:          of:N*T*Cir-spi-ledC*
alias:          of:N*T*Cir-spi-led

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/ir-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
index 66334e8d63ba..c58f2d38a458 100644
--- a/drivers/media/rc/ir-spi.c
+++ b/drivers/media/rc/ir-spi.c
@@ -161,6 +161,7 @@ static const struct of_device_id ir_spi_of_match[] = {
 	{ .compatible = "ir-spi-led" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, ir_spi_of_match);
 
 static struct spi_driver ir_spi_driver = {
 	.probe = ir_spi_probe,
-- 
2.20.1

