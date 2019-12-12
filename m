Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBDC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49182073D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 18:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="maPM2tZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbfLLShb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 13:37:31 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42476 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730556AbfLLShU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:37:20 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so2980135otd.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 10:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1B/UNGsCwmC1+pJqLAouyE9mmdM7pF8h5qlTzJmepM=;
        b=maPM2tZhprhWJ8fGdLXGtuduyJLqtv8jHVXpR8MsjrvKfxln57l9tx7SQBE0x79WXG
         JTTEeWbwxB40FLQVnC8JWIRLHuRqBkbx+UEO2xiqTJMkqRR43jmWo8/ijA29BMgKxZzF
         pRbaLfVYKjiHG0ZlFXtVu0qJq+wygH/7GfYO2SGZ8flL9t/eDADFMUi8Tbuq2J7dT5XP
         t8KPom5Ai4JBxCwMBA0q5PnOVTN8bnhiFxJrwqdyDmqIJ7DeSRDbzMAmctnec3w8pnzY
         vr4TRtD9EiMW/XRBKaPZ+f32Ro1YFQwuefNhpQg2gHZJWlrOK5MLFhE3Cj0NeKqyMkIA
         npbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1B/UNGsCwmC1+pJqLAouyE9mmdM7pF8h5qlTzJmepM=;
        b=Ni11fkXAGNc1MTWkgEll7xA3OmdRngmYeL+CqGYAuEva8w85FHsyEZT32dSWqiPxwD
         vnBnCyQX6lysQyTf740Jb+2vVhUE8eR3//dD/U/NLOYq7vVOJiABoQKp+mYmwRSEOa2z
         DBLTMAUEDkfgaezvPi39BYRfgC3N1NRZbRoD/hwjZfbXOHYNTGsZbNbQHTv99Ojdv3Sn
         VCiHxUNVKFQrbxKdA3WD375VbU7PqaYKKNRDssC+TiBQVIKblAHol7DGA4GiuUhHNHuU
         WRJfwPi309J4+EhtEG6mVbysppajq25LBAORFOq8g7I5DPvlOXwWpLFNsSsxY726xb6I
         7Fsw==
X-Gm-Message-State: APjAAAWT+eBFYgxKNqTPbEcsSZGiDi+ayOdrXrCFHeUzV9/0e0qhDIOQ
        X5volKF2QZXKGYwVoMnwj6QCIhzu9xiwbswLOD3dCQ==
X-Google-Smtp-Source: APXvYqzGXtxFv/xAOdG4yuw4XMjJzisV/2WrZaI4CvisC/5ifMvFJFK7rjYngU/ZzkzTFlSG0bYUjpSWRdFRyc4eJlM=
X-Received: by 2002:a05:6830:1097:: with SMTP id y23mr9517020oto.332.1576175839578;
 Thu, 12 Dec 2019 10:37:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203172641.66642-1-john.stultz@linaro.org>
 <20191203172641.66642-4-john.stultz@linaro.org> <59d42752-e5b1-a1e0-0978-dff0824e2ebd@ti.com>
In-Reply-To: <59d42752-e5b1-a1e0-0978-dff0824e2ebd@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 12 Dec 2019 10:37:08 -0800
Message-ID: <CALAqxLXir0sLSP_94GeoQzw1aD8tGzt1Boc0jrKvcJYZKAQ8pQ@mail.gmail.com>
Subject: Re: [RESEND][PATCH v16 3/5] dma-buf: heaps: Add system heap to dmabuf heaps
To:     "Andrew F. Davis" <afd@ti.com>
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
        Alistair Strachan <astrachan@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hillf Danton <hdanton@sina.com>,
        Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 8:20 AM Andrew F. Davis <afd@ti.com> wrote:
> On 12/3/19 12:26 PM, John Stultz wrote:
> > +static int system_heap_create(void)
> > +{
> > +     struct dma_heap_export_info exp_info;
> > +     int ret = 0;
> > +
> > +     exp_info.name = "system_heap";
>
>
> nit: Would prefer the name just be "system", the heap part is redundant
> given it will be in a "heaps" directory, other heaps don't have that. As
> the heap will be accessed by users using this name:
> (/sys/dma_heap/system_heap) we need to think of it like an ABI and get
> it right the first time. The directory name should probably also be
> plural "heaps" as it is a collection of heaps..

Wish this thought had come up earlier. Again, not bad suggestions,
just a bit late as the patches have been queued in drm-misc-next.

Can you submit a tack-on patch to address this, and we can see about
pulling it in so it lands before the code heads to Linus?

thanks
-john
