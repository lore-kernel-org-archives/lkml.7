Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1972BC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37D52082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfKYNDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:03:00 -0500
Received: from mail-eopbgr730080.outbound.protection.outlook.com ([40.107.73.80]:45308
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfKYNC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:02:59 -0500
Received: from CH2PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:4e::30)
 by BN7PR02MB4034.namprd02.prod.outlook.com (2603:10b6:406:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.19; Mon, 25 Nov
 2019 13:02:55 +0000
Received: from CY1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by CH2PR02CA0020.outlook.office365.com
 (2603:10b6:610:4e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.21 via Frontend
 Transport; Mon, 25 Nov 2019 13:02:55 +0000
Authentication-Results: spf=softfail (sender IP is 149.199.60.83)
 smtp.mailfrom=gmail.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none header.from=gmail.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 gmail.com discourages use of 149.199.60.83 as permitted sender)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT024.mail.protection.outlook.com (10.152.74.210) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Mon, 25 Nov 2019 13:02:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE10-0008Ax-Eg; Mon, 25 Nov 2019 05:02:54 -0800
Received: from localhost ([127.0.0.1] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0v-0008Tu-Cf; Mon, 25 Nov 2019 05:02:49 -0800
Received: from [10.140.6.59] (helo=xhdshubhraj40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <shubhrajyoti.datta@gmail.com>)
        id 1iZE0u-0008Ox-GI; Mon, 25 Nov 2019 05:02:48 -0800
From:   shubhrajyoti.datta@gmail.com
To:     linux-kernel@vger.kernel.org
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        Maarten Brock <m.brock@vanmierlo.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/3] serial: xilinx_uartps: set_termios sets flowcontrol
Date:   Mon, 25 Nov 2019 18:32:40 +0530
Message-Id: <1574686961-9588-2-git-send-email-shubhrajyoti.datta@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1574686961-9588-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1574686961-9588-1-git-send-email-shubhrajyoti.datta@gmail.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--4.830-7.0-31-1
X-imss-scan-details: No--4.830-7.0-31-1;No--4.830-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-Matching-Connectors: 132191605750530805;(f9e945fa-a09a-4caa-7158-08d2eb1d8c44);()
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(316002)(4326008)(2351001)(356004)(6666004)(86362001)(305945005)(498600001)(8676002)(336012)(61266001)(9686003)(47776003)(76482006)(70206006)(50466002)(107886003)(11346002)(81156014)(2616005)(446003)(48376002)(70586007)(2906002)(426003)(81166006)(51416003)(14444005)(54906003)(26005)(2361001)(9786002)(16586007)(82202003)(73392003)(6916009)(8936002)(76176011)(50226002)(55446002)(36756003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB4034;H:xsj-pvapsmtpgw01;FPR:;SPF:SoftFail;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aee43976-50e1-45e1-bf7b-08d771a7c982
X-MS-TrafficTypeDiagnostic: BN7PR02MB4034:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4034C07D0BDAA2D47A1AF657874A0@BN7PR02MB4034.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:136;
X-Forefront-PRVS: 0232B30BBC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0QxALJsAua1dQ3B06amMpYZ5RkqPQh+muVdLz0Uf3Mc5V5ErO87qb+9K+v+eCqpTu1O2R0oCje+knHfEWhqNaTm12mq9vVuK2HqYsz2Xc+4ZLhjjwLR9h0W4M4TbhMZwqvolgpSefVtKEZrm7g+g4ZbRcHJw/ZEqfgOKmEJ7sYn6Vg/FgdHkXKHB4/TiMrBdVJHD5/uYgLppPELYeoPSi3M7gJfL+//lwrIvfW2Syx/LiBXAWM0me7E70L6Lcz1pmsakgrnvdV6WMng2+++gBhjUQR5Z3ymtgJtxiG0jek0vk9LIIsiCis7Ze18Q18XnBT2G96SFzZ8jbx6TY328DwEpeSuLDF4+RngzCY9NsefMMzEqGqj43mELYFqke0caETqSjuPDZbv3plZDtUDUmSuyrp1aGmF0bgRY/M8v43ljnXjX3+cgPzFfw1hn2uqg
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2019 13:02:54.9189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee43976-50e1-45e1-bf7b-08d771a7c982
X-MS-Exchange-CrossTenant-Id: 5afe0b00-7697-4969-b663-5eab37d5f47e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5afe0b00-7697-4969-b663-5eab37d5f47e;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4034
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
index 9e12589..44dabd4 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -704,7 +704,7 @@ static void cdns_uart_break_ctl(struct uart_port *port, int ctl)
 static void cdns_uart_set_termios(struct uart_port *port,
 				struct ktermios *termios, struct ktermios *old)
 {
-	unsigned int cval = 0;
+	u32 cval = 0;
 	unsigned int baud, minbaud, maxbaud;
 	unsigned long flags;
 	unsigned int ctrl_reg, mode_reg, val;
@@ -825,6 +825,13 @@ static void cdns_uart_set_termios(struct uart_port *port,
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
 
@@ -1059,12 +1066,9 @@ static void cdns_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
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

