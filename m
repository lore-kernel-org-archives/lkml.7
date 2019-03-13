Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73317C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEB12087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 13:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ic53/oGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCMN4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 09:56:07 -0400
Received: from mail-eopbgr770054.outbound.protection.outlook.com ([40.107.77.54]:44210
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfCMN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 09:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/wTLA4RtlcgAO9VkeL0zDyKxHC2sEL6AvuuUlEJhUE=;
 b=ic53/oGhLXBUIp+Eni2UD4bb4mMGsfHBVWGp6iBcs0/IkOMOfroVHok7jgZmFWfBW+hF1hBo0I+y8ue3YbZM4D9YEg4tW4vLZzqjhTpTbbLuxqtTN2f+cg18UJzvIkd5ATj0AlDsoQKemD5CwVCc+pDYW70bWfBYutmCyab3Kmg=
Received: from MWHPR02CA0057.namprd02.prod.outlook.com (2603:10b6:301:60::46)
 by DM6PR02MB4345.namprd02.prod.outlook.com (2603:10b6:5:2a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13; Wed, 13 Mar
 2019 13:56:03 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by MWHPR02CA0057.outlook.office365.com
 (2603:10b6:301:60::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1709.13 via Frontend
 Transport; Wed, 13 Mar 2019 13:56:02 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1686.19
 via Frontend Transport; Wed, 13 Mar 2019 13:56:02 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:38832 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h44MT-0006bQ-TZ; Wed, 13 Mar 2019 06:56:01 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1h44MO-0002k1-PL; Wed, 13 Mar 2019 06:55:56 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x2DDtpUW003332;
        Wed, 13 Mar 2019 06:55:51 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1h44MJ-0002jJ-5l; Wed, 13 Mar 2019 06:55:51 -0700
Subject: Re: [PATCH] clocksource: cadence_ttc: fix memory leak in
 ttc_setup_clockevent
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Yue Haibing <yuehaibing@huawei.com>, <michal.simek@xilinx.com>,
        <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190309131958.17996-1-yuehaibing@huawei.com>
 <b9831ea9-3230-6f63-8c73-b3b2cd28c59f@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <127508c8-6275-2ecb-5b7a-4aea1b7c45ba@xilinx.com>
Date:   Wed, 13 Mar 2019 14:55:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b9831ea9-3230-6f63-8c73-b3b2cd28c59f@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(346002)(136003)(39860400002)(2980300002)(199004)(189003)(81166006)(65806001)(58126008)(8676002)(77096007)(81156014)(478600001)(9786002)(316002)(305945005)(54906003)(106466001)(110136005)(6246003)(4326008)(6306002)(2486003)(23676004)(65826007)(106002)(31686004)(8936002)(966005)(76176011)(65956001)(36386004)(47776003)(229853002)(31696002)(4744005)(64126003)(186003)(336012)(2616005)(476003)(126002)(426003)(11346002)(446003)(2201001)(356004)(36756003)(44832011)(486006)(5660300002)(26005)(50466002)(2906002)(230700001)(63266004)(42866002)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4345;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 993268eb-f264-4a11-5fb2-08d6a7bba154
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060);SRVR:DM6PR02MB4345;
X-MS-TrafficTypeDiagnostic: DM6PR02MB4345:
X-MS-Exchange-PUrlCount: 1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4345F1BC8B27516F5800533EC64A0@DM6PR02MB4345.namprd02.prod.outlook.com>
X-Forefront-PRVS: 09752BC779
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: haJq18/3wYC61flYyQjN2nFqumhAlC0U1z1SKW533v9bAX/2aKDZuU8+7oMyfwweTb39KV63pgTGj8qQggdJn5d5qqX2tl6wf30KczMA3I4NlAb+y3i1wS/tEoHmrHqCQL6JwWejGmDN49qh4FUDgdRPS198pAGPsWY1IEEysInHJDfPR47s9sQ5A8HaSSPT2uvJzjo2cNu3x5rvtkoXfQ8IaH3M/x0vw6cKqURBcfd+zB3VW/Vn0vymZSB/h5meIuDvb6fThOWqHlyLDrlztWrf64xRcQJpCaVROapZBEVrPIaFybued3DRu3nVdPuhdmzTcmH9eHiT3I1J171/QQYGrVZ7MDeIQt1duzIq57jpSFo5t7JB3s3FhCRe5MOGQCgXxa1eiKBXofs3GpA2nacyo03AqVKZ9o0QXO2Hb0M=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2019 13:56:02.4465
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993268eb-f264-4a11-5fb2-08d6a7bba154
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4345
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09. 03. 19 15:24, Daniel Lezcano wrote:
> 
> Hi Yue,
> 
> I appreciate the fix but usually we add a rollback for all the
> operations done in the init function.
> 
> Please, migrate the init function to the timer-of API, so the rollback
> will be automatically handled.
> 
> Example here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/clocksource/timer-sprd.c#n197

I have put a record to Xilinx database to take a look at it when we have
time.

Thanks,
Michal
