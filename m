Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E26C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970EF20679
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 14:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="oL1OUoYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfGaOV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:21:59 -0400
Received: from mail-eopbgr810055.outbound.protection.outlook.com ([40.107.81.55]:55760
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbfGaOV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 10:21:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9w0DR6kbQZw7o6vhQCCkezcXTByJkyvzmpzNb00InnMrPtOV/3pjhj6p0qkreMDTXtoB1a+n6Fj2CVLDAjfN4C42bOvDJEgvaZ7auW6JhZBMLvsMU8KQFpO+PZFM+/4sudNOBydwt+vJ82+qGdGzdoy6jM6JbxTk1+Ci//faedDfAlAB13bU0zMp5mSGILaYw8PzdXPpSTxmTaC7fOw+wFYaUUDHVzc1isWnAq7barBE/4+DJIDj3AAyEjc5aOTOkKUxgIjaQ17l4z+cDUyT/lviMY7fIDG/rdibLsDAD5BZu+a54Vjn/bnuBnpH/a3y3z4KlgeglYepYroVTcTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuc7nMtsOHKN1fSsmKu6JYkIM6fxecETTtn6dneZuT4=;
 b=fwXOBfeMwW1/fN7BPd3/p2wKNsdFDdzVrvOdIygBVm3T7ssTFhX7kIXoci1hw9gnWBGeTKHiIYiFvSj9mTan53jFTkPtlQj+ynJb0TTW2psmc4xfHj0nbFB81no+/S4h/8EaBHirZ/j1wCXNBHyUX/dtLqQw0w0YLdZKn7uj9blPv9aN07OqLf0vwElJAUpgBrB+Ql3y4vlnlAGVYab8DXoo1rDnQB+Nwc9zyD7PL1v+M8vx1JUpU1XB0FxPLTEQiJUbSPUzxjmDqBo3uJN4lMTswbTql0CAjeKDEw6a/3P1195nBQqPrSEPRzgMgBn2gc+W4y2DA3OAw1NAohzhNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com
 smtp.mailfrom=xilinx.com;dmarc=bestguesspass action=none
 header.from=xilinx.com;dkim=none (message not signed);arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuc7nMtsOHKN1fSsmKu6JYkIM6fxecETTtn6dneZuT4=;
 b=oL1OUoYbJEbTSNwGQbkOmCTPk8GQrV86T3ALDZeLoi0GfEosnfxxS5mwdlVVuGDIwMfpAQvZVJplDgJFuXXqnvIR6AssCMgDEm2G6Jz2jBgwlVX3vLLblRAn3AHopDi683AW3EX/nm216YnGf4i6eVuA9lRhTeNv3qd+sxtxXN4=
Received: from DM6PR02CA0020.namprd02.prod.outlook.com (2603:10b6:5:1c::33) by
 SN6PR02MB4768.namprd02.prod.outlook.com (2603:10b6:805:90::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 14:21:54 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::202) by DM6PR02CA0020.outlook.office365.com
 (2603:10b6:5:1c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.16 via Frontend
 Transport; Wed, 31 Jul 2019 14:21:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2115.10
 via Frontend Transport; Wed, 31 Jul 2019 14:21:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hspUF-00007h-QE; Wed, 31 Jul 2019 07:21:51 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1hspUA-0001nF-O8; Wed, 31 Jul 2019 07:21:46 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x6VELatv030283;
        Wed, 31 Jul 2019 07:21:36 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1hspTz-0001mf-US; Wed, 31 Jul 2019 07:21:36 -0700
Subject: Re: [PATCH] mailbox: zynqmp-ipi-mailbox: Add of_node_put() before
 goto
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        jassisinghbrar@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190709172841.13769-1-nishkadg.linux@gmail.com>
 <eaf1fcbe-615e-0fec-d330-ae94e8f3c102@xilinx.com>
 <6a5306bd-946d-383f-0b42-f17675c24218@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <c0be80c9-16ef-fe03-ae3b-a7d3d1a2ede8@xilinx.com>
Date:   Wed, 31 Jul 2019 16:21:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6a5306bd-946d-383f-0b42-f17675c24218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(2980300002)(189003)(199004)(8936002)(70586007)(31696002)(36756003)(229853002)(446003)(14444005)(426003)(65826007)(11346002)(478600001)(47776003)(336012)(305945005)(50466002)(44832011)(126002)(476003)(486006)(2616005)(58126008)(110136005)(65806001)(316002)(65956001)(356004)(36386004)(106002)(81166006)(5660300002)(26005)(63266004)(53546011)(64126003)(52146003)(8676002)(186003)(81156014)(23676004)(2486003)(6246003)(2870700001)(9786002)(70206006)(15650500001)(31686004)(76176011)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4768;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac43783c-3db8-4527-2639-08d715c26f57
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:SN6PR02MB4768;
X-MS-TrafficTypeDiagnostic: SN6PR02MB4768:
X-Microsoft-Antispam-PRVS: <SN6PR02MB47686428574BF7EABCB9D935C6DF0@SN6PR02MB4768.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 011579F31F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 4gjmQrn0k49pBxD/QGYhwjP9BlEc0nrK9lx3N/rmSgrqCue81ml9lDCCm2Oiy1BPkZQaYACUaoZz56cxLuwgcTihxrURZgYHrK9Dh79JBMWYtBCwB1iKzquH9V5hs21XTko9qm/Tc+NFweL7jEfEhHR/X3oETghvNlUdfUHiedl0oGw3sjAOeR0RuNj4jy8HDuzcF7ACVBI3LdSmVAHUK6oFeDZNUpGg7Hj7d+zwHLWqB+sC7HdLltq4Smvi2JfcgImAYRx3kfloU6i6XLs6okFMLnNVJNl0C1exAyJFX2tVaWZFgas1z7No2k2eve/9ppsZPQ0r9xIo1Yis3F+HtAe/oHArY92RhLXyG2TU3O0KaPj5uFfIq8Avof3ZxkUKgOyK6DB16B9mnDoYwj/owpwsdEkeK7NyfPMqKp4wkKs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2019 14:21:53.0224
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac43783c-3db8-4527-2639-08d715c26f57
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 07. 19 15:06, Nishka Dasgupta wrote:
> On 31/07/19 2:01 PM, Michal Simek wrote:
>> On 09. 07. 19 19:28, Nishka Dasgupta wrote:
>>> Each iteration of for_each_available_child_of_node puts the previous
>>> node, but in the case of a goto from the middle of the loop, there is
>>> no put, thus causing a memory leak. Hence add an of_node_put before the
>>> goto.
>>> Issue found with Coccinelle.
>>>
>>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>>> ---
>>>   drivers/mailbox/zynqmp-ipi-mailbox.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> index 86887c9a349a..bd80d4c10ec2 100644
>>> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
>>> @@ -661,6 +661,7 @@ static int zynqmp_ipi_probe(struct
>>> platform_device *pdev)
>>>           if (ret) {
>>>               dev_err(dev, "failed to probe subdev.\n");
>>>               ret = -EINVAL;
>>> +            of_node_put(nc);
>>>               goto free_mbox_dev;
>>>           }
>>>           mbox++;
>>>
>>
>> Patch is good but when you are saying that this was found by Coccinelle
>> then it should be added as script to kernel to detect it.
> 
> This particular patch was suggested by a script I did not write myself;
> someone else wrote it and sent it to me. How should I proceed in this case?

You can ask him to submit it to kernel.
Or you can take it, keep his authorship and send it to:

./scripts/get_maintainer.pl -f scripts/coccinelle/
Julia Lawall <Julia.Lawall@lip6.fr> (supporter:COCCINELLE/Semantic
Patches (SmPL))
Gilles Muller <Gilles.Muller@lip6.fr> (supporter:COCCINELLE/Semantic
Patches (SmPL))
Nicolas Palix <nicolas.palix@imag.fr> (supporter:COCCINELLE/Semantic
Patches (SmPL))
Michal Marek <michal.lkml@markovi.net> (supporter:COCCINELLE/Semantic
Patches (SmPL))
cocci@systeme.lip6.fr (moderated list:COCCINELLE/Semantic Patches (SmPL))
linux-kernel@vger.kernel.org (open list)

Thanks,
Michal
