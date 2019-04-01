Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C621AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DCF20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140529;
	bh=7s7kxGp2Q3WWujZ4w2VY066U4x5+eWDdIPjpzEMnoEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kvQ9VCWuL/urk8OhFcU6nviybGVzEWba+8dzd5ctQ7HihnlE4Xr0wbTk/CCv/s6W1
	 5jo/GnlEvKLhFXkFxqOnEyHEXWSDHEZi7bwqEOdEKB3Ov9MftTbExa2NSsCFwHlpsf
	 xUkN3b7Y05YhVGQ0hV/nv+E2CP6Q//FsUucUVNY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbfDARmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388180AbfDARh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C9520830;
        Mon,  1 Apr 2019 17:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140248;
        bh=7s7kxGp2Q3WWujZ4w2VY066U4x5+eWDdIPjpzEMnoEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejysrhAWuIDxZaOjPyFNUAo0cWHHEHf7QCfVbq0Qw1gs0Zq43TSJgkv2z0wmyGjzs
         MCYAtjNnA1D5BplGZkSxwp54ZtrcXtyy7c8pRBcGtj9SISfd4D1m/8Wn6bj+vPWhky
         04r0oFIE6QwGicnPlJA0wy59YKZQvOG+vlSSLEZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 19/50] ARM: 8510/1: rework ARM_CPU_SUSPEND dependencies
Date:   Mon,  1 Apr 2019 19:03:02 +0200
Message-Id: <20190401170043.576990744@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1b9bdf5c1661873a10e193b8cbb803a87fe5c4a1 ]

The code enabled by the ARM_CPU_SUSPEND config option is used by
kernel subsystems for purposes that go beyond system suspend so its
config entry should be augmented to take more default options into
account and avoid forcing its selection to prevent dependencies
override.

To achieve this goal, this patch reworks the ARM_CPU_SUSPEND config
entry and updates its default config value (by adding the BL_SWITCHER
option to it) and its dependencies (ARCH_SUSPEND_POSSIBLE), so that the
symbol is still selected by default by the subsystems requiring it and
at the same time enforcing the dependencies correctly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bd3a806df001..ee9acbfa7a1d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1433,7 +1433,6 @@ config BIG_LITTLE
 config BL_SWITCHER
 	bool "big.LITTLE switcher support"
 	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU && ARM_GIC
-	select ARM_CPU_SUSPEND
 	select CPU_PM
 	help
 	  The big.LITTLE "switcher" provides the core functionality to
@@ -2153,7 +2152,8 @@ config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
 config ARM_CPU_SUSPEND
-	def_bool PM_SLEEP
+	def_bool PM_SLEEP || BL_SWITCHER
+	depends on ARCH_SUSPEND_POSSIBLE
 
 config ARCH_HIBERNATION_POSSIBLE
 	bool
-- 
2.19.1



