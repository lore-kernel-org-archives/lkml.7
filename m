Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908C9C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233AB206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 05:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="D0AIvI4S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbfHBFM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 01:12:29 -0400
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:60486
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728248AbfHBFM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 01:12:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l6cC7Cx5t3Yjx1JhhIYepv5kM6P4iarmgs/IRs5j4G3Z6nVfrDprTo1MQE+uJJRmWYrTTh6nyzB+yfzV8zM7aGjrY3B2YcaAqVliPDxp0xXmeeT93g9TkkjtG3JDWRsmaILK4kNArrTGM5CPo2l40iUlmIIQkJYnRkMHfk4oldg77essZpEJzrlavPjgi8YpnoTueh/JiA7bxC0A1foXHTJwbPoOPtu8oixNX4zP/o0bd82D6/KIRrBaojRmd/W0k3un76HplTWfEsCYpjbSoCXzemcaY89+cvbKHIv8RsZedZtH2guXAWe/GqVzNrQ8AVH5PCFGXORnqvgk0f46zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ao9XcZcu7u/pjBNiC4k+Js0RzR0XJSJvise8m6ZqM4=;
 b=SGt7yobqLrb3J47avXdp3HNhbMRZ3JDvxQYL9NMB/al0gs0oWGPlKk449mXaSRYXo3wkWjDiSz8B42+idSgwMQ1WB9Vu9rBX1Hw6BpQuec+nuPopCEptF6F2wQKLvNgcEaVFRUHoMbX50k5T0dTrwN5hsetL0KTvagBTLwH4pVzUYOp+FaGZWQmUtlz8+xemW+/marbQy8JA8e6Dtfu17tp/TPVw7xTA6+w2nAp8BN6feFt8rhb9PFox92szk7B8mEzmAjk2FB3F5AInnQk8HurF96V1UG5CdSyoZeYrTOId19PVQPjqq2+RqzbNJ6P7gRR4Rm6iOIwFawgyr5QLLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ao9XcZcu7u/pjBNiC4k+Js0RzR0XJSJvise8m6ZqM4=;
 b=D0AIvI4S6i8gAwzHRnikcnYPCvnGdeM4jT2qupgfOKZ3JhgLuzgsf68SBvrGviaKQCBU25Jk/+jDXRrt2IDZlzClyVpqw9jbBdOwo16mOCuIVH3n8AY6HW8a4atCRoJxpRwvTnEKAoJC9tIvEnDGSCniG9BALG3yk//vfJQ7b3U=
Received: from MWHPR02CA0043.namprd02.prod.outlook.com (2603:10b6:301:60::32)
 by DM5PR02MB2684.namprd02.prod.outlook.com (2603:10b6:3:106::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2136.17; Fri, 2 Aug
 2019 05:12:24 +0000
Received: from CY1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR02CA0043.outlook.office365.com
 (2603:10b6:301:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.17 via Frontend
 Transport; Fri, 2 Aug 2019 05:12:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT014.mail.protection.outlook.com (10.152.75.142) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2136.14
 via Frontend Transport; Fri, 2 Aug 2019 05:12:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1htPra-0001O0-So; Thu, 01 Aug 2019 22:12:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1htPrV-0007ky-Oi; Thu, 01 Aug 2019 22:12:17 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x725CAjT026871;
        Thu, 1 Aug 2019 22:12:10 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1htPrN-0007jq-RG; Thu, 01 Aug 2019 22:12:10 -0700
Subject: Re: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before
 goto
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190709172841.13769-1-nishkadg.linux@gmail.com>
 <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
 <6a5306bd-946d-383f-0b42-f17675c24218@gmail.com>
 <c0be80c9-16ef-fe03-ae3b-a7d3d1a2ede8@xilinx.com>
 <ab6db31d-ff16-5a32-f097-347daa6b98fc@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <51e9925b-507c-9d26-bd58-24b49bf652b1@xilinx.com>
Date:   Fri, 2 Aug 2019 07:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ab6db31d-ff16-5a32-f097-347daa6b98fc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39850400004)(396003)(376002)(136003)(2980300002)(199004)(189003)(106002)(305945005)(110136005)(5660300002)(316002)(31686004)(65956001)(63266004)(50466002)(186003)(2486003)(64126003)(52146003)(47776003)(26005)(31696002)(53546011)(126002)(446003)(11346002)(336012)(8936002)(23676004)(2616005)(476003)(426003)(44832011)(70206006)(486006)(58126008)(70586007)(76176011)(81156014)(8676002)(81166006)(65806001)(14444005)(6246003)(36386004)(356004)(65826007)(36756003)(2870700001)(15650500001)(9786002)(229853002)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR02MB2684;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be990ebe-5ebf-4d17-e114-08d7170800cb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR02MB2684;
X-MS-TrafficTypeDiagnostic: DM5PR02MB2684:
X-Microsoft-Antispam-PRVS: <DM5PR02MB26840776A96FE2F7854580DBC6D90@DM5PR02MB2684.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 011787B9DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: m5nbKnJ3qV0tpqfXyNNLIWqN4+REwUDKHs8WMNq9U0TzGjryXoug/+6muGu4iwGssib2ESv35CyUGjxJiLRSzwgmUyhKCaQggvcJ4TI+pPW8K47J7KIqeBHUOvAbyJXGFgOxqeEe92SAwYTUwNfOCp8Hb3XnMRs5NjoDp/J/dN4O8VC7gudROS1d3F6pW7A2BMygeEhHdT+AFKG8S/E9Y/TcNJLPcE2mkER5hvru+z1FdLo73v5glGwUC6EqhzkkHswcAXNVXxDfgLL3gbJlaGWJkl666NEONVpZTaeczcFOALOD89oLs2XaEjux4Q+OeXqHy/tCpXLUlW+5rybLjccHRu6h3g85q+6fhMBmJZmgKr5yWwdZcJkvVwuHMPG0FbP4mL7e2pT9PVL3kS/2kQM5qaEYsFS82RJP2P9TgME=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2019 05:12:23.4358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be990ebe-5ebf-4d17-e114-08d7170800cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2684
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 08. 19 6:59, Nishka Dasgupta wrote:
> On 31/07/19 7:51 PM, Michal Simek wrote:
>> On 31. 07. 19 15:06, Nishka Dasgupta wrote:
>>> On 31/07/19 2:01 PM, Michal Simek wrote:
>>>> On 09. 07. 19 19:28, Nishka Dasgupta wrote:
>>>>> Each iteration of for_each_available_child_of_node puts the previous
>>>>> node, but in the case of a goto from the middle of the loop, there is
>>>>> no put, thus causing a memory leak. Hence add an of_node_put before
>>>>> the
>>>>> goto.
>>>>> Issue found with Coccinelle.
>>>>>
>>>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>>>> ---
>>>>>    drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>>>>>    1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> index 86887c9a349a..bd80d4c10ec2 100644
>>>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>>>> @@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct
>>>>> platform_device *pdev)
>>>>>            if (ret) {
>>>>>                dev_err(dev, "failed to probe subdev.\n");
>>>>>                ret = -EINVAL;
>>>>> +            of_node_put(nc);
>>>>>                goto free_mbox_dev;
>>>>>            }
>>>>>            mbox++;
>>>>>
>>>>
>>>> Patch is good but when you are saying that this was found by Coccinelle
>>>> then it should be added as script to kernel to detect it.
>>>
>>> This particular patch was suggested by a script I did not write myself;
>>> someone else wrote it and sent it to me. How should I proceed in this
>>> case?
>>
>> You can ask him to submit it to kernel.
>> Or you can take it, keep his authorship and send it to:
> 
> I have asked her to submit this script, thank you. Will I need to
> resubmit this patch, however?

I will let Jassi to decide.

Thanks,
Michal
