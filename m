Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7B8C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A852068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402739;
	bh=5UKKWctJDQZ8xRe1z8NZtBEcyGxr87Z4366ykrJckvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zl5sG8jTieI/NOarSM8EPckWdG8ItvWkffpXCCEigQx0wylE7iW4QbcppBx50laCg
	 BoL0+HDy28bW9VzROc0q8RGv1Gb9Ju0lgi4Sh5CikGkTqwvuLuYKgfPhNPHc2pT39A
	 NNHiUaIZse09aUHMqxxh/kLuZsK+mn4IE0pyy7gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfKVGFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727967AbfKVGCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:02:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9637E20714;
        Fri, 22 Nov 2019 06:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402557;
        bh=5UKKWctJDQZ8xRe1z8NZtBEcyGxr87Z4366ykrJckvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iqqicVhDFw6xYecwRJtOt+7h8Zt4pbdHvYfpu6u5cgGACOdE1N9oDI/AFjmtQH2gC
         HmseyxsQfy+cfMyJ8FS6389BK9VFALGm9dzBute3qbPswuei6kctnu7SfUdJhSUshu
         rAlZh8WFlZHcxFddmAytCkCnCB1rqe6Q7Y0/YjOM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>, linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 62/91] um: Make GCOV depend on !KCOV
Date:   Fri, 22 Nov 2019 01:01:00 -0500
Message-Id: <20191122060129.4239-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
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
index 68205fd3b08c8..6ae7f0f434a9c 100644
--- a/arch/um/Kconfig.debug
+++ b/arch/um/Kconfig.debug
@@ -18,6 +18,7 @@ config GPROF
 config GCOV
 	bool "Enable gcov support"
 	depends on DEBUG_INFO
+	depends on !KCOV
 	help
 	  This option allows developers to retrieve coverage data from a UML
 	  session.
-- 
2.20.1

