Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B909EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 798CB20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 21:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfCDVhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 16:37:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726522AbfCDVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 16:37:16 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x24LWMwq039541
        for <linux-kernel@vger.kernel.org>; Mon, 4 Mar 2019 16:37:15 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r1a9x47sc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:37:14 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Mon, 4 Mar 2019 21:37:14 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 4 Mar 2019 21:37:10 -0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x24Lb9YT15794402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Mar 2019 21:37:09 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D1B136051;
        Mon,  4 Mar 2019 21:37:09 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8B9713604F;
        Mon,  4 Mar 2019 21:37:08 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  4 Mar 2019 21:37:08 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, joel@jms.id.au,
        andrew@aj.id.au, arnd@arndb.de, gregkh@linuxfoundation.org,
        jk@ozlabs.org, openbmc@lists.ozlabs.org,
        Eddie James <eajames@linux.ibm.com>
Subject: [PATCH 3/6] drivers/misc: xdma: Add user interface
Date:   Mon,  4 Mar 2019 15:36:57 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
References: <1551735420-16202-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19030421-0004-0000-0000-000014E9E812
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010705; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01169658; UDB=6.00611233; IPR=6.00950286;
 MB=3.00025831; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-04 21:37:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19030421-0005-0000-0000-00008ACB431E
Message-Id: <1551735420-16202-4-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-04_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903040151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits adds a miscdevice to provide a user interface to the XDMA
engine. The interface provides the write operation to start DMA
operations. The DMA parameters are passed as the data to the write call.
The actual data to transfer is NOT passed through write. Note that both
directions of DMA operation are accomplished through the write command;
BMC to host and host to BMC.

The XDMA engine is restricted to only accessing the reserved memory
space on the AST2500, typically used by the VGA. For this reason, this
commit also adds a simple memory manager for this reserved memory space
which can then be allocated in pages by users calling mmap. The space
allocated by a client will be the space used in the DMA operation. For
an "upstream" (BMC to host) operation, the data in the client's area
will be transferred to the host. For a "downstream" (host to BMC)
operation, the host data will be placed in the client's memory area.

Poll is also provided in order to determine when the DMA operation is
complete for non-blocking IO.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/misc/aspeed-xdma.c | 301 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)

diff --git a/drivers/misc/aspeed-xdma.c b/drivers/misc/aspeed-xdma.c
index 970ea92..16235b3 100644
--- a/drivers/misc/aspeed-xdma.c
+++ b/drivers/misc/aspeed-xdma.c
@@ -113,6 +113,12 @@ struct aspeed_xdma_cmd {
 	u32 resv1;
 };
 
+struct aspeed_xdma_vga_blk {
+	u32 phys;
+	u32 size;
+	struct list_head list;
+};
+
 struct aspeed_xdma_client;
 
 struct aspeed_xdma {
@@ -123,6 +129,8 @@ struct aspeed_xdma {
 
 	unsigned long flags;
 	unsigned int cmd_idx;
+	struct mutex list_lock;
+	struct mutex start_lock;
 	wait_queue_head_t wait;
 	struct aspeed_xdma_client *current_client;
 
@@ -131,6 +139,9 @@ struct aspeed_xdma {
 	dma_addr_t vga_dma;
 	void *cmdq;
 	void *vga_virt;
+	struct list_head vga_blks_free;
+
+	struct miscdevice misc;
 };
 
 struct aspeed_xdma_client {
@@ -298,6 +309,260 @@ static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static u32 aspeed_xdma_alloc_vga_blk(struct aspeed_xdma *ctx, u32 req_size)
+{
+	u32 phys = 0;
+	u32 size = PAGE_ALIGN(req_size);
+	struct aspeed_xdma_vga_blk *free;
+
+	mutex_lock(&ctx->list_lock);
+
+	list_for_each_entry(free, &ctx->vga_blks_free, list) {
+		if (free->size >= size) {
+			phys = free->phys;
+
+			if (size == free->size) {
+				dev_dbg(ctx->dev,
+					"Allocd %08x[%08x r(%08x)], del.\n",
+					phys, size, req_size);
+				list_del(&free->list);
+				kfree(free);
+			} else {
+				free->phys += size;
+				free->size -= size;
+				dev_dbg(ctx->dev, "Allocd %08x[%08x r(%08x)], "
+					"shrunk %08x[%08x].\n", phys, size,
+					req_size, free->phys, free->size);
+			}
+
+			break;
+		}
+	}
+
+	mutex_unlock(&ctx->list_lock);
+
+	return phys;
+}
+
+static void aspeed_xdma_free_vga_blk(struct aspeed_xdma *ctx, u32 phys,
+				     u32 req_size)
+{
+	u32 min_free = UINT_MAX;
+	u32 size = PAGE_ALIGN(req_size);
+	const u32 end = phys + size;
+	struct aspeed_xdma_vga_blk *free;
+
+	mutex_lock(&ctx->list_lock);
+
+	list_for_each_entry(free, &ctx->vga_blks_free, list) {
+		if (end == free->phys) {
+			u32 fend = free->phys + free->size;
+
+			dev_dbg(ctx->dev,
+				"Freed %08x[%08x r(%08x)], exp %08x[%08x].\n",
+				phys, size, req_size, free->phys, free->size);
+
+			free->phys = phys;
+			free->size = fend - free->phys;
+
+			mutex_unlock(&ctx->list_lock);
+			return;
+		}
+
+		if (free->phys < min_free)
+			min_free = free->phys;
+	}
+
+	free = kzalloc(sizeof(*free), GFP_KERNEL);
+	if (free) {
+		free->phys = phys;
+		free->size = size;
+
+		dev_dbg(ctx->dev, "Freed %08x[%08x r(%08x)], new.\n", phys,
+			size, req_size);
+
+		if (phys < min_free)
+			list_add(&free->list, &ctx->vga_blks_free);
+		else
+			list_add_tail(&free->list, &ctx->vga_blks_free);
+	} else {
+		dev_err(ctx->dev, "Failed to register freed block.\n");
+	}
+
+	mutex_unlock(&ctx->list_lock);
+}
+
+static ssize_t aspeed_xdma_write(struct file *file, const char __user *buf,
+				 size_t len, loff_t *offset)
+{
+	int rc;
+	struct aspeed_xdma_op op;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+	u32 offs = client->phys ? (client->phys - ctx->vga_phys) :
+		XDMA_CMDQ_SIZE;
+
+	if (len != sizeof(struct aspeed_xdma_op))
+		return -EINVAL;
+
+	rc = copy_from_user(&op, buf, len);
+	if (rc)
+		return rc;
+
+	if (op.len > (ctx->vga_size - offs) || op.len < XDMA_BYTE_ALIGN)
+		return -EINVAL;
+
+	if (file->f_flags & O_NONBLOCK) {
+		if (!mutex_trylock(&ctx->start_lock))
+			return -EAGAIN;
+
+		if (test_bit(XDMA_IN_PRG, &ctx->flags)) {
+			mutex_unlock(&ctx->start_lock);
+			return -EAGAIN;
+		}
+	} else {
+		mutex_lock(&ctx->start_lock);
+
+		rc = wait_event_interruptible(ctx->wait,
+					      !test_bit(XDMA_IN_PRG,
+							&ctx->flags));
+		if (rc) {
+			mutex_unlock(&ctx->start_lock);
+			return -EINTR;
+		}
+	}
+
+	ctx->current_client = client;
+	set_bit(XDMA_IN_PRG, &client->flags);
+
+	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs);
+
+	mutex_unlock(&ctx->start_lock);
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		rc = wait_event_interruptible(ctx->wait,
+					      !test_bit(XDMA_IN_PRG,
+							&ctx->flags));
+		if (rc)
+			return -EINTR;
+	}
+
+	return len;
+}
+
+static __poll_t aspeed_xdma_poll(struct file *file,
+				 struct poll_table_struct *wait)
+{
+	__poll_t mask = 0;
+	__poll_t req = poll_requested_events(wait);
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	if (req & (EPOLLIN | EPOLLRDNORM)) {
+		if (test_bit(XDMA_IN_PRG, &client->flags))
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!test_bit(XDMA_IN_PRG, &client->flags))
+			mask |= EPOLLIN | EPOLLRDNORM;
+	}
+
+	if (req & (EPOLLOUT | EPOLLWRNORM)) {
+		if (test_bit(XDMA_IN_PRG, &ctx->flags))
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!test_bit(XDMA_IN_PRG, &ctx->flags))
+			mask |= EPOLLOUT | EPOLLWRNORM;
+	}
+
+	return mask;
+}
+
+static void aspeed_xdma_vma_close(struct vm_area_struct *vma)
+{
+	struct aspeed_xdma_client *client = vma->vm_private_data;
+
+	aspeed_xdma_free_vga_blk(client->ctx, client->phys, client->size);
+
+	client->phys = 0;
+	client->size = 0;
+}
+
+static const struct vm_operations_struct aspeed_xdma_vm_ops = {
+	.close =	aspeed_xdma_vma_close,
+};
+
+static int aspeed_xdma_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int rc;
+	struct aspeed_xdma_client *client = file->private_data;
+	struct aspeed_xdma *ctx = client->ctx;
+
+	/* restrict file to one mapping */
+	if (client->size)
+		return -ENOMEM;
+
+	client->size = vma->vm_end - vma->vm_start;
+	client->phys = aspeed_xdma_alloc_vga_blk(ctx, client->size);
+	if (!client->phys) {
+		client->size = 0;
+		return -ENOMEM;
+	}
+
+	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
+	vma->vm_ops = &aspeed_xdma_vm_ops;
+	vma->vm_private_data = client;
+
+	rc = dma_mmap_coherent(ctx->dev, vma, ctx->vga_virt, ctx->vga_dma,
+			       ctx->vga_size);
+	if (rc) {
+		aspeed_xdma_free_vga_blk(ctx, client->phys, client->size);
+
+		client->phys = 0;
+		client->size = 0;
+		return rc;
+	}
+
+	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
+		vma->vm_start, client->phys, client->size);
+
+	return 0;
+}
+
+static int aspeed_xdma_open(struct inode *inode, struct file *file)
+{
+	struct miscdevice *misc = file->private_data;
+	struct aspeed_xdma *ctx = container_of(misc, struct aspeed_xdma, misc);
+	struct aspeed_xdma_client *client = kzalloc(sizeof(*client),
+						    GFP_KERNEL);
+
+	if (!client)
+		return -ENOMEM;
+
+	client->ctx = ctx;
+	file->private_data = client;
+	return 0;
+}
+
+static int aspeed_xdma_release(struct inode *inode, struct file *file)
+{
+	struct aspeed_xdma_client *client = file->private_data;
+
+	if (client->ctx->current_client == client)
+		client->ctx->current_client = NULL;
+
+	kfree(client);
+	return 0;
+}
+
+static const struct file_operations aspeed_xdma_fops = {
+	.owner			= THIS_MODULE,
+	.write			= aspeed_xdma_write,
+	.poll			= aspeed_xdma_poll,
+	.mmap			= aspeed_xdma_mmap,
+	.open			= aspeed_xdma_open,
+	.release		= aspeed_xdma_release,
+};
+
 static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 {
 	int rc;
@@ -360,12 +625,26 @@ static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 		return -ENOMEM;
 	}
 
+	aspeed_xdma_free_vga_blk(ctx, ctx->vga_phys, ctx->vga_size);
+	aspeed_xdma_alloc_vga_blk(ctx, XDMA_CMDQ_SIZE);
+
 	dev_dbg(ctx->dev, "VGA mapped at phys[%08x], size[%08x].\n",
 		ctx->vga_phys, ctx->vga_size);
 
 	return 0;
 }
 
+static void aspeed_xdma_free_vga_blks(struct aspeed_xdma *ctx)
+{
+	struct aspeed_xdma_vga_blk *free;
+	struct aspeed_xdma_vga_blk *tmp;
+
+	list_for_each_entry_safe(free, tmp, &ctx->vga_blks_free, list) {
+		list_del(&free->list);
+		kfree(free);
+	}
+}
+
 static int aspeed_xdma_probe(struct platform_device *pdev)
 {
 	int irq;
@@ -380,6 +659,9 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
 	init_waitqueue_head(&ctx->wait);
+	mutex_init(&ctx->list_lock);
+	mutex_init(&ctx->start_lock);
+	INIT_LIST_HEAD(&ctx->vga_blks_free);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->base = devm_ioremap_resource(dev, res);
@@ -425,6 +707,22 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	aspeed_xdma_init_eng(ctx);
 
+	ctx->misc.minor = MISC_DYNAMIC_MINOR;
+	ctx->misc.fops = &aspeed_xdma_fops;
+	ctx->misc.name = "xdma";
+	ctx->misc.parent = dev;
+	rc = misc_register(&ctx->misc);
+	if (rc) {
+		dev_err(dev, "Unable to register xdma miscdevice\n");
+
+		aspeed_xdma_free_vga_blks(ctx);
+		dma_free_coherent(dev, ctx->vga_size, ctx->vga_virt,
+				  ctx->vga_dma);
+		dma_release_declared_memory(dev);
+		reset_control_assert(ctx->reset);
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -432,6 +730,9 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	misc_deregister(&ctx->misc);
+
+	aspeed_xdma_free_vga_blks(ctx);
 	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
 			  ctx->vga_dma);
 	dma_release_declared_memory(ctx->dev);
-- 
1.8.3.1

