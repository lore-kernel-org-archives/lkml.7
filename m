Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC22C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F1C217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907597;
	bh=5iipwqbod+07wlNafe9Ayygj1xxqr0ZOYSyh7O/qcLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EOl++Qb7XBlqaXCpG079sLscInyWGotkBzu0LqvgnoXwxrDJ38qTmrnMqVK29cyow
	 PeDf+d3BnY+rWsYJ28NIIvVOBaGF2fft3v0NlKB9sB7N0rkt3HdX3Ys7B3Lt+bcksB
	 Y+pnSC+CxX6dIRYixI8U0fzqBYPDF5uf0ecA28yQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfC3A74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732040AbfC3A5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DA2D206DD;
        Sat, 30 Mar 2019 00:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907421;
        bh=5iipwqbod+07wlNafe9Ayygj1xxqr0ZOYSyh7O/qcLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x9UhlKjAoCsniU1iStrk8GAcdPUgjlf7fFI1xjnaRvXA+ssCgaHBFbyiR9v0TerPO
         I3SQ3jU50OCBLAB1SQhr3YQjMvmox0cvufFDeqxrSR3UxWxI1NndORHxi5hZZzkaUX
         Hlpgx81aRdd9o0ehnu9BxyhrTnBFCah+Z2nXmwYk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 07/21] mmc: davinci: remove extraneous __init annotation
Date:   Fri, 29 Mar 2019 20:56:35 -0400
Message-Id: <20190330005649.28475-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005649.28475-1-sashal@kernel.org>
References: <20190330005649.28475-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9ce58dd7d9da3ca0d7cb8c9568f1c6f4746da65a ]

Building with clang finds a mistaken __init tag:

WARNING: vmlinux.o(.text+0x5e4250): Section mismatch in reference from the function davinci_mmcsd_probe() to the function .init.text:init_mmcsd_host()
The function davinci_mmcsd_probe() references
the function __init init_mmcsd_host().
This is often because davinci_mmcsd_probe lacks a __init
annotation or the annotation of init_mmcsd_host is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/davinci_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index ea2a2ebc6b91..dba7565571a5 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1147,7 +1147,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
 {
 }
 #endif
-static void __init init_mmcsd_host(struct mmc_davinci_host *host)
+static void init_mmcsd_host(struct mmc_davinci_host *host)
 {
 
 	mmc_davinci_reset_ctrl(host, 1);
-- 
2.19.1

