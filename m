Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D077C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6622146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="eyeUNmZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfCSMEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:04:50 -0400
Received: from mail-eopbgr680061.outbound.protection.outlook.com ([40.107.68.61]:54657
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbfCSMEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFqHGf6kODHbMVc8slJogLuV3UxkxgAz68bto8146Ns=;
 b=eyeUNmZJ9IeE7/QAFAuonp+NGw5ABBTUFnzsAVWA3ZkLW5jRod6lPynwLRB1Yp9/yuO3GebA+lbLQTjUvSX5tVm50ukza71mljWIB6z/K9ktDRvI+mcCuFuFo567Y3SUk2jCgc2nSR7RJPTg4EFQUPGUrwSRCnLBAPExhdjYtA8=
Received: from SN6PR02CA0023.namprd02.prod.outlook.com (2603:10b6:805:a2::36)
 by SN6PR02MB5551.namprd02.prod.outlook.com (2603:10b6:805:e8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.15; Tue, 19 Mar
 2019 12:04:39 +0000
Received: from SN1NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by SN6PR02CA0023.outlook.office365.com
 (2603:10b6:805:a2::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:39 +0000
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
 15.1.1531.3; Tue, 19 Mar 2019 12:04:35 +0000
Received: from smtp.xilinx.com (172.21.105.198) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 19 Mar 2019 12:04:35 +0000
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
        id 1h6DTv-0003Ch-G5; Tue, 19 Mar 2019 12:04:35 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 05/12] misc: xilinx_sdfec: Store driver config and state
Date:   Tue, 19 Mar 2019 12:04:17 +0000
Message-ID: <1552997064-432700-6-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(199004)(189003)(11346002)(26826003)(2906002)(76176011)(7636002)(51416003)(9786002)(30864003)(48376002)(44832011)(107886003)(26005)(7696005)(8676002)(5660300002)(486006)(8746002)(50466002)(305945005)(60926002)(8936002)(246002)(50226002)(4326008)(47776003)(186003)(106002)(93146003)(6666004)(356004)(478600001)(36906005)(110136005)(54906003)(5024004)(316002)(71366001)(336012)(2201001)(14444005)(126002)(2616005)(956004)(426003)(36756003)(476003)(446003)(28376004)(106466001)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5551;H:xir-pvapexch02.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a448b13-ccf5-45b8-828c-08d6ac631047
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:SN6PR02MB5551;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5551:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB55516E112AA7D012DF452520CB400@SN6PR02MB5551.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: VuvvQ6Mtv5SoLeg2IAFdvny7nuKa2tVvYDJkj1AMJf9s0mLyf0YGcCzcmfdlTl21DAeLqLQ8/cofyU2+PHNikgj754RdXwfXqXGC/t7Ipd6zefs5SWGjP24v8Ucwhghl/47TdhJwUtd0jL6F5CnnJNs+YX53QrZ+v/bjxo/msPli9zwgeDIv0dMRhf51mIp35J0Vk+cAwH0lKNMg6ik6T31vd0XGtpaNfyTbU0Nj3JV9FwJSjAtCe+cmVYln/xpq+MpVPkwloBzvImHeWA23gNDRCCWQXc12J3VQ75mJHwfr+hPULpGScuuP77dgsA2CGjp4WHIg0FneKJ58zkB1zdGIh4zYR9HCMG82aymG62FK3EEzjjQ3UlRzSb9Z5TFWwMqi2pvo5F6g+ks5vsoVxjrZmS7lUWdzkcjQHToxhiU=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:39.0642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a448b13-ccf5-45b8-828c-08d6ac631047
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stores configuration based on parameters from the DT
node and values from the SD-FEC core plus reads
the default state from the SD-FEC core. To obtain
values from the core register read, write capabilities
have been added plus related register map details.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 307 +++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h |  94 ++++++++++++
 2 files changed, 401 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 3407de4..d9ead0b 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -36,6 +36,85 @@ static struct class *xsdfec_class;
 static atomic_t xsdfec_ndevs =3D ATOMIC_INIT(0);
 static dev_t xsdfec_devt;

+/* Xilinx SDFEC Register Map */
+/* CODE_WRI_PROTECT Register */
+#define XSDFEC_CODE_WR_PROTECT_ADDR (0x4)
+
+/* ACTIVE Register */
+#define XSDFEC_ACTIVE_ADDR (0x8)
+#define XSDFEC_IS_ACTIVITY_SET (0x1)
+
+/* AXIS_WIDTH Register */
+#define XSDFEC_AXIS_WIDTH_ADDR (0xC)
+#define XSDFEC_AXIS_DOUT_WORDS_LSB (5)
+#define XSDFEC_AXIS_DOUT_WIDTH_LSB (3)
+#define XSDFEC_AXIS_DIN_WORDS_LSB (2)
+#define XSDFEC_AXIS_DIN_WIDTH_LSB (0)
+
+/* AXIS_ENABLE Register */
+#define XSDFEC_AXIS_ENABLE_ADDR (0x10)
+#define XSDFEC_AXIS_OUT_ENABLE_MASK (0x38)
+#define XSDFEC_AXIS_IN_ENABLE_MASK (0x7)
+#define XSDFEC_AXIS_ENABLE_MASK                                           =
     \
+       (XSDFEC_AXIS_OUT_ENABLE_MASK | XSDFEC_AXIS_IN_ENABLE_MASK)
+
+/* FEC_CODE Register */
+#define XSDFEC_FEC_CODE_ADDR (0x14)
+
+/* ORDER Register Map */
+#define XSDFEC_ORDER_ADDR (0x18)
+
+/* Interrupt Status Register */
+#define XSDFEC_ISR_ADDR (0x1C)
+/* Interrupt Status Register Bit Mask */
+#define XSDFEC_ISR_MASK (0x3F)
+
+/* Write Only - Interrupt Enable Register */
+#define XSDFEC_IER_ADDR (0x20)
+/* Write Only - Interrupt Disable Register */
+#define XSDFEC_IDR_ADDR (0x24)
+/* Read Only - Interrupt Mask Register */
+#define XSDFEC_IMR_ADDR (0x28)
+
+/* ECC Interrupt Status Register */
+#define XSDFEC_ECC_ISR_ADDR (0x2C)
+/* Single Bit Errors */
+#define XSDFEC_ECC_ISR_SBE_MASK (0x7FF)
+/* PL Initialize Single Bit Errors */
+#define XSDFEC_PL_INIT_ECC_ISR_SBE_MASK (0x3C00000)
+/* Multi Bit Errors */
+#define XSDFEC_ECC_ISR_MBE_MASK (0x3FF800)
+/* PL Initialize Multi Bit Errors */
+#define XSDFEC_PL_INIT_ECC_ISR_MBE_MASK (0x3C000000)
+/* Multi Bit Error to Event Shift */
+#define XSDFEC_ECC_ISR_MBE_TO_EVENT_SHIFT (11)
+/* PL Initialize Multi Bit Error to Event Shift */
+#define XSDFEC_PL_INIT_ECC_ISR_MBE_TO_EVENT_SHIFT (4)
+/* ECC Interrupt Status Bit Mask */
+#define XSDFEC_ECC_ISR_MASK (XSDFEC_ECC_ISR_SBE_MASK | XSDFEC_ECC_ISR_MBE_=
MASK)
+/* ECC Interrupt Status PL Initialize Bit Mask */
+#define XSDFEC_PL_INIT_ECC_ISR_MASK                                       =
     \
+       (XSDFEC_PL_INIT_ECC_ISR_SBE_MASK | XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+/* ECC Interrupt Status All Bit Mask */
+#define XSDFEC_ALL_ECC_ISR_MASK                                           =
     \
+       (XSDFEC_ECC_ISR_MASK | XSDFEC_PL_INIT_ECC_ISR_MASK)
+/* ECC Interrupt Status Single Bit Errors Mask */
+#define XSDFEC_ALL_ECC_ISR_SBE_MASK                                       =
     \
+       (XSDFEC_ECC_ISR_SBE_MASK | XSDFEC_PL_INIT_ECC_ISR_SBE_MASK)
+/* ECC Interrupt Status Multi Bit Errors Mask */
+#define XSDFEC_ALL_ECC_ISR_MBE_MASK                                       =
     \
+       (XSDFEC_ECC_ISR_MBE_MASK | XSDFEC_PL_INIT_ECC_ISR_MBE_MASK)
+
+/* Write Only - ECC Interrupt Enable Register */
+#define XSDFEC_ECC_IER_ADDR (0x30)
+/* Write Only - ECC Interrupt Disable Register */
+#define XSDFEC_ECC_IDR_ADDR (0x34)
+/* Read Only - ECC Interrupt Mask Register */
+#define XSDFEC_ECC_IMR_ADDR (0x38)
+
+/* BYPASS Register */
+#define XSDFEC_BYPASS_ADDR (0x3C)
+
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
  * @core_clk: Main processing clock for core
@@ -62,6 +141,7 @@ struct xsdfec_clks {
  * struct xsdfec_dev - Driver data for SDFEC
  * @regs: device physical base address
  * @dev: pointer to device struct
+ * @state: State of the SDFEC device
  * @config: Configuration of the SDFEC device
  * @open_count: Count of char device being opened
  * @xsdfec_cdev: Character device handle
@@ -73,6 +153,7 @@ struct xsdfec_clks {
 struct xsdfec_dev {
        void __iomem *regs;
        struct device *dev;
+       enum xsdfec_state state;
        struct xsdfec_config config;
        atomic_t open_count;
        struct cdev xsdfec_cdev;
@@ -81,6 +162,65 @@ struct xsdfec_dev {
        struct xsdfec_clks clks;
 };

+static inline void xsdfec_regwrite(struct xsdfec_dev *xsdfec, u32 addr,
+                                  u32 value)
+{
+       dev_dbg(xsdfec->dev, "Writing 0x%x to offset 0x%x", value, addr);
+       iowrite32(value, xsdfec->regs + addr);
+}
+
+static inline u32 xsdfec_regread(struct xsdfec_dev *xsdfec, u32 addr)
+{
+       u32 rval;
+
+       rval =3D ioread32(xsdfec->regs + addr);
+       dev_dbg(xsdfec->dev, "Read value =3D 0x%x from offset 0x%x", rval, =
addr);
+       return rval;
+}
+
+static void update_bool_config_from_reg(struct xsdfec_dev *xsdfec,
+                                       u32 reg_offset, u32 bit_num,
+                                       char *config_value)
+{
+       u32 reg_val;
+       u32 bit_mask =3D 1 << bit_num;
+
+       reg_val =3D xsdfec_regread(xsdfec, reg_offset);
+       *config_value =3D (reg_val & bit_mask) > 0;
+}
+
+static void update_config_from_hw(struct xsdfec_dev *xsdfec)
+{
+       u32 reg_value;
+       bool sdfec_started;
+
+       /* Update the Order */
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_ORDER_ADDR);
+       xsdfec->config.order =3D reg_value;
+
+       update_bool_config_from_reg(xsdfec, XSDFEC_BYPASS_ADDR,
+                                   0, /* Bit Number, maybe change to mask =
*/
+                                   &xsdfec->config.bypass);
+
+       update_bool_config_from_reg(xsdfec, XSDFEC_CODE_WR_PROTECT_ADDR,
+                                   0, /* Bit Number */
+                                   &xsdfec->config.code_wr_protect);
+
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_IMR_ADDR);
+       xsdfec->config.irq.enable_isr =3D (reg_value & XSDFEC_ISR_MASK) > 0=
;
+
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_ECC_IMR_ADDR);
+       xsdfec->config.irq.enable_ecc_isr =3D
+               (reg_value & XSDFEC_ECC_ISR_MASK) > 0;
+
+       reg_value =3D xsdfec_regread(xsdfec, XSDFEC_AXIS_ENABLE_ADDR);
+       sdfec_started =3D (reg_value & XSDFEC_AXIS_IN_ENABLE_MASK) > 0;
+       if (sdfec_started)
+               xsdfec->state =3D XSDFEC_STARTED;
+       else
+               xsdfec->state =3D XSDFEC_STOPPED;
+}
+
 static int xsdfec_dev_open(struct inode *iptr, struct file *fptr)
 {
        struct xsdfec_dev *xsdfec;
@@ -111,6 +251,69 @@ static int xsdfec_dev_release(struct inode *iptr, stru=
ct file *fptr)
        return 0;
 }

+static u32
+xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
+{
+       u32 axis_width_field =3D 0;
+
+       switch (axis_width_cfg) {
+       case XSDFEC_1x128b:
+               axis_width_field =3D 0;
+               break;
+       case XSDFEC_2x128b:
+               axis_width_field =3D 1;
+               break;
+       case XSDFEC_4x128b:
+               axis_width_field =3D 2;
+               break;
+       }
+
+       return axis_width_field;
+}
+
+static u32 xsdfec_translate_axis_words_cfg_val(enum xsdfec_axis_word_inclu=
de
+       axis_word_inc_cfg)
+{
+       u32 axis_words_field =3D 0;
+
+       if (axis_word_inc_cfg =3D=3D XSDFEC_FIXED_VALUE ||
+           axis_word_inc_cfg =3D=3D XSDFEC_IN_BLOCK)
+               axis_words_field =3D 0;
+       else if (axis_word_inc_cfg =3D=3D XSDFEC_PER_AXI_TRANSACTION)
+               axis_words_field =3D 1;
+
+       return axis_words_field;
+}
+
+static int xsdfec_cfg_axi_streams(struct xsdfec_dev *xsdfec)
+{
+       u32 reg_value;
+       u32 dout_words_field;
+       u32 dout_width_field;
+       u32 din_words_field;
+       u32 din_width_field;
+       struct xsdfec_config *config =3D &xsdfec->config;
+
+       /* translate config info to register values */
+       dout_words_field =3D
+               xsdfec_translate_axis_words_cfg_val(config->dout_word_inclu=
de);
+       dout_width_field =3D
+               xsdfec_translate_axis_width_cfg_val(config->dout_width);
+       din_words_field =3D
+               xsdfec_translate_axis_words_cfg_val(config->din_word_includ=
e);
+       din_width_field =3D
+               xsdfec_translate_axis_width_cfg_val(config->din_width);
+
+       reg_value =3D dout_words_field << XSDFEC_AXIS_DOUT_WORDS_LSB;
+       reg_value |=3D dout_width_field << XSDFEC_AXIS_DOUT_WIDTH_LSB;
+       reg_value |=3D din_words_field << XSDFEC_AXIS_DIN_WORDS_LSB;
+       reg_value |=3D din_width_field << XSDFEC_AXIS_DIN_WIDTH_LSB;
+
+       xsdfec_regwrite(xsdfec, XSDFEC_AXIS_WIDTH_ADDR, reg_value);
+
+       return 0;
+}
+
 static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
                             unsigned long data)
 {
@@ -164,6 +367,104 @@ static const struct file_operations xsdfec_fops =3D {
        .unlocked_ioctl =3D xsdfec_dev_ioctl,
 };

+static int xsdfec_parse_of(struct xsdfec_dev *xsdfec)
+{
+       struct device *dev =3D xsdfec->dev;
+       struct device_node *node =3D dev->of_node;
+       int rval;
+       const char *fec_code;
+       u32 din_width;
+       u32 din_word_include;
+       u32 dout_width;
+       u32 dout_word_include;
+
+       rval =3D of_property_read_string(node, "xlnx,sdfec-code", &fec_code=
);
+       if (rval < 0) {
+               dev_err(dev, "xlnx,sdfec-code not in DT");
+               return rval;
+       }
+
+       if (!strcasecmp(fec_code, "ldpc")) {
+               xsdfec->config.code =3D XSDFEC_LDPC_CODE;
+       } else if (!strcasecmp(fec_code, "turbo")) {
+               xsdfec->config.code =3D XSDFEC_TURBO_CODE;
+       } else {
+               dev_err(xsdfec->dev, "Invalid Code in DT");
+               return -EINVAL;
+       }
+
+       rval =3D of_property_read_u32(node, "xlnx,sdfec-din-words",
+                                   &din_word_include);
+       if (rval < 0) {
+               dev_err(dev, "xlnx,sdfec-din-words not in DT");
+               return rval;
+       }
+
+       if (din_word_include < XSDFEC_AXIS_WORDS_INCLUDE_MAX) {
+               xsdfec->config.din_word_include =3D din_word_include;
+       } else {
+               dev_err(xsdfec->dev, "Invalid DIN Words in DT");
+               return -EINVAL;
+       }
+
+       rval =3D of_property_read_u32(node, "xlnx,sdfec-din-width", &din_wi=
dth);
+       if (rval < 0) {
+               dev_err(dev, "xlnx,sdfec-din-width not in DT");
+               return rval;
+       }
+
+       switch (din_width) {
+       /* Fall through and set for valid values */
+       case XSDFEC_1x128b:
+       case XSDFEC_2x128b:
+       case XSDFEC_4x128b:
+               xsdfec->config.din_width =3D din_width;
+               break;
+       default:
+               dev_err(xsdfec->dev, "Invalid DIN Width in DT");
+               return -EINVAL;
+       }
+
+       rval =3D of_property_read_u32(node, "xlnx,sdfec-dout-words",
+                                   &dout_word_include);
+       if (rval < 0) {
+               dev_err(dev, "xlnx,sdfec-dout-words not in DT");
+               return rval;
+       }
+
+       if (dout_word_include < XSDFEC_AXIS_WORDS_INCLUDE_MAX) {
+               xsdfec->config.dout_word_include =3D dout_word_include;
+       } else {
+               dev_err(xsdfec->dev, "Invalid DOUT Words in DT");
+               return -EINVAL;
+       }
+
+       rval =3D of_property_read_u32(node, "xlnx,sdfec-dout-width", &dout_=
width);
+       if (rval < 0) {
+               dev_err(dev, "xlnx,sdfec-dout-width not in DT");
+               return rval;
+       }
+
+       switch (dout_width) {
+       /* Fall through and set for valid values */
+       case XSDFEC_1x128b:
+       case XSDFEC_2x128b:
+       case XSDFEC_4x128b:
+               xsdfec->config.dout_width =3D dout_width;
+               break;
+       default:
+               dev_err(xsdfec->dev, "Invalid DOUT Width in DT");
+               return -EINVAL;
+       }
+
+       /* Write LDPC to CODE Register */
+       xsdfec_regwrite(xsdfec, XSDFEC_FEC_CODE_ADDR, xsdfec->config.code);
+
+       xsdfec_cfg_axi_streams(xsdfec);
+
+       return 0;
+}
+
 static int xsdfec_clk_init(struct platform_device *pdev,
                           struct xsdfec_clks *clks)
 {
@@ -316,6 +617,12 @@ static int xsdfec_probe(struct platform_device *pdev)
                goto err_xsdfec_dev;
        }

+       err =3D xsdfec_parse_of(xsdfec);
+       if (err < 0)
+               goto err_xsdfec_dev;
+
+       update_config_from_hw(xsdfec);
+
        /* Save driver private data */
        platform_set_drvdata(pdev, xsdfec);

diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index 5de0add..0497b66 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -12,6 +12,33 @@
 #define __XILINX_SDFEC_H__

 /**
+ * enum xsdfec_code - Code Type.
+ * @XSDFEC_TURBO_CODE: Driver is configured for Turbo mode.
+ * @XSDFEC_LDPC_CODE: Driver is configured for LDPC mode.
+ *
+ * This enum is used to indicate the mode of the driver. The mode is deter=
mined
+ * by checking which codes are set in the driver. Note that the mode canno=
t be
+ * changed by the driver.
+ */
+enum xsdfec_code {
+       XSDFEC_TURBO_CODE =3D 0,
+       XSDFEC_LDPC_CODE,
+};
+
+/**
+ * enum xsdfec_order - Order
+ * @XSDFEC_MAINTAIN_ORDER: Maintain order execution of blocks.
+ * @XSDFEC_OUT_OF_ORDER: Out-of-order execution of blocks.
+ *
+ * This enum is used to indicate whether the order of blocks can change fr=
om
+ * input to output.
+ */
+enum xsdfec_order {
+       XSDFEC_MAINTAIN_ORDER =3D 0,
+       XSDFEC_OUT_OF_ORDER,
+};
+
+/**
  * enum xsdfec_state - State.
  * @XSDFEC_INIT: Driver is initialized.
  * @XSDFEC_STARTED: Driver is started.
@@ -30,13 +57,80 @@ enum xsdfec_state {
 };

 /**
+ * enum xsdfec_axis_width - AXIS_WIDTH.DIN Setting for 128-bit width.
+ * @XSDFEC_1x128b: DIN data input stream consists of a 128-bit lane
+ * @XSDFEC_2x128b: DIN data input stream consists of two 128-bit lanes
+ * @XSDFEC_4x128b: DIN data input stream consists of four 128-bit lanes
+ *
+ * This enum is used to indicate the AXIS_WIDTH.DIN setting for 128-bit wi=
dth.
+ * The number of lanes of the DIN data input stream depends upon the
+ * AXIS_WIDTH.DIN parameter.
+ */
+enum xsdfec_axis_width {
+       XSDFEC_1x128b =3D 1,
+       XSDFEC_2x128b =3D 2,
+       XSDFEC_4x128b =3D 4,
+};
+
+/**
+ * enum xsdfec_axis_word_include - Words Configuration.
+ * @XSDFEC_FIXED_VALUE: Fixed, the DIN_WORDS AXI4-Stream interface is remo=
ved
+ *                     from the IP instance and is driven with the specifi=
ed
+ *                     number of words.
+ * @XSDFEC_IN_BLOCK: In Block, configures the IP instance to expect a sing=
le
+ *                  DIN_WORDS value per input code block. The DIN_WORDS
+ *                  interface is present.
+ * @XSDFEC_PER_AXI_TRANSACTION: Per Transaction, configures the IP instanc=
e to
+ * expect one DIN_WORDS value per input transaction on the DIN interface. =
The
+ * DIN_WORDS interface is present.
+ * @XSDFEC_AXIS_WORDS_INCLUDE_MAX: Used to indicate out of bound Words
+ *                                Configurations.
+ *
+ * This enum is used to specify the DIN_WORDS configuration.
+ */
+enum xsdfec_axis_word_include {
+       XSDFEC_FIXED_VALUE =3D 0,
+       XSDFEC_IN_BLOCK,
+       XSDFEC_PER_AXI_TRANSACTION,
+       XSDFEC_AXIS_WORDS_INCLUDE_MAX,
+};
+
+/**
+ * struct xsdfec_irq - Enabling or Disabling Interrupts.
+ * @enable_isr: If true enables the ISR
+ * @enable_ecc_isr: If true enables the ECC ISR
+ */
+struct xsdfec_irq {
+       char enable_isr;
+       char enable_ecc_isr;
+};
+
+/**
  * struct xsdfec_config - Configuration of SD-FEC core.
  * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
  *          SD-FEC's in the FPGA and is related to the driver instance
  *          Minor number.
+ * @code: The codes being used by the SD-FEC instance
+ * @order: Order of Operation
+ * @bypass: Is the core being bypassed
+ * @code_wr_protect: Is write protection of LDPC codes enabled
+ * @din_width: Width of the DIN AXI4-Stream
+ * @din_word_include: How DIN_WORDS are inputted
+ * @dout_width: Width of the DOUT AXI4-Stream
+ * @dout_word_include: HOW DOUT_WORDS are outputted
+ * @irq: Enabling or disabling interrupts
  */
 struct xsdfec_config {
        s32 fec_id;
+       enum xsdfec_code code;
+       enum xsdfec_order order;
+       char bypass;
+       char code_wr_protect;
+       enum xsdfec_axis_width din_width;
+       enum xsdfec_axis_word_include din_word_include;
+       enum xsdfec_axis_width dout_width;
+       enum xsdfec_axis_word_include dout_word_include;
+       struct xsdfec_irq irq;
 };

 /*
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
