Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B50C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B9C217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369326;
	bh=bJeSUAmAfqUFVULoecThs62W5RENmoqSzHCULfskGqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OiNIOXIg6o/PswkXkMIfj5u9vJabWEPFlpJRMcWZ5SIs/2O2gHortnD3OeQFzqWvi
	 uFkAiM25iEaoY08FrcwhzQKY8Kb0uDOGx9tT1Dm7LFucO4O2Vqe1HUd8f2H1cvrc1I
	 1TMACpXQ+G4CGYRjizp3m/vHO6S8BuMh3L+XBH+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbfDDJPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387467AbfDDJPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:15:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1016F2075E;
        Thu,  4 Apr 2019 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369321;
        bh=bJeSUAmAfqUFVULoecThs62W5RENmoqSzHCULfskGqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qbhfu2kCEOl5Lw0gOB2AvDU2ZCwSyBBk8ZhfFjUL4W9DGeYOuOURp6tcsJWqRa+wP
         Win0qGWcSCIgp47oxIyrfqbxXW7AMVeYjTN0xmmbaRLfRcIjf0isdpnjaSumvVemNO
         mlsoKWRFm3e/lsQcRmmyJY2H17mO4bm5NcaT3KG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Mark Brown <broonie@kernel.org>,
        Sankalp Negi <sankalpnegi2310@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        John Crispin <john@phrozen.org>, NeilBrown <neil@brown.name>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 171/246] staging: spi: mt7621: Add return code check on device_reset()
Date:   Thu,  4 Apr 2019 10:47:51 +0200
Message-Id: <20190404084625.163463927@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 513b6e79b985..e1f50efd0922 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -330,6 +330,7 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	int status = 0;
 	struct clk *clk;
 	struct mt7621_spi_ops *ops;
+	int ret;
 
 	match = of_match_device(mt7621_spi_match, &pdev->dev);
 	if (!match)
@@ -377,7 +378,11 @@ static int mt7621_spi_probe(struct platform_device *pdev)
 	rs->pending_write = 0;
 	dev_info(&pdev->dev, "sys_freq: %u\n", rs->sys_freq);
 
-	device_reset(&pdev->dev);
+	ret = device_reset(&pdev->dev);
+	if (ret) {
+		dev_err(&pdev->dev, "SPI reset failed!\n");
+		return ret;
+	}
 
 	mt7621_spi_reset(rs);
 
-- 
2.19.1



