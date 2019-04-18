Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8BCC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B632186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610888;
	bh=LlN5nPZoZfaL1r1dT5KZ6/0K4j5zyqTNforSTSpw3Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a1wopwk/nmMLqgNITK74N0rx8hLsw2/unZrxc/yMd54fx9vuyWZv0p/2FjdSyIsbl
	 mjwh4IiM+dPT+N9TIBCZqLPx2fs//n5pLl0NFVOjvWqkk5uLziOwJMbky0B3XEaAey
	 stBE6Awbx5XPY/QG/b5AsxTla3YFUrkYtY4lC0mg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391731AbfDRSIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391720AbfDRSIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:08:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F79218AF;
        Thu, 18 Apr 2019 18:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610883;
        bh=LlN5nPZoZfaL1r1dT5KZ6/0K4j5zyqTNforSTSpw3Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yw9dUm5IhwW89lwr4AA8lDbnwmEpk05dddOlQQPKJUCMXMXSmLdOZXzj/BKfaYldy
         dAQAVvixTARW+NzlB9g9iQHgy4GRycni0RQpLpnMaxgrH/NQ0cwAy+K+5HGev3ol2d
         3MoLllRBcX9czz2304JXN+StzYj4eOTEjX0wVXx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/50] mmc: davinci: remove extraneous __init annotation
Date:   Thu, 18 Apr 2019 19:57:19 +0200
Message-Id: <20190418160423.867010848@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
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
index 8fa478c3b0db..619457b90dc7 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1120,7 +1120,7 @@ static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
 {
 }
 #endif
-static void __init init_mmcsd_host(struct mmc_davinci_host *host)
+static void init_mmcsd_host(struct mmc_davinci_host *host)
 {
 
 	mmc_davinci_reset_ctrl(host, 1);
-- 
2.19.1



