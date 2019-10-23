Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AADACA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C87B21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 12:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bsg6Jw/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391684AbfJWMoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 08:44:24 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:37276 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390091AbfJWMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:44:23 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 64735C0DD6;
        Wed, 23 Oct 2019 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1571834663; bh=aXrQqzbVm4I5+qHlUf7maqgUqLYuJAqo/qBpRrPFRz0=;
        h=From:To:Cc:Subject:Date:From;
        b=Bsg6Jw/zAIzcB8ZsPsuB1WTp14Cted3p0mmnYx1fbDk7TltotUXCa/BPdMrzT9bi2
         CtO/mQkXnG17i+zpKtW1i8NLlYrqsoDtIp78aQJZFc+MxWuXT4IdQz5fZdw2ZN9yXa
         kM6JO/2kCWTYY1g49D8q+QycTPaNkdSuBpoUUhMCUn2gwLUnx7eBSEFyymk5gfu1ED
         pobxNeBaYM722mFaQAoEPAyb1fZAAARNdp/bciMfA0ubismBSF2vBHcuIf0XCj0UEC
         ILCQiTZjthDC+8FHUJl9XRzE1/kKFmKKIzFxuibVx2GD1nk7VPwOoqg/QdNQzqeF61
         ItgKj4pYlyYaA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id A035BA0057;
        Wed, 23 Oct 2019 12:44:20 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/8] ARC: merge HAPS-HS with nSIM-HS configs
Date:   Wed, 23 Oct 2019 15:44:09 +0300
Message-Id: <20191023124417.5770-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from nSIM 2019.06 is possible to use DW UART
instead of ARC UART. That allows us to merge
"nsim_hs" with "haps_hs" and "nsim_hs_smp" with "haps_hs_smp"
with some minor changes.

We eliminate nsim_hs_defconfig and nsim_hs_smp_defconfig
and leave haps_hs_defconfig and haps_hs_smp_defconfig
which can be used on HAPS / nSIM / ZEBU / QEMU platforms
without additional changes in Linux kernel.

Also while I'm at it cleanup both HAPS and nSIM configurations
from obsolete/unused options.

Changes:
RFC -> v1:
 * update KBUILD_DEFCONFIG to use the haps defconfig instead of
   nSIM one
 * switch nsim_700 to dwuart

Eugeniy Paltsev (8):
  ARC: regenerate nSIM and HAPS defconfigs
  ARC: HAPS: cleanup defconfigs from unused IO-related options
  ARC: HAPS: use same UART configuration everywhere
  ARC: HAPS: add HIGHMEM memory zone to DTS
  ARC: HAPS: cleanup defconfigs from unused ETH drivers
  ARC: merge HAPS-HS with nSIM-HS configs
  ARC: nSIM_700: switch to DW UART usage
  ARC: nSIM_700: remove unused network options

 arch/arc/Makefile                      |  2 +-
 arch/arc/boot/dts/haps_hs.dts          | 15 +++---
 arch/arc/boot/dts/haps_hs_idu.dts      |  1 -
 arch/arc/boot/dts/nsim_700.dts         | 36 +++++---------
 arch/arc/boot/dts/nsim_hs.dts          | 67 --------------------------
 arch/arc/boot/dts/nsim_hs_idu.dts      | 65 -------------------------
 arch/arc/configs/haps_hs_defconfig     | 30 +++---------
 arch/arc/configs/haps_hs_smp_defconfig | 32 +++---------
 arch/arc/configs/nsim_700_defconfig    | 19 ++++----
 arch/arc/configs/nsim_hs_defconfig     | 60 -----------------------
 arch/arc/configs/nsim_hs_smp_defconfig | 58 ----------------------
 arch/arc/plat-sim/platform.c           |  1 -
 12 files changed, 44 insertions(+), 342 deletions(-)
 delete mode 100644 arch/arc/boot/dts/nsim_hs.dts
 delete mode 100644 arch/arc/boot/dts/nsim_hs_idu.dts
 delete mode 100644 arch/arc/configs/nsim_hs_defconfig
 delete mode 100644 arch/arc/configs/nsim_hs_smp_defconfig

-- 
2.21.0

