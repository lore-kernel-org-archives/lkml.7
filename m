Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA94F20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfKYNUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:20:12 -0500
Received: from mail-eopbgr730077.outbound.protection.outlook.com ([40.107.73.77]:36480
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfKYNUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:20:11 -0500
Received: from BL0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:207:3d::23)
 by SN6PR02MB4190.namprd02.prod.outlook.com (2603:10b6:805:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 13:20:08 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BL0PR02CA0046.outlook.office365.com
 (2603:10b6:207:3d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.30 via Frontend
 Transport; Mon, 25 Nov 2019 13:20:07 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:20:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDQ-0008Dj-37; Mon, 25 Nov 2019 05:15:44 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDK-0002XB-Mn; Mon, 25 Nov 2019 05:15:38 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xAPDFcUR002602;
        Mon, 25 Nov 2019 05:15:38 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZEDJ-0002Wb-At; Mon, 25 Nov 2019 05:15:37 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv2 2/3] serial: xilinx_uartps: set_termios sets flowcontrol
Date:   Mon, 25 Nov 2019 18:45:30 +0530
Message-Id: <1574687731-21563-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574687731-21563-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574687731-21563-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.830-7.0-31-1
X-imss-scan-details: No--4.830-7.0-31-1;No--4.830-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191616078997906;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39860400002)(189003)(199004)(2361001)(55446002)(82202003)(4326008)(107886003)(5660300002)(50466002)(81166006)(2616005)(11346002)(16586007)(50226002)(14444005)(8936002)(9786002)(9686003)(86362001)(76176011)(446003)(48376002)(70586007)(51416003)(36756003)(8676002)(81156014)(2906002)(76482006)(316002)(70206006)(61266001)(54906003)(6666004)(305945005)(47776003)(498600001)(336012)(26005)(6916009)(426003)(2351001)(356004)(73392003)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4190;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab55279-c0ce-446d-ee16-08d771aa311b
X-MS-TrafficTypeDiagnostic: SN6PR02MB4190:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4190C108238B5D343AD0E79A874A0@SN6PR02MB4190.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MWfnsxGp/GrnciHVQ5HJszjnZxxaGU2kSVQrKBBKvopw5UQXoHibIaHCJwRS5gF43VqNL+1vKWSH2Pf4/u77XCB7XkMUD2yRM0ctK2H6GbQWL60QJz9lJD0NLyRVaXO/SCuWGeB1MIIWKiZFyn0SnLtfX1G6GUryGQFTf1Ela3TBsae6Sv21xIUFoOuYBmoSi8eUvKc2lqHkMarhz0D96ZLr9syC35KGBN3+xb5+3mQZ8EhbulXgKLCDID+LTSocH1XufywzGHZ/I5eD3Tf9BO4pRSgF2hV7QqF5GJF9TMSlJXhoO76q5wnk6SKnZZWYYWlUbEki4tCY4yBehwCJoxYoW/X3PYjqLSJXjm1o6kYL4WQtAwyp8r1n7IBDjHyJ1q2pPYHttG5CA3XOqZXX2jEoKpy7JlbtXMxe1oNQ6nuRnS4vtV4gLIBoJJDfSHh
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:20:07.6776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab55279-c0ce-446d-ee16-08d771aa311b
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maarten Brock <m.brock@vanmierlo.com>

Let set_termios enable/disable automatic flow control.
set_mctrl should not touch automatic flow control.

Signed-off-by: Maarten Brock <m.brock@vanmierlo.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index acdb4fa5..e82f8db 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -694,7 +694,7 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 static void cdns_uart_set_termios(struct uart_port *port,
 				struct ktermios *termios, struct ktermios *old)
 {
-	unsigned int cval = 0;
+	u32 cval = 0;
 	unsigned int baud, minbaud, maxbaud;
 	unsigned long flags;
 	unsigned int ctrl_reg, mode_reg, val;
@@ -815,6 +815,13 @@ static void cdns_uart_set_termios(struct uart_port *port,
 	cval |= mode_reg & 1;
 	writel(cval, port->membase + CDNS_UART_MR);
 
+	cval = readl(port->membase + CDNS_UART_MODEMCR);
+	if (termios->c_cflag & CRTSCTS)
+		cval |= CDNS_UART_MODEMCR_FCM;
+	else
+		cval &= ~CDNS_UART_MODEMCR_FCM;
+	writel(cval, port->membase + CDNS_UART_MODEMCR);
+
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
@@ -1049,12 +1056,9 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	val = readl(port->membase + CDNS_UART_MODEMCR);
 	mode_reg = readl(port->membase + CDNS_UART_MR);
 
-	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR |
-		 CDNS_UART_MODEMCR_FCM);
+	val &= ~(CDNS_UART_MODEMCR_RTS | CDNS_UART_MODEMCR_DTR);
 	mode_reg &= ~CDNS_UART_MR_CHMODE_MASK;
 
-	if (mctrl & TIOCM_RTS || mctrl & TIOCM_DTR)
-		val |= CDNS_UART_MODEMCR_FCM;
 	if (mctrl & TIOCM_LOOP)
 		mode_reg |= CDNS_UART_MR_CHMODE_L_LOOP;
 	else
-- 
2.1.1

