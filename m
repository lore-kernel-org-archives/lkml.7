Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F1AC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085052186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610622;
	bh=xl4Q5FxowmnvoZUlCV3IJYoeImmT/nry9Uz/9lCDToE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MFOlBiJxb2LjC/LLp8omx93Kgf5XcSDBox0Ca3Bvscv/u1sVmeZfLwH8wBbuPunmR
	 S4T7UciwLy9MMh07Lp5w+oP7BBRwmC+n1uJpGJL0bMIGLpjvCGn91EUdp7pda+d5Wo
	 3owfvw3dvpxybq7HWpfnUlN0GnilS8M6RKGfdjHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbfDRSDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbfDRSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43853206B6;
        Thu, 18 Apr 2019 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610618;
        bh=xl4Q5FxowmnvoZUlCV3IJYoeImmT/nry9Uz/9lCDToE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ce1XaDKvwIoZvexdGzVMTTQEKW4Ra3YOeFGYHYS0b/RlnfvA1DOpvRQeeSFjYpZs2
         3Hm5Gv1OLM9lQyq2s8cPk0wcA8vtqNJfASnf7hd57qRiu+i9tPbI6BvXF3xFFGXLbB
         LfQFmtnhfkjPBRDrjEJSAlN/e+Zy+hXcpbFemgNk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/92] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Thu, 18 Apr 2019 19:56:20 +0200
Message-Id: <20190418160430.572092185@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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
index 083560e9e571..4dac1169f528 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -9,6 +9,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.1



