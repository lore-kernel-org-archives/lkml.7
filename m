Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E025C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0083820896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140274;
	bh=7TLBiLQZ5BISsmC3WsZ8C9hSG09iUUHDB9UYA96uWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Slgtd8UdlYryIbh7ufqr1++bR/zCHSOIM0/6RXclDx+2jyz/3d1Fb4k8EnRWd18z5
	 o5VLDv79XWhINBEoMGnDURSKj4Idt0POO6g1ZeSU7OiucePtei9cugqPVDhFjw5QbB
	 nPOTonWq8qy6EBOg5kVhUwMIVM5vwQ3SnVJry6pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbfDARhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbfDARhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C61662070B;
        Mon,  1 Apr 2019 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140270;
        bh=7TLBiLQZ5BISsmC3WsZ8C9hSG09iUUHDB9UYA96uWtE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRXKP1mML8Agun/K56N7TMWG2nTAjkkngmle9Qeg/zuZHHFtZbACljcCOufAbCIw6
         6C8V1s2R9XMcKpODEpL6kupf4LQmswH8M0VPJ6CYA68W/WhjFrPl/kSEz+qksByQa8
         i/8f2ZWZnbntZA2GzXGr2B1Xh8GQG8iRa6h6I4O8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 25/50] arm64: kconfig: drop CONFIG_RTC_LIB dependency
Date:   Mon,  1 Apr 2019 19:03:08 +0200
Message-Id: <20190401170044.127241556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
index 00b9c4870230..e8d81283c4fe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -69,7 +69,6 @@ config ARM64
 	select PERF_USE_VMALLOC
 	select POWER_RESET
 	select POWER_SUPPLY
-	select RTC_LIB
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select HAVE_CONTEXT_TRACKING
-- 
2.19.1



