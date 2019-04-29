Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441CEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 101C42075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556529697;
	bh=NgEVCvQYWgC5TeyYphEa2BoW8Z91YEisDfdNHslRIZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fx/8wdgAAycdxpSKYWQfK64ZutIohN6kz84zyvdYlVUMDIpeim0dLt+S01plqQhNM
	 l8338/3FsNkDZEE82OH0PXnFO1fbcasi2Vh2MAUJo9MzSYYOi73ulIXMQN4+GA0I6k
	 l63EGYLg8ErxbhfKCE/oSQZ10Xla46Cj50ZK1YLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfD2JVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 05:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbfD2JVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 05:21:35 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5586920578;
        Mon, 29 Apr 2019 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556529695;
        bh=NgEVCvQYWgC5TeyYphEa2BoW8Z91YEisDfdNHslRIZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQX9rvJLiREBhgvHGccQcxJrHxaH3ipTxUumn0o7y5ivyBpe1OKnYSZM6bLAg6pK0
         7XzKLLsWf15rzZKuVAtAwyXq0iFDxfL0Gut3wX86y1ob5t4tfcw+mEfXllAQVkWVSL
         5bE8DI+XM/jnsXz23yGXYsybgf9ncsvM5QYYpLWI=
Date:   Mon, 29 Apr 2019 12:21:32 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.1-rc7
Message-ID: <20190429092132.GT6705@mtr-leonro.mtl.com>
References: <20190429082645.9394-1-geert@linux-m68k.org>
 <CAMuHMdUuPPf8T2_WK2V_zW8kxb1ZfzvyKJck9D3MEHMRvYrmdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUuPPf8T2_WK2V_zW8kxb1ZfzvyKJck9D3MEHMRvYrmdA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:30:06AM +0200, Geert Uytterhoeven wrote:
> On Mon, Apr 29, 2019 at 10:28 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v5.1-rc7[1] to v5.1-rc6[3], the summaries are:
> >   - build errors: +1/-0
>
>   + /kisskb/src/drivers/infiniband/core/uverbs_main.c: error: 'struct
> vm_fault' has no member named 'vm_start':  => 898:15, 898:28
>
> mips-allmodconfig
> mips-allmodconfig
> s390-allmodconfig
> s390-allyesconfig
>
> > [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/37624b58542fb9f2d9a70e6ea006ef8a5f66c30b/ (all 236 configs)
> > [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/085b7755808aa11f78ab9377257e1dad2e6fa4bb/ (all 236 configs)

Thanks,
https://patchwork.kernel.org/patch/10920895/#22610993

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
