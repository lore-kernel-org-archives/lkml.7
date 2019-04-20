Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81336C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4799D20869
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 18:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLsb1on9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfDTSHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 14:07:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39526 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDTSHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 14:07:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so10725514wrn.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Apr 2019 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9NCEKRpKtMAUr/xc+h4+drpVDa6LkJhk/hQz5HsPRuU=;
        b=aLsb1on9gu+tQL6FDE/ytMxiKJI1kMbMP3nUqghtD3gBBKow8LKzGw2gnAmlut2mSE
         e8ES7tlj4YPOJKBDPE9cFtwxpqN4XCQpCU/QvycIJEfx9z8YMJy6BNvXHboclJYPnZUo
         m1ME+1vcugWXEyTi1azQJ7EFBEZ0a5KDQ3CsD0v5yqMZAtr5eWSQdBXI/jRh+JH76FRC
         yCgded6AhwQKiNCpyjY5VMVijslmfjrmC2YU1fzL/ZOIvUOZK5og1+LvQM4wgIZHM6ch
         GrvIQ/o7fELXSmtmclhoDclJPWD7FUHgnwa1J/C+9dNesYBhddK/Uv6ccbmtxvTX+TU9
         RtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9NCEKRpKtMAUr/xc+h4+drpVDa6LkJhk/hQz5HsPRuU=;
        b=VFpO5ApaDaMyK+rsLTBF+8f7CiMGYAcuMiD7ERpnSQOEBA+hDwOYv43nbb4+CINXNC
         4H/X4bB2rq3HfxEIYdZnD3LhO8sWQyeoqES8pw7uYxFsuwT72ethsNy4ZQGJoGYkv0p9
         zOiJ8yRy11dXkUKgP30OoRavDYs+bqK+HXrS9/dWe/RYV614zQrb2cEX36zTKjfZSq4m
         9wNYYdkuGM9n7gZjYG25lFxL0mo0UWzohdCrXIPETKFZW/s2EZJ9nrKP2w7uM67QWivP
         HnUf5CTvyhOAkjijji1+Et58NdQjj13PCX8I1CiNPh487MeEl3zNWVZaMDf6nyHqwWD/
         NEJA==
X-Gm-Message-State: APjAAAVOSDPM/5JTjoW+HYoZixG5Qp3eKsAXp0Ya8Qwc9CmLWyebRPjj
        Ql8WlS281QOtgiynqUF592hBjhY=
X-Google-Smtp-Source: APXvYqwur2sZdhivWFRZUtHjFLEZmI4iwIJ0hAmISh+6NPqmfuB1cn1BjYFT9dRmZ8B6LvwakEAACQ==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr1384517wrr.36.1555783626444;
        Sat, 20 Apr 2019 11:07:06 -0700 (PDT)
Received: from avx2 ([46.53.246.164])
        by smtp.gmail.com with ESMTPSA id v14sm8214758wrr.20.2019.04.20.11.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 11:07:05 -0700 (PDT)
Date:   Sat, 20 Apr 2019 21:07:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] elf: init pt_regs pointer later
Message-ID: <20190420180703.GA30184@avx2>
References: <20190419200343.GA19788@avx2>
 <20190419130826.849441bb8f526c9defcb1c0f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190419130826.849441bb8f526c9defcb1c0f@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 01:08:26PM -0700, Andrew Morton wrote:
> On Fri, 19 Apr 2019 23:03:43 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Get "current_pt_regs" pointer right before usage.
> > 
> > Space savings on x86_64:
> > 
> > 	add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-180 (-180)
> > 	Function                           old     new   delta
> > 	load_elf_binary                   5806    5626    -180 !!!
> 
> -256 bytes with my setup.
> 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -704,12 +704,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  	unsigned long start_code, end_code, start_data, end_data;
> >  	unsigned long reloc_func_desc __maybe_unused = 0;
> >  	int executable_stack = EXSTACK_DEFAULT;
> > -	struct pt_regs *regs = current_pt_regs();
> >  	struct {
> >  		struct elfhdr elf_ex;
> >  		struct elfhdr interp_elf_ex;
> >  	} *loc;
> >  	struct arch_elf_state arch_state = INIT_ARCH_ELF_STATE;
> > +	struct pt_regs *regs;
> >  
> >  	loc = kmalloc(sizeof(*loc), GFP_KERNEL);
> >  	if (!loc) {
> > @@ -1159,6 +1159,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  				MAP_FIXED | MAP_PRIVATE, 0);
> >  	}
> >  
> > +	regs = current_pt_regs();
> >  #ifdef ELF_PLAT_INIT
> >  	/*
> >  	 * The ABI may specify that certain registers be set up in special
> 
> Why the heck does this make such a difference?

Good question. Looks like compiler doesn't know that "current_pt_regs" is
stable pointer (because it doesn't know ->stack isn't) even though it knows
that "current" is stable pointer. So it saves it in the very beginning and
then tries to carry it through a lot of code.

Here is what happens here:

load_elf_binary()
		...
	mov	rax,QWORD PTR gs:0x14c00
	mov	r13,QWORD PTR [rax+0x18]	r13 = current->stack
	call	kmem_cache_alloc		# first kmalloc

		[980 bytes later!]

	# let's spill that sucker because we need a register
	# for "load_bias" calculations at
	#
	#	if (interpreter) {
	#		load_bias = ELF_ET_DYN_BASE;
	#		if (current->flags & PF_RANDOMIZE)
	#			load_bias += arch_mmap_rnd();
	#		elf_flags |= elf_fixed;
	#	}
	mov	QWORD PTR [rsp+0x68],r13

If this is not _the_ root cause it is still eeeeh.

After the patch things become much simpler:

	mov	rax, QWORD PTR gs:0x14c00	# current
	mov	rdx, QWORD PTR [rax+0x18]	# current->stack
	movq	[rdx+0x3fb8], 0			# fill pt_regs
		...
	call finalize_exec
