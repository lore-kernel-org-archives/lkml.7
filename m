Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C4C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEE02146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fTrln1Vx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfLQPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 10:10:13 -0500
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:6211
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727384AbfLQPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 10:10:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/8O/Pg1WUfidmmlyh2Fl29zboEg8LY2zqemvv55gNpg1XR/jCcqTpIwKAQZvo6JUZCmIjoQEc4VsW9/gIPmCo82Z9nvbO85eMBE/TmIqUIJz0dN0E2UUxK2l7ZuA2u+TLlKc6H/W9cpqWsIbDbcoSDYLq9c9NYahRmiFk2EUrKQHhiVZ4grMD9e7nX4/zUnLkGNRKrDJzDiWrNFuzZR+MSXRM25jgrD83VBWh6zWTNDHC/jwAPBb7a2kHPJ9kqyZK+Qp36H8Hsw62BpURbNNx1E/13AxCweuO4MRftWONRPFGbWLovo3AHowT752WO/GWKXfpYP2ekm7zU43AYsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnxs+AqOKWiciRH6hd4oTxx7mhTYdlElqpx3JVVf670=;
 b=e0Tp6lMCOaG2T9bFSI5qnW5QtwDd69WSmuOMBuFXOQxL7tjOIA5/Oyqmx57NCwaaAtGtloWAshQJxDqZAIPJRsE3REbonwegyV/iOT1am3XYIrn5bdkhlHlyZMI6ZNcXU/LoXdZguT8FC0D4APL1VuuzL5s6Tojy49suCxOzF22fXkZNL29zdO3c08DlIgjXx6O27ZcoCIJbpKjxyaX8wOwJpO2oSXrY1b+5Yg7a1z+fweS7f7GRpHXXRasCMfLaYlyd18pKWJmcjGtsH6wR02zJzHPqlkeIkWJ6uNtsXpX47EGm0QBDaF5lfEYMbK2dU93dSUcthgkd9Hn3vVar6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnxs+AqOKWiciRH6hd4oTxx7mhTYdlElqpx3JVVf670=;
 b=fTrln1VxlkToffk70hwgMOv3xldI9rQlMEKL+HBOOk5ohLlE2Zg7SlASIhhjVtFjMnwXCjOfUXokdxwgPUkfLAZv34fhCcRD6VD9dnlpWgudAcmEOW6cqbsrQS5IVt7QuJaPlZvP7KjiD3nlTcu2W1G5ToYN0F0mYy90RKvTD7s=
Received: from CY4PR01CA0021.prod.exchangelabs.com (2603:10b6:903:1f::31) by
 BYAPR02MB5480.namprd02.prod.outlook.com (2603:10b6:a03:9a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.16; Tue, 17 Dec 2019 15:10:04 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::b8) by CY4PR01CA0021.outlook.office365.com
 (2603:10b6:903:1f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Tue, 17 Dec 2019 15:10:04 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Tue, 17 Dec 2019 15:10:03 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihEU7-0000xT-BT; Tue, 17 Dec 2019 07:10:03 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ihEU2-0004H5-86; Tue, 17 Dec 2019 07:09:58 -0800
Received: from xsj-pvapsmtp01 (mail.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id xBHF9uXI000328;
        Tue, 17 Dec 2019 07:09:56 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1ihETz-0004Gq-PJ; Tue, 17 Dec 2019 07:09:55 -0800
Subject: Re: [PATCH] clocksource/drivers: Fix error handling in
 ttc_setup_clocksource
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
References: <2a6cdb63-397b-280a-7379-740e8f43ddf6@xilinx.com>
 <20191023044737.2824-1-navid.emamdoost@gmail.com>
 <CAEkB2ETvi=Zryh+3UnSddrprnB+MzSObAbsms+6LHHLuiRwZjw@mail.gmail.com>
 <26da3a6b-60f3-d09b-6eff-7a3db8234d64@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ff7aa6a0-3cfd-dab3-f187-7b93131378db@xilinx.com>
Date:   Tue, 17 Dec 2019 16:09:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <26da3a6b-60f3-d09b-6eff-7a3db8234d64@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(44832011)(2616005)(70206006)(70586007)(2906002)(5660300002)(4744005)(9786002)(336012)(356004)(426003)(186003)(31686004)(36756003)(53546011)(478600001)(26005)(8936002)(31696002)(316002)(110136005)(54906003)(4326008)(81166006)(81156014)(8676002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5480;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c81bdcc-e28f-4972-ed79-08d7830331c5
X-MS-TrafficTypeDiagnostic: BYAPR02MB5480:
X-Microsoft-Antispam-PRVS: <BYAPR02MB54800BCD6882887FA8369AB5C6500@BYAPR02MB5480.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 02543CD7CD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxknuBnoPeiI4gCj9QupBEpAcXuQJ5+Yr4p3bWoacz4J+WpTjQJS61CCmEhNrD7Lg/Kb1CUaFCpxPoREq+dJnN/V/AYrturc4jY0v4R2vwBTkqBM8sObq3FCznc/uOxYfAUbDABuguedX1Q68cfP08RDyIlMY88Y2X3WWykNAn2QXcThOQy62mzkBUeozF8F0Iu16uR3ignJO8YB/0lLu+vnkrwJ13SvCTSiZj8uWwDPevuZ+HhYEjdP4xiOUrSUOt8YrgSl5ImDgR8xmeSsxy/xeTG5WBJIrk+3gJULh+EZ/nUGKdJhGd/FEc7fxobssRYR8eRuBQCsN/qIar+fW98ywzc8uKsU+xJ/oYZSHq7Jm91vZhXf4Z+6rfXkPDj5XeOdWAsQGnK2K+q5hXhGoluDx4B1x64SSdL/0SqD7EQjV6WZZymJxwZjtUKN+/PokI+pk5c9p4YK/Ro/aCGnyJIxphc5W8PnmcW3Hj00kuku413xWQKvd2BWgGnxQW+u
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 15:10:03.8109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c81bdcc-e28f-4972-ed79-08d7830331c5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5480
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16. 12. 19 14:41, Daniel Lezcano wrote:
> 
> Hi Navid,
> 
> On 14/12/2019 23:54, Navid Emamdoost wrote:
>> Would you review this patch, please?
> 
> please fix the version number, send without in-reply-to.
> 
> Do the same for the other patch:
> 
> clocksource/drivers: Fix memory leak in ttc_setup_clockevent
> 
> It is a bit confuse what patch is ok or not.

+1 on this. And patch looks good to me but as I said before the same
changes should be done also in ttc_setup_clockevent. It means v2 with
these two things together is the best way to go.

Thanks,
Michal
