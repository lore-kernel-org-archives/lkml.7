Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E8C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F484207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hYhK3OgV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391082AbfFJPHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:07:16 -0400
Received: from mail-eopbgr790044.outbound.protection.outlook.com ([40.107.79.44]:34854
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389368AbfFJPHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlGbTDK0vCLS7MgntYsuF/kp19ce2eRMINisNYYRO6E=;
 b=hYhK3OgVmpN6LoXdxxZNXDxZmEcp1MUz9TsT/u6uH4cjJ8Kor00/gtFsWBrbpI2HULiglAN9aSj8FxOvSS/M+CWU/JjcMf6kfuV5kYngWJJ4v4Ntd7T06tDV9xMf9YtYY1Yz0aVIhioO65YRDnncfbqdTh3JpwWYoxuJqDcyROQ=
Received: from BL0PR02CA0082.namprd02.prod.outlook.com (2603:10b6:208:51::23)
 by DM6PR02MB6233.namprd02.prod.outlook.com (2603:10b6:5:1d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.12; Mon, 10 Jun
 2019 15:07:12 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BL0PR02CA0082.outlook.office365.com
 (2603:10b6:208:51::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1965.12 via Frontend
 Transport; Mon, 10 Jun 2019 15:07:11 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1965.12
 via Frontend Transport; Mon, 10 Jun 2019 15:07:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:51802 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1haLt8-0006nT-MQ; Mon, 10 Jun 2019 08:07:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1haLt3-0007JQ-KN; Mon, 10 Jun 2019 08:07:05 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x5AF70ek027439;
        Mon, 10 Jun 2019 08:07:00 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1haLsy-0007HS-Io; Mon, 10 Jun 2019 08:07:00 -0700
Subject: Re: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
To:     Greg KH <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
 <20190610144425.GC31086@kroah.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <888c7d0a-28dc-978c-662a-e96ee3863c41@xilinx.com>
Date:   Mon, 10 Jun 2019 17:06:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190610144425.GC31086@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(199004)(189003)(426003)(9786002)(65826007)(486006)(54906003)(26005)(70206006)(76176011)(186003)(70586007)(4326008)(478600001)(230700001)(305945005)(446003)(36386004)(44832011)(2906002)(476003)(336012)(11346002)(126002)(2616005)(50466002)(47776003)(6246003)(106002)(8676002)(229853002)(81156014)(31686004)(31696002)(81166006)(5660300002)(65806001)(63266004)(14444005)(2486003)(52146003)(23676004)(77096007)(316002)(6666004)(356004)(65956001)(8936002)(4744005)(64126003)(36756003)(58126008)(110136005)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6233;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd0c7092-6051-4d85-cc11-08d6edb55094
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM6PR02MB6233;
X-MS-TrafficTypeDiagnostic: DM6PR02MB6233:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB62332E6009940D3ECE150114C6130@DM6PR02MB6233.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-Forefront-PRVS: 0064B3273C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: UDPpF2P9o2aYYqT9NtViTB4m4sUyOp1dNh+hSgBQyemya+F/gOVmWnLyNslU/uPmarkLIrG2MuTfAiI9WdKHYbbVp6fA35fl1kCzObKSlukGl5h47/vUPNEsL0W5phFF+VA6E4kvrqeajTLcXWqWaeSOPRBad+LbhhNWjSod82h2SFfqCqk3GwuwPb3Gujp2JvEFk0uYBV0jtEXZA7FyqjR6fIEaB2DxSxQU6uj8TJ1G001tZ6ddE/s0M5EaF19m2Re4xwf3NmxrRMbQzmtR26SJ27SsRi5TraUKp5IrRi5cvar3Yv7SsqoIm/CoWRkyFQU5pFKYpBImCVHorz/bCP5w0zNXDzyWcJNwDZfrmQfrusg6h8vdOoM+j4erBskNhFHsWwyD4BxTIsIh2OaiFbwDQ5qjug1hgZcTz3IR5ao=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2019 15:07:11.1819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0c7092-6051-4d85-cc11-08d6edb55094
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6233
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 06. 19 16:44, Greg KH wrote:
> On Mon, Jun 10, 2019 at 10:44:55AM +0200, Michal Simek wrote:
>> From: Nava kishore Manne <nava.manne@xilinx.com>
>>
>> This patch fixes the below warning
>>
>>         -->Symbolic permissions 'S_IRUGO' are not preferred.
>>            Consider using octal permissions '0444'.
>>         -->macros should not use a trailing semicolon.
>>         -->line over 80 characters.
>>         -->void function return statements are not generally useful.
>>         -->Prefer 'unsigned int' to bare use of 'unsigned'.
>>
>> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Happy to split it if needed.
> 
> Please split.  Do not do more than one "logical thing" per patch.
> 
> And the subject is not correct, there are no general "warnings", these
> are all checkpatch warnings, not a build issue.

ok. Will do. Any issue with second patch?

Thanks,
Michal
