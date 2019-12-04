Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9071BC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2420833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482361;
	bh=5UKKWctJDQZ8xRe1z8NZtBEcyGxr87Z4366ykrJckvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXd9lYphYJ+cAZvKXN4itL4WyHPY0QqAUBCqCKtmN03JZ6Mb4ino2M/ldeA4Gsh8+
	 +dkOdoD2oEGG0ic50hkzoG5Fl0g3bYlnnTcvxoL9vDGOWJEjU21dhKXpK95b0MvL9U
	 oKDgBoWGLEXhHzceopRUU/e6WE0JfSjMCI/bg7nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfLDR7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 12:59:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:35422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729068AbfLDR7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 12:59:16 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562F32073B;
        Wed,  4 Dec 2019 17:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482355;
        bh=5UKKWctJDQZ8xRe1z8NZtBEcyGxr87Z4366ykrJckvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MupuoFVA0w1FAByqAENQ9LbmFVwgsaGyHl0r5fzdiWmw/ZGbH7IK2cNqaKG5v3o4O
         yFut+XdR0CPeQLvnfmVyAas4KcrmCdr8YsF5fnz0FEr1OPG5hC/H8VmboyhaptCdtW
         KB48+EaeRLieD/cccUp1Z9goTldyeWP7+PGU3tWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 55/92] um: Make GCOV depend on !KCOV
Date:   Wed,  4 Dec 2019 18:49:55 +0100
Message-Id: <20191204174333.740129153@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204174327.215426506@linuxfoundation.org>
References: <20191204174327.215426506@linuxfoundation.org>
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



