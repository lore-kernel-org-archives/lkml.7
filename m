Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E175C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620120644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 07:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="C/wDZ53A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfEHHzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 03:55:53 -0400
Received: from mail-eopbgr820082.outbound.protection.outlook.com ([40.107.82.82]:56288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfEHHzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 03:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntZ1DgLIHPzxyWjXS/i+t9vKfZShLt9v6y3eqbMIIEI=;
 b=C/wDZ53A3EZZcdOYBZhK++Eeo/df1P2N4YF4O3lp1+5OB6f1WE8Y9QUw8uAQQD6wsf7/d/Gu8EiQC58PwmYshhphL1L63K62Nqj2q6iyESqzTpBh2UARk58+eAFW/79GXajbQHFR3ov+PS8lg0eIG6WzsG29E+oUneb9QZS9xMQ=
Received: from MN2PR02CA0032.namprd02.prod.outlook.com (2603:10b6:208:fc::45)
 by DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1856.12; Wed, 8 May
 2019 07:55:10 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MN2PR02CA0032.outlook.office365.com
 (2603:10b6:208:fc::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.20 via Frontend
 Transport; Wed, 8 May 2019 07:55:09 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Wed, 8 May 2019 07:55:08 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPw-0004Y6-E8; Wed, 08 May 2019 00:55:08 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOHPr-0005yM-9u; Wed, 08 May 2019 00:55:03 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x487sqF4027151;
        Wed, 8 May 2019 00:54:53 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOHPg-0005s9-KO; Wed, 08 May 2019 00:54:52 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C80BC604D8; Wed,  8 May 2019 13:24:51 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "Claus H. Stovgaard" <cst@phaseone.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v2 0/3] usb: gadget: Add support for disabling U1 and U2 entries
Date:   Wed, 8 May 2019 13:24:48 +0530
Message-ID: <1557302091-7455-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(136003)(396003)(2980300002)(199004)(189003)(63266004)(7416002)(47776003)(305945005)(356004)(6666004)(90966002)(81166006)(486006)(81156014)(103686004)(26005)(2616005)(186003)(8936002)(51416003)(426003)(8676002)(476003)(336012)(2906002)(50226002)(16586007)(126002)(4326008)(6266002)(316002)(6306002)(42186006)(110136005)(70586007)(5660300002)(70206006)(14444005)(107886003)(54906003)(106002)(478600001)(48376002)(966005)(52956003)(50466002)(36756003)(36386004)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3830;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2966770b-a25f-415a-a58a-08d6d38a7e36
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR02MB3830;
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB383097B712FB76222FB0FCE7A7320@DM5PR02MB3830.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0031A0FFAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 848ofKxSide2kz0vOQHCMH3F5BFB8QzXRUmztvYUI5DDh3yfMrecykWhNZZy/h4fd8zrzRXf/toxz7yXtnzDWnUs2RB1uyEHCvThIQ3pHSKdiBpKAKAZVy6o9xpZ2eXR2ARTspeeiacAnwlA0Wr4XzGcZM1KpmM3g18cZo9D0RXcCHLcWdm578TRK4cLllJ0/I0YdcNZDXUVjmM7p5NbGDvtvDGF3zehczVJfQL4L0NuPjKW5xEoDLo38MjDvO0xfKKokPgglP0SDrORCeoBaMNnxSLG6hav0J6JJ/93Y8ViLf7UVQZ0AR1lo1hAZetBr8F1N663viD5ZNnBCEa1oNEnMrZ1T/3f4lIP+6WLG9vjIeduJZLfdGaslAYgnki23k2/gbCx6xHknDr4GHrAH8uiB2zhZCWknHnZS70WSRI=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2019 07:55:08.9654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2966770b-a25f-415a-a58a-08d6d38a7e36
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gadget applications may have a requirement to disable the U1 and U2
entry based on the usecase. Below are few usecases where the disabling
U1/U2 entries may be possible.

Usecase 1:
When combining dwc3 with an redriver for a USB Type-C device solution, it
sometimes have problems with leaving U1/U2 for certain hosts, resulting in
link training errors and reconnects. For this U1/U2 state entries may be
avoided.

Usecase 2:
When performing performance benchmarking on mass storage gadget the
U1 and U2 entries can be disabled.

Usecase 3:
When periodic transfers like ISOC transfers are used with bInterval
of 1 which doesn't require the link to enter into U1 or U2 state entry
(since ping is issued from host for every uframe interval). In this
case the U1 and U2 entry can be disabled.

Disablement of U1/U2 can be done by setting U1DevExitLat and U2DevExitLat
values to 0 in the BOS descriptor. Host on seeing 0 value for U1DevExitLat
and U2DevExitLat, it doesn't send SET_SEL requests to the gadget. There
may be some hosts which may send SET_SEL requests even after seeing 0 in
the UxDevExitLat of BOS descriptor. To aviod U1/U2 entries for these type
of hosts, dwc3 controller can be programmed to reject those U1/U2 requests
by not enabling ACCEPTUxENA bits in DCTL register.

This patch series updates the same.

Changes in v2:
	1. As suggested by Thinh Nguyen changed the "snps,dis_u1_entry_quirk"
	   to "snps,dis-u1-entry-quirk"
	2. Merged the changes done by Claus H. Stovgaard in ep0.c for rejecting
	   U1/U2 requests into this patch. Changes done by Claus can be found
	   here https://marc.info/?l=linux-kernel&m=155722068820568&w=2

Anurag Kumar Vulisha (3):
  doc: dt: bindings: usb: dwc3: Update entries for disabling U1 and U2
  usb: gadget: send usb_gadget as an argument in get_config_params
  usb: dwc3: gadget: Add support for disabling U1 and U2 entries

 Documentation/devicetree/bindings/usb/dwc3.txt |  2 ++
 drivers/usb/dwc3/core.c                        |  4 ++++
 drivers/usb/dwc3/core.h                        |  4 ++++
 drivers/usb/dwc3/ep0.c                         |  9 ++++++++-
 drivers/usb/dwc3/gadget.c                      | 19 +++++++++++++++++++
 drivers/usb/dwc3/gadget.h                      |  6 ++++++
 drivers/usb/gadget/composite.c                 |  2 +-
 include/linux/usb/gadget.h                     |  3 ++-
 8 files changed, 46 insertions(+), 3 deletions(-)

-- 
2.1.1

