Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFADC2D0D1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386C24650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfLSQAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:00:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbfLSQAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:00:51 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJFwhjT089605;
        Thu, 19 Dec 2019 11:00:35 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x089gv1wc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 11:00:34 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBJG0ROH001030;
        Thu, 19 Dec 2019 16:00:33 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 2wvqc7bheu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 16:00:33 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJG0VLe28180824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 16:00:31 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6F30BE068;
        Thu, 19 Dec 2019 16:00:31 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C1E8BE06A;
        Thu, 19 Dec 2019 16:00:31 +0000 (GMT)
Received: from [9.211.143.195] (unknown [9.211.143.195])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 16:00:30 +0000 (GMT)
Subject: Re: [PATCH v3 07/12] soc: aspeed: xdma: Add user interface
To:     Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        Joel Stanley <joel@jms.id.au>
References: <1576681778-18737-1-git-send-email-eajames@linux.ibm.com>
 <1576681778-18737-8-git-send-email-eajames@linux.ibm.com>
 <de68ff11-0942-422a-b233-ff578b06eefc@www.fastmail.com>
From:   Eddie James <eajames@linux.ibm.com>
Message-ID: <22d81b7d-4f1c-30b9-e895-1f38a862462e@linux.ibm.com>
Date:   Thu, 19 Dec 2019 10:00:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <de68ff11-0942-422a-b233-ff578b06eefc@www.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_04:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=2
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912190133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/19 7:19 PM, Andrew Jeffery wrote:
>
> On Thu, 19 Dec 2019, at 01:39, Eddie James wrote:
>> This commits adds a miscdevice to provide a user interface to the XDMA
>> engine. The interface provides the write operation to start DMA
>> operations. The DMA parameters are passed as the data to the write call.
>> The actual data to transfer is NOT passed through write. Note that both
>> directions of DMA operation are accomplished through the write command;
>> BMC to host and host to BMC.
>>
>> The XDMA driver reserves an area of physical memory for DMA operations,
>> as the XDMA engine is restricted to accessing certain physical memory
>> areas on some platforms. This memory forms a pool from which users can
>> allocate pages for their usage with calls to mmap. The space allocated
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
>> Changes since v2:
>>   - Rework commit message to talk about VGA memory less
>>   - Remove user reset functionality
>>   - Clean up sanity checks in aspeed_xdma_write()
>>   - Wait for transfer complete in the vm area close function
>>
>>   drivers/soc/aspeed/aspeed-xdma.c | 205 ++++++++++++++++++++++++++++++-
>>   1 file changed, 203 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
>> index cb94adf798b1..e844937dc925 100644
>> --- a/drivers/soc/aspeed/aspeed-xdma.c
>> +++ b/drivers/soc/aspeed/aspeed-xdma.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/io.h>
>>   #include <linux/jiffies.h>
>>   #include <linux/mfd/syscon.h>
>> +#include <linux/miscdevice.h>
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/of_device.h>
>> @@ -201,6 +202,8 @@ struct aspeed_xdma {
>>   	struct clk *clock;
>>   	struct reset_control *reset;
>>   
>> +	/* file_lock serializes reads of current_client */
>> +	struct mutex file_lock;
> I wonder whether start_lock can serve this purpose.
>
>>   	/* client_lock protects error and in_progress of the client */
>>   	spinlock_t client_lock;
>>   	struct aspeed_xdma_client *current_client;
>> @@ -223,6 +226,8 @@ struct aspeed_xdma {
>>   	void __iomem *mem_virt;
>>   	dma_addr_t cmdq_phys;
>>   	struct gen_pool *pool;
>> +
>> +	struct miscdevice misc;
>>   };
>>   
>>   struct aspeed_xdma_client {
>> @@ -522,6 +527,185 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq,
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
>> +
>> +	if (len != sizeof(op))
>> +		return -EINVAL;
>> +
>> +	rc = copy_from_user(&op, buf, len);
>> +	if (rc)
>> +		return rc;
>> +
>> +	if (!op.len || op.len > client->size ||
>> +	    op.direction > ASPEED_XDMA_DIRECTION_UPSTREAM)
>> +		return -EINVAL;
>> +
>> +	if (file->f_flags & O_NONBLOCK) {
>> +		if (!mutex_trylock(&ctx->file_lock))
>> +			return -EAGAIN;
>> +
>> +		if (ctx->current_client) {
> Should be tested under client_lock for consistency with the previous patch,
> though perhaps you could use READ_ONCE()?


I think READ_ONCE will work.



>
>> +			mutex_unlock(&ctx->file_lock);
>> +			return -EBUSY;
>> +		}
>> +	} else {
>> +		mutex_lock(&ctx->file_lock);
>> +
>> +		rc = wait_event_interruptible(ctx->wait, !ctx->current_client);
>> +		if (rc) {
>> +			mutex_unlock(&ctx->file_lock);
>> +			return -EINTR;
>> +		}
>> +	}
>> +
>> +	aspeed_xdma_start(ctx, &op, client->phys, client);
>> +
>> +	mutex_unlock(&ctx->file_lock);
> Shouldn't we lift start_lock out of aspeed_xdma_start() use that here
> instead of file_lock? I think that would mean that we could remove
> file_lock.


That wouldn't work with the reset though. The reset should hold 
start_lock as well, but if a client is waiting here with start_lock, 
we'd never get to the reset if the transfer doesn't complete. I think 
file_lock is necessary.


>
>> +
>> +	if (!(file->f_flags & O_NONBLOCK)) {
>> +		rc = wait_event_interruptible(ctx->wait, !client->in_progress);
>> +		if (rc)
>> +			return -EINTR;
>> +
>> +		if (client->error)
>> +			return -EIO;
>> +	}
>> +
>> +	return len;
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
>> +		if (ctx->current_client)
>> +			poll_wait(file, &ctx->wait, wait);
>> +
>> +		if (!ctx->current_client)
>> +			mask |= EPOLLOUT | EPOLLWRNORM;
>> +	}
>> +
>> +	return mask;
>> +}
>> +
>> +static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
>> +{
>> +	int rc;
>> +	struct aspeed_xdma_client *client = vma->vm_private_data;
>> +
>> +	rc = wait_event_interruptible(client->ctx->wait, !client->in_progress);
>> +	if (rc)
>> +		return;
>> +
>> +	gen_pool_free(client->ctx->pool, (unsigned long)client->virt,
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
>> +		return -EBUSY;
>> +
>> +	client->size = vma->vm_end - vma->vm_start;
>> +	client->virt = gen_pool_dma_alloc(ctx->pool, client->size,
>> +					  &client->phys);
>> +	if (!client->virt) {
>> +		client->phys = 0;
>> +		client->size = 0;
>> +		return -ENOMEM;
>> +	}
>> +
>> +	vma->vm_pgoff = (client->phys - ctx->mem_phys) >> PAGE_SHIFT;
>> +	vma->vm_ops = &aspeed_xdma_vm_ops;
>> +	vma->vm_private_data = client;
>> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> +
>> +	rc = io_remap_pfn_range(vma, vma->vm_start, client->phys >> PAGE_SHIFT,
>> +				client->size, vma->vm_page_prot);
>> +	if (rc) {
> Probably worth a dev_warn() here so we know what happened?


Sure.


>
>> +		gen_pool_free(ctx->pool, (unsigned long)client->virt,
>> +			      client->size);
>> +
>> +		client->virt = NULL;
>> +		client->phys = 0;
>> +		client->size = 0;
>> +		return rc;
>> +	}
>> +
>> +	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
>> +		vma->vm_start, (u32)client->phys, client->size);
>> +
>> +	return 0;
>> +}
>> +
>> +static int aspeed_xdma_open(struct inode *inode, struct file *file)
>> +{
>> +	struct miscdevice *misc = file->private_data;
>> +	struct aspeed_xdma *ctx = container_of(misc, struct aspeed_xdma, misc);
>> +	struct aspeed_xdma_client *client = kzalloc(sizeof(*client),
>> +						    GFP_KERNEL);
>> +
>> +	if (!client)
>> +		return -ENOMEM;
>> +
>> +	client->ctx = ctx;
>> +	file->private_data = client;
>> +	return 0;
>> +}
>> +
>> +static int aspeed_xdma_release(struct inode *inode, struct file *file)
>> +{
>> +	struct aspeed_xdma_client *client = file->private_data;
>> +
>> +	kfree(client);
> I assume the vma gets torn down before release() gets invoked? I haven't
> looked closely.


 From what I've read, yes, the VMA has to be closed before release() can 
be called.


Thanks for the review!

Eddie


>
> Andrew
