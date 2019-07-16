Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D11C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B7020880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 12:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="DaEnJlnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbfGPM0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 08:26:45 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:51494
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728121AbfGPM0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 08:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJcaSurSLZ8e5hyP/Ux6k3qtFtIEZFtiXs9SjlU1rDc+jwwkYNrgUYuz4GF4RmOQFBSCyxhqKZPyj/n2g1hG0ocdp6kJOCYwcdkCqF6GPqmPLVsXRZxN5+74ajMPPLq8ajy6xJFbww4fB+oHIYihPNJrUMx6PhG7vLBcjjo/ftXjnN00wRUzp3Mc8ObdKhqwXTUpQexyRMywugo7AUCERPNx8Q2tGQ2mYvij8BXq+4PtmyfkTjAUMcLdteG2QnddM4ksg6HIABtAAJb0t0YaXP7UIzUwURiu0hTlXX1WYh/IeIxyn/WId6OMJ27JzY84pxHJ+Mzs8ShWyqQpwpLnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMH+GrufTBUitMHTytEFLheaMf0/0DfQy/UYM/WwNDk=;
 b=Z6N4YGye76OfFTU+mG55Urm2m7F1LTLS5EmkQ8y+f2EoAZZD0YbStUg0MtM2Kc+uxui5lsWkSBOJ5HHXJSbCmLxk0MwPv1KSX8put6jojFZkahoVqYMsSw31BhAgFf3zEbvdz6odlzhY7EiWtaJhSROiiVLVMOccMC2K9OpoAoO48kerX7CgAQMs+pBIGIpPrmO8z1vtfCfWhzzWU6G+27+JLnJqYreuxTssc6zKUx+MZTSbASMVrXrFnYc9D7XwiP7mjO7Yb2WCyXjNTqLo1zH4+j9WxEHioNW14iGak3YNCOIT/EvBCgOUnKLPY5KDpoIXh39I+hK98YuLT8sSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMH+GrufTBUitMHTytEFLheaMf0/0DfQy/UYM/WwNDk=;
 b=DaEnJlnrvs2xHmDayvx27rDqyYyjXonWkTPtPcR2SpHPE8xqb1A2aLI7krulS/KI//YmLsvehWUn2Nfwqel8JF1WE42TjD91SwtQMkq0XexKUPH6TvfM4WmtXjNOssZn2qQn5Xsu32GcV++D2BalXPzmC8D9LQBnvn0VbtsV9lM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6112.eurprd05.prod.outlook.com (20.178.204.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Tue, 16 Jul 2019 12:26:41 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 12:26:41 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Doug Ledford <dledford@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rdma tree with the v4l-dvb-next
 tree
Thread-Topic: linux-next: manual merge of the rdma tree with the v4l-dvb-next
 tree
Thread-Index: AQHVO2/tbODbR7FZn0qQzE55M1UGyabNLIyA
Date:   Tue, 16 Jul 2019 12:26:40 +0000
Message-ID: <20190716122637.GA29741@mellanox.com>
References: <20190716104614.2ec8b57c@canb.auug.org.au>
In-Reply-To: <20190716104614.2ec8b57c@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR1501CA0009.namprd15.prod.outlook.com
 (2603:10b6:207:17::22) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77e3bfae-ff06-466d-97d9-08d709e8dae5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6112;
x-ms-traffictypediagnostic: VI1PR05MB6112:
x-microsoft-antispam-prvs: <VI1PR05MB6112DDD8787817F7D992B4D7CFCE0@VI1PR05MB6112.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(53754006)(199004)(189003)(6436002)(81156014)(68736007)(99286004)(66066001)(102836004)(81166006)(8936002)(66476007)(26005)(6246003)(6506007)(66556008)(186003)(2616005)(4326008)(6486002)(386003)(486006)(86362001)(76176011)(8676002)(2906002)(14454004)(229853002)(33656002)(52116002)(1076003)(6916009)(25786009)(71190400001)(446003)(71200400001)(305945005)(6116002)(3846002)(6512007)(478600001)(476003)(54906003)(5660300002)(256004)(66446008)(64756008)(53936002)(11346002)(7736002)(316002)(36756003)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6112;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TQlTMkHG0dClFP89G8wPu+eTMvfvNyVty3PWKGjVm7O51NtNOTFTZ/Lrnq1f6AOEGDNmq90iop0rtXPtqmDBHEYbYiiuDMr2+XipwzZqM8eVXAjH3GSOFHaSvSGPpk8lAOvY6fjSh27txS6ZHCKKRa6ZV0ToyyJB40gLOKVavkPJLUgvjrQZiq6K092PORhgnNRjRGQZXPwRJWn3tk8XLkZM6V8HNGmI6I0YDn1SQFuUZwBeOJngcfwsLw2OxoY7005EQVAbyW1iH3N/r7v3vnbtE5DsQ8OGpix2kE0MHycJfmykuZtxifW+PHeOJP0h7f/Q1/fBoJjoDXkNFPNAHgEXH84CaWDOZHxv2ddffswpC31hXJpNcrsSiaAPGA9k0Unvo164lVETRKLZZxdVOH9N/lfltb5ZRVWlaUaMOOM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE73668CC7A2B942820EAE89573B18B5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e3bfae-ff06-466d-97d9-08d709e8dae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 12:26:41.0144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 10:46:14AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the rdma tree got a conflict in:
>=20
>   Documentation/index.rst
>=20
> between commit:
>=20
>   09fdc957ad0d ("docs: leds: add it to the driver-api book")
> (and others following)
>=20
> from the v4l-dvb-next tree and commit:
>=20
>   a3a400da206b ("docs: infiniband: add it to the driver-api bookset")
>=20
> from the rdma tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I'm surprised this is coming from a v4l tree..

> diff --cc Documentation/index.rst
> index f379e43fcda0,869616b57aa8..000000000000
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@@ -96,23 -90,9 +96,24 @@@ needed)
>  =20
>      driver-api/index
>      core-api/index
>  +   locking/index
>  +   accounting/index
>  +   block/index
>  +   cdrom/index
>  +   ide/index
>  +   fb/index
>  +   fpga/index
>  +   hid/index
>  +   iio/index
>  +   leds/index
> +    infiniband/index

This should be kept sorted, Mauro rdma is already merged you'll need
to tell Linus about this trivial conflict when you send your patches.

Thanks,
Jason
