Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C146CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C632084D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwZbZIBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfKDScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:32:51 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34430 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:32:51 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so15042666oig.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuoEqQL2KebTopf41oEH+8ZFIOF1Y0zb5FGL5THAEuM=;
        b=ZwZbZIBWQ+1OPsCtH8o21sKLwWYTv0Kawog0LE/+kqZNZkKsrkMxmIP2M2Fb9jXc7H
         PfBqNkyAv4wjM1gG1iSziv44ViPJDPX9/dSI9wUBBPa3fkwlAFoHnhh9qBZBvkqzlee9
         UVbTycJm7wH3UBOVZm0jBLDmKjfKhsthLVfDpqxEnOkFamie1kQZ1YwX6Z4xjkx4PKu1
         IAQFGY0QW6ISt3Yd7pbZg2zTQXAT6TQ1R5VemL4iN1V6uMgMOnGbP6Wq6fklFoGWEpeD
         tzQntg3Xf6gSomNDRKzSt0EiGf+gzvgF3idrJbJPMNKYifm2EjJTUaE+2oEG5hnqaSZm
         KTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuoEqQL2KebTopf41oEH+8ZFIOF1Y0zb5FGL5THAEuM=;
        b=QLzuFf0hzrKUfKra3bwiiX/wNpxGrDJix7FL5XiT00DySqsKFe8DovBPGru5FlG161
         8bBXHrOkpnSEuEZbQ7qW/uXCWdb2v3evr2e/fhvYozJv5ExdYV8bB9ONxtiMIePkbaGW
         WBdr/r7fqRZxDTBy7rNHf7vaahUWYZXqaAT4Iw+xGfVzXYWJJnWsHZ1J5W5P+Wi99jyv
         iPbQZnrGp4xP8T/y+8Sc+jnFfL2I1bND9FKyI48VeEGT8dQkQHp+x4HHpn4aRSyYIX/3
         otyyaR7GUrlqaVWt+D4nn55EuW0HmoyQAhqkD34fNgSwl1W8yo/Z8v2wIqGbKPhVmats
         kCQw==
X-Gm-Message-State: APjAAAVaQpqSqUlMIQEF4w1NecDRMMGudEeiuGKO07bwsSM90ZyoSwYF
        qMsMIf2t6KkkH55I901MtXQJLZRr99wFeDVhc0U7Xw==
X-Google-Smtp-Source: APXvYqxzL7/7wJOJVUvH16w+QAISOOtNnm2/b5W3JNn1FGUmUr3Uh54+UjraGD6AcXkBB/veySBVsA+RG1Rjuz032Rw=
X-Received: by 2002:aca:c64c:: with SMTP id w73mr363929oif.161.1572892369118;
 Mon, 04 Nov 2019 10:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20191101214238.78015-1-john.stultz@linaro.org>
 <20191101214238.78015-2-john.stultz@linaro.org> <20191103160225.GA13344@google.com>
In-Reply-To: <20191103160225.GA13344@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 4 Nov 2019 10:32:38 -0800
Message-ID: <CALAqxLXjRmWWTiQNZnypk+r7am9STd_UBDgK4b73icS8UfZwpA@mail.gmail.com>
Subject: Re: [PATCH v14 1/5] dma-buf: Add dma-buf heaps framework
To:     Sandeep Patil <sspatil@google.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>, Laura Abbott <labbott@redhat.com>,
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
        sspatil+mutt@google.com, Alistair Strachan <astrachan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 3, 2019 at 8:02 AM <sspatil@google.com> wrote:
> > +static long dma_heap_ioctl_get_features(struct file *file, void *data)
> > +{
> > +     struct dma_heap_get_features_data *heap_features = data;
> > +
> > +     /* nothing should be passed in */
> > +     if (heap_features->features)
> > +             return -EINVAL;
>
> curious, what are we trying to protect here? Unless I misunderstood this, you
> are forcing userspace to 0 initialize the structure passed into the ioctl.
> So an uninitialized stack variable passed into ioctl() will end up returning
> -EINVAL .. I am not sure thats ok?

Yea, so the rational mostly comes from the document here:
  https://www.kernel.org/doc/Documentation/ioctl/botching-up-ioctls.rst

The general idea is to be very conservative in what you accept on
IOCTLs to avoid any extensions made from breaking existing userland.

Usually this is most critical for write-ioctls, and probably isn't as
important for read ones like get_features, but I don't see much
downside to enforcing it.

> Plus, the point is pointing into the kmalloc'ed memory or the local 'char
> stack_data[128] from the ioctl() function, so not sure if this check was
> intentional? If so, may be easier to 0 initialize *kdata in the ioctl
> function below?

So the bits in the kdata (be it kmalloced or on the stack) is all
copied over from the userpointer. So we're just trying to enforce that
userland zeros it before passing it in.

Thanks again for your other feedback, I'll address them in the next revision!

thanks
-john
