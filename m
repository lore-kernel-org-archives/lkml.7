Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1434DC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6B820869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 20:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfKHUVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 15:21:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727296AbfKHUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 15:21:37 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA8KLE7B136410;
        Fri, 8 Nov 2019 15:21:22 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w5dahkmav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 15:21:21 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xA8KGJ3c029898;
        Fri, 8 Nov 2019 20:18:42 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2w41uk2g3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Nov 2019 20:18:42 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA8KIftc40501582
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Nov 2019 20:18:41 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A595728059;
        Fri,  8 Nov 2019 20:18:41 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE24A28058;
        Fri,  8 Nov 2019 20:18:40 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.103.158])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  8 Nov 2019 20:18:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, joel@jms.id.au,
        maz@kernel.org, jason@lakedaemon.net, tglx@linutronix.de,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH 07/12] drivers/soc: xdma: Add user interface
Date:   Fri,  8 Nov 2019 14:18:28 -0600
Message-Id: <1573244313-9190-8-git-send-email-eajames@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
References: <1573244313-9190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-08_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911080195
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
space on the AST2500, typically used by the VGA. For this reason, the
VGA memory space is pooled and allocated with genalloc. Users calling
mmap allocate pages from this pool for their usage. The space allocated
by a client will be the space used in the DMA operation. For an
"upstream" (BMC to host) operation, the data in the client's area will
be transferred to the host. For a "downstream" (host to BMC) operation,
the host data will be placed in the client's memory area.

Poll is also provided in order to determine when the DMA operation is
complete for non-blocking IO.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/soc/aspeed/aspeed-xdma.c | 223 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 99041a6..3d37582 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -64,6 +64,9 @@
 #define XDMA_CMDQ_SIZE				PAGE_SIZE
 #define XDMA_NUM_CMDS				\
 	(XDMA_CMDQ_SIZE / sizeof(struct aspeed_xdma_cmd))
+#define XDMA_OP_SIZE_MAX			sizeof(struct aspeed_xdma_op)
+#define XDMA_OP_SIZE_MIN			\
+	(sizeof(struct aspeed_xdma_op) - sizeof(u64))
 
 /* Aspeed specification requires 10ms after switching the reset line */
 #define XDMA_RESET_TIME_MS			10
@@ -216,6 +219,7 @@ struct aspeed_xdma {
 	bool in_reset;
 	bool upstream;
 	unsigned int cmd_idx;
+	struct mutex file_lock;
 	struct mutex start_lock;
 	struct delayed_work reset_work;
 	spinlock_t client_lock;
@@ -230,6 +234,8 @@ struct aspeed_xdma {
 	dma_addr_t cmdq_vga_phys;
 	void *cmdq_vga_virt;
 	struct gen_pool *vga_pool;
+
+	struct miscdevice misc;
 };
 
 struct aspeed_xdma_client {
@@ -557,6 +563,204 @@ static irqreturn_t aspeed_xdma_pcie_irq(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
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
+	if (len < XDMA_OP_SIZE_MIN)
+		return -EINVAL;
+
+	if (len > XDMA_OP_SIZE_MAX)
+		len = XDMA_OP_SIZE_MAX;
+
+	rc = copy_from_user(&op, buf, len);
+	if (rc)
+		return rc;
+
+	if (op.direction == ASPEED_XDMA_DIRECTION_RESET) {
+		mutex_lock(&ctx->start_lock);
+
+		if (aspeed_xdma_reset_start(ctx)) {
+			msleep(XDMA_RESET_TIME_MS);
+
+			aspeed_xdma_reset_finish(ctx);
+		}
+
+		mutex_unlock(&ctx->start_lock);
+
+		return len;
+	} else if (op.direction > ASPEED_XDMA_DIRECTION_RESET) {
+		return -EINVAL;
+	}
+
+	if (op.len > ctx->vga_size - offs)
+		return -EINVAL;
+
+	if (file->f_flags & O_NONBLOCK) {
+		if (!mutex_trylock(&ctx->file_lock))
+			return -EAGAIN;
+
+		if (ctx->in_progress || ctx->in_reset) {
+			mutex_unlock(&ctx->file_lock);
+			return -EAGAIN;
+		}
+	} else {
+		mutex_lock(&ctx->file_lock);
+
+		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress &&
+					      !ctx->in_reset);
+		if (rc) {
+			mutex_unlock(&ctx->file_lock);
+			return -EINTR;
+		}
+	}
+
+	aspeed_xdma_start(ctx, &op, ctx->vga_phys + offs, client);
+
+	mutex_unlock(&ctx->file_lock);
+
+	if (!(file->f_flags & O_NONBLOCK)) {
+		rc = wait_event_interruptible(ctx->wait, !ctx->in_progress);
+		if (rc)
+			return -EINTR;
+
+		if (client->error)
+			return -EIO;
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
+		if (client->in_progress)
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!client->in_progress) {
+			if (client->error)
+				mask |= EPOLLERR;
+			else
+				mask |= EPOLLIN | EPOLLRDNORM;
+		}
+	}
+
+	if (req & (EPOLLOUT | EPOLLWRNORM)) {
+		if (ctx->in_progress)
+			poll_wait(file, &ctx->wait, wait);
+
+		if (!ctx->in_progress)
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
+	gen_pool_free(client->ctx->vga_pool, (unsigned long)client->virt,
+		      client->size);
+
+	client->virt = NULL;
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
+	client->virt = gen_pool_dma_alloc(ctx->vga_pool, client->size,
+					  &client->phys);
+	if (!client->virt) {
+		client->phys = 0;
+		client->size = 0;
+		return -ENOMEM;
+	}
+
+	vma->vm_pgoff = (client->phys - ctx->vga_phys) >> PAGE_SHIFT;
+	vma->vm_ops = &aspeed_xdma_vm_ops;
+	vma->vm_private_data = client;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	rc = io_remap_pfn_range(vma, vma->vm_start, client->phys >> PAGE_SHIFT,
+				client->size, vma->vm_page_prot);
+	if (rc) {
+		gen_pool_free(ctx->vga_pool, (unsigned long)client->virt,
+			      client->size);
+
+		client->virt = NULL;
+		client->phys = 0;
+		client->size = 0;
+		return rc;
+	}
+
+	dev_dbg(ctx->dev, "mmap: v[%08lx] to p[%08x], s[%08x]\n",
+		vma->vm_start, (u32)client->phys, client->size);
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
 static int aspeed_xdma_init(struct aspeed_xdma *ctx)
 {
 	int rc;
@@ -739,6 +943,7 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
+	mutex_init(&ctx->file_lock);
 	mutex_init(&ctx->start_lock);
 	INIT_DELAYED_WORK(&ctx->reset_work, aspeed_xdma_reset_work);
 	spin_lock_init(&ctx->client_lock);
@@ -797,6 +1002,23 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	aspeed_xdma_init_eng(ctx);
 
+	ctx->misc.minor = MISC_DYNAMIC_MINOR;
+	ctx->misc.fops = &aspeed_xdma_fops;
+	ctx->misc.name = "aspeed-xdma";
+	ctx->misc.parent = dev;
+	rc = misc_register(&ctx->misc);
+	if (rc) {
+		dev_err(dev, "Unable to register xdma miscdevice.\n");
+
+		gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
+			      XDMA_CMDQ_SIZE);
+		iounmap(ctx->vga_virt);
+
+		reset_control_assert(ctx->reset);
+		clk_disable_unprepare(ctx->clock);
+		return rc;
+	}
+
 	/*
 	 * This interrupt could fire immediately so only request it once the
 	 * engine and driver are initialized.
@@ -818,6 +1040,7 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
 		      XDMA_CMDQ_SIZE);
 	iounmap(ctx->vga_virt);
-- 
1.8.3.1

