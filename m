Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318A1C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0603A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 22:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="deNzpoVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGAWuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 18:50:00 -0400
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:20965
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbfGAWuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 18:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxr9ve+pG365E35Pap88t0tzxc0hVMCk2wGueDeElqs=;
 b=deNzpoVEKum3LKsJN2IlwfQ8aIMiO3ubcLpjpHG18+/9a2MG08pM6+jDdo+PI+4ZwIlJoyf9sqagut9FG7RUAIz7kygPuf/pGmRI0ixuIr2+lqFLytMCkIN3XTjukawAJ3uELfzYdAqegSSm+CBmepWmF6lGUcY1n8wgjwG1eAs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6000.eurprd05.prod.outlook.com (20.178.127.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 22:49:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 22:49:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     wangxi <wangxi11@huawei.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lijun Ou <oulijun@huawei.com>
Subject: Re: linux-next: build failure after merge of the rdma tree
Thread-Topic: linux-next: build failure after merge of the rdma tree
Thread-Index: AQHVL8OActCQCeCYN0akJ9eSFAjYnKa1ZOUAgAD6KAA=
Date:   Mon, 1 Jul 2019 22:49:54 +0000
Message-ID: <20190701224950.GA23718@mellanox.com>
References: <20190701141431.5cba95c3@canb.auug.org.au>
 <bbd5fbc9-2dac-ae1b-7cae-68790b6ea878@huawei.com>
In-Reply-To: <bbd5fbc9-2dac-ae1b-7cae-68790b6ea878@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR0102CA0020.prod.exchangelabs.com
 (2603:10b6:207:18::33) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0386a983-3d83-4f11-753e-08d6fe766ed3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6000;
x-ms-traffictypediagnostic: VI1PR05MB6000:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR05MB600015DFAA12D6EBFFC53C8BCFF90@VI1PR05MB6000.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(199004)(189003)(256004)(4326008)(81156014)(6506007)(8676002)(81166006)(25786009)(7736002)(478600001)(229853002)(102836004)(66946007)(71200400001)(5660300002)(386003)(6486002)(446003)(71190400001)(73956011)(305945005)(316002)(33656002)(76176011)(26005)(186003)(1076003)(54906003)(64756008)(66446008)(66476007)(2906002)(8936002)(66556008)(6246003)(6306002)(4744005)(11346002)(486006)(53936002)(36756003)(2616005)(6512007)(52116002)(99286004)(966005)(6436002)(6916009)(14454004)(66066001)(3846002)(68736007)(6116002)(476003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6000;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SMrKB2lTma+NJAhViJPHup9cnr3v9+iGObH8cAUDaXoQADbHUXM/8ExXDfRze1E/yZ+gKO/NtbbdpBwNe6tcgY9JoVh7onjoK71Bc6ekEdhTCe6XfH6ejn5o1vS/1mL2dO6b0YKkJ12Tlt/TD7gf3hHwK9NHSnCrcI8/V3By7ruKTDLgbvfVHzdwdv6X8W8hol7wF4RZ/wSIloh+EKdh9e40f1rPamEFX9wIyPhUe2CDCf2q/+QAMSCEB+GVotzOQQ9CSrgXN4IMALzJkfygOWX1zB7FfiaXQQ5eNoL7/T4JtmxkgDIvO/CHoQdbQTscsD0X9qZgQn/6jaY17WGn678ANjP3fPw9aR91NxCcYQJgj+UMJxlmrlXkBSwlngVfg4q1MSrFEl8/et7w3SBXZIqi0mLHqhWA5cC4nLb8yQo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA77DEFE19AE89468A08F9AD106F07B2@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0386a983-3d83-4f11-753e-08d6fe766ed3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 22:49:54.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 03:54:30PM +0800, wangxi wrote:
> > Presumably caused by commit
> >=20
> >   e9816ddf2a33 ("RDMA/hns: Cleanup unnecessary exported symbols")
>=20
> I have confirmed the latest code in
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git.  I
> found that the changes to Makefile and Kconfig in the original patch
> have been lost.

What does that mean?

Commit e9816ddf2a33f3afdf3dfc35c21aafad389ee482 looks the same as=20
https://patchwork.kernel.org/patch/11003547/

To me

Please send a fixup patch.

This looks wrong:

obj-$(CONFIG_INFINIBAND_HNS) +=3D hns-roce-hw-v1.o $(hns-roce-objs)

Jason
