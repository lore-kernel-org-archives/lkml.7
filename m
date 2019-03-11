Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147892075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 14:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="s3GLfyQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCKONZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:13:25 -0400
Received: from mail-eopbgr10065.outbound.protection.outlook.com ([40.107.1.65]:46919
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726897AbfCKONZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 10:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Pxf0PXdcNBu8HCY4TqxrwLrgjB6vhNlXNW1XGAoJVQ=;
 b=s3GLfyQph6UveQ6rIn9dZ0mkvdscWjaQrYfMWQ6lyqXvcQv+JNcD1MKPSDwDoS/9xCjIriO8/zLiK56y0gwtRmIFmQu7f0NAa1cH3RJRQweyIyQlhVmRtFjMUeUWX7QrdUlBiUjJ8wS9qIsjpNw0ngozDxyhDNEvLzeI4w2u94E=
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com (20.179.44.81) by
 DBBPR05MB6348.eurprd05.prod.outlook.com (20.179.41.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 14:12:39 +0000
Received: from DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f]) by DBBPR05MB6570.eurprd05.prod.outlook.com
 ([fe80::5d59:2e1c:c260:ea6f%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 14:12:39 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Doug Ledford <dledford@redhat.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the xarray tree
Thread-Topic: linux-next: build failure after merge of the xarray tree
Thread-Index: AQHUyayWFZfOlBmck0G6zKDUm21wO6XqMEkAgBulFgCAAJ8KAIAABNSAgAAcXIA=
Date:   Mon, 11 Mar 2019 14:12:39 +0000
Message-ID: <20190311141235.GH22862@mellanox.com>
References: <20190221171332.262cf619@canb.auug.org.au>
 <20190221123440.GD17501@mtr-leonro.mtl.com>
 <20190311024434.GA19508@bombadil.infradead.org>
 <20190311121348.GD22862@mellanox.com>
 <20190311123105.GC19508@bombadil.infradead.org>
In-Reply-To: <20190311123105.GC19508@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR0101CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::27) To DBBPR05MB6570.eurprd05.prod.outlook.com
 (2603:10a6:10:d1::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [24.137.65.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad58abb8-0ee9-423b-8783-08d6a62b9ea2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DBBPR05MB6348;
x-ms-traffictypediagnostic: DBBPR05MB6348:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DBBPR05MB6348;23:9YOnEjwf9Sfmk1JIthRV6UDEp0aqeZB0YRwufzzz6?=
 =?us-ascii?Q?/1vCYH1Z9fOvGyw8KjJ9jExfu8QJvDwS5mQ7INequ2tvN1GM3zXbKKnFp7lH?=
 =?us-ascii?Q?4ItN5UgCmwutq0bZnMWoYem8rKxWBjXvWPyfmB4z3grpCRaTB/TxcIFgfYZy?=
 =?us-ascii?Q?ee5nQqH+9VkPtwxGFARu9xKCqHnbYl9Yhn56WVKERrLg93ug2LZN2iQCRAin?=
 =?us-ascii?Q?cf2RJHNs5Wa6jxGQX6KPTDi1eE0SB+cVOJoKPxqhpl5Mp2H9AIvxGGOG7RVX?=
 =?us-ascii?Q?7eeb7ECw5zOgW9Yd2sGgC0p3L9OUUSdX8YYjCddbEmzzx01gIc5W2Q4ZTocS?=
 =?us-ascii?Q?WQDRWp4nWXqZoakbD7fwNVYvYNETvereXQ0fxt73+U3H6XHS2ZxaH5HBAuF7?=
 =?us-ascii?Q?HeZK5gWZHlyzCJMIaQ/l09un+7e8JEcDjNJTjoc8J92j/lHyfzuO1HgIHCx/?=
 =?us-ascii?Q?+XEZP1vqLIcxSfN+43h9AEYkcFuUOS1/bpo4GcPLsR6K3Y0HhyRkssLeKwtR?=
 =?us-ascii?Q?cfqY6EE+xd0UCZwv7cQl88sTdm5r0f02ScTtMXGD/myBA3D1gM0Nnmvgl7XM?=
 =?us-ascii?Q?Q/EEk4MC7xmuilNy4zFqYukcWmKA4imB+QkhjW4czQu8esb6F0jsPPLcWFlS?=
 =?us-ascii?Q?tXW0ipPc9HCCfAqyoTRSm5h9X8KWffzyZS0OQLYHnQV5Ys6L42GYcWzniM/z?=
 =?us-ascii?Q?7DRta1wVUaJqGDkcsemps5AFTq1P9fMv0vnxkgIVeFHQWeFq0Gvkg3CI1tqi?=
 =?us-ascii?Q?81eXYF5Q/15NpbWVJd7q1mlNbAbQT5UjJrzot4dN2vOI7QYYEE1efuEgU6HX?=
 =?us-ascii?Q?9kIkMByX8gN6HUq6kVFC/e1utZEiFxB4cvijIMv1Q59w67gcbfb4vCpVT8i/?=
 =?us-ascii?Q?4zOWbD83i5H2xmjOXakfkr5l1ZjCY3cM6SGNk8gFp7US+5x8XTGEdOu9ykN6?=
 =?us-ascii?Q?5ejlR7t/hKyPnKH15lT9fKGcctmy5WsFwRTfUrr4KfOGbb3aTVaKPSmF4tAD?=
 =?us-ascii?Q?KQMHaydeVfcnhIbrm1V9ZoS9k/AvP00NKFp9p276uDE2PsfzMytiUTDbgtbl?=
 =?us-ascii?Q?jf4w1oPXW4zvOgPui7BlzD6cj0u8reTWxYqaWweGKSPIdTyF35CcbW2nvave?=
 =?us-ascii?Q?zDcqlWuHGBG6sZd9N74QAwBe6y69LtPxvHFFGm16KM2yHVmEURXnRw9A8zw0?=
 =?us-ascii?Q?QiZHVey+tvBrzeH6Zkjw/kRFIngGNMwFB0Z/V0yWqAn5KCpCTP3tElxHb89v?=
 =?us-ascii?Q?2lL2DNgRgqBsuvr2RdnkwLtwuZKCtTURz0sPzmpibHZE+QgPpu8g80Dg9oGW?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <DBBPR05MB63485073FEF997C98D3D6800CF480@DBBPR05MB6348.eurprd05.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(189003)(199004)(106356001)(446003)(11346002)(4326008)(476003)(2616005)(486006)(186003)(6486002)(33656002)(86362001)(6436002)(1076003)(6246003)(5660300002)(53936002)(7736002)(305945005)(6512007)(99286004)(25786009)(105586002)(386003)(36756003)(6506007)(97736004)(81166006)(26005)(102836004)(81156014)(52116002)(66066001)(8676002)(76176011)(54906003)(2906002)(478600001)(316002)(93886005)(8936002)(256004)(6916009)(14444005)(6116002)(3846002)(68736007)(71200400001)(71190400001)(229853002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DBBPR05MB6348;H:DBBPR05MB6570.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5zBK6NRKuXT36euaG+lFh3wAFKswuyhWyT2UOmsEjrhq5ASXxQUFagKLEmAeTqozh6Qd/Li/eY5KO2cwx/2P1s1GiZN/DTduZCrQhhtWLdPtYwGSBfb9+6QNwILEvWRHDKQ1QnnqEbCnuUlXzTXSGMUmNIUe2a/pTaIHti5KbYNrbsOQXS8qyGDBhqJ880xI2mzXabHtXxrg/uWJZnXZs8kym7ApLK1KZp421EavlPi/42UL/+RQBCZWeXlunf4WU4ne6yCL7E0Vgc32HYIPRxG0nNmf982nTBSTS4PejgCSlzYdNzC/msIeoL+7gChkfrYZbHgXQgAasH96jSqGR4M/y1GbAriEQOakwDnCZO7bpCz0AZhmWW1kz/POMaZJ9Yq+paBtEnmn1vtkuBom+ozjC5dH+jJiv2s1dg3IARw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B42EC11540708545932D74D1D2F716D7@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad58abb8-0ee9-423b-8783-08d6a62b9ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 14:12:39.7672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR05MB6348
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 05:31:05AM -0700, Matthew Wilcox wrote:
> On Mon, Mar 11, 2019 at 12:13:54PM +0000, Jason Gunthorpe wrote:
> > > @@ -1059,14 +1050,14 @@ static int assign_client_id(struct ib_client =
*client)
> > >  	 * to get the LIFO order. The extra linked list can go away if xarr=
ay
> > >  	 * learns to reverse iterate.
> > >  	 */
> > > -	if (list_empty(&client_list))
> > > +	if (list_empty(&client_list)) {
> > >  		client->client_id =3D 0;
> > > -	else
> > > -		client->client_id =3D
> > > -			list_last_entry(&client_list, struct ib_client, list)
> > > -				->client_id;
> > > -	ret =3D xa_alloc(&clients, &client->client_id, INT_MAX, client,
> > > -		       GFP_KERNEL);
> > > +	} else {
> > > +		struct ib_client *last =3D list_last_entry(&client_list,
> > > +				struct ib_client, list);
> > > +		client->client_id =3D last->client_id + 1;
> >=20
> > blank line after locals, but other wise these all looks fine..=20
>=20
> Would you rather see this rendered as:
>=20
>         if (list_empty(&client_list)) {
>                 client->client_id =3D 0;
>         } else {
>                 struct ib_client *last;=20
>=20
>                 last =3D list_last_entry(&client_list, struct ib_client, =
list);
>                 client->client_id =3D last->client_id + 1;
>         }

Don't care much either way. Only that the Linux style guide is to
always have the blank line after variable declarations in any block

> or move the declaration of 'last' up to the top of the function?

This one I dislike, variables should be in their narrowest scope for
clarity

> > Should have started out with the xa_insert version above..
>=20
> I didn't spot it until last night either ...

It is a leftover weird thinking logic from an earlier attempt I had
that was trying to get the last ID out of the xarray without the
linked list..

Jason
