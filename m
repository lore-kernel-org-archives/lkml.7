Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC9CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28BFA217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610327;
	bh=HlccvsZjJjU0jCWfvlL9CxuJBJugFUiZA1k3sQFrpKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lTsZAupGUFsIdnbzqtGRPRyb45ovxj2Hx37NoeySpBF99AdytcYHaz908zFHAk0mP
	 xgWWA4BgZl8uw6OhecXY0Ig0VFnR1GFd/pdZk7C+uDJYJIaV/26U2J19bnwq3llVDU
	 DAT8lM+67NeUhEBc23qrsX+MtwpB14TsG2MzUDSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbfDRR6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389928AbfDRR6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53D72206B6;
        Thu, 18 Apr 2019 17:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610323;
        bh=HlccvsZjJjU0jCWfvlL9CxuJBJugFUiZA1k3sQFrpKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KXsS6ktrYuhcjaII0kwDFApK571rwg0mabx7oe6Sz9BRkIDihb7SflIEa7L96Xy9y
         BhZe9ZoBIVpGToJdxq/96dUWuqvBh0kn+hMvQegiveS2477Al7KPM7GSFvPQkVklgU
         o59sYk/iaGZpXzVU5m2amLEBiXRVzoxv1L/1Fyz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 002/110] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Thu, 18 Apr 2019 19:55:51 +0200
Message-Id: <20190418160437.750057024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 0728aeb7ead99a9b0dac2f3c92b3752b4e02ff97 ]

We have now a HSDK device in our kernelci lab, but kernel builded via
the hsdk_defconfig lacks ramfs supports, so it cannot boot kernelci jobs
yet.

So this patch enable CONFIG_BLK_DEV_RAM in hsdk_defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 2a1d2cbfee1a..651fa7978e51 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -8,6 +8,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.1



