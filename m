Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFA0C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C532054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="K0oknNrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfGOPE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:04:56 -0400
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:6806
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733113AbfGOPEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATJGn5rycD0k8Lm8+q4lAbvA0JyCH9CGM5K52guYMxmU10QgzYfY44bEOJsTZ8kIzzYKVdKjQIfupJ9fpMQOY/tg0aW2CjDsqWKm+Vbg8HtyVbknXJstUHDvExkhUhMiBD7ipmVwuZ7cTY09HPmx/O0Pk89dI1+frB2xBYydR48t978nKm8k8EEr19tZtFTJenVZXZ60NcEna3ILMY7MEWX8M1ZlqfO1CuJb8cG3ClUmsygVs1jpXmBIyRw7Gp4dttcvlN907WKO3KUn8q/AT4wlvxjXoI6JNAqlDeE0YFSzAFSpeM7ItOl7/Gj5QmBK1ucFITXNMybdiu1B/PICng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZmk1uxAVo6FKfrBs6fhFNW30XPmnCjwlpAPTH8nAxk=;
 b=FubVpF6glmrt9qF1D0nHFg6VJ7+HbVNonRCktX7vtkrlBFTqsmpVgd+6i8+n97Tr5Yf6n42RyE+cXBDMyOGMBUU4rpzTIK7W3SQ8isGz+WF/ugEOPp5QwvR9Qyf2bYqwqhfU14nmTfA7n8xTdmBZm1HGN1+M7TRFWTbm3zWIroD9dyVwTbpoGJEgCEHcQ/cQehwtF9zG7RbpXvMKkhVgukEtIuLcU6eT+jT7HVtvurfiaIWoExVFarpmkgB5OgfC2muaVkGdgU32dmaZRmVkWQAHAJGCT0bownbITgKUK2eK644ZN//HpJujtKx1FZzLPsKUNN4EEAtg4A76JYUFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZmk1uxAVo6FKfrBs6fhFNW30XPmnCjwlpAPTH8nAxk=;
 b=K0oknNrJ8Bcyl1SXbbmShUUy0XyAFgxvt+19qVjeJglo6AD15A31LhuQqDhJTSWzLyY5UyKsC/L5HLaDj4pjKr/XLQNoWcK8WcYjYBpjrm27F1TewrkaPidlE+iJSp10FBFMDA/PMNCw1Ov7tM60s/KxjajY65wahnATJzNkHqw=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB4656.eurprd05.prod.outlook.com (20.176.3.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 15:04:06 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 15:04:06 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
CC:     Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: DRM pull for v5.3-rc1
Thread-Topic: DRM pull for v5.3-rc1
Thread-Index: AQHVOwjxvOBTsCZDkEWbf47t9QeYFabLuosAgAAMdgA=
Date:   Mon, 15 Jul 2019 15:04:06 +0000
Message-ID: <20190715150402.GD15202@mellanox.com>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com>
 <CAKMK7uHvjuQ5Dqm0LPrtQxdHh5Z6Pt2mg4AnpRRR0gWb1Wp05g@mail.gmail.com>
In-Reply-To: <CAKMK7uHvjuQ5Dqm0LPrtQxdHh5Z6Pt2mg4AnpRRR0gWb1Wp05g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR07CA0008.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::18) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c21725d2-8bd4-45ca-2423-08d70935ae51
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB4656;
x-ms-traffictypediagnostic: VI1PR05MB4656:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB46566CFEF571B95325146F9ECFCF0@VI1PR05MB4656.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(199004)(189003)(966005)(476003)(478600001)(7736002)(305945005)(486006)(68736007)(2616005)(11346002)(36756003)(446003)(5660300002)(14454004)(8936002)(64756008)(66946007)(66446008)(3846002)(66556008)(66476007)(6116002)(6306002)(8676002)(81166006)(81156014)(6512007)(26005)(186003)(256004)(14444005)(53936002)(76176011)(316002)(6436002)(99286004)(2906002)(71200400001)(71190400001)(54906003)(6486002)(229853002)(25786009)(86362001)(33656002)(66066001)(6916009)(102836004)(52116002)(4326008)(1076003)(6246003)(386003)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4656;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EbApiuLZZxJQzBUJW4gsWokwPzsLOn+6owEcsNyp1jANGfkF7mMjsKVLk8zJb2J4BpeFNFA4LzJMhIdm2RpfnJNCQ8/gi0/WGaQuk26IPFxEQ0N5Ta7gbGW5rHtT8iYlF+vE5+kxZbh6gDbyk/n+fzQiOEYOzBXGBvnvPnX3el59rPz1wbjrknSQfoVn8AplQUOPlg5ZCFdXPUToe+MMP+PAjNFoNpgNPCZddIMupp3He99qv8BIAZACAXG2EWJri8selkedWqBKyuIqGlTAybzh7yKhusp4rxtqIKJDiYLVXqyoPV4KeRcqXUlL6sWysX0/7Q+KQRGYfJN1MR+57qix2zPjNt9ocEcwoGsW1cWuCzSb/XOklh2s6TRMHAa2k4VSfus/HiLhvDip8E1y52Fm8l446TYcHKL2TueHxxc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5B7A3B0F68EBF243966782172D52DE3F@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c21725d2-8bd4-45ca-2423-08d70935ae51
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 15:04:06.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4656
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 04:19:26PM +0200, Daniel Vetter wrote:

> > Linus, do you have any advice on how best to handle sharing mm
> > patches? The hmm.git was mildly painful as it sits between quilt on
> > the -mm side and what seems like 'a world of interesting git things'
> > on the DRM side (but maybe I just don't know enough about DRM).
>=20
> I think the approach in this merge window worked fairly well:
> - refactor/rework core mm stuff in (h)mm.git
> - handle all the gpu stuff in drm.git
> - make the clashes workable through some clever prep patches like
>   we've done this time around

Okay, as long as we agree.

I think part of the challenge with hmm.git was setting some
expectation for managing conflicts - there is some happy middle ground
between none & scary we need to navigate to make this work.

> I think Linus wants to be able to look through core mm stuff quite
> closely, so not a good idea if we deeply intertwin it with one of the
> biggest subsystems there is.

There is definately a bunch of stuff that is under the mm/ directory
but is not quite 'core mm' - it would be good if we could rely on
mailing list review of that part and use a topic workflow to manage
things. This was/is more or less my plan with hmm.git

Otherwise yes, as much as reasonable we should avoid topic merges
between the trees.

However, I again see conflict risk coming this cycle ..

>  And I don't think there will be a real conflict like this every
> merge window, this should be the exception.  Worst case we have to
> stage some work 1 release cycle apart, i.e.  merge mm stuff first,
> then drm 3 months later.=20

I really dislike this idea. Not being able to provide users for core
APIs is a huge process/review problem. Worse it tends to create a
'ladder' where in-flight changes to drivers (to implement the new
core) now block any changes to the core APIs on alternating cycles. So
'the big pitcture' starts to fall a part if we can't co-ordinate cross
tree changes in some way.

.. and honestly, splitting a review process across a 9 week gap is one
of the best ways I've seen to get a poor quality review :(

I'm pretty familiar with this problem, we had it in spades between RDMA
and netdev for a long time, and it is finally fully resolved now
through a careful use of topic branches and merges.

For example, next week I'll queue CH's patches that shift the last
batch of hmm 'conflict management' shims into nouveau, and tries to
fix them:

  https://patchwork.kernel.org/project/linux-mm/list/?series=3D141835

This is something uncontroversial that really should go into the DRM
world as a topic so it doesn't interfere with ongoing nouveau dev. But
I want to keep the hmm.c/.h bits in the hmm.git to avoid conflicts.

So, I'll put it on a topic and send you two a note next week to decide
if you want to merge it or not. I'm really unclear how nouveau's and
AMD's patchflow works..

Thanks.
Jason
