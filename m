Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3CBC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D4213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sXGl+c/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCSSv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 14:51:59 -0400
Received: from mail-eopbgr770052.outbound.protection.outlook.com ([40.107.77.52]:14048
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726753AbfCSSv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 14:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=peMIXsPGZWTGyL9rKc5EDN4WOKBt+MjCDtV3Ps19GtE=;
 b=sXGl+c/4DLita6aGcZ739e95kbZcRhnKtydIpHNmB8dzQAygAAvllCdskGDcDs/y3g+UulL6Cf7LhK/8gRcSjd1loFpiqUjKnl3QoZRGn6ZkF7uBsXFefrt7pZbLsCQJjiMtC8r6cAAupfzesAW1XcyZ1F2UpIa5J6/jRzt+QBc=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1154.namprd12.prod.outlook.com (10.168.227.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Tue, 19 Mar 2019 18:51:55 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::51a:7e56:5b6e:bc1f]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::51a:7e56:5b6e:bc1f%2]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 18:51:55 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Jerome Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH 00/10] HMM updates for 5.1
Thread-Topic: [PATCH 00/10] HMM updates for 5.1
Thread-Index: AQHU3nJt/fPh2r1eIEeZBueGAlevbKYTLO4AgAAe/zA=
Date:   Tue, 19 Mar 2019 18:51:55 +0000
Message-ID: <BN6PR12MB18091EB0297912641666526EF7400@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190129165428.3931-1-jglisse@redhat.com>
 <20190313012706.GB3402@redhat.com>
 <20190313091004.b748502871ba0aa839b924e9@linux-foundation.org>
 <20190318170404.GA6786@redhat.com>
 <20190319094007.a47ce9222b5faacec3e96da4@linux-foundation.org>
 <20190319165802.GA3656@redhat.com>
In-Reply-To: <20190319165802.GA3656@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.73.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1f68c82-72be-4cae-c74d-08d6ac9bf567
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1154;
x-ms-traffictypediagnostic: BN6PR12MB1154:
x-microsoft-antispam-prvs: <BN6PR12MB115446992D508B44A9E476D6F7400@BN6PR12MB1154.namprd12.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(366004)(376002)(396003)(39860400002)(13464003)(189003)(199004)(54534003)(476003)(6436002)(478600001)(2906002)(26005)(446003)(68736007)(8936002)(74316002)(53936002)(97736004)(99286004)(71190400001)(15650500001)(486006)(9686003)(6116002)(305945005)(25786009)(11346002)(3846002)(186003)(71200400001)(106356001)(105586002)(102836004)(4326008)(8676002)(86362001)(7736002)(52536014)(110136005)(6246003)(14454004)(316002)(229853002)(76176011)(81156014)(81166006)(33656002)(66066001)(53546011)(256004)(66574012)(55016002)(54906003)(72206003)(6506007)(5660300002)(93886005)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1154;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nSqP21BGtZ3Cmq1A9ihCOYGCREbHKtCk5f06EId3znOxvASR0l8lta+sBl+Pqz8E1BNWjXUFwUP+VHJjZ+zp72RkisRQM9wcUtnt6EzTRG+aSwqY5W57jPWvaOpt5YDIamP/l23yj5awO8k8FXSN7PemIUOW8qQrn2FfHMWEOs0EEOXAW6ic9mh7kX/fJx4i2DYPn0C8mAfgY1TD9CxfqXq9XO2wefkCSkeJKLgCC8vCb2e4Y24rv4kEqNKiEhAlNZfWsahV35OtEMiLgfQCs3JPlHPvNkyRUJwxn2AjjkPkM4DV41mhTvcxqNzMSkEMRp0JipiK4jowuhJ9lLxPDbL4Z2tPlc+TAlx0g/Mcjw7ZYIm0bXhfdoGMpJKWtEWX0nuGqMwCYk8lG3oxY1lBVOfdlloI7Rd40hGlYjWJbuM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f68c82-72be-4cae-c74d-08d6ac9bf567
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 18:51:55.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jerome Glisse <jglisse@redhat.com>
> Sent: Tuesday, March 19, 2019 12:58 PM
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org; Kuehling, Felix
> <Felix.Kuehling@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Ralph Campbell <rcampbell@nvidia.com>;
> John Hubbard <jhubbard@nvidia.com>; Jason Gunthorpe
> <jgg@mellanox.com>; Dan Williams <dan.j.williams@intel.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH 00/10] HMM updates for 5.1
>=20
> On Tue, Mar 19, 2019 at 09:40:07AM -0700, Andrew Morton wrote:
> > On Mon, 18 Mar 2019 13:04:04 -0400 Jerome Glisse <jglisse@redhat.com>
> wrote:
> >
> > > On Wed, Mar 13, 2019 at 09:10:04AM -0700, Andrew Morton wrote:
> > > > On Tue, 12 Mar 2019 21:27:06 -0400 Jerome Glisse
> <jglisse@redhat.com> wrote:
> > > >
> > > > > Andrew you will not be pushing this patchset in 5.1 ?
> > > >
> > > > I'd like to.  It sounds like we're converging on a plan.
> > > >
> > > > It would be good to hear more from the driver developers who will
> > > > be consuming these new features - links to patchsets, review
> > > > feedback, etc.  Which individuals should we be asking?  Felix,
> > > > Christian and Jason, perhaps?
> > > >
> > >
> > > So i am guessing you will not send this to Linus ?
> >
> > I was waiting to see how the discussion proceeds.  Was also expecting
> > various changelog updates (at least) - more acks from driver
> > developers, additional pointers to client driver patchsets,
> > description of their readiness, etc.
>=20
> nouveau will benefit from this patchset and is already upstream in 5.1 so=
 i am
> not sure what kind of pointer i can give for that, it is already there. a=
mdgpu
> will also benefit from it and is queue up AFAICT. ODP RDMA is the third d=
river
> and i gave link to the patch that also use the 2 new functions that this
> patchset introduce. Do you want more ?
>=20
> I guess i will repost with updated ack as Felix, Jason and few others tol=
d me
> they were fine with it.
>=20
> >
> > Today I discover that Alex has cherrypicked "mm/hmm: use reference
> > counting for HMM struct" into a tree which is fed into linux-next
> > which rather messes things up from my end and makes it hard to feed a
> > (possibly modified version of) that into Linus.
>=20
> :( i did not know the tree they pull that in was fed into next. I will di=
scourage
> them from doing so going forward.
>=20

I can drop it.  I included it because it fixes an issue with HMM as used by=
 amdgpu in our current -next tree.  So users testing my drm-next branch wil=
l run into the issue without it.  I don't plan to include it the actual -ne=
xt PR.  What is the recommended way to deal with this?

Alex

> > So I think I'll throw up my hands, drop them all and shall await
> > developments :(
>=20
> What more do you want to see ? I can repost with the ack already given an=
d
> the improve commit wording on some of the patch. But from user point of
> view nouveau is already upstream, ODP RDMA depends on this patchset and
> is posted and i have given link to it. amdgpu is queue up. What more do i
> need ?
>=20
> Cheers,
> J=E9r=F4me
