Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C631C24683
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576607543;
	bh=utRU0rcTxqsnhWk9PNVbjZTpVL/hhO/HrBD/nPxq4fM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rrI9Ss7AM8KSZZhAAn8gmbjMN8aaivKQmYJ4OnRO9hC4AjvpQto2qu6uzkM2ERMTG
	 eT8+Pr/JumTyfWd6nXk0/rGuHte1Dsv8l5+DoD7R7Yk+R0bhACp2v5+719FLibXt5S
	 X+Nfd0lDgjCNZa8x9AixwgVphW4MwmipBNq+sRHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbfLQScW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 13:32:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:33638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfLQScW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:32:22 -0500
Received: from rapoport-lnx (unknown [87.71.31.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F022072D;
        Tue, 17 Dec 2019 18:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576607541;
        bh=utRU0rcTxqsnhWk9PNVbjZTpVL/hhO/HrBD/nPxq4fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdWRiqTKQ4SxW0b6an1UEYpDfBwhuvKp6ARSjzCkngo1iXrbrLgOZnAOaq+ATyvkp
         ioZZY+/NDuvIYNtHKlBjfGGiAtAFhaQCLhG2bJW9ozes7DFPaaudXXilp6WsB3EBDN
         OUnCOguhqK7w7hztbs3HnqpA0mK2yijRgOMvgWx4=
Date:   Tue, 17 Dec 2019 20:32:14 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 2/2] sh: add support for folded p4d page tables
Message-ID: <20191217183213.GA29446@rapoport-lnx>
References: <20191217142150.10392-1-rppt@kernel.org>
 <20191217142150.10392-3-rppt@kernel.org>
 <CAMuHMdXYp7EBK446EsDt_HLDvc96TPP9oPZmsLtFL5VvhSejjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXYp7EBK446EsDt_HLDvc96TPP9oPZmsLtFL5VvhSejjw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 06:59:43PM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Tue, Dec 17, 2019 at 3:23 PM Mike Rapoport <rppt@kernel.org> wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and remove usage of __ARCH_USE_5LEVEL_HACK.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/mm/fault.c
> > +++ b/arch/sh/mm/fault.c
> > @@ -65,7 +66,20 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
> >                         break;
> >                 }
> >
> > -               pud = pud_offset(pgd, addr);
> > +               p4d = p4d_offset(pgd, addr);
> > +               if (PTRS_PER_P4D != 1)
> > +                       printk(", *p4d=%0*Lx", (u32)(sizeof(*p4d) * 2),
> > +                              (u64)p4d_val(*p4d));
> 
> This (and the prints below) is gonna cause lots of broken output lines.
> You should use pr_cont() instead, and probably rebase on top of  my
> "[PATCH 7/7] sh: fault: Modernize printing of kernel messages"
> (https://lore.kernel.org/lkml/20191203162645.19950-8-geert+renesas@glider.be/).

Ok, will fix.	 

> > +
> > +               if (p4d_none(*p4d))
> > +                       break;
> > +
> > +               if (p4d_bad(*p4d)) {
> > +                       printk("(bad)");
> > +                       break;
> > +               }
> > +
> > +               pud = pud_offset(p4d, addr);
> >                 if (PTRS_PER_PUD != 1)
> >                         printk(", *pud=%0*Lx", (u32)(sizeof(*pud) * 2),
> >                                (u64)pud_val(*pud));
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

-- 
Sincerely yours,
Mike.
