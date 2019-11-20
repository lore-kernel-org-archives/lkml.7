Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2170220898
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574277417;
	bh=UQU++xEappoMl5G28i/JzcgG4wXZ2fTH42SKjc1j2u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=osWeuBlUlCUTx5t6atYjFJBhfXN9LESKC/GrVJTyR5Q2LjylZqgIF5CuRrXUXPbwg
	 O2EJY4FPpZcIRl023XgJ9nJVJffW1P6mokDT/KIOD+I88fFQ/Bia9XUEeWA510la4D
	 OisCMqgtaqPOmlUmg5j5ao30iZeHsZ5zU2VU5uK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKTTQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:16:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbfKTTQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:16:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C4120855;
        Wed, 20 Nov 2019 19:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574277414;
        bh=UQU++xEappoMl5G28i/JzcgG4wXZ2fTH42SKjc1j2u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WziG8xtuqOgZFzbPFcjtcWVQNw9A3GkxdTmLRuZttL6PQH/5hhUSy5PgUF+xggJWh
         Ljq67o33oiP9+FLlDynMRmypUwOSq9pz+0XKfC8jwoLl4mR7wbfOTSkG/r4JeHu7EH
         Dzc6jXuL/zsVIfPXEYHCtIq1vIhRk9OYXypDE8vs=
Date:   Wed, 20 Nov 2019 19:16:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, steve.capper@arm.com,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com, mark.rutland@arm.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
Message-ID: <20191120191648.GB4799@willie-the-truck>
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 05:10:06PM -0500, Pavel Tatashin wrote:
> Userland access functions (__arch_clear_user, __arch_copy_from_user,
> __arch_copy_in_user, __arch_copy_to_user), enable and disable PAN
> for the duration of copy. However, when copy fails for some reason,
> i.e. access violation the code is transferred to fixedup section,
> where we do not disable PAN.
> 
> The bug is a security violation as the access to userland is still
> open when it should be disabled, but it also causes memory corruptions
> when software emulated PAN is used: CONFIG_ARM64_SW_TTBR0_PAN=y.
> 
> I was able to reproduce memory corruption problem on Broadcom's SoC
> ARMv8-A like this:
> 
> Enable software perf-events with PERF_SAMPLE_CALLCHAIN so userland's
> stack is accessed and copied.
> 
> The test program performed the following on every CPU and forking many
> processes:
> 
> 	unsigned long *map = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
> 				  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> 	map[0] = getpid();
> 	sched_yield();
> 	if (map[0] != getpid()) {
> 		fprintf(stderr, "Corruption detected!");
> 	}
> 	munmap(map, PAGE_SIZE);
> 
> From time to time I was getting map[0] to contain pid for a different
> process.
> 
> Fixes: 338d4f49d6f7114 ("arm64: kernel: Add support for Privileged...")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/lib/clear_user.S     | 1 +
>  arch/arm64/lib/copy_from_user.S | 1 +
>  arch/arm64/lib/copy_in_user.S   | 1 +
>  arch/arm64/lib/copy_to_user.S   | 1 +
>  4 files changed, 4 insertions(+)

Thanks. I've pushed this and your other patch out [1], with some changes
to the commit message. I'm annoyed that I didn't spot this during review
of the initial PAN patches.

Will

[1] https://fixes.arm64.dev
