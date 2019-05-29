Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=AC_FROM_MANY_DOTS,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE0DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3BE23B5C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="0SF+kbZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfE2PAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:00:07 -0400
Received: from mail-eopbgr760042.outbound.protection.outlook.com ([40.107.76.42]:62331
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726147AbfE2PAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON5/Ha0qg8YzKDotvQGjWDShxo70tZShCJ7W05kbDC4=;
 b=0SF+kbZqFgllf06drQMR/1svsVbUkafsrbO60fTGWEtfOJ8qEO7obMy/3BOIlHM3+qeq30pib/58op75htNWOwQ+PoZU0SP97scINUX/eHLo0csB+22iaoC2lASVRipe6/ct5ogKPMz1W7hlGk7TQoUbBUO4Z4TgLaMBErWcAlU=
Received: from DM6PR02CA0012.namprd02.prod.outlook.com (2603:10b6:5:1c::25) by
 BYAPR02MB4936.namprd02.prod.outlook.com (2603:10b6:a03:47::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.17; Wed, 29 May 2019 15:00:03 +0000
Received: from CY1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by DM6PR02CA0012.outlook.office365.com
 (2603:10b6:5:1c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1943.16 via Frontend
 Transport; Wed, 29 May 2019 15:00:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT055.mail.protection.outlook.com (10.152.74.80) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1922.16
 via Frontend Transport; Wed, 29 May 2019 15:00:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:33191 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hW03e-0001wV-AL; Wed, 29 May 2019 08:00:02 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1hW03Z-0006Tc-65; Wed, 29 May 2019 07:59:57 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x4TExlSJ022944;
        Wed, 29 May 2019 07:59:48 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1hW03P-0006TH-Ft; Wed, 29 May 2019 07:59:47 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id A962D604A9; Wed, 29 May 2019 20:29:46 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        v.anuragkumar@gmail.com,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH] usb: dwc3: gadget: Correct the logic for finding last SG entry
Date:   Wed, 29 May 2019 20:29:45 +0530
Message-Id: <1559141985-17104-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(346002)(39860400002)(396003)(2980300002)(189003)(199004)(50226002)(8936002)(186003)(26005)(42186006)(316002)(52956003)(63266004)(107886003)(426003)(8676002)(2616005)(48376002)(50466002)(305945005)(103686004)(336012)(81156014)(81166006)(478600001)(14444005)(36756003)(47776003)(51416003)(70206006)(70586007)(5660300002)(356004)(2906002)(4326008)(110136005)(36386004)(126002)(16586007)(486006)(6266002)(106002)(476003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4936;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61636102-3efd-4fdf-2a32-08d6e4465439
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(4709054)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:BYAPR02MB4936;
X-MS-TrafficTypeDiagnostic: BYAPR02MB4936:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4936451F5CDB8BDE86C17686A71F0@BYAPR02MB4936.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0052308DC6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: +WF5sPnKo8c/mn8HNcknG+/9BqVGaMRf2DcOSTlg9RVPOwMCcvsPiLnOvue+Vs0wyZLILiS5s79zRzq9qvIcm5EFJecMOD31/xDLZn+3Pq8Y2Ygb5aNtGTFWtd3YhnOY9pQ2U1L9MIqFXr7JSiOu+ACA+JhH0+tZnf4f2yaaOurTTE0VjMmkwSsiwkfrLTYL6MLrGiLsmMMCVFEpSREYvJpH3qRD0j0f+0qH0QmgL6beSKaeNIk0vr2ykUlrzqwv1DgUBxXGj2zpUQH1LP8X0zYo9ri5ChMJmNkwYBVpWat49llzdjRuFW6uEunL4xlW3UeeFNbNJ5yh2yQ545EebYGlbCOpirOA7NFLopFfz/0wz3YIjAT8bvYRDBOHYaRQHWcoLV3l/7UEXZlzjkZ0bTegFQIy/v2/WnV+1sgYLsw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2019 15:00:02.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61636102-3efd-4fdf-2a32-08d6e4465439
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a process of preparing TRBs usb_gadget_map_request_by_dev() is
called from dwc3_prepare_trbs() for mapping the request. This will
call dma_map_sg() if req->num_sgs are greater than 0. dma_map_sg()
will map the sg entries in sglist and return the number of mapped SGs.
As a part of mapping, some sg entries having contigous memory may be
merged together into a single sg (when IOMMU used). So, the number of
mapped sg entries may not be equal to the number of orginal sg entries
in the request (req->num_sgs).

As a part of preparing the TRBs, dwc3_prepare_one_trb_sg() iterates over
the sg entries present in the sglist and calls sg_is_last() to identify
whether the sg entry is last and set IOC bit for the last sg entry. The
sg_is_last() determines last sg if SG_END is set in sg->page_link. When
IOMMU used, dma_map_sg() merges 2 or more sgs into a single sg and it
doesn't retain the page_link properties. Because of this reason the
sg_is_last() may not find SG_END and thus resulting in IOC bit never
getting set.

For example:

Consider a request having 8 sg entries with each entry having a length of
4096 bytes. Assume that sg1 & sg2, sg3 & sg4, sg5 & sg6, sg7 & sg8 are
having contigous memory regions.

Before calling dma_map_sg():
            sg1-->sg2-->sg3-->sg4-->sg6-->sg7-->sg8
dma_length: 4K    4K    4K    4K    4K    4K    4K
SG_END:     False False False False False False True
num_sgs = 8
num_mapped_sgs = 0

The dma_map_sg() merges sg1 & sg2 memory regions into sg1->dma_address.
Similarly sg3 & sg4 into sg2->dma_address, sg5 & sg6 into the
sg3->dma_address and sg6 & sg8 into sg4->dma_address. Here the memory
regions are merged but the page_link properties like SG_END are not
retained into the merged sgs.

After calling dma_map_sg();
            sg1-->sg2-->sg3-->sg4-->sg6-->sg7-->sg8
dma_length: 8K    8K    8K    8K    0K    0K     0K
SG_END:     False False False False False False True
num_sgs = 8
num_mapped_sgs = 4

After calling dma_map_sg(), sg1,sg2,sg3,sg4 are having dma_length of
8096 bytes each and remaining sg4,sg5,sg6,sg7 are having 0 bytes of
dma_length.

After dma_map_sg() is performed dma_perpare_trb_sg() iterates on all sg
entries and sets IOC bit only for the sg8 (since sg_is_last() returns true
only for sg8). But after calling dma_map_sg() the valid data are present
only till sg4 and the IOC bit should be set for sg4 TRB only (which is not
happening in the present code)

The above mentioned issue can be fixed by determining last sg based on the
req->num_queued_sgs instead of sg_is_last(). If (req->num_queued_sgs + 1)
is equal to req->num_mapped_sgs, then this sg is the last sg. In the above
example, the dwc3 driver has already queued 3 sgs (upto sg3), so the
num_queued_sgs = 3. On preparing the next sg (i.e sg4), check for last sg
(num_queued_sgs + 1) == num_mapped_sgs becomes true. So, the driver sets
IOC bit for sg4. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index d676553..0ab59a6 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1062,7 +1062,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		if (sg_is_last(s))
+		if ((req->num_queued_sgs + 1) == req->request.num_mapped_sgs)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
-- 
2.1.1

