Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B35FCA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268F2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1lIoRWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfKDTg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:36:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45906 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfKDTgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:36:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id 77so11023527oti.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXh+XyYjVt4Pkzk3hYB9YYJ9vT2OyZQipdsfPeD6n3s=;
        b=H1lIoRWjL4OYFkpqlyx8OmO6lY+KBz2M7Mz7iGNOYJa0J54H7QwoSEcuN/GSu+2AH0
         dFTzflkEqNe4Rm8kNrdSE2dvUX/YYWqAw89dXD0sp6/NXQYXmKIaLgQQSYw3qeOqTixZ
         nVjY8fLdmXHWlXOO2x5K7YMNc6hbyXyzdBIGJvWb82qxFUpwtr0H6DjGH3wVsVGCsMJn
         BXcdZxNaLamch4iTtp5zelRitudQkMU1s5KITIfPtfTbulq9AyOfOxo84ro30uj5vvSp
         lIf0syfuOUxAlFdvPw2y1mdmxjmSgiQbKY2t/5DRtXsYywV5UNIe8IGJhNhbU/eCulSC
         qmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXh+XyYjVt4Pkzk3hYB9YYJ9vT2OyZQipdsfPeD6n3s=;
        b=Yt3XFXXhbXUZmu0l0XYlB/nPQXqpZS+2LGgesxyGYTxf3nu/aTuwwS+yAmtZD+3LbB
         jb6pbT5tA19vJ1aeBLBnXDpit1QReB5yXHcb8Hzk1wCUggm0MTK3P9QaZtSbc2oT1FoV
         7kdNT4qpar/5YqEj3FTQZrYIivJvZIWj8mYh/qH4JPzx0ZEwzY1MuseBSYpRt8DAo8XB
         yPpsY0pJEEuZdazX0GL2g0y44nhJxImUQNgLr/40dVK/ik+Li6KmYRuF3/9+G8Xib4bY
         N8JGPrSa1hTIC+WYB8vClqN7exQk4wAq7CL0ovpytwI2t1/g+tw7tEhTEjcc9JrJdgQZ
         OTvg==
X-Gm-Message-State: APjAAAWc0pr5XqcTC/TKIxwkDNLDI2kY+jSjg1oWx/1VkzlZyBU2voE2
        +S9JQSuFDSSabLzd5G+vfOlliAoZBMQr2SHfn5wtZg==
X-Google-Smtp-Source: APXvYqzfbbYgLTNfmyd+UspCAlEURyP4S8sOC8DTJ2KyVYYSpmCqgONBTPwkfMiVfz9R9z9xnGRv0uSAtsP7KUaF12s=
X-Received: by 2002:a05:6830:ca:: with SMTP id x10mr18725811oto.221.1572896183903;
 Mon, 04 Nov 2019 11:36:23 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-3-john.stultz@linaro.org> <20191103161348.GB13344@google.com>
 <CALAqxLUhot_nceaw5zpJ7QXcsfHNL8bOV-3MOeKu9c76Tfzx=g@mail.gmail.com>
In-Reply-To: <CALAqxLUhot_nceaw5zpJ7QXcsfHNL8bOV-3MOeKu9c76Tfzx=g@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 11:36:12 -0800
Message-ID: <CALAqxLWjFKVQ_vVYThBo0+wGgee1EXyPTcqTPHEG5cY+eZ+dJg@mail.gmail.com>
Subject: Re: [PATCH v14 2/5] dma-buf: heaps: Add heap helpers
To:     Sandeep Patil <sspatil@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chenbo Feng <fengc@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        sspatil+mutt@google.com, "Andrew F . Davis" <afd@ti.com>,
        Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:34 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Sun, Nov 3, 2019 at 8:13 AM <sspatil@google.com> wrote:
> > On Fri, Nov 01, 2019 at 09:42:35PM +0000, John Stultz wrote:
> > > Add generic helper dmabuf ops for dma heaps, so we can reduce
> > > the amount of duplicative code for the exported dmabufs.
> > >
> > > This code is an evolution of the Android ION implementation, so
> > > thanks to its original authors and maintainters:
> > >   Rebecca Schultz Zavin, Colin Cross, Laura Abbott, and others!
> > >
> > > Cc: Laura Abbott <labbott@redhat.com>
> > > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > Cc: Liam Mark <lmark@codeaurora.org>
> > > Cc: Pratik Patel <pratikp@codeaurora.org>
> > > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > > Cc: Vincent Donnefort <Vincent.Donnefort@arm.com>
> > > Cc: Sudipto Paul <Sudipto.Paul@arm.com>
> > > Cc: Andrew F. Davis <afd@ti.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Chenbo Feng <fengc@google.com>
> > > Cc: Alistair Strachan <astrachan@google.com>
> > > Cc: Hridya Valsaraju <hridya@google.com>
> > > Cc: Sandeep Patil <sspatil@google.com>
> > > Cc: Hillf Danton <hdanton@sina.com>
> > > Cc: Dave Airlie <airlied@gmail.com>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> > > Acked-by: Laura Abbott <labbott@redhat.com>
> > > Tested-by: Ayan Kumar Halder <ayan.halder@arm.com>
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> >
> > I have one question and a naming suggestin below (sorry).
> >
> > Acked-by: Sandeep Patil <sspatil@android.com>
>
> > > +
> > > +static void dma_heap_buffer_vmap_put(struct heap_helper_buffer *buffer)
> > > +{
> > > +     if (!--buffer->vmap_cnt) {
> >
> > nit: just checking here cause I don't know the order in which vmap_get() and
> > vmap_put() is expected to be called from dmabuf, the manual refcounting
> > based map/unmap is ok?
> >
> > I know ion had this for a while and it worked fine over the years, but I
> > don't know if anybody saw any issues with it.

Sorry, I hit send before replying to this bit. I'll double check on this.

thanks again for the review!
-john
