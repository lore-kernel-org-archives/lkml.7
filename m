Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C555C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B7720740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfKYNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:20:15 -0500
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:60059
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKYNUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:20:14 -0500
Received: from BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15)
 by BYAPR02MB5143.namprd02.prod.outlook.com (2603:10b6:a03:64::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 13:20:10 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by BL0PR02CA0038.outlook.office365.com
 (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 25 Nov 2019 13:20:10 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:20:10 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDS-0008Dp-QO; Mon, 25 Nov 2019 05:15:46 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDN-0002XV-Db; Mon, 25 Nov 2019 05:15:41 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPDFeng002616;
        Mon, 25 Nov 2019 05:15:41 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDM-0002Wb-5q; Mon, 25 Nov 2019 05:15:40 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 3/3] serial: xilinx_uartps: set_mctrl sets RTS and DTR
Date:   Mon, 25 Nov 2019 18:45:31 +0530
Message-Id: <1574687731-21563-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574687731-21563-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574687731-21563-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.124-7.0-31-1
X-imss-scan-details: No--5.124-7.0-31-1;No--5.124-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191616104858297;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(9686003)(86362001)(4326008)(82202003)(51416003)(305945005)(2351001)(6666004)(356004)(54906003)(316002)(36756003)(2906002)(55446002)(2361001)(48376002)(76482006)(50466002)(446003)(76176011)(498600001)(16586007)(9786002)(107886003)(26005)(5660300002)(70586007)(336012)(426003)(73392003)(11346002)(2616005)(70206006)(4744005)(50226002)(81166006)(81156014)(47776003)(8676002)(61266001)(8936002)(6916009)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5143;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4a80fb2-092f-4a1a-7947-08d771aa32a3
X-MS-TrafficTypeDiagnostic: BYAPR02MB5143:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5143D5FC005AB3943D50F5C1874A0@BYAPR02MB5143.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eERPhYBpqwKkmGa1uGhdR17PxKXUv7K9ln4PCNEQNK4tcFaUL/ZyzJfdwZyl?=
 =?us-ascii?Q?dAzZMPAjRS2xpNR/Zw4+a5OYxsV9zVI8YGjgTNZt89lfZoHN+Y7+kjv5unxr?=
 =?us-ascii?Q?8WFAzqREDEUpwKQosRJ0jjGp2Bt2Ze3Zk2slvoVwHbI4A3eOw4LCzAtzHTOC?=
 =?us-ascii?Q?1Cf7sMhYETTHKzDZwUCEa8RrRRAEf7dGhYwebPj45zULpzEUaFQdXUUPmDlL?=
 =?us-ascii?Q?qKmx/CXmmzRFxhG/EWtXWtxfa3mh3pHv0/z4PQYpEUYaUrBQ0KV8jc6ON3aj?=
 =?us-ascii?Q?VtE2HEaggeI4Hui3Ibts3XdKoOHdfjBnbEE9GIbj4X1wLaF50Yb8RZHyYvk9?=
 =?us-ascii?Q?OiuWn4Skvgct0iX11qwNS3UgrF8moGeOXG9OY3qtRD3JdSawfZBedIYBDQk0?=
 =?us-ascii?Q?bAW1/wejfELJ97wSHvSPOIHxrC604p0Bw0Q9bNo0w8fKZtBeIqc64fQpo7HQ?=
 =?us-ascii?Q?J9XbHwXPYLWwMp8o4n2peqLkQ/ioVLwizEGgk+MhlqPJOXHfrb9BsI2glKf8?=
 =?us-ascii?Q?Nc9XOL/Db5HL1+x9BCwSrmL/NnBvvnvxA10lDeFtqHCnpcYhfIeghEBSDb1g?=
 =?us-ascii?Q?W2uQfcfXPTCVpKkxNxo8atWiLvlYRQNU4Xy2erIxoHAjWX8QTGaX8XOWvzBR?=
 =?us-ascii?Q?K9w2iPCkK9DPkqcmUJ26BXhnplCXNZTouswp3TfhFZSOgjLvPnid+SDucSSq?=
 =?us-ascii?Q?r1RHPFpfX1iTNJbm8L/XPQvFFBz1ZsPQY3/M1v2QVirSFj08P7pO+Zw8XdAP?=
 =?us-ascii?Q?k4qtOUPUbI95xS7XLU1F1dsngW1SNqc8l9zMuR5hw06G9Oks3ZvXK0BMIapm?=
 =?us-ascii?Q?aRF6qrmFkFWWymCfen6+4FSzvJonXv+CwdHZC3BlbBnPn+f3VNUBxXdscmFB?=
 =?us-ascii?Q?FCix0CfHs1MKBA1Q+TWSY2rXqdpZfXLUJ50+itNrXnl+4cNOyygaK5OH7ht3?=
 =?us-ascii?Q?AkneXi8S1s33hwl5jyAPDsnS91Gy1F8In+Y4zJIz1BFV+sF8114HVVA+s8M3?=
 =?us-ascii?Q?Uep+eW5bshD/hjgm8Q5et6iJ9VGrqavbAZx6SHUFUGDkX6PfCVXaN5/0xEyr?=
 =?us-ascii?Q?nYt9KKDrIa0kjWzKSzIeq5GM4yIqV421F0WaNZF1piDWhMrsyskO3jgW61xm?=
 =?us-ascii?Q?tv3O2z4cctRBPAJHWBuT/ikz6IAjemSdPsZhpuMyzy7x+oTmpcZFUhageRKO?=
 =?us-ascii?Q?ryBEnhEc3qAA4wyR1mXd6DfOOGRnY8U0WnjlGWpK4bPz0tZa+yig+MuPmjYq?=
 =?us-ascii?Q?51AvU7MYde8sn6oDmOKGco+YX6vaqTNiMeGHx6/azMzkg27cTHbWAnwm9U7r?=
 =?us-ascii?Q?UDh3vQp2j+X+K+I03rgZaidudcZgaNz8b7xFl/dLc9TpLQJ9iYE57ZpBB3gi?=
 =?us-ascii?Q?wiTVzrtnpYjaRnfj6TW7l6mJeOXnD4kw3ac1wKiSn7yrLP+qKYTa6ImfBe5j?=
 =?us-ascii?Q?F+GehXtzhpM5lPdLJoMDQDiagFUyd7usu6AE7P0xS8E1Ce1AAqdAcnJQH7z3?=
 =?us-ascii?Q?Rm01edM06CaT+GTPSTCywcDq2s/Az51Qb7XATq7TCE5xAOF+sF6eRuM8psNk?=
 =?us-ascii?Q?DSrhLjpVBswSS4fkejBXjnciOMbsyb7pMEBdw0zh?=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:20:10.2426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a80fb2-092f-4a1a-7947-08d771aa32a3
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Brock <m.brock@vanmierlo.com>

set_mctrl now sets RTS and DTR.

Signed-off-by: Maarten Brock <m.brock@vanmierlo.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index e82f8db..b4fd550 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1059,6 +1059,10 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
+	if (mctrl & TIOCM_RTS)
+		val |= CDNS_UART_MODEMCR_RTS;
+	if (mctrl & TIOCM_DTR)
+		val |= CDNS_UART_MODEMCR_DTR;
 	if (mctrl & TIOCM_LOOP)
 		mode_reg |= CDNS_UART_MR_CHMODE_L_LOOP;
 	else
-- 
2.1.1

