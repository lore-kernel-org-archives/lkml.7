Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A35C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E9F20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="amVhjzI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfDIKHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:07:55 -0400
Received: from mail-eopbgr730078.outbound.protection.outlook.com ([40.107.73.78]:3232
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbfDIKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYHF96EnlOKZPQTfy3chEOwxj9PCo/jA6T8XvRv8H0o=;
 b=amVhjzI5Rnx9M4qrJOTs0qqPy0U912dFiA0UPCb2gDGOIF5BEbzRkSeJHFCZN8lK4+56bVVq3SPitGkvtsbVeziFStbTe+95ZDFV0pxWCWdgg1iLECr/EOeVnirP3snVR70KSPkYB+LlRy/wgvp4GUa/LKBTJbrOJLAzXRI7y7Q=
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by BLUPR02MB148.namprd02.prod.outlook.com (2a01:111:e400:849::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.1771.21; Tue, 9
 Apr 2019 10:07:19 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1771.16 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:18 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:18 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 9 Apr 2019 11:07:04 +0100
Received: from smtp.xilinx.com (172.21.105.197) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 9 Apr 2019 11:07:04 +0100
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=57788 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1hDnei-0007SJ-Mw; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 09/12] misc: xilinx_sdfec: Support poll file operation
Date:   Tue, 9 Apr 2019 11:06:51 +0100
Message-ID: <1554804414-206099-10-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(2980300002)(189003)(199004)(36756003)(486006)(126002)(48376002)(7696005)(446003)(14444005)(11346002)(426003)(2616005)(28376004)(476003)(50466002)(44832011)(336012)(356004)(6666004)(2906002)(956004)(51416003)(26826003)(478600001)(8936002)(30864003)(76130400001)(2201001)(106466001)(107886003)(9786002)(110136005)(93146003)(16586007)(54906003)(50226002)(316002)(36906005)(7636002)(246002)(47776003)(5660300002)(76176011)(71366001)(106002)(60926002)(305945005)(4326008)(8676002)(186003)(26005)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR02MB148;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8196efe6-96fc-4e5e-190e-08d6bcd3264a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BLUPR02MB148;
X-MS-TrafficTypeDiagnostic: BLUPR02MB148:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BLUPR02MB148201C3FBC69703137AB07CB2D0@BLUPR02MB148.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: tIEwiw/q2prtYZYftUjG9+mgraSgt73pykIOoLXKByevKGBS7x3fiv4YTzbCTTifgQcxfGX3/JXFyHBcooYiAqwFYNXMUB+E2Hg0AUGcv6Fbzjc3lo0VRZTklDhQ1to1GXUWRd1Z5UsD/73UzZrfHQNVlCLzb+i09dwzFiFS4qvsV8tc023nyQSdcB8Xqa5VjHDHL5U/CEDusXD3A1Ir3CH9OpzhRn5fPnBzQJ8qtNJgq9SHM8mGm5eZsHlhebW4lw+htfNGhkAPTtOkR/ul3QUnz1UiHiqEZqBh1w3k8F5Ipa+L5gkiEwfjaOXa7hZFNXwJcUMHk8QJu7+1ka24WgKsdd2tKd/NRFnCnrqbD6Xzx1c1IEntExMrrRMG65wknIj25wZSWhwiGZeNl2iVjUT23wpSF5RDsUWNaj/ttDA=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:18.4414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8196efe6-96fc-4e5e-190e-08d6bcd3264a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR02MB148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support monitoring and detecting the SD-FEC error events
through IRQ and poll file operation.

The SD-FEC device can detect one-error or multi-error events.
An error triggers an interrupt which creates and run the ONE_SHOT
IRQ thread.
The ONE_SHOT IRQ thread detects type of error and pass that
information to the poll function.
The file_operation callback poll(), collects the events and
updates the statistics accordingly.
The function poll blocks() on waiting queue which can be
unblocked by ONE_SHOT IRQ handling thread.

Support SD-FEC interrupt set ioctl callback.
The SD-FEC can detect two type of errors: coding errors (ECC) and
a data interface errors (TLAST).
The errors are  events which can trigger an IRQ if enabled.
The driver can monitor and detect these errors through IRQ.
Also the driver updates the statistical data.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 283 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h |  13 ++
 2 files changed, 296 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 560a2ed..32b2e2d 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -203,8 +203,15 @@ struct xsdfec_clks {
  * @dev: pointer to device struct
  * @state: State of the SDFEC device
  * @config: Configuration of the SDFEC device
+ * @state_updated: indicates State updated by interrupt handler
+ * @stats_updated: indicates Stats updated by interrupt handler
+ * @isr_err_count: Count of ISR errors
+ * @cecc_count: Count of Correctable ECC errors (SBE)
+ * @uecc_count: Count of Uncorrectable ECC errors (MBE)
  * @open_count: Count of char device being opened
+ * @irq: IRQ number
  * @xsdfec_cdev: Character device handle
+ * @waitq: Driver wait queue
  * @irq_lock: Driver spinlock
  * @clks: Clocks managed by the SDFEC driver
  *
@@ -215,8 +222,15 @@ struct xsdfec_dev {
 	struct device *dev;
 	enum xsdfec_state state;
 	struct xsdfec_config config;
+	bool state_updated;
+	bool stats_updated;
+	atomic_t isr_err_count;
+	atomic_t cecc_count;
+	atomic_t uecc_count;
 	atomic_t open_count;
+	int irq;
 	struct cdev xsdfec_cdev;
+	wait_queue_head_t waitq;
 	/* Spinlock to protect state_updated and stats_updated */
 	spinlock_t irq_lock;
 	struct xsdfec_clks clks;
@@ -317,6 +331,90 @@ static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
 	return err;
 }
 
+static int xsdfec_isr_enable(struct xsdfec_dev *xsdfec, bool enable)
+{
+	u32 mask_read;
+
+	if (enable) {
+		/* Enable */
+		xsdfec_regwrite(xsdfec, XSDFEC_IER_ADDR, XSDFEC_ISR_MASK);
+		mask_read = xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
+		if (mask_read & XSDFEC_ISR_MASK) {
+			dev_err(xsdfec->dev,
+				"SDFEC enabling irq with IER failed");
+			return -EIO;
+		}
+	} else {
+		/* Disable */
+		xsdfec_regwrite(xsdfec, XSDFEC_IDR_ADDR, XSDFEC_ISR_MASK);
+		mask_read = xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
+		if ((mask_read & XSDFEC_ISR_MASK) != XSDFEC_ISR_MASK) {
+			dev_err(xsdfec->dev,
+				"SDFEC disabling irq with IDR failed");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int xsdfec_ecc_isr_enable(struct xsdfec_dev *xsdfec, bool enable)
+{
+	u32 mask_read;
+
+	if (enable) {
+		/* Enable */
+		xsdfec_regwrite(xsdfec, XSDFEC_ECC_IER_ADDR,
+				XSDFEC_ALL_ECC_ISR_MASK);
+		mask_read = xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
+		if (mask_read & XSDFEC_ALL_ECC_ISR_MASK) {
+			dev_err(xsdfec->dev,
+				"SDFEC enabling ECC irq with ECC IER failed");
+			return -EIO;
+		}
+	} else {
+		/* Disable */
+		xsdfec_regwrite(xsdfec, XSDFEC_ECC_IDR_ADDR,
+				XSDFEC_ALL_ECC_ISR_MASK);
+		mask_read = xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
+		if (!(((mask_read & XSDFEC_ALL_ECC_ISR_MASK) ==
+		       XSDFEC_ECC_ISR_MASK) ||
+		      ((mask_read & XSDFEC_ALL_ECC_ISR_MASK) ==
+		       XSDFEC_PL_INIT_ECC_ISR_MASK))) {
+			dev_err(xsdfec->dev,
+				"SDFEC disable ECC irq with ECC IDR failed");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+static int xsdfec_set_irq(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	struct xsdfec_irq irq;
+	int err;
+	int isr_err;
+	int ecc_err;
+
+	err = copy_from_user(&irq, arg, sizeof(irq));
+	if (err)
+		return -EFAULT;
+
+	/* Setup tlast related IRQ */
+	isr_err = xsdfec_isr_enable(xsdfec, irq.enable_isr);
+	if (!isr_err)
+		xsdfec->config.irq.enable_isr = irq.enable_isr;
+
+	/* Setup ECC related IRQ */
+	ecc_err = xsdfec_ecc_isr_enable(xsdfec, irq.enable_ecc_isr);
+	if (!ecc_err)
+		xsdfec->config.irq.enable_ecc_isr = irq.enable_ecc_isr;
+
+	if (isr_err < 0 || ecc_err < 0)
+		err = -EIO;
+
+	return err;
+}
+
 static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 {
 	struct xsdfec_turbo turbo;
@@ -831,6 +929,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	case XSDFEC_GET_CONFIG:
 		rval = xsdfec_get_config(xsdfec, arg);
 		break;
+	case XSDFEC_SET_IRQ:
+		rval = xsdfec_set_irq(xsdfec, arg);
+		break;
 	case XSDFEC_SET_TURBO:
 		rval = xsdfec_set_turbo(xsdfec, arg);
 		break;
@@ -865,11 +966,34 @@ static long xsdfec_dev_compat_ioctl(struct file *file, unsigned int cmd,
 }
 #endif
 
+static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
+{
+	unsigned int mask = 0;
+	struct xsdfec_dev *xsdfec = file->private_data;
+
+	if (!xsdfec)
+		return POLLNVAL | POLLHUP;
+
+	poll_wait(file, &xsdfec->waitq, wait);
+
+	/* XSDFEC ISR detected an error */
+	spin_lock_irq(&xsdfec->irq_lock);
+	if (xsdfec->state_updated)
+		mask |= POLLIN | POLLPRI;
+
+	if (xsdfec->stats_updated)
+		mask |= POLLIN | POLLRDNORM;
+	spin_unlock_irq(&xsdfec->irq_lock);
+
+	return mask;
+}
+
 static const struct file_operations xsdfec_fops = {
 	.owner = THIS_MODULE,
 	.open = xsdfec_dev_open,
 	.release = xsdfec_dev_release,
 	.unlocked_ioctl = xsdfec_dev_ioctl,
+	.poll = xsdfec_poll,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl = xsdfec_dev_compat_ioctl,
 #endif
@@ -973,6 +1097,146 @@ static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
 	return 0;
 }
 
+static void xsdfec_count_and_clear_ecc_multi_errors(struct xsdfec_dev *xsdfec,
+						    u32 uecc)
+{
+	u32 uecc_event;
+
+	/* Update ECC ISR error counts */
+	atomic_add(hweight32(uecc), &xsdfec->uecc_count);
+	xsdfec->stats_updated = true;
+
+	/* Clear ECC errors */
+	xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR,
+			XSDFEC_ALL_ECC_ISR_MBE_MASK);
+	/* Clear ECC events */
+	if (uecc & XSDFEC_ECC_ISR_MBE_MASK) {
+		uecc_event = uecc >> XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT;
+		xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, uecc_event);
+	} else if (uecc & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK) {
+		uecc_event = uecc >> XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_SHIFT;
+		xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, uecc_event);
+	}
+}
+
+static void xsdfec_count_and_clear_ecc_single_errors(struct xsdfec_dev *xsdfec,
+						     u32 cecc, u32 sbe_mask)
+{
+	/* Update ECC ISR error counts */
+	atomic_add(hweight32(cecc), &xsdfec->cecc_count);
+	xsdfec->stats_updated = true;
+
+	/* Clear ECC errors */
+	xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, sbe_mask);
+}
+
+static void xsdfec_count_and_clear_isr_errors(struct xsdfec_dev *xsdfec,
+					      u32 isr_err)
+{
+	/* Update ISR error counts */
+	atomic_add(hweight32(isr_err), &xsdfec->isr_err_count);
+	xsdfec->stats_updated = true;
+
+	/* Clear ISR error status */
+	xsdfec_regwrite(xsdfec, XSDFEC_ISR_ADDR, XSDFEC_ISR_MASK);
+}
+
+static void xsdfec_update_state_for_isr_err(struct xsdfec_dev *xsdfec)
+{
+	xsdfec->state = XSDFEC_NEEDS_RESET;
+	xsdfec->state_updated = true;
+}
+
+static void xsdfec_update_state_for_ecc_err(struct xsdfec_dev *xsdfec,
+					    u32 ecc_err)
+{
+	if (ecc_err & XSDFEC_ECC_ISR_MBE_MASK)
+		xsdfec->state = XSDFEC_NEEDS_RESET;
+	else if (ecc_err & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+		xsdfec->state = XSDFEC_PL_RECONFIGURE;
+
+	xsdfec->state_updated = true;
+}
+
+static int xsdfec_get_sbe_mask(u32 ecc_err)
+{
+	u32 sbe_mask = XSDFEC_ALL_ECC_ISR_SBE_MASK;
+
+	if (ecc_err & XSDFEC_ECC_ISR_MBE_MASK) {
+		sbe_mask = (XSDFEC_ECC_ISR_MBE_MASK - ecc_err) >>
+			   XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT;
+	} else if (ecc_err & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+		sbe_mask = (XSDFEC_PL_INIT_ECC_ISR_MBE_MASK - ecc_err) >>
+			   XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_SHIFT;
+
+	return sbe_mask;
+}
+
+static irqreturn_t xsdfec_irq_thread(int irq, void *dev_id)
+{
+	struct xsdfec_dev *xsdfec = dev_id;
+	irqreturn_t ret = IRQ_HANDLED;
+	u32 ecc_err;
+	u32 isr_err;
+	u32 err_value;
+	u32 sbe_mask;
+
+	WARN_ON(xsdfec->irq != irq);
+
+	/* Mask Interrupts */
+	xsdfec_isr_enable(xsdfec, false);
+	xsdfec_ecc_isr_enable(xsdfec, false);
+
+	/* Read Interrupt Status Registers */
+	ecc_err = xsdfec_regread(xsdfec, XSDFEC_ECC_ISR_ADDR);
+	isr_err = xsdfec_regread(xsdfec, XSDFEC_ISR_ADDR);
+
+	spin_lock(&xsdfec->irq_lock);
+
+	err_value = ecc_err & XSDFEC_ALL_ECC_ISR_MBE_MASK;
+	if (err_value) {
+		dev_err(xsdfec->dev, "Multi-bit error on xsdfec%d",
+			xsdfec->config.fec_id);
+		/* Count and clear multi-bit errors and associated events */
+		xsdfec_count_and_clear_ecc_multi_errors(xsdfec, err_value);
+		xsdfec_update_state_for_ecc_err(xsdfec, ecc_err);
+	}
+
+	/*
+	 * Update SBE mask to remove events associated with MBE if present.
+	 * If no MBEs are present will return mask for all SBE bits
+	 */
+	sbe_mask = xsdfec_get_sbe_mask(err_value);
+	err_value = ecc_err & sbe_mask;
+	if (err_value) {
+		dev_info(xsdfec->dev, "Correctable error on xsdfec%d",
+			 xsdfec->config.fec_id);
+		xsdfec_count_and_clear_ecc_single_errors(xsdfec, err_value,
+							 sbe_mask);
+	}
+
+	err_value = isr_err & XSDFEC_ISR_MASK;
+	if (err_value) {
+		dev_err(xsdfec->dev,
+			"Tlast,or DIN_WORDS or DOUT_WORDS not correct");
+		xsdfec_count_and_clear_isr_errors(xsdfec, err_value);
+		xsdfec_update_state_for_isr_err(xsdfec);
+	}
+
+	if (xsdfec->state_updated || xsdfec->stats_updated)
+		wake_up_interruptible(&xsdfec->waitq);
+	else
+		ret = IRQ_NONE;
+
+	/* Unmaks Interrupts */
+	xsdfec_isr_enable(xsdfec, true);
+	xsdfec_ecc_isr_enable(xsdfec, true);
+
+	spin_unlock(&xsdfec->irq_lock);
+
+	return ret;
+}
+
 static int xsdfec_clk_init(struct platform_device *pdev,
 			   struct xsdfec_clks *clks)
 {
@@ -1103,6 +1367,7 @@ static int xsdfec_probe(struct platform_device *pdev)
 	struct device *dev_create;
 	struct resource *res;
 	int err;
+	bool irq_enabled = true;
 
 	xsdfec = devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
 	if (!xsdfec)
@@ -1125,6 +1390,12 @@ static int xsdfec_probe(struct platform_device *pdev)
 		goto err_xsdfec_dev;
 	}
 
+	xsdfec->irq = platform_get_irq(pdev, 0);
+	if (xsdfec->irq < 0) {
+		dev_dbg(dev, "platform_get_irq failed");
+		irq_enabled = false;
+	}
+
 	err = xsdfec_parse_of(xsdfec);
 	if (err < 0)
 		goto err_xsdfec_dev;
@@ -1134,6 +1405,18 @@ static int xsdfec_probe(struct platform_device *pdev)
 	/* Save driver private data */
 	platform_set_drvdata(pdev, xsdfec);
 
+	if (irq_enabled) {
+		init_waitqueue_head(&xsdfec->waitq);
+		/* Register IRQ thread */
+		err = devm_request_threaded_irq(dev, xsdfec->irq, NULL,
+						xsdfec_irq_thread, IRQF_ONESHOT,
+						"xilinx-sdfec16", xsdfec);
+		if (err < 0) {
+			dev_err(dev, "unable to request IRQ%d", xsdfec->irq);
+			goto err_xsdfec_dev;
+		}
+	}
+
 	cdev_init(&xsdfec->xsdfec_cdev, &xsdfec_fops);
 	xsdfec->xsdfec_cdev.owner = THIS_MODULE;
 	err = cdev_add(&xsdfec->xsdfec_cdev,
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index 22e9cfe..7dd9495 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -279,6 +279,19 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
  */
 #define XSDFEC_MAGIC 'f'
 /**
+ * DOC: XSDFEC_SET_IRQ
+ * @Parameters
+ *
+ * @struct xsdfec_irq *
+ *	Pointer to the &struct xsdfec_irq that contains the interrupt settings
+ *	for the SD-FEC core
+ *
+ * @Description
+ *
+ * ioctl to enable or disable irq
+ */
+#define XSDFEC_SET_IRQ _IOW(XSDFEC_MAGIC, 3, struct xsdfec_irq)
+/**
  * DOC: XSDFEC_SET_TURBO
  * @Parameters
  *
-- 
2.7.4

