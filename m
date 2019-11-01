Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC2CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D2A222CB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="D2eNoW4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbfKAQHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:07:22 -0400
Received: from shroom.duncanthrax.net ([178.63.180.169]:51995 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfKAQHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:07:22 -0400
X-Greylist: delayed 1667 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 12:07:21 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iqYA5fETDX6oAawBOnjaoR4rJRUghsV/4yW9eGheshQ=; b=D2eNoW4p9bKXgIjVB+MrDQs49v
        HcO9QyX0Pi147mZPEvurVKnXCIkEcvidueyMePcq2Vh9DEacMwF0M7CNrdUJEWiqFzj5GFVxyUPYr
        qRHgjxVwF7JOc7J0TcYhN0b1EYTbuY8WNb4wE5/dz8Gf7d4jNBbBhMIhSLPCjrdq4d5U=;
Received: from hsi-kbw-046-005-233-221.hsi8.kabel-badenwuerttemberg.de ([46.5.233.221] helo=t470p.stackframe.org)
        by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
        (envelope-from <svens@stackframe.org>)
        id 1iQZ1P-00080S-20; Fri, 01 Nov 2019 16:39:31 +0100
Date:   Fri, 1 Nov 2019 16:39:30 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        amit.kachhap@arm.com, catalin.marinas@arm.com, deller@gmx.de,
        duwe@suse.de, James.Bottomley@HansenPartnership.com,
        james.morse@arm.com, jeyu@kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, linux-parisc@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        takahiro.akashi@linaro.org, will@kernel.org
Subject: Re: [PATCHv2 0/8] arm64: ftrace cleanup + FTRACE_WITH_REGS
Message-ID: <20191101153929.GA9053@t470p.stackframe.org>
References: <20191029165832.33606-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029165832.33606-1-mark.rutland@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Tue, Oct 29, 2019 at 04:58:24PM +0000, Mark Rutland wrote:
> Hi,
> 
> This series is a reworked version of Torsten's FTRACE_WITH_REGS series
> [1]. I've tried to rework the existing code in preparatory patches so
> that the patchable-function-entry bits slot in with fewer surprises.
> This version is based on v5.4-rc3, and can be found in my
> arm64/ftrace-with-regs branch [2].
> 
> Patch 1 adds an (optional) ftrace_init_nop(), which the core code uses
> to initialize callsites. This allows us to avoid a synthetic MCOUNT_ADDR
> symbol, and more cleanly separates the one-time initialization of the
> callsite from dynamic NOP<->CALL modification. Architectures which don't
> implement this get the existing ftrace_make_nop() with MCOUNT_ADDR.
> 
> Recently parisc gained ftrace support using patchable-function-entry.
> Patch 2 makes the handling of module callsite locations common in
> kernel/module.c with a new FTRACE_CALLSITE_SECTION definition, and
> removed the newly redundant bits from arch/parisc.
> 
> Patches 3 and 4 move the module PLT initialization to module load time,
> which simplifies runtime callsite modification. This also means that we
> don't transitently mark the module text RW, and will allow for the
> removal of module_disable_ro().
> 
> Patches 5 and 6 add some trivial infrastructure, with patch 7 finally
> adding FTRACE_WITH_REGS support. Additional work will be required for
> livepatching (e.g. implementing reliable stack trace), which is
> commented as part of patch 7.
> 
> Patch 8 is a trivial cleanup atop of the rest of the series, making the
> code easier to read and less susceptible to config-specific breakage.
> 
> Since v1 [3]:
> * Add a couple of people to Cc
> * Fold in Ard's Reviewed-by tag
> * Rename ftrace_code_init_disabled() to ftrace_nop_initialize()
> * Move ftrace_init_nop() to <linux/ftrace.h>, with kerneldoc
> * Update kerneldoc for rec parameters
[..]

I tested this series on parisc both with ftracing kernel internal functions and
module functions. Both are working fine, so feel free to add my

Tested-by: Sven Schnelle <svens@stackframe.org>

Regards
Sven
