Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0921CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8991B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ECHMqoIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbfJVIv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:51:29 -0400
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:13098
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387961AbfJVIv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:51:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YEZnKuWNKG73R/8hQE4UoSS83Zf21pIt75Pgv9zoXJpzSd/VXE7ymf9IYV5bYh0kZF5953uoeU2bahoqtf+fAh3a8OUMhVKdhjPfgvNzs9MPtSeFIDvTXeJf9VM02O+NOR1uzdO59DBGsXFwJRVwlcuEfeNRK0OHXx8KzcPJibjMEU4keocJgmDwr/R4jkTFMEBMxKakZfYRVcD/07wCff4yrjxkDRK88Xjxc9TjghfnJQGjJGT20mmcW4xQqK6UUQPYUDHQytotd+axaIzSKPc+YMvMSq60fhwdNMGvXDHiNrtrZAa+q99I0IQwwbefp2K2IqVghAeEgnZ5QCgrUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56W45nPGUSRM1VFi2Z8YDVEVdGdyBXNSIhTK92cktVw=;
 b=NlegAizUS3apKtMMlHC52WYctT/Ah3n5rXIqJ1z/Iz6puAmQRcjc2Ia+rfw9Wu0FkW6dtsUpy+G+ePsPa8OsoeZsT4rt1cw3T7+NgpUxXr7g+bRxnaPlQK1icoOiz2vw190UI8yKTpg7/qawNVbaTGrY3BTexVYdQCpsR0AfxcLXuI5jTtuq2lfBhF8pbWMUAtJ+m2YaVCD9u4Yq40E/g0qpgB8fmeA8iSXWYZQIi1V6i9tbuZ/2C7mnbtIURzQAVKrThJ02/2wak5AudSz1cLCSWyKQrma8lbb6ezH23c2TOVGJ7g/uaBb9uE5OyKaxmaqXtLRgXt7fN5b8dgU6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linutronix.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56W45nPGUSRM1VFi2Z8YDVEVdGdyBXNSIhTK92cktVw=;
 b=ECHMqoIawE0FkeOAHbkticeGGhmbF1DWx6+vcTUSq8mWUTiqheZYUxTt3ExYI923gislAh/9et4sKizrT5Xp42TFdAy7wikq5epHOG373fGzx2klm4ZDadUqmLFsIVcX417j/cnIboNUVspER35E+vVjxE/lop/PLtXnoKO2zcM=
Received: from BN7PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:20::17)
 by BN8PR02MB5955.namprd02.prod.outlook.com (2603:10b6:408:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Tue, 22 Oct
 2019 08:51:23 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by BN7PR02CA0004.outlook.office365.com
 (2603:10b6:408:20::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.23 via Frontend
 Transport; Tue, 22 Oct 2019 08:51:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 08:51:23 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iMpsw-0002uh-Tp; Tue, 22 Oct 2019 01:51:22 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iMpsr-0002P5-RN; Tue, 22 Oct 2019 01:51:17 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iMpso-0002DK-JO; Tue, 22 Oct 2019 01:51:14 -0700
Subject: Re: [PATCH] clocksource/drivers: Fix memory leak in
 ttc_setup_clockevent
To:     Markus Elfring <Markus.Elfring@web.de>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20191021201848.4231-1-navid.emamdoost@gmail.com>
 <fb5d5331-9a89-8370-1e61-396dd05f291a@web.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
Date:   Tue, 22 Oct 2019 10:51:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fb5d5331-9a89-8370-1e61-396dd05f291a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(376002)(396003)(136003)(189003)(199004)(36756003)(126002)(23676004)(446003)(44832011)(47776003)(316002)(50466002)(486006)(356004)(426003)(476003)(6666004)(76176011)(2616005)(11346002)(336012)(36386004)(65806001)(54906003)(26005)(229853002)(2486003)(65956001)(8676002)(81156014)(81166006)(31696002)(186003)(7416002)(8936002)(966005)(2870700001)(478600001)(5660300002)(6306002)(106002)(9786002)(6246003)(2906002)(4326008)(110136005)(58126008)(31686004)(305945005)(70586007)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR02MB5955;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cf784a9-5f70-4fb5-1ecc-08d756cd0445
X-MS-TrafficTypeDiagnostic: BN8PR02MB5955:
X-MS-Exchange-PUrlCount: 2
X-Microsoft-Antispam-PRVS: <BN8PR02MB5955F28EA42CB7AFD3AEDFB5C6680@BN8PR02MB5955.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzYUZESoncFwqnQ7wPDWbdjjMVjAKIQX27d7J3FltOwQKLfjIgXZdrCMD3t+8vbdh6nkCma5IiSZ3uht2N7OdauivDdXrnGqfWAstujZeGhl8kaE3rLQARl7ZjF9kIlOL6mxbA5xh8oqGsiMF0h+oo/rN8wbqUYJQ+AJs61W7Q8OLAmFuw/8Y2KM047CzvLzU6ao8iJjFKtbEwbV4ffrn/pP/lcoZqo/VYar3KOB9DXEer/CLXuc3NGPhvK4ZAymeBcnCe2kt+9i4bLwDeOZlDyJUtkiqO9uOUWtnLjTtMBhyXucbtzQnTz4aM26MsJ8T1ePuYusf1qSUH4oLcO7A8gl7KVc7Hl7X1vVi7qs06Hd28wpIPsrQtIcHUAXT9/FIErVPW3vXQIJuhQB+93+cGxz/6yzbO3YcJbOQ846pxmejftf9kY2NMBh0eH0ywmOTfGJwbIynhhb9zm6BZINJQ==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 08:51:23.5006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf784a9-5f70-4fb5-1ecc-08d756cd0445
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5955
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 10. 19 10:26, Markus Elfring wrote:
>> In the impelementation of ttc_setup_clockevent() the allocated memory
>> for ttcce should be released if clk_notifier_register() fails.
> 
> * Please avoid the copying of typos from previous change descriptions.
> 
> * Under which circumstances will an “imperative mood” matter for you here?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=7d194c2100ad2a6dded545887d02754948ca5241#n151
> 
> 
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -424,6 +424,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>  				    &ttcce->ttc.clk_rate_change_nb);
>>  	if (err) {
>>  		pr_warn("Unable to register clock notifier.\n");
>> +		kfree(ttcce);
>>  		return err;
>>  	}
> 
> This addition looks correct.
> But I would prefer to move such exception handling code to the end of
> this function implementation so that duplicate source code will be reduced.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=7d194c2100ad2a6dded545887d02754948ca5241#n450

Just a note. Maybe you should also consider to fix this error path in
ttc_setup_clocksource() when notifier also can fail that there is no
need to continue with code execution.

Thanks,
Michal
