Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA87C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14E82082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfKYNDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:03:02 -0500
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:30624
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727299AbfKYNC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:02:59 -0500
Received: from CH2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:610:4e::28)
 by DM6PR02MB5996.namprd02.prod.outlook.com (2603:10b6:5:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.16; Mon, 25 Nov
 2019 13:02:58 +0000
Received: from BL2NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by CH2PR02CA0018.outlook.office365.com
 (2603:10b6:610:4e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21 via Frontend
 Transport; Mon, 25 Nov 2019 13:02:58 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT013.mail.protection.outlook.com (10.152.77.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:02:57 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE13-0008B4-9I; Mon, 25 Nov 2019 05:02:57 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0y-0008W7-7t; Mon, 25 Nov 2019 05:02:52 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0x-0008Ox-HB; Mon, 25 Nov 2019 05:02:51 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/3] serial: xilinx_uartps: set_mctrl sets RTS and DTR
Date:   Mon, 25 Nov 2019 18:32:41 +0530
Message-Id: <1574686961-9588-3-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574686961-9588-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574686961-9588-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.124-7.0-31-1
X-imss-scan-details: No--5.124-7.0-31-1;No--5.124-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191605781557826;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(199004)(189003)(2361001)(2351001)(26005)(50466002)(48376002)(9686003)(36756003)(81156014)(51416003)(82202003)(4744005)(5660300002)(47776003)(61266001)(305945005)(11346002)(76176011)(6916009)(446003)(70586007)(2616005)(70206006)(336012)(86362001)(356004)(6666004)(54906003)(55446002)(2906002)(73392003)(426003)(316002)(76482006)(4326008)(9786002)(8676002)(107886003)(81166006)(8936002)(50226002)(498600001)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5996;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a44c4a-689e-4b45-8c1d-08d771a7cb54
X-MS-TrafficTypeDiagnostic: DM6PR02MB5996:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5996108F33EDB9764AFAF8B3874A0@DM6PR02MB5996.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:88;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v6PIuu3KdcmbR4L8NXrB6dHtQBEVS8/3QWbATUKXGIUFCqdmW/eMcTAx7ZFq4FKhQ2x3kLEJvVZ/w1/VHEXU0fyazUG2f6aH56EjskqAaYoWe4ZBySrLD2hZdgSi4eHcPpTBZob42/x6McgyxCPqMQNrcXCb79zdiEx0SH78thFMxRcsU5lS4UiSqVR5nTux7PSaUBRN6nYiRYvuLJiCLY/Si9CJhhuDj8YECTwiDGKJ3oQmNud8uVCCb9ekobLuz9tzXTgwTdS2WktjDG/nD6pjz5POkEFtSu3/2AhUKImnySOMCTe4L9dH96Et8Q12MZvf6r2e7RZaWG9m90VaMS8m/jqFxjivHel72s9J/oD5ETcdMgDocu/WMw9RgTRN9R+3+ZUnravEX0MmYRFvZ82iZEBaXccxBP0yj2Kab9leHYs24kV2Ue3m3SupSpMi
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:02:57.9256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a44c4a-689e-4b45-8c1d-08d771a7cb54
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5996
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
index 44dabd4..019302e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1069,6 +1069,10 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
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

