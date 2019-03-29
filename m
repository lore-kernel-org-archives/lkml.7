Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8520C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B268021773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH8x4/7y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbfC2KBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:01:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50259 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfC2KBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:01:00 -0400
Received: by mail-it1-f194.google.com with SMTP id m137so2872908ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l0hO4rYWdv+UasdHDvS+LUyIV32oFDyUl4LF0L6WqaI=;
        b=IH8x4/7yTlx7bL0pskerXjgJ1ilz7acv4Z0iZ6Py/gUHtd6y2oEMEVogBaRxoro3FW
         UUua47uiH1A7u7d4/awNIJGHcMJ2Txk2i7CJKjE7at2bOxgAVeto53u2RV/srK/wkzhN
         YZxu2Pb7P3tEgj+gllV+TLpKGCAWy1znPUCANSNaxwXdjne4hBAIc0axumexYm/NBRz7
         RYoBS2FgaY6cWm7XRzzG7erjQmunkA1EALw0Zj3UyZNfVjJvOs13RTFkTy0fO1azukNq
         Bbs7yJAGJBnPJXzWRrJci3iMLp9llZ5qYcVbLo5WTLyVqov3JZ9KlTyBt0yvZK8msrBA
         GhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l0hO4rYWdv+UasdHDvS+LUyIV32oFDyUl4LF0L6WqaI=;
        b=B36KkjYzGcjxIHxy8rU2TfXBjhQd+hkrUuGy7Sai9DYk/Rw9gPgf1pFl7CGONcTamZ
         b3FMCbOXcfX/M3SCK4Apg8n/JkumeDi8zpYLa+N5Q9YXoXiDAZS4JWX3741MgPgl0qFm
         WZv94PCd5TAHRWO2pDJJGFArv30BiWWwWX0StW+FtTkSisSQzSU5t7hbEL2AWoyk4IUJ
         e3S60UlPuZnIuEWrZXUCLOuDwRBqXrdOqb6kKB8H4LYgzeKy0UCcRLZxN5cOC3HUY7g2
         rJ4mvmnozGaEvS8NnQBUrn//z2cMOks+SHHBfX0oAqa5ThX9GtrSdKEg/nctV/p0onOr
         Re8g==
X-Gm-Message-State: APjAAAXug+mEhQR8RfKbyxmi7HkVwYXel3JM9YjU/CtByk8QCwc6nUOV
        5l4+EmtBfmgoDr08msC8n12mEs33xjsg6n5Qgg==
X-Google-Smtp-Source: APXvYqz0EoBaTZ19ReU+ErXJY+0EQrFFdcoQIY27hwncAwru4+E0hZQU34IMBsFQKbtqH9I9k8EE0C6nAsVSKRQT/N4=
X-Received: by 2002:a24:9:: with SMTP id 9mr3750142ita.127.1553853659831; Fri,
 29 Mar 2019 03:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv> <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv> <20190322083419.GB18740@MiWiFi-R3L-srv>
 <CAFgQCTti4S3TUx_4YHi+Yx6poJbHhekT+Jzjjg__0tpZdA9tRQ@mail.gmail.com>
 <20190329062715.GA7627@MiWiFi-R3L-srv> <CAFgQCTvGnV5NUcyp1RCJa2hHxKiQDM=HRn_GwWs+WUdt1afLQA@mail.gmail.com>
 <20190329073438.GC7627@MiWiFi-R3L-srv>
In-Reply-To: <20190329073438.GC7627@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 29 Mar 2019 18:00:48 +0800
Message-ID: <CAFgQCTtbfYDzDkeZ_tPqAS2+f2E1dRtHgzZT13D0Zb6pfEEZug@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 3:34 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/29/19 at 03:25pm, Pingfan Liu wrote:
> > On Fri, Mar 29, 2019 at 2:27 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 03/29/19 at 01:45pm, Pingfan Liu wrote:
> > > > On Fri, Mar 22, 2019 at 4:34 PM Baoquan He <bhe@redhat.com> wrote:
> > > > >
> > > > > On 03/22/19 at 03:52pm, Baoquan He wrote:
> > > > > > On 03/22/19 at 03:43pm, Pingfan Liu wrote:
> > > > > > > > > +/* parse crashkernel=x@y option */
> > > > > > > > > +static void mem_avoid_crashkernel_simple(char *option)
> > > > > > > >
> > > > > > > > Chao ever mentioned this, I want to ask again, why does it has to be
> > > > > > > > xxx_simple()?
> > > > > > > >
> > > > > > > Seems that I had replied Chao's question in another email. The naming
> > > > > > > follows the function parse_crashkernel_simple(), as the notes above
> > > > > >                        ~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > >
> > > > > > Sorry, I don't get.  typo?
> > > > >
> > > > > OK, I misunderstood it. We do have parse_crashkernel_simple() to handle
> > > > > crashkernel=size[@offset] case, to differente with other complicated
> > > > > cases, like crashkernel=size,[high|low],
> > > > >
> > > > > Then I am fine with this naming. Soryy about the noise.
> > > > >
> > > > > By the way, do you think if we should take care of this case:
> > > > > crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > > > >
> > > > > It can also specify @offset. Not sure if it's too complicated, you may
> > > > > have a investigation.
> > > > >
> > > > In this case, kernel should get the total memory size info. So
> > > > process_e820_entries() or process_efi_entries() should be called
> > > > twice. One before handle_mem_options(), so crashkernel can evaluate
> > > > the reserved size. It is doable, and what is your opinion about the
> > >
> > > You mean calling process_e820_entries to calculate the RAM size in
> > > system? I may not do like that, please check what __find_max_addr() is
> > > doing. Did I get it?
> >
> > Yes, you got my meaning. But __find_max_addr() relies on the info, fed
> > by e820__memblock_setup(). It also involves the iteration of all e820
> > entries to get the max address. No essential difference, right?
>
> Hmm, I would say iterating e820 or efi entries to get the mas addr should be
> different with calling process_e820_entries(). The 1st is much simpler,
> right?
>
Yes. My original meaning is to reuse process_e820_entries(), but does
not call process_mem_region() at the first time.

Thanks,
Pingfan
