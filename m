Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86924C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCA921852
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="k14i41lK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfGDV26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:28:58 -0400
Received: from mail-eopbgr20041.outbound.protection.outlook.com ([40.107.2.41]:59969
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfGDV26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 17:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzrIxZPRXFQpJbkXBZfe9b+ex1RCZ3jZqSg6FVANuEg=;
 b=k14i41lKIR7K3YX4vICpwjjL8lxmU5cY2GWO7zYln0REMVAjOvxSzdt8QSBIxl6a0MD9iLQ2QNOsVGBZ+/8Css1cHoBSPsMyutusm6HgIauANlw7V+cke7T80UzaJ3XUwIKIRi8rfLtxqg4QLTn+se4uzoptMWKD5V2ifoV7wsI=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB6014.eurprd05.prod.outlook.com (20.178.127.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Thu, 4 Jul 2019 21:28:54 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2032.019; Thu, 4 Jul 2019
 21:28:54 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Topic: [PATCH v3 0/4] Devmap cleanups + arm64 support
Thread-Index: AQHVK/HAM2r3dJ5EjUuvQfApLyHQmKat3lEAgAA0MoCAAAH5AIAAxnaAgAwArgCAABJ8AIAADxQAgAAJ3QA=
Date:   Thu, 4 Jul 2019 21:28:54 +0000
Message-ID: <20190704212850.GB23542@mellanox.com>
References: <cover.1558547956.git.robin.murphy@arm.com>
 <20190626073533.GA24199@infradead.org>
 <20190626123139.GB20635@lakrids.cambridge.arm.com>
 <20190626153829.GA22138@infradead.org> <20190626154532.GA3088@mellanox.com>
 <20190626203551.4612e12be27be3458801703b@linux-foundation.org>
 <20190704115324.c9780d01ef6938ab41403bf9@linux-foundation.org>
 <20190704195934.GA23542@mellanox.com>
 <20190704135332.234891ac6ce641bf29913d06@linux-foundation.org>
In-Reply-To: <20190704135332.234891ac6ce641bf29913d06@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:d4::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5ea08e7-e074-4157-6e83-08d700c69d65
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB6014;
x-ms-traffictypediagnostic: VI1PR05MB6014:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR05MB601420B2E47CBEC22759ECACCFFA0@VI1PR05MB6014.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0088C92887
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(6306002)(8676002)(81166006)(36756003)(6512007)(53936002)(81156014)(6436002)(2906002)(102836004)(26005)(6916009)(99286004)(52116002)(76176011)(14444005)(256004)(186003)(6506007)(386003)(68736007)(66066001)(8936002)(6486002)(1076003)(229853002)(6116002)(7416002)(11346002)(305945005)(2616005)(476003)(316002)(6246003)(54906003)(14454004)(86362001)(478600001)(446003)(66476007)(71200400001)(33656002)(73956011)(71190400001)(66446008)(66556008)(66946007)(64756008)(966005)(4326008)(486006)(25786009)(5660300002)(3846002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB6014;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GZhpXph8JQTGJITEs1uAnNGeBubFnAoQYzEo901XU5xi1gvsUfc2XUrlN9pMi+ZO6mQX/YsukdIcAoDfJq7YWux0bFz2RHa7DKPr8JVkYm0pu7+qsrV2LVCupYivVRjdUnPkwFCB1ZFZrGhh9aU6lBeWzr5MGsfHaY9GD+VbKELzIldDZB/61wVeOd88ade/tPRAUFpeOTkKjlOwM0fuA9iKsewiXCsvddPMRnTY2k3YMqAS4tl4h6ED5DiOfUXkwM7MzlTzMUOnQwRYDLmK3E7XrTKr6+bmIZqa6zkiYbjZ5bKGoirb3zVYAhhfPlp1bV6uA2orjwL+mNNs7tn+EbJxk70PTMtPLqy/VKWJCK5wUC8SQSN/U485oOOwGAC7sXW5GnD6W82hKBOu7f6sDa8vbiD939d7ZmnTp5fWDTA=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9DE2EFC78892704782174E84794C9CF6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ea08e7-e074-4157-6e83-08d700c69d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2019 21:28:54.2548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 01:53:32PM -0700, Andrew Morton wrote:
> On Thu, 4 Jul 2019 19:59:38 +0000 Jason Gunthorpe <jgg@mellanox.com> wrot=
e:
>=20
> > On Thu, Jul 04, 2019 at 11:53:24AM -0700, Andrew Morton wrote:
> > > On Wed, 26 Jun 2019 20:35:51 -0700 Andrew Morton <akpm@linux-foundati=
on.org> wrote:
> > >=20
> > > > > Let me know and I can help orchestate this.
> > > >=20
> > > > Well.  Whatever works.  In this situation I'd stage the patches aft=
er
> > > > linux-next and would merge them up after the prereq patches have be=
en
> > > > merged into mainline.  Easy.
> > >=20
> > > All right, what the hell just happened?=20
> >=20
> > Christoph's patch series for the devmap & hmm rework finally made it
> > into linux-next
>=20
> We're talking about "dev_pagemap related cleanups v4", yes?
>
> I note that linux-next contains "mm: remove the HMM config option"
> which was present in Christoph's v3 series but wasn't present in v4.=20
> Perhaps something has gone wrong here.

When CH sent v4 to the list it was corrupted, v3 is the one to
reference for content.

Here is the mailing thread discussing this:

https://lore.kernel.org/linux-mm/20190702184201.GO31718@mellanox.com/

> > sorry, it took quite a few iterations on the list to
> > get all the reviews and tests, and figure out how to resolve some
> > other conflicting things. So it just made it this week.
> >=20
> > Recall, this is the patch series I asked you about routing a few weeks
> > ago, as it really exceeded the small area that hmm.git was supposed to
> > cover. I think we are both caught off guard how big the conflict is!
>=20
> I guess I was distracted - I should have taken a look to see how
> mergable it all was.

Okay, fair enough. I also could have also done more checks myself with
linux-next

> It's a large patchset and it appears to be mainly (entirely?) code
> cleanups.  I don't think such material would be appropriate for a late
> -rc7 merge even if it didn't conflict with lots of other higher
> priority pending functional changes and fixes!

I see your other email you resolved the conflicts - so please let me
know if you want to proceed with dropping CH's series or not, I'll
make a special effort to get that change into tomorrows linux-next if
you want (it is already 6pm here)

Regards,
Jason
