Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F411C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2799B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388194AbfB1RPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:15:13 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51756 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732899AbfB1RPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:15:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2818EBD;
        Thu, 28 Feb 2019 09:15:10 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9673F720;
        Thu, 28 Feb 2019 09:15:09 -0800 (PST)
Date:   Thu, 28 Feb 2019 17:15:07 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Zhang Lei <zhang.lei@jp.fujitsu.com>
Subject: Re: [PATCH v5] arm64: Add workaround for Fujitsu A64FX erratum 010001
Message-ID: <20190228171506.GC226495@arrakis.emea.arm.com>
References: <20190226184341.26083-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226184341.26083-1-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 06:43:41PM +0000, James Morse wrote:
> From: Zhang Lei <zhang.lei@jp.fujitsu.com>
> 
> On the Fujitsu-A64FX cores ver(1.0, 1.1), memory access may cause
> an undefined fault (Data abort, DFSC=0b111111). This fault occurs under
> a specific hardware condition when a load/store instruction performs an
> address translation. Any load/store instruction, except non-fault access
> including Armv8 and SVE might cause this undefined fault.
> 
> The TCR_ELx.NFD1 bit is used by the kernel when CONFIG_RANDOMIZE_BASE
> is enabled to mitigate timing attacks against KASLR where the kernel
> address space could be probed using the FFR and suppressed fault on
> SVE loads.
> 
> Since this erratum causes spurious exceptions, which may corrupt
> the exception registers, we clear the TCR_ELx.NFDx=1 bits when
> booting on an affected CPU.
> 
> Signed-off-by: Zhang Lei <zhang.lei@jp.fujitsu.com>
> [Generated MIDR value/mask for __cpu_setup(), removed spurious-fault handler
>  and always disabled the NFDx bits on affected CPUs]
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: zhang.lei <zhang.lei@jp.fujitsu.com>

Queued for 5.1. Thanks.

-- 
Catalin
