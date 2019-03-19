Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEB4C10F0D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE46F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 12:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r5mg5YrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfCSMFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 08:05:03 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:34022
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbfCSMFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 08:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn/Zvi+oD6T+aOjLVwLL71HP7LtlxG8omwkzor21Dco=;
 b=r5mg5YrXcTGiwl7qILReWwGfvnTd3iR3l5UQwyylLGLi0Z4pGafTpXSZ8th2DrdV7nBMGCSjzhGwMNt+h9bQWJTvoLDTL5WcJQaOhcAcpAoo2FcC6agzQ8h246rc7IAJTIliqAzPJ0+tVUcDj3T8tsxzz4y+1892VPzS+eVX9kw=
Received: from SN4PR0201CA0009.namprd02.prod.outlook.com
 (2603:10b6:803:2b::19) by BYAPR02MB5911.namprd02.prod.outlook.com
 (2603:10b6:a03:122::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Tue, 19 Mar
 2019 12:04:38 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by SN4PR0201CA0009.outlook.office365.com
 (2603:10b6:803:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Tue, 19 Mar 2019 12:04:38 +0000
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
 15.20.1730.9 via Frontend Transport; Tue, 19 Mar 2019 12:04:37 +0000
Received: from xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) by
 xir-pvapexch01.xlnx.xilinx.com (172.21.17.15) with Microsoft SMTP Server
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
        id 1h6DTw-0003Ch-Q9; Tue, 19 Mar 2019 12:04:36 +0000
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH 07/12] misc: xilinx_sdfec: Add ability to configure LDPC
Date:   Tue, 19 Mar 2019 12:04:19 +0000
Message-ID: <1552997064-432700-8-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1552997064-432700-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(2980300002)(189003)(199004)(93146003)(106466001)(107886003)(28376004)(26826003)(48376002)(50466002)(106002)(54906003)(4326008)(356004)(110136005)(6666004)(30864003)(7696005)(51416003)(5660300002)(5024004)(14444005)(305945005)(76176011)(8746002)(26005)(126002)(8936002)(60926002)(486006)(2906002)(186003)(956004)(2616005)(476003)(446003)(246002)(2201001)(36756003)(44832011)(426003)(8676002)(11346002)(36906005)(316002)(50226002)(71366001)(336012)(478600001)(9786002)(7636002)(47776003)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5911;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd75699a-7911-4377-2e9d-08d6ac630f65
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4608103)(4709054)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BYAPR02MB5911;
X-MS-TrafficTypeDiagnostic: BYAPR02MB5911:
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB5911DC840BB55C1A661F16A1CB400@BYAPR02MB5911.namprd02.prod.outlook.com>
X-Forefront-PRVS: 0981815F2F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: JlMPCf+lyp5zIRDvfdUyq0wcG0I3VzEvpmmUCF8vEtH9AtAFRDknpDOBYZlQKCzPVw3XFlTjoiAmqq6OKbiEeBfQjdQ0dddTDHp8Jv7ca9WHrwTi1yPt6140lU4+rhS345rCWvNCBFfWDgPsILdTpUfOHIhX4FYqLN+Ild762CtUiJLJXBWEsaum3Nuob3NtgTw3aQCJGGYVmqRmAr6VpJrmuGT0jocjR2ZxldshQjCICwlcbQwdHNdkZwiT1OXVpoB3wPU8faVWQnS4FtWZWV1jP/2z9VlhdMOlz9n9XaRSaDPx7ObL9aKkgoFV6qT726oP/laijiw0Y/qLInf4gJdDjX6aaDJlHJ1w/b8G6MWOGUzHOnZg2RFc9EOA0ZFRACv7t+tSGa7DgZBPox+FclHxK9waQg6Qxyc8TPxsdy8=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2019 12:04:37.7881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd75699a-7911-4377-2e9d-08d6ac630f65
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5911
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to configure LDPC mode via the ioctl
XSDFEC_ADD_LDPC_CODE_PARAMS. The ioctl set the parameters
and tables for the LDPC FEC algorithm.

Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 345 +++++++++++++++++++++++++++++++++++=
++++
 include/uapi/misc/xilinx_sdfec.h | 114 +++++++++++++
 2 files changed, 459 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 58b1c57..088ad9d 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -121,6 +121,58 @@ static dev_t xsdfec_devt;
 #define XSDFEC_TURBO_SCALE_BIT_POS (8)
 #define XSDFEC_TURBO_SCALE_MAX (15)

+/* REG0 Register */
+#define XSDFEC_LDPC_CODE_REG0_ADDR_BASE (0x2000)
+#define XSDFEC_LDPC_CODE_REG0_ADDR_HIGH (0x27F0)
+#define XSDFEC_REG0_N_MIN (4)
+#define XSDFEC_REG0_N_MAX (32768)
+#define XSDFEC_REG0_N_MUL_P (256)
+#define XSDFEC_REG0_N_LSB (0)
+#define XSDFEC_REG0_K_MIN (2)
+#define XSDFEC_REG0_K_MAX (32766)
+#define XSDFEC_REG0_K_MUL_P (256)
+#define XSDFEC_REG0_K_LSB (16)
+
+/* REG1 Register */
+#define XSDFEC_LDPC_CODE_REG1_ADDR_BASE (0x2004)
+#define XSDFEC_LDPC_CODE_REG1_ADDR_HIGH (0x27f4)
+#define XSDFEC_REG1_PSIZE_MIN (2)
+#define XSDFEC_REG1_PSIZE_MAX (512)
+#define XSDFEC_REG1_NO_PACKING_MASK (0x400)
+#define XSDFEC_REG1_NO_PACKING_LSB (10)
+#define XSDFEC_REG1_NM_MASK (0xFF800)
+#define XSDFEC_REG1_NM_LSB (11)
+#define XSDFEC_REG1_BYPASS_MASK (0x100000)
+
+/* REG2 Register */
+#define XSDFEC_LDPC_CODE_REG2_ADDR_BASE (0x2008)
+#define XSDFEC_LDPC_CODE_REG2_ADDR_HIGH (0x27f8)
+#define XSDFEC_REG2_NLAYERS_MIN (1)
+#define XSDFEC_REG2_NLAYERS_MAX (256)
+#define XSDFEC_REG2_NNMQC_MASK (0xFFE00)
+#define XSDFEC_REG2_NMQC_LSB (9)
+#define XSDFEC_REG2_NORM_TYPE_MASK (0x100000)
+#define XSDFEC_REG2_NORM_TYPE_LSB (20)
+#define XSDFEC_REG2_SPECIAL_QC_MASK (0x200000)
+#define XSDFEC_REG2_SPEICAL_QC_LSB (21)
+#define XSDFEC_REG2_NO_FINAL_PARITY_MASK (0x400000)
+#define XSDFEC_REG2_NO_FINAL_PARITY_LSB (22)
+#define XSDFEC_REG2_MAX_SCHEDULE_MASK (0x1800000)
+#define XSDFEC_REG2_MAX_SCHEDULE_LSB (23)
+
+/* REG3 Register */
+#define XSDFEC_LDPC_CODE_REG3_ADDR_BASE (0x200C)
+#define XSDFEC_LDPC_CODE_REG3_ADDR_HIGH (0x27FC)
+#define XSDFEC_REG3_LA_OFF_LSB (8)
+#define XSDFEC_REG3_QC_OFF_LSB (16)
+
+#define XSDFEC_LDPC_REG_JUMP (0x10)
+#define XSDFEC_REG_WIDTH_JUMP (4)
+
+#define XSDFEC_SC_TABLE_DEPTH (0x3FC)
+#define XSDFEC_LA_TABLE_DEPTH (0xFFC)
+#define XSDFEC_QC_TABLE_DEPTH (0x7FFC)
+
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
  * @core_clk: Main processing clock for core
@@ -328,6 +380,296 @@ static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec=
, void __user *arg)
        return err;
 }

+static int xsdfec_reg0_write(struct xsdfec_dev *xsdfec, u32 n, u32 k, u32 =
psize,
+                            u32 offset)
+{
+       u32 wdata;
+
+       if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX ||
+           (n > XSDFEC_REG0_N_MUL_P * psize) || n <=3D k || ((n % psize) !=
=3D 0)) {
+               dev_err(xsdfec->dev, "N value is not in range");
+               return -EINVAL;
+       }
+       n <<=3D XSDFEC_REG0_N_LSB;
+
+       if (k < XSDFEC_REG0_K_MIN || k > XSDFEC_REG0_K_MAX ||
+           (k > XSDFEC_REG0_K_MUL_P * psize) || ((k % psize) !=3D 0)) {
+               dev_err(xsdfec->dev, "K value is not in range");
+               return -EINVAL;
+       }
+       k =3D k << XSDFEC_REG0_K_LSB;
+       wdata =3D k | n;
+
+       if (XSDFEC_LDPC_CODE_REG0_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUM=
P) >
+           XSDFEC_LDPC_CODE_REG0_ADDR_HIGH) {
+               dev_err(xsdfec->dev, "Writing outside of LDPC reg0 space 0x=
%x",
+                       XSDFEC_LDPC_CODE_REG0_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP));
+               return -EINVAL;
+       }
+       xsdfec_regwrite(xsdfec,
+                       XSDFEC_LDPC_CODE_REG0_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP),
+                       wdata);
+       return 0;
+}
+
+static int xsdfec_reg1_write(struct xsdfec_dev *xsdfec, u32 psize,
+                            u32 no_packing, u32 nm, u32 offset)
+{
+       u32 wdata;
+
+       if (psize < XSDFEC_REG1_PSIZE_MIN || psize > XSDFEC_REG1_PSIZE_MAX)=
 {
+               dev_err(xsdfec->dev, "Psize is not in range");
+               return -EINVAL;
+       }
+
+       if (no_packing !=3D 0 && no_packing !=3D 1)
+               dev_err(xsdfec->dev, "No-packing bit register invalid");
+       no_packing =3D ((no_packing << XSDFEC_REG1_NO_PACKING_LSB) &
+                     XSDFEC_REG1_NO_PACKING_MASK);
+
+       if (nm & ~(XSDFEC_REG1_NM_MASK >> XSDFEC_REG1_NM_LSB))
+               dev_err(xsdfec->dev, "NM is beyond 10 bits");
+       nm =3D (nm << XSDFEC_REG1_NM_LSB) & XSDFEC_REG1_NM_MASK;
+
+       wdata =3D nm | no_packing | psize;
+       if (XSDFEC_LDPC_CODE_REG1_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUM=
P) >
+           XSDFEC_LDPC_CODE_REG1_ADDR_HIGH) {
+               dev_err(xsdfec->dev, "Writing outside of LDPC reg1 space 0x=
%x",
+                       XSDFEC_LDPC_CODE_REG1_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP));
+               return -EINVAL;
+       }
+       xsdfec_regwrite(xsdfec,
+                       XSDFEC_LDPC_CODE_REG1_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP),
+                       wdata);
+       return 0;
+}
+
+static int xsdfec_reg2_write(struct xsdfec_dev *xsdfec, u32 nlayers, u32 n=
mqc,
+                            u32 norm_type, u32 special_qc, u32 no_final_pa=
rity,
+                            u32 max_schedule, u32 offset)
+{
+       u32 wdata;
+
+       if (nlayers < XSDFEC_REG2_NLAYERS_MIN ||
+           nlayers > XSDFEC_REG2_NLAYERS_MAX) {
+               dev_err(xsdfec->dev, "Nlayers is not in range");
+               return -EINVAL;
+       }
+
+       if (nmqc & ~(XSDFEC_REG2_NNMQC_MASK >> XSDFEC_REG2_NMQC_LSB))
+               dev_err(xsdfec->dev, "NMQC exceeds 11 bits");
+       nmqc =3D (nmqc << XSDFEC_REG2_NMQC_LSB) & XSDFEC_REG2_NNMQC_MASK;
+
+       if (norm_type > 1)
+               dev_err(xsdfec->dev, "Norm type is invalid");
+       norm_type =3D ((norm_type << XSDFEC_REG2_NORM_TYPE_LSB) &
+                    XSDFEC_REG2_NORM_TYPE_MASK);
+       if (special_qc > 1)
+               dev_err(xsdfec->dev, "Special QC in invalid");
+       special_qc =3D ((special_qc << XSDFEC_REG2_SPEICAL_QC_LSB) &
+                     XSDFEC_REG2_SPECIAL_QC_MASK);
+
+       if (no_final_parity > 1)
+               dev_err(xsdfec->dev, "No final parity check invalid");
+       no_final_parity =3D
+               ((no_final_parity << XSDFEC_REG2_NO_FINAL_PARITY_LSB) &
+                XSDFEC_REG2_NO_FINAL_PARITY_MASK);
+       if (max_schedule &
+           ~(XSDFEC_REG2_MAX_SCHEDULE_MASK >> XSDFEC_REG2_MAX_SCHEDULE_LSB=
))
+               dev_err(xsdfec->dev, "Max Schdule exceeds 2 bits");
+       max_schedule =3D ((max_schedule << XSDFEC_REG2_MAX_SCHEDULE_LSB) &
+                       XSDFEC_REG2_MAX_SCHEDULE_MASK);
+
+       wdata =3D (max_schedule | no_final_parity | special_qc | norm_type =
|
+                nmqc | nlayers);
+
+       if (XSDFEC_LDPC_CODE_REG2_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUM=
P) >
+           XSDFEC_LDPC_CODE_REG2_ADDR_HIGH) {
+               dev_err(xsdfec->dev, "Writing outside of LDPC reg2 space 0x=
%x",
+                       XSDFEC_LDPC_CODE_REG2_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP));
+               return -EINVAL;
+       }
+       xsdfec_regwrite(xsdfec,
+                       XSDFEC_LDPC_CODE_REG2_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP),
+                       wdata);
+       return 0;
+}
+
+static int xsdfec_reg3_write(struct xsdfec_dev *xsdfec, u8 sc_off, u8 la_o=
ff,
+                            u16 qc_off, u32 offset)
+{
+       u32 wdata;
+
+       wdata =3D ((qc_off << XSDFEC_REG3_QC_OFF_LSB) |
+                (la_off << XSDFEC_REG3_LA_OFF_LSB) | sc_off);
+       if (XSDFEC_LDPC_CODE_REG3_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUM=
P) >
+           XSDFEC_LDPC_CODE_REG3_ADDR_HIGH) {
+               dev_err(xsdfec->dev, "Writing outside of LDPC reg3 space 0x=
%x",
+                       XSDFEC_LDPC_CODE_REG3_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP));
+               return -EINVAL;
+       }
+       xsdfec_regwrite(xsdfec,
+                       XSDFEC_LDPC_CODE_REG3_ADDR_BASE +
+                               (offset * XSDFEC_LDPC_REG_JUMP),
+                       wdata);
+       return 0;
+}
+
+static int xsdfec_sc_table_write(struct xsdfec_dev *xsdfec, u32 offset,
+                                u32 *sc_ptr, u32 len)
+{
+       u32 reg;
+
+       /*
+        * Writes that go beyond the length of
+        * Shared Scale(SC) table should fail
+        */
+       if ((XSDFEC_REG_WIDTH_JUMP * (offset + len)) > XSDFEC_SC_TABLE_DEPT=
H) {
+               dev_err(xsdfec->dev, "Write exceeds SC table length");
+               return -EINVAL;
+       }
+
+       for (reg =3D 0; reg < len; reg++) {
+               xsdfec_regwrite(xsdfec,
+                               XSDFEC_LDPC_SC_TABLE_ADDR_BASE +
+                                       (offset + reg) * XSDFEC_REG_WIDTH_J=
UMP,
+                               sc_ptr[reg]);
+       }
+       return reg;
+}
+
+static int xsdfec_la_table_write(struct xsdfec_dev *xsdfec, u32 offset,
+                                u32 *la_ptr, u32 len)
+{
+       u32 reg;
+
+       if (XSDFEC_REG_WIDTH_JUMP * (offset + len) > XSDFEC_LA_TABLE_DEPTH)=
 {
+               dev_err(xsdfec->dev, "Write exceeds LA table length");
+               return -EINVAL;
+       }
+
+       for (reg =3D 0; reg < len; reg++) {
+               xsdfec_regwrite(xsdfec,
+                               XSDFEC_LDPC_LA_TABLE_ADDR_BASE +
+                                       (offset + reg) * XSDFEC_REG_WIDTH_J=
UMP,
+                               la_ptr[reg]);
+       }
+       return reg;
+}
+
+static int xsdfec_qc_table_write(struct xsdfec_dev *xsdfec, u32 offset,
+                                u32 *qc_ptr, u32 len)
+{
+       u32 reg;
+
+       if (XSDFEC_REG_WIDTH_JUMP * (offset + len) > XSDFEC_QC_TABLE_DEPTH)=
 {
+               dev_err(xsdfec->dev, "Write exceeds QC table length");
+               return -EINVAL;
+       }
+
+       for (reg =3D 0; reg < len; reg++) {
+               xsdfec_regwrite(xsdfec,
+                               XSDFEC_LDPC_QC_TABLE_ADDR_BASE +
+                                       (offset + reg) * XSDFEC_REG_WIDTH_J=
UMP,
+                               qc_ptr[reg]);
+       }
+
+       return reg;
+}
+
+static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+       struct xsdfec_ldpc_params *ldpc;
+       int ret;
+
+       ldpc =3D kzalloc(sizeof(*ldpc), GFP_KERNEL);
+       if (!ldpc)
+               return -ENOMEM;
+
+       ret =3D copy_from_user(ldpc, arg, sizeof(*ldpc));
+       if (ret) {
+               dev_err(xsdfec->dev, "%s failed to copy from user for SDFEC=
%d",
+                       __func__, xsdfec->config.fec_id);
+               goto err_out;
+       }
+       if (xsdfec->config.code =3D=3D XSDFEC_TURBO_CODE) {
+               dev_err(xsdfec->dev,
+                       "%s: Unable to write LDPC to SDFEC%d check DT",
+                       __func__, xsdfec->config.fec_id);
+               ret =3D -EIO;
+               goto err_out;
+       }
+
+       /* Verify Device has not started */
+       if (xsdfec->state =3D=3D XSDFEC_STARTED) {
+               dev_err(xsdfec->dev,
+                       "%s attempting to write LDPC code while started for=
 SDFEC%d",
+                       __func__, xsdfec->config.fec_id);
+               ret =3D -EIO;
+               goto err_out;
+       }
+
+       if (xsdfec->config.code_wr_protect) {
+               dev_err(xsdfec->dev,
+                       "%s writing LDPC code while Code Write Protection e=
nabled for SDFEC%d",
+                       __func__, xsdfec->config.fec_id);
+               ret =3D -EIO;
+               goto err_out;
+       }
+
+       /* Write Reg 0 */
+       ret =3D xsdfec_reg0_write(xsdfec, ldpc->n, ldpc->k, ldpc->psize,
+                               ldpc->code_id);
+       if (ret)
+               goto err_out;
+
+       /* Write Reg 1 */
+       ret =3D xsdfec_reg1_write(xsdfec, ldpc->psize, ldpc->no_packing, ld=
pc->nm,
+                               ldpc->code_id);
+       if (ret)
+               goto err_out;
+
+       /* Write Reg 2 */
+       ret =3D xsdfec_reg2_write(xsdfec, ldpc->nlayers, ldpc->nmqc,
+                               ldpc->norm_type, ldpc->special_qc,
+                               ldpc->no_final_parity, ldpc->max_schedule,
+                               ldpc->code_id);
+       if (ret)
+               goto err_out;
+
+       /* Write Reg 3 */
+       ret =3D xsdfec_reg3_write(xsdfec, ldpc->sc_off, ldpc->la_off,
+                               ldpc->qc_off, ldpc->code_id);
+       if (ret)
+               goto err_out;
+
+       /* Write Shared Codes */
+       ret =3D xsdfec_sc_table_write(xsdfec, ldpc->sc_off, ldpc->sc_table,
+                                   ldpc->nlayers);
+       if (ret < 0)
+               goto err_out;
+
+       ret =3D xsdfec_la_table_write(xsdfec, 4 * ldpc->la_off, ldpc->la_ta=
ble,
+                                   ldpc->nlayers);
+       if (ret < 0)
+               goto err_out;
+
+       ret =3D xsdfec_qc_table_write(xsdfec, 4 * ldpc->qc_off, ldpc->qc_ta=
ble,
+                                   ldpc->nqc);
+       if (ret > 0)
+               ret =3D 0;
+err_out:
+       kfree(ldpc);
+       return ret;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -435,6 +777,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigne=
d int cmd,
        case XSDFEC_GET_TURBO:
                rval =3D xsdfec_get_turbo(xsdfec, arg);
                break;
+       case XSDFEC_ADD_LDPC_CODE_PARAMS:
+               rval =3D xsdfec_add_ldpc(xsdfec, arg);
+               break;
        default:
                /* Should not get here */
                dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sd=
fec.h
index 1a15771..b70dbff 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -11,6 +11,14 @@
 #ifndef __XILINX_SDFEC_H__
 #define __XILINX_SDFEC_H__

+/* Shared LDPC Tables */
+#define XSDFEC_LDPC_SC_TABLE_ADDR_BASE (0x10000)
+#define XSDFEC_LDPC_SC_TABLE_ADDR_HIGH (0x103FC)
+#define XSDFEC_LDPC_LA_TABLE_ADDR_BASE (0x18000)
+#define XSDFEC_LDPC_LA_TABLE_ADDR_HIGH (0x18FFC)
+#define XSDFEC_LDPC_QC_TABLE_ADDR_BASE (0x20000)
+#define XSDFEC_LDPC_QC_TABLE_ADDR_HIGH (0x27FFC)
+
 /**
  * enum xsdfec_code - Code Type.
  * @XSDFEC_TURBO_CODE: Driver is configured for Turbo mode.
@@ -125,6 +133,56 @@ struct xsdfec_turbo {
 };

 /**
+ * struct xsdfec_ldpc_params - User data for LDPC codes.
+ * @n: Number of code word bits
+ * @k: Number of information bits
+ * @psize: Size of sub-matrix
+ * @nlayers: Number of layers in code
+ * @nqc: Quasi Cyclic Number
+ * @nmqc: Number of M-sized QC operations in parity check matrix
+ * @nm: Number of M-size vectors in N
+ * @norm_type: Normalization required or not
+ * @no_packing: Determines if multiple QC ops should be performed
+ * @special_qc: Sub-Matrix property for Circulant weight > 0
+ * @no_final_parity: Decide if final parity check needs to be performed
+ * @max_schedule: Experimental code word scheduling limit
+ * @sc_off: SC offset
+ * @la_off: LA offset
+ * @qc_off: QC offset
+ * @sc_table: SC Table
+ * @la_table: LA Table
+ * @qc_table: QC Table
+ * @code_id: LDPC Code
+ *
+ * This structure describes the LDPC code that is passed to the driver by =
the
+ * application.
+ */
+struct xsdfec_ldpc_params {
+       u32 n;
+       u32 k;
+       u32 psize;
+       u32 nlayers;
+       u32 nqc;
+       u32 nmqc;
+       u32 nm;
+       u32 norm_type;
+       u32 no_packing;
+       u32 special_qc;
+       u32 no_final_parity;
+       u32 max_schedule;
+       u32 sc_off;
+       u32 la_off;
+       u32 qc_off;
+       u32 sc_table[XSDFEC_LDPC_SC_TABLE_ADDR_HIGH -
+                    XSDFEC_LDPC_SC_TABLE_ADDR_BASE];
+       u32 la_table[XSDFEC_LDPC_LA_TABLE_ADDR_HIGH -
+                    XSDFEC_LDPC_LA_TABLE_ADDR_BASE];
+       u32 qc_table[XSDFEC_LDPC_QC_TABLE_ADDR_HIGH -
+                    XSDFEC_LDPC_QC_TABLE_ADDR_BASE];
+       u16 code_id;
+};
+
+/**
  * struct xsdfec_status - Status of SD-FEC core.
  * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
  *          SD-FEC's in the FPGA and is related to the driver instance
@@ -176,6 +234,41 @@ struct xsdfec_config {
        struct xsdfec_irq irq;
 };

+/**
+ * struct xsdfec_ldpc_param_table_sizes - Used to store sizes of SD-FEC ta=
ble
+ *                                       entries for an individual LPDC co=
de
+ *                                       parameter.
+ * @sc_size: Size of SC table used
+ * @la_size: Size of LA table used
+ * @qc_size: Size of QC table used
+ */
+struct xsdfec_ldpc_param_table_sizes {
+       u32 sc_size;
+       u32 la_size;
+       u32 qc_size;
+};
+
+/**
+ * xsdfec_calculate_shared_ldpc_table_entry_size - Calculates shared code
+ * table sizes.
+ * @ldpc: Pointer to the LPDC Code Parameters
+ * @table_sizes: Pointer to structure containing the calculated table size=
s
+ *
+ * Calculates the size of shared LDPC code tables used for a specified LPD=
C code
+ * parameters.
+ */
+inline void
+xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *l=
dpc,
+       struct xsdfec_ldpc_param_table_sizes *table_sizes)
+{
+       /* Calculate the sc_size in 32 bit words */
+       table_sizes->sc_size =3D (ldpc->nlayers + 3) >> 2;
+       /* Calculate the la_size in 256 bit words */
+       table_sizes->la_size =3D ((ldpc->nlayers << 2) + 15) >> 4;
+       /* Calculate the qc_size in 256 bit words */
+       table_sizes->qc_size =3D ((ldpc->nqc << 2) + 15) >> 4;
+}
+
 /*
  * XSDFEC IOCTL List
  */
@@ -196,6 +289,27 @@ struct xsdfec_config {
  */
 #define XSDFEC_SET_TURBO _IOW(XSDFEC_MAGIC, 4, struct xsdfec_turbo *)
 /**
+ * DOC: XSDFEC_ADD_LDPC_CODE_PARAMS
+ * @Parameters
+ *
+ * @struct xsdfec_ldpc_params *
+ *     Pointer to the &struct xsdfec_ldpc_params that contains the LDPC co=
de
+ *     parameters to be added to the SD-FEC Block
+ *
+ * @Description
+ * ioctl to add an LDPC code to the SD-FEC LDPC codes
+ *
+ * This can only be used when:
+ *
+ * - Driver is in the XSDFEC_STOPPED state
+ *
+ * - SD-FEC core is configured as LPDC
+ *
+ * - SD-FEC Code Write Protection is disabled
+ */
+#define XSDFEC_ADD_LDPC_CODE_PARAMS                                       =
     \
+       _IOW(XSDFEC_MAGIC, 5, struct xsdfec_ldpc_params *)
+/**
  * DOC: XSDFEC_GET_TURBO
  * @Parameters
  *
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
