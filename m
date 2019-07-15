Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09A0C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563177837;
	bh=BodxxScsF0Jv3v1NuDbmeuCqN9bmTOVOa273Q2DnfE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l8frYFAxcHH++nMl5vVUGOJMm1pFyNUy+yaRqi/vF3I7ufSE7rQ8luLdU8uB//JCT
	 0NvdjhxEaMAfxMkP2QqqbT4TDoJPApqsiDZKOrnfMcnMEcj1hFxBthntHd2STTV+op
	 gWRFTdNfYb/Zz+LAvH3bfcZi/dUjzMvdc0sGVZog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbfGOID4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfGOID4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 04:03:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4D8214C6;
        Mon, 15 Jul 2019 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563177835;
        bh=BodxxScsF0Jv3v1NuDbmeuCqN9bmTOVOa273Q2DnfE4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bOYMhnVPP9Lgn5gHhHdt6QTinC2NXr3Y/N6IFZWRAcgdYtLYs0MPfOuaPjkluf9Ti
         N7Npm3ILYju0sIH0ZE9PnkEUnqIpBhgiJk1W7NwVTVv1I8gDgKrmgXt8lpLTlIIak3
         j4L9EHfbU75NrPDlXRG3Gog6VM+SOggg1O/YYPHw=
Date:   Mon, 15 Jul 2019 09:03:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Qian Cai <cai@lca.pw>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        anshuman.khandual@arm.com,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, deanbo422@gmail.com,
        deller@gmx.de, Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Guan Xuetao <gxt@pku.edu.cn>, Ley Foon Tan <lftan@altera.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Hocko <mhocko@suse.com>, mm-commits@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>, ralf@linux-mips.org,
        Guo Ren <ren_guo@c-sky.com>,
        Richard Weinberger <richard@nod.at>,
        Richard Kuo <rkuo@codeaurora.org>, rppt@linux.ibm.com,
        sammy@sammy.net, Matthew Wilcox <willy@infradead.org>
Subject: Re: [patch 105/147] arm64: switch to generic version of pte
 allocation
Message-ID: <20190715080346.5hnw3hmc4y3gz6of@willie-the-truck>
References: <20190712035802.eeH5anzpz%akpm@linux-foundation.org>
 <1562935747.8510.26.camel@lca.pw>
 <20190712141058.d8fd55c910dbdf6044fab2c4@linux-foundation.org>
 <CAHk-=whd4=Dj8MY=z1DExJuJMF3zWswLwNyOQhSEzqPiFhPj-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whd4=Dj8MY=z1DExJuJMF3zWswLwNyOQhSEzqPiFhPj-A@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 02:35:42PM -0700, Linus Torvalds wrote:
> On Fri, Jul 12, 2019 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 12 Jul 2019 08:49:07 -0400 Qian Cai <cai@lca.pw> wrote:
> > >
> > > https://lore.kernel.org/linux-mm/20190617151252.GF16810@rapoport-lnx/
> >
> > That's already merged - it went in via the arm64 tree I think.
> 
> No. Only the arch/arm64/include/asm/pgtable.h part got in through the
> arm64 tree (commit 615c48ad8f42: "arm64/mm: don't initialize pgd_cache
> twice").
> 
> The arch/arm64/mm/pgd.c part was missing.

That's right; we split the patch because part of it was a fix for an
existing issue.

> I think I fixed it all up correctly.

Looks good to me, thanks.

Will
