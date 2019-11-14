Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C8C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976D4206F3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573690768;
	bh=tGvFGDEK2oZKkTKzOKFp8OpdDoQrzJYalEyDYSTMIVg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qthUu2s2jUiajGkEmg0e6X6KYp6y/qeCvGHsHmz4TcMjtJ/wL9mTEiGw9BoNnsfWT
	 dge/3kAPgHgSVxji6Otf6v9dkUOt9ylFSjR0Qcr0PprMPwtsEOR522ARpi/XZTwCo3
	 U+ey4XDLZFpZz/KYn2JhaWy+SyxDeh8mmZDkQxfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNAT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:19:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726363AbfKNAT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:19:27 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9142D206F2;
        Thu, 14 Nov 2019 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573690766;
        bh=tGvFGDEK2oZKkTKzOKFp8OpdDoQrzJYalEyDYSTMIVg=;
        h=From:To:Cc:Subject:Date:From;
        b=f/aDnd9PUbLsbmDBSL4DfUkvccnDESjrH7AtRU+zGXDtwB6YkS4lRSEQ/06/z3bUZ
         Mc7tUphoZznPcIBp6UkxdNQT0wULRKsmkns5EEPsYon/IbcDOhHDwk6XQocEEO3YV2
         EHcQv9hIJSJha9hletYo9KRaGoRyZ/ZtQKk+prYo=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] clk: ingenic: Allow drivers to be built with COMPILE_TEST
Date:   Wed, 13 Nov 2019 16:19:25 -0800
Message-Id: <20191114001925.159276-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need the MIPS architecture or even a MIPS compiler to compile
test these drivers. Let's add a COMPILE_TEST possibility on the
menuconfig here so that we can build these drivers on more
configurations.

Cc: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/ingenic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ingenic/Kconfig b/drivers/clk/ingenic/Kconfig
index fb7b39961703..b4555b465ea6 100644
--- a/drivers/clk/ingenic/Kconfig
+++ b/drivers/clk/ingenic/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menu "Ingenic SoCs drivers"
-	depends on MIPS
+	depends on MIPS || COMPILE_TEST
 
 config INGENIC_CGU_COMMON
 	bool
-- 
Sent by a computer through tubes

