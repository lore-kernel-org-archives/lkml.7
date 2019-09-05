Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189FAC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5734320820
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="P4PlfczS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389998AbfIEO70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:59:26 -0400
Received: from mail-eopbgr10087.outbound.protection.outlook.com ([40.107.1.87]:20961
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389796AbfIEO7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:59:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJG/RmHCU8QVlBLTyMNS9UbZrUVIZdzzcO1bxHs+6pjeiKkIwImYDZSmplbIy8YQai7MEG0pD+M6siWU1B8xt0gZXv7II0bmoiNu0FwMbnhKCvPquXAtW9fB/epvpqsYwUxjU8jE528MfllUONT1GFtRt01cP9FF0J698jbB397MezxWFZwpHnCg7H3Jm5JoNcda9HX6nnmR9tA5GiOCMy9+593mxaYBK2nEfDVzsPo99imDmf6Py3ZudFQ3tg8qLPjMC0xeJsMf2TQHGNiwcA7B2SuVr7OHtrL/RPDkJs1yDWwqWjtOfAoQhLPXtR87tZgNv+g1t03x2VvcTLj2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3LyS/fFg3B09znDYfF104ADRjye99Nudxy8r+bYK9s=;
 b=MIcRopL8QcgGHGuuryEpjF0MMIOC6xPIsxLYXYO7XiFj4lXegbektxi/LZ4EuOSscAmE2owoqZFY1PkLLnDqZUB2jz8ktI8FwQkrE19Q2IQOr+IWcVmD4Ye8gp3yoDP9xxM3/YNedgTl1DFKnql8fGeKd6HjP2LAIoOXY27d2uXMu+/JPSCi9SiWlXf3mhYm//L6oYsDxS6bxFgjd6lYVUfgKVJ7/sW4qBgE70bZZyI2994EUcUcEDk5EgS0QoR9469ZEs3+UT1ZonSekcXCcNVDuFQ8YmcnILP5F4bnIIO4V8+yEwTKkesF3AGdbpBgHxWZoW0AUqaB9dt4Lr5TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3LyS/fFg3B09znDYfF104ADRjye99Nudxy8r+bYK9s=;
 b=P4PlfczSEP0VgiBzZd8mfnT592NDK2mpqme8eHlFYXKqGC2OE6A3Tpx12WUoFuTfyVkFlW/tXZGclxyVOescdYeiLHObIRtuXHtodq8u7V+7LWV5VR4lbMkoa+N8NHCWppppcN+QDkLWUsp035OrsEaZ1KvtYu2PWu+Iiz3ujyI=
Received: from VI1PR0502CA0033.eurprd05.prod.outlook.com (2603:10a6:803:1::46)
 by VI1PR0502MB2959.eurprd05.prod.outlook.com (2603:10a6:800:b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19; Thu, 5 Sep
 2019 14:59:21 +0000
Received: from DB5EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::200) by VI1PR0502CA0033.outlook.office365.com
 (2603:10a6:803:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.14 via Frontend
 Transport; Thu, 5 Sep 2019 14:59:21 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT015.mail.protection.outlook.com (10.152.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Thu, 5 Sep 2019 14:59:21 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Thu, 5 Sep 2019 17:59:20
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Thu,
 5 Sep 2019 17:59:20 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 5 Sep 2019 17:59:18
 +0300
Subject: Re: [PATCH] nvme: tcp: remove redundant assignment to variable ret
To:     Colin King <colin.king@canonical.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190905143435.2864-1-colin.king@canonical.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <105245d1-26b7-2e4d-0aad-0ba1b6fe323c@mellanox.com>
Date:   Thu, 5 Sep 2019 17:59:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905143435.2864-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(189003)(199004)(58126008)(6246003)(230700001)(54906003)(336012)(76176011)(65806001)(110136005)(16576012)(36756003)(305945005)(486006)(23676004)(2486003)(316002)(70586007)(70206006)(7736002)(106002)(2616005)(11346002)(4326008)(4744005)(53936002)(6116002)(65956001)(53546011)(31686004)(476003)(478600001)(126002)(356004)(8676002)(81156014)(81166006)(86362001)(229853002)(50466002)(14444005)(5660300002)(186003)(8936002)(3846002)(2906002)(31696002)(26005)(446003)(47776003)(16526019)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB2959;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7deec5ce-5ea8-467a-75af-08d73211a243
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0502MB2959;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB2959:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB29592BA238D56300E8EA74CBB6BB0@VI1PR0502MB2959.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: LX51A4y3qvAA/Cpq3+CDe8Xdf8aWPgn5O9UHNrVSXhntX1fwqVVvByFDbGDYf/5/mSRqOnPzrJOiDriuR0jCj/fpkNGeHNPk5h0HhKLPC/RJPKDB6mJ3hhVEmS2m+xzmikKMU5CRynIhPVxwl/3l4kmy+okDFJKL2cpcMlequfvbHQvac+XQ9hi1s6VbBvR5lbOdBBtDywM60JypNBiKF29gNeazUwbr6LWY53dqNMCj2tmONkbsYcgPP7N/Fn/ZkEXIN18Ge06HSFeuKBRi0BUaHey1KoORiYYMuc8uM24wtIkd9Q1yl8tYlkRm3N2Sd7jVKMRghDbKgmgd7+3JdNfOhOomml+otvmrOSR6GltuBGuHLll8Xz4t3YfREIutSK6PuKq5uXSy9w9Y6HJ0g7qPOGN6yE/uvqOifOFcs8Q=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 14:59:21.2255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deec5ce-5ea8-467a-75af-08d73211a243
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB2959
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2019 5:34 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ret is being initialized with a value that is never read
> and is being re-assigned immediately afterwards. The assignment is
> redundant and hence can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/nvme/host/tcp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 2d8ba31cb691..d91be6ddfe25 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1824,7 +1824,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
>   static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
> -	int ret = -EINVAL;
> +	int ret;
>   
>   	ret = nvme_tcp_configure_admin_queue(ctrl, new);
>   	if (ret)

Looks fine,

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

