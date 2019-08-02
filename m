Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4BFC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C80217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564752150;
	bh=8sBmr0xPW4QbjaqapDbv1f25B6bl8u9/kMKY5KOunzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I7oPo31Py5ye1nFXd2RVoGUVxFs6Zvj9tGF31bl+/e7xvkiJ3ym0uMSf5x2DRI5Qz
	 P38d74cf5Ph7B+o6fbNDld1+OjRIhDPJIvRIs2U838l/rLNcVNqQmIyRLCoMVunKKm
	 l0Kjq1GccSVOE6yKZY0sELRZ5hcgcFpu18reF+x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393777AbfHBNW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:22:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:32810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393760AbfHBNWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:22:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D9921855;
        Fri,  2 Aug 2019 13:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564752145;
        bh=8sBmr0xPW4QbjaqapDbv1f25B6bl8u9/kMKY5KOunzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQXuAoqnG8iXNb3lr0eHP9LSNNTogHiDE3AR9qEdpgm/4jRnG3Y8X4lh5BFIGAa+k
         bbuQ157LLTfgbXdfxM3RixOStfsv9PH5aZglle+ruajptRzlfo1tps5BPcTZqI5T1D
         xtE5aJTP2kIRL6Duq3QPd2sPxxEJiImfQwoFNzPE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 62/76] ARM: davinci: fix sleep.S build error on ARMv4
Date:   Fri,  2 Aug 2019 09:19:36 -0400
Message-Id: <20190802131951.11600-62-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190802131951.11600-1-sashal@kernel.org>
References: <20190802131951.11600-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit d64b212ea960db4276a1d8372bd98cb861dfcbb0 ]

When building a multiplatform kernel that includes armv4 support,
the default target CPU does not support the blx instruction,
which leads to a build failure:

arch/arm/mach-davinci/sleep.S: Assembler messages:
arch/arm/mach-davinci/sleep.S:56: Error: selected processor does not support `blx ip' in ARM mode

Add a .arch statement in the sources to make this file build.

Link: https://lore.kernel.org/r/20190722145211.1154785-1-arnd@arndb.de
Acked-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-davinci/sleep.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
index 05d03f09ff54b..71262dcdbca32 100644
--- a/arch/arm/mach-davinci/sleep.S
+++ b/arch/arm/mach-davinci/sleep.S
@@ -24,6 +24,7 @@
 #define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
 
 	.text
+	.arch	armv5te
 /*
  * Move DaVinci into deep sleep state
  *
-- 
2.20.1

