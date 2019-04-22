Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD34C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC6320874
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 10:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555929297;
	bh=fEe9nS1ln5YRUUrmBJP8AmjoKpvGKmxNFN/J0FRAjx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P7R4tQtHcR0k0BJerCZep8AU7vkawds4n79k3eCFFabEPo/GvwIgEBIoAJbBjXRi8
	 8yAa8jWfOHEEFCibUaIjLUFWtfsPpW8ehyj1EieiwQ19as+v2hyHdzJrGYHxYPqeFt
	 rsIwLzxGF5pgNxwXLK4uUE7ehYoc8AGQwAYhgPqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfDVKez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:34:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54189 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfDVKez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 06:34:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so13923710wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 03:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyMQ+eyBXo2LZ4GuH7kHJyfZneSPy6Q384j2ybq1soc=;
        b=ZyozIE9FInXiUNKlwZfru+qlaypsIpOnn5VC3ZnDvPY4L6Cpcif1OB0iD2yxX8R74y
         eQ67n2Oa+lwANYt065QzvtS03Rq7fPxZpZGsI5TudvzDPRlUML5ZQDoYCaVWlzgcadB4
         xmSRzwjZcoCxJc8e12U1IenRbh+hbL2JLRp3QpYKpaXJ58RCHDxst5jJ7ozbQU5b0XJt
         9JnvLXePqrA2mLgyPPKlf4Uh+fRfHdtZg8rr3Xk5CGN1TAvlTJvTMaDAOB98911dWe39
         hldRPNac6jjKMMDx6eOk1DSPcfV7l1bFhLd0Qb2I4nsnVZKEx5ADdpo8PZym4EHR5wic
         l22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyMQ+eyBXo2LZ4GuH7kHJyfZneSPy6Q384j2ybq1soc=;
        b=YMkM04TuIB1Oh35EAr6aXtwi43GS+vhF+GAYmUztU42dLD2DnLnuKFnxMervgjwak7
         RE7e2q/WVcUhn3wX+UEOhEEz+BEUYa1mFs8yzVSd3JJurIY5JWBW5SMGDR01njQ87zOQ
         FBqLaJd3dn7G9Tqy7in463oTS5zvi44oO21xYzMkmTlAgtYEXw0LIbVBn0jP0teYem67
         oxfYqrFM2UmI+hn4l2Y1lk4vwkhTFSsRlMLdxd2TGFICx3F4GrmGom2ARMIu8lV4uhJL
         tNhe/QZvqRdtyVyf+UqYTBAz7bIBsr36uRQqPXihWo3EoY0agx1kc0xbNoSOR8rwlPtK
         KyZg==
X-Gm-Message-State: APjAAAWya//thYSS/WA3vbhNfua+QJBINKVAJes2pEBv31YNP1qL2SxM
        7UHNCWzEEeQkjmWfEsN5XoS6Dx1M
X-Google-Smtp-Source: APXvYqxbE1oA8h7LpdiOTZq2BFjGLGf5uGk0H046sA23WOMVesu7A4Cinrv2GFMay2aPjhFodjYZ/g==
X-Received: by 2002:a1c:7208:: with SMTP id n8mr12451725wmc.46.1555929293362;
        Mon, 22 Apr 2019 03:34:53 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id i17sm13060467wrs.44.2019.04.22.03.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 03:34:52 -0700 (PDT)
Date:   Mon, 22 Apr 2019 12:34:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190422103449.GA75723@gmail.com>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
 <20190421211007.GA30444@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190421211007.GA30444@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> > >> +++ b/arch/x86/kernel/task_size_64.c
> > >> @@ -0,0 +1,9 @@
> > >> +#include <linux/export.h>
> > >> +#include <linux/sched.h>
> > >> +#include <linux/thread_info.h>
> > >> +
> > >> +unsigned long _task_size(void)
> > >> +{
> > >> +	return test_thread_flag(TIF_ADDR32) ? IA32_PAGE_OFFSET :
> > >TASK_SIZE_MAX;
> > >> +}
> > >> +EXPORT_SYMBOL(_task_size);
> > >
> > >Good idea - but instead of adding yet another compilation unit, why not
> > >
> > >stick _task_size() into arch/x86/kernel/process_64.c, which is the 
> > >canonical place for process management related arch functions?
> > >
> > >Thanks,
> > >
> > >	Ingo
> > 
> > Better yet... since TIF_ADDR32 isn't something that changes randomly, 
> > perhaps this should be a separate variable?
> 
> Maybe. I only thought about putting every 32-bit related flag under 
> CONFIG_COMPAT to further eradicate bloat (and force everyone else to 
> keep an eye on it, ha-ha).

Basically TIF_ADDR32 is only set for a task if set_personality_ia32() is 
called, which function is called in the following circumstances:

 - arch/x86/ia32/ia32_aout.c:load_aout_binary()

   This is in exec(), when a new binary is loaded for the current task, 
   via search_binary_handler() and exec_binprm(). Ordering is 
   synchronous, AFAICS there can be no race between TASK_SIZE users and 
   the set_personality_ia32() call which is always for the current task.

 - in COMPAT_SET_PERSONALITY(), which through macro detours ends up being 
   in SET_PERSONALITY2(), which is used in fs/compat_binfmt_elf.c's 
   load_elf_binary(), used in a similar fashion in exec() as the AOUT 
   case above. One particular macro detour of note is that 
   fs/compat_binfmt_elf.c #includes fs/binfmt_elf.c and re-defines the 
   personality setting method to map to set_personality_ia32().

When set_personality_ia32() is called then TIF_ADDR32 is set 
unconditionally, without any Kconfig variations.

TIF_ADDR32 is cleared:

 - In set_personality_64bit(), when a 64-bit binary is loaded via 
   fs/binfmt_elf.c.

 - It also defaults to clear in the init task, which is inherited by the 
   initial kernel threads and any user-space task they might end up 
   executing.

So the conclusion is that IMO we can safely put TASK_SIZE into a new 
thread_info()->task_size field, and:

 - change ->task_size to the 32-bit address space in 
   set_personality_ia32()

 - change ->task_size to teh 64-bit address space in the init task and in 
   set_personality_64bit().

This should cover it I think, unless I missed something.

Thanks,

	Ingo
