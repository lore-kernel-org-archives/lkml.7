Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0703C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E84B20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 12:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TV9A6phs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCRMm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 08:42:26 -0400
Received: from mail-eopbgr820059.outbound.protection.outlook.com ([40.107.82.59]:53800
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726704AbfCRMmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 08:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgUMnLsGhOoqZeQW6KEHzOycWF7L0qKvRvNN81FyhZ0=;
 b=TV9A6phsTanyWvduCIZGQbhDtm/SWDTJt+Q+QQQkyaOAFObB5mohxTgL2uef2r935sqyK+IQJLFgWaWFFONWumvwTxvxYFrQ7Af8iDnyzrvQ73FfxAMFhdpk0omRXFVuRpRVxJ1xfbnR+CY7hgGHL07mMtpD5wnsetABpAgcxJ4=
Received: from DM6PR02CA0058.namprd02.prod.outlook.com (2603:10b6:5:177::35)
 by BN6PR02MB2354.namprd02.prod.outlook.com (2603:10b6:404:2f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.14; Mon, 18 Mar
 2019 12:42:22 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by DM6PR02CA0058.outlook.office365.com
 (2603:10b6:5:177::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.13 via Frontend
 Transport; Mon, 18 Mar 2019 12:42:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1730.9
 via Frontend Transport; Mon, 18 Mar 2019 12:42:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:43327 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5rav-0005AH-EA; Mon, 18 Mar 2019 05:42:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h5raq-0003zr-8K; Mon, 18 Mar 2019 05:42:16 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2ICg8Ta017195;
        Mon, 18 Mar 2019 05:42:08 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h5rai-0003xh-79; Mon, 18 Mar 2019 05:42:08 -0700
Subject: Re: [PATCH 0/2] Rename dt header and move clock binding
To:     Jolly Shah <jolly.shah@xilinx.com>, <robh+dt@kernel.org>
CC:     <michal.simek@xilinx.com>, <rajanv@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
References: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a23b7c49-d6fb-5e11-7770-c860e8c9b8f9@xilinx.com>
Date:   Mon, 18 Mar 2019 13:42:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1551300670-6949-1-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(305945005)(64126003)(356004)(6666004)(81156014)(126002)(63266004)(4326008)(486006)(31686004)(31696002)(336012)(81166006)(26005)(8676002)(446003)(107886003)(6246003)(426003)(106466001)(476003)(478600001)(44832011)(2616005)(47776003)(65956001)(65806001)(14444005)(23676004)(2486003)(11346002)(229853002)(36756003)(36386004)(76176011)(54906003)(65826007)(230700001)(58126008)(316002)(110136005)(5660300002)(9786002)(106002)(2906002)(77096007)(8936002)(50466002)(186003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2354;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528805d7-0718-4ada-96cc-08d6ab9f2a9c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:BN6PR02MB2354;
X-MS-TrafficTypeDiagnostic: BN6PR02MB2354:
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB23547FE7F08271035525F73BC6470@BN6PR02MB2354.namprd02.prod.outlook.com>
X-Forefront-PRVS: 098076C36C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: njyI8w0Y4HEUClyXWX+AyVlWILxknL8R7BcGxTNMv72W9B4CjiuCCqQUB3FL/kCWaohcq6TvBivYd1ZZ//VmLz+PPR3e3z+s6R+4auFqinLlak+aqzN5RRBEDJxV3m2KchPldMBxwWF30YskZyw3C0bTGfyTdZki1UnoCTNh99jSFY6O2vG/xkvNSk685BIW3FvQ9N2AtiUIOWjnkkJOWHtN22i5ZX4D6EabVzrS6uDxl6AM33OTfz02ootLZeSrU4Oq9VFXD+LyNpruu3J6qOgfeuVrJcrs40k8wzVcqYQKGNFiyP8TfowmRNZ1FQFDWJ3w6pVLNCicYr5rp5wKUPGyGsJ07EatgriO79Kiji/yXSUJUmfYuNNIAaTLWrKQzyKi0KPgXAvCvnuwBmeppJIJmxwDFL4thEZAXo8kwdg=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2019 12:42:22.0807
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528805d7-0718-4ada-96cc-08d6ab9f2a9c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 02. 19 21:51, Jolly Shah wrote:
> This patchset renames clock dt include file to align with other incldues.
> Other patch moves clock binding to a separate file under clock directory to
> align with other firmware child binding documenetation.
> 
> Jolly Shah (1):
>   include: dt-binding: clock: Rename zynqmp header file
> 
> Rajan Vaja (1):
>   dt-bindings: xilinx: Separate clock binding from firmware doc
> 
>  .../devicetree/bindings/clock/xlnx,zynqmp-clk.txt  |  63 +++++++++++
>  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  54 +--------
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 -------------------
>  include/dt-bindings/clock/xlnx-zynqmp-clk.h        | 126 +++++++++++++++++++++
>  4 files changed, 190 insertions(+), 169 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/xlnx,zynqmp-clk.txt
>  delete mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h
>  create mode 100644 include/dt-bindings/clock/xlnx-zynqmp-clk.h
> 

I have applied this. Please let me know if you see any issue with it.

Thanks,
Michal
