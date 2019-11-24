Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BF9C43215
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8DA207FD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 23:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Nmm60HL8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YZtioize"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKXX56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 18:57:58 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46937 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbfKXX56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 18:57:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B67882296C;
        Sun, 24 Nov 2019 18:57:56 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 24 Nov 2019 18:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=yrN1+EIl721/kAQDrnl9Ff0O9lkipUL
        lArAA6BTNrEU=; b=Nmm60HL87MoHkyRmvwv6JTC8M8DOW78/DY1jwuSZWa+EynL
        KiLLWN28F6cjW6MjBA29OPAIFZeJ3QUyGbPc7IRg36KiqnbFMm8G7GfDxhJJ/JUn
        xXexHUW3RHGhaja0ICrno6HgzrBpSJr9pIjSibfOd6htrtRgA6KINRqHysk4cZtT
        AEcHd94sXqOGrDsyzYcJkTisrTuFcOyQzsimHhWbjyqdCtivs2PIT4ZOhCJa3Hbq
        yFNg5nqXQT1M51kATXAgohFW5UPfV26TwcYB9h58yTXlyV1xFcYdZh65g5UmH0t5
        JveLYQitiLOOL7zSJXc4eJ99Mf2jjGWKfZXVJGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yrN1+E
        Il721/kAQDrnl9Ff0O9lkipULlArAA6BTNrEU=; b=YZtioizebjrKz2o4ZMUvgj
        Bgg5gt8ecjH/4ZgGNE2J2CllZQwYA75x4XwiU9CiHBkYNIXuzTitAxHUfRpjUKWw
        S/cnO1yFTwSe3ADi4dHQRnRPEAdOClPE7/E8WtsydCAv0v2kB+ZERt2FmcGBlpEt
        c2o+joRZ3NnRBrD+PkXafI9F+bPtTPvEtMXYXgOHx/4vkREYuTVoiIEONuO2vGOM
        mmAtU15u+zqExBpW6Z2XEbXFMHgbJBIylDErdxi7X/LnPv1PRtEtrQW+GtuqSIqD
        ZwSo4WRO6HdZlLzi1dCRQgRbcQN2QpvaqbyaVCE0GavjtGQ0a/apHNAeYp9sB0Pw
        ==
X-ME-Sender: <xms:AxnbXRMl-eZwDnCDBR_3OYj5NNVpXyQJpFJeCIkUnumUKRC3eTVJeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudehledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:AxnbXQTIkpgXP9IO9XHqgqoM6l7-M0qmOA0VqyW1oVlsNFeQVmNVJA>
    <xmx:AxnbXTDL4cCSuONMvoVLCWe06cgj4wp6ojR5_6zX6n2MT04jHTzHXQ>
    <xmx:AxnbXfhChMW9CGPnqEHNfZ_h8UqZf-gAS-0KmypW985kTuNdtawYXA>
    <xmx:BBnbXcK0U1ZVw5U3dd3gbtBpLmJBpB4veHoYwTjchJSEzxqToZhaSg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8AB67E00A2; Sun, 24 Nov 2019 18:57:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <3de1107b-59e6-48a6-90a0-704f0ebf70da@www.fastmail.com>
In-Reply-To: <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
Date:   Mon, 25 Nov 2019 10:29:24 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, "Joel Stanley" <joel@jms.id.au>,
        maz@kernel.org, "Jason Cooper" <jason@lakedaemon.net>,
        tglx@linutronix.de, "Rob Herring" <robh+dt@kernel.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH 07/12] drivers/soc: xdma: Add user interface
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Nov 2019, at 06:48, Eddie James wrote:
> This commits adds a miscdevice to provide a user interface to the XDMA
> engine. The interface provides the write operation to start DMA
> operations. The DMA parameters are passed as the data to the write call.
> The actual data to transfer is NOT passed through write. Note that both
> directions of DMA operation are accomplished through the write command;
> BMC to host and host to BMC.
> 
> The XDMA engine is restricted to only accessing the reserved memory
> space on the AST2500, typically used by the VGA. For this reason, the
> VGA memory space is pooled and allocated with genalloc. Users calling
> mmap allocate pages from this pool for their usage. The space allocated
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
>  drivers/soc/aspeed/aspeed-xdma.c | 223 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 223 insertions(+)
> 
> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> index 99041a6..3d37582 100644
> --- a/drivers/soc/aspeed/aspeed-xdma.c
> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> @@ -64,6 +64,9 @@
>  #define XDMA_CMDQ_SIZE				PAGE_SIZE
>  #define XDMA_NUM_CMDS				\
>  	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
> +#define XDMA_OP_SIZE_MAX			sizeof(struct aspeed_xdma_op)
> +#define XDMA_OP_SIZE_MIN			\
> +	(sizeof(struct aspeed_xdma_op) - sizeof(u64))
>  
>  /* Aspeed specification requires 10ms after switching the reset line */
>  #define XDMA_RESET_TIME_MS			10
> @@ -216,6 +219,7 @@ struct aspeed_xdma {
>  	bool in_reset;
>  	bool upstream;
>  	unsigned int cmd_idx;
> +	struct mutex file_lock;

Please add documentation about what data file_lock is protecting.

>  	struct mutex start_lock;
>  	struct delayed_work reset_work;
>  	spinlock_t client_lock;
> @@ -230,6 +234,8 @@ struct aspeed_xdma {
>  	dma_addr_t cmdq_vga_phys;
>  	void *cmdq_vga_virt;
>  	struct gen_pool *vga_pool;
> +
> +	struct miscdevice misc;
>  };
>  
>  struct aspeed_xdma_client {
> @@ -557,6 +563,204 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq, 
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
> +	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
> +		XDMA_CMDQ_SIZE;
> +
> +	if (len < XDMA_OP_SIZE_MIN)
> +		return -EINVAL;
> +
> +	if (len > XDMA_OP_SIZE_MAX)
> +		len = XDMA_OP_SIZE_MAX;

Isn't this an EINVAL case as well?

> +
> +	rc = copy_from_user(&op, buf, len);
> +	if (rc)
> +		return rc;
> +
> +	if (op.direction == ASPEED_XDMA_DIRECTION_RESET) {

Seems a bit abusive to use the direction field to issue a reset.

> +		mutex_lock(&ctx->start_lock);
> +
> +		if (aspeed_xdma_reset_start(ctx)) {
> +			msleep(XDMA_RESET_TIME_MS);
> +
> +			aspeed_xdma_reset_finish(ctx);
> +		}
> +
> +		mutex_unlock(&ctx->start_lock);
> +
> +		return len;
> +	} else if (op.direction > ASPEED_XDMA_DIRECTION_RESET) {
> +		return -EINVAL;
> +	}
> +
> +	if (op.len > ctx->vga_size - offs)
> +		return -EINVAL;
> +
> +	if (file->f_flags & O_NONBLOCK) {
> +		if (!mutex_trylock(&ctx->file_lock))
> +			return -EAGAIN;
> +
> +		if (ctx->in_progress || ctx->in_reset) {

ctx->in_progress was protected by a lock that isn't file_lock, so this looks wrong.

> +			mutex_unlock(&ctx->file_lock);
> +			return -EAGAIN;
> +		}
> +	} else {
> +		mutex_lock(&ctx->file_lock);
> +
> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress &&
> +					      !ctx->in_reset);

As above.

> +		if (rc) {
> +			mutex_unlock(&ctx->file_lock);
> +			return -EINTR;
> +		}
> +	}
> +
> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
> +
> +	mutex_unlock(&ctx->file_lock);
> +
> +	if (!(file->f_flags & O_NONBLOCK)) {
> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress);
> +		if (rc)
> +			return -EINTR;
> +
> +		if (client->error)
> +			return -EIO;

What's the client->error value? Can it be more informative?

> +	}
> +
> +	return len;

We've potentially truncated len above (in the len >  XDMA_OP_SIZE_MAX),
which leads to some ambiguity with the write() syscall given that it can
potentially return less than the requested length. This is one such case, but
the caller probably shouldn't attempt a follow-up write.

This would go away if we make the len > XDMA_OP_SIZE_MAX an EINVAL
case as suggested agove.

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
> +		if (ctx->in_progress)
> +			poll_wait(file, &ctx->wait, wait);
> +
> +		if (!ctx->in_progress)
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
> +	gen_pool_free(client->ctx->vga_pool, (unsigned long)client->virt,
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
> +		return -ENOMEM;

Can we do better with the error code here?

> +
> +	client->size = vma->vm_end - vma->vm_start;
> +	client->virt = gen_pool_dma_alloc(ctx->vga_pool, client->size,
> +					  &client->phys);
> +	if (!client->virt) {
> +		client->phys = 0;
> +		client->size = 0;
> +		return -ENOMEM;
> +	}
> +
> +	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;

Where does client->phys get set?

Andrew
