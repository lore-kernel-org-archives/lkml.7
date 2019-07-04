Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F25C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0E62083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="asNCceim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfGDVAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:00:33 -0400
Received: from mail-eopbgr30053.outbound.protection.outlook.com ([40.107.3.53]:38841
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbfGDVAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNoVJAHO6CRRSlhcEfj5pkXhMHyt97i6+nT/6eVep1w=;
 b=asNCceimTc2R0s4DaDCRfFRoMO0BlwTnVZ7ioQGBHlYQT3OQoiGsM5mTo6AvTnendl5GPf0W/OTXyYU6hD2OjT9zwzgjhqqO3kEaGVB26hXkNG+t9w89ZztdAalnMv9rUM4t32dj0wrihOC4iDVaPMBP5bWt59CH9wv27opx79o=
Received: from AM3PR05CA0105.eurprd05.prod.outlook.com (2603:10a6:207:1::31)
 by AM0PR05MB5074.eurprd05.prod.outlook.com (2603:10a6:208:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2032.20; Thu, 4 Jul
 2019 21:00:30 +0000
Received: from VE1EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM3PR05CA0105.outlook.office365.com
 (2603:10a6:207:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.17 via Frontend
 Transport; Thu, 4 Jul 2019 21:00:30 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT045.mail.protection.outlook.com (10.152.19.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Thu, 4 Jul 2019 21:00:29 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 5 Jul 2019 00:00:28
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 5 Jul 2019 00:00:28 +0300
Received: from [172.16.0.91] (172.16.0.91) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Fri, 5 Jul 2019 00:00:27
 +0300
Subject: Re: [PATCH v2 1/2] nvmet: Fix use-after-free bug when a port is
 removed
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Sagi Grimberg" <sagi@grimberg.me>
CC:     Stephen Bates <sbates@raithlin.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-2-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <786259e6-ffed-8db3-74d0-71ed5a760079@mellanox.com>
Date:   Fri, 5 Jul 2019 00:00:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703230304.22905-2-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.91]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(136003)(39860400002)(346002)(2980300002)(199004)(189003)(58126008)(126002)(70586007)(70206006)(110136005)(230700001)(486006)(31696002)(5660300002)(2906002)(4744005)(316002)(106002)(6246003)(229853002)(2201001)(67846002)(8936002)(86362001)(31686004)(4326008)(186003)(336012)(53546011)(50466002)(23676004)(2486003)(81166006)(8676002)(81156014)(7736002)(64126003)(356004)(305945005)(16526019)(11346002)(6116002)(16576012)(65806001)(47776003)(2616005)(65956001)(476003)(3846002)(446003)(26005)(76176011)(77096007)(65826007)(36756003)(478600001)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB5074;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0403bc53-9b1d-4b27-436d-08d700c2a59c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM0PR05MB5074;
X-MS-TrafficTypeDiagnostic: AM0PR05MB5074:
X-Microsoft-Antispam-PRVS: <AM0PR05MB507419A1E085470A5481608CB6FA0@AM0PR05MB5074.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-Forefront-PRVS: 0088C92887
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: DMWAXPPGArpM+aYbCvW99zK0kkGFn5244u6nsJE0BSwp39Nev15V0nf91Emynsq9Z2nbjHGsDB/MaR2laEJueiJH8+5N3K3jW60zPn/rb7GWooVls3M3MzLt4lYOGVDq4F7CQfWSCFGOs6s0o6evm+Bc/2ULBc1C4rl8zzW+S++21vDBQQbkZ4AwenSPA8zJ244s/fnALh9i30wxdptcTCGUQ87HcFNzFTIqvrldPtLxwQeR7MMICM52bhrcNjwM21s7f0mXQC7p0IYOpB/Riqr4TwWcbD3xv1LYA+3ZYwmc4LNQIKTXZpM0LiXL0hnOGFnSECUhx8NyIxjKY7wzWW26wrqx1VpXEk2qcQce+akCZBgDIDI7gpxYsCjh7g7acdlBKZkN4BqlTuA3Gv7XaGzqGz+koSZnajV1euQKDhU=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2019 21:00:29.5569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0403bc53-9b1d-4b27-436d-08d700c2a59c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
> When a port is removed through configfs, any connected controllers
> are still active and can still send commands. This causes a
> use-after-free bug which is detected by KASAN for any admin command
> that dereferences req->port (like in nvmet_execute_identify_ctrl).
>
> To fix this, disconnect all active controllers when a subsystem is
> removed from a port. This ensures there are no active controllers
> when the port is eventually removed.

so now we are enforcing controller existence with port configfs, right ? 
sounds reasonable.

Did you run your patches with other transport (RDMA/TCP/FC) ?


