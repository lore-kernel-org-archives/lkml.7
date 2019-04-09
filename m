Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0423B20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="AQr3OP7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDIKIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:08:05 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:37348
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726854AbfDIKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv8NujMbyBzQoXxAVjW+rF92cj09GxKM+aKiDVxeGCk=;
 b=AQr3OP7Q9PXrwsi9D5KLrqa1BXNZo30S5XCFHgIf/FxkbUNE14I7xkl+sfmSHXkziRRFwCmNE8f+oDh5Kk7jGjmPbC2GdXmr1katpr5AWZLcFduizmRk7XJ6g3yxb5H3AYCMk23MbNDB2s9WSlFH27IcS4nnjxq/BAO2ljn7OY4=
Received: from BYAPR02CA0009.namprd02.prod.outlook.com (52.135.206.22) by
 BL0PR02MB3825.namprd02.prod.outlook.com (52.132.9.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Tue, 9 Apr 2019 10:07:16 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR02CA0009.outlook.office365.com
 (2603:10b6:a02:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1792.14 via Frontend
 Transport; Tue, 9 Apr 2019 10:07:15 +0000
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
 15.20.1771.16 via Frontend Transport; Tue, 9 Apr 2019 10:07:14 +0000
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
        id 1hDnei-0007SJ-Li; Tue, 09 Apr 2019 11:07:04 +0100
From:   Dragan Cvetic <dragan.cvetic@xilinx.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>
Subject: [PATCH V2 07/12] misc: xilinx_sdfec: Add ability to configure LDPC
Date:   Tue, 9 Apr 2019 11:06:49 +0100
Message-ID: <1554804414-206099-8-git-send-email-dragan.cvetic@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
References: <1554804414-206099-1-git-send-email-dragan.cvetic@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.80.198;IPV:CAL;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(376002)(136003)(2980300002)(199004)(189003)(7696005)(36906005)(76176011)(71366001)(2201001)(7636002)(126002)(4326008)(486006)(106466001)(51416003)(305945005)(106002)(30864003)(26005)(9786002)(8936002)(60926002)(50226002)(54906003)(26826003)(50466002)(246002)(446003)(47776003)(93146003)(186003)(110136005)(48376002)(76130400001)(316002)(6666004)(2906002)(356004)(478600001)(2616005)(5660300002)(476003)(956004)(36756003)(11346002)(8676002)(16586007)(107886003)(28376004)(336012)(44832011)(426003)(14444005)(102446001)(461764006);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3825;H:xir-pvapexch01.xlnx.xilinx.com;FPR:;SPF:Pass;LANG:en;PTR:unknown-80-198.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f0ff941-aa84-4878-1f13-08d6bcd32438
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4709054)(2017052603328);SRVR:BL0PR02MB3825;
X-MS-TrafficTypeDiagnostic: BL0PR02MB3825:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB38255FB622ABE488358E3F1ACB2D0@BL0PR02MB3825.namprd02.prod.outlook.com>
X-Forefront-PRVS: 000227DA0C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xKhN+7KimbPH0BOQoV9b9QDD75DkFX+Kt9Ce74JBLMqesNGQ0yFjF9nfbrXLFXmlXuylhS0WgU8HwghBxvRLucFf/U9XXsA14ws3QAFsuHeB1uuaOCVEHnlYgyflvits+grT9+eLd+9HG7axB86RchZdWxTBqv3UBiktPIXPfXbGK7BQd6hX3szitJLfN/sDd8+pLnzxLPY4QmBL3C6jBpMWZDVceAT8i63OfSP2Al4Ow1xVCn6k81hGql9DmUm6q7c7CMnS1MJAzunYXyRhrKFoV+IgTHjouNuZV1PKqt9Gc2+dAwlLCvEi2n7jpsyo/9Fh6MVPpbNVe3sKzo8YCVbCH9L5vnX698yKlFTPLJ/kuT1R+Q+fN0nb1zf4kU1o+YD592tAnB5kzcRL6oQ4C3EWgsy9Lcv9pre0Qegfi1o=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2019 10:07:14.9401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0ff941-aa84-4878-1f13-08d6bcd32438
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.80.198];Helo=[xir-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3825
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the capability to configure LDPC mode via the ioctl
XSDFEC_ADD_LDPC_CODE_PARAMS.

Tested-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
Signed-off-by: Derek Kiernan <derek.kiernan@xilinx.com>
Signed-off-by: Dragan Cvetic <dragan.cvetic@xilinx.com>
---
 drivers/misc/xilinx_sdfec.c      | 333 +++++++++++++++++++++++++++++++++++++++
 include/uapi/misc/xilinx_sdfec.h | 119 ++++++++++++++
 2 files changed, 452 insertions(+)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 19b5f96..18e7ae2 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -26,6 +26,8 @@
 #include <linux/spinlock.h>
 #include <linux/clk.h>
 #include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
 
 #include <uapi/misc/xilinx_sdfec.h>
 
@@ -122,6 +124,57 @@ static dev_t xsdfec_devt;
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
+/* The maximum number of pinned pages */
+#define MAX_NUM_PAGES ((XSDFEC_QC_TABLE_DEPTH / PAGE_SIZE) + 1)
+
 /**
  * struct xsdfec_clks - For managing SD-FEC clocks
  * @core_clk: Main processing clock for core
@@ -318,6 +371,283 @@ static int xsdfec_get_turbo(struct xsdfec_dev *xsdfec, void __user *arg)
 	return err;
 }
 
+static int xsdfec_reg0_write(struct xsdfec_dev *xsdfec, u32 n, u32 k, u32 psize,
+			     u32 offset)
+{
+	u32 wdata;
+
+	if (n < XSDFEC_REG0_N_MIN || n > XSDFEC_REG0_N_MAX ||
+	    (n > XSDFEC_REG0_N_MUL_P * psize) || n <= k || ((n % psize) != 0)) {
+		dev_err(xsdfec->dev, "N value is not in range");
+		return -EINVAL;
+	}
+	n <<= XSDFEC_REG0_N_LSB;
+
+	if (k < XSDFEC_REG0_K_MIN || k > XSDFEC_REG0_K_MAX ||
+	    (k > XSDFEC_REG0_K_MUL_P * psize) || ((k % psize) != 0)) {
+		dev_err(xsdfec->dev, "K value is not in range");
+		return -EINVAL;
+	}
+	k = k << XSDFEC_REG0_K_LSB;
+	wdata = k | n;
+
+	if (XSDFEC_LDPC_CODE_REG0_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUMP) >
+	    XSDFEC_LDPC_CODE_REG0_ADDR_HIGH) {
+		dev_err(xsdfec->dev, "Writing outside of LDPC reg0 space 0x%x",
+			XSDFEC_LDPC_CODE_REG0_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP));
+		return -EINVAL;
+	}
+	xsdfec_regwrite(xsdfec,
+			XSDFEC_LDPC_CODE_REG0_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP),
+			wdata);
+	return 0;
+}
+
+static int xsdfec_reg1_write(struct xsdfec_dev *xsdfec, u32 psize,
+			     u32 no_packing, u32 nm, u32 offset)
+{
+	u32 wdata;
+
+	if (psize < XSDFEC_REG1_PSIZE_MIN || psize > XSDFEC_REG1_PSIZE_MAX) {
+		dev_err(xsdfec->dev, "Psize is not in range");
+		return -EINVAL;
+	}
+
+	if (no_packing != 0 && no_packing != 1)
+		dev_err(xsdfec->dev, "No-packing bit register invalid");
+	no_packing = ((no_packing << XSDFEC_REG1_NO_PACKING_LSB) &
+		      XSDFEC_REG1_NO_PACKING_MASK);
+
+	if (nm & ~(XSDFEC_REG1_NM_MASK >> XSDFEC_REG1_NM_LSB))
+		dev_err(xsdfec->dev, "NM is beyond 10 bits");
+	nm = (nm << XSDFEC_REG1_NM_LSB) & XSDFEC_REG1_NM_MASK;
+
+	wdata = nm | no_packing | psize;
+	if (XSDFEC_LDPC_CODE_REG1_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUMP) >
+	    XSDFEC_LDPC_CODE_REG1_ADDR_HIGH) {
+		dev_err(xsdfec->dev, "Writing outside of LDPC reg1 space 0x%x",
+			XSDFEC_LDPC_CODE_REG1_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP));
+		return -EINVAL;
+	}
+	xsdfec_regwrite(xsdfec,
+			XSDFEC_LDPC_CODE_REG1_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP),
+			wdata);
+	return 0;
+}
+
+static int xsdfec_reg2_write(struct xsdfec_dev *xsdfec, u32 nlayers, u32 nmqc,
+			     u32 norm_type, u32 special_qc, u32 no_final_parity,
+			     u32 max_schedule, u32 offset)
+{
+	u32 wdata;
+
+	if (nlayers < XSDFEC_REG2_NLAYERS_MIN ||
+	    nlayers > XSDFEC_REG2_NLAYERS_MAX) {
+		dev_err(xsdfec->dev, "Nlayers is not in range");
+		return -EINVAL;
+	}
+
+	if (nmqc & ~(XSDFEC_REG2_NNMQC_MASK >> XSDFEC_REG2_NMQC_LSB))
+		dev_err(xsdfec->dev, "NMQC exceeds 11 bits");
+	nmqc = (nmqc << XSDFEC_REG2_NMQC_LSB) & XSDFEC_REG2_NNMQC_MASK;
+
+	if (norm_type > 1)
+		dev_err(xsdfec->dev, "Norm type is invalid");
+	norm_type = ((norm_type << XSDFEC_REG2_NORM_TYPE_LSB) &
+		     XSDFEC_REG2_NORM_TYPE_MASK);
+	if (special_qc > 1)
+		dev_err(xsdfec->dev, "Special QC in invalid");
+	special_qc = ((special_qc << XSDFEC_REG2_SPEICAL_QC_LSB) &
+		      XSDFEC_REG2_SPECIAL_QC_MASK);
+
+	if (no_final_parity > 1)
+		dev_err(xsdfec->dev, "No final parity check invalid");
+	no_final_parity =
+		((no_final_parity << XSDFEC_REG2_NO_FINAL_PARITY_LSB) &
+		 XSDFEC_REG2_NO_FINAL_PARITY_MASK);
+	if (max_schedule &
+	    ~(XSDFEC_REG2_MAX_SCHEDULE_MASK >> XSDFEC_REG2_MAX_SCHEDULE_LSB))
+		dev_err(xsdfec->dev, "Max Schdule exceeds 2 bits");
+	max_schedule = ((max_schedule << XSDFEC_REG2_MAX_SCHEDULE_LSB) &
+			XSDFEC_REG2_MAX_SCHEDULE_MASK);
+
+	wdata = (max_schedule | no_final_parity | special_qc | norm_type |
+		 nmqc | nlayers);
+
+	if (XSDFEC_LDPC_CODE_REG2_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUMP) >
+	    XSDFEC_LDPC_CODE_REG2_ADDR_HIGH) {
+		dev_err(xsdfec->dev, "Writing outside of LDPC reg2 space 0x%x",
+			XSDFEC_LDPC_CODE_REG2_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP));
+		return -EINVAL;
+	}
+	xsdfec_regwrite(xsdfec,
+			XSDFEC_LDPC_CODE_REG2_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP),
+			wdata);
+	return 0;
+}
+
+static int xsdfec_reg3_write(struct xsdfec_dev *xsdfec, u8 sc_off, u8 la_off,
+			     u16 qc_off, u32 offset)
+{
+	u32 wdata;
+
+	wdata = ((qc_off << XSDFEC_REG3_QC_OFF_LSB) |
+		 (la_off << XSDFEC_REG3_LA_OFF_LSB) | sc_off);
+	if (XSDFEC_LDPC_CODE_REG3_ADDR_BASE + (offset * XSDFEC_LDPC_REG_JUMP) >
+	    XSDFEC_LDPC_CODE_REG3_ADDR_HIGH) {
+		dev_err(xsdfec->dev, "Writing outside of LDPC reg3 space 0x%x",
+			XSDFEC_LDPC_CODE_REG3_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP));
+		return -EINVAL;
+	}
+	xsdfec_regwrite(xsdfec,
+			XSDFEC_LDPC_CODE_REG3_ADDR_BASE +
+				(offset * XSDFEC_LDPC_REG_JUMP),
+			wdata);
+	return 0;
+}
+
+static int xsdfec_table_write(struct xsdfec_dev *xsdfec, u32 offset,
+			      u32 *src_ptr, u32 len, const u32 base_addr,
+			      const u32 depth)
+{
+	u32 reg = 0;
+	u32 res;
+	u32 n, i;
+	u32 *addr = NULL;
+	struct page *page[MAX_NUM_PAGES];
+
+	/*
+	 * Writes that go beyond the length of
+	 * Shared Scale(SC) table should fail
+	 */
+	if ((XSDFEC_REG_WIDTH_JUMP * (offset + len)) > depth) {
+		dev_err(xsdfec->dev, "Write exceeds SC table length");
+		return -EINVAL;
+	}
+
+	n = len / PAGE_SIZE;
+	if (len % PAGE_SIZE)
+		n += 1;
+
+	res = get_user_pages_fast((unsigned long)src_ptr, n, 0, page);
+	if (res < n) {
+		for (i = 0; i < res; i++)
+			put_page(page[i]);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < n; i++) {
+		addr = kmap(page[i]);
+		do {
+			xsdfec_regwrite(xsdfec,
+					base_addr + ((offset + reg) *
+						     XSDFEC_REG_WIDTH_JUMP),
+					addr[reg]);
+			reg++;
+		} while ((reg < len) && (reg % PAGE_SIZE));
+		put_page(page[i]);
+	}
+	return reg;
+}
+
+static int xsdfec_add_ldpc(struct xsdfec_dev *xsdfec, void __user *arg)
+{
+	struct xsdfec_ldpc_params *ldpc;
+	int ret, n;
+
+	ldpc = kzalloc(sizeof(*ldpc), GFP_KERNEL);
+	if (!ldpc)
+		return -ENOMEM;
+
+	ret = copy_from_user(ldpc, arg, sizeof(*ldpc));
+	if (ret)
+		goto err_out;
+
+	if (xsdfec->config.code == XSDFEC_TURBO_CODE) {
+		dev_err(xsdfec->dev,
+			"%s: Unable to write LDPC to SDFEC%d check DT",
+			__func__, xsdfec->config.fec_id);
+		ret = -EIO;
+		goto err_out;
+	}
+
+	/* Verify Device has not started */
+	if (xsdfec->state == XSDFEC_STARTED) {
+		dev_err(xsdfec->dev,
+			"%s attempting to write LDPC code while started for SDFEC%d",
+			__func__, xsdfec->config.fec_id);
+		ret = -EIO;
+		goto err_out;
+	}
+
+	if (xsdfec->config.code_wr_protect) {
+		dev_err(xsdfec->dev,
+			"%s writing LDPC code while Code Write Protection enabled for SDFEC%d",
+			__func__, xsdfec->config.fec_id);
+		ret = -EIO;
+		goto err_out;
+	}
+
+	/* Write Reg 0 */
+	ret = xsdfec_reg0_write(xsdfec, ldpc->n, ldpc->k, ldpc->psize,
+				ldpc->code_id);
+	if (ret)
+		goto err_out;
+
+	/* Write Reg 1 */
+	ret = xsdfec_reg1_write(xsdfec, ldpc->psize, ldpc->no_packing, ldpc->nm,
+				ldpc->code_id);
+	if (ret)
+		goto err_out;
+
+	/* Write Reg 2 */
+	ret = xsdfec_reg2_write(xsdfec, ldpc->nlayers, ldpc->nmqc,
+				ldpc->norm_type, ldpc->special_qc,
+				ldpc->no_final_parity, ldpc->max_schedule,
+				ldpc->code_id);
+	if (ret)
+		goto err_out;
+
+	/* Write Reg 3 */
+	ret = xsdfec_reg3_write(xsdfec, ldpc->sc_off, ldpc->la_off,
+				ldpc->qc_off, ldpc->code_id);
+	if (ret)
+		goto err_out;
+
+	/* Write Shared Codes */
+	n = ldpc->nlayers / 4;
+	if (ldpc->nlayers % 4)
+		n++;
+
+	ret = xsdfec_table_write(xsdfec, ldpc->sc_off, ldpc->sc_table, n,
+				 XSDFEC_LDPC_SC_TABLE_ADDR_BASE,
+				 XSDFEC_SC_TABLE_DEPTH);
+	if (ret < 0)
+		goto err_out;
+
+	ret = xsdfec_table_write(xsdfec, 4 * ldpc->la_off, ldpc->la_table,
+				 ldpc->nlayers, XSDFEC_LDPC_LA_TABLE_ADDR_BASE,
+				 XSDFEC_LA_TABLE_DEPTH);
+	if (ret < 0)
+		goto err_out;
+
+	ret = xsdfec_table_write(xsdfec, 4 * ldpc->qc_off, ldpc->qc_table,
+				 ldpc->nqc, XSDFEC_LDPC_QC_TABLE_ADDR_BASE,
+				 XSDFEC_QC_TABLE_DEPTH);
+	if (ret > 0)
+		ret = 0;
+err_out:
+	kfree(ldpc);
+	return ret;
+}
+
 static u32
 xsdfec_translate_axis_width_cfg_val(enum xsdfec_axis_width axis_width_cfg)
 {
@@ -417,6 +747,9 @@ static long xsdfec_dev_ioctl(struct file *fptr, unsigned int cmd,
 	case XSDFEC_GET_TURBO:
 		rval = xsdfec_get_turbo(xsdfec, arg);
 		break;
+	case XSDFEC_ADD_LDPC_CODE_PARAMS:
+		rval = xsdfec_add_ldpc(xsdfec, arg);
+		break;
 	default:
 		/* Should not get here */
 		dev_err(xsdfec->dev, "Undefined SDFEC IOCTL");
diff --git a/include/uapi/misc/xilinx_sdfec.h b/include/uapi/misc/xilinx_sdfec.h
index b46c90e..53a3e3b 100644
--- a/include/uapi/misc/xilinx_sdfec.h
+++ b/include/uapi/misc/xilinx_sdfec.h
@@ -11,6 +11,22 @@
 #ifndef __XILINX_SDFEC_H__
 #define __XILINX_SDFEC_H__
 
+/* Shared LDPC Tables */
+#define XSDFEC_LDPC_SC_TABLE_ADDR_BASE (0x10000)
+#define XSDFEC_LDPC_SC_TABLE_ADDR_HIGH (0x10400)
+#define XSDFEC_LDPC_LA_TABLE_ADDR_BASE (0x18000)
+#define XSDFEC_LDPC_LA_TABLE_ADDR_HIGH (0x19000)
+#define XSDFEC_LDPC_QC_TABLE_ADDR_BASE (0x20000)
+#define XSDFEC_LDPC_QC_TABLE_ADDR_HIGH (0x28000)
+
+/* LDPC tables depth */
+#define XSDFEC_SC_TABLE_DEPTH                                                  \
+	(XSDFEC_LDPC_SC_TABLE_ADDR_HIGH - XSDFEC_LDPC_SC_TABLE_ADDR_BASE)
+#define XSDFEC_LA_TABLE_DEPTH                                                  \
+	(XSDFEC_LDPC_LA_TABLE_ADDR_HIGH - XSDFEC_LDPC_LA_TABLE_ADDR_BASE)
+#define XSDFEC_QC_TABLE_DEPTH                                                  \
+	(XSDFEC_LDPC_QC_TABLE_ADDR_HIGH - XSDFEC_LDPC_QC_TABLE_ADDR_BASE)
+
 /**
  * enum xsdfec_code - Code Type.
  * @XSDFEC_TURBO_CODE: Driver is configured for Turbo mode.
@@ -125,6 +141,53 @@ struct xsdfec_turbo {
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
+ * @sc_table: Pointer to SC Table which must be page aligned
+ * @la_table: Pointer to LA Table which must be page aligned
+ * @qc_table: Pointer to QC Table which must be page aligned
+ * @code_id: LDPC Code
+ *
+ * This structure describes the LDPC code that is passed to the driver by the
+ * application.
+ */
+struct xsdfec_ldpc_params {
+	u32 n;
+	u32 k;
+	u32 psize;
+	u32 nlayers;
+	u32 nqc;
+	u32 nmqc;
+	u32 nm;
+	u32 norm_type;
+	u32 no_packing;
+	u32 special_qc;
+	u32 no_final_parity;
+	u32 max_schedule;
+	u32 sc_off;
+	u32 la_off;
+	u32 qc_off;
+	u32 *sc_table;
+	u32 *la_table;
+	u32 *qc_table;
+	u16 code_id;
+};
+
+/**
  * struct xsdfec_status - Status of SD-FEC core.
  * @fec_id: ID of SD-FEC instance. ID is limited to the number of active
  *          SD-FEC's in the FPGA and is related to the driver instance
@@ -176,6 +239,41 @@ struct xsdfec_config {
 	struct xsdfec_irq irq;
 };
 
+/**
+ * struct xsdfec_ldpc_param_table_sizes - Used to store sizes of SD-FEC table
+ *					  entries for an individual LPDC code
+ *					  parameter.
+ * @sc_size: Size of SC table used
+ * @la_size: Size of LA table used
+ * @qc_size: Size of QC table used
+ */
+struct xsdfec_ldpc_param_table_sizes {
+	u32 sc_size;
+	u32 la_size;
+	u32 qc_size;
+};
+
+/**
+ * xsdfec_calculate_shared_ldpc_table_entry_size - Calculates shared code
+ * table sizes.
+ * @ldpc: Pointer to the LPDC Code Parameters
+ * @table_sizes: Pointer to structure containing the calculated table sizes
+ *
+ * Calculates the size of shared LDPC code tables used for a specified LPDC code
+ * parameters.
+ */
+inline void
+xsdfec_calculate_shared_ldpc_table_entry_size(struct xsdfec_ldpc_params *ldpc,
+	struct xsdfec_ldpc_param_table_sizes *table_sizes)
+{
+	/* Calculate the sc_size in 32 bit words */
+	table_sizes->sc_size = (ldpc->nlayers + 3) >> 2;
+	/* Calculate the la_size in 256 bit words */
+	table_sizes->la_size = ((ldpc->nlayers << 2) + 15) >> 4;
+	/* Calculate the qc_size in 256 bit words */
+	table_sizes->qc_size = ((ldpc->nqc << 2) + 15) >> 4;
+}
+
 /*
  * XSDFEC IOCTL List
  */
@@ -196,6 +294,27 @@ struct xsdfec_config {
  */
 #define XSDFEC_SET_TURBO _IOW(XSDFEC_MAGIC, 4, struct xsdfec_turbo)
 /**
+ * DOC: XSDFEC_ADD_LDPC_CODE_PARAMS
+ * @Parameters
+ *
+ * @struct xsdfec_ldpc_params *
+ *	Pointer to the &struct xsdfec_ldpc_params that contains the LDPC code
+ *	parameters to be added to the SD-FEC Block
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
+#define XSDFEC_ADD_LDPC_CODE_PARAMS                                            \
+	_IOW(XSDFEC_MAGIC, 5, struct xsdfec_ldpc_params)
+/**
  * DOC: XSDFEC_GET_TURBO
  * @Parameters
  *
-- 
2.7.4

