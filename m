Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB0EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED0322ADA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997446;
	bh=E06qOU/TbsjBXHsCMeVvt2IuRjYwXwW1DtBuGYA5hP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kXTRHXR50RsnNeiSiqNbh4Vm/ydHXrUd4x2oi8BFqJNzgVJvC+LBy4hJbwd9JPpHI
	 8Bhgn79D2cY9de1bRBvY1HRNj5mRAq2XhZEegTFRNCpixgE/3Vok5ZVPWdKeG8FLrY
	 27uVj/h1Tjgc9glYyt79DF/k52SivVI1eXcBMi9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390749AbfGXToF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfGXToB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:44:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A4C6214AF;
        Wed, 24 Jul 2019 19:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997440;
        bh=E06qOU/TbsjBXHsCMeVvt2IuRjYwXwW1DtBuGYA5hP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUU2eoP+DAjE4wkFAFmNqxSWekYAwzcj1Omy3XY8PukAg7U44wYq9b9GMk6QwGcgF
         /5XWOwcoB+k+uoo8EE1Av6R0pxNf+xFT1zo9oWwpWoSgfTZUTBP34x/hfcHqifC3nW
         00XVDi1ZMtN+ELN9ZsZPW/isUeSMu5MuzHRZBi90=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Daniel Gomez <dagmcr@gmail.com>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 024/371] media: spi: IR LED: add missing of table registration
Date:   Wed, 24 Jul 2019 21:16:16 +0200
Message-Id: <20190724191726.316958080@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



