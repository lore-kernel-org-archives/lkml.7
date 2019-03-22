Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4B82083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbfCVIeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfCVIeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:34:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2F94307CDE3;
        Fri, 22 Mar 2019 08:34:24 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 56FF65D9CC;
        Fri, 22 Mar 2019 08:34:22 +0000 (UTC)
Date:   Fri, 22 Mar 2019 16:34:19 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Pingfan Liu <kernelfans@gmail.com>, dyoung@redhat.com
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel
 reserved region
Message-ID: <20190322083419.GB18740@MiWiFi-R3L-srv>
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv>
 <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322075259.GA18740@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 22 Mar 2019 08:34:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/22/19 at 03:52pm, Baoquan He wrote:
> On 03/22/19 at 03:43pm, Pingfan Liu wrote:
> > > > +/* parse crashkernel=x@y option */
> > > > +static void mem_avoid_crashkernel_simple(char *option)
> > >
> > > Chao ever mentioned this, I want to ask again, why does it has to be
> > > xxx_simple()?
> > >
> > Seems that I had replied Chao's question in another email. The naming
> > follows the function parse_crashkernel_simple(), as the notes above
>                        ~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Sorry, I don't get.  typo?

OK, I misunderstood it. We do have parse_crashkernel_simple() to handle 
crashkernel=size[@offset] case, to differente with other complicated
cases, like crashkernel=size,[high|low],

Then I am fine with this naming. Soryy about the noise.

By the way, do you think if we should take care of this case:
crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]

It can also specify @offset. Not sure if it's too complicated, you may
have a investigation.

These two cases have dependency on your crashkernel=X bug fix patch.
The current code only allow crashkernel= to reserve under 896MB. I
noticed Boris has agreed on the solution. Maybe you can repost a new
version based on the discussion.

http://lkml.kernel.org/r/1548047768-7656-1-git-send-email-kernelfans@gmail.com
[PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr

Thanks
Baoquan

> 
> > the definition
> > /*
> >  * That function parses "simple" (old) crashkernel command lines like
> >  *
> >  * crashkernel=size[@offset]
> 
> Hmm, should only crashkernel=size@offset be cared? crashkernel=size will
> auto finding a place to reserve, and that is after KASLR.
> 
> >  *
> >  * It returns 0 on success and -EINVAL on failure.
> >  */
> > static int __init parse_crashkernel_simple(char *cmdline,
> > 
> > Do you have alternative suggestion?
> > 
> > > Except of these, patch looks good to me. It's a nice catch, and only
> > > need a simple fix based on the current code.
> > >
> > Thank you for the kindly review.
> > 
> > Regards,
> > Pingfan
> > 
> > > Thanks
> > > Baoquan
> > >
> > > > +{
> > > > +     unsigned long long crash_size, crash_base;
> > > > +     char *cur = option;
> > > > +
> > > > +     crash_size = memparse(option, &cur);
> > > > +     if (option == cur)
> > > > +             return;
> > > > +
> > > > +     if (*cur == '@') {
> > > > +             option = cur + 1;
> > > > +             crash_base = memparse(option, &cur);
> > > > +             if (option == cur)
> > > > +                     return;
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > > > +     }
> > > > +}
> > > >
> > > >  static void handle_mem_options(void)
> > > >  {
> > > > @@ -250,7 +270,7 @@ static void handle_mem_options(void)
> > > >       u64 mem_size;
> > > >
> > > >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> > > > -             !strstr(args, "hugepages"))
> > > > +             !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> > > >               return;
> > > >
> > > >       tmp_cmdline = malloc(len + 1);
> > > > @@ -286,6 +306,8 @@ static void handle_mem_options(void)
> > > >                               goto out;
> > > >
> > > >                       mem_limit = mem_size;
> > > > +             } else if (strstr(param, "crashkernel")) {
> > > > +                     mem_avoid_crashkernel_simple(val);
> > > >               }
> > > >       }
> > > >
> > > > @@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> > > >
> > > >       /* We don't need to set a mapping for setup_data. */
> > > >
> > > > -     /* Mark the memmap regions we need to avoid */
> > > > +     /* Mark the regions we need to avoid */
> > > >       handle_mem_options();
> > > >
> > > >  #ifdef CONFIG_X86_VERBOSE_BOOTUP
> > > > --
> > > > 2.7.4
> > > >
