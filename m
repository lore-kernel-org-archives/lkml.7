Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC327C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A351F2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403782;
	bh=+MPkf+/1ZgSXTTcyRZTaHbIWLFnK7BZRQH9Tcq5LrlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vl+6CBeTEs0iUgoeRQSFVCqwhBT/V3Hfcb3uBExYxyT886VAX4DqykOfwKp4SpKON
	 hg4rpGu7Wx1q7r3BM2G8p/9g/byaIteX2BeAGiPk44aVqEOYJId8BWVntAmNeAhNvA
	 x+wxuirceqnKPnPHB4CQRsIS4dbOsLHJAGQKEuv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfKVGXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfKVFvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D5DA2070A;
        Fri, 22 Nov 2019 05:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401913;
        bh=+MPkf+/1ZgSXTTcyRZTaHbIWLFnK7BZRQH9Tcq5LrlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ur/qXM0UZOHhrmqSRKTl8ZLjoNzUpMOB500Me/fMwxbCH4ydP/o0fBv+VwmDz1dvq
         UJIRaMpsetUpCiCX66/JR21ermiDEe8N+3ahPkwLG5fMzi+jQISxawS5fKrEbz8kYF
         TdpX2BjkZ5kZZfgK6h4Ih5yP0HyRy478sYhDrzuY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 144/219] um: Make GCOV depend on !KCOV
Date:   Fri, 22 Nov 2019 00:47:56 -0500
Message-Id: <20191122054911.1750-137-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
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
index 2014597605ea9..85726eeec3451 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -16,6 +16,7 @@ config GPROF
 config GCOV
 	bool "Enable gcov support"
 	depends on DEBUG_INFO
+	depends on !KCOV
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session.
-- 
2.20.1

