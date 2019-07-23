Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02382C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB27229EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 20:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDPrieZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfGWUKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 16:10:08 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38196 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfGWUKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 16:10:07 -0400
Received: by mail-ed1-f67.google.com with SMTP id r12so10299939edo.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 13:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tUGsIMqs+SNwG7Wa9YryBNQpEKIGP6cwaQO1e+qGdxc=;
        b=UDPrieZ62DZ2mz2+GrBJZ4KAevDIjPajIqVhkjl2OjmbVFtwXQggxYhH/QuuJAvk35
         1T6VBw9/33sOIL8raiWYoSMHWLIko/lgbzkxEZPp9dZ4Xn0O3GitxItv4t5EeELcg3tY
         V07jYxMBs4xXkAKNMyzbedqrCkl1yYzHG+0W2sfZIK7dKnDXnurviMo/kO+47YSr/t3p
         8LLJpiV1smiHKIiCDXDYCNc8IBPKlmCd1dGasujo7jS02GhqaVxBKFTurNAKtZiC7Rd4
         SHGu7j6p/OvE0lU1fUJFFIyKieaxXKU98sxS/cdL0mE+7/uyW5G6zWVvZKRdwXbKIWwl
         GK3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tUGsIMqs+SNwG7Wa9YryBNQpEKIGP6cwaQO1e+qGdxc=;
        b=GAF/9n7RK67HF9kTr9aiWs7vib9vZ4VREL8432HNM/43JS64WLtjnPm54be7aQFYGL
         F9Rm/Qv7FdV/dsn7oKKx/LaNufdNPp40RnGiZnTYqPUvxSA1mpjEJZB7WvjKjfcZ1b74
         BekdYxagGS1CVo8DJOlVl9mPVCikszqIp0BG+X0utCuAJvUtUpxNj/r8mvnJPOxgaSZQ
         1GaCpGFKjl1DcI72aDdn0atx0iHs4jFQq09lSVXtEWyKMmj9T1dXvomIiFaTmHIDBQhX
         AmZvv8Lb+DtBblSBOVTFgZr0+zO95Nikc9/yfSfNCf8J8+wBrQR1daaAH60FF8jN21N4
         pgfA==
X-Gm-Message-State: APjAAAWqG6m0Lxlte00H1lfZiJokzvZ4qlSqwxwhxwCx6YCWyTWNhxvx
        uwIaIyjohliONu9gxWBHV5XocXsdLmeZHzzENqY=
X-Google-Smtp-Source: APXvYqwhuDJQWXBFchqde9MjHuP6u9IF20GvxtLPj5ajprHQwMd007jx38zaufMthkY298kJ81UMcN1e0xvJwExaeSk=
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr60616455ejj.192.1563912606283;
 Tue, 23 Jul 2019 13:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190624194908.121273-1-john.stultz@linaro.org>
 <20190624194908.121273-3-john.stultz@linaro.org> <20190718100654.GA19666@infradead.org>
 <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
In-Reply-To: <CALAqxLX1s4mbitE-_1s1vFPJrbrCKqpyhYoFW0V6hMEqE=eKVw@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 23 Jul 2019 13:09:55 -0700
Message-ID: <CAF6AEGuM1+pimGNhyKHbYR0BdH=hH+Sai0es8RjGHE9jKHjngw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] dma-buf: heaps: Add heap helpers
To:     John Stultz <john.stultz@linaro.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        Sudipto Paul <Sudipto.Paul@arm.com>,
        "Andrew F . Davis" <afd@ti.com>,
        Xu YiPing <xuyiping@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        Yudongbin <yudongbin@hisilicon.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 9:09 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Thu, Jul 18, 2019 at 3:06 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Is there any exlusion between mmap / vmap and the device accessing
> > the data?  Without that you are going to run into a lot of coherency
> > problems.

dma_fence is basically the way to handle exclusion between different
device access (since device access tends to be asynchronous).  For
device<->device access, each driver is expected to take care of any
cache(s) that the device might have.  (Ie. device writing to buffer
should flush it's caches if needed before signalling fence to let
reading device know that it is safe to read, etc.)

_begin/end_cpu_access() is intended to be the exclusion for CPU access
(which is synchronous)

BR,
-R

> This has actually been a concern of mine recently, but at the higher
> dma-buf core level.  Conceptually, there is the
> dma_buf_map_attachment() and dma_buf_unmap_attachment() calls drivers
> use to map the buffer to an attached device, and there are the
> dma_buf_begin_cpu_access() and dma_buf_end_cpu_access() calls which
> are to be done when touching the cpu mapped pages.  These look like
> serializing functions, but actually don't seem to have any enforcement
> mechanism to exclude parallel access.
>
> To me it seems like adding the exclusion between those operations
> should be done at the dmabuf core level, and would actually be helpful
> for optimizing some of the cache maintenance rules w/ dmabuf.  Does
> this sound like something closer to what your suggesting, or am I
> misunderstanding your point?
>
> Again, I really appreciate the review and feedback!
>
> Thanks so much!
> -john
