Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372FBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C7720855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="pA52IRmK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="bU26BXET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfDDHUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:20:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39670 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfDDHUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:20:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 177686044E; Thu,  4 Apr 2019 07:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362434;
        bh=Tf05padmYY9W0Nlpdwfn0Uv75g1nIbg+zNGAKiv48iQ=;
        h=From:To:Cc:Subject:Date:From;
        b=pA52IRmKxjEYC921aGrSwYLpo50+jn3KQrrTfBeAllU4W8AKtgb9/Sdp5B4PlyxPu
         pWSqiwztU2CiE4/48NofDSH/lZ5NWc+vpSJlHBdlc47bsVOC4lI5bGaYZhn36go3of
         Zgwppjf+HEwVh602x5SrhEyFzqTfmGeu6m4R9ezE=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5331B611CE;
        Thu,  4 Apr 2019 07:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554362432;
        bh=Tf05padmYY9W0Nlpdwfn0Uv75g1nIbg+zNGAKiv48iQ=;
        h=From:To:Cc:Subject:Date:From;
        b=bU26BXETveM/WaRH3U+YjMPawsG/koNGFYgJcyrN4jQYf1iGJdF4qJRdCrAPrcKBw
         MqbdGDRqkTm4Wy6CsV9CLfEErE9sC1CRJZMAXXBerK6cuu90F4+GsrDP90R8j/xaK6
         vZ82b4HQX8F4j9bYs+oeQt/mSLCQq2sSiqIVInb4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5331B611CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH 0/7] irqchip: Use devm_platform_ioremap_resource()
Date:   Thu,  4 Apr 2019 12:50:06 +0530
Message-Id: <1554362413-3305-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This is just a minor change to promote using of this api
devm_platform_ioremap_resource() and nothing else functional
change it does.

Also, there are patches where only ioremap is used without requesting
the mem region so this devm_platform_ioremap_resource() take cares all
of that in single call.


Mukesh Ojha (7):
  irqchip/irq-uniphier-aidet: Use devm_platform_ioremap_resource()
  irqchip/irq-imgpdc.c: Use devm_platform_ioremap_resource()
  irqchip/irq-ts4800.c: Use devm_platform_ioremap_resource()
  irqchip/irq-mbigen.c: Use devm_platform_ioremap_resource()
  irqchip/irq-mvebu-icu: Use devm_platform_ioremap_resource()
  irqchip/irq-mvebu-pic: Use devm_platform_ioremap_resource()
  irqchip/irq-mvebu-sei: Use devm_platform_ioremap_resource()

 drivers/irqchip/irq-imgpdc.c         | 10 +---------
 drivers/irqchip/irq-ls-scfg-msi.c    |  4 +---
 drivers/irqchip/irq-mbigen.c         |  9 +--------
 drivers/irqchip/irq-mvebu-icu.c      |  4 +---
 drivers/irqchip/irq-mvebu-pic.c      |  4 +---
 drivers/irqchip/irq-mvebu-sei.c      |  3 +--
 drivers/irqchip/irq-ts4800.c         |  4 +---
 drivers/irqchip/irq-uniphier-aidet.c |  4 +---
 8 files changed, 8 insertions(+), 34 deletions(-)

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

