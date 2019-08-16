Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C2C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25B62133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 20:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfHPUOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 16:14:35 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52506 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbfHPUOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 16:14:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 103FC28D215
Message-ID: <43d7adfb9ae9d25fc7c6093d3119c62f742df2cb.camel@collabora.com>
Subject: Re: [PATCH] dma-buf: Fix memory leak in dma_buf_set_name
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Bharath Vedartham <linux.bhar@gmail.com>, sumit.semwal@linaro.org
Cc:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Aug 2019 17:14:24 -0300
In-Reply-To: <1565978422-9661-1-git-send-email-linux.bhar@gmail.com>
References: <1565978422-9661-1-git-send-email-linux.bhar@gmail.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bharath,

Thanks for taking the time to try to fix this report.

However, this doesn't look right.

On Fri, 2019-08-16 at 23:30 +0530, Bharath Vedartham wrote:
> This patch fixes a memory leak bug reported by syzbot. Link to the
> bug is given at [1].
> 
> A local variable name is used to hold the copied user buffer string
> using strndup_user. strndup_user allocates memory using
> kmalloc_track_caller in memdup_user. This kmalloc allocation needs to be
> followed by a kfree.
> 
> This patch has been tested by a compile test.
> 
> [1] https://syzkaller.appspot.com/bug?id=ce692a3aa13e00e335e090be7846c6eb60ddff7a
> 
> Reported-by: syzbot+b2098bc44728a4efb3e9@syzkaller.appspotmail.com
> Signed-off-by: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/dma-buf/dma-buf.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index f45bfb2..9798f6d 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -342,6 +342,7 @@ static long dma_buf_set_name(struct dma_buf *dmabuf, const char __user *buf)
>  	}
>  	kfree(dmabuf->name);
>  	dmabuf->name = name;
> +	kfree(name);
>  

Just by looking at this, you can deduce something is not right.
You are assigning "name" to dmabuf->name, but then releasing "name"!

So now, dmabuf->name has free memory, which will lead to
user-after-free issues.

Note also, that this function doesn't look leaky since the previous
"name" is freed, before setting a new one.

Maybe the syzbot report is some kind of false positive?

Also, I _strongly_ suggest that in the future you don't compile-test
only these kind of not trivial fixes. Since you are touching a crucial
part of the kernel here, you should really be testing properly.

Specially since syzbot produces a reproducer.

Consider compile test as something you do when your changes are
only cosmetic, and you are completely and absolutely sure things
will be OK.

Thanks.
Ezequiel

