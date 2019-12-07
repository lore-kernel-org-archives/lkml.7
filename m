Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7165C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A4421835
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 12:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HddGJfrG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sqpm6+eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLGMUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 07:20:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60013 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbfLGMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 07:20:32 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7645C227EE;
        Sat,  7 Dec 2019 07:20:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 07 Dec 2019 07:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6JSzrQgu3sDPwpghkTBapwQmdsO
        NUjx1H15lfpZN1X0=; b=HddGJfrGI/v4bHjcctOS7Z3MfncJI8eOFORHuFSJCPd
        P760/sbjTrcW/zyWI+tqfgWt6xAi0FsL+upgqR15vpttHErjBWStqDsoUr6gQB0+
        kyKzSCDlJ6tdLyDKHLspw96vo/QJX/zCu3P3dQfwetndx6c77Rbofs9tol6Ow6nG
        Jk/uYtKo6D+Vp76sx4pUikv7tP4Z11vd5fY0jvHKNv2AaRus6ZVYBIMManBObI0V
        NiMb2Swzw8RiIgsELI0WsxmYJygB1uOMzYSYjM2Ijxwjz2wwQ1tX4fhZhCB5DKTs
        oqI1jO1SA3WdqU7M15WGVEH0eJWJ9TTXdh3/jiAIQVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=6JSzrQ
        gu3sDPwpghkTBapwQmdsONUjx1H15lfpZN1X0=; b=Sqpm6+eCOry63ktKqhdHvF
        y+RgKHtDlWk0ggGQTxgDbnZfZ95TU58R3BWzkGFiTXQT7UgHUw1VrMgInsJs7F+q
        prrl/E0IyvrE2YzBF7JNDH7wqNnWJ6B1BOaePg9cunOJccUBYlMv3DgjWcrQAiBf
        hcLBckn9SWB4K12dUBC11LnFneqNGCQjrzve3I0AEPaA3Yk6hzG/KnBxOB+Jo3dY
        ixjvQ0HiMWlnSVaJn8TIzHCfhvobpOfqzKVfiRG+XVZ4FK0MaIASAc673uJ1uC2Y
        1lJ0/gfkkTQelchCvW8bU8hOLlFbr7phEdzc7FPJRgtCyvX9g8YV8clG96t7+IiA
        ==
X-ME-Sender: <xms:D5nrXYhB1lG2JZ_K692iZucMfyL1y65NK8cJr83LvYNHektTDHqksw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeefrdekiedrkeelrddutd
    ejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucev
    lhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:D5nrXQc74ctMZUPjz5lvty9-Qy8ZLpP323uSb1Vk8IyekcTYm4StYw>
    <xmx:D5nrXRJxjTpYsABeX9whbLnpZfDOpZ3FCgaVFSmA5wIbitakQX43eA>
    <xmx:D5nrXdnDEQ73U6D4zpDc_jXf7PPPwXWz_riPqg3PNYvPygHioHzF1Q>
    <xmx:D5nrXYR_-8iqJa5F3wSDF1KhtmvgiooVZ1mmawNRQf_b-IUEyXV1oA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACEF580063;
        Sat,  7 Dec 2019 07:20:30 -0500 (EST)
Date:   Sat, 7 Dec 2019 13:20:29 +0100
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     p.zabel@pengutronix.de, stable-commits@vger.kernel.org
Subject: Re: Patch "media: coda: fix memory corruption in case more than 32
 instances are opened" has been added to the 4.4-stable tree
Message-ID: <20191207122029.GA395017@kroah.com>
References: <20191206212445.379A92467A@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206212445.379A92467A@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 04:24:44PM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     media: coda: fix memory corruption in case more than 32 instances are opened
> 
> to the 4.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      media-coda-fix-memory-corruption-in-case-more-than-3.patch
> and it can be found in the queue-4.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 0aecc2dd80345b10cd6ab210a77b3ecc83ca4bdc
> Author: Philipp Zabel <p.zabel@pengutronix.de>
> Date:   Tue Nov 6 05:40:54 2018 -0500
> 
>     media: coda: fix memory corruption in case more than 32 instances are opened
>     
>     [ Upstream commit 649cfc2bdfeeb98ff7d8fdff0af3f8fb9c8da50f ]
>     
>     The ffz() return value is undefined if the instance mask does not
>     contain any zeros. If it returned 32, the following set_bit would
>     corrupt the debugfs_root pointer.
>     Switch to IDA for context index allocation. This also removes the
>     artificial 32 instance limit for all except CodaDx6.
>     
>     Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
>     Signed-off-by: Hans Verkuil <hansverk@cisco.com>
>     Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/media/platform/coda/coda-common.c b/drivers/media/platform/coda/coda-common.c
> index 323aad3c89de6..154aa7d73a8d2 100644
> --- a/drivers/media/platform/coda/coda-common.c
> +++ b/drivers/media/platform/coda/coda-common.c
> @@ -17,6 +17,7 @@
>  #include <linux/firmware.h>
>  #include <linux/gcd.h>
>  #include <linux/genalloc.h>
> +#include <linux/idr.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
> @@ -1644,17 +1645,6 @@ int coda_decoder_queue_init(void *priv, struct vb2_queue *src_vq,
>  	return coda_queue_init(priv, dst_vq);
>  }
>  
> -static int coda_next_free_instance(struct coda_dev *dev)
> -{
> -	int idx = ffz(dev->instance_mask);
> -
> -	if ((idx < 0) ||
> -	    (dev->devtype->product == CODA_DX6 && idx > CODADX6_MAX_INSTANCES))
> -		return -EBUSY;
> -
> -	return idx;
> -}
> -
>  /*
>   * File operations
>   */
> @@ -1663,7 +1653,8 @@ static int coda_open(struct file *file)
>  {
>  	struct video_device *vdev = video_devdata(file);
>  	struct coda_dev *dev = video_get_drvdata(vdev);
> -	struct coda_ctx *ctx = NULL;
> +	struct coda_ctx *ctx;
> +	unsigned int max = ~0;
>  	char *name;
>  	int ret;
>  	int idx;
> @@ -1672,12 +1663,13 @@ static int coda_open(struct file *file)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	idx = coda_next_free_instance(dev);
> +	if (dev->devtype->product == CODA_DX6)
> +		max = CODADX6_MAX_INSTANCES - 1;
> +	idx = ida_alloc_max(&dev->ida, max, GFP_KERNEL);
>  	if (idx < 0) {
>  		ret = idx;
>  		goto err_coda_max;
>  	}
> -	set_bit(idx, &dev->instance_mask);
>  
>  	name = kasprintf(GFP_KERNEL, "context%d", idx);
>  	if (!name) {
> @@ -1771,8 +1763,8 @@ err_clk_per:
>  err_pm_get:
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
> -	clear_bit(ctx->idx, &dev->instance_mask);
>  err_coda_name_init:
> +	ida_free(&dev->ida, ctx->idx);
>  err_coda_max:
>  	kfree(ctx);
>  	return ret;
> @@ -1811,7 +1803,7 @@ static int coda_release(struct file *file)
>  	pm_runtime_put_sync(&dev->plat_dev->dev);
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
> -	clear_bit(ctx->idx, &dev->instance_mask);
> +	ida_free(&dev->ida, ctx->idx);
>  	if (ctx->ops->release)
>  		ctx->ops->release(ctx);
>  	debugfs_remove_recursive(ctx->debugfs_entry);
> @@ -2192,6 +2184,7 @@ static int coda_probe(struct platform_device *pdev)
>  
>  	mutex_init(&dev->dev_mutex);
>  	mutex_init(&dev->coda_mutex);
> +	ida_init(&dev->ida);
>  
>  	dev->debugfs_root = debugfs_create_dir("coda", NULL);
>  	if (!dev->debugfs_root)
> @@ -2276,6 +2269,7 @@ static int coda_remove(struct platform_device *pdev)
>  	coda_free_aux_buf(dev, &dev->tempbuf);
>  	coda_free_aux_buf(dev, &dev->workbuf);
>  	debugfs_remove_recursive(dev->debugfs_root);
> +	ida_destroy(&dev->ida);
>  	return 0;
>  }
>  
> diff --git a/drivers/media/platform/coda/coda.h b/drivers/media/platform/coda/coda.h
> index 96532b06bd9e1..239f6bb2fca42 100644
> --- a/drivers/media/platform/coda/coda.h
> +++ b/drivers/media/platform/coda/coda.h
> @@ -16,6 +16,7 @@
>  #define __CODA_H__
>  
>  #include <linux/debugfs.h>
> +#include <linux/idr.h>
>  #include <linux/irqreturn.h>
>  #include <linux/mutex.h>
>  #include <linux/kfifo.h>
> @@ -93,7 +94,7 @@ struct coda_dev {
>  	struct v4l2_m2m_dev	*m2m_dev;
>  	struct vb2_alloc_ctx	*alloc_ctx;
>  	struct list_head	instances;
> -	unsigned long		instance_mask;
> +	struct ida		ida;
>  	struct dentry		*debugfs_root;
>  };
>  

This breaks the build in 4.4, 4.9, and 4.14 kernels, so I've dropped it
from there.
