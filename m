Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF41C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4691D204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfDVT4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:56:17 -0400
Received: from verein.lst.de ([213.95.11.211]:41760 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731024AbfDVT4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:56:12 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7ABF068AFE; Mon, 22 Apr 2019 21:55:57 +0200 (CEST)
Date:   Mon, 22 Apr 2019 21:55:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alex Ghiti <alex@ghiti.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions
 to mm
Message-ID: <20190422195556.GD2224@lst.de>
References: <20190417052247.17809-1-alex@ghiti.fr> <20190417052247.17809-5-alex@ghiti.fr> <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com> <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr> <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:19:18AM -0500, Kees Cook wrote:
> On Thu, Apr 18, 2019 at 12:55 AM Alex Ghiti <alex@ghiti.fr> wrote:
> > Regarding the help text, I agree that it does not seem to be frequent to
> > place
> > comment above config like that, I'll let Christoph and you decide what's
> > best. And I'll
> > add the possibility for the arch to define its own STACK_RND_MASK.
> 
> Yeah, I think it's very helpful to spell out the requirements for new
> architectures with these kinds of features in the help text (see
> SECCOMP_FILTER for example).

Spelling out the requirements sounds useful.  Abusing the help text
for an option for which no help text can be displayed it pointless.
Just make it a comment as Alex did in this patch, which makes whole
lot more sense.

> > Actually, I had to add those ifdefs for mmap_rnd_compat_bits, not
> > is_compat_task.
> 
> Oh! In that case, use CONFIG_HAVE_ARCH_MMAP_RND_BITS. :) Actually,
> what would be maybe cleaner would be to add mmap_rnd_bits_min/max
> consts set to 0 for the non-CONFIG_HAVE_ARCH_MMAP_RND_BITS case at the
> top of mm/mmap.c.

Lets do that in a second step.  The current series is already big
enough and a major improvement, even if there is much more to clean
up in this area still left.
