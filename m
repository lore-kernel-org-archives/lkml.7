Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41F4C2D0D2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23DD2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 01:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="mIgBLxDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWKhnKum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfLSBRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 20:17:55 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33155 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfLSBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 20:17:55 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 71DA021F92;
        Wed, 18 Dec 2019 20:17:53 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Wed, 18 Dec 2019 20:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=Ej9oZRbrjMybX+mUqzStzu68DsSeTNj
        LHLVFdivMMtY=; b=mIgBLxDk+NpZQU8SNFJU1ACg4l+3AlomywqLk3MghtuBy8Q
        4gHoiGxcI1iOGCMJcMoYKd1QlVBncAMbPrGGqNL09EVPJ4GbO88V5wzplCGcgzn6
        ukMhJY125KOVP7vOAl5WTkcslNvtiAKxn5EgE6eRYg9j+x7ZdC/lBvWp5PpW3Wz8
        4pfHXTf3FRJ6aQeX+WrwpyJQlGoewUQxd4EW5OPg1x1madyVn+G2aaKdlSUsV3hd
        g3hWEJ9+64bmnts37BYiembOPSBrHaRBerNc02QmFS01HPeO/tfmqXLm/tArcMv2
        MrEKRE4D5Kkhzg8Q2vVHcWNTVxMwPQc9k1S8jeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ej9oZR
        brjMybX+mUqzStzu68DsSeTNjLHLVFdivMMtY=; b=CWKhnKumxInlJgxpAoWLj2
        2THJNrsf13FC/zq4Vs0WmMLy1+bEPqVbzs1mc+oPzDKJCAMfnCDFUA281YuV25OA
        tJC5HGA7WcnnfbuPPH8Xhp6A+iaSvPRJkKcNz/aLOeEf/iMu2QpOHIYTWsiciiaL
        dyABxIcCvIFRIyKiQ8hBFgSldeWHyGFGC8wfn2U3BsgcP/SqjeH49740SC+ztgbt
        7pdawEmcBWCE2kjSdxyEetPRhdFSfU6naKGs4miMEadKUi6QX8sWw7MmYTy8OZOM
        Mj/kIT/3wVIz65ItxAfs65Qx5aVIu+YSuPDeGTdEN6MeEEa4U6OBxZV08kRhx2hw
        ==
X-ME-Sender: <xms:v8_6XTaz0FXvfGE-cV9T97fSoD4KftSo8Z9FLPQjMqmxZKPZcNNTGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddutddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:v8_6Xd0fPWONZTOer7f-YfLu93EiLK1wtEYRsC5ONabdF-51gQNsWw>
    <xmx:v8_6XZcyTrkijgqbjfo-pWAPCLyblqz8GMr1tsP2T7GE7W_mR5sJYQ>
    <xmx:v8_6XeEaINiix0MotN1ol1bGoIImC_gW_ywcIf8mINSJ9Mp-ucbCQg>
    <xmx:wc_6XSr6f6ndzO10xs7LWGf6A6npToebmM5y1ePMUXd4D7n3z5Jp4w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 515DFE00A3; Wed, 18 Dec 2019 20:17:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-694-gd5bab98-fmstable-20191218v1
Mime-Version: 1.0
Message-Id: <de68ff11-0942-422a-b233-ff578b06eefc@www.fastmail.com>
In-Reply-To: <1576681778-18737-8-git-send-email-eajames@linux.ibm.com>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-8-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 19 Dec 2019 11:49:27 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v3 07/12] soc: aspeed: xdma: Add user interface
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
> This commits adds a miscdevice to provide a user interface to the XDMA
> engine. The interface provides the write operation to start DMA
> operations. The DMA parameters are passed as the data to the write call.
> The actual data to transfer is NOT passed through write. Note that both
> directions of DMA operation are accomplished through the write command;
> BMC to host and host to BMC.
> 
> The XDMA driver reserves an area of physical memory for DMA operations,
> as the XDMA engine is restricted to accessing certain physical memory
> areas on some platforms. This memory forms a pool from which users can
> allocate pages for their usage with calls to mmap. The space allocated
> by a client will be the space used in the DMA operation. For an
> "upstream" (BMC to host) operation, the data in the client's area will
> be transferred to the host. For a "downstream" (host to BMC) operation,
> the host data will be placed in the client's memory area.
> 
> Poll is also provided in order to determine when the DMA operation is
> complete for non-blocking IO.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v2:
>  - Rework commit message to talk about VGA memory less
>  - Remove user reset functionality
>  - Clean up sanity checks in aspeed_xdma_write()
>  - Wait for transfer complete in the vm area close function
> 
>  drivers/soc/aspeed/aspeed-xdma.c | 205 ++++++++++++++++++++++++++++++-
>  1 file changed, 203 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> index cb94adf798b1..e844937dc925 100644
> --- a/drivers/soc/aspeed/aspeed-xdma.c
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -13,6 +13,7 @@
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of_device.h>
> @@ -201,6 +202,8 @@ struct aspeed_xdma {
>  	struct clk *clock;
>  	struct reset_control *reset;
>  
> +	/* file_lock serializes reads of current_client */
> +	struct mutex file_lock;

I wonder whether start_lock can serve this purpose.

>  	/* client_lock protects error and in_progress of the client */
>  	spinlock_t client_lock;
>  	struct aspeed_xdma_client *current_client;
> @@ -223,6 +226,8 @@ struct aspeed_xdma {
>  	void __iomem *mem_virt;
>  	dma_addr_t cmdq_phys;
>  	struct gen_pool *pool;
> +
> +	struct miscdevice misc;
>  };
>  
>  struct aspeed_xdma_client {
> @@ -522,6 +527,185 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq, 
> void *arg)
>  	return IRQ_HANDLED;
>  }
>  
> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
> +				 size_t len, loff_t *offset)
> +{
> +	int rc;
> +	struct aspeed_xdma_op op;
> +	struct aspeed_xdma_client *client = file->private_data;
> +	struct aspeed_xdma *ctx = client->ctx;
> +
> +	if (len != sizeof(op))
> +		return -EINVAL;
> +
> +	rc = copy_from_user(&op, buf, len);
> +	if (rc)
> +		return rc;
> +
> +	if (!op.len || op.len > client->size ||
> +	    op.direction > ASPEED_XDMA_DIRECTION_UPSTREAM)
> +		return -EINVAL;
> +
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (!mutex_trylock(&ctx->file_lock))
> +			return -EAGAIN;
> +
> +		if (ctx->current_client) {

Should be tested under client_lock for consistency with the previous patch,
though perhaps you could use READ_ONCE()?

> +			mutex_unlock(&ctx->file_lock);
> +			return -EBUSY;
> +		}
> +	} else {
> +		mutex_lock(&ctx->file_lock);
> +
> +		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
> +		if (rc) {
> +			mutex_unlock(&ctx->file_lock);
> +			return -EINTR;
> +		}
> +	}
> +
> +	aspeed_xdma_start(ctx, &op, client->phys, client);
> +
> +	mutex_unlock(&ctx->file_lock);

Shouldn't we lift start_lock out of aspeed_xdma_start() use that here
instead of file_lock? I think that would mean that we could remove
file_lock.

> +
> +	if (!(file->f_flags & O_NONBLOCK)) {
> +		rc = wait_event_interruptible(ctx->wait, !client->in_progress);
> +		if (rc)
> +			return -EINTR;
> +
> +		if (client->error)
> +			return -EIO;
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
> +		if (client->in_progress)
> +			poll_wait(file, &ctx->wait, wait);
> +
> +		if (!client->in_progress) {
> +			if (client->error)
> +				mask |= EPOLLERR;
> +			else
> +				mask |= EPOLLIN | EPOLLRDNORM;
> +		}
> +	}
> +
> +	if (req & (EPOLLOUT | EPOLLWRNORM)) {
> +		if (ctx->current_client)
> +			poll_wait(file, &ctx->wait, wait);
> +
> +		if (!ctx->current_client)
> +			mask |= EPOLLOUT | EPOLLWRNORM;
> +	}
> +
> +	return mask;
> +}
> +
> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
> +{
> +	int rc;
> +	struct aspeed_xdma_client *client = vma->vm_private_data;
> +
> +	rc = wait_event_interruptible(client->ctx->wait, !client->in_progress);
> +	if (rc)
> +		return;
> +
> +	gen_pool_free(client->ctx->pool, (unsigned long)client->virt,
> +		      client->size);
> +
> +	client->virt = NULL;
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
> +		return -EBUSY;
> +
> +	client->size = vma->vm_end - vma->vm_start;
> +	client->virt = gen_pool_dma_alloc(ctx->pool, client->size,
> +					  &client->phys);
> +	if (!client->virt) {
> +		client->phys = 0;
> +		client->size = 0;
> +		return -ENOMEM;
> +	}
> +
> +	vma->vm_pgoff = (client->phys - ctx->mem_phys) >> PAGE_SHIFT;
> +	vma->vm_ops = &aspeed_xdma_vm_ops;
> +	vma->vm_private_data = client;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	rc = io_remap_pfn_range(vma, vma->vm_start, client->phys >> PAGE_SHIFT,
> +				client->size, vma->vm_page_prot);
> +	if (rc) {

Probably worth a dev_warn() here so we know what happened?

> +		gen_pool_free(ctx->pool, (unsigned long)client->virt,
> +			      client->size);
> +
> +		client->virt = NULL;
> +		client->phys = 0;
> +		client->size = 0;
> +		return rc;
> +	}
> +
> +	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
> +		vma->vm_start, (u32)client->phys, client->size);
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
> +	kfree(client);

I assume the vma gets torn down before release() gets invoked? I haven't
looked closely.

Andrew
