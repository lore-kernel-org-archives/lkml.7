Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2350CCA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86712087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 15:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aUtgADL5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfJ3PU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 11:20:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46345 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfJ3PU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 11:20:58 -0400
Received: by mail-ed1-f66.google.com with SMTP id z22so2029668edr.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WelAeH2c+ewUFXMqzibHzNrbO0iv8d5R7fbVULwLqc=;
        b=aUtgADL5DK0nImfhe/gfmEFtgWdBGRsYsp06B7dPmIh6ijzq/OsArBiemDsg8NxCO2
         DY6MdSqBP+xrfoWYwvyzkYHeILfLsJFHI+xpo41raCQITr+AhKMITt7bzSz+uHKU0dNE
         7Psn8QOTNIvxhPhsQ92pJZOSzcQAYuXG3mRLJecqPX+e4lWKMN0vaJ52eg26VQpYxW4+
         9YIUTtJUxAv7Q/lbJZynFXrOqG5IRw4qjlBatFFyXEei2CbqaMrLJYHsscQLHqAhOKeh
         bmInSTZG6AAgtkiinMYvPV10YusjDcEfu00m7/PzjBF5W4JCjGQVmcE8K0Qok6T7nenB
         kJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WelAeH2c+ewUFXMqzibHzNrbO0iv8d5R7fbVULwLqc=;
        b=NwR0S0qk4jOzXm/5NIXiJUlx0AIh8CLtTcUuSdAtKcK5yDal45N1YbDjPZ520azBOb
         qe0huOMR0VDOl86faOlLO0KAVGzWabK07vxCroIr6lIHRKwG3G5mdIMQfKU8s9yeY4Xs
         8Q3olm9v99NYbYB7hYRxNZXmyVfPH8qKuEISdEAvuX+4PI6/habGCQYpjI3aZ1/l27lO
         FHxkn3reJz4LVAAetc6KiCSmmk6lbzqGzMkEC1NKO9qmuQfR3KqF7T5tbm8RDo1Cgs/9
         8y99o6iWwJcGxmWM2Z3V4FB/xvaho7IxFjPvkatAVKg87FEFYv/a130nmYLIrMPR8YTT
         iAiw==
X-Gm-Message-State: APjAAAXfHUYj9fNV+1XmjzYCeiPt1M01cu0kkezU4Ik5xl1rU1KT170e
        V0G3XUiKkVvvXkfpnzKbhqJLGKowVz7PQWyTb3wP3g==
X-Google-Smtp-Source: APXvYqwFwie01ABPFi/VnwYag197buGFTQ/FM/qpCjhAqJ0fW94Xei/rjs0hwu+Rrk6alIe27zn9uJYl3/OHuXZQoxc=
X-Received: by 2002:a17:906:6993:: with SMTP id i19mr9566232ejr.259.1572448855629;
 Wed, 30 Oct 2019 08:20:55 -0700 (PDT)
MIME-Version: 1.0
References: <20191030131122.8256-1-vincent.whitchurch@axis.com>
 <20191030132958.GD31513@dhcp22.suse.cz> <20191030140216.i26n22asgafckfxy@axis.com>
 <20191030141259.GE31513@dhcp22.suse.cz>
In-Reply-To: <20191030141259.GE31513@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 30 Oct 2019 11:20:44 -0400
Message-ID: <CA+CK2bDObV=N1Y+LhDX=tYsTX3HZ+mbB=8aXT=fPX254hKEUBQ@mail.gmail.com>
Subject: Re: [PATCH] mm/sparse: Consistently do not zero memmap
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 10:13 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> [Add Pavel - the email thread starts http://lkml.kernel.org/r/20191030131122.8256-1-vincent.whitchurch@axis.com
>  but it used your old email address]
>
> On Wed 30-10-19 15:02:16, Vincent Whitchurch wrote:
> > On Wed, Oct 30, 2019 at 02:29:58PM +0100, Michal Hocko wrote:
> > > On Wed 30-10-19 14:11:22, Vincent Whitchurch wrote:
> > > > (I noticed this because on my ARM64 platform, with 1 GiB of memory the
> > > >  first [and only] section is allocated from the zeroing path while with
> > > >  2 GiB of memory the first 1 GiB section is allocated from the
> > > >  non-zeroing path.)
> > >
> > > Do I get it right that sparse_buffer_init couldn't allocate memmap for
> > > the full node for some reason and so sparse_init_nid would have to
> > > allocate one for each memory section?
> >
> > Not quite.  The sparsemap_buf is successfully allocated with the correct
> > size in sparse_buffer_init(), but sparse_buffer_alloc() fails to
> > allocate the same size from it.
> >
> > The reason it fails is that sparse_buffer_alloc() for some reason wants
> > to return a pointer which is aligned to the allocation size.  But the
> > sparsemap_buf was only allocated with PAGE_SIZE alignment so there's not
> > enough space to align it.
> >
> > I don't understand the reason for this alignment requirement since the
> > fallback path also allocates with PAGE_SIZE alignment.  I'm guessing the
> > alignment is for the VMEMAP code which also uses sparse_buffer_alloc()?
>
> I am not 100% sure TBH. Aligning makes some sense when mapping the
> memmaps to page tables but that would suggest that sparse_buffer_init
> is using a wrong alignment then. It is quite wasteful to allocate
> alarge misaligned block like that.
>
> Your patch still makes sense but this is something to look into.
>
> Pavel?

I remember thinking about this large alignment, as it looked out of
place to me also.
It was there to keep memmap in single chunks on larger x86 machines.
Perhaps it can be revisited now.

The patch that introduced this alignment:
9bdac914240759457175ac0d6529a37d2820bc4d

vmemmap_alloc_block_buf
+       ptr = (void *)ALIGN((unsigned long)vmemmap_buf, size);

Pasha
