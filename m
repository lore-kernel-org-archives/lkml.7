Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2481220659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402483;
	bh=GQas2avcl0NjPgNPlaAfiSvtV+EZURLJOYzb58XTsXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BnPcj3polfwEkCVU3XtuWdlaLQt3kuONzWt5zqH1/li1sNtRqlVKj1+xtGZvVC9L8
	 Av0+R04T4w7vk8RuPKrrP2HMJYroHLfl0PJO9QaIjMzDfmni7hgRGeYLi37KUmbsI7
	 V64+9oAXXfWTA3T8L5iT2xT7g0wYCwohhKRtYHJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbfKVGBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfKVF5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:57:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9AF92084B;
        Fri, 22 Nov 2019 05:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402239;
        bh=GQas2avcl0NjPgNPlaAfiSvtV+EZURLJOYzb58XTsXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hgLAOvSDmTOjGhN+FdzDQ4udPT8ypYSPgx4rOE0mmBoV9q6y30Kcya9qV3NWoygxZ
         J1srnaXX/+n0d2gfQZ3n71D+hwPrw1dYG14gdZwF5udFSwPVRvazdM98nMRb9is9dM
         eM7UZt+TvvM9WBOfE7T7cbTw7oeXhlXMeCIpjFPI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 084/127] um: Make GCOV depend on !KCOV
Date:   Fri, 22 Nov 2019 00:55:02 -0500
Message-Id: <20191122055544.3299-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122055544.3299-1-sashal@kernel.org>
References: <20191122055544.3299-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Weinberger <richard@nod.at>

[ Upstream commit 550ed0e2036663b35cec12374b835444f9c60454 ]

Both do more or less the same thing and are mutually exclusive.
If both are enabled the build will fail.
Sooner or later we can kill UML's GCOV.

Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig.debug b/arch/um/Kconfig.debug
index 967d3109689ff..39d44bfb241d5 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -19,6 +19,7 @@ config GPROF
 config GCOV
 	bool "Enable gcov support"
 	depends on DEBUG_INFO
+	depends on !KCOV
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session.
-- 
2.20.1

