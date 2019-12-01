Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6DBC432C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C3520748
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaVjFLhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfLAQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:09:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35140 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLAQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:09:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id r15so23096118lff.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2019 08:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=eEAJr7YoKlHMv0ni1EPxl1Ancl/NFctZGAvD6eEs7O8=;
        b=EaVjFLhOM+kZ2hk5aB41KTk/TwOn2rT9SrjrnSJ1oJSPvmEdkhzQfYOUbf7HXA4h6/
         2+OzxQOEHBtmHmM0RyBrMntuJmO/mG1jHmHqiwY6peonqLYNj1c5EaMEd86x4CAvwCUr
         vTcpyT2eBi8F7KsliSVSWhSv4FmSxGLUP9lFSHEAbPBrcpZtSZN2rRq+Iu9hmPnIcs69
         mDZetBmwgSz+ZDd6yDna1Y5DINcZcXibOFrvBCAurz+9OQj6U48Nuhne4HVB1yWyXiv1
         Zua2IV77hN6qi5OgHbeixQgfJ5PghV/wpHKv6dnPrp7sfoyhKrnF4vUqtIr0Rrl69qxP
         9kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=eEAJr7YoKlHMv0ni1EPxl1Ancl/NFctZGAvD6eEs7O8=;
        b=axOYVF4eS8QJ/KMQ9aXoZyCjCyCWQH2MP21VqbArkLFnjQCTuR3mOzkSDdkcAM7heP
         9asR4C4SruLU0xmEHmB9yC78UjzFaX07TiOf5eDrirR9g9OrSVDQff3mCq6iQMLHV3cr
         FfqtzrYDIm5mLnyfRzA5HfpaJlb8E667pVKj4Rw63mxZxYUW/3XvJl3BXFt7w09wqW74
         IHiAl553DZv2XGHR4ACoovoDZecFEfYukU/wWMlErdpzCSPXOwTiglySCOD4+VZE+2p1
         CXxO+ELlBJo/AS3IpVDbUFs5yqfvAYPnQAg+RDs7FA94GGJ/wzJ0GJcDQlv+sup6TGNa
         owHg==
X-Gm-Message-State: APjAAAVvRztXL6WRktHoUx7f0+UPtLFtI6SErcjaKOGter6IaE4Jujw9
        LrJI7AGztLSkK0Wace/JUz4g/11DL66B7eQPSSI=
X-Google-Smtp-Source: APXvYqwPUStU4RhtTXFRl0BTXcLJgsDV2RouaPvX8I4KI24qHk5lQqYgnIpfjFKu3EBzHBp+RVigZ+uwqIUJq+af2xg=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr11697344lfh.102.1575216563754;
 Sun, 01 Dec 2019 08:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20191127005312.GD20422@shao2-debian> <CAJTyqKPstH9PYk1nMuRJWnXUPTf9wAkphPFi9Yfz6PApLVVE0Q@mail.gmail.com>
 <20191130212729.ykxstm5kj2p5ir6q@linux-p48b> <CAJTyqKOp+mV1CfpasschSDO4vEDbshE4GPCB6+aX4rJOYSF=7A@mail.gmail.com>
 <CAHk-=wh--xwpatv_Rcp3WtCPQtg-RVoXYQj8O+1TSw8os7Jtvw@mail.gmail.com>
 <20191201104624.GA51279@gmail.com> <20191201144947.GA4167@gmail.com>
In-Reply-To: <20191201144947.GA4167@gmail.com>
Reply-To: mceier@gmail.com
From:   Mariusz Ceier <mceier@gmail.com>
Date:   Sun, 1 Dec 2019 16:09:12 +0000
Message-ID: <CAJTyqKPUhQR_DjSkMs3s9YSWA-tQXQvtnLqzxF353W9nnQ2cLw@mail.gmail.com>
Subject: Re: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <rong.a.chen@intel.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Kenneth R. Crudup" <kenny@panix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch fixes performance issue on my system and afterwards
/sys/kernel/debug/x86/pat_memtype_list contents are:

PAT memtype list:
write-back @ 0x55ba4000-0x55ba5000
write-back @ 0x5e88c000-0x5e8b5000
write-back @ 0x5e8b4000-0x5e8b5000
write-back @ 0x5e8b4000-0x5e8b8000
write-back @ 0x5e8b7000-0x5e8bb000
write-back @ 0x5e8ba000-0x5e8bc000
write-back @ 0x5e8bb000-0x5e8be000
write-back @ 0x5e8bd000-0x5e8bf000
write-back @ 0x5e8be000-0x5e8c2000
write-back @ 0x5ef3c000-0x5ef3d000
write-back @ 0x5ef6c000-0x5ef6d000
write-back @ 0x5ef6f000-0x5ef70000
write-back @ 0x5ef72000-0x5ef73000
write-back @ 0x5f5b3000-0x5f5b5000
uncached-minus @ 0xe3f00000-0xe3f10000
uncached-minus @ 0xec000000-0xec040000
uncached-minus @ 0xec002000-0xec003000
uncached-minus @ 0xec110000-0xec111000
uncached-minus @ 0xec200000-0xec240000
uncached-minus @ 0xec260000-0xec264000
uncached-minus @ 0xec300000-0xec320000
uncached-minus @ 0xec326000-0xec327000
uncached-minus @ 0xf0000000-0xf8000000
uncached-minus @ 0xf0000000-0xf0001000
uncached-minus @ 0xfdc43000-0xfdc44000
uncached-minus @ 0xfe000000-0xfe001000
uncached-minus @ 0xfed00000-0xfed01000
uncached-minus @ 0xfed10000-0xfed16000
uncached-minus @ 0xfed90000-0xfed91000
write-combining @ 0x2000000000-0x2100000000
write-combining @ 0x2000000000-0x2100000000
uncached-minus @ 0x2100000000-0x2100001000
uncached-minus @ 0x2100001000-0x2100002000
uncached-minus @ 0x2ffff10000-0x2ffff20000
uncached-minus @ 0x2ffff20000-0x2ffff24000

It's very similar to pat_memtype_list contents after reverting 4
x86/mm/pat patches affecting performance:

@@ -1,8 +1,8 @@
 PAT memtype list:
 write-back @ 0x55ba4000-0x55ba5000
 write-back @ 0x5e88c000-0x5e8b5000
-write-back @ 0x5e8b4000-0x5e8b8000
 write-back @ 0x5e8b4000-0x5e8b5000
+write-back @ 0x5e8b4000-0x5e8b8000
 write-back @ 0x5e8b7000-0x5e8bb000
 write-back @ 0x5e8ba000-0x5e8bc000
 write-back @ 0x5e8bb000-0x5e8be000
@@ -21,8 +21,8 @@
 uncached-minus @ 0xec260000-0xec264000
 uncached-minus @ 0xec300000-0xec320000
 uncached-minus @ 0xec326000-0xec327000
-uncached-minus @ 0xf0000000-0xf0001000
 uncached-minus @ 0xf0000000-0xf8000000
+uncached-minus @ 0xf0000000-0xf0001000
 uncached-minus @ 0xfdc43000-0xfdc44000
 uncached-minus @ 0xfe000000-0xfe001000
 uncached-minus @ 0xfed00000-0xfed01000

Best regards,
Mariusz Ceier

On Sun, 1 Dec 2019 at 14:49, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ingo Molnar <mingo@kernel.org> wrote:
>
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > > But the final difference is a real difference where it used to be WC,
> > > and is now UC-:
> > >
> > >     -write-combining @ 0x2000000000-0x2100000000
> > >     -write-combining @ 0x2000000000-0x2100000000
> > >     +uncached-minus @ 0x2000000000-0x2100000000
> > >     +uncached-minus @ 0x2000000000-0x2100000000
> > >
> > > which certainly could easily explain the huge performance degradation.
>
> > It's not an unconditional regression, as both Boris and me tried to
> > reproduce it on different systems that do ioremap_wc() as well and didn't
> > measure a slowdown, but something about the memory layout probably
> > triggers the tree management bug.
>
> Ok, I think I found at least one bug in the new PAT code, the conversion
> of memtype_check_conflict() is buggy I think:
>
>    8d04a5f97a5f: ("x86/mm/pat: Convert the PAT tree to a generic interval tree")
>
>         dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
>         found_type = match->type;
>
> -       node = rb_next(&match->rb);
> -       while (node) {
> -               match = rb_entry(node, struct memtype, rb);
> -
> -               if (match->start >= end) /* Checked all possible matches */
> -                       goto success;
> -
> -               if (is_node_overlap(match, start, end) &&
> -                   match->type != found_type) {
> +       match = memtype_interval_iter_next(match, start, end);
> +       while (match) {
> +               if (match->type != found_type)
>                         goto failure;
> -               }
>
> -               node = rb_next(&match->rb);
> +               match = memtype_interval_iter_next(match, start, end);
>         }
>
>
> Note how the '>= end' condition to end the interval check, got converted
> into:
>
> +       match = memtype_interval_iter_next(match, start, end);
>
> This is subtly off by one, because the interval trees interfaces require
> closed interval parameters:
>
>   include/linux/interval_tree_generic.h
>
>  /*                                                                            \
>   * Iterate over intervals intersecting [start;last]                           \
>   *                                                                            \
>   * Note that a node's interval intersects [start;last] iff:                   \
>   *   Cond1: ITSTART(node) <= last                                             \
>   * and                                                                        \
>   *   Cond2: start <= ITLAST(node)                                             \
>   */                                                                           \
>
>   ...
>
>                 if (ITSTART(node) <= last) {            /* Cond1 */           \
>                         if (start <= ITLAST(node))      /* Cond2 */           \
>                                 return node;    /* node is leftmost match */  \
>
> [start;last] is a closed interval (note that '<= last' check) - while the
> PAT 'end' parameter is 1 byte beyond the end of the range, because
> ioremap() and the other mapping APIs usually use the [start,end)
> half-open interval, derived from 'size'.
>
> This is what ioremap() does for example:
>
>         /*
>          * Mappings have to be page-aligned
>          */
>         offset = phys_addr & ~PAGE_MASK;
>         phys_addr &= PHYSICAL_PAGE_MASK;
>         size = PAGE_ALIGN(last_addr+1) - phys_addr;
>
>         retval = reserve_memtype(phys_addr, (u64)phys_addr + size,
>                                                 pcm, &new_pcm);
>
>
> phys_addr+size will be on a page boundary, after the last byte of the
> mapped interval.
>
> So the correct parameter to use in the interval tree searches is not
> 'end' but 'end-1'.
>
> This could have relevance if conflicting PAT ranges are exactly adjacent,
> for example a future WC region is followed immediately by an already
> mapped UC- region - in this case memtype_check_conflict() would
> incorrectly deny the WC memtype region and downgrade the memtype to UC-.
>
> BTW., rather annoyingly this downgrading is done silently in
> memtype_check_insert():
>
> int memtype_check_insert(struct memtype *new,
>                          enum page_cache_mode *ret_type)
> {
>         int err = 0;
>
>         err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
>         if (err)
>                 return err;
>
>         if (ret_type)
>                 new->type = *ret_type;
>
>         memtype_interval_insert(new, &memtype_rbroot);
>         return 0;
> }
>
>
> So on such a conflict we'd just silently get UC- in *ret_type, and write
> it into the new region, never the wiser ...
>
> So assuming that the patch below fixes the primary bug the diagnostics
> side of ioremap() cache attribute downgrades would be another thing to
> fix.
>
> Anyway, I checked all the interval-tree iterations, and most of them are
> off by one - but I think the one related to memtype_check_conflict() is
> the one causing this particular performance regression.
>
> The only correct interval-tree searches were these two:
>
> arch/x86/mm/pat_interval.c:     match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
> arch/x86/mm/pat_interval.c:             match = memtype_interval_iter_next(match, 0, ULONG_MAX);
>
> The ULONG_MAX was hiding the off-by-one in plain sight. :-)
>
> So it would be nice if everyone who is seeing this bug could test the
> patch below against Linus's latest tree - does it fix the regression?
>
> If not then please send the before/after dump of
> /sys/kernel/debug/x86/pat_memtype_list - and even if it works please send
> the dumps so we can double check it all.
>
> Note that the bug was benign in the sense of implementing a too strict
> cache attribute conflict policy and downgrading cache attributes - so
> AFAICS the worst outcome of this bug would be a performance regression.
>
> Patch is only lightly tested, so take care. (Patch is emphatically not
> signed off yet, because I spent most of the day on this and I don't yet
> trust my fix - all of the affected sites need to be reviewed more
> carefully.)
>
> Thanks,
>
>         Ingo
>
>
> ====================>
> From: Ingo Molnar <mingo@kernel.org>
> Date: Sun, 1 Dec 2019 15:25:50 +0100
> Subject: [PATCH] x86/pat: Fix off-by-one bugs in interval tree search
>
> NOT-Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/x86/mm/pat_interval.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
> index 47a1bf30748f..6855362eaf21 100644
> --- a/arch/x86/mm/pat_interval.c
> +++ b/arch/x86/mm/pat_interval.c
> @@ -56,7 +56,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
>  {
>         struct memtype *match;
>
> -       match = memtype_interval_iter_first(&memtype_rbroot, start, end);
> +       match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
>         while (match != NULL && match->start < end) {
>                 if ((match_type == MEMTYPE_EXACT_MATCH) &&
>                     (match->start == start) && (match->end == end))
> @@ -66,7 +66,7 @@ static struct memtype *memtype_match(u64 start, u64 end, int match_type)
>                     (match->start < start) && (match->end == end))
>                         return match;
>
> -               match = memtype_interval_iter_next(match, start, end);
> +               match = memtype_interval_iter_next(match, start, end-1);
>         }
>
>         return NULL; /* Returns NULL if there is no match */
> @@ -79,7 +79,7 @@ static int memtype_check_conflict(u64 start, u64 end,
>         struct memtype *match;
>         enum page_cache_mode found_type = reqtype;
>
> -       match = memtype_interval_iter_first(&memtype_rbroot, start, end);
> +       match = memtype_interval_iter_first(&memtype_rbroot, start, end-1);
>         if (match == NULL)
>                 goto success;
>
> @@ -89,12 +89,12 @@ static int memtype_check_conflict(u64 start, u64 end,
>         dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
>         found_type = match->type;
>
> -       match = memtype_interval_iter_next(match, start, end);
> +       match = memtype_interval_iter_next(match, start, end-1);
>         while (match) {
>                 if (match->type != found_type)
>                         goto failure;
>
> -               match = memtype_interval_iter_next(match, start, end);
> +               match = memtype_interval_iter_next(match, start, end-1);
>         }
>  success:
>         if (newtype)
> @@ -160,7 +160,7 @@ struct memtype *memtype_erase(u64 start, u64 end)
>  struct memtype *memtype_lookup(u64 addr)
>  {
>         return memtype_interval_iter_first(&memtype_rbroot, addr,
> -                                          addr + PAGE_SIZE);
> +                                          addr + PAGE_SIZE-1);
>  }
>
>  #if defined(CONFIG_DEBUG_FS)
