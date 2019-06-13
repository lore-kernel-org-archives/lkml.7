Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A78CC31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E47E20665
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441833;
	bh=Ancavv+BoF7Os5qUutPzpjyzltErOSbXPflF11dU5gA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DCCQMUO+29LrLPeYS5WUOyvYLgeMgdCWRgiY22yuMvM8/qbPEkdWI7VgcgDvdMLZm
	 e40fiheIjqqmMKoh5y05Z+R9CIlAjRIvmHN/kRCWoQKaLJP0tVn2hF2fjAmOwfddjn
	 ZD1fP1jqYp5fW+2dln9TMWcWlaavbLnBNzhIjpgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfFMQDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbfFMIrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:47:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D0122147A;
        Thu, 13 Jun 2019 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415638;
        bh=Ancavv+BoF7Os5qUutPzpjyzltErOSbXPflF11dU5gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeHwDMeWpLBVpUJrG2TegAA4PTSdVcqddb7r9g6Ma+UJmin4vt1zZyfLLrO8fDSd7
         Ee8Od5JqaLH8PVUGV6dJC2YTUpFaX1biKSxv+8u7bAqImZ3k3o4oUcZHvpbC/UEngC
         obgzvko3AGzdZIAxHga59RFuFKYPphqNB7PazPRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Borislav Petkov <bp@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>, linuxppc-dev@ozlabs.org,
        morbidrsa@gmail.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 038/155] EDAC/mpc85xx: Prevent building as a module
Date:   Thu, 13 Jun 2019 10:32:30 +0200
Message-Id: <20190613075655.219567146@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2b8358a951b1e2a534a54924cd8245e58a1c5fb8 ]

The mpc85xx EDAC driver can be configured as a module but then fails to
build because it uses two unexported symbols:

  ERROR: ".pci_find_hose_for_OF_device" [drivers/edac/mpc85xx_edac_mod.ko] undefined!
  ERROR: ".early_find_capability" [drivers/edac/mpc85xx_edac_mod.ko] undefined!

We don't want to export those symbols just for this driver, so make the
driver only configurable as a built-in.

This seems to have been broken since at least

  c92132f59806 ("edac/85xx: Add PCIe error interrupt edac support")

(Nov 2013).

 [ bp: make it depend on EDAC=y so that the EDAC core doesn't get built
   as a module. ]

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
Cc: morbidrsa@gmail.com
Link: https://lkml.kernel.org/r/20190502141941.12927-1-mpe@ellerman.id.au
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 47eb4d13ed5f..5e2e0348d460 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -263,8 +263,8 @@ config EDAC_PND2
 	  micro-server but may appear on others in the future.
 
 config EDAC_MPC85XX
-	tristate "Freescale MPC83xx / MPC85xx"
-	depends on FSL_SOC
+	bool "Freescale MPC83xx / MPC85xx"
+	depends on FSL_SOC && EDAC=y
 	help
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
-- 
2.20.1



