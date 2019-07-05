Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3EDC4649B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DCDD216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ifB+RvhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbfGEMUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:20:39 -0400
Received: from mail-eopbgr50066.outbound.protection.outlook.com ([40.107.5.66]:48257
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbfGEMUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nedWuy/27H1a+ingUAprQRS6TMjCVkFTEoHNByrPO+I=;
 b=ifB+RvhWNe5HYvkjhzQkYocNwec6QRq0UQfd34Q9xfF8+sXjNIbpybKJaCFGm39hG6HOMBxA+yHnjLfCSMQQSarbdLKSgRJrAkfTUFO6iqoIqz1QK3uhadh724GyoCgudIyVDT4K31hxhrRpLIkSg12BEMSmeT+IorC9ydHM06A=
Received: from HE1PR05CA0297.eurprd05.prod.outlook.com (20.176.160.156) by
 DB3PR0502MB3977.eurprd05.prod.outlook.com (52.134.70.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 12:20:34 +0000
Received: from VE1EUR03FT042.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by HE1PR05CA0297.outlook.office365.com
 (2603:10a6:7:93::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.19 via Frontend
 Transport; Fri, 5 Jul 2019 12:20:34 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 VE1EUR03FT042.mail.protection.outlook.com (10.152.19.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Fri, 5 Jul 2019 12:20:33 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 5 Jul 2019 15:20:31
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Fri,
 5 Jul 2019 15:20:31 +0300
Received: from [172.16.0.102] (172.16.0.102) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Fri, 5 Jul 2019 15:20:31
 +0300
Subject: Re: [PATCH v2 2/2] nvmet-loop: Flush nvme_delete_wq when removing the
 port
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "Sagi Grimberg" <sagi@grimberg.me>
CC:     Stephen Bates <sbates@raithlin.com>
References: <20190703230304.22905-1-logang@deltatee.com>
 <20190703230304.22905-3-logang@deltatee.com>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <bbbfdcda-5acc-a02c-565a-929180ab6c0c@mellanox.com>
Date:   Fri, 5 Jul 2019 15:20:30 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190703230304.22905-3-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.102]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(64126003)(229853002)(3846002)(6116002)(77096007)(16526019)(186003)(356004)(86362001)(7736002)(486006)(2201001)(476003)(478600001)(8676002)(81166006)(230700001)(65826007)(81156014)(4326008)(446003)(2616005)(305945005)(8936002)(126002)(11346002)(23676004)(2486003)(106002)(6246003)(31686004)(76176011)(53546011)(31696002)(16576012)(67846002)(58126008)(110136005)(316002)(65806001)(47776003)(26005)(14444005)(2906002)(70206006)(70586007)(50466002)(336012)(5660300002)(36756003)(65956001)(3940600001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0502MB3977;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caa205c8-ec5e-4c25-319e-08d701432da4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:DB3PR0502MB3977;
X-MS-TrafficTypeDiagnostic: DB3PR0502MB3977:
X-Microsoft-Antispam-PRVS: <DB3PR0502MB3977211A03BFF00FE5192854B6F50@DB3PR0502MB3977.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 008960E8EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 3d3uzSNvC9su4jASWxDwHJAKJOhOFmpbS0xwRpJSaQyaEfbo7n9k08gtyywmQBc/mn5k15A2jGBPeIRZfqq7PJvQTGuzpLlcAed75ll6imTma0bJrOV44ph47+wCvRCOqVAjaHEeWeOjGrwMGEMmiWyVb/vEfStLSttEnOhYKJyFW0w2TMk7YPcBDt2lIRDCqQX5bP+d+T9Ekopi9//NUhZ7c2uPGi0Hu6UUn7UI4dtNrHyv3zbZ1MsEZIp3nj5aa+EIbcCKrfc7DmJ0agXtntamCMY4JosU6e/4zq/DsiXA23/Ks97+IrVcyc/AE1zEFz0KAlzyHpEY3SowpgVsk4XmR0OHZgSU+9wP1EBcVwg95NJ5Qc/GlXSDVg5NTszvUh00weby0jNH6SR5so7vHNao9tZoehVPGn88qWKiEG0=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2019 12:20:33.3143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa205c8-ec5e-4c25-319e-08d701432da4
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0502MB3977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/2019 2:03 AM, Logan Gunthorpe wrote:
> After calling nvme_loop_delete_ctrl(), the controllers will not
> yet be deleted because nvme_delete_ctrl() only schedules work
> to do the delete.
>
> This means a race can occur if a port is removed but there
> are still active controllers trying to access that memory.
>
> To fix this, flush the nvme_delete_wq before returning from
> nvme_loop_remove_port() so that any controllers that might
> be in the process of being deleted won't access a freed port.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   drivers/nvme/target/loop.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index 9e211ad6bdd3..da9cd07461fb 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -654,6 +654,14 @@ static void nvme_loop_remove_port(struct nvmet_port *port)
>   	mutex_lock(&nvme_loop_ports_mutex);
>   	list_del_init(&port->entry);
>   	mutex_unlock(&nvme_loop_ports_mutex);
> +
> +	/*
> +	 * Ensure any ctrls that are in the process of being
> +	 * deleted are in fact deleted before we return
> +	 * and free the port. This is to prevent active
> +	 * ctrls from using a port after it's freed.
> +	 */
> +	flush_workqueue(nvme_delete_wq);
>   }
>   
>   static const struct nvmet_fabrics_ops nvme_loop_ops = {

Looks good:

Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

