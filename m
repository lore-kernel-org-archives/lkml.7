Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03320700
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713272;
	bh=Ot/XjfivtGOM0jecL3sMhOMnHdz7KJmm1rO3A+LkZcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F3CQ49veGX59lyRLgob9UHS/W4+btaF7ilWWtS3zMaWZUaX1b9+HVMKg+SmHCRBC6
	 X8qdFlEze3C8D/KErED5cBP4BBoPhwEAE6jqonfYMGkHvcdsvrHGGJJltA5mxQL8DG
	 H+WAvr1I4qd+42yBJD6EMkeOZDJcweg6KJB13h/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbfC0TBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:01:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389619AbfC0SOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:14:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D92C2082F;
        Wed, 27 Mar 2019 18:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710463;
        bh=Ot/XjfivtGOM0jecL3sMhOMnHdz7KJmm1rO3A+LkZcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07QnFTqtWtei3s2R8O6zVcGJeUZJxRTVhdnAYTA7K6g/mcJ4YcnjxkRdS4Xnaq31h
         WAsaYoRdmTalF75fNtex2SQyw57H8cSgrmomGgGpjL7iSbfIFNXkus3NfbOFf8MUuv
         qP/WolgXjZechkCPYcSMnXSxu0HVvdBBnm5Zxvao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Roese <sr@denx.de>, Mark Brown <broonie@kernel.org>,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 131/192] staging: spi: mt7621: Add return code check on device_reset()
Date:   Wed, 27 Mar 2019 14:09:23 -0400
Message-Id: <20190327181025.13507-131-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Roese <sr@denx.de>

[ Upstream commit 46c337872f34bc6387b0c29a4964f562c70139e3 ]

This patch adds a return code check on device_reset() and removes the
compile warning.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Sankalp Negi <sankalpnegi2310@gmail.com>
Cc: Chuanhong Guo <gch981213@gmail.com>
Cc: John Crispin <john@phrozen.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index d045b5568e0f..578aa6824ad3 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -429,6 +429,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	int status = 0;
 	struct clk *clk;
 	struct mt7621_spi_ops *ops;
+	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
@@ -476,7 +477,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "SPI reset failed!\n");
+		return ret;
+	}
 
 	mt7621_spi_reset(rs, 0);
 
-- 
2.19.1

