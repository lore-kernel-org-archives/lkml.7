Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92975C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A81A214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 04:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vh1jl6u6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfDYEoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 00:44:21 -0400
Received: from mail-eopbgr20071.outbound.protection.outlook.com ([40.107.2.71]:49766
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbfDYEoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 00:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpRKduPd8ePHSGSwtcTwv+SkhnobiR7zC30sHjI2xv4=;
 b=Vh1jl6u6ZWGfbx6Sb4dWEqmvcSgaKaL6NEgJHfqa44PIOLjYEEBfq6U+9TZgq/zUnYLmId/dTC4vLMtt9Um9qlP87xzzJvDIUqgHK9rDbEGzEaU85SCVW7FuPezzeOsM/FJ5tr/xS4g85gbATH7Ck5y49QmVF2bHF1x8vWVHIac=
Received: from VE1PR04MB6670.eurprd04.prod.outlook.com (20.179.235.142) by
 VE1PR04MB6413.eurprd04.prod.outlook.com (20.179.232.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Thu, 25 Apr 2019 04:44:15 +0000
Received: from VE1PR04MB6670.eurprd04.prod.outlook.com
 ([fe80::d84c:c5bc:dc39:32cc]) by VE1PR04MB6670.eurprd04.prod.outlook.com
 ([fe80::d84c:c5bc:dc39:32cc%5]) with mapi id 15.20.1835.010; Thu, 25 Apr 2019
 04:44:15 +0000
From:   Vakul Garg <vakul.garg@nxp.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Wenwen Wang <wang6495@umn.edu>
CC:     Boris Pismenny <borisp@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING [TLS]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: tls: fix a memory leak bug
Thread-Topic: [PATCH] net: tls: fix a memory leak bug
Thread-Index: AQHU+trepvsmBbb/oUSYaUK+00Q4HaZMESAAgAA72/A=
Date:   Thu, 25 Apr 2019 04:44:15 +0000
Message-ID: <VE1PR04MB66708069A751DD3B7174E4F98B3D0@VE1PR04MB6670.eurprd04.prod.outlook.com>
References: <1556137087-25814-1-git-send-email-wang6495@umn.edu>
 <20190424180840.515b88af@cakuba.netronome.com>
In-Reply-To: <20190424180840.515b88af@cakuba.netronome.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vakul.garg@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb767f7-0d97-4f15-8f3f-08d6c938abf3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6413;
x-ms-traffictypediagnostic: VE1PR04MB6413:
x-microsoft-antispam-prvs: <VE1PR04MB64139F4C24D0A8176280693E8B3D0@VE1PR04MB6413.eurprd04.prod.outlook.com>
x-forefront-prvs: 0018A2705B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39860400002)(136003)(13464003)(189003)(199004)(97736004)(7416002)(66476007)(53546011)(66946007)(6506007)(305945005)(6246003)(102836004)(14454004)(54906003)(25786009)(26005)(76116006)(186003)(86362001)(81156014)(316002)(81166006)(55016002)(9686003)(478600001)(33656002)(110136005)(53936002)(73956011)(2171002)(76176011)(7736002)(74316002)(66066001)(68736007)(44832011)(256004)(3846002)(7696005)(4326008)(14444005)(11346002)(476003)(2906002)(486006)(229853002)(6116002)(8676002)(5660300002)(66446008)(71190400001)(52536014)(8936002)(446003)(71200400001)(6436002)(64756008)(99286004)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6413;H:VE1PR04MB6670.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DX/cb6u+kIvz+K/hTc9g5Am3TLbG9NjtS3G+nZ1RN6z0ZRelSQEusGQ7Y/MYtVdOq6fU0PAO+wwml1o1arkXMSmD3ZmTdfRfKRAxcL6228H/QM1XVO6qpNvSWd6Xy7PvIxg5qlp5GvkAus1diYQYIxRsWrd6rqZXfQbUYvo2RWIxsXLz/LIIkQjsPWWZ4AniXENzcJm5eXKFuRacQTpU7xHYpsWZ/pmILS7Cf7h5+vFZ9fdstv8G/nWhlSXIOFkI/PFK4q3oMdiZ3kNvpNGHVKnvEc/S+LCLbKvRIbf8KqcMHXKeTvFk3j7doN9b96kkma+Y3BefFG3bpaUSX62N1OWHKU7jn74U2Wwu3u28D7WKRqZJVmkYNy27rLodWTuPlW6qDfICnMs9kXSjxxXtzldnIXpD4rUXZ2IR8StAsBI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb767f7-0d97-4f15-8f3f-08d6c938abf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2019 04:44:15.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6413
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Sent: Thursday, April 25, 2019 6:39 AM
> To: Wenwen Wang <wang6495@umn.edu>
> Cc: Boris Pismenny <borisp@mellanox.com>; Aviad Yehezkel
> <aviadye@mellanox.com>; Dave Watson <davejwatson@fb.com>; John
> Fastabend <john.fastabend@gmail.com>; Daniel Borkmann
> <daniel@iogearbox.net>; David S. Miller <davem@davemloft.net>; open
> list:NETWORKING [TLS] <netdev@vger.kernel.org>; open list <linux-
> kernel@vger.kernel.org>; Vakul Garg <vakul.garg@nxp.com>
> Subject: Re: [PATCH] net: tls: fix a memory leak bug
>=20
> On Wed, 24 Apr 2019 15:18:07 -0500, Wenwen Wang wrote:
> > In decrypt_internal(), a memory block 'mem' is allocated through
> > kmalloc() to hold aead_req, sgin[], sgout[], aad, and iv. This memory
> > block should be freed after it is used, before this function is
> > returned. However, if the return value of the function invocation of
> > tls_do_decryption() is -EINPROGRESS, this memory block is actually not
> > freed, which is a memory leak bug.
> >
> > To fix this issue, free the allocated block before the error code
> > -EINPROGRESS is returned.
> >
> > Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>=20
> Did you find this by code inspection or is this provable at runtime (kmem=
leak
> or such)?
>=20
> > diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c index
> > b50ced8..22445bb 100644
> > --- a/net/tls/tls_sw.c
> > +++ b/net/tls/tls_sw.c
> > @@ -1445,8 +1445,10 @@ static int decrypt_internal(struct sock *sk,
> struct sk_buff *skb,
> >  	/* Prepare and submit AEAD request */
> >  	err =3D tls_do_decryption(sk, skb, sgin, sgout, iv,
> >  				data_len, aead_req, async);
> > -	if (err =3D=3D -EINPROGRESS)
> > +	if (err =3D=3D -EINPROGRESS) {
> > +		kfree(mem);
> >  		return err;
>=20
> Mm... don't think so.
>=20
> -EINPROGRESS is special, it means something is working on the request
> asynchronously here.
>=20
> I think this memory is freed in tls_decrypt_done():
>=20
> 	kfree(aead_req);
>=20
> Note that aead_req is the first member of the allocated buffer.
>=20
> CCing Vakul

The patch is wrong.=20
Valid reasons have been given against the patch.

>=20
> > +	}
> >
> >  	/* Release the pages in case iov was mapped to pages */
> >  	for (; pages > 0; pages--)

