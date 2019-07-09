Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003EC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3482080C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0zyBu6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfGISj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:39:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbfGISjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:39:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so4100348wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C2IvA+TdolzbC7+a5rr2lhrfnz6gFaLE+xuZf46t8K0=;
        b=h0zyBu6dXQ1Lpt6O4ND5ATNxcq+KZKxYFDq9HbaasvroJoj2yWKQGMaptrD8Lei4WQ
         LSMsvzBY99h2qz8V5Bt+YpMUSc+ivzsNOxqMM7qBbJlRY7ZHYanFKXrtAw99dZNsT/bH
         BPIhXYPvbrWDeMZ0FTuLKXmV2olIzq/z1yUyVefUW3j48k8jR9saefCl5YDp2aH3YWvU
         zvuqyvxMSyEdOpW975RdOd2MmsZE8IGpyLOiyqgcpClAw9D6xToMxeX581kggJoqveIA
         LacgK7gUo56vseyKw8fgF0d5XoDlLYW7Ex+0uD4LsWIF/hijq7OE8bJlbMInD/mkFKvZ
         j15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C2IvA+TdolzbC7+a5rr2lhrfnz6gFaLE+xuZf46t8K0=;
        b=dJubkPoN+bFHCkg+y3KtE1P4xuMGm+OHIm3VsMglNy5jMVGu+Gw7w6pT16OyT13Np9
         jP/ArjJdgqrZZ/j4M9j4n8twV/VmDVHXf9YkdHdZJVPxAR5Y+Z4ySr4i4VJhFvoBRyFp
         JVfWSYrSZLFCiBIpBFQpztQnAexhQkf4Sex4HDhRCdBUogrcb/KaIBlof58+wNG6pHSh
         utIWJuwVfHkXMiaurARKl6K7eL16K7yeHY95UOiuNOpp/OsXWjfQp9LwkV01Aqv57gQz
         rsHnG3kwUk5l3aBlZIO9t5kA8H9u9BHsvx42n4L31KUxCOlmtlih/T0SWSXhKmDw5Ej1
         3Kzw==
X-Gm-Message-State: APjAAAWlQHyVJ5u1V+RfssBqcDEyOdin65QccTCuj7XS8cWYZUkpt5vC
        c4YZ0Mn0T8aqvIUQNqguMHPWJZc=
X-Google-Smtp-Source: APXvYqzvWKETCe9CJinslefB4sgK0bS059uLtQuCmRwic5kEX4plEeX9Jh4CgPRnsEQOGTWIn+jyFA==
X-Received: by 2002:a05:600c:291:: with SMTP id 17mr1072135wmk.32.1562697564480;
        Tue, 09 Jul 2019 11:39:24 -0700 (PDT)
Received: from avx2 ([46.53.250.207])
        by smtp.gmail.com with ESMTPSA id b203sm4456425wmd.41.2019.07.09.11.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 11:39:23 -0700 (PDT)
Date:   Tue, 9 Jul 2019 21:39:21 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 06/11] x86/CPU: Adapt assembly for PIE support
Message-ID: <20190709183921.GA27282@avx2>
References: <20190708190930.GA16215@avx2>
 <CAJcbSZELSRbcfPqE9DuBidM8stxY2DdjseSZgM_pCS1L3FEpcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJcbSZELSRbcfPqE9DuBidM8stxY2DdjseSZgM_pCS1L3FEpcA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 12:35:13PM -0700, Thomas Garnier wrote:
> On Mon, Jul 8, 2019 at 12:09 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >
> > Thomas Garnier wrote:
> > > -             "pushq $1f\n\t"
> > > +             "movabsq $1f, %q0\n\t"
> > > +             "pushq %q0\n\t"
> > >               "iretq\n\t"
> > >               UNWIND_HINT_RESTORE
> > >               "1:"
> >
> > Fake PIE. True PIE looks like this:
> 
> I used movabsq in couple assembly changes where the memory context is
> unclear and relative reference might lead to issues. It happened on
> early boot and hibernation save/restore paths. Do you think a relative
> reference in this function will always be accurate?

As long as iretq target is not too far it should be OK.

I'm not really sure which issues can pop up.

IRETQ is 64-bit only, RIP-relative addressing is 64-bit only.
Assembler (hopefully) will error compilation if target is too far.

And it is shorter than movabsq.

> > ffffffff81022d70 <do_sync_core>:
> > ffffffff81022d70:       8c d0                   mov    eax,ss
> > ffffffff81022d72:       50                      push   rax
> > ffffffff81022d73:       54                      push   rsp
> > ffffffff81022d74:       48 83 04 24 08          add    QWORD PTR [rsp],0x8
> > ffffffff81022d79:       9c                      pushf
> > ffffffff81022d7a:       8c c8                   mov    eax,cs
> > ffffffff81022d7c:       50                      push   rax
> > ffffffff81022d7d:  ===> 48 8d 05 03 00 00 00    lea    rax,[rip+0x3]        # ffffffff81022d87 <do_sync_core+0x17>
> > ffffffff81022d84:       50                      push   rax
> > ffffffff81022d85:       48 cf                   iretq
> > ffffffff81022d87:       c3                      ret
> >
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> >
> > --- a/arch/x86/include/asm/processor.h
> > +++ b/arch/x86/include/asm/processor.h
> > @@ -710,7 +710,8 @@ static inline void sync_core(void)
> >                 "pushfq\n\t"
> >                 "mov %%cs, %0\n\t"
> >                 "pushq %q0\n\t"
> > -               "pushq $1f\n\t"
> > +               "leaq 1f(%%rip), %q0\n\t"
> > +               "pushq %q0\n\t"
> >                 "iretq\n\t"
> >                 UNWIND_HINT_RESTORE
> >                 "1:"
