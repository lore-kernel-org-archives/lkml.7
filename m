Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA8CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9BC2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kpUBX0ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfJUSc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 14:32:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37258 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfJUSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 14:32:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id 53so281710otv.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0e3LF7aKuz2iLw0mcj6oU7FpBQcB5Q8PDmzRJ1cFd9Q=;
        b=kpUBX0ruClnhJmvKIIzHN1Q4dn2+sfqWY7IUWOaBG0kl0XXLWEY/UD5emw1x8pnoxA
         M0shj/WOB1CKY6RhwXF5fySgQtZPj4vgKAz1Bqk624KDQE47uoit9Udq2oLFfj/QWzIT
         7LZJ6jtYaRTaYat8Dwota/2nNaJfbpfsxTcqt6cRmDliTzndexUk/M4Mr0kUPNiif7TK
         mES8A6X3XPgZErIxFsE2/I2/CZkNli5wHSJpqhIJqKmz8ZlmbHoOk0tW6J52FNwTCCQP
         p3HwyXvJlF0XaU9SKGbJDH/czU7lrMlKeSVBAeQ1rgr69q52knLyAXrJ2ikvXlcSrkOF
         dKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0e3LF7aKuz2iLw0mcj6oU7FpBQcB5Q8PDmzRJ1cFd9Q=;
        b=YP5F04nH4qh0M/p1acfACwRFb956D3sbOB0ea6n+aeGuEWqvfdgEra9llFaySLlYNF
         4ptFk0ILs3Jev9PA6o51P4a68cuOmYwALXzNq4FrVzF+7H6Ib4tPRz/MQFFsbHpRpgaJ
         x1cVJDc0u11FT25mfBOe0pB+V/z3Nf1LCLDRoxP5U5SBW7j3R3nQLMj7lVqVG5uEH6vi
         X6tjz8JqzuYtNNTpQ3aVzPHDkhzArW0OXtlpSaFHF17Dit0gM50okUaSOWV2fjtBRBW1
         85ypo3I69JqEd+QYV2eD6/umu4cVCPmDrCQcPrlujHMKaSsXpS+2BBDo4l2guSqR5cR0
         efIw==
X-Gm-Message-State: APjAAAUafhNdXE6BcocvwCCUKpXUfKCCdRQr/vatLwR8KEn/CaNUCPGk
        vTRnmaVf/qcfqxOPhXXYZLRKSAze4Bzo5tpFbNWC2g==
X-Google-Smtp-Source: APXvYqxAXUfQVl/EVFVJQCv8ArX0aLPCEDz5Jp59sqSiaykhOpeMwlsHfK2y9HsCUzb/LpNQcUsAKiuhGmgJsk2nJEE=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr2801767oth.102.1571682747558;
 Mon, 21 Oct 2019 11:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191018052323.21659-1-john.stultz@linaro.org>
 <20191018052323.21659-2-john.stultz@linaro.org> <20191018111832.o7wx3x54jm3ic6cq@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLUVLP0ujB0SHyWHMncRMHkBvVj1+CpBgGUD8Xg3RexQ8w@mail.gmail.com> <20191021093546.m5hgpjadtpu7d4km@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20191021093546.m5hgpjadtpu7d4km@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 21 Oct 2019 11:32:16 -0700
Message-ID: <CALAqxLVQpWgYhw+t33wGrZD_Q49JkgVMsa0mOg1LTapCH2pPUQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/5] dma-buf: Add dma-buf heaps framework
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 2:36 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> On Fri, Oct 18, 2019 at 11:26:52AM -0700, John Stultz wrote:
> > On Fri, Oct 18, 2019 at 4:18 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
> > > On Fri, Oct 18, 2019 at 05:23:19AM +0000, John Stultz wrote:
> > >
> > > As in v3:
> > >
> > >  * Avoid EXPORT_SYMBOL until we finalize modules (suggested by
> > >    Brian)
> >
> > Heh. I guess it has been awhile.  :)
> >
> > > Did something change in that regard? I still think letting modules
> > > register heaps without a way to remove them is a recipe for issues.
> >
> > So yea, in recent months, work around Android with their GKI effort
> > has made it necessary for ION heaps to be loadable from modules. I had
> > some patches in WIP tree to enable this, and in the rework I did
> > yesterday for the CMA module trivially collided with parts, and
> > forgetting the discussion back in v3, I figured I'd just fold those
> > bits in before I resubmitted for v12.
>
> Ah yes, I can see that would be needed.
>
> >
> > If it's an issue, I can pull it out, but I'm going to be submitting
> > module enablement for review as soon as the core bits are queued, as
> > its going to be important to support for Android to switch to this
> > from ION.
> >
>
> I don't know how to decide if it's an issue. My understanding is that
> if you rmmod something which has exported buffers, various Bad Things
> might happen; I believe including data leaks, corruption or crashing
> the kernel. There's probably plenty of scope for that with dma-buf
> exporters already, so it's not exactly "new" but it is a bit
> unfortunate.
>
> If "people" are OK with adding new code which has the same issue, then
> I'm not going to make any more of a fuss, because perfection is the
> enemy of progress. Perhaps an obvious comment pointing out the issue
> would be prudent, though - as a reminder to people that add heaps from
> their code (and wonder why there's no "dma_heap_remove" function).

Eh. If I need to respin anyway, I'll just remove the exports for now.

It's really just my fault for getting impatient and trying to squeeze
some extra changes in.

I'll then submit the module enablement patches separately.

Thanks again for the review, I really appreciate your sharp eye!
-john
