Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E42AC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41702073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ELjyHWU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfDPLG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:06:28 -0400
Received: from mail-eopbgr60068.outbound.protection.outlook.com ([40.107.6.68]:20982
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726917AbfDPLG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/1DVeUh1+wbaTkeD4iIfu4Lt2JngN88qzssmoHptQs=;
 b=ELjyHWU/4aHxPP1sMwqBn89oow++XA8wFzu/POUx/pThm7+DoaTeobifxKSaaJo/lLq8yqyjIZzJ1yr7TB+J9A2xIfmOF4s7VyaLXNAZMIT/veoSH1L+pNvszFfw0XzneIslhHc815gwyM0WHGDN7Z6PcQzJK9HVXLcDpVHVHT4=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
 AM6PR05MB5624.eurprd05.prod.outlook.com (20.178.86.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Tue, 16 Apr 2019 11:06:22 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92]) by AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92%6]) with mapi id 15.20.1813.011; Tue, 16 Apr 2019
 11:06:22 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/cxgb4: fix null pointer dereference on alloc_skb
 failure
Thread-Topic: [PATCH] RDMA/cxgb4: fix null pointer dereference on alloc_skb
 failure
Thread-Index: AQHU9ERso+Yk52XNJEqqSJZt6k25ZA==
Date:   Tue, 16 Apr 2019 11:06:22 +0000
Message-ID: <20190416110618.GA15844@mellanox.com>
References: <20190413160026.5873-1-colin.king@canonical.com>
In-Reply-To: <20190413160026.5873-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB6PR0902CA0021.eurprd09.prod.outlook.com
 (2603:10a6:6:2::34) To AM6PR05MB4439.eurprd05.prod.outlook.com
 (2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.47.165.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f14c9808-c01a-48b4-4519-08d6c25b8f0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5624;
x-ms-traffictypediagnostic: AM6PR05MB5624:
x-microsoft-antispam-prvs: <AM6PR05MB56242D783FEB10B4B072AF85CF240@AM6PR05MB5624.eurprd05.prod.outlook.com>
x-forefront-prvs: 000947967F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(189003)(7736002)(102836004)(316002)(186003)(6512007)(4326008)(81156014)(6486002)(53936002)(81166006)(8676002)(36756003)(305945005)(99286004)(6246003)(26005)(33656002)(1076003)(54906003)(6506007)(386003)(478600001)(14454004)(3846002)(76176011)(2906002)(4744005)(105586002)(6116002)(52116002)(25786009)(86362001)(6916009)(71200400001)(71190400001)(5660300002)(97736004)(229853002)(11346002)(68736007)(476003)(486006)(2616005)(256004)(446003)(106356001)(8936002)(6436002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5624;H:AM6PR05MB4439.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hw0eohQuK72iDSoD/2Zli2vbDMSuAt80tRlvi4oaNt94HI9m2y1ZjtWMqkhs9XFz759qvTdX5Vtwwn8dTGsiCyPLRf/e/W7wbDMt05+4ZP3QHlSulW/mI3jrpy5tl3iEeTqHjM+usFM0uGB6eGuFLEOM4VyxTRdDDsJvrL2UWQKsqd87UCvNavOJvMqRj3s5WR6AN67PgPjZOLykA0mogq7Z0SxOzpCgWW1XChbjT4qyNW7kQ28sj4hf+e7kxG8bqYcRRGq2aiAbK5Vt7blg0XtEb3hwq10WuSNFfXjJxib62CLIWYRPodFfdye5nzZXD+OGKk1ePBC4SWwffvEuyL0rIZZO5R7AS4sDciyO8qSv+e9zVGgkFqpqa7forC94Rb430gvEg/k3qbg0c3QhQiLUDcG4Yrvmx9IFwpG9arA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3A441435B82E8A41B10EF6265175C80D@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14c9808-c01a-48b4-4519-08d6c25b8f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2019 11:06:22.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5624
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2019 at 05:00:26PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently if alloc_skb fails to allocate the skb a null skb is passed
> to t4_set_arp_err_handler and this ends up dereferencing the null skb.
> Avoid the null pointer dereference by checking for a null skb and
> returning early.
>=20
> Addresses-Coverity: ("Dereference null return")
> Fixes: b38a0ad8ec11 ("RDMA/cxgb4: Set arp error handler for PASS_ACCEPT_R=
PL messages")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Potnuri Bharat Teja <bharat@chelsio.com>
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to for-next

Thanks,
Jason
