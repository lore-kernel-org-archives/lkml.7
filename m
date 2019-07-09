Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024BAC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5E22080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZqpFQHXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfGISsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:48:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35929 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGISsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:48:03 -0400
Received: by mail-ed1-f66.google.com with SMTP id k21so18788187edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eK+xewQIWx/F1jZ9xUWUB+xnJfY4b6YBYNbe+JCkf34=;
        b=ZqpFQHXVR6K0FCwEd+vfPBI8Dcro2Z85YfwX6ySYtov0K4gBR+9zCFxbpcTJfV/80C
         MQfA+fm3xaDKEWqgtsv3ycOk9s0dLt1gp2ifffjhOCTa50oNpaKn7SgVWU/qzL+S3sMS
         W4To20natzJR9fhWCUrqpqv8kZ66fxDWaVoCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eK+xewQIWx/F1jZ9xUWUB+xnJfY4b6YBYNbe+JCkf34=;
        b=qMjxCw3K5iz9o+vmW8Dxi0dCvRg5gIcZYs7zJY2jTvc814ym+R3MJSC5m8htdfbBAC
         jw5D0HUDlzT5I8LS8ZxHsCJ1LvjXmy4vh8Ac2yEUst1d6GAgcNDpNXqak65QvJqBRDkC
         Ab6BtbYQMIM6yJCysgNsjkeVowKBfxZ2WefViomdNBOUFZwJdMhNhYFAsbRNv/xqRDUc
         Y1PjXHu5laPfjw66xT+A6dVIpk25AgR6D0lJvFPCU+aWAEMYgUTE3D098sGL30HfOScC
         hynmw/KPe4W87BciCLA5Yju/Ls8nONI4zBemLa5+ElasCOeKrtjNYiJZTkKu4bFad4zD
         iJqw==
X-Gm-Message-State: APjAAAUDHwfJAgT7MOiY/pa7ISQ850Rb/ToXCzMgJeNNTv2Z7UHoqfoX
        xy5cLztLM8pcNJlx2ARhRZhKyzhppFU=
X-Google-Smtp-Source: APXvYqxcpA4Zpeh6YjyCEiF7syB7qM68pRzx6gexdgqTIae6/QFPXPUoaC06k2jIPUOUfV2VtdBf/A==
X-Received: by 2002:a50:f4dd:: with SMTP id v29mr27022276edm.246.1562698081510;
        Tue, 09 Jul 2019 11:48:01 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id y22sm6439843edw.94.2019.07.09.11.48.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:48:01 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id z1so17509287wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:48:00 -0700 (PDT)
X-Received: by 2002:a5d:5152:: with SMTP id u18mr17305021wrt.9.1562698080410;
 Tue, 09 Jul 2019 11:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190708190930.GA16215@avx2> <CAJcbSZELSRbcfPqE9DuBidM8stxY2DdjseSZgM_pCS1L3FEpcA@mail.gmail.com>
 <20190709183921.GA27282@avx2>
In-Reply-To: <20190709183921.GA27282@avx2>
From:   Thomas Garnier <thgarnie@chromium.org>
Date:   Tue, 9 Jul 2019 11:47:48 -0700
X-Gmail-Original-Message-ID: <CAJcbSZFt6Xu=r+bvhPVoGnRL4Y2iRhnFo7_oBmwzW_LzxYO47w@mail.gmail.com>
Message-ID: <CAJcbSZFt6Xu=r+bvhPVoGnRL4Y2iRhnFo7_oBmwzW_LzxYO47w@mail.gmail.com>
Subject: Re: [PATCH v8 06/11] x86/CPU: Adapt assembly for PIE support
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 9, 2019 at 11:39 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Mon, Jul 08, 2019 at 12:35:13PM -0700, Thomas Garnier wrote:
> > On Mon, Jul 8, 2019 at 12:09 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > Thomas Garnier wrote:
> > > > -             "pushq $1f\n\t"
> > > > +             "movabsq $1f, %q0\n\t"
> > > > +             "pushq %q0\n\t"
> > > >               "iretq\n\t"
> > > >               UNWIND_HINT_RESTORE
> > > >               "1:"
> > >
> > > Fake PIE. True PIE looks like this:
> >
> > I used movabsq in couple assembly changes where the memory context is
> > unclear and relative reference might lead to issues. It happened on
> > early boot and hibernation save/restore paths. Do you think a relative
> > reference in this function will always be accurate?
>
> As long as iretq target is not too far it should be OK.
>
> I'm not really sure which issues can pop up.
>
> IRETQ is 64-bit only, RIP-relative addressing is 64-bit only.
> Assembler (hopefully) will error compilation if target is too far.
>
> And it is shorter than movabsq.

Agree, I will change it and run some tests for the next iteration.

>
> > > ffffffff81022d70 <do_sync_core>:
> > > ffffffff81022d70:       8c d0                   mov    eax,ss
> > > ffffffff81022d72:       50                      push   rax
> > > ffffffff81022d73:       54                      push   rsp
> > > ffffffff81022d74:       48 83 04 24 08          add    QWORD PTR [rsp],0x8
> > > ffffffff81022d79:       9c                      pushf
> > > ffffffff81022d7a:       8c c8                   mov    eax,cs
> > > ffffffff81022d7c:       50                      push   rax
> > > ffffffff81022d7d:  ===> 48 8d 05 03 00 00 00    lea    rax,[rip+0x3]        # ffffffff81022d87 <do_sync_core+0x17>
> > > ffffffff81022d84:       50                      push   rax
> > > ffffffff81022d85:       48 cf                   iretq
> > > ffffffff81022d87:       c3                      ret
> > >
> > > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > >
> > > --- a/arch/x86/include/asm/processor.h
> > > +++ b/arch/x86/include/asm/processor.h
> > > @@ -710,7 +710,8 @@ static inline void sync_core(void)
> > >                 "pushfq\n\t"
> > >                 "mov %%cs, %0\n\t"
> > >                 "pushq %q0\n\t"
> > > -               "pushq $1f\n\t"
> > > +               "leaq 1f(%%rip), %q0\n\t"
> > > +               "pushq %q0\n\t"
> > >                 "iretq\n\t"
> > >                 UNWIND_HINT_RESTORE
> > >                 "1:"
