Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D924C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413327;
	bh=NISoBMVF0NpWM66kbTqoeWdT27uAFHKgPtyG9pJJ1sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yxyRjK8BrbCyue1bamrSPzm9L6cvPf2xCqkjXabMFgZm2L8WteHovNxi/W98mzK8w
	 KtT6IFF8niiYSdqIAKPnLp/ysMX5i7Qffb0L1gtWsNKarPim9dVE2TKvma/hBwf9v/
	 1GPf2NH1OLuyWSV1nC7b+ytcT/evXUjgb6zjIzSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfLCWsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:48:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729155AbfLCWsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:48:41 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F79320848;
        Tue,  3 Dec 2019 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413320;
        bh=NISoBMVF0NpWM66kbTqoeWdT27uAFHKgPtyG9pJJ1sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fX1+2bZkPq76PZ7GZFpszGrRSPgYJEH26CNhf5rpf+z5fA5JCYb5fGiPfA+Edpskk
         IXuZssQuykoRMO/6nlQh1IYHK1TLFf0Rou+1Dx5M98Wuxk3GAWHjY6+8FKW5k74vsx
         XXeuiqPlRpwyb1WJiBBI/6VQBYFK0sERC9Ng0B9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 081/321] ARM: ks8695: fix section mismatch warning
Date:   Tue,  3 Dec 2019 23:32:27 +0100
Message-Id: <20191203223431.373128527@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 4aa64677330beeeed721b4b122884dabad845d66 ]

WARNING: vmlinux.o(.text+0x13250): Section mismatch in reference from the function acs5k_i2c_init() to the (unknown reference) .init.data:(unknown)
The function acs5k_i2c_init() references
the (unknown reference) __initdata (unknown).
This is often because acs5k_i2c_init lacks a __initdata
annotation or the annotation of (unknown) is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-ks8695/board-acs5k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ks8695/board-acs5k.c b/arch/arm/mach-ks8695/board-acs5k.c
index ef835d82cdb95..5783062224c39 100644
--- a/arch/arm/mach-ks8695/board-acs5k.c
+++ b/arch/arm/mach-ks8695/board-acs5k.c
@@ -100,7 +100,7 @@ static struct i2c_board_info acs5k_i2c_devs[] __initdata = {
 	},
 };
 
-static void acs5k_i2c_init(void)
+static void __init acs5k_i2c_init(void)
 {
 	/* The gpio interface */
 	gpiod_add_lookup_table(&acs5k_i2c_gpiod_table);
-- 
2.20.1



