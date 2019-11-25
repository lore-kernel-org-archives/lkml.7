Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBBAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E65020740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbfKYNUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:20:08 -0500
Received: from mail-eopbgr820082.outbound.protection.outlook.com ([40.107.82.82]:38909
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKYNUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:20:08 -0500
Received: from DM6PR02CA0058.namprd02.prod.outlook.com (2603:10b6:5:177::35)
 by CY4PR0201MB3587.namprd02.prod.outlook.com (2603:10b6:910:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21; Mon, 25 Nov
 2019 13:20:06 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by DM6PR02CA0058.outlook.office365.com
 (2603:10b6:5:177::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Mon, 25 Nov 2019 13:20:05 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:20:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDN-0008Di-72; Mon, 25 Nov 2019 05:15:41 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDH-0002Wy-Qe; Mon, 25 Nov 2019 05:15:35 -0800
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPDFZsI002575;
        Mon, 25 Nov 2019 05:15:35 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDG-0002Wb-A7; Mon, 25 Nov 2019 05:15:34 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 1/3] serial: xilinx_uartps: Let get_mctrl return status
Date:   Mon, 25 Nov 2019 18:45:29 +0530
Message-Id: <1574687731-21563-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--1.851-7.0-31-1
X-imss-scan-details: No--1.851-7.0-31-1;No--1.851-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191616058011282;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(305945005)(50226002)(82202003)(26005)(70206006)(498600001)(107886003)(81156014)(426003)(6916009)(55446002)(336012)(2906002)(9686003)(2361001)(50466002)(316002)(2616005)(54906003)(76482006)(9786002)(4326008)(48376002)(86362001)(8936002)(73392003)(16586007)(356004)(6666004)(5660300002)(61266001)(51416003)(70586007)(47776003)(81166006)(2351001)(14444005)(36756003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR0201MB3587;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb5c979-1bcc-4bf3-da0f-08d771aa2fdb
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3587:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3587B3A44C28CA1F8C106230874A0@CY4PR0201MB3587.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /PpI7T/s7KEuxIzhgtH/rMxfwCOFCpjmIcqqsC1aXm5eeeqOItfbfdABfGVUM/i5zQPybvww0jNmDx/EEvha6uc/vBXO7HtvR0l3XlUhQ0KQZD66JLh1nB6D5/SvsHDhJqA254lxumx9RVenGVnzVJI8BF4dI7PQ4psp/HmA0o/8h/IkPgK/D2tLJlNtY3aSwiJTKgPBkejA1mYPM5eXA6++6cOc44LFFiV6t0r10PC/mf+vUjTBwHR6yYLvJPfuY9zq4RuZgaTYMnwFS8idqh8+Lz3AU1+0Z1DbgFpfortPEYA8cfSYIEHaJnP5MmA1qQ0/H4k9sN2QYMIeertxV5O3Ai532/tCg2H4hDFd+NoU5K38HSA+i7qaynQHaNkFvgX9tKOMAq5P8otPV1lmrdZ9upsqgJ69R1rL9H33Yt3nAjBq5DLSNZ/nKfD96FFy
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:20:05.5799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb5c979-1bcc-4bf3-da0f-08d771aa2fdb
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3587
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Brock <m.brock@vanmierlo.com>

Some of the applications like microcom do not work if
modem is disabled. To fix them we always return
TIOCM_CTS | TIOCM_DSR | TIOCM_CAR instead of 0 when
using cts_override. Make get_mctrl return actual status
when not using cts_override.

Signed-off-by: Maarten Brock <m.brock@vanmierlo.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 4e55bc3..acdb4fa5 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -158,6 +158,16 @@ MODULE_PARM_DESC(rx_timeout, "Rx timeout, 1-255");
 #define CDNS_UART_MODEMCR_DTR	0x00000001 /* Data Terminal Ready */
 
 /*
+ * Modem Status register:
+ * The read/write Modem Status register reports the interface with the modem
+ * or data set, or a peripheral device emulating a modem.
+ */
+#define CDNS_UART_MODEMSR_DCD	BIT(7) /* Data Carrier Detect */
+#define CDNS_UART_MODEMSR_RI	BIT(6) /* Ting Indicator */
+#define CDNS_UART_MODEMSR_DSR	BIT(5) /* Data Set Ready */
+#define CDNS_UART_MODEMSR_CTS	BIT(4) /* Clear To Send */
+
+/*
  * Channel Status Register:
  * The channel status register (CSR) is provided to enable the control logic
  * to monitor the status of bits in the channel interrupt status register,
@@ -1007,12 +1017,24 @@ static void cdns_uart_config_port(struct uart_port *port, int flags)
  */
 static unsigned int cdns_uart_get_mctrl(struct uart_port *port)
 {
+	u32 val;
+	unsigned int mctrl = 0;
 	struct cdns_uart *cdns_uart_data = port->private_data;
 
 	if (cdns_uart_data->cts_override)
-		return 0;
-
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+		return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+
+	val = readl(port->membase + CDNS_UART_MODEMSR);
+	if (val & CDNS_UART_MODEMSR_CTS)
+		mctrl |= TIOCM_CTS;
+	if (val & CDNS_UART_MODEMSR_DSR)
+		mctrl |= TIOCM_DSR;
+	if (val & CDNS_UART_MODEMSR_RI)
+		mctrl |= TIOCM_RNG;
+	if (val & CDNS_UART_MODEMSR_DCD)
+		mctrl |= TIOCM_CAR;
+
+	return mctrl;
 }
 
 static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
-- 
2.1.1

