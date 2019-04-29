Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E70C04AA6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B5F20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 12:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfD2MDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 08:03:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:41194 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbfD2MDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 08:03:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x3TC3N75019409;
        Mon, 29 Apr 2019 07:03:23 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x3TC3MCq019406;
        Mon, 29 Apr 2019 07:03:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 29 Apr 2019 07:03:22 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Serge Belyshev <belyshev@depni.sinp.msu.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/32s: fix BATs setting with CONFIG_STRICT_KERNEL_RWX
Message-ID: <20190429120322.GP8599@gate.crashing.org>
References: <3a21c6f19637847e6ed080186a834ede619f3849.1556528569.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a21c6f19637847e6ed080186a834ede619f3849.1556528569.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

(But see comments below.)

On Mon, Apr 29, 2019 at 09:08:09AM +0000, Christophe Leroy wrote:
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index bf1de3ca39bc..37cf2af98f6a 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -101,7 +101,7 @@ static int find_free_bat(void)
>  static unsigned int block_size(unsigned long base, unsigned long top)
>  {
>  	unsigned int max_size = (cpu_has_feature(CPU_FTR_601) ? 8 : 256) << 20;
> -	unsigned int base_shift = (fls(base) - 1) & 31;
> +	unsigned int base_shift = (ffs(base) - 1) & 31;
>  	unsigned int block_shift = (fls(top - base) - 1) & 31;

The code is quite confusing now...  Add a comment, or improve it?


Segher
