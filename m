Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6195C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C98242E7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+UGu35r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfE2XA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:00:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42023 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2XA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:00:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id 33so751265pgv.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mZDm1kAKgU0IhEGbB++jzmktRAbr4Q0cIPFXqDEyagM=;
        b=A+UGu35rAnrltsa65R7VI1+bvaLfoGq5ejnoxdsD3zYpAcgF2pfHPSObDmbmOWfteh
         41QdlFgg7R3pRwbx2xtJi0B+k27nu/g2/BqQStCoemBh8HKxCuPZeiL7cQd1W0Ryxtgy
         knRcGmMBGQdYM2+CUA5H6fwPt7UoApSYMspWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mZDm1kAKgU0IhEGbB++jzmktRAbr4Q0cIPFXqDEyagM=;
        b=J/WTlvY3IkF5mf2Ph87toQOvOpBhaoukwHjyu/hwGC30ZcN6OFbq5Mi1s417Zy7MLY
         RjdYAIOQlurxdPPlx7jnncUF8H7K92xe5yLuSxlmWnYEPc3akNo7Z9gTRSWN9OZ2irEB
         LUGGkoQJbkb5mBOqwYNcSDIAtL5K4ZTVronb0mhOe0f3bsXTpGmKxAeZEvtUdywERDbi
         4ssdtDT64WAfTwpYhwQQXW5sVvV2pHqroaEiAYc7Da8ldl6V5QeacjFh5IksB6yHnuFk
         lh8A29Otf7UzZL8QLvlBsVytiDLl2J5DCoH9OuloiLctnkqTicuCl+2J0eFW3LlbgnWt
         EDrA==
X-Gm-Message-State: APjAAAVlw6LwZAF9HXtH4AWDgVSC+tYZH1bL7h0+wdozoHOGTVEGhkPY
        LXzwbUnY0RexDTK7Fi0nLTmXrw==
X-Google-Smtp-Source: APXvYqxBsGzFdEFFHE9ZZiZzg2iQiXe5Qj3DcWZv7aDHSpfnAhwMXj2Rx0f/hyPuR7+Z9T3sjOH5Pg==
X-Received: by 2002:a62:2b82:: with SMTP id r124mr102112pfr.235.1559170825907;
        Wed, 29 May 2019 16:00:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm769994pfo.8.2019.05.29.16.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 16:00:25 -0700 (PDT)
Date:   Wed, 29 May 2019 16:00:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <201905291559.87E96F79@keescook>
References: <20190529213708.GA10729@avx2>
 <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529152020.c9d0ed1c6194328f751fe0f9@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 03:20:20PM -0700, Andrew Morton wrote:
> On Thu, 30 May 2019 00:37:08 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > AT_RANDOM content is always misaligned on x86_64:
> > 
> > 	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
> > 	AT_RANDOM:       0x7fff02101019
> > 
> > glibc copies first few bytes for stack protector stuff, aligned
> > access should be slightly faster.
> 
> I just don't understand the implications of this.  Is there
> (badly-behaved) userspace out there which makes assumptions about the
> current alignment?
> 
> How much faster, anyway?  How frequently is the AT_RANDOM record
> accessed?
> 
> I often have questions such as these about your performance/space
> tweaks :(.  Please try to address them as a matter of course when
> preparing changelogs?
> 
> And let's Cc Kees, who wrote the thing.
> 
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
> >  #define STACK_ALLOC(sp, len) ({ \
> >  	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
> >  	old_sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))
> 
> I suspect plain old ALIGN() could be used here.
> 
> >  #else
> >  #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
> >  #define STACK_ROUND(sp, items) \
> >  	(((unsigned long) (sp - items)) &~ 15UL)
> >  #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
> > +#define STACK_ALIGN(sp, align)	\
> > +	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))
> 
> And maybe there's a helper which does this, dunno.
> 
> >  #endif
> >  
> >  #ifndef ELF_BASE_PLATFORM
> > @@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
> >  			return -EFAULT;
> >  	}
> >  
> > +	/*
> > +	 * glibc copies first bytes for stack protector purposes
> > +	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
> > +	 */
> > +	p = STACK_ALIGN(p, sizeof(long));
> > +

I have no objection to eating some bytes here. Though perhaps things could just
be reordered to leave all the aligned things together and put all the
strings later?

-Kees

> >  	/*
> >  	 * Generate 16 random bytes for userspace PRNG seeding.
> >  	 */
> 

-- 
Kees Cook
