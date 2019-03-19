Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB43FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817682173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AkyNxZ2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfCSMFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:24 -0400
Received: from mail-eopbgr740041.outbound.protection.outlook.com ([40.107.74.41]:43222
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727580AbfCSMEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbjnA48mRLjQ3V+zCB0Fk/0ulDa3kLV2iykrvJFOyrw=;
 b=AkyNxZ2zxLSlFknxHXMsj45W7hOQSWiQ7yfODvWa/xxQtrHeCOeY6EwduP+z5AgEJ8FJjwHIHCF9IX0LEDLy0az2pnhnzrt3C3ZdrpClO+wXT/DBluuEHrxVxpGhx8AXFPB+SUDtPlcqOFs3YHKlZCoefG874dC6Vq4HeXZ4tTI=
Received: from SN6PR02CA0013.namprd02.prod.outlook.com (2603:10b6:805:a2::26)
 by DM6PR02MB5915.namprd02.prod.outlook.com (2603:10b6:5:152::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Tue, 19 Mar
 2019 12:04:40 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN6PR02CA0013.outlook.office365.com
 (2603:10b6:805:a2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:40 +0000
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
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:39 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch02.xlnx.xilinx.com (172.21.17.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 19 Mar 2019 12:04:36 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:36 +0000
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
        id 1h6DTw-0003Ch-4i; Tue, 19 Mar 2019 12:04:36 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 06/12] misc: xilinx_sdfec: Add ability to configure turbo mode
Date:   Tue, 19 Mar 2019 12:04:18 +0000
Message-ID: <1552997064-432700-7-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(7636002)(76176011)(356004)(26005)(28376004)(305945005)(93146003)(2906002)(50226002)(36756003)(110136005)(316002)(47776003)(4326008)(5660300002)(60926002)(71366001)(9786002)(48376002)(50466002)(107886003)(54906003)(8676002)(26826003)(8746002)(8936002)(478600001)(246002)(36906005)(106466001)(6666004)(336012)(106002)(44832011)(5024004)(14444005)(2201001)(186003)(956004)(2616005)(446003)(51416003)(11346002)(426003)(126002)(7696005)(476003)(486006)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5915;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb99aa44-f134-4680-c1e6-08d6ac6310cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB5915;
X-MS-TrafficTypeDiagnostic: DM6PR02MB5915:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5915028F68BA82D82739D373CB400@DM6PR02MB5915.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Kl6WIImAzX93nlG7wtDdNyRMvpSmv6ZtAlRfzBUy6uPSFrG51IkS7jt2R2KCulCRSCw/LQYylKZzScJ6SxpzPM0DrIKJr8/QkrZrQG0KeEWe+yTNtYjGAdaVoZKxg27Jz6tsgTK1d10dj+oLP7spn3o/ia3HRwBB/ThjzIk8wip0pdy/jS8QqjcWdugvMtfpYuhwuhkVHEmA6/sDehfOrEBxb6eKjrDTIufBt4Qal0F1TFy04+eH+1NLs/x+xFkHavc1XFyKq04IBA7G06J+b1Kr93EG3gEy7x/lKmG4uPrsGkZooxCFNHAFLL0AEBZvypqK0zbH8i1LF78+y5gW85gTwuq6InwcfyvmgEJf5zniyyWGoxu9+NNdhz5bQYyKSz2h4o9XQ11hN4uYnElrAOO+yA4smdR1ZHMY/3f5DlI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:39.9299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb99aa44-f134-4680-c1e6-08d6ac6310cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to configure and retrieve turbo mode
via the ioctls XSDFEC_SET_TURBO and XSDFEC_GET_TURBO.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 83 ++++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h | 71 ++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index d9ead0b..58b1c57 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -115,6 +115,12 @@ static dev_t xsdfec_devt;
 /* BYPASS Register */
 #define XSDFEC_BYPASS_ADDR (0x3C)

+/* Turbo Code Register */
+#define XSDFEC_TURBO_ADDR (0x100)
+#define XSDFEC_TURBO_SCALE_MASK (0xFFF)
+#define XSDFEC_TURBO_SCALE_BIT_POS (8)
+#define XSDFEC_TURBO_SCALE_MAX (15)
+
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
  * @core_clk: Main processing clock for core
@@ -251,6 +257,77 @@ static int xsdfec_dev_release(struct inode *iptr, stru=
ct file *fptr)
        return 0;
 }

+static int xsdfec_set_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       struct xsdfec_turbo turbo;
+       int err;
+       u32 turbo_write;
+
+       err =3D copy_from_user(&turbo, arg, sizeof(turbo));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               return -EFAULT;
+       }
+
+       if (turbo.alg >=3D XSDFEC_TURBO_ALG_MAX) {
+               dev_err(xsdfec->dev,
+                       "%s invalid turbo alg value %d for SDFEC%d", __func=
__,
+                       turbo.alg, xsdfec->config.fec_id);
+               return -EINVAL;
+       }
+
+       if (turbo.scale > XSDFEC_TURBO_SCALE_MAX) {
+               dev_err(xsdfec->dev,
+                       "%s invalid turbo scale value %d for SDFEC%d", __fu=
nc__,
+                       turbo.scale, xsdfec->config.fec_id);
+               return -EINVAL;
+       }
+
+       /* Check to see what device tree says about the FEC codes */
+       if (xsdfec->config.code =3D=3D XSDFEC_LDPC_CODE) {
+               dev_err(xsdfec->dev,
+                       "%s: Unable to write Turbo to SDFEC%d check DT",
+                       __func__, xsdfec->config.fec_id);
+               return -EIO;
+       }
+
+       turbo_write =3D ((turbo.scale & XSDFEC_TURBO_SCALE_MASK)
+                      << XSDFEC_TURBO_SCALE_BIT_POS) |
+                     turbo.alg;
+       xsdfec_regwrite(xsdfec, XSDFEC_TURBO_ADDR, turbo_write);
+       return err;
+}
+
+static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       u32 reg_value;
+       struct xsdfec_turbo turbo_params;
+       int err;
+
+       if (xsdfec->config.code =3D=3D XSDFEC_LDPC_CODE) {
+               dev_err(xsdfec->dev,
+                       "%s: SDFEC%d is configured for LDPC, check DT",
+                       __func__, xsdfec->config.fec_id);
+               return -EIO;
+       }
+
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_TURBO_ADDR);
+
+       turbo_params.scale =3D (reg_value & XSDFEC_TURBO_SCALE_MASK) >>
+                            XSDFEC_TURBO_SCALE_BIT_POS;
+       turbo_params.alg =3D reg_value & 0x1;
+
+       err =3D copy_to_user(arg, &turbo_params, sizeof(turbo_params));
+       if (err) {
+               dev_err(xsdfec->dev, "%s failed for SDFEC%d", __func__,
+                       xsdfec->config.fec_id);
+               err =3D -EFAULT;
+       }
+
+       return err;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -352,6 +429,12 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsign=
ed int cmd,
        }

        switch (cmd) {
+       case XSDFEC_SET_TURBO:
+               rval =3D xsdfec_set_turbo(xsdfec, arg);
+               break;
+       case XSDFEC_GET_TURBO:
+               rval =3D xsdfec_get_turbo(xsdfec, arg);
+               break;
        default:
                /* Should not get here */
                dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index 0497b66..1a15771 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -39,6 +39,22 @@ enum xsdfec_order {
 };

 /**
+ * enum xsdfec_turbo_alg - Turbo Algorithm Type.
+ * @XSDFEC_MAX_SCALE: Max Log-Map algorithm with extrinsic scaling. When
+ *                   scaling is set to this is equivalent to the Max Log-M=
ap
+ *                   algorithm.
+ * @XSDFEC_MAX_STAR: Log-Map algorithm.
+ * @XSDFEC_TURBO_ALG_MAX: Used to indicate out of bound Turbo algorithms.
+ *
+ * This enum specifies which Turbo Decode algorithm is in use.
+ */
+enum xsdfec_turbo_alg {
+       XSDFEC_MAX_SCALE =3D 0,
+       XSDFEC_MAX_STAR,
+       XSDFEC_TURBO_ALG_MAX,
+};
+
+/**
  * enum xsdfec_state - State.
  * @XSDFEC_INIT: Driver is initialized.
  * @XSDFEC_STARTED: Driver is started.
@@ -96,6 +112,33 @@ enum xsdfec_axis_word_include {
 };

 /**
+ * struct xsdfec_turbo - User data for Turbo codes.
+ * @alg: Specifies which Turbo decode algorithm to use
+ * @scale: Specifies the extrinsic scaling to apply when the Max Scale alg=
orithm
+ *        has been selected
+ *
+ * Turbo code structure to communicate parameters to XSDFEC driver.
+ */
+struct xsdfec_turbo {
+       enum xsdfec_turbo_alg alg;
+       u8 scale;
+};
+
+/**
+ * struct xsdfec_status - Status of SD-FEC core.
+ * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
+ *          SD-FEC's in the FPGA and is related to the driver instance
+ *          Minor number.
+ * @state: State of the SD-FEC core
+ * @activity: Describes if the SD-FEC instance is Active
+ */
+struct xsdfec_status {
+       s32 fec_id;
+       enum xsdfec_state state;
+       char activity;
+};
+
+/**
  * struct xsdfec_irq - Enabling or Disabling Interrupts.
  * @enable_isr: If true enables the ISR
  * @enable_ecc_isr: If true enables the ECC ISR
@@ -137,4 +180,32 @@ struct xsdfec_config {
  * XSDFEC IOCTL List
  */
 #define XSDFEC_MAGIC 'f'
+/**
+ * DOC: XSDFEC_SET_TURBO
+ * @Parameters
+ *
+ * @struct xsdfec_turbo *
+ *     Pointer to the &struct xsdfec_turbo that contains the Turbo decode
+ *     settings for the SD-FEC core
+ *
+ * @Description
+ *
+ * ioctl that sets the SD-FEC Turbo parameter values
+ *
+ * This can only be used when the driver is in the XSDFEC_STOPPED state
+ */
+#define XSDFEC_SET_TURBO _IOW(XSDFEC_MAGIC, 4, struct xsdfec_turbo *)
+/**
+ * DOC: XSDFEC_GET_TURBO
+ * @Parameters
+ *
+ * @struct xsdfec_turbo *
+ *     Pointer to the &struct xsdfec_turbo that contains the current Turbo
+ *     decode settings of the SD-FEC Block
+ *
+ * @Description
+ *
+ * ioctl that returns SD-FEC turbo param values
+ */
+#define XSDFEC_GET_TURBO _IOR(XSDFEC_MAGIC, 7, struct xsdfec_turbo *)
 #endif /* __XILINX_SDFEC_H__ */
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
