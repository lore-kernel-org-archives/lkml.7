Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E6BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B5D24655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="stQ7HrR8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfLQRI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:08:26 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45514 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfLQRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:08:26 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so5918346oiv.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 09:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MX5ryTLyNj1gEJN4sAxITw/PDa3L7q0z0atwMq1Sllw=;
        b=stQ7HrR8NLUsEd/uKcjLTm8K2InQYMIR3k0x+rFPgURFB5KG0yx3arx4y53sIfEArF
         2sW/VixVADH95/PrHcDkWXFVxsxOm1TlwOsRAvpt9JB+6Ksj8iGT/tOhpqyRvBkaYAUY
         2y+TMFjlTYh2vIh8gkkzzsV2PkH3GHk4/YnI0pEKe4uAO2reLYCxjxfPwVqineaigDgA
         PduA30a6IOlQ7RpPm1BvTwcDJTuDHH/xdiRSvKo1KIOo9rWbdqW8lh6D+hTedNl4z0EU
         wJM7b5eSXJRTD8qRAvE8vZFzOiSDUzQ8wMbJFmYzyzNWKozoRIuT2KtNsz0cH2SjVvb+
         I3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MX5ryTLyNj1gEJN4sAxITw/PDa3L7q0z0atwMq1Sllw=;
        b=rr6VXAd5u2O49dt5L7R79MIl9GI3t6mk61LGarCY1iwhPbca6PAUuXnywaZTXQgcbD
         UilvAXack08Rw3dHCZQG8DVCScSn6XhXD3W7eLkjqM5XQ8dHU/Dwi5u3E6+1vD3n6nVP
         HK2BODSadWdeYBIfzFVknuYROSrBjtIuKhYng22aO8rvUliEBZSOXmtZ/mXQfrvzljSF
         rHH7X4T5QTLlEgueIbU7Jqyz7gBiFBiyP/Nipmj8Hj89KCYOTdAFrTazLjQXimrdvM3Z
         IREkjDtWj7t1HM7Cbvcbh/smXPnF6s6K35Tc9dk0cMEdHYdez5LIWjSTmf2Rey0iNy3b
         nqzA==
X-Gm-Message-State: APjAAAXttq8NUuDUy3dUUG/R7iEKLfLTB+aGKrfdqKOoklKsLkxcdNui
        uaErb2m+vOmp2cfmnqW2UqfVC6aQPtkErfsWoKDPig==
X-Google-Smtp-Source: APXvYqxLG7bWE9YdSVjIU8t3m/nXCwJvl2pBOamYDowsUPR2xloYjm0CkOITzBgkXp6Y+XU6F55krB3cB8r5tqx42h4=
X-Received: by 2002:aca:5fc6:: with SMTP id t189mr2244612oib.166.1576602505161;
 Tue, 17 Dec 2019 09:08:25 -0800 (PST)
MIME-Version: 1.0
References: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com> <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
 <CALAqxLWAWc6NZDnixWhmHg6BtGHXTy6pZ6GXM0F=SkoYH8DiQw@mail.gmail.com> <5DF83CEC.5060002@huawei.com>
In-Reply-To: <5DF83CEC.5060002@huawei.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 17 Dec 2019 22:38:11 +0530
Message-ID: <CAO_48GFzdM9ZsNYTRc1JVQxUQ77TtVCYdUcCGQzkJDf-Ob=L-Q@mail.gmail.com>
Subject: Re: [PATCH v2] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zhong Jiang,

On Tue, 17 Dec 2019 at 07:56, zhong jiang <zhongjiang@huawei.com> wrote:
>
> On 2019/12/17 5:13, John Stultz wrote:
> > On Mon, Dec 16, 2019 at 5:43 AM zhong jiang <zhongjiang@huawei.com> wrote:
> >> Fix the following sparse warning.
Thanks for the patch; could I request you to please use
scripts/get_maintainer.pl to get the cc: list for the patches?

+ dri-devel.
> >>
> >> drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds' was not declared. Should it be static?
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  drivers/dma-buf/dma-heap.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> >> index 4f04d10..da2090e 100644
> >> --- a/drivers/dma-buf/dma-heap.c
> >> +++ b/drivers/dma-buf/dma-heap.c
> >> @@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
> >>         return 0;
> >>  }
> >>
> >> -unsigned int dma_heap_ioctl_cmds[] = {
> >> +static unsigned int dma_heap_ioctl_cmds[] = {
> >>         DMA_HEAP_IOC_ALLOC,
> >>  };
> > Acked-by: John Stultz <john.stultz@linaro.org>
> >
> > This patch will collide with Andrew's _IOCTL_ naming change, but its a
> > fairly simple thing to resolve.
> >
> > Sumit: If you're comfortable resolving the collision, please queue
> > with the rest of the recent changes for drm-misc-next.
> > Otherwise, I'm happy to submit the resolution I tested with here
> > afterwards. Let me know.
Of course, I am sure I can handle collisions, John, or else being a
maintainer might get a tad difficult :)
> As it is an fairly simple patch, I hope you can resolve the issue directly.
>
> Thanks,
> zhong jiang
> > thanks
> > -john
> >
Best,
Sumit.
