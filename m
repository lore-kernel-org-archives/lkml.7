Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E190D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 05:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh2FJ9Vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfC2Fpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 01:45:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:36365 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfC2Fpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 01:45:53 -0400
Received: by mail-it1-f196.google.com with SMTP id y10so90494itc.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 22:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hucrVM0WNeasPWPGCYejzTf1K34QPWPOptxBeaX8TI=;
        b=Jh2FJ9Vi5p4Ub+xTaiIMApOna4s5IROFxxWAis2MtcMn3VNBnIGbifZep4nQn75AVh
         AaadjAaXJKDFWrba8XxqtoYEscLVnBo9IyCC2auJ514muw14L2vbWzCXw9H/PxisnTwh
         JVNkZms6foZt6olzopBFu9frFNl04k9TOOY3e1yBMbHa6Ctmj8w93v9hNtVWO/vf7Wmw
         OTNSq78eX5L+WMumrRH5yuuASwTT7vg5ftFhOLev2NTQ8hiXJ6hAWn76zWwCxyuiFy1O
         Ask9qAmKKBdKqI6uc7r9pqBru+j0nIRuFtKIU97bYM7MURMnQy2cNia8XCyRNgHV59Zl
         IPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hucrVM0WNeasPWPGCYejzTf1K34QPWPOptxBeaX8TI=;
        b=ed3AkWESLuHDTDTyTm8vsa6+/g2ndEAfRKlyyphaQ0acx7ADcKamjtD+43FVT2xunp
         /j2HSH7pqvHge1S6JgkaUfUM4OLKQwKZT5RvtEKj81gSSgxkfUjx5aVdneKhSaQLzjoF
         FYy8yRZr8QPX+knASFHzmQusJiefh1bE81+8WJ4b1C2P47BeB8za12qP63ayKo8OO6u+
         JYuTofmHMJYMIyTTbrYcFMovoh8AtUS5L9nWpWW10Zp907Kb2er7/s5Np/lDLZ2PdOcV
         Q0Nffmj8luPDptdC3vbfz32t+l9CMhDxyWfS6Z6KbQFUn6i1SlAndhhHPd+Zeh6AARgU
         DIFw==
X-Gm-Message-State: APjAAAUstl/v6YsUd0xj6JIvD2zqD3zAwCkHFtBGy91IRBIvKbO71gTi
        89vzdmjWeVVkPWjpmiAYsMfkjV9l/PVNPQD7zg==
X-Google-Smtp-Source: APXvYqwfBeXNE7CepEqFnEVO0t8+h0xTyPRh+gvq1LxbYtnLnTpM0RYu7HZzuXwD5W9b08OWxCRAT7KUtwSAvCQPEG8=
X-Received: by 2002:a05:660c:38e:: with SMTP id x14mr3121884itj.146.1553838352456;
 Thu, 28 Mar 2019 22:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
 <20190320002524.GD18740@MiWiFi-R3L-srv> <CAFgQCTt3-9oZ6yi_MGYFOZhn5+cSdJLGf3OQRMJ1CJr0eXiE5w@mail.gmail.com>
 <20190322075259.GA18740@MiWiFi-R3L-srv> <20190322083419.GB18740@MiWiFi-R3L-srv>
In-Reply-To: <20190322083419.GB18740@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 29 Mar 2019 13:45:41 +0800
Message-ID: <CAFgQCTti4S3TUx_4YHi+Yx6poJbHhekT+Jzjjg__0tpZdA9tRQ@mail.gmail.com>
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
In this case, kernel should get the total memory size info. So
process_e820_entries() or process_efi_entries() should be called
twice. One before handle_mem_options(), so crashkernel can evaluate
the reserved size. It is doable, and what is your opinion about the
extra complicate?

Thanks,
Pingfan
[...]
