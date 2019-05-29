Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C1BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923E624045
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfE2SK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:10:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726102AbfE2SKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:10:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TI4V1g089668
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ssx9ra45f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 14:10:19 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <eajames@linux.ibm.com>;
        Wed, 29 May 2019 19:10:18 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 May 2019 19:10:14 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4TIADUh37355764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:10:13 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BB80112061;
        Wed, 29 May 2019 18:10:13 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B1D2112065;
        Wed, 29 May 2019 18:10:12 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 May 2019 18:10:12 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org, joel@jms.id.au,
        andrew@aj.id.au, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 3/8] drivers/soc: xdma: Add user interface
Date:   Wed, 29 May 2019 13:10:03 -0500
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
References: <1559153408-31190-1-git-send-email-eajames@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052918-0040-0000-0000-000004F6043C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011180; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01210373; UDB=6.00635908; IPR=6.00991405;
 MB=3.00027105; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-29 18:10:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052918-0041-0000-0000-000009021DD9
Message-Id: <1559153408-31190-4-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290117
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
 drivers/soc/aspeed/aspeed-xdma.c | 201 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/drivers/soc/aspeed/aspeed-xdma.c b/drivers/soc/aspeed/aspeed-xdma.c
index 3dc0ce4..39f6545 100644
--- a/drivers/soc/aspeed/aspeed-xdma.c
+++ b/drivers/soc/aspeed/aspeed-xdma.c
@@ -129,6 +129,8 @@ struct aspeed_xdma {
 
 	unsigned long flags;
 	unsigned int cmd_idx;
+	struct mutex list_lock;
+	struct mutex start_lock;
 	wait_queue_head_t wait;
 	struct aspeed_xdma_client *current_client;
 
@@ -140,6 +142,8 @@ struct aspeed_xdma {
 	dma_addr_t cmdq_vga_phys;
 	void *cmdq_vga_virt;
 	struct gen_pool *vga_pool;
+
+	struct miscdevice misc;
 };
 
 struct aspeed_xdma_client {
@@ -331,6 +335,183 @@ static irqreturn_t aspeed_xdma_irq(int irq, void *arg)
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
+
+	rc = dma_mmap_coherent(ctx->dev, vma, ctx->vga_virt, ctx->vga_dma,
+			       ctx->vga_size);
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
 static int aspeed_xdma_init_mem(struct aspeed_xdma *ctx)
 {
 	int rc;
@@ -431,6 +612,8 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 	ctx->dev = dev;
 	platform_set_drvdata(pdev, ctx);
 	init_waitqueue_head(&ctx->wait);
+	mutex_init(&ctx->list_lock);
+	mutex_init(&ctx->start_lock);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	ctx->base = devm_ioremap_resource(dev, res);
@@ -482,6 +665,23 @@ static int aspeed_xdma_probe(struct platform_device *pdev)
 
 	aspeed_xdma_init_eng(ctx);
 
+	ctx->misc.minor = MISC_DYNAMIC_MINOR;
+	ctx->misc.fops = &aspeed_xdma_fops;
+	ctx->misc.name = "xdma";
+	ctx->misc.parent = dev;
+	rc = misc_register(&ctx->misc);
+	if (rc) {
+		dev_err(dev, "Unable to register xdma miscdevice.\n");
+
+		gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
+			      XDMA_CMDQ_SIZE);
+		dma_free_coherent(dev, ctx->vga_size, ctx->vga_virt,
+				  ctx->vga_dma);
+		dma_release_declared_memory(dev);
+		reset_control_assert(ctx->reset);
+		return rc;
+	}
+
 	return 0;
 }
 
@@ -489,6 +689,7 @@ static int aspeed_xdma_remove(struct platform_device *pdev)
 {
 	struct aspeed_xdma *ctx = platform_get_drvdata(pdev);
 
+	misc_deregister(&ctx->misc);
 	gen_pool_free(ctx->vga_pool, (unsigned long)ctx->cmdq_vga_virt,
 		      XDMA_CMDQ_SIZE);
 	dma_free_coherent(ctx->dev, ctx->vga_size, ctx->vga_virt,
-- 
1.8.3.1

