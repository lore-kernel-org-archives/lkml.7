Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EF6C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB74620883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HPRJ9AXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfE1MmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:42:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37976 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfE1MmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t2vArhK5ONSzG4f61utNPX6iuQEVIA/xkviTlXVlEb4=; b=HPRJ9AXdPxXH93KtZWMlngs4d
        oLca7XsLgMK+6r6FdA4ZxY5y/aTFakuSI1ts6DG7/vtK92LYzhXJvGTVO1RTDATctncupVy4biIGM
        c14v4cUXQ9R9xaGfMz+wXoROvs7/teJ1apRU5hP1s+MEKHvIMeNVduA7NPxAlFKijYKStRXmdRUaB
        HycwgL/lBtOVl4LbgU7XZx0Kwp/EDpL0I5l+TXVTmZz85KEH+rDWSJTfWxOr+4hX19oY0ABEq0P54
        XthKetauAq/9eWp9+emsOoOJ0Q8T2I03rK3gXz4jkv7PpgO8rwQeZ6OGYOHz8pYbzhnd70glyCVbU
        n/lH3o41A==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:56030)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hVbQS-0005lo-AK; Tue, 28 May 2019 13:41:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hVbQO-0003cr-Ip; Tue, 28 May 2019 13:41:52 +0100
Date:   Tue, 28 May 2019 13:41:52 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Young Xiao <92siuyang@gmail.com>
Cc:     will.deacon@arm.com, mark.rutland@arm.com, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, peterz@infradead.org,
        kan.liang@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
Message-ID: <20190528124152.z76z7ar62hklz7tk@shell.armlinux.org.uk>
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:31:29PM +0800, Young Xiao wrote:
> When a kthread calls call_usermodehelper() the steps are:
>   1. allocate current->mm
>   2. load_elf_binary()
>   3. populate current->thread.regs
> 
> While doing this, interrupts are not disabled. If there is a perf
> interrupt in the middle of this process (i.e. step 1 has completed
> but not yet reached to step 3) and if perf tries to read userspace
> regs, kernel oops.
> 
> Fix it by setting abi to PERF_SAMPLE_REGS_ABI_NONE when userspace
> pt_regs are not set.
> 
> See commit bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs
> user process") for details.
> 
> Signed-off-by: Young Xiao <92siuyang@gmail.com>
> ---
>  arch/arm/kernel/perf_regs.c   | 3 ++-
>  arch/arm64/kernel/perf_regs.c | 3 ++-
>  arch/x86/kernel/perf_regs.c   | 3 ++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
> index 05fe92a..78ee29a 100644
> --- a/arch/arm/kernel/perf_regs.c
> +++ b/arch/arm/kernel/perf_regs.c
> @@ -36,5 +36,6 @@ void perf_get_regs_user(struct perf_regs *regs_user,
>  			struct pt_regs *regs_user_copy)
>  {
>  	regs_user->regs = task_pt_regs(current);
> -	regs_user->abi = perf_reg_abi(current);
> +	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
> +			 PERF_SAMPLE_REGS_ABI_NONE;

I'd prefer it if we didn't introduce unnecessary parens - what function
do the parens around "regs_user->regs" serve?
-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
