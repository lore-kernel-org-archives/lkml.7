Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A04C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7130A20678
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 06:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n1zRxKLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfIMGEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 02:04:37 -0400
Received: from mail-eopbgr740087.outbound.protection.outlook.com ([40.107.74.87]:26136
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfIMGEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 02:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhA2rS6bO3AaeOCBAzoQYWuf1oXnxhJwm8cXN7KuB/ioVrymCNau5VxBv67EG3YkIQcNNAoHjtAh2kgN6/hTlYqH9P+ZoR5iFM7E2RLcbjyCrmDDgeIKOXIV0tFbKss5cZ72DLR9zFI2Glyf7zGsJ+cET/slJNB6euM2ZAnkcAxng5Gg0TMI86aMz+Pb53yghUCWGUhIarcTH/G+7SqwcDG++Wcg1d4RiAnA2luHDm0JZnrVl5AqFZwhRBjoSZ92NPLI3AkhSOR2wrCmw17yx5VmHyGcFY1knLol1QsjxztqN567xUpxvk3IbgxKyFfu+TLkeb7CdGvYCVlaGFjZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjM6+LD7uQOGfHffnz8qgTy+zHJearTCrIKSqOIHbq0=;
 b=fWdIhTImiSC5VHKvc+/aY/hRfMlUnhJaWDWhZElIJ0S7HCA60SfuQHrkjz+O6zrI1mlYjD6pZU7qmrCL7gKf3rdzsbPHQNXxf9chOeSoH6xO+FxBqxqRsH2go1azqAVGaaf8mMYhAH866rUmJiKKlwFm45JKqHtPX6fxxNy6dN+iymGgnhX9Lq/p9oprr22aPvXZH5j3di4XNVPpGHUhLBKOVSEaxdPJxGrPyO8X/m0R9OS6q80si4eJf22CjjVC4geFAPeidjOuN/+NmKocfDJbBDdKWf1m/D+i9A+4bC9CS0gNfR9r64gJ1H+TwfwBSuuVG1X2BIpqpOlTKqzyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjM6+LD7uQOGfHffnz8qgTy+zHJearTCrIKSqOIHbq0=;
 b=n1zRxKLDmmgRRK2YNgPDRPiRMqrCzL7RbUzdlCtsQJ2fUoLE4ZBCl9BA31HiyF8IgYqhFMKlE6aOapLeQrUOjKNw677hex1ErpvD+fezDya09vbYyrHNZrwsg5RH6erBRtOrTefwcbV8i7wSdnBYH+UVolMtxSA6cLk1jTjVnUo=
Received: from MWHPR0201CA0049.namprd02.prod.outlook.com
 (2603:10b6:301:73::26) by SN6PR02MB5262.namprd02.prod.outlook.com
 (2603:10b6:805:70::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.20; Fri, 13 Sep
 2019 06:03:54 +0000
Received: from SN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by MWHPR0201CA0049.outlook.office365.com
 (2603:10b6:301:73::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Fri, 13 Sep 2019 06:03:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT035.mail.protection.outlook.com (10.152.72.145) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 06:03:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:56459 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i8egT-0001nk-HS; Thu, 12 Sep 2019 23:03:53 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i8egO-0004He-Dq; Thu, 12 Sep 2019 23:03:48 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i8egF-0004Gt-1N; Thu, 12 Sep 2019 23:03:39 -0700
Subject: Re: Regression: commit c9712e333809 breaks xilinx_uartps
To:     Paul Thomas <pthomas8589@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <CAD56B7euf1kQpwOYiq-he8HveKKzkGdf8_-izEVfwa=QH24a3g@mail.gmail.com>
 <33ec2a52-91aa-6c4a-d900-1725f2970975@xilinx.com>
 <CAD56B7dvKtqQV9hkKEKB7VgoE8hqQGqMxHZiCXxg0sejUpsNCg@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a05ea4ae-05b0-402e-b8bf-763c49b30700@xilinx.com>
Date:   Fri, 13 Sep 2019 08:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD56B7dvKtqQV9hkKEKB7VgoE8hqQGqMxHZiCXxg0sejUpsNCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(58126008)(9786002)(6246003)(54906003)(36756003)(26005)(110136005)(316002)(229853002)(65806001)(65956001)(2906002)(356004)(106002)(70206006)(23676004)(47776003)(31686004)(70586007)(52146003)(2486003)(8676002)(478600001)(5660300002)(81166006)(476003)(44832011)(126002)(2616005)(36386004)(305945005)(426003)(486006)(446003)(230700001)(50466002)(4326008)(336012)(31696002)(81156014)(11346002)(76176011)(8936002)(186003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5262;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8155d786-e8d3-4163-85fe-08d738102824
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:SN6PR02MB5262;
X-MS-TrafficTypeDiagnostic: SN6PR02MB5262:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5262A438D533D04B2A1A7EAEC6B30@SN6PR02MB5262.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: yWw/TUeFRS88uP/oOihr3j1U4h9gyedDsuL271XUPW6P1IWH8yPIzKFoSRKW7nododLgmLEqMRKPES4OSV8H/pLqdH5UUfwerkcFrcK++GxaveKU8XWf7OoC/IiMftaTrV7f1BN8hK1zstTb8SA5Mmzlbwnx7Vq2YJbdoUxK0ZZ+1wSypWOx/NCaBNZhwoHA//3uuysj+W4sD2ClYqfwlDDUePdNdC3fLc0K0u1ZPguC5+/+y36bp0vYXfGUfzdzGEOnOL/GRksaIRLvt/5SkNPtK1/UsxBIXyCuEV8oOlZS/7/XC36XQhQqZMPNuDpHtjpdugtLt1FoAVl5g+o6Q6sdNbc4PdkdJ0VkX2oEBhUOW/YlyQ5J541KBJjQvUGFdsa2w2abrrvXNTAyHQXVDpYmB9fWwQYJfe9cgdtsYTw=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 06:03:53.9215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8155d786-e8d3-4163-85fe-08d738102824
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 09. 19 18:38, Paul Thomas wrote:
>>> ---
>>>  drivers/tty/serial/xilinx_uartps.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/xilinx_uartps.c
>>> b/drivers/tty/serial/xilinx_uartps.c
>>> index 9dcc4d855ddd..ece7f6caa994 100644
>>> --- a/drivers/tty/serial/xilinx_uartps.c
>>> +++ b/drivers/tty/serial/xilinx_uartps.c
>>> @@ -1565,6 +1565,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
>>>
>>>         cdns_uart_data->pclk = devm_clk_get(&pdev->dev, "pclk");
>>>         if (PTR_ERR(cdns_uart_data->pclk) == -EPROBE_DEFER) {
>>> +               /* If we end up defering then set uartps_major back to 0 */
>>> +               uartps_major = 0;
>>>                 rc = PTR_ERR(cdns_uart_data->pclk);
>>>                 goto err_out_unregister_driver;
>>>         }
>>>
>>
>> I expect that this can be problematic for all failures in probe.
>> What about this?
> Makes sense, this worked for me. Although, I think the patch is
> malformed by the email line lengths.

I just c&p. Let me send proper patch with description.

Thanks,
Michal

