Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A44BC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6BD222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610213;
	bh=b9cOOqN6mQFnZs78FIgD6ZunfWBisXdwsKiH6hJNCbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eBvm4DBQDET9MBw0K821zjsBIwl92rU/I5KjgBfJY5L+mXgB7gF913ELdPMMzNG7s
	 bcy0NRZx6xe4gGi871yAB4vUbLLc7COr1ij9DYJLtHBKnQPG6jDHE0xHifGG/Hab52
	 eSOcuKXNJR3ziACeC6v4a34xzffy1dVWHw655HSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbfKMB4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:56:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729567AbfKMB4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA48A222CF;
        Wed, 13 Nov 2019 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610203;
        bh=b9cOOqN6mQFnZs78FIgD6ZunfWBisXdwsKiH6hJNCbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRIP7zaT2FtK1op7whyqP2OjnpUqOjUlC7XEpag1ReyJ0PV36x3e/RQeCYgQSNRBC
         8xp87GrfZt7LylTz6Ns8l//1idhn1CmhUkvZ9VBY6+WiN1euUHdVpApJzKDoTT4G+R
         RH8bFh34cfJyQwozqpy9hNWqJ+gnUp4R8X1AfHME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-ide@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 015/115] ata: ahci_brcm: Allow using driver or DSL SoCs
Date:   Tue, 12 Nov 2019 20:54:42 -0500
Message-Id: <20191113015622.11592-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 7fb44929cb0e5cdcde143e1ca3ca57b5b8247db0 ]

The Broadcom STB AHCI controller is the same as the one found on DSL
SoCs, so we will utilize the same driver on these systems as well.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cb5339166563e..229a5ccd6b73b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -102,7 +102,8 @@ config SATA_AHCI_PLATFORM
 
 config AHCI_BRCM
 	tristate "Broadcom AHCI SATA support"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || ARCH_BCM_NSP || \
+		   ARCH_BCM_63XX
 	help
 	  This option enables support for the AHCI SATA3 controller found on
 	  Broadcom SoC's.
-- 
2.20.1

