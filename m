Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B94C2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554891460;
	bh=39p7kXFH6WH93ric1Nly8BotdbxU7gMU3kKP932nF2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T1/L44V6vMPnzJWX+QEMq18m3SoOMYLsSmM+Uv4Em8ktuijmZnz7GSs20XzYkLmlG
	 4n0QSUO3O2tjLbb0MlWzsnYVJYlA2x6lBmz8jEBvEY94zy6QeXpO+sqjOIAVQbmb6S
	 o7xK5r9sETclWKMloIe/i6tTNZZu//fi6IhbQqYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbfDJKRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:17:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40465 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbfDJKRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:17:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id z24so1945894wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 03:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4sO5jSiscab6IaiP75ZeySxkFtk5f5b4dfSwAIMkONM=;
        b=PTLuQ7HgBARvaWNrY6ivwaWNdG4A4RWAqS6Qc0KplUPBo8Vdg9R0NpfVvgbccdjfXh
         BBVrdh+7yw+ofVVFSO4C731mMbRq+Ty0nxsOz3LdBdzpFynQnYrAp94o/SNa/jIVI/u0
         q/PXGXIzqHW6lOyqwFcGN5Al8iAkPvqGtb68f/4+fgZJlWCzRMkqN5pyUkSPoEGQGgbq
         Ig40LjOIbrvK6mcNAoUy3FWqG9wbR5MMu2nRD3vhaScczfvRJGtcw+ClV0C/xrsqFuLS
         EkY0N3vRSwrhB0RCvPoGM8CSeO5zD1HpptIoWOHCjDPWqGCJ9zPN1j++quh7eGulmPsO
         fVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4sO5jSiscab6IaiP75ZeySxkFtk5f5b4dfSwAIMkONM=;
        b=dbZB8ofOQwPePikBs9CqNNDEHK/Jpyle9n2oB+GSlnFi/oejz9BxqEle/RxaP5jg/Y
         zBEJbhY0p07sOZgDWABQasXHuxoBc1RFKczpbNtq0TbY7kn62RcmmwV4E/K9Mk6pWwlh
         z+M7xKbLddQi8CKX2HY4D8g849GUeqjBkgZGuewnhwsrEgC3FyqdYlcBdGbbDKJQBBqU
         YavXb1nUhVVysPjZQYoLpLU0gTuYXbMCF+pSaqGAjljj2hYwfT6XnKApY0yTGOuvoFhm
         4pK4WzoWm/leqjBgkCH8bXhgn0ddqn5GFMZw1rfCIwdn3iYsfGk72T/NhXgsNXbyD+an
         KLVg==
X-Gm-Message-State: APjAAAXxj/zWlBdp6WnqpjCGTh/Sv/j9YUm6KrtP/WF7OVSxXtf7IwL1
        p5e+/7ytkOJqUl+ipJ79d9w=
X-Google-Smtp-Source: APXvYqx5Y1sT/1A2nFj5qee3w5UXYyEYbUViY+/Z2xmIWeFPbBnVMlQ12zs9I5Wk7U3xXHZwxHwuaA==
X-Received: by 2002:a1c:7512:: with SMTP id o18mr2334730wmc.68.1554891456274;
        Wed, 10 Apr 2019 03:17:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id u17sm1933713wmj.1.2019.04.10.03.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 03:17:35 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:17:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190410101733.GA2045@gmail.com>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble>
 <20190410082642.GA35032@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Reshetova, Elena <elena.reshetova@intel.com> wrote:

> > * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> > > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > > > index 7bc105f47d21..38ddc213a5e9 100644
> > > > --- a/arch/x86/entry/common.c
> > > > +++ b/arch/x86/entry/common.c
> > > > @@ -35,6 +35,12 @@
> > > >  #define CREATE_TRACE_POINTS
> > > >  #include <trace/events/syscalls.h>
> > > >
> > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > +#include <linux/random.h>
> > > > +
> > > > +void *alloca(size_t size);
> > > > +#endif
> > > > +
> > > >  #ifdef CONFIG_CONTEXT_TRACKING
> > > >  /* Called on entry from user mode with IRQs off. */
> > > >  __visible inline void enter_from_user_mode(void)
> > > > @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr, struct
> > pt_regs *regs)
> > > >  {
> > > >  	struct thread_info *ti;
> > > >
> > > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > > +	size_t offset = ((size_t)prandom_u32()) % 256;
> > > > +	char *ptr = alloca(offset);
> > > > +
> > > > +	asm volatile("":"=m"(*ptr));
> > > > +#endif
> > > > +
> > > >  	enter_from_user_mode();
> > > >  	local_irq_enable();
> > > >  	ti = current_thread_info();
> > >
> > > Would it make sense to also do this for the compat syscalls
> > > (do_fast_syscall_32, do_int80_syscall_32)?
> > 
> > Could someone please include the full patch, with justification and
> > performance impact analysis etc.? Can only find the code part of the
> > thread on lkml, which leaves out this context.
> > 
> 
> Sorry, this is very weird, I cannot find it either from lkml, but it was sent there
> to begin with (and as visible from reply-to headers).
> 
> Do you want me to resent original version or with "do_fast_syscall_32,
> do_int80_syscall_32" additions (I am finishing testing them now).

The original patch would be fine to me, was missing the context.

Thanks,

	Ingo
