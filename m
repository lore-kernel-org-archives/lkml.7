Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E7CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61969217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nVsOJWSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfEJHIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:08:25 -0400
Received: from mail-eopbgr780074.outbound.protection.outlook.com ([40.107.78.74]:8288
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726934AbfEJHIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idbeOJpMWWKVVxJsCC009CC1eowIPz22bWYhdNICMhI=;
 b=nVsOJWSBvwcHHDawAEO913WcQZOEchgihesEnwFAIg0MqmYKG7CfHUeOqCzyxFn7LXa4gssZhBAGVbwEjuzS7eErXwXyFijkY+QRs4F8/vRUQD2cgiqfrZ2Rak02kYn8G06CDI7zSQmg5oIUYkdchp8gtWmknluj59nc7F9UVkI=
Received: from BYAPR02CA0048.namprd02.prod.outlook.com (2603:10b6:a03:54::25)
 by DM5PR02MB3832.namprd02.prod.outlook.com (2603:10b6:4:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1878.22; Fri, 10 May
 2019 07:07:40 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BYAPR02CA0048.outlook.office365.com
 (2603:10b6:a03:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1878.22 via Frontend
 Transport; Fri, 10 May 2019 07:07:40 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1856.11
 via Frontend Transport; Fri, 10 May 2019 07:07:39 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59126 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd5-0003Nt-FJ; Fri, 10 May 2019 00:07:39 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hOzd0-0004bk-B9; Fri, 10 May 2019 00:07:34 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4A77TQZ004220;
        Fri, 10 May 2019 00:07:30 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hOzcv-0004aK-Ir; Fri, 10 May 2019 00:07:29 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id BB4A760509; Fri, 10 May 2019 12:37:28 +0530 (IST)
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
Subject: [PATCH v3 0/3] usb: gadget: Add support for disabling U1 and U2 entries
Date:   Fri, 10 May 2019 12:37:25 +0530
Message-ID: <1557472048-10536-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(376002)(2980300002)(189003)(199004)(50466002)(2616005)(7416002)(48376002)(47776003)(305945005)(16586007)(42186006)(63266004)(316002)(106002)(966005)(51416003)(478600001)(26005)(81166006)(8676002)(70206006)(81156014)(70586007)(8936002)(6266002)(107886003)(103686004)(6666004)(50226002)(110136005)(426003)(476003)(356004)(5660300002)(486006)(2906002)(14444005)(336012)(4326008)(36756003)(90966002)(54906003)(126002)(52956003)(6306002)(186003)(36386004)(5001870100001)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB3832;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e344e7cd-9340-4893-57cb-08d6d51630b6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4709054)(2017052603328);SRVR:DM5PR02MB3832;
X-MS-TrafficTypeDiagnostic: DM5PR02MB3832:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM5PR02MB3832A8947A32938D489F7CDCA70C0@DM5PR02MB3832.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0033AAD26D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: Zd9d9H5dq7+9mxsO4qW3GJ6R0T1AZPlTnYSoB4Ax87oEfxb+SG9UKltUZy3j2ZH7KJ92BwZt51uTgcVcjoAbecFp2/waOUKL6M3sp++0HEsBdRR81KvaDZQa0pwhj91zyokOFudrMueK0C/ChjWiOo/ZTJm0umU5GwnTUbnDfiWqvQUp+QRVoNgF0FMyTPC5URXufXvcGzGZ/13ExhmaXnRzwhgSQYXx2e3ztGxPSJXYbJSbVYz9NTL95rk4tV+T6fFgfYnLGxabbKa/lZ9olJ/K4J7FKjasFCopBchvxqA9wj7El933J5B3hutgLYB/adrXmUVxUCKZgsmCDqvkoDevjjzi1Ecy7rkKkQRlaeRanF9lbbUjjwWAuMDsP/qGr+Myz77FDObHM+LWzvGykehAJW+slo7/6GL/nDpOKWg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2019 07:07:39.8799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e344e7cd-9340-4893-57cb-08d6d51630b6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3832
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

Changes in v3:
	1. As suggested by Thinh Nguyen modified the logic for rejecting only
	   SET_FEATURE(enable U1/U2) from host.
	2. Used cpu_to_le16() before assigning the value to bU2DevExitLat.

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
 drivers/usb/dwc3/gadget.c                      | 20 ++++++++++++++++++++
 drivers/usb/dwc3/gadget.h                      |  6 ++++++
 drivers/usb/gadget/composite.c                 |  2 +-
 include/linux/usb/gadget.h                     |  3 ++-
 8 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.1.1

