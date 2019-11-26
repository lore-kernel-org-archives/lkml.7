Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57761C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3074C2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 03:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="SZPRGPx9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DVoC6vHg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKZDaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 22:30:00 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:60307 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbfKZD37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 22:29:59 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D5A866EB1;
        Mon, 25 Nov 2019 22:29:56 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Mon, 25 Nov 2019 22:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=KycFNOHXT6CcMo9TPCaUgdaCZdV5Z8A
        gfUCO43zSPqY=; b=SZPRGPx9vKNpFnpv0SeSxdh0I1XIeLEZC4Si0/CwdgRtM+/
        3dR9AzoBMsUxHilPyAmcnmEchnmx60CvQ2uJw1KlVoK5nrVW0xf40HT/X+ESfuk8
        7V1rAz6IvYmCSTmTUjs8cRCxqvitx4uoS4CRQ3Xe0L4xXFHdRMd0yDt/uFM2jb7k
        FfSHjM15QbTiE1jxGF9n6ThOe5rxp5Shyggh1Y+HpJ8KZqOLuWTAtz53FzM2IsdS
        8RappJ4/5uqxSe2LbWON2BzeWXW6XqIQuKbqakSOurlfxwIocsIJKp8cwjMwiM+p
        wzDDd9iIiFJHeqjVKBVS/zJiutHPrYHrdXYG9cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=KycFNO
        HXT6CcMo9TPCaUgdaCZdV5Z8AgfUCO43zSPqY=; b=DVoC6vHgZP7GlRaGjS6wi4
        m4k5YcHvRsm0BJEgVuabQ1TkpCFhc8Io7PBVD+t4qYk1UBpcs0OqABJtGhgBq22M
        YnVJRUeFiX6F8aq2td2fRQpRCDcRSdvs4zBXvKoTAZztMn2GHIzskd8wuTBmm4AI
        IQshSnpm+ZVrMGswQ2q40hJJWOCEl+MB8xLHERyxSptQhvKRGc1UVGePBo+jRSHW
        +VnKUyI3jU+pp3X0Z8IJeM061bwVNHNZ0dcljBiihqxjIqztWGV/nYCbprL1bTyU
        69oIx/FSbqjhjLxEnae1UEQZraxOayLPaSvYQUm/sndHRPK3iD8a3lqc9ATf8l1g
        ==
X-ME-Sender: <xms:M5zcXQYyo0_60wqHSTR-D_H-_nnC9aOnQC8ijBY9YGrv3yOtJYtnlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeivddgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:M5zcXbFycGJH_bjQAn__qsQDJE_hxro8iDoCnX9Pki6M1q2AONCXWA>
    <xmx:M5zcXWlhkIyIlI1-V6nTq7YYmo_viikNurSvZJsB0pZytcvhKSAvQQ>
    <xmx:M5zcXWcTGGNFb9XpoqUUww4rYtA9a5djDT00wCkJubxARYzrNm0m0Q>
    <xmx:NJzcXapUs5-wqIUNzKd4mc7LzVKttRIac-loODaTC7AEmKGM-QmVBg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 716AEE00A2; Mon, 25 Nov 2019 22:29:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <2bab457b-a66e-4b40-949a-fda8b5ec69c0@www.fastmail.com>
In-Reply-To: <d096ccaa-1ee5-24f2-d510-04339c131ad8@linux.vnet.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
 <3de1107b-59e6-48a6-90a0-704f0ebf70da@www.fastmail.com>
 <d096ccaa-1ee5-24f2-d510-04339c131ad8@linux.vnet.ibm.com>
Date:   Tue, 26 Nov 2019 14:00:16 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.vnet.ibm.com>,
        "Eddie James" <eajames@linux.ibm.com>, linux-kernel@vger.kernel.org
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



On Tue, 26 Nov 2019, at 06:14, Eddie James wrote:
> 
> On 11/24/19 5:59 PM, Andrew Jeffery wrote:
> >
> > On Sat, 9 Nov 2019, at 06:48, Eddie James wrote:
> >> This commits adds a miscdevice to provide a user interface to the XDMA
> >> engine. The interface provides the write operation to start DMA
> >> operations. The DMA parameters are passed as the data to the write call.
> >> The actual data to transfer is NOT passed through write. Note that both
> >> directions of DMA operation are accomplished through the write command;
> >> BMC to host and host to BMC.
> >>
> >> The XDMA engine is restricted to only accessing the reserved memory
> >> space on the AST2500, typically used by the VGA. For this reason, the
> >> VGA memory space is pooled and allocated with genalloc. Users calling
> >> mmap allocate pages from this pool for their usage. The space allocated
> >> by a client will be the space used in the DMA operation. For an
> >> "upstream" (BMC to host) operation, the data in the client's area will
> >> be transferred to the host. For a "downstream" (host to BMC) operation,
> >> the host data will be placed in the client's memory area.
> >>
> >> Poll is also provided in order to determine when the DMA operation is
> >> complete for non-blocking IO.
> >>
> >> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> >> ---
> >>   drivers/soc/aspeed/aspeed-xdma.c | 223 +++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 223 insertions(+)
> >>
> >> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
> >> index 99041a6..3d37582 100644
> >> --- a/drivers/soc/aspeed/aspeed-xdma.c
> >> +++ b/drivers/soc/aspeed/aspeed-xdma.c
> >> @@ -64,6 +64,9 @@
> >>   #define XDMA_CMDQ_SIZE				PAGE_SIZE
> >>   #define XDMA_NUM_CMDS				\
> >>   	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
> >> +#define XDMA_OP_SIZE_MAX			sizeof(struct aspeed_xdma_op)
> >> +#define XDMA_OP_SIZE_MIN			\
> >> +	(sizeof(struct aspeed_xdma_op) - sizeof(u64))
> >>   
> >>   /* Aspeed specification requires 10ms after switching the reset line */
> >>   #define XDMA_RESET_TIME_MS			10
> >> @@ -216,6 +219,7 @@ struct aspeed_xdma {
> >>   	bool in_reset;
> >>   	bool upstream;
> >>   	unsigned int cmd_idx;
> >> +	struct mutex file_lock;
> > Please add documentation about what data file_lock is protecting.
> >
> >>   	struct mutex start_lock;
> >>   	struct delayed_work reset_work;
> >>   	spinlock_t client_lock;
> >> @@ -230,6 +234,8 @@ struct aspeed_xdma {
> >>   	dma_addr_t cmdq_vga_phys;
> >>   	void *cmdq_vga_virt;
> >>   	struct gen_pool *vga_pool;
> >> +
> >> +	struct miscdevice misc;
> >>   };
> >>   
> >>   struct aspeed_xdma_client {
> >> @@ -557,6 +563,204 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq,
> >> void *arg)
> >>   	return IRQ_HANDLED;
> >>   }
> >>   
> >> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
> >> +				 size_t len, loff_t *offset)
> >> +{
> >> +	int rc;
> >> +	struct aspeed_xdma_op op;
> >> +	struct aspeed_xdma_client *client = file->private_data;
> >> +	struct aspeed_xdma *ctx = client->ctx;
> >> +	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
> >> +		XDMA_CMDQ_SIZE;
> >> +
> >> +	if (len < XDMA_OP_SIZE_MIN)
> >> +		return -EINVAL;
> >> +
> >> +	if (len > XDMA_OP_SIZE_MAX)
> >> +		len = XDMA_OP_SIZE_MAX;
> > Isn't this an EINVAL case as well?
> 
> 
> Perhaps so.
> 
> 
> >
> >> +
> >> +	rc = copy_from_user(&op, buf, len);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	if (op.direction == ASPEED_XDMA_DIRECTION_RESET) {
> > Seems a bit abusive to use the direction field to issue a reset.
> 
> 
> What would you recommend instead?

Looks like an ioctl() to me. But what need do we have to directly reset
the device? Could we achieve the same by rebinding the driver if
necessary? We should only need to reset it if the driver has bugs, or
is there some errata that we need to deal with? Userspace shouldn't
be handling that though?

> 
> 
> >
> >> +		mutex_lock(&ctx->start_lock);
> >> +
> >> +		if (aspeed_xdma_reset_start(ctx)) {
> >> +			msleep(XDMA_RESET_TIME_MS);
> >> +
> >> +			aspeed_xdma_reset_finish(ctx);
> >> +		}
> >> +
> >> +		mutex_unlock(&ctx->start_lock);
> >> +
> >> +		return len;
> >> +	} else if (op.direction > ASPEED_XDMA_DIRECTION_RESET) {
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (op.len > ctx->vga_size - offs)
> >> +		return -EINVAL;
> >> +
> >> +	if (file->f_flags & O_NONBLOCK) {
> >> +		if (!mutex_trylock(&ctx->file_lock))
> >> +			return -EAGAIN;
> >> +
> >> +		if (ctx->in_progress || ctx->in_reset) {
> > ctx->in_progress was protected by a lock that isn't file_lock, so this looks wrong.
> 
> 
> file_lock isn't protecting in_progress. It's protecting access to the 
> whole engine while a transfer is in progress.

Then when would we ever gain file_lock if in_progress was set? Shouldn't the current
client hold file_lock until we'd set in_progress to false, in which case we wouldn't
need to check in_progress if we now hold the lock?

> in_progress isn't protected at all,

Except it is, because you've acquired file_lock above before checking it (and
in_reset).

And why is in_progress written to under ctx->start_lock (which is not file_lock)
in aspeed_xdma_start() in the earlier patch if it's not protected?

> it's just better to lock

There's never a case of "it's just better to lock", as if it were optional. Either the
variable needs to be protected against concurrent access or it doesn't. If it does,
always access it under a consistent lock.

> before waiting for 
> in_progress so that multiple clients don't all see in_progress go false 
> and have to wait for a mutex (particularly in the nonblocking case).

Yes, so what you're suggesting is that in_progress needs to be protected against
concurrent access, so needs to be accessed under a consistent lock. Though as
suggested above it might be enough to successfully acquire file_lock.

As far as I can see we have three events that we need to care about:

1. Submission of a DMA request
2. Completion of a DMA request
3. PCIe-driven reset

For 1, multiple concurrent submissions need to be serialised, so we need a
mutex with the semantics of file_lock as you've described above.

2 should only occur if we have an event of type 1 outstanding. If 1 is outstanding
then receiving 2 should cause the process that triggered 1 to wake and release
the mutex.

3 can happen at any time which results in two cases that we need to care about:

3a. DMA request in progress (i.e. 1 but have not yet seen corresponding 2)
3b. DMA idle (no request in progress)

Events of type 1 need to be serialised against 3. 2 won't occur after 3 until 1 has
occurred, so there's no need to consider it in the serialisation for 3.

In the case of 3a. we need to reset the device, then mark the current transfer failed,
then wake the associated process. The woken process will release the mutex and
allow any queued requests to proceed.

3b is much simpler, though we need to prevent events of type 1 concurrently
accessing the device while the reset is in progress. So we need a spinlock to cover
configuring the device.

So that's two locks - a mutex to serialise process-context access to the device, and
a spinlock to serialise interrupts with respect to process-context access. Currently
your implementation contains two mutexes (start_lock and file_lock) and two
spinlocks (client_lock and reset_lock), all with fairly hazy definitions.

> 
> 
> >
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EAGAIN;
> >> +		}
> >> +	} else {
> >> +		mutex_lock(&ctx->file_lock);
> >> +
> >> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress &&
> >> +					      !ctx->in_reset);
> > As above.
> >
> >> +		if (rc) {
> >> +			mutex_unlock(&ctx->file_lock);
> >> +			return -EINTR;
> >> +		}
> >> +	}
> >> +
> >> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
> >> +
> >> +	mutex_unlock(&ctx->file_lock);
> >> +
> >> +	if (!(file->f_flags & O_NONBLOCK)) {
> >> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress);
> >> +		if (rc)
> >> +			return -EINTR;
> >> +
> >> +		if (client->error)
> >> +			return -EIO;
> > What's the client->error value? Can it be more informative?
> 
> 
> Not really. There isn't much error information available. Basically the 
> only way to get an error is if the engine is reset (user or PCIE 
> initiated) while the transfer is on-going.
> 
> 
> >
> >> +	}
> >> +
> >> +	return len;
> > We've potentially truncated len above (in the len >  XDMA_OP_SIZE_MAX),
> > which leads to some ambiguity with the write() syscall given that it can
> > potentially return less than the requested length. This is one such case, but
> > the caller probably shouldn't attempt a follow-up write.
> >
> > This would go away if we make the len > XDMA_OP_SIZE_MAX an EINVAL
> > case as suggested agove.
> 
> 
> Sure.
> 
> 
> >
> >> +}
> >> +
> >> +static __poll_t aspeed_xdma_poll(struct file *file,
> >> +				 struct poll_table_struct *wait)
> >> +{
> >> +	__poll_t mask = 0;
> >> +	__poll_t req = poll_requested_events(wait);
> >> +	struct aspeed_xdma_client *client = file->private_data;
> >> +	struct aspeed_xdma *ctx = client->ctx;
> >> +
> >> +	if (req & (EPOLLIN | EPOLLRDNORM)) {
> >> +		if (client->in_progress)
> >> +			poll_wait(file, &ctx->wait, wait);
> >> +
> >> +		if (!client->in_progress) {
> >> +			if (client->error)
> >> +				mask |= EPOLLERR;
> >> +			else
> >> +				mask |= EPOLLIN | EPOLLRDNORM;
> >> +		}
> >> +	}
> >> +
> >> +	if (req & (EPOLLOUT | EPOLLWRNORM)) {
> >> +		if (ctx->in_progress)
> >> +			poll_wait(file, &ctx->wait, wait);
> >> +
> >> +		if (!ctx->in_progress)
> >> +			mask |= EPOLLOUT | EPOLLWRNORM;
> >> +	}
> >> +
> >> +	return mask;
> >> +}
> >> +
> >> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
> >> +{
> >> +	struct aspeed_xdma_client *client = vma->vm_private_data;
> >> +
> >> +	gen_pool_free(client->ctx->vga_pool, (unsigned long)client->virt,
> >> +		      client->size);
> >> +
> >> +	client->virt = NULL;
> >> +	client->phys = 0;
> >> +	client->size = 0;
> >> +}
> >> +
> >> +static const struct vm_operations_struct aspeed_xdma_vm_ops = {
> >> +	.close =	aspeed_xdma_vma_close,
> >> +};
> >> +
> >> +static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
> >> +{
> >> +	int rc;
> >> +	struct aspeed_xdma_client *client = file->private_data;
> >> +	struct aspeed_xdma *ctx = client->ctx;
> >> +
> >> +	/* restrict file to one mapping */
> >> +	if (client->size)
> >> +		return -ENOMEM;
> > Can we do better with the error code here?
> 
> 
> Maybe? I'm open to suggestions...

How about EBUSY?

> 
> 
> >
> >> +
> >> +	client->size = vma->vm_end - vma->vm_start;
> >> +	client->virt = gen_pool_dma_alloc(ctx->vga_pool, client->size,
> >> +					  &client->phys);
> >> +	if (!client->virt) {
> >> +		client->phys = 0;
> >> +		client->size = 0;
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
> > Where does client->phys get set?
> 
> 
> gen_pool_dma_alloc sets it.

Ah, yes. Thanks.

Andrew
