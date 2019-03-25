Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A7920879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfx5CfDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbfCYF4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:56:50 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37603 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbfCYF4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:56:50 -0400
Received: by mail-io1-f65.google.com with SMTP id x7so6642626ioh.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 22:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rErnU8F2Tub/HLxErqtgrrFFFoxYilwVLP0ZwjlXNEE=;
        b=Sfx5CfDlRll0o67vrQCTdFEeLo7TCb10zhVYYOb30y/xUvBqVZ0QaUmBWLooxcHPwH
         2PEIeoJ4gwh/yS9ccDTw4K36qfp/VOvmdoFy0rpP57N6+E+FLjH6HEkn75z4uP7pHRjO
         dCsD8FKDeCqKvxKO6vzuy68N6Zs9ZVn9sEAlkgl9FDlUoqStpmBN8smqWwJE03nokwiL
         MAwdhlNbHeopVa8Tr/CluWAknA2PLN4mFppHuM1DELlBAuXTvqCoAdcfR9cFYAEM/OYU
         kBOcXWOh22t+JRdhuGGq2VmmVadIHAphfSxQDcXR8MGhbwBJn5Jf7kGYEKCjktRuED1C
         V4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rErnU8F2Tub/HLxErqtgrrFFFoxYilwVLP0ZwjlXNEE=;
        b=oEf8SJ/5KpLy5QhtpNV2l8PekMtuuPL/9434Ycr2OCzvoOHY9rGpfnDu3sHu3RyiSR
         rTLJzuL9/oUeJ59l2u1oQPzDuKzQo0F3fg5g1QAdBxEwqLRaEbOty8joI761asmysM5l
         ckhng7Vj/RLMmRA1CgQHRcI96HzkDHnLRGCeJe8+DalLI3JwcyA5Bs14mFb3Hd/JMq4Q
         xJi784jl9CFtCTCL8xj41Npu2JIhiu7TJux/IULCynBs1DR0ImuUjhZgCiPEJzv8o3Bu
         KNkQtf20VuFjLZXhxtpiMPD8tXxn1t+qJY0fQZv4yy6eP9B9OJ6PGsLtuW8oGpulyJa5
         DvnA==
X-Gm-Message-State: APjAAAUyDkyFFnTqVxXIRVSYeOXeWoc7kptjj8OZZlHPzKVazrThEFwV
        eCk2QNcfyCO0Io83Iqzjr+/sfSQbqKURmf9X4Q==
X-Google-Smtp-Source: APXvYqxE4xctNjyxf8Y+oH412kBfJfvVPih+nLJLYmYrlSO47d3fNR8YlfGhvEHQpaI0GNbfj2CGC/Z/kzJQ+ryvs/Y=
X-Received: by 2002:a6b:f10f:: with SMTP id e15mr15678796iog.106.1553493409070;
 Sun, 24 Mar 2019 22:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv> <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv> <20190322083419.GB18740@MiWiFi-R3L-srv>
In-Reply-To: <20190322083419.GB18740@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 25 Mar 2019 13:56:37 +0800
Message-ID: <CAFgQCTuu1j64QUHfXp3MJYOD2U9zhrcNCNkWA=6KVy6_cwYyNw@mail.gmail.com>
Subject: Re: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel reserved region
To:     Baoquan He <bhe@redhat.com>
Cc:     Dave Young <dyoung@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 4:34 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/22/19 at 03:52pm, Baoquan He wrote:
> > On 03/22/19 at 03:43pm, Pingfan Liu wrote:
> > > > > +/* parse crashkernel=x@y option */
> > > > > +static void mem_avoid_crashkernel_simple(char *option)
> > > >
> > > > Chao ever mentioned this, I want to ask again, why does it has to be
> > > > xxx_simple()?
> > > >
> > > Seems that I had replied Chao's question in another email. The naming
> > > follows the function parse_crashkernel_simple(), as the notes above
> >                        ~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Sorry, I don't get.  typo?
>
> OK, I misunderstood it. We do have parse_crashkernel_simple() to handle
> crashkernel=size[@offset] case, to differente with other complicated
> cases, like crashkernel=size,[high|low],
>
> Then I am fine with this naming. Soryy about the noise.
>
> By the way, do you think if we should take care of this case:
> crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
>
> It can also specify @offset. Not sure if it's too complicated, you may
> have a investigation.
>
OK, I will try it.
> These two cases have dependency on your crashkernel=X bug fix patch.
No, crashkernel=x@y should have no dependcy on crashkernel=X, the
later one relies on memblock searching.
> The current code only allow crashkernel= to reserve under 896MB. I
> noticed Boris has agreed on the solution. Maybe you can repost a new
> version based on the discussion.
I will sync with Dave to see whether he will post the new version.

Thank you for kindly review.

Regards,
Pingfan
>
> http://lkml.kernel.org/r/1548047768-7656-1-git-send-email-kernelfans@gmail.com
> [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X consistent with kaslr
>
> Thanks
> Baoquan
>
> >
> > > the definition
> > > /*
> > >  * That function parses "simple" (old) crashkernel command lines like
> > >  *
> > >  * crashkernel=size[@offset]
> >
> > Hmm, should only crashkernel=size@offset be cared? crashkernel=size will
> > auto finding a place to reserve, and that is after KASLR.
> >
> > >  *
> > >  * It returns 0 on success and -EINVAL on failure.
> > >  */
> > > static int __init parse_crashkernel_simple(char *cmdline,
> > >
> > > Do you have alternative suggestion?
> > >
> > > > Except of these, patch looks good to me. It's a nice catch, and only
> > > > need a simple fix based on the current code.
> > > >
> > > Thank you for the kindly review.
> > >
> > > Regards,
> > > Pingfan
> > >
> > > > Thanks
> > > > Baoquan
> > > >
> > > > > +{
> > > > > +     unsigned long long crash_size, crash_base;
> > > > > +     char *cur = option;
> > > > > +
> > > > > +     crash_size = memparse(option, &cur);
> > > > > +     if (option == cur)
> > > > > +             return;
> > > > > +
> > > > > +     if (*cur == '@') {
> > > > > +             option = cur + 1;
> > > > > +             crash_base = memparse(option, &cur);
> > > > > +             if (option == cur)
> > > > > +                     return;
> > > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
> > > > > +             mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
> > > > > +     }
> > > > > +}
> > > > >
> > > > >  static void handle_mem_options(void)
> > > > >  {
> > > > > @@ -250,7 +270,7 @@ static void handle_mem_options(void)
> > > > >       u64 mem_size;
> > > > >
> > > > >       if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
> > > > > -             !strstr(args, "hugepages"))
> > > > > +             !strstr(args, "hugepages") && !strstr(args, "crashkernel="))
> > > > >               return;
> > > > >
> > > > >       tmp_cmdline = malloc(len + 1);
> > > > > @@ -286,6 +306,8 @@ static void handle_mem_options(void)
> > > > >                               goto out;
> > > > >
> > > > >                       mem_limit = mem_size;
> > > > > +             } else if (strstr(param, "crashkernel")) {
> > > > > +                     mem_avoid_crashkernel_simple(val);
> > > > >               }
> > > > >       }
> > > > >
> > > > > @@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
> > > > >
> > > > >       /* We don't need to set a mapping for setup_data. */
> > > > >
> > > > > -     /* Mark the memmap regions we need to avoid */
> > > > > +     /* Mark the regions we need to avoid */
> > > > >       handle_mem_options();
> > > > >
> > > > >  #ifdef CONFIG_X86_VERBOSE_BOOTUP
> > > > > --
> > > > > 2.7.4
> > > > >
