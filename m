Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15473C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D82DC207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420569;
	bh=CRRHNqPWZVBDH3wUrp+1VH0/eHLL/17msIBzpwJ4APY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qq3KLScc9bsGWk+aU3P8wSy+gkZt37Tdo/KhoSik1MOk0OfbjVxZqlPBgNUh78eY5
	 KTqtcedyvz2H34x4gmLbnljMPYHj/UK1j3/5i/QoH2aM/Bj+lRHLZXznVn2n6C1tNP
	 isjSGypFUh4bxgTMipAgqyj76KprnPVm1YSXSrTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbfKVLCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:02:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:56452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbfKVLCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:02:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10EF92075E;
        Fri, 22 Nov 2019 11:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420563;
        bh=CRRHNqPWZVBDH3wUrp+1VH0/eHLL/17msIBzpwJ4APY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9syo7BJpeHeBtB0cQ4W7WId3WzBj0UajPdJwtlWVeWTHMzFIH9y/bMifDs3d/bSA
         x1vPz8dQBbq9QIN/0rMZln19MoEuzVfh/bk1ia8Lewg3aQZ3ZQ+MW5gv/Xe1PJEPm9
         9I+J1aDNDFIz9xVmdEB9BbwO4RDqNd/CJVVIhcdg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 149/220] mmc: tmio: Fix SCC error detection
Date:   Fri, 22 Nov 2019 11:28:34 +0100
Message-Id: <20191122100923.460544655@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



