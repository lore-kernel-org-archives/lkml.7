Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13BC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E65206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554884809;
	bh=3kRCoHzwYAssjJT5pw/w57LtFwHIbEzX5fO6B+FoD3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s6CDgwFzYOYGMSEwvKhLcNJMjLtQ12BwbYV3bkp83BXk2JUxEGv96PRPwfk1lCuYv
	 9HTub1wMfcBtJvGfpOeuBztr5zmx0dTX1K3pV4aq+be6c0UPVHgVqp+G/fgdVFzUE4
	 tx300rrOd/6/JaCYIztn9xBPdyK6GIgx2Ss2K2OE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbfDJI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:26:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35430 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfDJI0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:26:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so1839976wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 01:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOU27czn01LbyzXwVx1HPcV0VNtC4qKCAIF9uxXqZEM=;
        b=u/m6PwRXiYW+eyViXv5GxQjrumSTgw9wtD8JjUTntA4WgmSrf4mtyv1Ka6uvmDKT8G
         5Ubp7iarTSS9LbOhGssnvLs/j30IDCG10RzWeH2Jq+3j0NlgOqV9einAWtIIvIoyPZir
         g7JoA4Tm9K+gSRa8j7vnMxon0WzMwjC33IWOH4UPk968i+2gubjbsbuPOKqw42mLw1Ez
         XbQjccBDG3Gk6LIUVo+S6c3ENYd67ZkmlQBfbcgAm02f4pemNzCOLROwHO7miw63gwby
         p08+DM9832mmjO2BxbnHITP1LGs92Y2nh9DCU426oHzth+UKY/RWL5fPwbLfen7maoE2
         bB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOU27czn01LbyzXwVx1HPcV0VNtC4qKCAIF9uxXqZEM=;
        b=WIEZVManOpfA1NkNqWw6YueP/e3Dxx1pEwnLXMvJlmS0+hZ6RLxrtTExgEWgp7aixc
         ga9k/NgNv7I+Soh0hcNbPKWA5Hce4PdsjWqtHOA8ZtB+Y//5QoIctU1jwlrd4q9Bd51s
         Z42RZEIoUVhWV9OrUT28f7BHXAEBdaZUin0c1LV+sAhWG7qW+82+NzIgwsqqaFEB12Sq
         R5m1fnv4y2+oPtrXkb9+ItdvsoSsSWKilvQVKHk8Nuuza+sUKtrZDhY6o5u47FQGDIb9
         HTsjwJhIdKWbBE4Tme8ErW41cZqjxqS+cpxcNIRqXBE5+ZO52RSL9K5PijNdqChnbQZj
         MeLQ==
X-Gm-Message-State: APjAAAUHCD7teRWIdyh6/uqkTyPkoFf4vCFWCXvvbK1UAuRB9ETqAflE
        xWsxkI/aQqDZKQRjfCL+wsY=
X-Google-Smtp-Source: APXvYqx1HcYTY0wQ08zFq7/cHZfayXC33/b7ed4q01ajd89NQPdAlDc5tgUsGn595YEU+1GQJV1Azg==
X-Received: by 2002:a5d:69c7:: with SMTP id s7mr25723233wrw.71.1554884806043;
        Wed, 10 Apr 2019 01:26:46 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z63sm2174316wme.30.2019.04.10.01.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 01:26:44 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:26:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Elena Reshetova <elena.reshetova@intel.com>, luto@kernel.org,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        keescook@chromium.org, jannh@google.com, enrico.perla@intel.com,
        mingo@redhat.com, bp@alien8.de, tglx@linutronix.de,
        peterz@infradead.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Message-ID: <20190410082642.GA35032@gmail.com>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408124940.hb4d2mvwue7aydjj@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > index 7bc105f47d21..38ddc213a5e9 100644
> > --- a/arch/x86/entry/common.c
> > +++ b/arch/x86/entry/common.c
> > @@ -35,6 +35,12 @@
> >  #define CREATE_TRACE_POINTS
> >  #include <trace/events/syscalls.h>
> >  
> > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > +#include <linux/random.h>
> > +
> > +void *alloca(size_t size);
> > +#endif
> > +
> >  #ifdef CONFIG_CONTEXT_TRACKING
> >  /* Called on entry from user mode with IRQs off. */
> >  __visible inline void enter_from_user_mode(void)
> > @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
> >  {
> >  	struct thread_info *ti;
> >  
> > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > +	size_t offset = ((size_t)prandom_u32()) % 256;
> > +	char *ptr = alloca(offset);
> > +
> > +	asm volatile("":"=m"(*ptr));
> > +#endif
> > +
> >  	enter_from_user_mode();
> >  	local_irq_enable();
> >  	ti = current_thread_info();
> 
> Would it make sense to also do this for the compat syscalls
> (do_fast_syscall_32, do_int80_syscall_32)?

Could someone please include the full patch, with justification and 
performance impact analysis etc.? Can only find the code part of the 
thread on lkml, which leaves out this context.

Thanks,

	Ingo
