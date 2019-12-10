Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89195C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8C920836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576017152;
	bh=xfqzfHzmDVF2NCNq9omTFPeXuBDsh3yuMnBSW7K8NEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2rZNCTkOch+1/QOo6cpjcec9u+TuY78go5c43bFzURM82dUwD/UO6lO3nzH2SrZn
	 jjj2SoPCK0BqIQDQ+O/g1NEbJHo4V5HI/C4K7CQc1GBQ/kX7OeibZPYm1cmrzFV3bA
	 9/l9WyryGBJ8DTR6ZJh6wUZFn+qYm1HMv4O8HyCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbfLJWca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:32:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbfLJWcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:32:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0B7621D7D;
        Tue, 10 Dec 2019 22:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576017132;
        bh=xfqzfHzmDVF2NCNq9omTFPeXuBDsh3yuMnBSW7K8NEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkxErzxwYMQEbJThb6ANIUn1I0kAS9k3ms0IeqRkYjj4U/f51bXtuydqguJgaQbqG
         zqGNp0Llq5wuCBQOo4LrdlFi1RK4CiNtZ6WD7OYbIq107h6n/ZhwCBqM5TU2NWysLS
         SowpNJj3VmovWsGGGtFOPeFpNLLy25mPqS8lGkc0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 81/91] spi: st-ssc4: add missed pm_runtime_disable
Date:   Tue, 10 Dec 2019 17:30:25 -0500
Message-Id: <20191210223035.14270-81-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210223035.14270-1-sashal@kernel.org>
References: <20191210223035.14270-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit cd050abeba2a95fe5374eec28ad2244617bcbab6 ]

The driver forgets to call pm_runtime_disable in probe failure
and remove.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Link: https://lore.kernel.org/r/20191118024848.21645-1-hslester96@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-st-ssc4.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index e54b596384582..710adbc2485f5 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -385,6 +385,7 @@ static int spi_st_probe(struct platform_device *pdev)
 	return 0;
 
 clk_disable:
+	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(spi_st->clk);
 put_master:
 	spi_master_put(master);
@@ -396,6 +397,8 @@ static int spi_st_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_master_get_devdata(master);
 
+	pm_runtime_disable(&pdev->dev);
+
 	clk_disable_unprepare(spi_st->clk);
 
 	pinctrl_pm_select_sleep_state(&pdev->dev);
-- 
2.20.1

