Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90366ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62B0B218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571270811;
	bh=DbAnuXxxI4ql/mIxS5Ri9OMBjzaKAjXqFG3gEGJ1gCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i6D2UWHrbdVIW/ZvXwSx+/ghE8Mkuhusvrntxbwc7WW3PllIJAbLAKn82KnZgLgkU
	 EyGYTgKHxGIIxsQxzOjwyOJ2fatUSaUbdtVZwKP727JFNGqqiJM/gi+1GAFaz1LvXf
	 2dQvbqYcXjpQuWxf2ulf2jzX5AqIuw2hHoOtMEsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438098AbfJQAGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbfJQAGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:06:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A08320872;
        Thu, 17 Oct 2019 00:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571270809;
        bh=DbAnuXxxI4ql/mIxS5Ri9OMBjzaKAjXqFG3gEGJ1gCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xz1C1hik3XHTqGfPEVqTo9ImbCcmors0wQuV4afL0eLWgsqqfDHIPmcGMmrSHBA8w
         D/szxMBGp/eS2TcvxYEmlnspxC0QqMIUztNT+FdeFI1ZkBeNjiqYKemRCibMMVU95h
         b655V++6gZTcUWL8kQ1TVhzJVSSFEaazEnFKkxhA=
Date:   Thu, 17 Oct 2019 01:06:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, catalin.marinas@arm.com, dave.martin@arm.com
Subject: Re: [PATCH 0/3] arm64: Fix support for systems without FP/SIMD
Message-ID: <20191017000644.uudhadekbeei73uy@willie-the-truck>
References: <20191010171517.28782-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010171517.28782-1-suzuki.poulose@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 06:15:14PM +0100, Suzuki K Poulose wrote:
> This series fixes the original support for systems without FP/SIMD.
> We have three set of issues with the current code :
> 
> 1) We detect the absence of FP/SIMD after the SMP cpus are brought
> online (i.e, SYSTEM scope). This means, some of the early kernel threads
> could run with their TIF_FOREIGN_FPSTATE flag set which might be
> inherited by applications forked by them (e.g, modprobe from initramfs).
> 
> Also we allow a hotplugged CPU to boot successfully even if it doesn't
> have the FP/SIMD when we have decided otherwise at boot and have now
> advertised the ELF HWCAP for the userspace.
> Fix this by turning this to a BOOT_RESTRICTED_CPU_LOCAL feature to
> allow the detection of the feature the very moment a CPU turns up
> without FP/SIMD and also prevent a conflict after SMP boot.
> 
> 2) As mentioned above, some tasks could have the TIF flag set,
> which will never be cleared after we detect the capability.
> Thus they could get stuck indefinitely in do_notfiy_resume().
> Fix this by clearing the TIF flag for such tasks but continuing
> to avoid the save/restore of the FP state.
> 
> 3) The compat ELF_HWCAP bits are statically initialised to indicate
> that the FP/SIMD support is available. This must be updated dynamically
> to provide the correct flags to the userspace.
> 
> Tested with a 32bit Debian Jessie fs on Fast model (with and without
> FP support).
> 
> Suzuki K Poulose (3):
>   arm64: cpufeature: Fix the type of no FP/SIMD capability
>   arm64: nofpsmid: Clear TIF_FOREIGN_FPSTATE flag for early tasks
>   arm64: cpufeature: Set the FP/SIMD compat HWCAP bits properly

This looks alright apart from Dave's comments on patch 2. Do you plan to
address those at all? Some of it looks like scope for future work, but there
are also some questions about the mechanics of the patch.

Will
