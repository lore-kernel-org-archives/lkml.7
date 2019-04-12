Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7418C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CA8218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="h2UQ3ZaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfDLTA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:00:28 -0400
Received: from mail-eopbgr130072.outbound.protection.outlook.com ([40.107.13.72]:6119
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbfDLTA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNNvjRNZ64QRUVFEXiIKBONT9CQa3VR1av0k5y9L5iY=;
 b=h2UQ3ZaH5XyK4Zj0gdMK7XYRZ9voWAIv0VMmQczVLKYf/B1IDZ18MYAXFAq9DQbO6az3UV7t6OM2W6KLAX1S6rTxnvil1Rrg6fvteKR80+H4J+tqeEb2GqRZ+y6lIxRuTZ6jdnfzEI3eFPTF5UHBLL4rvNaLyAzgVi7aU/Bdr+Y=
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com (52.135.162.148) by
 AM6PR05MB4104.eurprd05.prod.outlook.com (52.135.160.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.18; Fri, 12 Apr 2019 19:00:16 +0000
Received: from AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92]) by AM6PR05MB4439.eurprd05.prod.outlook.com
 ([fe80::24cd:a3f1:870b:bd92%5]) with mapi id 15.20.1792.009; Fri, 12 Apr 2019
 19:00:16 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Colin King <colin.king@canonical.com>
CC:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] RDMA/mlx5: check for error return in flow_rule
 rather than err
Thread-Topic: [PATCH][next] RDMA/mlx5: check for error return in flow_rule
 rather than err
Thread-Index: AQHU8WH3uEzTZqN650atlkTvnrBiiA==
Date:   Fri, 12 Apr 2019 19:00:16 +0000
Message-ID: <20190412142143.GA22222@mellanox.com>
References: <20190412104017.25507-1-colin.king@canonical.com>
In-Reply-To: <20190412104017.25507-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YTXPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::49) To AM6PR05MB4439.eurprd05.prod.outlook.com
 (2603:10a6:209:43::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [207.164.2.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4993a06d-fe3f-4f0e-61a3-08d6bf791946
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB4104;
x-ms-traffictypediagnostic: AM6PR05MB4104:
x-microsoft-antispam-prvs: <AM6PR05MB4104E9D7987DBFD34DF44764CF280@AM6PR05MB4104.eurprd05.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39860400002)(346002)(189003)(199004)(66066001)(6116002)(4744005)(1076003)(6486002)(68736007)(3846002)(305945005)(478600001)(229853002)(7736002)(486006)(36756003)(6512007)(71190400001)(476003)(14454004)(2616005)(256004)(14444005)(6436002)(2906002)(446003)(86362001)(11346002)(8936002)(97736004)(386003)(4326008)(76176011)(33656002)(105586002)(186003)(6246003)(54906003)(71200400001)(6916009)(316002)(81156014)(81166006)(106356001)(25786009)(99286004)(5660300002)(26005)(53936002)(52116002)(102836004)(6506007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB4104;H:AM6PR05MB4439.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ItxMvpi9ShQk2KCQMm984BY7g6/lzQO9Tr6Qxttj2tqW6jJzH4T0qB1VFeDAikXB7zvboG+5y1CHnoiiq3RoAJ/G78XjObuU6LdmOoV9LZuDsc4VswgRaPzosMUg5dOPdS3/jG5PKvMfAeJVnF3Fk3czXAnV0VTq9FMu+qxEUhYbCvlWCIb/rkJ5fFBoHbOfVWv1r9HrnUpHnyrzaSptyKu4djbmyNgAEZyL0Zk4QwI6IkCHCXMM1VTnyctogdZaRBI8xfe63tFY9BWZ7DWg7tjOgdEdlsSevd4cKFJ2jrNJlujBiGUb9UbPVe2+k9k3AJ+E+NfW9vbwVX9Wnjfl31+/NWlFwiUaGfXRV9N66xi5YisZuTLcW69iV30UuZ9Wh/acmW2hptAivBDwcO0DUyC+7KWVnFtsWYWp28rMRb0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <13CCEDE948459F429CB18B4A1A8DA5EB@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4993a06d-fe3f-4f0e-61a3-08d6bf791946
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 19:00:16.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:40:17AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently when the call to create_flow_rule_vport_sq fails, the error
> check is being performed on err rather than on the return pointer
> flow_rule.  The return flow_rule maybe NULL (which is not considered
> an error) or an error code, so check for the error on flow_rule.
>=20
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: d5ed8ac34cef ("RDMA/mlx5: Move default representors SQ steering to=
 rule to modify QP")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
