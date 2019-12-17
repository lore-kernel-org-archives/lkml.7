Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D85EC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6882146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="hN+kGbOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfLQPAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:00:41 -0500
Received: from mail-dm6nam11on2077.outbound.protection.outlook.com ([40.107.223.77]:22666
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726560AbfLQPAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:00:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlAvK+NiJO5E93puafyje2fk/fuQkVk7nIEnDVFw7hzcQL+u6rygt664ytHsZO9xr/k8q6z4w07RtYUjT4u41DbRe+dOMCr13LceC96wEwqA70f+Ymcrtdqb9qsNXnaOwVcaispmb2hcWaeFY0ow9evnH1+fulOsobkyk7pFFPPOe/tAjucmosdd+Oc+qTk+M+2LRQR+lSOI/4CCJ6r0/2tGDne7TuwmVoAwEnmw4lsaSWSby96GuMKNsXeyTP5YEoMzAQsu0aDXaCcz+FtmAcS9WNYvJ6IoxQQpbIL3WwkRBjqW7nOzClHqd1o8CG13Xoi/HqgPKGdW4/lFtbMWrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1m/xWx/6c4QiohZBfzSiVJiftjl77uZxLdlVhnub1o=;
 b=kFb06RzZRHCTN1SEmW1ns5sh9NnoPKRjG2auhHsviyrpcc5MCQ0MHle6mgNRs1MEjvEG+zlJIea1rW9rRKVxZ3zY93vCFKepXZvcTMUH23aRYdgyyiOM/3mlKwD4w2JjpckmmFnDcGNm0VHJJsOPSXYAuDwrrw9Fq+bEd9PBJc4Raev7KhjCcxO4uH2XLq9W7Dhm3X6otFj6aS5w6Ngv7qDYPAOSRsJYlE9zydc1Li2boRs9Gu7tMNtsYVzuQgfbax3WXnNpM1WOTk5zQSigIWNN5DkpTAiX8sIt7nlcfxDIoyO6HyNwSr84nlhhlUwUlp/yslGMDNatRgu//Cps5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1m/xWx/6c4QiohZBfzSiVJiftjl77uZxLdlVhnub1o=;
 b=hN+kGbOFdbMKGA9cdOU1EB80MjKw6/CfMRkSmvOtXNMQ75udroZd9+fzjLDy+D1FSxlR7bFKYo37U5Q51PJaexyyCwNfuekAgqDv/F34dxTBNNcdlDGyK84mqj+A6lwQDfzE6fJS9G3MhQSCsMcztwl88PCalwmYGqZYrrsbYYo=
Received: from CY4PR06CA0049.namprd06.prod.outlook.com (2603:10b6:903:13d::11)
 by BN8PR02MB5762.namprd02.prod.outlook.com (2603:10b6:408:b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Tue, 17 Dec
 2019 15:00:36 +0000
Received: from CY1NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::f1) by CY4PR06CA0049.outlook.office365.com
 (2603:10b6:903:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.16 via Frontend
 Transport; Tue, 17 Dec 2019 15:00:35 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT040.mail.protection.outlook.com (10.152.75.135) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Tue, 17 Dec 2019 15:00:34 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihEKr-0000vF-T1; Tue, 17 Dec 2019 07:00:29 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihEKm-00026Z-OT; Tue, 17 Dec 2019 07:00:24 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ihEKd-0001l3-Py; Tue, 17 Dec 2019 07:00:15 -0800
Subject: Re: [PATCH] drivers: clocksource: Use ttc driver as platform driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1573122988-18399-1-git-send-email-rajan.vaja@xilinx.com>
 <BYAPR02MB40555C1884AA318D9E79EFFEB7450@BYAPR02MB4055.namprd02.prod.outlook.com>
 <2ffe4baf-1de1-3f0e-311f-dd1fdaf1cee8@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <d313e68d-81ea-29e0-1e0b-306716855ea0@xilinx.com>
Date:   Tue, 17 Dec 2019 16:00:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <2ffe4baf-1de1-3f0e-311f-dd1fdaf1cee8@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(13464003)(199004)(189003)(81156014)(478600001)(316002)(4326008)(8676002)(81166006)(426003)(70206006)(2616005)(31686004)(110136005)(336012)(44832011)(54906003)(356004)(9786002)(186003)(26005)(36756003)(5660300002)(2906002)(70586007)(31696002)(53546011)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5762;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9325e4b-91c3-41e2-3338-08d78301de77
X-MS-TrafficTypeDiagnostic: BN8PR02MB5762:
X-Microsoft-Antispam-PRVS: <BN8PR02MB5762A63328E0EDB8B95EDAA5C6500@BN8PR02MB5762.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLiOTzmT8xKWvEJW5/bQzgN0Md+yV198HR9MKK9AIbv2yJlOj5EMX3Kz/UBKQuLM20u4gx7kLXzJl17ZpRqPgmW34bLthkcvU7LCWrzsd9s2NT/0IftlaDUhgM/xev4gkj5/ZcaXy9zctyQ6EVVxMzz5s6LUQaGmBJt7++aWodRTpgAO093dzKBIE5QOW2WSsnFUa1RuU7Wm/1yzHpt8Is1V97rFshjRi2/rlCYkKUFQHWxmRTeysojp5aFri1bhuRv4CgaWyy72B+P343hL252/bKo5FpQxt9/XDw1yYWj4yUpjzFpr8MUmNBDxxpwKCgCtT6Urzp17rbPGXxPYZLu6JSB4OUtXiCgrI//GczhERegK8ODxxlTmHJcppasrlBNKlBNAAITCPtNBPVaL1HPl8PTXV79uFUpJDqtxRWC/wkcfjWW5MhEf5KtXlHix41OAuXM1BJBSvxo3ukZez+UqfCz2viLWzS6CMfi7lMVmYKVRqKrkxlmGaSCes2bv
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 15:00:34.5032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9325e4b-91c3-41e2-3338-08d78301de77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5762
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 12. 19 17:24, Daniel Lezcano wrote:
> On 26/11/2019 12:53, Rajan Vaja wrote:
>> Request for review.
> 
> Waiting from Michal Simek review ...
> 
> 
>>> -----Original Message-----
>>> From: Rajan Vaja <rajan.vaja@xilinx.com>
>>> Sent: 07 November 2019 04:06 PM
>>> To: Michal Simek <michals@xilinx.com>; daniel.lezcano@linaro.org;
>>> tglx@linutronix.de
>>> Cc: linux-arm-kernel@lists.infradead.org; Jolly Shah <JOLLYS@xilinx.com>; linux-
>>> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
>>> Subject: [PATCH] drivers: clocksource: Use ttc driver as platform driver
>>>
>>> Currently TTC driver is TIMER_OF_DECLARE type driver. Because of
>>> that, TTC driver may be initialized before other clock drivers. If
>>> TTC driver is dependent on that clock driver then initialization of
>>> TTC driver will failed.
>>>
>>> So use TTC driver as platform driver instead of using
>>> TIMER_OF_DECLARE.
>>>
>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>> ---
>>>  drivers/clocksource/timer-cadence-ttc.c | 26 ++++++++++++++++++--------
>>>  1 file changed, 18 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-
>>> cadence-ttc.c
>>> index 88fe2e9..38858e1 100644
>>> --- a/drivers/clocksource/timer-cadence-ttc.c
>>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>>> @@ -15,6 +15,8 @@
>>>  #include <linux/of_irq.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/sched_clock.h>
>>> +#include <linux/module.h>
>>> +#include <linux/of_platform.h>
>>>
>>>  /*
>>>   * This driver configures the 2 16/32-bit count-up timers as follows:
>>> @@ -464,13 +466,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>>  	return 0;
>>>  }
>>>
>>> -/**
>>> - * ttc_timer_init - Initialize the timer
>>> - *
>>> - * Initializes the timer hardware and register the clock source and clock event
>>> - * timers with Linux kernal timer framework
>>> - */
>>> -static int __init ttc_timer_init(struct device_node *timer)
>>> +static int __init ttc_timer_probe(struct platform_device *pdev)
>>>  {
>>>  	unsigned int irq;
>>>  	void __iomem *timer_baseaddr;
>>> @@ -478,6 +474,7 @@ static int __init ttc_timer_init(struct device_node *timer)
>>>  	static int initialized;
>>>  	int clksel, ret;
>>>  	u32 timer_width = 16;
>>> +	struct device_node *timer = pdev->dev.of_node;
>>>
>>>  	if (initialized)
>>>  		return 0;
>>> @@ -532,4 +529,17 @@ static int __init ttc_timer_init(struct device_node *timer)
>>>  	return 0;
>>>  }
>>>
>>> -TIMER_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
>>> +static const struct of_device_id ttc_timer_of_match[] = {
>>> +	{.compatible = "cdns,ttc"},
>>> +	{},
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(of, ttc_timer_of_match);
>>> +
>>> +static struct platform_driver ttc_timer_driver = {
>>> +	.driver = {
>>> +		.name	= "cdns_ttc_timer",
>>> +		.of_match_table = ttc_timer_of_match,
>>> +	},
>>> +};
>>> +builtin_platform_driver_probe(ttc_timer_driver, ttc_timer_probe);
>>> --
>>> 2.7.4
>>

Looks good. I have also tested it on zc706.

Tested-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>

Note: headers are not sorted but they weren't even before this patch.

Thanks,
Michal


