Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F1C28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF4F276F2
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559396618;
	bh=Hshb00E3YY/ALIe4BTZ8oT6UxHJVL0f6jBjud6JkyMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHUePUoTPLej0l5YpUm0zT0igfqSBRQiTZ9YYKjDZuumMO0O4JmEc6h01/JXK8JHs
	 ZknDaPqvI44oUtbTDH3JTT456xVbaD++hGQZE58lL6ElfgIQ6HB5tInnUcEiZ0/AfR
	 +jfW99x7ic0ZPioKL/1YulgogRhSbdI0feJ7qCJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbfFANnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 09:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbfFANSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 09:18:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0462727C;
        Sat,  1 Jun 2019 13:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559395086;
        bh=Hshb00E3YY/ALIe4BTZ8oT6UxHJVL0f6jBjud6JkyMY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s3Ak+8W+exmGAicZADTOp4bd0AnPZLhKeBYj+OahyjOy0AXP/22dKJMmt4AR1HjwF
         J8C8m9keN1zXg71SQWzdiPeKjRokRRd8SZQcLDlzEwFzDKbusmcR6l3B05238nTAFL
         SvCUyTK8GV08pMpeMy3lk6WnW3j0oQ7yy2LayR9g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Gomez <dagmcr@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.1 026/186] mfd: tps65912-spi: Add missing of table registration
Date:   Sat,  1 Jun 2019 09:14:02 -0400
Message-Id: <20190601131653.24205-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190601131653.24205-1-sashal@kernel.org>
References: <20190601131653.24205-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Gomez <dagmcr@gmail.com>

[ Upstream commit 9e364e87ad7f2c636276c773d718cda29d62b741 ]

MODULE_DEVICE_TABLE(of, <of_match_table> should be called to complete DT
OF mathing mechanism and register it.

Before this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          spi:tps65912

After this patch:
modinfo drivers/mfd/tps65912-spi.ko | grep alias
alias:          of:N*T*Cti,tps65912C*
alias:          of:N*T*Cti,tps65912
alias:          spi:tps65912

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tps65912-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/tps65912-spi.c b/drivers/mfd/tps65912-spi.c
index 3bd75061f7776..f78be039e4637 100644
--- a/drivers/mfd/tps65912-spi.c
+++ b/drivers/mfd/tps65912-spi.c
@@ -27,6 +27,7 @@ static const struct of_device_id tps65912_spi_of_match_table[] = {
 	{ .compatible = "ti,tps65912", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, tps65912_spi_of_match_table);
 
 static int tps65912_spi_probe(struct spi_device *spi)
 {
-- 
2.20.1

