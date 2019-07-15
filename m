Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC29C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF04206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 12:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="glASsluy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfGOM3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 08:29:33 -0400
Received: from mail-eopbgr50082.outbound.protection.outlook.com ([40.107.5.82]:48166
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728933AbfGOM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 08:29:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVahyFQQXIFokxA9t4v5RzQcMelocAbzN3xTlPEul7qdx+vx0o+kqihHSlZ4zAla2N06lxcIWhuu6RNwMFfljeeTik1WEOUUfkLUPtWHoJbWV73KXPauoc0qyAYr1pisVKQGVuOQ0rsYwmqegCEYnetz3LDKNPcr+WVm1OG+lpW8JkCgy6uWkX+ez6YzUVjbIf1jbkso5ojpWsS8qkbpsV6505LUHtZBbwia7Y29HRuS+ShNv5AzpkWM2ePbw+2nALjARG74G0wlAYVxnM8VJ3p/KzZMQ+zLgyGZIK0+iL/sMN/CJjxyOz2WBzlDSAF4drr2aa3iM8bcgEvqSrZEhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akapq/9daGyVJ60ceakWNGGwz1EagQPDxIEO0hWhUpM=;
 b=f/Kg0YT0My7C4XlJYUNtxlpCoKNboC22txggh7mWucaQP0lgyILmTUWI7SHbDgt6lso3Q882L6rOAD4/+NydkxKp2M7iTcaVqwD11NgBjg2r+/zWGzfYNFM1QhmIeE60Izxd19pFMDIZ0WRWx8M1xhbK4uv+h1SQPTdIjTXjgabUgAT8tMSlLCQHEuxmJgr65JMBJWPVAKUcldnsy6B+XNbI9eMj28w+rHIuc4kn4v0fmfYMK0b71oAioNzSmMU5H+RHzWyN2XHd8TlND+E84nbiqRxHSNRwsDo/ecG+yJsLYsE/FGNhYx5WQJi0GWTzklHSvolJot8/miHbG76lvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akapq/9daGyVJ60ceakWNGGwz1EagQPDxIEO0hWhUpM=;
 b=glASsluy9Ym4+EShVYM2XOc8iuWUlVZuEdTBA5MdEIbLc+Km+jV9mqGJnfPplMKD1xnAeD2ON7luPykCcQFv6ipOOJMQ4WqPWLDb6uJeWM1rp9Re56jQic0ADtMLksKaULGnITz2coPceBDW7MBPHkvFQ7EqsjxCtSGYOvo6DoM=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4800.eurprd05.prod.outlook.com (20.176.4.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 12:29:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 12:29:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Dave Airlie <airlied@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: DRM pull for v5.3-rc1
Thread-Topic: DRM pull for v5.3-rc1
Thread-Index: AQHVOwjxvOBTsCZDkEWbf47t9QeYFQ==
Date:   Mon, 15 Jul 2019 12:29:28 +0000
Message-ID: <20190715122924.GA15202@mellanox.com>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
In-Reply-To: <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:208:a8::41) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39b432ae-8622-459d-d658-08d709201442
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4800;
x-ms-traffictypediagnostic: VI1PR05MB4800:
x-microsoft-antispam-prvs: <VI1PR05MB4800229D63E8D8F46822BF41CFCF0@VI1PR05MB4800.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(386003)(102836004)(6506007)(256004)(14444005)(26005)(7736002)(68736007)(8936002)(25786009)(478600001)(99286004)(1411001)(2906002)(305945005)(6246003)(8676002)(14454004)(486006)(71190400001)(54906003)(71200400001)(6116002)(81166006)(81156014)(4326008)(33656002)(76176011)(52116002)(3846002)(186003)(11346002)(53936002)(64756008)(446003)(86362001)(6436002)(1076003)(229853002)(66946007)(36756003)(66446008)(66476007)(5660300002)(6486002)(476003)(2616005)(66066001)(66556008)(6512007)(316002)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4800;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XvWuynTcGBBrOfp3GFfG94yLV2FH4VG5X3fXfSBTeZGcq8vBW95TMWRz5eB6inQqJJENO0NFfI/RmrdlVUkvRILFKLQumMjnIl+w4J/KACQocg+sc6x0rEBxRGfOZ7CddpCeNNKp8d936h26nGmA9APjkcDHequz73K1fd9N/K+2rClkIDNT4NA9F6lpBguEuvDfDvMUg7wyjvUEXKBwfiU8mjOiB8wfkvopyN4bC8I4paSkkNsaVY2n+1U/rpOO8LHqaQNnJ1XPvVSGjN4VqDJfuKGInNZjW/gqN6V2hJQjRqyBiSskru+w3DnEO8wx0znZ3gBo6z53V8/Jm6zJL7+EaUfFsDG0U8mQioK/VPB2KTLnPYuYStJXHjEJqeqxMDI/JwfDQivfIfemmknH8nxgoFow9UYI0y0gQr78IVY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FEAD40FF44C9646ADFEFE6B81EBB6E0@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b432ae-8622-459d-d658-08d709201442
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 12:29:28.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[urk, html email.. forgive the mess]

On Mon, Jul 15, 2019 at 04:59:39PM +1000, Dave Airlie wrote:

>      VMware had some mm helpers go in via my tree (looking back I'm
>      not sure Thomas really secured enough acks on these, but I'm

I saw those patches, honestly I couldn't entirely understand what
problem they were trying to address..

>      going with it for now until I get push back). They conflicted
>      with one of the mm cleanups in the hmm tree, I've pushed a
>      patch to the top of my next to fix most of the fallout in my
>      tree, and the resulting fixup is to pick the closure->ptefn
>      hunk and apply something like in mm/memory.c

Did I mess a notification from StephenR in linux-next? I was unwaware
of this conflict?

The 'hmm' tree is something I ran to try and help workflow issues like
this, as it could be merged to DRM as a topic branch - maybe consider
this flow in future?

Linus, do you have any advice on how best to handle sharing mm
patches? The hmm.git was mildly painful as it sits between quilt on
the -mm side and what seems like 'a world of interesting git things'
on the DRM side (but maybe I just don't know enough about DRM).

> @@ -2201,7 +2162,7 @@ static int apply_to_page_range_wrapper(pte_t
>      *pte,
>              struct page_range_apply *pra =3D
>                      container_of(pter, typeof(*pra), pter);
>      -       return pra->fn(pte, NULL, addr, pra->data);
>      +       return pra->fn(pte, addr, pra->data);
>       }

I looked through this and it looks OK to me, thanks

Jason
