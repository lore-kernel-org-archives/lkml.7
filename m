Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AD6C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3692085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 12:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intenta.de header.i=@intenta.de header.b="G0fwpmGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbfFRMNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 08:13:02 -0400
Received: from mail.intenta.de ([178.249.25.132]:32330 "EHLO mail.intenta.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRMNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 08:13:02 -0400
X-Greylist: delayed 336 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Jun 2019 08:13:01 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=intenta.de; s=dkim1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:CC:To:From:Date; bh=HPlPJ4uGAfuFI4JxO/9dnycfR2aDEbR0VS4Uhr7HO0w=;
        b=G0fwpmGa+PGXLtujI3SLrLjxixit8AZtbiSbq1UgPIh2R6FWkSN2zlzZGO6aBGepfwrEeY4MceyuFugtojP+hRQdLiC09ka+bACkIODAJ5Fnt+vMy6i6jKy/s0LLRcIUAiATXroX+ykuQdAIy48Fe4duEiyPC1rzRBHrx91X/NdFglqmPtchtR7IwGRePpTpgI0cVvs89ay+azAepZBuCPjClzZYKfQvwkzMJ0TipCtYBGsSZzzhdsDisY1Q/oOLGbjoM2MDwwgk0LrdH5m3JVXN5senlC9rTagZMZEi9HoSOo05JmYzZoMho7B/w8YQHCY33qizRgGiJaQbtwSfqA==;
X-CTCH-RefID: str=0001.0A0C020C.5D08D3F8.00C0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Date:   Tue, 18 Jun 2019 14:07:21 +0200
From:   Helmut Grohne <helmut.grohne@intenta.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 02/15] clocksource/drivers/sp804: Add COMPILE_TEST to
 CONFIG_ARM_TIMER_SP804
Message-ID: <20190618120719.a4kgyiuljm5uivfq@laureti-dev>
References: <7e786ba3-a664-8fd9-dd17-6a5be996a712@linaro.org>
 <20190509111048.11151-1-daniel.lezcano@linaro.org>
 <20190509111048.11151-2-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190509111048.11151-2-daniel.lezcano@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-ClientProxiedBy: ICSMA002.intenta.de (10.10.16.48) To ICSMA002.intenta.de
 (10.10.16.48)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 01:10:35PM +0200, Daniel Lezcano wrote:
> From: David Abdurachmanov <david.abdurachmanov@gmail.com>
> 
> This is only used on arm and arm64 platforms. Add COMPILE_TEST option.

This patch breaks selecting CONFIG_ARM_TIMER_SP804 here. I don't quite
understand why, but commit dfc82faad72520769ca146f857e65c23632eed5a is
where bisection stops.

When I try make allnoconfig with a KCONFIG_ALLCONFIG that explicitly
enables this option, it remains disabled.

When I try make menuconfig, the clocksource menu is empty.

If I apply the patch below, the option is selectable in menuconfig and
with KCONFIG_ALLCONFIG again. It could be used as an alternative
implementation, but I don't have a good rationale for why the previous
approach breaks.

My reading of the kconfig documentation indicates that the "if
condition" should only influence the default value, but it seems like it
entirely disables the option here. I'm left wondering why.

Can we revert the patch until this is sorted out?

Helmut

--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -388,7 +388,8 @@ config ARM_GLOBAL_TIMER
 	  This options enables support for the ARM global timer unit
 
 config ARM_TIMER_SP804
-	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
+	bool "Support for Dual Timer SP804 module"
+	depends on ARM || ARM64 || COMPILE_TEST
 	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select TIMER_OF if OF
