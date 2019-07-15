Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662DDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="lZUW2IUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfGOTRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:17:12 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:6054
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729432AbfGOTRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:17:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRy3F/f19XQ5Ws6D97cuJfNslFM8g+OQNHVeSzctjRUWRXEi60v1CDsKedGCrLKOv30jDBd5YczuXzI3mrZ6EAD/lCcRtHhmKgB6IUrn2LWF3PlQ2WZwiu/VL/qOPDkgvjpwZDTdlTlKvnGRY7pnQamvNWPhk5QBZCMJ0qbqosu6C/AdFSu3SmkU96UC3WEUQcKdkDSldYA51O0nA39SD5ZfD4QLOTKr9bJIZoQwwugrvve7IRN/xCn2pND4Ye9rUXOSMIEKvq8ns9Sh3KG6MnP2V44Z01sUSRwtnZR/lfX+6ghvtWa4P6FlsR319c2N8U5gcBPA0ijgJoFdfQTvRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ISiw4cLmgEvNJ8Na5+APkgOApNsKAf4uvFCLaPd/9c=;
 b=RsetV/IqhMZa5qa8nrejqcGgIq/1tb3G5Jrr8NPB1Rmeu3EOfNbhO2FhOpq6wYkZKa6WOKLWsBoIYGrdxOB4h0nx2bog8KdFIquI1N7LafDBJbVXdaxfqAgu6yV3fggW7uA/TZxDniNCYa6jdVge2Knr0dlT6Pvx3t1ceN37q4Fo8JsHQhudAQG9IQWX/gKI2IekwkpLnKAfDsxOVMQP+ZI8TBjn9HJNJOCnHAtX/j8jbHx7tpbPPQ4zFI0ynvYqgIsogu89xRfnAtFpItFMTBHivvYlYE74MlC76mRsXHZy/JjTmFRl3o8XxUo9FjMFVFJ1MJteWe37n3gEc2Wkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ISiw4cLmgEvNJ8Na5+APkgOApNsKAf4uvFCLaPd/9c=;
 b=lZUW2IUhMWBSJL2Dr8As2NAqa9Mp5U2hBxSTFDsOQK+C6wO3MfXs8xpCoydN02/5M0loMQusYe1/t2OiN/2m9tAyLxpW7A9cxVNsMDHN/p917vNOHVC3r7Kc+sMeuogULWbbkLafcdXOywj1QsuXf2Be9PAn3844dkhtTWRFflk=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3181.eurprd05.prod.outlook.com (10.170.237.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Mon, 15 Jul 2019 19:17:08 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::f5d8:df9:731:682e%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 19:17:08 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: DRM pull for v5.3-rc1
Thread-Topic: DRM pull for v5.3-rc1
Thread-Index: AQHVOwjxvOBTsCZDkEWbf47t9QeYFabL/LCAgAARAQA=
Date:   Mon, 15 Jul 2019 19:17:08 +0000
Message-ID: <20190715191702.GD5043@mellanox.com>
References: <CAPM=9tzJQ+26n_Df1eBPG1A=tXf4xNuVEjbG3aZj-aqYQ9nnAg@mail.gmail.com>
 <CAPM=9tx+CEkzmLZ-93GZmde9xzJ_rw3PJZxFu_pjZJc7KM5f-w@mail.gmail.com>
 <20190715122924.GA15202@mellanox.com>
 <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
In-Reply-To: <CAHk-=wgEimwxXiDUdp9eSGZn4j6n8g-4KhdEG0kPVgKFQeAXgw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQBPR0101CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::29) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fd5f218-0210-433d-af5a-08d70959079b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3181;
x-ms-traffictypediagnostic: VI1PR05MB3181:
x-microsoft-antispam-prvs: <VI1PR05MB318153FF71C6D6DB6A19201ACFCF0@VI1PR05MB3181.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(189003)(199004)(14444005)(256004)(66066001)(86362001)(316002)(14454004)(71200400001)(8936002)(71190400001)(66556008)(66476007)(64756008)(66446008)(6916009)(1076003)(5660300002)(54906003)(66946007)(446003)(4326008)(99286004)(102836004)(486006)(11346002)(2906002)(386003)(305945005)(7736002)(53936002)(6436002)(229853002)(52116002)(476003)(2616005)(68736007)(478600001)(6486002)(6512007)(25786009)(6506007)(53546011)(76176011)(33656002)(8676002)(6116002)(3846002)(186003)(81156014)(81166006)(36756003)(26005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3181;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2Pm0du8sq6JH5OLOReQ0+d3KFOROuzLaxbyUOeN4bP41cAiJCLHro5ca0yJVUIzRNdozmHDVt9QMl0VfuxlsF22FvW9rAQ9BkFRMmYoqzXdS8WDDRtS/VSrbupU6jkwRnegSsmd3dTAYLeutD9R69syK4hRaznLpw3hwhRaRZfmWBsUWCV+VgY07G17nlEnxbxyIUgofvMyKU/ylJFwp8mM0ivR2NwJj2lWmTLbDsKoliHjjl6+riFuwkDlUzu+LxsMnh6dpV3jWN1HuiPDNCYIg40kN2fgVCPhwhrgEYpmsmLiqI9guxyMPS2xiPDqk1f9+qFA8g6rbYOKVCXOs04xIn7iqpzNj+RxRyBrxFddd4F+7PNgyx4XMYw0G/CiZu5SY1D3pWEd2V861zfTRtgww+IlkU6JMwsRZa79OIC8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31A30FDC27B98847BD0C7E4675A970D1@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd5f218-0210-433d-af5a-08d70959079b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 19:17:08.2156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 11:16:11AM -0700, Linus Torvalds wrote:
> [ Ugh, I have three different threads about the drm pull because of
> the subject / html confusion. So now I'm replying in separate threads
> and I'm hoping the people involved have better threading than gmail
> does ;/ ]
>=20
> On Mon, Jul 15, 2019 at 5:29 AM Jason Gunthorpe <jgg@mellanox.com> wrote:
> >
> > The 'hmm' tree is something I ran to try and help workflow issues like
> > this, as it could be merged to DRM as a topic branch - maybe consider
> > this flow in future?
> >
> > Linus, do you have any advice on how best to handle sharing mm
> > patches?
>=20
> I don't have a lot of advice except for "very very carefully".
>=20
> I think the hmm tree worked really well this merge window, at least
> from my standpoint.
>=20
> But it is of course possible that my happiness about the hmm tree is a
> complete fluke and came about because pretty much all the patches were
> removing oddities and cleaning things up, and they weren't adding new
> odd things (or if they were, you hid it better ;^).

lol

Actually I think it was a lot of effort from many people to monitor
and stay on top of conflicts, and there was certainly a deliberate
effort to bring many people together.

About the only thing I could concretely suggest for working with -mm
is if there was some way the -mm quilt patches could participate in
'git merge' resolution at your level.

I only say this because the lowest point was when merging CH's series
to hmm.git caused Andrew to have to do a lot of work rebasing DanW's
series during rc7. Arguably that should have been my work preparing a
conflict resolution instruction, not his doing rebases.

.. and if we needed to revise hmm.git Dan's series would have been at
more risk. It kind of still is as I haven't seen him Ack Andrew's
rebase yet?

Thanks,
Jason
