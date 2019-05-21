Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B961C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D762173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 03:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="IlqI0+2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvCshKjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfEUDww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 23:52:52 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:60243 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfEUDwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 23:52:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 12E17220CB;
        Mon, 20 May 2019 23:52:50 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 20 May 2019 23:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=CC/jy/bRvOYRgoOmXfaJKCbLZbEtDlY
        CR75APZeAq5c=; b=IlqI0+2NQIeOAlPA6YD6EwqarCq2JKxUzwoTd8cBJvx34h4
        fUUoX/WO4w5+uDp+V8wFkrTxME8DkH/YNFZchTndg8Pu4NoNrWEzvnvxUwrQPmpK
        GZ59yUuRC8wJVlVhdegqjKiFcz2ZoXzwxhpet4cjfIkY3vx7h8/dFrarhPX5YKg9
        wuH8+5CXyw0K1Qh83MhgMck/xznSaQafFz6oCPOqriLmShe0B/ijTTBj6ZGzLiqA
        fW1lW8upaU04LaPyqmLSOjBAtluFYPFcJNp7axX7EVc6z2CSStgTjAaeBe/ZmZLn
        Qxtuep+2UgSdz6mkXyhAzwmG8uxUiM8HBjD/5jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CC/jy/
        bRvOYRgoOmXfaJKCbLZbEtDlYCR75APZeAq5c=; b=IvCshKjwBc+sU1LCXswPkJ
        aZuTyQSZS6m8ZaVMW3oZ0jVjOssBmk4YEUtG1ufFF/LpTzJIRXnhWvKAEV0nD7SP
        xL8VujAOT0QFjPwMw5YuA++Xkulh31ShKp/F3pLhErA9tX3yCZFXlP2OJPHi46z5
        ZcEoOpd/JhaYb/GYYoGSQHmJtzSFsiQx3EooD39GcGWJJPWUDo/ZtogHkfR6ad7A
        bqcbKrPh6SZgVcfb6XIl50T0kxWY5s+13Lvm9ZMfR0Om3MltJiBmM7amjHagbV8T
        +TBAsWznvl6mf0kRS4CvpvztODPw6M3TXOZyAHyFyGYkbRVpnkoy7uTnpvKLeWMg
        ==
X-ME-Sender: <xms:EXbjXCqXjvdeJyrSrR9FFKDA-iQ-Bfns_z4ugIeU1Va2YFnzSLa3gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:EXbjXO6etqyKC9V0HopNZDRZTQNongRgUwuVIvFm63wn8BQrhKU0Hg>
    <xmx:EXbjXAjDQXter1WSS58gcDFvJWdc7GchZPJzr0qUNgogemjea8Z1xQ>
    <xmx:EXbjXE4NfkJmu0oTuyqxZOn85grSCnPlIH_o6_kDN13K5iDDiMlTiw>
    <xmx:EnbjXAxZaAuFvc4WHK2C6uSQSq6MxuHVad8tghgplkM2hIbTS0n7Mw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E0BFF7C390; Mon, 20 May 2019 23:52:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-550-g29afa21-fmstable-20190520v1
Mime-Version: 1.0
Message-Id: <7679062c-401c-41d7-baee-911c3598b686@www.fastmail.com>
In-Reply-To: <1558383565-11821-4-git-send-email-eajames@linux.ibm.com>
References: <1558383565-11821-1-git-send-email-eajames@linux.ibm.com>
 <1558383565-11821-4-git-send-email-eajames@linux.ibm.com>
Date:   Tue, 21 May 2019 13:22:20 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v2 3/7] drivers/soc: xdma: Add user interface
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 May 2019, at 05:49, Eddie James wrote:
> This commits adds a miscdevice to provide a user interface to the XDMA
> engine. The interface provides the write operation to start DMA
> operations. The DMA parameters are passed as the data to the write call.
> The actual data to transfer is NOT passed through write. Note that both
> directions of DMA operation are accomplished through the write command;
> BMC to host and host to BMC.
> 
> The XDMA engine is restricted to only accessing the reserved memory
> space on the AST2500, typically used by the VGA. For this reason, this
> commit also adds a simple memory manager for this reserved memory space
> which can then be allocated in pages by users calling mmap. The space
> allocated by a client will be the space used in the DMA operation. For
> an "upstream" (BMC to host) operation, the data in the client's area
> will be transferred to the host. For a "downstream" (host to BMC)
> operation, the host data will be placed in the client's memory area.

Did you explore genalloc as a solution for allocating out of the VGA reserved
memory? Wondering if we can avoid implementing a custom allocator (even if
it is simple).

Andrew

> 
> Poll is also provided in order to determine when the DMA operation is
> complete for non-blocking IO.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/soc/aspeed/aspeed-xdma.c | 301 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 301 insertions(+)
> 
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> index 0992d2a..2162ca0 100644
> --- a/drivers/soc/aspeed/aspeed-xdma.c
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -118,6 +118,12 @@ struct aspeed_xdma_cmd {
>  	u32 resv1;
>  };
>  
> +struct aspeed_xdma_vga_blk {
> +	u32 phys;
> +	u32 size;
> +	struct list_head list;
> +};
> +
>  struct aspeed_xdma_client;
>  
>  struct aspeed_xdma {
> @@ -128,6 +134,8 @@ struct aspeed_xdma {
>  
>  	unsigned long flags;
>  	unsigned int cmd_idx;
> +	struct mutex list_lock;
> +	struct mutex start_lock;
>  	wait_queue_head_t wait;
>  	struct aspeed_xdma_client *current_client;
>  
> @@ -136,6 +144,9 @@ struct aspeed_xdma {
>  	dma_addr_t vga_dma;
>  	void *cmdq;
>  	void *vga_virt;
> +	struct list_head vga_blks_free;
> +
> +	struct miscdevice misc;
>  };
>  
>  struct aspeed_xdma_client {
> @@ -325,6 +336,260 @@ static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static u32 aspeed_xdma_alloc_vga_blk(struct aspeed_xdma *ctx, u32 req_size)
> +{
> +	u32 phys = 0;
> +	u32 size = PAGE_ALIGN(req_size);
> +	struct aspeed_xdma_vga_blk *free;
> +
> +	mutex_lock(&ctx->list_lock);
> +
> +	list_for_each_entry(free, &ctx->vga_blks_free, list) {
> +		if (free->size >= size) {
> +			phys = free->phys;
> +
> +			if (size == free->size) {
> +				dev_dbg(ctx->dev,
> +					"Allocd %08x[%08x r(%08x)], del.\n",
> +					phys, size, req_size);
> +				list_del(&free->list);
> +				kfree(free);
> +			} else {
> +				free->phys += size;
> +				free->size -= size;
> +				dev_dbg(ctx->dev, "Allocd %08x[%08x r(%08x)], "
> +					"shrunk %08x[%08x].\n", phys, size,
> +					req_size, free->phys, free->size);
> +			}
> +
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&ctx->list_lock);
> +
> +	return phys;
> +}
> +
> +static void aspeed_xdma_free_vga_blk(struct aspeed_xdma *ctx, u32 phys,
> +				     u32 req_size)
> +{
> +	u32 min_free = UINT_MAX;
> +	u32 size = PAGE_ALIGN(req_size);
> +	const u32 end = phys + size;
> +	struct aspeed_xdma_vga_blk *free;
> +
> +	mutex_lock(&ctx->list_lock);
> +
> +	list_for_each_entry(free, &ctx->vga_blks_free, list) {
> +		if (end == free->phys) {
> +			u32 fend = free->phys + free->size;
> +
> +			dev_dbg(ctx->dev,
> +				"Freed %08x[%08x r(%08x)], exp %08x[%08x].\n",
> +				phys, size, req_size, free->phys, free->size);
> +
> +			free->phys = phys;
> +			free->size = fend - free->phys;
> +
> +			mutex_unlock(&ctx->list_lock);
> +			return;
> +		}
> +
> +		if (free->phys < min_free)
> +			min_free = free->phys;
> +	}
> +
> +	free = kzalloc(sizeof(*free), GFP_KERNEL);
> +	if (free) {
> +		free->phys = phys;
> +		free->size = size;
> +
> +		dev_dbg(ctx->dev, "Freed %08x[%08x r(%08x)], new.\n", phys,
> +			size, req_size);
> +
> +		if (phys < min_free)
> +			list_add(&free->list, &ctx->vga_blks_free);
> +		else
> +			list_add_tail(&free->list, &ctx->vga_blks_free);
> +	} else {
> +		dev_err(ctx->dev, "Failed to register freed block.\n");
> +	}
> +
> +	mutex_unlock(&ctx->list_lock);
> +}
> +
> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
> +				 size_t len, loff_t *offset)
> +{
> +	int rc;
> +	struct aspeed_xdma_op op;
> +	struct aspeed_xdma_client *client = file->private_data;
> +	struct aspeed_xdma *ctx = client->ctx;
> +	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
> +		XDMA_CMDQ_SIZE;
> +
> +	if (len != sizeof(struct aspeed_xdma_op))
> +		return -EINVAL;
> +
> +	rc = copy_from_user(&op, buf, len);
> +	if (rc)
> +		return rc;
> +
> +	if (op.len > (ctx->vga_size - offs) || op.len < XDMA_BYTE_ALIGN)
> +		return -EINVAL;
> +
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (!mutex_trylock(&ctx->start_lock))
> +			return -EAGAIN;
> +
> +		if (test_bit(XDMA_IN_PRG, &ctx->flags)) {
> +			mutex_unlock(&ctx->start_lock);
> +			return -EAGAIN;
> +		}
> +	} else {
> +		mutex_lock(&ctx->start_lock);
> +
> +		rc = wait_event_interruptible(ctx->wait,
> +					      !test_bit(XDMA_IN_PRG,
> +							&ctx->flags));
> +		if (rc) {
> +			mutex_unlock(&ctx->start_lock);
> +			return -EINTR;
> +		}
> +	}
> +
> +	ctx->current_client = client;
> +	set_bit(XDMA_IN_PRG, &client->flags);
> +
> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs);
> +
> +	mutex_unlock(&ctx->start_lock);
> +
> +	if (!(file->f_flags & O_NONBLOCK)) {
> +		rc = wait_event_interruptible(ctx->wait,
> +					      !test_bit(XDMA_IN_PRG,
> +							&ctx->flags));
> +		if (rc)
> +			return -EINTR;
> +	}
> +
> +	return len;
> +}
> +
> +static __poll_t aspeed_xdma_poll(struct file *file,
> +				 struct poll_table_struct *wait)
> +{
> +	__poll_t mask = 0;
> +	__poll_t req = poll_requested_events(wait);
> +	struct aspeed_xdma_client *client = file->private_data;
> +	struct aspeed_xdma *ctx = client->ctx;
> +
> +	if (req & (EPOLLIN | EPOLLRDNORM)) {
> +		if (test_bit(XDMA_IN_PRG, &client->flags))
> +			poll_wait(file, &ctx->wait, wait);
> +
> +		if (!test_bit(XDMA_IN_PRG, &client->flags))
> +			mask |= EPOLLIN | EPOLLRDNORM;
> +	}
> +
> +	if (req & (EPOLLOUT | EPOLLWRNORM)) {
> +		if (test_bit(XDMA_IN_PRG, &ctx->flags))
> +			poll_wait(file, &ctx->wait, wait);
> +
> +		if (!test_bit(XDMA_IN_PRG, &ctx->flags))
> +			mask |= EPOLLOUT | EPOLLWRNORM;
> +	}
> +
> +	return mask;
> +}
> +
> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
> +{
> +	struct aspeed_xdma_client *client = vma->vm_private_data;
> +
> +	aspeed_xdma_free_vga_blk(client->ctx, client->phys, client->size);
> +
> +	client->phys = 0;
> +	client->size = 0;
> +}
> +
> +static const struct vm_operations_struct aspeed_xdma_vm_ops = {
> +	.close =	aspeed_xdma_vma_close,
> +};
> +
> +static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	int rc;
> +	struct aspeed_xdma_client *client = file->private_data;
> +	struct aspeed_xdma *ctx = client->ctx;
> +
> +	/* restrict file to one mapping */
> +	if (client->size)
> +		return -ENOMEM;
> +
> +	client->size = vma->vm_end - vma->vm_start;
> +	client->phys = aspeed_xdma_alloc_vga_blk(ctx, client->size);
> +	if (!client->phys) {
> +		client->size = 0;
> +		return -ENOMEM;
> +	}
> +
> +	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
> +	vma->vm_ops = &aspeed_xdma_vm_ops;
> +	vma->vm_private_data = client;
> +
> +	rc = dma_mmap_coherent(ctx->dev, vma, ctx->vga_virt, ctx->vga_dma,
> +			       ctx->vga_size);
> +	if (rc) {
> +		aspeed_xdma_free_vga_blk(ctx, client->phys, client->size);
> +
> +		client->phys = 0;
> +		client->size = 0;
> +		return rc;
> +	}
> +
> +	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
> +		vma->vm_start, client->phys, client->size);
> +
> +	return 0;
> +}
> +
> +static int aspeed_xdma_open(struct inode *inode, struct file *file)
> +{
> +	struct miscdevice *misc = file->private_data;
> +	struct aspeed_xdma *ctx = container_of(misc, struct aspeed_xdma, misc);
> +	struct aspeed_xdma_client *client = kzalloc(sizeof(*client),
> +						    GFP_KERNEL);
> +
> +	if (!client)
> +		return -ENOMEM;
> +
> +	client->ctx = ctx;
> +	file->private_data = client;
> +	return 0;
> +}
> +
> +static int aspeed_xdma_release(struct inode *inode, struct file *file)
> +{
> +	struct aspeed_xdma_client *client = file->private_data;
> +
> +	if (client->ctx->current_client == client)
> +		client->ctx->current_client = NULL;
> +
> +	kfree(client);
> +	return 0;
> +}
> +
> +static const struct file_operations aspeed_xdma_fops = {
> +	.owner			= THIS_MODULE,
> +	.write			= aspeed_xdma_write,
> +	.poll			= aspeed_xdma_poll,
> +	.mmap			= aspeed_xdma_mmap,
> +	.open			= aspeed_xdma_open,
> +	.release		= aspeed_xdma_release,
> +};
> +
>  static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>  {
>  	int rc;
> @@ -382,12 +647,26 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
>  		return -ENOMEM;
>  	}
>  
> +	aspeed_xdma_free_vga_blk(ctx, ctx->vga_phys, ctx->vga_size);
> +	aspeed_xdma_alloc_vga_blk(ctx, XDMA_CMDQ_SIZE);
> +
>  	dev_dbg(ctx->dev, "VGA mapped at phys[%08x], size[%08x].\n",
>  		ctx->vga_phys, ctx->vga_size);
>  
>  	return 0;
>  }
>  
> +static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
> +{
> +	struct aspeed_xdma_vga_blk *free;
> +	struct aspeed_xdma_vga_blk *tmp;
> +
> +	list_for_each_entry_safe(free, tmp, &ctx->vga_blks_free, list) {
> +		list_del(&free->list);
> +		kfree(free);
> +	}
> +}
> +
>  static int aspeed_xdma_probe(struct platform_device *pdev)
>  {
>  	int irq;
> @@ -402,6 +681,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>  	ctx->dev = dev;
>  	platform_set_drvdata(pdev, ctx);
>  	init_waitqueue_head(&ctx->wait);
> +	mutex_init(&ctx->list_lock);
> +	mutex_init(&ctx->start_lock);
> +	INIT_LIST_HEAD(&ctx->vga_blks_free);
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	ctx->base = devm_ioremap_resource(dev, res);
> @@ -447,6 +729,22 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
>  
>  	aspeed_xdma_init_eng(ctx);
>  
> +	ctx->misc.minor = MISC_DYNAMIC_MINOR;
> +	ctx->misc.fops = &aspeed_xdma_fops;
> +	ctx->misc.name = "xdma";
> +	ctx->misc.parent = dev;
> +	rc = misc_register(&ctx->misc);
> +	if (rc) {
> +		dev_err(dev, "Unable to register xdma miscdevice\n");
> +
> +		aspeed_xdma_free_vga_blks(ctx);
> +		dma_free_coherent(dev, ctx->vga_size, ctx->vga_virt,
> +				  ctx->vga_dma);
> +		dma_release_declared_memory(dev);
> +		reset_control_assert(ctx->reset);
> +		return rc;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -454,6 +752,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
>  {
>  	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
>  
> +	misc_deregister(&ctx->misc);
> +
> +	aspeed_xdma_free_vga_blks(ctx);
>  	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
>  			  ctx->vga_dma);
>  	dma_release_declared_memory(ctx->dev);
> -- 
> 1.8.3.1
> 
>
