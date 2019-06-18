Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B8C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB32D213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 13:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfFRNuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:50:51 -0400
Received: from foss.arm.com ([217.140.110.172]:42176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfFRNuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 09:50:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC7CD2B;
        Tue, 18 Jun 2019 06:50:49 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 412343F718;
        Tue, 18 Jun 2019 06:50:48 -0700 (PDT)
Date:   Tue, 18 Jun 2019 14:50:46 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Anisse Astier <aastier@freebox.fr>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@aerifal.cx>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64/sve: <uapi/asm/ptrace.h> should not depend
 on <uapi/linux/prctl.h>
Message-ID: <20190618135046.GH31041@fuggles.cambridge.arm.com>
References: <20190617084545.GA38959@anisse-station>
 <20190617132222.32182-1-aastier@freebox.fr>
 <20190617132222.32182-2-aastier@freebox.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617132222.32182-2-aastier@freebox.fr>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 03:22:22PM +0200, Anisse Astier wrote:
> Otherwise this will create userspace build issues for any program
> (strace, qemu) that includes both <sys/prctl.h> (with musl libc) and
> <linux/ptrace.h> (which then includes <asm/ptrace.h>), like this:
> 
> 	error: redefinition of 'struct prctl_mm_map'
> 	 struct prctl_mm_map {
> 
> See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
> for a public example of people working around this issue.
> 
> Copying the defines is a bit imperfect here, but better than creating a
> whole other header for just two defines that would never change, as part
> of the kernel ABI.
> 
> This patch depends on patch "arm64: ssbd: explicitly depend on
> <linux/prctl.h>" for kernel >= 4.18
> 
> Fixes: 43d4da2c45b2 ("arm64/sve: ptrace and ELF coredump support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anisse Astier <aastier@freebox.fr>
> ---
>  arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

I've pushed these two out to the arm64 fixes branch [1], with Dave's Ack
on this one. Note that I reworked the commit messages a bit to explain
better what's going on.

Cheers,

Will

[1] https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/fixes
