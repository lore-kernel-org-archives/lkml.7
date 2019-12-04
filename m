Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE3C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B894E205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483731;
	bh=GQas2avcl0NjPgNPlaAfiSvtV+EZURLJOYzb58XTsXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AlXDGOG0333KeBBSec0+qv9iTCIvH3a4WV82W3Z3KL0g6al52RiaqyYkSk3kBAJIN
	 dqJFNz9S3gK7Du07KFCCoJqJe+0Hr6qGLtBN/AMre9A3kTXEBQYEZcT1HpUx2ERvIw
	 HqCGYDWbm21fCBHlB/KIs2bfotBV7daAJOJu7pG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbfLDSFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730022AbfLDSFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:05:31 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC1322081B;
        Wed,  4 Dec 2019 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482730;
        bh=GQas2avcl0NjPgNPlaAfiSvtV+EZURLJOYzb58XTsXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JgbRub/z6tik/1Bah5q43O3imJtMhny4g4AeGVP31XpSrorisSDbKtpfAO9rKEe25
         tK9ehV3E/KF7GlEtdlH+cTumljxO4aVWRH9eYvsN8TL3VJG6RpbnYqI0fm2pmcxmKN
         hr27kORxAF/dfnXObYSUDpfRMAVI+EMvm+dTMvbc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 112/209] um: Make GCOV depend on !KCOV
Date:   Wed,  4 Dec 2019 18:55:24 +0100
Message-Id: <20191204175330.337779127@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



