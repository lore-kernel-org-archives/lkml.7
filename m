Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BEBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D452184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Nynjf/yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCQKFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 06:05:38 -0400
Received: from mail-eopbgr70055.outbound.protection.outlook.com ([40.107.7.55]:12647
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbfCQKFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 06:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kkuNje1scYVaPR9kYQxeLZ0ux8uXpCe8K/EMFu7U1o=;
 b=Nynjf/yjvvJeQFyLVAPdJrLIMHX4MPKuXVy4WOFls+uSUtf2iRWh0MXKb3GJpeMWImMHCyDRyzEgw2z21hsYIwx5ynE5U6AZXCvNcc9HAFNZeqIsoSuDH1YZNgdpsAN5DyYrAWbS0WY6qwPTnRvxQlEztWf7/2SMRHydYnVrduo=
Received: from HE1PR05CA0305.eurprd05.prod.outlook.com (2603:10a6:7:93::36) by
 AM0PR05MB4562.eurprd05.prod.outlook.com (2603:10a6:208:b0::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Sun, 17 Mar 2019 10:05:32 +0000
Received: from VE1EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::205) by HE1PR05CA0305.outlook.office365.com
 (2603:10a6:7:93::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1709.14 via Frontend
 Transport; Sun, 17 Mar 2019 10:05:32 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT057.mail.protection.outlook.com (10.152.19.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1730.9 via Frontend Transport; Sun, 17 Mar 2019 10:05:31 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 17 Mar 2019 12:05:30
 +0200
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 17 Mar 2019 12:05:30 +0200
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Sun, 17 Mar 2019 12:05:28
 +0200
Subject: Re: [PATCH] IB/iser: remove uninitialized variable len
To:     Colin King <colin.king@canonical.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190316230512.8933-1-colin.king@canonical.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <fe379614-5b0c-4063-2153-bd8a792d51c6@mellanox.com>
Date:   Sun, 17 Mar 2019 12:05:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190316230512.8933-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(136003)(39850400004)(396003)(346002)(2980300002)(199004)(189003)(36756003)(4326008)(106466001)(50466002)(23676004)(229853002)(2486003)(47776003)(65956001)(356004)(65806001)(6246003)(64126003)(8676002)(476003)(2906002)(478600001)(446003)(86362001)(336012)(316002)(58126008)(110136005)(81166006)(16526019)(65826007)(81156014)(486006)(11346002)(2616005)(76176011)(126002)(7736002)(305945005)(230700001)(26005)(77096007)(67846002)(31696002)(4744005)(53546011)(16576012)(3846002)(6116002)(8936002)(54906003)(5660300002)(106002)(186003)(31686004)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR05MB4562;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82e45f05-8439-429a-70b9-08d6aac0172f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4608103)(4709054)(2017052603328)(7153060)(7193020);SRVR:AM0PR05MB4562;
X-MS-TrafficTypeDiagnostic: AM0PR05MB4562:
X-Microsoft-Antispam-PRVS: <AM0PR05MB4562BF352F6D49B3F40AD00BB6460@AM0PR05MB4562.eurprd05.prod.outlook.com>
X-Forefront-PRVS: 09796A1B83
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: ZaoAlYQfTMOo8jLXZoT0X88+3LZNBmLzUWkSPg3Fzb/rhGBPqag0nK6NVbSi/rOF4Xc8KYiebhmEbJ4uy59kkygLIHcKfStLL6tRocyuG0L4yEKgLrwLtjpgQQ1u5H/XnXnKkmPna82zXFLt/YwRr62zDG/EizH3qfeCQhkT5VFLKYCK8AWNU5Q0wDD5qHqqycx9Gq0hIkWC0nv1zNUOz5BVtR/zdDVXruk3/dD73vvMS2L0+anagXeiTOCztoDpdJrWn/BCvO8WUzquKW9PEbwvXbhog8amYjN0+Q4TXO+kwbUdRVZLWjinzpqr0yEHHfZJxJrZXrK/EfVG1K3xCvUESTxihlvIrm4NS3yppodWQaBdTSyu8GZbHkxcQ97fkQYsD3g3b8ej9lc8SX/zik2KV/jbSM+RrZgZaTB7aBk=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2019 10:05:31.4938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e45f05-8439-429a-70b9-08d6aac0172f
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4562
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/17/2019 1:05 AM, Colin King wrote:
> From: Colin Ian King<colin.king@canonical.com>
>
> The variable len is not being inintialized and the uninitialized
> value is being returned. However, this return path is never reached
> because the default case in the switch statement returns -ENOSYS.
> Clean up the code by replacing the return -ENOSYS with a break
> for the default case and returning -ENOSYS at the end of the
> function.  This allows len to be removed.  Also remove redundant
> break that follows a return statement.
>
> Signed-off-by: Colin Ian King<colin.king@canonical.com>

Looks good,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

