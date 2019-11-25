Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69BC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D2112075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYTou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:44:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725818AbfKYTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:44:50 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAPJcBk9081118;
        Mon, 25 Nov 2019 14:44:31 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wfk9b107h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 14:44:30 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAPJhLZR011626;
        Mon, 25 Nov 2019 19:44:30 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 2wevd64ska-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Nov 2019 19:44:30 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAPJiQZD44958144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 19:44:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B368EAC059;
        Mon, 25 Nov 2019 19:44:26 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDAF2AC05B;
        Mon, 25 Nov 2019 19:44:25 +0000 (GMT)
Received: from [9.41.103.158] (unknown [9.41.103.158])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Nov 2019 19:44:25 +0000 (GMT)
Subject: Re: [PATCH 07/12] drivers/soc: xdma: Add user interface
To:     Andrew Jeffery <andrew@aj.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        maz@kernel.org, Jason Cooper <jason@lakedaemon.net>,
        tglx@linutronix.de, Rob Herring <robh+dt@kernel.org>,
        mark.rutland@arm.com, devicetree@vger.kernel.org
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
 <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
 <3de1107b-59e6-48a6-90a0-704f0ebf70da@www.fastmail.com>
From:   Eddie James <eajames@linux.vnet.ibm.com>
Message-ID: <d096ccaa-1ee5-24f2-d510-04339c131ad8@linux.vnet.ibm.com>
Date:   Mon, 25 Nov 2019 13:44:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3de1107b-59e6-48a6-90a0-704f0ebf70da@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_04:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2
 impostorscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911250161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/24/19 5:59 PM, Andrew Jeffery wrote:
>
> On Sat, 9 Nov 2019, at 06:48, Eddie James wrote:
>> This commits adds a miscdevice to provide a user interface to the XDMA
>> engine. The interface provides the write operation to start DMA
>> operations. The DMA parameters are passed as the data to the write call.
>> The actual data to transfer is NOT passed through write. Note that both
>> directions of DMA operation are accomplished through the write command;
>> BMC to host and host to BMC.
>>
>> The XDMA engine is restricted to only accessing the reserved memory
>> space on the AST2500, typically used by the VGA. For this reason, the
>> VGA memory space is pooled and allocated with genalloc. Users calling
>> mmap allocate pages from this pool for their usage. The space allocated
>> by a client will be the space used in the DMA operation. For an
>> "upstream" (BMC to host) operation, the data in the client's area will
>> be transferred to the host. For a "downstream" (host to BMC) operation,
>> the host data will be placed in the client's memory area.
>>
>> Poll is also provided in order to determine when the DMA operation is
>> complete for non-blocking IO.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/soc/aspeed/aspeed-xdma.c | 223 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 223 insertions(+)
>>
>> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
>> index 99041a6..3d37582 100644
>> --- a/drivers/soc/aspeed/aspeed-xdma.c
>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>> @@ -64,6 +64,9 @@
>>   #define XDMA_CMDQ_SIZE				PAGE_SIZE
>>   #define XDMA_NUM_CMDS				\
>>   	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
>> +#define XDMA_OP_SIZE_MAX			sizeof(struct aspeed_xdma_op)
>> +#define XDMA_OP_SIZE_MIN			\
>> +	(sizeof(struct aspeed_xdma_op) - sizeof(u64))
>>   
>>   /* Aspeed specification requires 10ms after switching the reset line */
>>   #define XDMA_RESET_TIME_MS			10
>> @@ -216,6 +219,7 @@ struct aspeed_xdma {
>>   	bool in_reset;
>>   	bool upstream;
>>   	unsigned int cmd_idx;
>> +	struct mutex file_lock;
> Please add documentation about what data file_lock is protecting.
>
>>   	struct mutex start_lock;
>>   	struct delayed_work reset_work;
>>   	spinlock_t client_lock;
>> @@ -230,6 +234,8 @@ struct aspeed_xdma {
>>   	dma_addr_t cmdq_vga_phys;
>>   	void *cmdq_vga_virt;
>>   	struct gen_pool *vga_pool;
>> +
>> +	struct miscdevice misc;
>>   };
>>   
>>   struct aspeed_xdma_client {
>> @@ -557,6 +563,204 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq,
>> void *arg)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
>> +				 size_t len, loff_t *offset)
>> +{
>> +	int rc;
>> +	struct aspeed_xdma_op op;
>> +	struct aspeed_xdma_client *client = file->private_data;
>> +	struct aspeed_xdma *ctx = client->ctx;
>> +	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
>> +		XDMA_CMDQ_SIZE;
>> +
>> +	if (len < XDMA_OP_SIZE_MIN)
>> +		return -EINVAL;
>> +
>> +	if (len > XDMA_OP_SIZE_MAX)
>> +		len = XDMA_OP_SIZE_MAX;
> Isn't this an EINVAL case as well?


Perhaps so.


>
>> +
>> +	rc = copy_from_user(&op, buf, len);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (op.direction == ASPEED_XDMA_DIRECTION_RESET) {
> Seems a bit abusive to use the direction field to issue a reset.


What would you recommend instead?


>
>> +		mutex_lock(&ctx->start_lock);
>> +
>> +		if (aspeed_xdma_reset_start(ctx)) {
>> +			msleep(XDMA_RESET_TIME_MS);
>> +
>> +			aspeed_xdma_reset_finish(ctx);
>> +		}
>> +
>> +		mutex_unlock(&ctx->start_lock);
>> +
>> +		return len;
>> +	} else if (op.direction > ASPEED_XDMA_DIRECTION_RESET) {
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (op.len > ctx->vga_size - offs)
>> +		return -EINVAL;
>> +
>> +	if (file->f_flags & O_NONBLOCK) {
>> +		if (!mutex_trylock(&ctx->file_lock))
>> +			return -EAGAIN;
>> +
>> +		if (ctx->in_progress || ctx->in_reset) {
> ctx->in_progress was protected by a lock that isn't file_lock, so this looks wrong.


file_lock isn't protecting in_progress. It's protecting access to the 
whole engine while a transfer is in progress. in_progress isn't 
protected at all, it's just better to lock before waiting for 
in_progress so that multiple clients don't all see in_progress go false 
and have to wait for a mutex (particularly in the nonblocking case).


>
>> +			mutex_unlock(&ctx->file_lock);
>> +			return -EAGAIN;
>> +		}
>> +	} else {
>> +		mutex_lock(&ctx->file_lock);
>> +
>> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress &&
>> +					      !ctx->in_reset);
> As above.
>
>> +		if (rc) {
>> +			mutex_unlock(&ctx->file_lock);
>> +			return -EINTR;
>> +		}
>> +	}
>> +
>> +	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
>> +
>> +	mutex_unlock(&ctx->file_lock);
>> +
>> +	if (!(file->f_flags & O_NONBLOCK)) {
>> +		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress);
>> +		if (rc)
>> +			return -EINTR;
>> +
>> +		if (client->error)
>> +			return -EIO;
> What's the client->error value? Can it be more informative?


Not really. There isn't much error information available. Basically the 
only way to get an error is if the engine is reset (user or PCIE 
initiated) while the transfer is on-going.


>
>> +	}
>> +
>> +	return len;
> We've potentially truncated len above (in the len >  XDMA_OP_SIZE_MAX),
> which leads to some ambiguity with the write() syscall given that it can
> potentially return less than the requested length. This is one such case, but
> the caller probably shouldn't attempt a follow-up write.
>
> This would go away if we make the len > XDMA_OP_SIZE_MAX an EINVAL
> case as suggested agove.


Sure.


>
>> +}
>> +
>> +static __poll_t aspeed_xdma_poll(struct file *file,
>> +				 struct poll_table_struct *wait)
>> +{
>> +	__poll_t mask = 0;
>> +	__poll_t req = poll_requested_events(wait);
>> +	struct aspeed_xdma_client *client = file->private_data;
>> +	struct aspeed_xdma *ctx = client->ctx;
>> +
>> +	if (req & (EPOLLIN | EPOLLRDNORM)) {
>> +		if (client->in_progress)
>> +			poll_wait(file, &ctx->wait, wait);
>> +
>> +		if (!client->in_progress) {
>> +			if (client->error)
>> +				mask |= EPOLLERR;
>> +			else
>> +				mask |= EPOLLIN | EPOLLRDNORM;
>> +		}
>> +	}
>> +
>> +	if (req & (EPOLLOUT | EPOLLWRNORM)) {
>> +		if (ctx->in_progress)
>> +			poll_wait(file, &ctx->wait, wait);
>> +
>> +		if (!ctx->in_progress)
>> +			mask |= EPOLLOUT | EPOLLWRNORM;
>> +	}
>> +
>> +	return mask;
>> +}
>> +
>> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
>> +{
>> +	struct aspeed_xdma_client *client = vma->vm_private_data;
>> +
>> +	gen_pool_free(client->ctx->vga_pool, (unsigned long)client->virt,
>> +		      client->size);
>> +
>> +	client->virt = NULL;
>> +	client->phys = 0;
>> +	client->size = 0;
>> +}
>> +
>> +static const struct vm_operations_struct aspeed_xdma_vm_ops = {
>> +	.close =	aspeed_xdma_vma_close,
>> +};
>> +
>> +static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	int rc;
>> +	struct aspeed_xdma_client *client = file->private_data;
>> +	struct aspeed_xdma *ctx = client->ctx;
>> +
>> +	/* restrict file to one mapping */
>> +	if (client->size)
>> +		return -ENOMEM;
> Can we do better with the error code here?


Maybe? I'm open to suggestions...


>
>> +
>> +	client->size = vma->vm_end - vma->vm_start;
>> +	client->virt = gen_pool_dma_alloc(ctx->vga_pool, client->size,
>> +					  &client->phys);
>> +	if (!client->virt) {
>> +		client->phys = 0;
>> +		client->size = 0;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
> Where does client->phys get set?


gen_pool_dma_alloc sets it.


Thanks for the review!

Eddie



>
> Andrew
