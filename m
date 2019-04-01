Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B14520830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140592;
	bh=2jilSU7stb9yXDlx/dTLLhAwaAA/I3anKjq2zGxv/dY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SkEEePSeGJ1Kb1JvR4TSNf8nWo3U3ixgjCMzq3NgWzxHI1fsgvYGpkxCEI3mJBsf4
	 f1UyZBMKMmuOwTcOfC19007vC4HJBy1w6jqZS3ufXdoPSD4yJ4SrWX/+qAonGzySal
	 xRWsMVHCeyVl6zo9qOlo3+pPwrAx5H15sEbHndnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbfDARnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387994AbfDARgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CFD20830;
        Mon,  1 Apr 2019 17:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140166;
        bh=2jilSU7stb9yXDlx/dTLLhAwaAA/I3anKjq2zGxv/dY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sadWESLRmcQbO/pHoPzxdzAOQTwwAO4legYK2R6tBMDImtkXtwfZQgHB67He9pm3u
         acAbGdykk8kqWmgfx2/GtV3DGLHihD9LmdalK6/54Pw9k+hG1scuvhjvBQcqs70vh2
         DXPBiHoyDoSYCLiUDsb+v78D+K7bvV+6l6FS1pdw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 086/131] arm64: kconfig: drop CONFIG_RTC_LIB dependency
Date:   Mon,  1 Apr 2019 19:02:36 +0200
Message-Id: <20190401170059.252200352@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 99a507771fa57238dc7ffe674ae06090333d02c9 ]

The rtc-lib dependency is not required, and seems it was just
copy-pasted from ARM's Kconfig. If platform requires rtc-lib,
they should select it individually.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5b47218809e0..00c491750918 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -89,7 +89,6 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
-	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
-- 
2.19.1



