Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE33C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86CA20716
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="gqgZyfDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfLTIiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:38:08 -0500
Received: from mail-eopbgr700069.outbound.protection.outlook.com ([40.107.70.69]:59936
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbfLTIiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:38:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSsigN2HIL1fCcIbf2xexsCr6T9oMf5K8OumU+c8Kz972Tcor+RbyHGQoBCYr3goReVmE2u5hwj/a8mrB5DmevqpK8xU5S/fvILALomOlwfCY9lCuc8kD1uaf/3qYTijb50rW76UGNpCa8+D4IZGViwxN8JPem9bLlnk3HjOq3TG1HKZiGIZDB386dTMBfoE5ccJ6b2Uox1caNRtdS0l3yl4YNf1Gx4rNq8ZpaNPosp7rkZtHFYGAkEGEw5Opb+sVUlICtHK760qHqESanqURY61Elcs6FjjdHscR4DJEX3ZpFHZmZasgNhE+6doFYHEDbT5CeNr8Ke/xF4Fryk+eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLcQJIC1S+0YSE6e4VtMV6Hwbg3ZflHxhmeLrgqULr0=;
 b=hW4Xiw4TiLrsFFHGdxLPT+fvGo7CK6FPwvdZaLmWD245y1HgV1QB8SiCFppJQn7sppy+MhTM2BFCqkByN1/esclX6qIEHTnyvnG2n8AKPsx7txosWRNrbGvLirUEw3rHr/Nf835CZn6FDdWrs5XM299Ljw465YfIBtXkddMMrI0EEngaJgzNEQBgOrnPY3ICq5SeD1V4lcufeRw55yVwQcUTNXr4EeTcjbPAH1EmCVOd9pBqMobcgF/lRZiLwbxZOsw7ejQzRw8aRqunON7D11QMoV3Z+nB6Apmq9IBvUrWBSlH8zlnZmv8IVT+L8o1jKQ142bw85y1LE6l1XUq63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLcQJIC1S+0YSE6e4VtMV6Hwbg3ZflHxhmeLrgqULr0=;
 b=gqgZyfDTB0oEKdQQeP1TDLIikd4AQmwaSbyGr/EqvnbVrRUbyalw1sTHHM3IURMQa1ke9q7PqAYuFd7arvbeQaK40HuZP9LQOROPkdAAJd57rVaCh+8TAoGQpLYti4pbMHX9ul8c1RFA/a6NaYwFJsiRTEwKnZhAoYRHn90F7PU=
Received: from BL0PR02CA0113.namprd02.prod.outlook.com (2603:10b6:208:35::18)
 by MN2PR02MB5790.namprd02.prod.outlook.com (2603:10b6:208:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13; Fri, 20 Dec
 2019 08:38:04 +0000
Received: from BL2NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by BL0PR02CA0113.outlook.office365.com
 (2603:10b6:208:35::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.13 via Frontend
 Transport; Fri, 20 Dec 2019 08:38:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT042.mail.protection.outlook.com (10.152.76.193) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Fri, 20 Dec 2019 08:38:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iiDnO-0002PY-Rh; Fri, 20 Dec 2019 00:38:02 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iiDnK-000667-2h; Fri, 20 Dec 2019 00:37:58 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBK8blCY025271;
        Fri, 20 Dec 2019 00:37:47 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iiDn8-00065H-SM; Fri, 20 Dec 2019 00:37:47 -0800
Subject: Re: [PATCH] clocksource/drivers: Fix memory leaks in
 ttc_setup_clockevent and ttc_setup_clocksource
To:     Johan Hovold <johan@kernel.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?S=c3=b6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        emamd001@umn.edu
References: <20191220000923.9924-1-navid.emamdoost@gmail.com>
 <20191220051013.GT22665@localhost>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <3d72fe70-25fb-cdee-ac7d-bc1aa2ae5137@xilinx.com>
Date:   Fri, 20 Dec 2019 09:37:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220051013.GT22665@localhost>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(199004)(189003)(336012)(31686004)(70586007)(8936002)(9786002)(26005)(426003)(186003)(70206006)(5660300002)(4326008)(31696002)(44832011)(54906003)(2616005)(6666004)(356004)(81156014)(8676002)(478600001)(36756003)(110136005)(2906002)(316002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB5790;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6d9d3bd-ed15-4516-fdda-08d78527ee05
X-MS-TrafficTypeDiagnostic: MN2PR02MB5790:
X-Microsoft-Antispam-PRVS: <MN2PR02MB579059FB0DFC6194BB9E81C5C62D0@MN2PR02MB5790.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 025796F161
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5zTrcnlDfz6f3B3yamrrW11Mbf1sL/ItwNS7LyilJek2mgmryFV0zHjt85RUF3jeevEsvg7kp6tGHE7694QvpV2eGx3o0HDlJluL89stShezwZ8qxjhnfHKCrZHKtXH+NnwqyaBvD0nkFBYz0kuJA0eFt2tFxkQjShBoV1m7rwQMbeaWle7a6Q8xd5OW+p+QjAGLNhq8ZuwjmIRnY8FLR8L+jPe8aqDJyLRPQ9cpMJ0MU9bGZ0psMO4CzSAnZ0wIKgsxMQksxf0qr+1TkeYKHs4fmfqGg1lYUT5UAYV5g9HVvNoPMniuSDMFptyZmQRiKny7y25XDTfxUa6+ogertwF/OL0MuRi3F/Z5c/5O+eqV8GHZ2THcuLEj7052qoVvJ9nKx16kJ7zJGRG0xv+eTA72fzDTiHdCpYaNXVe7Pf9aSRN68M6xDyy4vQ1sL2d
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 08:38:03.8072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d9d3bd-ed15-4516-fdda-08d78527ee05
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 12. 19 6:10, Johan Hovold wrote:
> On Thu, Dec 19, 2019 at 06:09:21PM -0600, Navid Emamdoost wrote:
>> In the implementation of ttc_setup_clockevent() and
>> ttc_setup_clocksource(), the allocated memory for ttccs is leaked when
>> clk_notifier_register() fails. Use goto to direct the execution into error
>> handling path.
> 
> No, that memory was never leaked since that function did not return on
> registration errors before your patch.
> 
>> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> 
> Perhaps you meant to fix the actual leak that was added by this commit
> in a different function, ttc_setup_clockevent(), when returning on
> notifier-registration errors?
> 
> Also should the clock be left enabled on errors?
> 
>> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>> ---
>>  drivers/clocksource/timer-cadence-ttc.c | 22 +++++++++++++---------
>>  1 file changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
>> index c6d11a1cb238..46d69982ad33 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -328,10 +328,8 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>  	ttccs->ttc.clk = clk;
>>  
>>  	err = clk_prepare_enable(ttccs->ttc.clk);
>> -	if (err) {
>> -		kfree(ttccs);
>> -		return err;
>> -	}
>> +	if (err)
>> +		goto release_ttcce;
>>  
>>  	ttccs->ttc.freq = clk_get_rate(ttccs->ttc.clk);
>>  
>> @@ -341,8 +339,10 @@ static int __init ttc_setup_clocksource(struct clk *clk, void __iomem *base,
>>  
>>  	err = clk_notifier_register(ttccs->ttc.clk,
>>  				    &ttccs->ttc.clk_rate_change_nb);
>> -	if (err)
>> +	if (err) {
>>  		pr_warn("Unable to register clock notifier.\n");
>> +		goto release_ttcce;
>> +	}
> 

+ this is IMHO v3 version. It means just label it properly and also keep
changes log.

Thanks,
Michal

