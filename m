Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F84C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593F0206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CD7DDxip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbfG3Mdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:33:46 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:6304
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726986AbfG3Mdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:33:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duZqtWSBY97V/rluhGAmN//dTbA+13SADWRK91Io7QHY/ofM9u4mHxxXAtWdHSrkFNndFpBnBPjuX4gv2yIped/axaqZtS9TjnH0E6vtniCfoq/jolTri6QGh6NNSdSC6BGlmKrjPkCXXL0aCPaGkmrQVD74Zouf0ojYXzED1zyXmIiV1iCdr8fKIgG2Xil9m8gU5wQltRZYxtG/xH25WKtfXDE3+Af3JuMt6bGa7Gw1lJf0cOKyMBNCi/7Xgqr66E3463Fu/fmIB3AXY/LchoxfCqFL4Ba9AeRAZHFlM/BgcY7nP5wIMJlJrwwv2xHKwgZMKEJ78qWTwJclV/GAWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJBqIk0uULmDKfoRtscS14x8TCOltxwjYuCzhuHiI4g=;
 b=gXxdBu2nWchZxziBgDkLJEyfrLgGyDCX09t3HTOYicf2nIyiUVJ4z/6GD9102yWwzu/Ll5OMRd6BSZZCHNFMMahD0h0PmoTer+rMSl24SNpuwsKuqiM7IgVw2XMbjVVfYGNZ+8h7CdaTH8c4n87IP8EAa8jRJgHx0GvwHePyncsdkHm5yNbMKYHztFpTswXUsXlvYVZhGPfuWi3cV8d6cdxpABMR7iUESI8YavARq958TDg1807dPHCLF89osOnVsYIg9dBTkblRMhMa1v8+o+3MACPb7u2lKDvjxxLck3fh2mC7IpTxDg6x6djg2/4HnIIAM0uwkZpP+Rr5h1OB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJBqIk0uULmDKfoRtscS14x8TCOltxwjYuCzhuHiI4g=;
 b=CD7DDxipYMn+6S2T94cLuSDRmuuBt5DamfzHeseDG7MZYE8eeZ9b6pGmLbIXqkZH5cNj0Abc6KlcFNBKRZTB9yiEIcOMZk3uoLxlVWOQ7D8sqcD5ykWPI1niJrw3RDKCsEY8+v+lNTHhDArEN042v8A+RypPfpCGEwf8E7p1O+s=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5568.eurprd05.prod.outlook.com (20.177.202.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Tue, 30 Jul 2019 12:33:13 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 12:33:13 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Thread-Topic: [PATCH 02/13] amdgpu: don't initialize range->list in
 amdgpu_hmm_init_range
Thread-Index: AQHVRpr2/Xz4jNPu6k2DNRcwdQGPdqbjGKwA
Date:   Tue, 30 Jul 2019 12:33:12 +0000
Message-ID: <20190730123308.GC24038@mellanox.com>
References: <20190730055203.28467-1-hch@lst.de>
 <20190730055203.28467-3-hch@lst.de>
In-Reply-To: <20190730055203.28467-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0027.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::40)
 To VI1PR05MB4141.eurprd05.prod.outlook.com (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 030d7e3e-a479-4767-61b9-08d714ea1671
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB5568;
x-ms-traffictypediagnostic: VI1PR05MB5568:
x-microsoft-antispam-prvs: <VI1PR05MB5568E3AC8C0E36649BB76B91CFDC0@VI1PR05MB5568.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(199004)(189003)(446003)(11346002)(53936002)(486006)(5660300002)(2616005)(476003)(14444005)(256004)(4744005)(6246003)(26005)(6436002)(6512007)(66946007)(6486002)(102836004)(305945005)(66476007)(68736007)(66446008)(64756008)(66556008)(33656002)(8936002)(186003)(1076003)(66066001)(71200400001)(7736002)(81156014)(81166006)(8676002)(229853002)(7416002)(99286004)(2906002)(6916009)(6116002)(54906003)(316002)(36756003)(3846002)(86362001)(478600001)(76176011)(6506007)(386003)(52116002)(14454004)(4326008)(25786009)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5568;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: igJ5d+sAtfWgcZPbFsVrEGUPsD09Bd7BkfoQ48FP7/adNthai8eA3lAChgCflxSwnW0Jt41B456uo/4Al0S11kKYNWcpeHjygIX0jTJpycSsbzFnamNI7EXV2SowJlY/1SQhOJzNxzzkXUBDrb6Kk1Mb5a9Rh0VbEb/9bflnMMms40fPrgIxBEGZ7d2xO9Za/2QPKM3mxRt/x29xrb5ov3H4vJWDncg6kYWwEsmYSq0dl2qPR8d4GTYgyQ1YkVgz18KnnNPiStw0RUT4AAipzrRrMi0OAqeMKJOWnGHbi30hIYyqA9IqFMqI6oxV7xz5wJxx5IO9CJ3cZIvlmGMlwFtqukwwjnJjtKHOROYMxRHzo0uXwv4blAzYzMLlc2UiI4rR1+UJNCr3FTZ56DvjWnHJy+CbvfDCTVzVPqFieic=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4857B6B6FF775241B37B5E5B4EA4984B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030d7e3e-a479-4767-61b9-08d714ea1671
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 12:33:12.9565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5568
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 08:51:52AM +0300, Christoph Hellwig wrote:
> The list is used to add the range to another list as an entry in the
> core hmm code, so there is no need to initialize it in a driver.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
