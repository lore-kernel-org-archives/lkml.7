Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D80FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA7D2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MtKkQgi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbfCSMEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:50 -0400
Received: from mail-eopbgr820079.outbound.protection.outlook.com ([40.107.82.79]:22143
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727591AbfCSMEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTDgZcGclnXB2bcC8cV4Oq1pezekIiyFkntF8HYJ484=;
 b=MtKkQgi9I2c82ceigJuoE/tamZ9LxX5OShnbKTPW8boPQx2TlPFW8N5L6G/YqtWxbSddzub1rEJhnKT/lUOwNwtWTNLCwT0wPZEFYGdzmruj+Et437OIzVoTi0xYFw0JoJ0haOMrteu9ZPannK/UFS5/M7VUTmyK9lreiMk0Vrc=
Received: from SN6PR02CA0023.namprd02.prod.outlook.com (2603:10b6:805:a2::36)
 by BN8PR02MB5907.namprd02.prod.outlook.com (2603:10b6:408:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 12:04:41 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN6PR02CA0023.outlook.office365.com
 (2603:10b6:805:a2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch02.xlnx.xilinx.com;
Received: from xir-pvapexch02.xlnx.xilinx.com (149.199.80.198) by
 SN1NAM02FT057.mail.protection.outlook.com (10.152.73.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:40 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:38 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:38 +0000
Envelope-to: arnd@arndb.de,
 gregkh@linuxfoundation.org,
 michal.simek@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 dragan.cvetic@xilinx.com,
 derek.kiernan@xilinx.com
Received: from [149.199.110.15] (port=43674 helo=xirdraganc40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <dragan.cvetic@xilinx.com>)
        id 1h6DTy-0003Ch-Gs; Tue, 19 Mar 2019 12:04:38 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 09/12] misc: xilinx_sdfec: Support poll file operation
Date:   Tue, 19 Mar 2019 12:04:21 +0000
Message-ID: <1552997064-432700-10-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(2980300002)(199004)(189003)(2616005)(956004)(476003)(11346002)(2201001)(126002)(6666004)(356004)(36756003)(4326008)(60926002)(107886003)(44832011)(486006)(8676002)(50226002)(76176011)(446003)(8936002)(54906003)(26005)(7636002)(246002)(106002)(426003)(8746002)(9786002)(7696005)(336012)(51416003)(14444005)(93146003)(186003)(50466002)(47776003)(36906005)(110136005)(478600001)(28376004)(26826003)(48376002)(71366001)(5024004)(5660300002)(316002)(305945005)(30864003)(2906002)(106466001)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5907;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82d62a43-8bb5-4991-ea94-08d6ac63115b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN8PR02MB5907;
X-MS-TrafficTypeDiagnostic: BN8PR02MB5907:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN8PR02MB5907380384F6B16CF5CCF5CFCB400@BN8PR02MB5907.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qZDWnT+bxZs7uMYqrpeMtVs4UFQlWuLdw7QbCp6meg9mnlONQJ6w80iE2APbs7gdbYF69mIREWMRtUvGZ/kyCDApaDAxIiHC4YZceOnaE4lH6dQYr2/tTeDPiK2AAJyHrJpC7ZlPhLAPh1jkVqEqrRa8Gs54/m/VS/RPV9Ye9QyC8FiFqVe4nVnME3Cxg9z29QQSR5BuPxidQE/6kiKVVxt0eDtSnamufkCF0Aa7UPFK7thCV7m9GTkjA9xBtn1HNVTod515A4jsdsx+eDbU0PMrGSkxHGEHRThNvJiCR/8USMPSRcxjEKP1MiEW+pIuMLbZDzrZDYdSi6+ucA73FR29AAfj0m5EnxWIr3NvdRbeX6AOTtayQx9omb0xd0TXkP0vo9cY4I9vjoo8zTLsW73NPZvAgek1wejw0e5cgkY=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:40.8757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d62a43-8bb5-4991-ea94-08d6ac63115b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5907
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

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 286 +++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h |  13 ++
 2 files changed, 299 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index e980b70..b48a881 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -201,8 +201,15 @@ struct xsdfec_clks {
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
@@ -213,8 +220,15 @@ struct xsdfec_dev {
        struct device *dev;
        enum xsdfec_state state;
        struct xsdfec_config config;
+       bool state_updated;
+       bool stats_updated;
+       atomic_t isr_err_count;
+       atomic_t cecc_count;
+       atomic_t uecc_count;
        atomic_t open_count;
+       int irq;
        struct cdev xsdfec_cdev;
+       wait_queue_head_t waitq;
        /* Spinlock to protect state_updated and stats_updated */
        spinlock_t irq_lock;
        struct xsdfec_clks clks;
@@ -322,6 +336,93 @@ static int xsdfec_get_config(struct xsdfec_dev *xsdfec=
, void __user *arg)
        return err;
 }

+static int xsdfec_isr_enable(struct xsdfec_dev *xsdfec, bool enable)
+{
+       u32 mask_read;
+
+       if (enable) {
+               /* Enable */
+               xsdfec_regwrite(xsdfec, XSDFEC_IER_ADDR, XSDFEC_ISR_MASK);
+               mask_read =3D xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
+               if (mask_read & XSDFEC_ISR_MASK) {
+                       dev_err(xsdfec->dev,
+                               "SDFEC enabling irq with IER failed");
+                       return -EIO;
+               }
+       } else {
+               /* Disable */
+               xsdfec_regwrite(xsdfec, XSDFEC_IDR_ADDR, XSDFEC_ISR_MASK);
+               mask_read =3D xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
+               if ((mask_read & XSDFEC_ISR_MASK) !=3D XSDFEC_ISR_MASK) {
+                       dev_err(xsdfec->dev,
+                               "SDFEC disabling irq with IDR failed");
+                       return -EIO;
+               }
+       }
+       return 0;
+}
+
+static int xsdfec_ecc_isr_enable(struct xsdfec_dev *xsdfec, bool enable)
+{
+       u32 mask_read;
+
+       if (enable) {
+               /* Enable */
+               xsdfec_regwrite(xsdfec, XSDFEC_ECC_IER_ADDR,
+                               XSDFEC_ALL_ECC_ISR_MASK);
+               mask_read =3D xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
+               if (mask_read & XSDFEC_ALL_ECC_ISR_MASK) {
+                       dev_err(xsdfec->dev,
+                               "SDFEC enabling ECC irq with ECC IER failed=
");
+                       return -EIO;
+               }
+       } else {
+               /* Disable */
+               xsdfec_regwrite(xsdfec, XSDFEC_ECC_IDR_ADDR,
+                               XSDFEC_ALL_ECC_ISR_MASK);
+               mask_read =3D xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
+               if (!(((mask_read & XSDFEC_ALL_ECC_ISR_MASK) =3D=3D
+                      XSDFEC_ECC_ISR_MASK) ||
+                     ((mask_read & XSDFEC_ALL_ECC_ISR_MASK) =3D=3D
+                      XSDFEC_PL_INIT_ECC_ISR_MASK))) {
+                       dev_err(xsdfec->dev,
+                               "SDFEC disable ECC irq with ECC IDR failed"=
);
+                       return -EIO;
+               }
+       }
+       return 0;
+}
+
+static int xsdfec_set_irq(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       struct xsdfec_irq irq;
+       int err;
+       int isr_err;
+       int ecc_err;
+
+       err =3D copy_from_user(&irq, arg, sizeof(irq));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               return -EFAULT;
+       }
+
+       /* Setup tlast related IRQ */
+       isr_err =3D xsdfec_isr_enable(xsdfec, irq.enable_isr);
+       if (!isr_err)
+               xsdfec->config.irq.enable_isr =3D irq.enable_isr;
+
+       /* Setup ECC related IRQ */
+       ecc_err =3D xsdfec_ecc_isr_enable(xsdfec, irq.enable_ecc_isr);
+       if (!ecc_err)
+               xsdfec->config.irq.enable_ecc_isr =3D irq.enable_ecc_isr;
+
+       if (isr_err < 0 || ecc_err < 0)
+               err =3D -EIO;
+
+       return err;
+}
+
 static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 {
        struct xsdfec_turbo turbo;
@@ -848,6 +949,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigne=
d int cmd,
        case XSDFEC_GET_CONFIG:
                rval =3D xsdfec_get_config(xsdfec, arg);
                break;
+       case XSDFEC_SET_IRQ:
+               rval =3D xsdfec_set_irq(xsdfec, arg);
+               break;
        case XSDFEC_SET_TURBO:
                rval =3D xsdfec_set_turbo(xsdfec, arg);
                break;
@@ -874,11 +978,34 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsig=
ned int cmd,
        return rval;
 }

+static unsigned int xsdfec_poll(struct file *file, poll_table *wait)
+{
+       unsigned int mask =3D 0;
+       struct xsdfec_dev *xsdfec =3D file->private_data;
+
+       if (!xsdfec)
+               return POLLNVAL | POLLHUP;
+
+       poll_wait(file, &xsdfec->waitq, wait);
+
+       /* XSDFEC ISR detected an error */
+       spin_lock_irq(&xsdfec->irq_lock);
+       if (xsdfec->state_updated)
+               mask |=3D POLLIN | POLLPRI;
+
+       if (xsdfec->stats_updated)
+               mask |=3D POLLIN | POLLRDNORM;
+       spin_unlock_irq(&xsdfec->irq_lock);
+
+       return mask;
+}
+
 static const struct file_operations xsdfec_fops =3D {
        .owner =3D THIS_MODULE,
        .open =3D xsdfec_dev_open,
        .release =3D xsdfec_dev_release,
        .unlocked_ioctl =3D xsdfec_dev_ioctl,
+       .poll =3D xsdfec_poll,
 };

 static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
@@ -979,6 +1106,146 @@ static int xsdfec_parse_of(struct xsdfec_dev *xsdfec=
)
        return 0;
 }

+static void xsdfec_count_and_clear_ecc_multi_errors(struct xsdfec_dev *xsd=
fec,
+                                                   u32 uecc)
+{
+       u32 uecc_event;
+
+       /* Update ECC ISR error counts */
+       atomic_add(hweight32(uecc), &xsdfec->uecc_count);
+       xsdfec->stats_updated =3D true;
+
+       /* Clear ECC errors */
+       xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR,
+                       XSDFEC_ALL_ECC_ISR_MBE_MASK);
+       /* Clear ECC events */
+       if (uecc & XSDFEC_ECC_ISR_MBE_MASK) {
+               uecc_event =3D uecc >> XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT;
+               xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, uecc_event);
+       } else if (uecc & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK) {
+               uecc_event =3D uecc >> XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_=
SHIFT;
+               xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, uecc_event);
+       }
+}
+
+static void xsdfec_count_and_clear_ecc_single_errors(struct xsdfec_dev *xs=
dfec,
+                                                    u32 cecc, u32 sbe_mask=
)
+{
+       /* Update ECC ISR error counts */
+       atomic_add(hweight32(cecc), &xsdfec->cecc_count);
+       xsdfec->stats_updated =3D true;
+
+       /* Clear ECC errors */
+       xsdfec_regwrite(xsdfec, XSDFEC_ECC_ISR_ADDR, sbe_mask);
+}
+
+static void xsdfec_count_and_clear_isr_errors(struct xsdfec_dev *xsdfec,
+                                             u32 isr_err)
+{
+       /* Update ISR error counts */
+       atomic_add(hweight32(isr_err), &xsdfec->isr_err_count);
+       xsdfec->stats_updated =3D true;
+
+       /* Clear ISR error status */
+       xsdfec_regwrite(xsdfec, XSDFEC_ISR_ADDR, XSDFEC_ISR_MASK);
+}
+
+static void xsdfec_update_state_for_isr_err(struct xsdfec_dev *xsdfec)
+{
+       xsdfec->state =3D XSDFEC_NEEDS_RESET;
+       xsdfec->state_updated =3D true;
+}
+
+static void xsdfec_update_state_for_ecc_err(struct xsdfec_dev *xsdfec,
+                                           u32 ecc_err)
+{
+       if (ecc_err & XSDFEC_ECC_ISR_MBE_MASK)
+               xsdfec->state =3D XSDFEC_NEEDS_RESET;
+       else if (ecc_err & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+               xsdfec->state =3D XSDFEC_PL_RECONFIGURE;
+
+       xsdfec->state_updated =3D true;
+}
+
+static int xsdfec_get_sbe_mask(u32 ecc_err)
+{
+       u32 sbe_mask =3D XSDFEC_ALL_ECC_ISR_SBE_MASK;
+
+       if (ecc_err & XSDFEC_ECC_ISR_MBE_MASK) {
+               sbe_mask =3D (XSDFEC_ECC_ISR_MBE_MASK - ecc_err) >>
+                          XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT;
+       } else if (ecc_err & XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+               sbe_mask =3D (XSDFEC_PL_INIT_ECC_ISR_MBE_MASK - ecc_err) >>
+                          XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_SHIFT;
+
+       return sbe_mask;
+}
+
+static irqreturn_t xsdfec_irq_thread(int irq, void *dev_id)
+{
+       struct xsdfec_dev *xsdfec =3D dev_id;
+       irqreturn_t ret =3D IRQ_HANDLED;
+       u32 ecc_err;
+       u32 isr_err;
+       u32 err_value;
+       u32 sbe_mask;
+
+       WARN_ON(xsdfec->irq !=3D irq);
+
+       /* Mask Interrupts */
+       xsdfec_isr_enable(xsdfec, false);
+       xsdfec_ecc_isr_enable(xsdfec, false);
+
+       /* Read Interrupt Status Registers */
+       ecc_err =3D xsdfec_regread(xsdfec, XSDFEC_ECC_ISR_ADDR);
+       isr_err =3D xsdfec_regread(xsdfec, XSDFEC_ISR_ADDR);
+
+       spin_lock(&xsdfec->irq_lock);
+
+       err_value =3D ecc_err & XSDFEC_ALL_ECC_ISR_MBE_MASK;
+       if (err_value) {
+               dev_err(xsdfec->dev, "Multi-bit error on xsdfec%d",
+                       xsdfec->config.fec_id);
+               /* Count and clear multi-bit errors and associated events *=
/
+               xsdfec_count_and_clear_ecc_multi_errors(xsdfec, err_value);
+               xsdfec_update_state_for_ecc_err(xsdfec, ecc_err);
+       }
+
+       /*
+        * Update SBE mask to remove events associated with MBE if present.
+        * If no MBEs are present will return mask for all SBE bits
+        */
+       sbe_mask =3D xsdfec_get_sbe_mask(err_value);
+       err_value =3D ecc_err & sbe_mask;
+       if (err_value) {
+               dev_info(xsdfec->dev, "Correctable error on xsdfec%d",
+                        xsdfec->config.fec_id);
+               xsdfec_count_and_clear_ecc_single_errors(xsdfec, err_value,
+                                                        sbe_mask);
+       }
+
+       err_value =3D isr_err & XSDFEC_ISR_MASK;
+       if (err_value) {
+               dev_err(xsdfec->dev,
+                       "Tlast,or DIN_WORDS or DOUT_WORDS not correct");
+               xsdfec_count_and_clear_isr_errors(xsdfec, err_value);
+               xsdfec_update_state_for_isr_err(xsdfec);
+       }
+
+       if (xsdfec->state_updated || xsdfec->stats_updated)
+               wake_up_interruptible(&xsdfec->waitq);
+       else
+               ret =3D IRQ_NONE;
+
+       /* Unmaks Interrupts */
+       xsdfec_isr_enable(xsdfec, true);
+       xsdfec_ecc_isr_enable(xsdfec, true);
+
+       spin_unlock(&xsdfec->irq_lock);
+
+       return ret;
+}
+
 static int xsdfec_clk_init(struct platform_device *pdev,
                           struct xsdfec_clks *clks)
 {
@@ -1109,6 +1376,7 @@ static int xsdfec_probe(struct platform_device *pdev)
        struct device *dev_create;
        struct resource *res;
        int err;
+       bool irq_enabled =3D true;

        xsdfec =3D devm_kzalloc(&pdev->dev, sizeof(*xsdfec), GFP_KERNEL);
        if (!xsdfec)
@@ -1131,6 +1399,12 @@ static int xsdfec_probe(struct platform_device *pdev=
)
                goto err_xsdfec_dev;
        }

+       xsdfec->irq =3D platform_get_irq(pdev, 0);
+       if (xsdfec->irq < 0) {
+               dev_dbg(dev, "platform_get_irq failed");
+               irq_enabled =3D false;
+       }
+
        err =3D xsdfec_parse_of(xsdfec);
        if (err < 0)
                goto err_xsdfec_dev;
@@ -1140,6 +1414,18 @@ static int xsdfec_probe(struct platform_device *pdev=
)
        /* Save driver private data */
        platform_set_drvdata(pdev, xsdfec);

+       if (irq_enabled) {
+               init_waitqueue_head(&xsdfec->waitq);
+               /* Register IRQ thread */
+               err =3D devm_request_threaded_irq(dev, xsdfec->irq, NULL,
+                                               xsdfec_irq_thread, IRQF_ONE=
SHOT,
+                                               "xilinx-sdfec16", xsdfec);
+               if (err < 0) {
+                       dev_err(dev, "unable to request IRQ%d", xsdfec->irq=
);
+                       goto err_xsdfec_dev;
+               }
+       }
+
        cdev_init(&xsdfec->xsdfec_cdev, &xsdfec_fops);
        xsdfec->xsdfec_cdev.owner =3D THIS_MODULE;
        err =3D cdev_add(&xsdfec->xsdfec_cdev,
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index c6584a4..8dfada9 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -274,6 +274,19 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct x=
sdfec_ldpc_params *ldpc,
  */
 #define XSDFEC_MAGIC 'f'
 /**
+ * DOC: XSDFEC_SET_IRQ
+ * @Parameters
+ *
+ * @struct xsdfec_irq *
+ *     Pointer to the &struct xsdfec_irq that contains the interrupt setti=
ngs
+ *     for the SD-FEC core
+ *
+ * @Description
+ *
+ * ioctl to enable or disable irq
+ */
+#define XSDFEC_SET_IRQ _IOW(XSDFEC_MAGIC, 3, struct xsdfec_irq *)
+/**
  * DOC: XSDFEC_SET_TURBO
  * @Parameters
  *
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
