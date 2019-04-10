Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E6EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F8F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDJJAs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 05:00:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:39521 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbfDJJAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 05:00:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 02:00:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="159855706"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by fmsmga002.fm.intel.com with ESMTP; 10 Apr 2019 02:00:45 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.44]) with mapi id 14.03.0415.000;
 Wed, 10 Apr 2019 10:00:44 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "luto@kernel.org" <luto@kernel.org>,
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
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU7dJsIdze6jSaA0qMnvHjeKNle6YyJqcAgALbMACAABmnEA==
Date:   Wed, 10 Apr 2019 09:00:43 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C48943@IRSMSX102.ger.corp.intel.com>
References: <20190408061358.21288-1-elena.reshetova@intel.com>
 <20190408124940.hb4d2mvwue7aydjj@treble> <20190410082642.GA35032@gmail.com>
In-Reply-To: <20190410082642.GA35032@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDBkZjBjNmMtODE4ZC00ZDZkLTk5Y2EtNDE2NDVkYjkzZjEwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiM1hlb1wvMW1xa3lYSERPTXJrNnhhZHhFc3pJamdVc25KTnJaS2RwRXJhRmxQQWU4WlwvekRSQUI4YW9cLzdvV2hOKyJ9
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> * Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Mon, Apr 08, 2019 at 09:13:58AM +0300, Elena Reshetova wrote:
> > > diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> > > index 7bc105f47d21..38ddc213a5e9 100644
> > > --- a/arch/x86/entry/common.c
> > > +++ b/arch/x86/entry/common.c
> > > @@ -35,6 +35,12 @@
> > >  #define CREATE_TRACE_POINTS
> > >  #include <trace/events/syscalls.h>
> > >
> > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > +#include <linux/random.h>
> > > +
> > > +void *alloca(size_t size);
> > > +#endif
> > > +
> > >  #ifdef CONFIG_CONTEXT_TRACKING
> > >  /* Called on entry from user mode with IRQs off. */
> > >  __visible inline void enter_from_user_mode(void)
> > > @@ -273,6 +279,13 @@ __visible void do_syscall_64(unsigned long nr, struct
> pt_regs *regs)
> > >  {
> > >  	struct thread_info *ti;
> > >
> > > +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
> > > +	size_t offset = ((size_t)prandom_u32()) % 256;
> > > +	char *ptr = alloca(offset);
> > > +
> > > +	asm volatile("":"=m"(*ptr));
> > > +#endif
> > > +
> > >  	enter_from_user_mode();
> > >  	local_irq_enable();
> > >  	ti = current_thread_info();
> >
> > Would it make sense to also do this for the compat syscalls
> > (do_fast_syscall_32, do_int80_syscall_32)?
> 
> Could someone please include the full patch, with justification and
> performance impact analysis etc.? Can only find the code part of the
> thread on lkml, which leaves out this context.
> 

Sorry, this is very weird, I cannot find it either from lkml, but it was sent there
to begin with (and as visible from reply-to headers).

Do you want me to resent original version or with "do_fast_syscall_32,
do_int80_syscall_32" additions (I am finishing testing them now).

Best Regards,
Elena.
