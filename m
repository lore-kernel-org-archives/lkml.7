Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727C020854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hGF82qGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfCSMEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:47 -0400
Received: from mail-eopbgr740049.outbound.protection.outlook.com ([40.107.74.49]:21680
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbfCSMEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxLCdcBeWwOiRR7dl6t6bZLfvl6oR7mDBNBn33JpjW8=;
 b=hGF82qGOAUhlrxpN/S3GQ55eIGwj2xz51ljB7MBQmUQKRgUh+7qYbpH7iqD6vWzhrTQEiYqviktLPxVB8lLrB4UfCzKC5LqhWin4wAHRp25q0NgJKkPm4u6/XRyY1u4nlfosDCkvnhDjCfaVAzOM6KQj3ZcSzJTfjwoBU27R1n0=
Received: from SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) by DM6PR02MB5916.namprd02.prod.outlook.com
 (2603:10b6:5:152::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 12:04:39 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by SN4PR0201CA0016.outlook.office365.com
 (2603:10b6:803:2b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:39 +0000
Authentication-Results: spf=pass (sender IP is 149.199.80.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.80.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.80.198; helo=xir-pvapexch01.xlnx.xilinx.com;
Received: from xir-pvapexch01.xlnx.xilinx.com (149.199.80.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:39 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:37 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:37 +0000
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
        id 1h6DTx-0003Ch-Ll; Tue, 19 Mar 2019 12:04:37 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 08/12] misc: xilinx_sdfec: Add ability to get/set config
Date:   Tue, 19 Mar 2019 12:04:20 +0000
Message-ID: <1552997064-432700-9-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(396003)(376002)(2980300002)(199004)(189003)(956004)(28376004)(426003)(4326008)(26826003)(60926002)(5024004)(2201001)(6666004)(186003)(356004)(36756003)(14444005)(71366001)(93146003)(36906005)(478600001)(47776003)(8746002)(486006)(106466001)(11346002)(2616005)(446003)(44832011)(2906002)(8936002)(76176011)(7696005)(51416003)(316002)(476003)(126002)(246002)(8676002)(48376002)(50466002)(5660300002)(26005)(336012)(305945005)(7636002)(110136005)(54906003)(9786002)(106002)(50226002)(107886003)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5916;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de19e4a9-0129-4999-0b09-08d6ac631027
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB5916;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5916:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5916B288426038694F7B12C2CB400@DM6PR02MB5916.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6N7wsbNeLIWLTrZqAohVU1ktyU4WOWZvsghqP5shpNk/fK5lmFnGsZlYSUv33sjvf1Ro2Sf5c/dAZokHzWGfKzVCDXpeiY5u+vtGxn0fhO8fciMWAweEY+MCOIphrvxpPmZqKhX/MY0f81+MBPo74Q9n22EJdD98dq/nOyncpOejYDa5NilR6qWRACmusKo3PPLV3QL8ybWdcjs8o7hPcuKkBzJUjp/IP1TAMM3cbnVPhWxVQqjihMrmBrSTXmiqEiQV17dTSDq0xIDd1YF8fbd3yzRxnFJCIVHYlUddt0jXIZGKwpyb2QIe+ORc0rrz5Whc7Si0ATIOTPEfVSzmAhmZ2RQ+vpmWbE48zkjXMYsg3wEMWVglDmLRckxn9r0HKO9yaVkopNOCcslVERxHzZt5FaVWaReR+SlUAxFnzig=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:39.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de19e4a9-0129-4999-0b09-08d6ac631027
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5916
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add capability to get SD-FEC config data using ioctl
XSDFEC_GET_CONFIG.

- Add capability to set SD-FEC data order using ioctl
SDFEC_SET_ORDER. The order of data blocks can change
from input to output or to be maintained.

- Add capability to set SD-FEC bypass option using ioctl
XSDFEC_SET_BYPASS. The bypass mode is when HW is
configured to skip SD-FEC engine and redirect input
directly to output.

- Add capability to set SD-FEC active state using ioctl
XSDFEC_IS_ACTIVE. Support for ioctl which puts SD-FEC
in active or non-active state.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 86 ++++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h | 57 ++++++++++++++++++++++++++
 2 files changed, 143 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 088ad9d..e980b70 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -309,6 +309,19 @@ static int xsdfec_dev_release(struct inode *iptr, stru=
ct file *fptr)
        return 0;
 }

+static int xsdfec_get_config(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       int err;
+
+       err =3D copy_to_user(arg, &xsdfec->config, sizeof(xsdfec->config));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               err =3D -EFAULT;
+       }
+       return err;
+}
+
 static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 {
        struct xsdfec_turbo turbo;
@@ -670,6 +683,67 @@ static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, =
void __user *arg)
        return ret;
 }

+static int xsdfec_set_order(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       bool order_invalid;
+       enum xsdfec_order order =3D *((enum xsdfec_order *)arg);
+
+       order_invalid =3D (order !=3D XSDFEC_MAINTAIN_ORDER) &&
+                       (order !=3D XSDFEC_OUT_OF_ORDER);
+       if (order_invalid) {
+               dev_err(xsdfec->dev, "%s invalid order value %d for SDFEC%d=
",
+                       __func__, order, xsdfec->config.fec_id);
+               return -EINVAL;
+       }
+
+       /* Verify Device has not started */
+       if (xsdfec->state =3D=3D XSDFEC_STARTED) {
+               dev_err(xsdfec->dev,
+                       "%s attempting to set Order while started for SDFEC=
%d",
+                       __func__, xsdfec->config.fec_id);
+               return -EIO;
+       }
+
+       xsdfec_regwrite(xsdfec, XSDFEC_ORDER_ADDR, order);
+
+       xsdfec->config.order =3D order;
+
+       return 0;
+}
+
+static int xsdfec_set_bypass(struct xsdfec_dev *xsdfec, bool __user *arg)
+{
+       bool bypass =3D *arg;
+
+       /* Verify Device has not started */
+       if (xsdfec->state =3D=3D XSDFEC_STARTED) {
+               dev_err(xsdfec->dev,
+                       "%s attempting to set bypass while started for SDFE=
C%d",
+                       __func__, xsdfec->config.fec_id);
+               return -EIO;
+       }
+
+       if (bypass)
+               xsdfec_regwrite(xsdfec, XSDFEC_BYPASS_ADDR, 1);
+       else
+               xsdfec_regwrite(xsdfec, XSDFEC_BYPASS_ADDR, 0);
+
+       xsdfec->config.bypass =3D bypass;
+
+       return 0;
+}
+
+static int xsdfec_is_active(struct xsdfec_dev *xsdfec, bool __user *is_act=
ive)
+{
+       u32 reg_value;
+
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_ACTIVE_ADDR);
+       /* using a double ! operator instead of casting */
+       *is_active =3D !!(reg_value & XSDFEC_IS_ACTIVITY_SET);
+
+       return 0;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -771,6 +845,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigne=
d int cmd,
        }

        switch (cmd) {
+       case XSDFEC_GET_CONFIG:
+               rval =3D xsdfec_get_config(xsdfec, arg);
+               break;
        case XSDFEC_SET_TURBO:
                rval =3D xsdfec_set_turbo(xsdfec, arg);
                break;
@@ -780,6 +857,15 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsign=
ed int cmd,
        case XSDFEC_ADD_LDPC_CODE_PARAMS:
                rval =3D xsdfec_add_ldpc(xsdfec, arg);
                break;
+       case XSDFEC_SET_ORDER:
+               rval =3D xsdfec_set_order(xsdfec, arg);
+               break;
+       case XSDFEC_SET_BYPASS:
+               rval =3D xsdfec_set_bypass(xsdfec, arg);
+               break;
+       case XSDFEC_IS_ACTIVE:
+               rval =3D xsdfec_is_active(xsdfec, (bool __user *)arg);
+               break;
        default:
                /* Should not get here */
                dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index b70dbff..c6584a4 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -310,6 +310,19 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct x=
sdfec_ldpc_params *ldpc,
 #define XSDFEC_ADD_LDPC_CODE_PARAMS                                       =
     \
        _IOW(XSDFEC_MAGIC, 5, struct xsdfec_ldpc_params *)
 /**
+ * DOC: XSDFEC_GET_CONFIG
+ * @Parameters
+ *
+ * @struct xsdfec_config *
+ *     Pointer to the &struct xsdfec_config that contains the current
+ *     configuration settings of the SD-FEC Block
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC core configuration
+ */
+#define XSDFEC_GET_CONFIG _IOR(XSDFEC_MAGIC, 6, struct xsdfec_config *)
+/**
  * DOC: XSDFEC_GET_TURBO
  * @Parameters
  *
@@ -322,4 +335,48 @@ xsdfec_calculate_shared_ldpc_table_entry_size(struct x=
sdfec_ldpc_params *ldpc,
  * ioctl that returns SD-FEC turbo param values
  */
 #define XSDFEC_GET_TURBO _IOR(XSDFEC_MAGIC, 7, struct xsdfec_turbo *)
+/**
+ * DOC: XSDFEC_SET_ORDER
+ * @Parameters
+ *
+ * @struct unsigned long *
+ *     Pointer to the unsigned long that contains a value from the
+ *     @enum xsdfec_order
+ *
+ * @Description
+ *
+ * ioctl that sets order, if order of blocks can change from input to outp=
ut
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_ORDER _IOW(XSDFEC_MAGIC, 8, unsigned long *)
+/**
+ * DOC: XSDFEC_SET_BYPASS
+ * @Parameters
+ *
+ * @struct bool *
+ *     Pointer to bool that sets the bypass value, where false results in
+ *     normal operation and false results in the SD-FEC performing the
+ *     configured operations (same number of cycles) but output data match=
es
+ *     the input data
+ *
+ * @Description
+ *
+ * ioctl that sets bypass.
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_BYPASS _IOW(XSDFEC_MAGIC, 9, bool *)
+/**
+ * DOC: XSDFEC_IS_ACTIVE
+ * @Parameters
+ *
+ * @struct bool *
+ *     Pointer to bool that returns true if the SD-FEC is processing data
+ *
+ * @Description
+ *
+ * ioctl that determines if SD-FEC is processing data
+ */
+#define XSDFEC_IS_ACTIVE _IOR(XSDFEC_MAGIC, 10, bool *)
 #endif /* __XILINX_SDFEC_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
