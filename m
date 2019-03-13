Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7243CC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D33A2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 20:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552510686;
	bh=JDHn2HtnkUSZH5fZ+Do5A5xKS+DP7ZXUc1b3Yhu/yKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C5L0uwcO7kyIAUkoUcAlFRqx6rqT8aVjPdY857GrPcpG/yKixDQXYkFq4XuHRpAJ6
	 hpvqnk20p57q/yMYHe7vF7hTryDrXkdGq8xR3lQPhtojCZ6xHqmYODVQF5Nrm5HQFJ
	 UjrHq9GUe2xpv2gOpoe5w49NKOGsX3wxJkVIIoQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfCMU6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfCMU6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 16:58:04 -0400
Received: from localhost (unknown [12.27.65.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A20206DF;
        Wed, 13 Mar 2019 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552510683;
        bh=JDHn2HtnkUSZH5fZ+Do5A5xKS+DP7ZXUc1b3Yhu/yKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUqa0DZYlXJAK9BQUvYkZn+YeO/8GRJIxI7Nzky4doFhOboenjMSV5OBV6y3jUzcm
         le9wt91LpaAFRrpHBCijyQ/gOLl5AZNC/KmHoh+ZWsUwjREa2l1v/vSmSPhuqW+tPX
         Abs4z0FLKfsUVZk+JcbM5+olclsxHbC12KafB1y0=
Date:   Wed, 13 Mar 2019 13:58:02 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Huang Pei <huangpei@loongson.cn>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        ambrosehua <ambrosehua@gmail.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Xu Chenghua <xuchenghua@loongson.cn>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: =?utf-8?B?UmXvvJpbUEFUQ0ggNC4=?= =?utf-8?Q?9?= 81/96] MIPS:
 Loongson: Introduce and use loongson_llsc_mb()
Message-ID: <20190313205802.GC5289@kroah.com>
References: <tencent_033D72440ADE105C78D24982@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_033D72440ADE105C78D24982@qq.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 09:17:15PM +0800, 陈华才 wrote:
> Hi, GREG,
> 
> 4.9 need to modify spinlock.h, please wait my patch.
> 
> 
> 
> ---原始邮件---
> 发件人:"Greg Kroah-Hartman"<gregkh@linuxfoundation.org>
> 发送时间:2019年3月13日(星期三) 凌晨1:10
> 收件人:"linux-kernel"<linux-kernel@vger.kernel.org>;
> 主题:[PATCH 4.9 81/96] MIPS: Loongson: Introduce and use loongson_llsc_mb()
> 4.9-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit e02e07e3127d8aec1f4bcdfb2fc52a2d99b4859e ]
> 
> On the Loongson-2G/2H/3A/3B there is a hardware flaw that ll/sc and
> lld/scd is very weak ordering. We should add sync instructions "before
> each ll/lld" and "at the branch-target between ll/sc" to workaround.
> Otherwise, this flaw will cause deadlock occasionally (e.g. when doing
> heavy load test with LTP).
> 
> Below is the explaination of CPU designer:
> 
> "For Loongson 3 family, when a memory access instruction (load, store,
> or prefetch)'executing occurs between the execution of LL and SC, the
> success or failure of SC is not predictable. Although programmer would
> not insert memory access instructions between LL and SC, the memory
> instructions before LL in program-order, may dynamically executed
> between the execution of LL/SC, so a memory fence (SYNC) is needed
> before LL/LLD to avoid this situation.
> 
> Since Loongson-3A R2 (3A2000), we have improved our hardware design to
> handle this case. But we later deduce a rarely circumstance that some
> speculatively executed memory instructions due to branch misprediction
> between LL/SC still fall into the above case, so a memory fence (SYNC)
> at branch-target (if its target is not between LL/SC) is needed for
> Loongson 3A1000, 3B1500, 3A2000 and 3A3000.
> 
> Our processor is continually evolving and we aim to to remove all these
> workaround-SYNCs around LL/SC for new-come processor."
> 
> Here is an example:
> 
> Both cpu1 and cpu2 simutaneously run atomic_add by 1 on same atomic var,
> this bug cause both ''un by two cpus (in atomic_add) succeed at same
> time(''eturn 1), and the variable is only *added by 1*, sometimes,
> which is wrong and unacceptable(it should be added by 2).
> 
> Why disable fix-loongson3-llsc in compiler?
> Because compiler fix will cause problems in kernel'__ex_table section.
> 
> This patch fix all the cases in kernel, but:
> 
> +. the fix at the end of futex_atomic_cmpxchg_inatomic is for branch-target
> of 'e'there other cases which smp_mb__before_llsc() and smp_llsc_mb() fix
> the ll and branch-target coincidently such as atomic_sub_if_positive/
> cmpxchg/xchg, just like this one.
> 
> +. Loongson 3 does support CONFIG_EDAC_ATOMIC_SCRUB, so no need to touch
> edac.h
> 
> +. local_ops and cmpxchg_local should not be affected by this bug since
> only the owner can write.
> 
> +. mips_atomic_set for syscall.c is deprecated and rarely used, just let
> it go
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> [paul.burton@mips.com:
>  - Simplify the addition of -mno-fix-loongson3-llsc to cflags, and add
>  a comment describing why it'there.
>  - Make loongson_llsc_mb() a no-op when
>  CONFIG_CPU_LOONGSON3_WORKAROUNDS=n, rather than a compiler memory
>  barrier.
>  - Add a comment describing the bug & how loongson_llsc_mb() helps
>  in asm/barrier.h.]
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: ambrosehua@gmail.com
> Cc: Steven J . Hill <Steven.Hill@cavium.com>
> Cc: linux-mips@linux-mips.org
> Cc: Fuxin Zhang <zhangfx@lemote.com>
> Cc: Zhangjin Wu <wuzhangjin@gmail.com>
> Cc: Li Xuefeng <lixuefeng@loongson.cn>
> Cc: Xu Chenghua <xuchenghua@loongson.cn>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> arch/mips/Kconfig               | 15 ++++++++++++++
> arch/mips/include/asm/atomic.h  |  6 ++++++
> arch/mips/include/asm/barrier.h | 36 +++++++++++++++++++++++++++++++++
> arch/mips/include/asm/bitops.h  |  5 +++++
> arch/mips/include/asm/futex.h   |  3 +++
> arch/mips/include/asm/pgtable.h |  2 ++
> arch/mips/loongson64/Platform   | 23 +++++++++++++++++++++
> arch/mips/mm/tlbex.c            | 10 +++++++++
> 8 files changed, 100 insertions(+)

Ok, I will go drop this from all stable queues now, thanks!

greg k-h
