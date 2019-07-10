Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095CC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFC920693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="UCVfirEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfGJIyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:54:19 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:35623
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726695AbfGJIyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjyT/+L+T/ZvR/I42bhYm8OUoAouD8gsXx3xkSetZrU=;
 b=UCVfirEtCRwOimoF+11IGBGS84WmpGQfCawPZVQgSNv10NXACyAF9SMW6nuwcHPtFG/H8kXtYvkCf5sMmH9v2OyniwSGsjlc6NNTldg5QBJefQhGhLcX8Wt7jb55UBiJDqB3Ap0rwhKmtEOQycpPD7/Zifz6FDD0yvD2wcZUO2A=
Received: from AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19)
 by AM0PR0502MB3972.eurprd05.prod.outlook.com (2603:10a6:208:8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2052.18; Wed, 10 Jul
 2019 08:54:15 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by AM3PR05CA0141.outlook.office365.com
 (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2052.18 via Frontend
 Transport; Wed, 10 Jul 2019 08:54:15 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; kalray.eu; dkim=none (message not signed)
 header.d=none;kalray.eu; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.134 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.134; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.134) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2052.18 via Frontend Transport; Wed, 10 Jul 2019 08:54:14 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 10 Jul 2019 11:54:13
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 10 Jul 2019 11:54:13 +0300
Received: from [10.223.3.162] (10.223.3.162) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.301.0; Wed, 10 Jul 2019 11:53:40
 +0300
Subject: Re: [PATCH v2] nvme: fix multipath crash when ANA desactivated
To:     Christoph Hellwig <hch@lst.de>
CC:     Marta Rybczynska <mrybczyn@kalray.eu>, <kbusch@kernel.org>,
        <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Samuel Jones <sjones@kalray.eu>,
        Jean-Baptiste Riaux <jbriaux@kalray.eu>
References: <1575872828.30576006.1562335512322.JavaMail.zimbra@kalray.eu>
 <989987da-6711-0abc-785c-6574b3bb768c@mellanox.com>
 <20190709212904.GB9636@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <0d113713-0198-0dc2-2a8f-a9fbcabbf05a@mellanox.com>
Date:   Wed, 10 Jul 2019 11:53:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709212904.GB9636@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.223.3.162]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(199004)(189003)(11346002)(7736002)(67846002)(478600001)(336012)(16526019)(26005)(65826007)(186003)(31686004)(47776003)(3846002)(446003)(316002)(2616005)(58126008)(54906003)(14444005)(50466002)(16576012)(8676002)(476003)(126002)(81156014)(70586007)(70206006)(486006)(86362001)(31696002)(6916009)(36756003)(230700001)(2906002)(6246003)(76176011)(6116002)(65956001)(65806001)(8936002)(229853002)(356004)(64126003)(5660300002)(23676004)(2486003)(305945005)(81166006)(53546011)(106002)(4326008)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0502MB3972;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:mail13.mellanox.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24efeae-0d16-4235-ca11-08d705142f52
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328)(7193020);SRVR:AM0PR0502MB3972;
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3972:
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3972A4DC6449927E2FD9F995B6F00@AM0PR0502MB3972.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0094E3478A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 8AVHLRJZ+EBqNXvqm95HKz+YLkEOVj24bng4j98NvFwHhqdC4CxewlJuCU0cR6dDu2U9d1//typloprPQkx74zCm6LoKmEFUxUO3aUW3SrcWpTmsnPOG8T3JrVyoGkrJG7z5HheWu1PZofHphTb8hYmFeJNjJOQuZhbJvumTQSBK3I2VhElFF22PliQM3jKKrT1rLRM2IESrD4Ywuy4hqSpj5vZrpi0RoSoU1gAcPZuEqROgsuShGm99+mu2a21/11zTLfEz6Xdl+iMsJvCnWLK8UIcAE5FV80u2iOeouL86uJy2owe6tn2Uq/LH7B/LOQBn7pPZP44KKBe9auxO+H+V98Y8UZwDq1tFvU43dWWf9iOYqFHYDAxgIcnW/iTST8aWpezYYlqk94NfBbbSg//VpuCy/qXB7t3yvfG+1Ok=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2019 08:54:14.3911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24efeae-0d16-4235-ca11-08d705142f52
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3972
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/10/2019 12:29 AM, Christoph Hellwig wrote:
> On Sat, Jul 06, 2019 at 01:06:44PM +0300, Max Gurtovoy wrote:
>>> +	/* check if multipath is enabled and we have the capability */
>>> +	if (!multipath)
>>> +		return 0;
>>> +	if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) != 0))
>> shouldn't it be:
>>
>> if (!ctrl->subsys || ((ctrl->subsys->cmic & (1 << 3)) == 0))
>>
>> or
>>
>> if (!ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>>
>>
>> Otherwise, you don't really do any initialization and return 0 in case you have the capability, right ?
> Yes.  FYI, my idea how to fix this would be something like:
>
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index a9a927677970..cdb3e5baa329 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -12,11 +12,6 @@ module_param(multipath, bool, 0444);
>   MODULE_PARM_DESC(multipath,
>   	"turn on native support for multiple controllers per subsystem");
>   
> -inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> -{
> -	return multipath && ctrl->subsys && (ctrl->subsys->cmic & (1 << 3));
> -}
> -
>   /*
>    * If multipathing is enabled we need to always use the subsystem instance
>    * number for numbering our devices to avoid conflicts between subsystems that
> @@ -622,7 +617,7 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   {
>   	int error;
>   
> -	if (!nvme_ctrl_use_ana(ctrl))
> +	if (!multipath || !ctrl->subsys || !(ctrl->subsys->cmic & (1 << 3)))
>   		return 0;
>   
>   	ctrl->anacap = id->anacap;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 716a876119c8..14eca76bec5c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -485,7 +485,10 @@ extern const struct attribute_group *nvme_ns_id_attr_groups[];
>   extern const struct block_device_operations nvme_ns_head_ops;
>   
>   #ifdef CONFIG_NVME_MULTIPATH
> -bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl);
> +static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->ana_log_buf != NULL;
> +}
>   void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   			struct nvme_ctrl *ctrl, int *flags);
>   void nvme_failover_req(struct request *req);

Yes this looks good.

