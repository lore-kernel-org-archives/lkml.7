Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E6920862
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 18:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574880524;
	bh=HDIbn9OA5W3/OHbyFtYxhIzAoQuK3beU9F7h1ihvZpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0hvbr7icLYM65Iv3OFxUNWZ7BtqNjYyffbpVChu+9h5Vag0VpHvdpQtL71UAL+tU7
	 N5alwZ31KV/O8+H1pQxekmdytQFjUIUq0y3geZ+PT6ZF4CswjMTezoKcNUN2cEbrbR
	 AHopknOUcmXBzXBfiXh/MXquZDvo/00+5zAkSCYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfK0Ssn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 13:48:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34809 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfK0Ssn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 13:48:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so27932761wrr.1;
        Wed, 27 Nov 2019 10:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JmmRBkg7UlLwGnEFJ66/QQfvNXyQttt8bYoR973+hkk=;
        b=EpOdtM4p1KXHp2iiufznJArmz12ePIbafsnRqk1rZQ5/l4JV3BO8Zj3htv6yTNQ/rO
         Clr77x9TNHQtF8V6D7rSi5S3QA5RA8JplUglC4aIBEwdb4jWIw1+lN/Wl8JeGOag+95g
         e/edbK29eNSix7r+n/hnlXwO8o8T9ggaMfBpT1sNVOawwMdkub1H7QV64wv5VVnsaIXH
         ym8QUt3adBaj8aQhUQw7rTVurxjyrm+gxqoGahggmnwfGNemokZB5c9aYP2IhHvvDzpn
         ES0ztvJIQM1n9xe5e7D/fzYnnE6gjwiUOaavhxavaEB+j8s+VHj3ZCvWtsINs2CUDTgG
         ODvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JmmRBkg7UlLwGnEFJ66/QQfvNXyQttt8bYoR973+hkk=;
        b=AZ1C2zW2VgVkqNqiFwr9ximM9wXD6RfOfdJgt3XpGRbXX9krCtmB33iQXMrGsTSIMe
         h5YwUjstJrBOK91hIfwbRb61lFf+wGL1+kP8eNb1BihPBb1PjE2GCa56LOks9IuQZyAp
         f6XUij2+LL1TC9VTBcTcRHlHNRsmjj+R9W+c3KwOcyGosgA0id+2k3BEJglbo1W9V8j9
         o7MdBtbJODIwoLLvQEFpc0slOhALRodtCWikJ6L7h6rItY72P+BQCGcAbumA6NpIkAE5
         aLzxBjcVjQjWTyvPyli66j1I8oBGllRpqztw0jyb5jrbapwFyJUGDg+89YO0hA+fdOMw
         MEUA==
X-Gm-Message-State: APjAAAVqt1l92L6UNwXwrMmPNEdVnfvocMw8Anzn3siO6hdRSGhnECoK
        RMqE8+T8hCZh/5+OPlUxKxQ=
X-Google-Smtp-Source: APXvYqwCp6WRNs8Y4B8KzqvPYE3HW/fy9bkMdUXX3EDmrke5PKVDPKwn+2p6aFmhnU92Fhg+Os5zFA==
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr3960864wrs.92.1574880520143;
        Wed, 27 Nov 2019 10:48:40 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z2sm5564406wmf.47.2019.11.27.10.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 10:48:39 -0800 (PST)
Date:   Wed, 27 Nov 2019 19:48:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: x86/urgent] lkdtm: Add a DOUBLE_FAULT crash type on x86
Message-ID: <20191127184837.GA35982@gmail.com>
References: <157484277010.21853.17013724751521586684.tip-bot2@tip-bot2>
 <201911270942.0F120BF82@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911270942.0F120BF82@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Kees Cook <keescook@chromium.org> wrote:

> On Wed, Nov 27, 2019 at 08:19:30AM -0000, tip-bot2 for Andy Lutomirski wrote:
> > The following commit has been merged into the x86/urgent branch of tip:
> > 
> > Commit-ID:     b09511c253e5c739a60952b97c071a93e92b2e88
> > Gitweb:        https://git.kernel.org/tip/b09511c253e5c739a60952b97c071a93e92b2e88
> > Author:        Andy Lutomirski <luto@kernel.org>
> > AuthorDate:    Sun, 24 Nov 2019 21:18:04 -08:00
> > Committer:     Ingo Molnar <mingo@kernel.org>
> > CommitterDate: Tue, 26 Nov 2019 21:53:34 +01:00
> > 
> > lkdtm: Add a DOUBLE_FAULT crash type on x86
> > 
> > The DOUBLE_FAULT crash does INT $8, which is a decent approximation
> > of a double fault.  This is useful for testing the double fault
> > handling.  Use it like:
> > 
> > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/misc/lkdtm/bugs.c  | 39 +++++++++++++++++++++++++++++++++++++-
> >  drivers/misc/lkdtm/core.c  |  3 +++-
> >  drivers/misc/lkdtm/lkdtm.h |  3 +++-
> >  3 files changed, 45 insertions(+)
> > 
> > diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> > index 7284a22..a4fdad0 100644
> > --- a/drivers/misc/lkdtm/bugs.c
> > +++ b/drivers/misc/lkdtm/bugs.c
> > @@ -12,6 +12,10 @@
> >  #include <linux/sched/task_stack.h>
> >  #include <linux/uaccess.h>
> >  
> > +#ifdef CONFIG_X86_32
> > +#include <asm/desc.h>
> > +#endif
> > +
> >  struct lkdtm_list {
> >  	struct list_head node;
> >  };
> > @@ -337,3 +341,38 @@ void lkdtm_UNSET_SMEP(void)
> >  	pr_err("FAIL: this test is x86_64-only\n");
> >  #endif
> >  }
> > +
> > +#ifdef CONFIG_X86_32
> > +void lkdtm_DOUBLE_FAULT(void)
> > +{
> > +	/*
> > +	 * Trigger #DF by setting the stack limit to zero.  This clobbers
> > +	 * a GDT TLS slot, which is okay because the current task will die
> > +	 * anyway due to the double fault.
> > +	 */
> > +	struct desc_struct d = {
> > +		.type = 3,	/* expand-up, writable, accessed data */
> > +		.p = 1,		/* present */
> > +		.d = 1,		/* 32-bit */
> > +		.g = 0,		/* limit in bytes */
> > +		.s = 1,		/* not system */
> > +	};
> > +
> > +	local_irq_disable();
> > +	write_gdt_entry(get_cpu_gdt_rw(smp_processor_id()),
> > +			GDT_ENTRY_TLS_MIN, &d, DESCTYPE_S);
> > +
> > +	/*
> > +	 * Put our zero-limit segment in SS and then trigger a fault.  The
> > +	 * 4-byte access to (%esp) will fault with #SS, and the attempt to
> > +	 * deliver the fault will recursively cause #SS and result in #DF.
> > +	 * This whole process happens while NMIs and MCEs are blocked by the
> > +	 * MOV SS window.  This is nice because an NMI with an invalid SS
> > +	 * would also double-fault, resulting in the NMI or MCE being lost.
> > +	 */
> > +	asm volatile ("movw %0, %%ss; addl $0, (%%esp)" ::
> > +		      "r" ((unsigned short)(GDT_ENTRY_TLS_MIN << 3)));
> > +
> > +	panic("tried to double fault but didn't die\n");
> 
> I'll modify this in some later patches, but I prefer the #ifdef inside
> the function so that all tests are visible on all
> architectures/configurations. And it should not panic on a test failure,
> it should continue (see the others) with something like:
> 
> 	pr_err("FAIL: did not double fault!\n");
> 
> E.g. an external system monitor would see the double-fault and the panic as
> both causing a system reboot, but only the double-fault should do that.
> 
> > +}
> > +#endif
> > diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> > index cbc4c90..ee0d6e7 100644
> > --- a/drivers/misc/lkdtm/core.c
> > +++ b/drivers/misc/lkdtm/core.c
> > @@ -171,6 +171,9 @@ static const struct crashtype crashtypes[] = {
> >  	CRASHTYPE(USERCOPY_KERNEL_DS),
> >  	CRASHTYPE(STACKLEAK_ERASING),
> >  	CRASHTYPE(CFI_FORWARD_PROTO),
> > +#ifdef CONFIG_X86_32
> > +	CRASHTYPE(DOUBLE_FAULT),
> > +#endif
> 
> And then ifdefs aren't needed here either.
> 
> >  };
> >  
> >  
> > diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> > index ab446e0..c56d23e 100644
> > --- a/drivers/misc/lkdtm/lkdtm.h
> > +++ b/drivers/misc/lkdtm/lkdtm.h
> > @@ -28,6 +28,9 @@ void lkdtm_CORRUPT_USER_DS(void);
> >  void lkdtm_STACK_GUARD_PAGE_LEADING(void);
> >  void lkdtm_STACK_GUARD_PAGE_TRAILING(void);
> >  void lkdtm_UNSET_SMEP(void);
> > +#ifdef CONFIG_X86_32
> > +void lkdtm_DOUBLE_FAULT(void);
> > +#endif
> 
> Same.

If you think I can apply your fixes on top of x86/urgent, so that it goes 
upstream in a clean fashion?

I can also rebase and remove it for the time being - your call!

Thanks,

	Ingo
