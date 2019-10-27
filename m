Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD334CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD51214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210352;
	bh=5Nr5wkSF+b1goWgQ2aphtBeiCNf2n7oAmLzI4t7+QnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IatXcDrmQo52IVcPAEcn7AILMllGiB6yVg+LcmtyeeBMZHQbuMoiAMDHSMfq+Ji0R
	 ZO0jRnezLqStdlA/YxNzHb6BMPDIVut6OnPorK9LhjGaEI/hudldBxGAi1m2Urar2y
	 3HtYOJtRSZjUJR3tH5qAYX/ctmXh4ODLb+DtwFKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfJ0VFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbfJ0VFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:05:46 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F5C2064A;
        Sun, 27 Oct 2019 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210345;
        bh=5Nr5wkSF+b1goWgQ2aphtBeiCNf2n7oAmLzI4t7+QnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYvWgLj44OpSNj9d5HrJpjpBufc2fayKohrBkPTno82buSSTnZ2stvoBgMDS8QYkF
         CsKmqFdwwaMZrKPojL6qW12n6Y6Dw1R3T/9goljhmmU0lOIRNNj6fBB/GBnHV01C2A
         Wyu+fFO2ARMRQqa1iWsoyro7771klv5c8xuqOqEE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 04/49] ARM: OMAP2+: Fix missing reset done flag for am3 and am43
Date:   Sun, 27 Oct 2019 22:00:42 +0100
Message-Id: <20191027203122.682053599@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 8ad8041b98c665b6147e607b749586d6e20ba73a ]

For ti,sysc-omap4 compatible devices with no sysstatus register, we do have
reset done status available in the SOFTRESET bit that clears when the reset
is done. This is documented for example in am437x TRM for DMTIMER_TIOCP_CFG
register. The am335x TRM just says that SOFTRESET bit value 1 means reset is
ongoing, but it behaves the same way clearing after reset is done.

With the ti-sysc driver handling this automatically based on no sysstatus
register defined, we see warnings if SYSC_HAS_RESET_STATUS is missing in the
legacy platform data:

ti-sysc 48042000.target-module: sysc_flags 00000222 != 00000022
ti-sysc 48044000.target-module: sysc_flags 00000222 != 00000022
ti-sysc 48046000.target-module: sysc_flags 00000222 != 00000022
...

Let's fix these warnings by adding SYSC_HAS_RESET_STATUS. Let's also
remove the useless parentheses while at it.

If it turns out we do have ti,sysc-omap4 compatible devices without a
working SOFTRESET bit we can set up additional quirk handling for it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index e2d84aa7f595f..fa1c6707877a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -939,7 +939,8 @@ static struct omap_hwmod_class_sysconfig am33xx_timer_sysc = {
 	.rev_offs	= 0x0000,
 	.sysc_offs	= 0x0010,
 	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET),
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_RESET_STATUS,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
 			  SIDLE_SMART_WKUP),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
-- 
2.20.1



