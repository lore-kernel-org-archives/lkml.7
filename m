Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED2DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51D7D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 07:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkG183hF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfC2H0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 03:26:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44628 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbfC2H0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 03:26:11 -0400
Received: by mail-io1-f66.google.com with SMTP id u12so929481iop.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kvpxmuogHEP+QnPnXtkSS63T0TaL2meAXicXutd/Zxs=;
        b=hkG183hFy3gmhMkN7Zs5J2LqD6wsZz/c1b1cGWJGxvN0MypQ5lVnDJ2ydeIUCF8jzw
         ZlY6g702iwu9KvJCDO+lTEUhdzUBcL3u4OnOnA8rNNFDUYG+eFsrEY75ffG7bn/puJBU
         tThXTnvmLwnBoPOuc2OcXAeO57w+KzrZ7z590LdwBKqvIQMxXUlkKHzZW904LzVJeFdT
         fubJ0q60nLeZUFH5Ggu5W/C3W0cRKnbFmOGyn+MjqVu15rxNjk5kb8yDn2iS84esvqvz
         GNoSAC8FKVg+ITFcsDjonTPqBJ9oqAaH7xNzMKjd1LWJdKCJaLIov+tVrU1Lcp3x8Z6S
         vpqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kvpxmuogHEP+QnPnXtkSS63T0TaL2meAXicXutd/Zxs=;
        b=PJGerwZmt/NkuM/ragPNipx/qjSZ5HTnUsl658xTAvgCisUGRYCgUuEBbijE3zKtaw
         ZyphuY/F2TDMmgjtUJx38B/AbA8NuL0KBQodD1/rkuhTu73gMYtLfAo0+lHiptq5iBDo
         PJOd0tCBFJEtZORo45d7bYpEKwBeswu/z1BR44QBhimQuvxQ66ODLQDehumkjrAwIiJV
         Gcqb3Qby8Y9tJU3SlMHp3SNykXPp79CAEE3uczek08SMrpgSzzAzbgA/gPsI5OH4fCOC
         BDbOVztOYzvPXhxbufZRHMZjmsDF0lWHgv80+Bc043KkfplZpqAPu+hUAp2smIT1zCrU
         b08A==
X-Gm-Message-State: APjAAAXvcj7a7Qzo+zccCAqfVf3Vbjp6qxNs79knWe5MIieRcv/01Za8
        srZQkVph9Pp6waV7C7WpUw2/cRTXXBaA8EE6bo9J5uSWJw==
X-Google-Smtp-Source: APXvYqzH2FRwA98pmzzU5Ntj8hXcgVHS2K/2MqlK51ctKF6hzxXQ4ZmpA9uHFleRiPXJYve+S342DZPSfU+xZUz2Gag=
X-Received: by 2002:a6b:f10f:: with SMTP id e15mr32996256iog.106.1553844370613;
 Fri, 29 Mar 2019 00:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv> <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv> <20190322083419.GB18740@MiWiFi-R3L-srv>
 <CAFgQCTti4S3TUx_4YHi+Yx6poJbHhekT+Jzjjg__0tpZdA9tRQ@mail.gmail.com> <20190329062715.GA7627@MiWiFi-R3L-srv>
In-Reply-To: <20190329062715.GA7627@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 29 Mar 2019 15:25:59 +0800
Message-ID: <CAFgQCTvGnV5NUcyp1RCJa2hHxKiQDM=HRn_GwWs+WUdt1afLQA@mail.gmail.com>
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

On Fri, Mar 29, 2019 at 2:27 PM Baoquan He <bhe@redhat.com> wrote:
>
> On 03/29/19 at 01:45pm, Pingfan Liu wrote:
> > On Fri, Mar 22, 2019 at 4:34 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 03/22/19 at 03:52pm, Baoquan He wrote:
> > > > On 03/22/19 at 03:43pm, Pingfan Liu wrote:
> > > > > > > +/* parse crashkernel=x@y option */
> > > > > > > +static void mem_avoid_crashkernel_simple(char *option)
> > > > > >
> > > > > > Chao ever mentioned this, I want to ask again, why does it has to be
> > > > > > xxx_simple()?
> > > > > >
> > > > > Seems that I had replied Chao's question in another email. The naming
> > > > > follows the function parse_crashkernel_simple(), as the notes above
> > > >                        ~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Sorry, I don't get.  typo?
> > >
> > > OK, I misunderstood it. We do have parse_crashkernel_simple() to handle
> > > crashkernel=size[@offset] case, to differente with other complicated
> > > cases, like crashkernel=size,[high|low],
> > >
> > > Then I am fine with this naming. Soryy about the noise.
> > >
> > > By the way, do you think if we should take care of this case:
> > > crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
> > >
> > > It can also specify @offset. Not sure if it's too complicated, you may
> > > have a investigation.
> > >
> > In this case, kernel should get the total memory size info. So
> > process_e820_entries() or process_efi_entries() should be called
> > twice. One before handle_mem_options(), so crashkernel can evaluate
> > the reserved size. It is doable, and what is your opinion about the
>
> You mean calling process_e820_entries to calculate the RAM size in
> system? I may not do like that, please check what __find_max_addr() is
> doing. Did I get it?

Yes, you got my meaning. But __find_max_addr() relies on the info, fed
by e820__memblock_setup(). It also involves the iteration of all e820
entries to get the max address. No essential difference, right?
