Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AEEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B1E2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="z/WQ63VK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfCSMFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:11 -0400
Received: from mail-eopbgr790059.outbound.protection.outlook.com ([40.107.79.59]:37424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727606AbfCSMEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRigCOdcBp97mtzDiP+SbshrRbN2Cb/KTlqKXda3POc=;
 b=z/WQ63VKfV9WKZpQ89Qt8DMPHp583/QddteEAKYU+/5ptBujJOnJTWnBl/Kp8aypPiqC7QfaR+NFxIgdnoLhhUukSjzQach0DOilU1GIz99pwKbtpA6TnWZOm3NpqJxM9Ig5q0i4RH+mwaSua0tf5pSGTtjhbd69XWpXsExBFXs=
Received: from SN6PR02CA0035.namprd02.prod.outlook.com (52.135.118.176) by
 MWHPR02MB2205.namprd02.prod.outlook.com (10.168.243.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 12:04:43 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by SN6PR02CA0035.outlook.office365.com
 (2603:10b6:805:a2::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:42 +0000
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
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:42 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:39 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:39 +0000
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
        id 1h6DTz-0003Ch-9c; Tue, 19 Mar 2019 12:04:39 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 10/12] misc: xilinx_sdfec: Add stats & status ioctls
Date:   Tue, 19 Mar 2019 12:04:22 +0000
Message-ID: <1552997064-432700-11-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(2980300002)(189003)(199004)(446003)(316002)(36906005)(2201001)(76176011)(51416003)(8746002)(478600001)(47776003)(8676002)(106466001)(476003)(2906002)(126002)(36756003)(11346002)(26826003)(2616005)(9786002)(6666004)(60926002)(7696005)(71366001)(4326008)(5024004)(14444005)(336012)(356004)(8936002)(956004)(93146003)(50226002)(26005)(28376004)(486006)(186003)(5660300002)(246002)(426003)(50466002)(106002)(7636002)(44832011)(110136005)(54906003)(305945005)(48376002)(107886003)(102446001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB2205;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf1c9acc-625a-48a1-aada-08d6ac631256
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:MWHPR02MB2205;
X-MS-TrafficTypeDiagnostic: MWHPR02MB2205:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR02MB2205A56BA58365330A3C50F7CB400@MWHPR02MB2205.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: eSvgyVrRuQNF7XN3eonAbgNJGDZh1tKsQPtlPFfq1zCH1FbBYgU+H8MlO0Hi+JR7tzaMm9xyo0yYDksRqO367NnZXFGdOQAM/97bSSLgtFc/vMkDceN1mH+9H+GcxTth02IoUI7yXoF4Ugw0NWPb/2FdibSjWOPToRpTbLt8XYUKgBbPxVBjcyho/ra0dP7jiRlNMY5Y5xuhZGaOsHnSNpVomxeNYZZBqjXGx3uL2aGc2zvRMeUhHxASppr3hlnCpUvGI3s40BOSlR+B5VHPVIsFNn3igfyo73rVsC1pvKmSA3TU60uryZy+BgmcO7yNynySn3rtGgl1z2bustQXkJjqxZjbPnY0xZaJVDgCI0I+55oB5MRR0GwhA0qdU5UnOwzG0Nlv8CSNm3+5gttjvqVIPs7D0RpprcF726BsPi0=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:42.5160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1c9acc-625a-48a1-aada-08d6ac631256
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD-FEC statistic data are:
- count of data interface errors (isr_err_count)
- count of Correctable ECC errors (cecc_count)
- count of Uncorrectable ECC errors (uecc_count)

Add support:
1. clear stats ioctl callback which clears collected
statistic data,
2. get stats ioctl callback which reads a collected
statistic data,
3. set default configuration ioctl callback,
4. start ioctl callback enables SD-FEC HW,
5. stop ioctl callback disables SD-FEC HW.

In a failed state driver enables the following ioctls:
- get status
- get statistics
- clear stats
- set default SD-FEC device configuration

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Santhosh Dyavanapally <SDYAVANA@xilinx.com>
Tested by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Tested-by: Derek Kiernan <derek.kiernan@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 128 +++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h |  75 +++++++++++++++++++++++
 2 files changed, 203 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index b48a881..4e29e29 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -201,6 +201,7 @@ struct xsdfec_clks {
  * @dev: pointer to device struct
  * @state: State of the SDFEC device
  * @config: Configuration of the SDFEC device
+ * @intr_enabled: indicates IRQ enabled
  * @state_updated: indicates State updated by interrupt handler
  * @stats_updated: indicates Stats updated by interrupt handler
  * @isr_err_count: Count of ISR errors
@@ -220,6 +221,7 @@ struct xsdfec_dev {
        struct device *dev;
        enum xsdfec_state state;
        struct xsdfec_config config;
+       bool intr_enabled;
        bool state_updated;
        bool stats_updated;
        atomic_t isr_err_count;
@@ -323,6 +325,28 @@ static int xsdfec_dev_release(struct inode *iptr, stru=
ct file *fptr)
        return 0;
 }

+static int xsdfec_get_status(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       struct xsdfec_status status;
+       int err;
+
+       status.fec_id =3D xsdfec->config.fec_id;
+       spin_lock_irq(&xsdfec->irq_lock);
+       status.state =3D xsdfec->state;
+       xsdfec->state_updated =3D false;
+       spin_unlock_irq(&xsdfec->irq_lock);
+       status.activity =3D (xsdfec_regread(xsdfec, XSDFEC_ACTIVE_ADDR) &
+                          XSDFEC_IS_ACTIVITY_SET);
+
+       err =3D copy_to_user(arg, &status, sizeof(status));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               err =3D -EFAULT;
+       }
+       return err;
+}
+
 static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
 {
        int err;
@@ -908,6 +932,83 @@ static int xsdfec_cfg_axi_streams(struct xsdfec_dev *x=
sdfec)
        return 0;
 }

+static int xsdfec_start(struct xsdfec_dev *xsdfec)
+{
+       u32 regread;
+
+       regread =3D xsdfec_regread(xsdfec, XSDFEC_FEC_CODE_ADDR);
+       regread &=3D 0x1;
+       if (regread !=3D xsdfec->config.code) {
+               dev_err(xsdfec->dev,
+                       "%s SDFEC HW code does not match driver code, reg %=
d, code %d",
+                       __func__, regread, xsdfec->config.code);
+               return -EINVAL;
+       }
+
+       /* Set AXIS enable */
+       xsdfec_regwrite(xsdfec, XSDFEC_AXIS_ENABLE_ADDR,
+                       XSDFEC_AXIS_ENABLE_MASK);
+       /* Done */
+       xsdfec->state =3D XSDFEC_STARTED;
+       return 0;
+}
+
+static int xsdfec_stop(struct xsdfec_dev *xsdfec)
+{
+       u32 regread;
+
+       if (xsdfec->state !=3D XSDFEC_STARTED)
+               dev_err(xsdfec->dev, "Device not started correctly");
+       /* Disable AXIS_ENABLE Input interfaces only */
+       regread =3D xsdfec_regread(xsdfec, XSDFEC_AXIS_ENABLE_ADDR);
+       regread &=3D (~XSDFEC_AXIS_IN_ENABLE_MASK);
+       xsdfec_regwrite(xsdfec, XSDFEC_AXIS_ENABLE_ADDR, regread);
+       /* Stop */
+       xsdfec->state =3D XSDFEC_STOPPED;
+       return 0;
+}
+
+static int xsdfec_clear_stats(struct xsdfec_dev *xsdfec)
+{
+       atomic_set(&xsdfec->isr_err_count, 0);
+       atomic_set(&xsdfec->uecc_count, 0);
+       atomic_set(&xsdfec->cecc_count, 0);
+
+       return 0;
+}
+
+static int xsdfec_get_stats(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       int err;
+       struct xsdfec_stats user_stats;
+
+       spin_lock_irq(&xsdfec->irq_lock);
+       user_stats.isr_err_count =3D atomic_read(&xsdfec->isr_err_count);
+       user_stats.cecc_count =3D atomic_read(&xsdfec->cecc_count);
+       user_stats.uecc_count =3D atomic_read(&xsdfec->uecc_count);
+       xsdfec->stats_updated =3D false;
+       spin_unlock_irq(&xsdfec->irq_lock);
+
+       err =3D copy_to_user(arg, &user_stats, sizeof(user_stats));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               err =3D -EFAULT;
+       }
+
+       return err;
+}
+
+static int xsdfec_set_default_config(struct xsdfec_dev *xsdfec)
+{
+       /* Ensure registers are aligned with core configuration */
+       xsdfec_regwrite(xsdfec, XSDFEC_FEC_CODE_ADDR, xsdfec->config.code);
+       xsdfec_cfg_axi_streams(xsdfec);
+       update_config_from_hw(xsdfec);
+
+       return 0;
+}
+
 static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
                             unsigned long data)
 {
@@ -919,6 +1020,15 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsig=
ned int cmd,
        if (!xsdfec)
                return rval;

+       /* In failed state allow only reset and get status IOCTLs */
+       if (xsdfec->state =3D=3D XSDFEC_NEEDS_RESET &&
+           (cmd !=3D XSDFEC_SET_DEFAULT_CONFIG && cmd !=3D XSDFEC_GET_STAT=
US &&
+            cmd !=3D XSDFEC_GET_STATS && cmd !=3D XSDFEC_CLEAR_STATS)) {
+               dev_err(xsdfec->dev, "SDFEC%d in failed state. Reset Requir=
ed",
+                       xsdfec->config.fec_id);
+               return -EPERM;
+       }
+
        if (_IOC_TYPE(cmd) !=3D XSDFEC_MAGIC) {
                dev_err(xsdfec->dev, "Not a xilinx sdfec ioctl");
                return -ENOTTY;
@@ -946,9 +1056,27 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsig=
ned int cmd,
        }

        switch (cmd) {
+       case XSDFEC_START_DEV:
+               rval =3D xsdfec_start(xsdfec);
+               break;
+       case XSDFEC_STOP_DEV:
+               rval =3D xsdfec_stop(xsdfec);
+               break;
+       case XSDFEC_CLEAR_STATS:
+               rval =3D xsdfec_clear_stats(xsdfec);
+               break;
+       case XSDFEC_GET_STATS:
+               rval =3D xsdfec_get_stats(xsdfec, arg);
+               break;
+       case XSDFEC_GET_STATUS:
+               rval =3D xsdfec_get_status(xsdfec, arg);
+               break;
        case XSDFEC_GET_CONFIG:
                rval =3D xsdfec_get_config(xsdfec, arg);
                break;
+       case XSDFEC_SET_DEFAULT_CONFIG:
+               rval =3D xsdfec_set_default_config(xsdfec);
+               break;
        case XSDFEC_SET_IRQ:
                rval =3D xsdfec_set_irq(xsdfec, arg);
                break;
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index 8dfada9..df47995 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -235,6 +235,21 @@ struct xsdfec_config {
 };

 /**
+ * struct xsdfec_stats - Stats retrived by ioctl XSDFEC_GET_STATS. Used
+ *                      to buffer atomic_t variables from struct
+ *                      xsdfec_dev. Counts are accumulated until
+ *                      the user clears them.
+ * @isr_err_count: Count of ISR errors
+ * @cecc_count: Count of Correctable ECC errors (SBE)
+ * @uecc_count: Count of Uncorrectable ECC errors (MBE)
+ */
+struct xsdfec_stats {
+       u32 isr_err_count;
+       u32 cecc_count;
+       u32 uecc_count;
+};
+
+/**
  * struct xsdfec_ldpc_param_table_sizes - Used to store sizes of SD-FEC ta=
ble
  *                                       entries for an individual LPDC co=
de
  *                                       parameter.
@@ -274,6 +289,32 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct x=
sdfec_ldpc_params *ldpc,
  */
 #define XSDFEC_MAGIC 'f'
 /**
+ * DOC: XSDFEC_START_DEV
+ *
+ * @Description
+ *
+ * ioctl to start SD-FEC core
+ *
+ * This fails if the XSDFEC_SET_ORDER ioctl has not been previously called
+ */
+#define XSDFEC_START_DEV _IO(XSDFEC_MAGIC, 0)
+/**
+ * DOC: XSDFEC_STOP_DEV
+ *
+ * @Description
+ *
+ * ioctl to stop the SD-FEC core
+ */
+#define XSDFEC_STOP_DEV _IO(XSDFEC_MAGIC, 1)
+/**
+ * DOC: XSDFEC_GET_STATUS
+ *
+ * @Description
+ *
+ * ioctl that returns status of SD-FEC core
+ */
+#define XSDFEC_GET_STATUS _IOR(XSDFEC_MAGIC, 2, struct xsdfec_status *)
+/**
  * DOC: XSDFEC_SET_IRQ
  * @Parameters
  *
@@ -392,4 +433,38 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct x=
sdfec_ldpc_params *ldpc,
  * ioctl that determines if SD-FEC is processing data
  */
 #define XSDFEC_IS_ACTIVE _IOR(XSDFEC_MAGIC, 10, bool *)
+/**
+ * DOC: XSDFEC_CLEAR_STATS
+ *
+ * @Description
+ *
+ * ioctl that clears error stats collected during interrupts
+ */
+#define XSDFEC_CLEAR_STATS _IO(XSDFEC_MAGIC, 11)
+/**
+ * DOC: XSDFEC_GET_STATS
+ * @Parameters
+ *
+ * @struct xsdfec_stats *
+ *     Pointer to the &struct xsdfec_stats that will contain the updated s=
tats
+ *     values
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core stats
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_GET_STATS _IOR(XSDFEC_MAGIC, 12, struct xsdfec_stats *)
+/**
+ * DOC: XSDFEC_SET_DEFAULT_CONFIG
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core to default config, use after a reset
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_DEFAULT_CONFIG _IO(XSDFEC_MAGIC, 13)
+
 #endif /* __XILINX_SDFEC_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
