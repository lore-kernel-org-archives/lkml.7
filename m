Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCD1C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9289521739
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JjoVzq8e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfLPVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:14:02 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37759 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfLPVOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:14:01 -0500
Received: by mail-il1-f196.google.com with SMTP id t8so5158145iln.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScEgdn7td6K2AI+QFF092h38Iaa+VFJSkrPG9BcVwIc=;
        b=JjoVzq8evnG1icA/FtopLUdXEb40mvSQ0C965AomDw1ZpMxVKvh8bqXaP8m0+NxVtZ
         +yxzzGrofpGvvYQ+KsveN/bZFU9GQgHEpfhAeGd6HPSk9PT3WDpeItFfOCtJdCoOW2XD
         14pqovdsi9xZ/PhVdfQ1oYj2foEYctqqZv2g/BWnQdoezCCyQTlbC7GDKGpFsXgka5Dd
         xVokR0JbVhSznTyx/OeUuy0k5O06bKQrGklYpaA1N5TuE2WjdkWp6T1hla1d2bQsZQ5+
         lJumWqjfOcvOoBwBhvXIAkvSRtb8eAg4hPBmojfPPbCMDcIoCIUKBzJ8e81qNHVHA8bK
         Nz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScEgdn7td6K2AI+QFF092h38Iaa+VFJSkrPG9BcVwIc=;
        b=YeCOKZYRrrZcJJMHW8fPWcmv9yjBJui9KBcSgsYKaAbC365ZY9T7Cik5WUm1XRU8C3
         jwjJ0AZQXpJpF0mi8wRektP5P7DhxaMBCuXUqtIQ4gbZP8wrCX4S+1PFpPJIljMvcph3
         hO7WKkPzou4g7UifSI0pXvVJyuBkR8Eurez+7mQ9eIlF06zANvaUTCAzwlE5KZ0I40eP
         Hc2rxmWfbSDRTBcpbseUQBBHTyAxduL3Il2gruOhI5PMV3Gpyvdbcqxk3/oOlhRNVPrx
         GC+FKPBU2MabruHO4H7ZCt4lWUuPCz5yRw5p+4ZY+8Z7teQlso+PDZSJqD0LM7i1KG6H
         4rFg==
X-Gm-Message-State: APjAAAXkdr0mCbIJkHn8IG4kcEXdXKXzFr3CLYhWKD5Zo8KT+jnBhTO0
        9IEXmhZBv5eejoVvVUEoa7b8QZiuHRqM/kBuCmkNxg==
X-Google-Smtp-Source: APXvYqwcLLmtNs0dAvpxYBX6LtdSa6EiRvef1XeYW0zzM03UEWa1PdIyxhPK8EMM7ulemON/T2tzskJyV423SW9L3wA=
X-Received: by 2002:a92:2550:: with SMTP id l77mr13210229ill.21.1576530841155;
 Mon, 16 Dec 2019 13:14:01 -0800 (PST)
MIME-Version: 1.0
References: <c1244a5f-b82a-baee-262a-7241531036ad@ti.com> <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1576503511-27500-1-git-send-email-zhongjiang@huawei.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 16 Dec 2019 13:13:50 -0800
Message-ID: <CALAqxLWAWc6NZDnixWhmHg6BtGHXTy6pZ6GXM0F=SkoYH8DiQw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-heap: Make the symbol 'dma_heap_ioctl_cmds' static
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     "Andrew F. Davis" <afd@ti.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 5:43 AM zhong jiang <zhongjiang@huawei.com> wrote:
>
> Fix the following sparse warning.
>
> drivers/dma-buf/dma-heap.c:109:14: warning: symbol 'dma_heap_ioctl_cmds' was not declared. Should it be static?
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/dma-buf/dma-heap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 4f04d10..da2090e 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -106,7 +106,7 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
>         return 0;
>  }
>
> -unsigned int dma_heap_ioctl_cmds[] = {
> +static unsigned int dma_heap_ioctl_cmds[] = {
>         DMA_HEAP_IOC_ALLOC,
>  };

Acked-by: John Stultz <john.stultz@linaro.org>

This patch will collide with Andrew's _IOCTL_ naming change, but its a
fairly simple thing to resolve.

Sumit: If you're comfortable resolving the collision, please queue
with the rest of the recent changes for drm-misc-next.
Otherwise, I'm happy to submit the resolution I tested with here
afterwards. Let me know.

thanks
-john
