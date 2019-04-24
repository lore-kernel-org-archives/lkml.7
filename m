Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE4C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173F0205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126423;
	bh=R8RqQ7qo3KjMPF+2Txgn0fbFlpInTNu1v11IlaHVguA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hEgVnq/8osCuq6Gt6VWd5seSJIzlm2GzvE0i0GTvQzQV4E7Asc2QZ9Cw3jwhxgfuc
	 TGfKQIN5zoo8posOW3Gk40VPAXnOtgu+lkoRcaMlHKRYKINNgyX+0sdRU/6gj//8kE
	 Sh/yrxtDZx88dnI1GIMepkn4IhO0rMnl09X89Jrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfDXRUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:20:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbfDXRUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:20:19 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C33421905;
        Wed, 24 Apr 2019 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126418;
        bh=R8RqQ7qo3KjMPF+2Txgn0fbFlpInTNu1v11IlaHVguA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwCNGKTh9hZ78GLtB4483TuCRfZhpzlZY0EnXGfdwKri3nyuTcCXGNVsoSGbNca1r
         ZJ6NyCaHwcZyVKkRkznW8FiPn9NeJHa734/VKDVYVDsW9MNDZY9g9DR1c3kF7WBMER
         9XZf5yzB1MdVPdc4ItsGyz1NYU3SyYDAip6w2rzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 104/168] mmc: davinci: remove extraneous __init annotation
Date:   Wed, 24 Apr 2019 19:09:08 +0200
Message-Id: <20190424170929.763061204@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170923.452349382@linuxfoundation.org>
References: <20190424170923.452349382@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



