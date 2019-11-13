Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A369C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E132053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611659;
	bh=CRRHNqPWZVBDH3wUrp+1VH0/eHLL/17msIBzpwJ4APY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MuZAnJp4bHu9D/nARBhjfamA6V/V5V5ABvs7oMcJN4yXk7mUNOsDyB91UaOq/k9p8
	 KK07v6YGz5nt39w6uG3dibG/UfEH5g0RHJ1vNIq55rf8xMQWNiTXvjjVAvrgb4IWhh
	 pumA9GdW/G26Jp8b1HKhXovXJT3LXl8XM0Xl2NRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfKMCU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:20:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfKMByM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:54:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1885D222CF;
        Wed, 13 Nov 2019 01:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610051;
        bh=CRRHNqPWZVBDH3wUrp+1VH0/eHLL/17msIBzpwJ4APY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xESTH2HK6FUFXrAm/KxG/rhIJUmnOBqj4c0ch4mSRG2m2A274JDIit25yDlr7uHdd
         l0NdlqZDMcLFa+wTZBSUG36XvjEvFnYQNTwvmwry/wbvGcx3o4cX5vXaErNEh4jl4U
         VOlzp6GUKc2gBHNj4LbUAa/1DFD16Vd+km1bp2tw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 138/209] mmc: tmio: Fix SCC error detection
Date:   Tue, 12 Nov 2019 20:49:14 -0500
Message-Id: <20191113015025.9685-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

[ Upstream commit b85fb0a1c8aeaaa40d08945d51a6656b512173f0 ]

SDR104, HS200 and HS400 need to check for SCC error. If SCC error is
detected, retuning is necessary.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[Niklas: update commit message]
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/tmio_mmc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 7d13ca9ea5347..94c43c3d3ae58 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -926,8 +926,8 @@ static void tmio_mmc_finish_request(struct tmio_mmc_host *host)
 	if (mrq->cmd->error || (mrq->data && mrq->data->error))
 		tmio_mmc_abort_dma(host);
 
-	if (host->check_scc_error)
-		host->check_scc_error(host);
+	if (host->check_scc_error && host->check_scc_error(host))
+		mrq->cmd->error = -EILSEQ;
 
 	/* If SET_BLOCK_COUNT, continue with main command */
 	if (host->mrq && !mrq->cmd->error) {
-- 
2.20.1

