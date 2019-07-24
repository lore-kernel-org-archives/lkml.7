Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9F8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E068C21926
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="km/avlPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbfGXTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:09:16 -0400
Received: from mail-eopbgr70050.outbound.protection.outlook.com ([40.107.7.50]:58816
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725955AbfGXTJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:09:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM3kNgZ5Tafqm23ueiMyCI05LD0+Keh3x22M+BI03RRcFw5HRRvJV31h44tXjla+8FoNtrSugPWhMGGSxWTLx8EGIfQ+OiBaw1KWT9W3BAi8krZhc5kyAsX3zWgZuN3EbHy3XaA/61fYw6vyHwcHIiGKEToa8wRoEIc1BpSdrRs5uPGw+k6frqjj8Bq3KuV30wQS+v36JRfjYj3C5zBjF7vJhmr6+hNviYOu0IMChr535MdUjBDt1IizU0QszEjgh3ssMaNiO9UpEa1eSI84TweJLaK8UsxbS1ysTKFKLbMczNnj93xYaYQK5QQJTAF0/ASMKCpyoix7JR9Twyq9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP106LapniA+9wQSg8B7SETXeKNZkZ5tzYOjhwW5jI4=;
 b=fklCCFTScozkypAXSrMH7Tc7kWoSSijl8cRbEbeIkosqDrcV0ts9rI6eO1dbf34dGLi5AyPFJXHfRWoVzBkNApHYz2OSB/yXPuZpR8cqP3oSB8Na2gBROiSYKVqz6CHMTY/g+tX1VY2wN2qd/MNOxVEECIbnD4CCFr5+RojtmAD2P4iCQL3DLL5BgiLfisaLXAuA9oZ7fUzQgsJXFCMvVi7eKoOnsplN+rRtMBNHz7BqaIM8f/yRVPoJiR0RQBSVEtWcQ7eh5eDcttSKMSipi8rr+DBe3oLH4uRnId3qB3tsoid0OqZqR9RA5WLX1fDeo2rr5mWgjdKnk9ikCDYDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP106LapniA+9wQSg8B7SETXeKNZkZ5tzYOjhwW5jI4=;
 b=km/avlPXkI8jYpjZqMDeR2fE0SaxiWFf3vMzFqeTUq3lTiW5+wkqVjJkM60FcZMlr5SWe2PvqDN8Ykxmzu2czOrid4tPAdXUveEAgQsY2vZdZcg6UaDLE1ZidqELAuoN6+IJsp/kyqWJlqNN+MefBkh5pUVq7wBmu5HTjcwSvco=
Received: from AM6PR05MB5973.eurprd05.prod.outlook.com (20.179.1.139) by
 AM6PR05MB6293.eurprd05.prod.outlook.com (20.179.4.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 24 Jul 2019 19:09:12 +0000
Received: from AM6PR05MB5973.eurprd05.prod.outlook.com
 ([fe80::c1ba:21d6:109d:fb8b]) by AM6PR05MB5973.eurprd05.prod.outlook.com
 ([fe80::c1ba:21d6:109d:fb8b%2]) with mapi id 15.20.2094.017; Wed, 24 Jul 2019
 19:09:12 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "minyard@acm.org" <minyard@acm.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Thread-Topic: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c
Thread-Index: AQHVQi1l169YEOUyBE+9gKenP4eaI6baIX4AgAAAkxA=
Date:   Wed, 24 Jul 2019 19:09:12 +0000
Message-ID: <AM6PR05MB597324B4BCF4325C49749A5CDAC60@AM6PR05MB5973.eurprd05.prod.outlook.com>
References: <cover.1563978634.git.Asmaa@mellanox.com>
 <84ef25695b2bfa5100803d5bb30e5d4152e336e0.1563978634.git.Asmaa@mellanox.com>
 <20190724190640.GK3066@minyard.net>
In-Reply-To: <20190724190640.GK3066@minyard.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11ea1ff8-eacb-4238-7f83-08d7106a69bc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB6293;
x-ms-traffictypediagnostic: AM6PR05MB6293:
x-microsoft-antispam-prvs: <AM6PR05MB62932C2C3D69F7FEAE773DD3DAC60@AM6PR05MB6293.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(13464003)(199004)(189003)(6506007)(5660300002)(305945005)(476003)(66446008)(64756008)(66556008)(66476007)(102836004)(6246003)(14444005)(52536014)(256004)(76116006)(53936002)(81156014)(53546011)(26005)(11346002)(81166006)(186003)(66946007)(71190400001)(229853002)(71200400001)(74316002)(1730700003)(8936002)(446003)(7736002)(68736007)(76176011)(3846002)(6916009)(86362001)(8676002)(478600001)(99286004)(5640700003)(6436002)(14454004)(316002)(25786009)(9686003)(66066001)(55016002)(6116002)(33656002)(4326008)(2351001)(2906002)(2501003)(80792005)(486006)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB6293;H:AM6PR05MB5973.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 5q2vikpay2SwMVvlakAxi+axYQLid6PYcWrbQZrwi/0BKoRGDdTeN58pEYfJ+IE3A0LHGB5Pk2hZICGpDpm4ToKLqHOv10z740fzRGMcgucrjqu+Bt51kI4RNzJcV3O1zHovfIHFBArCsK163xY6FsxYivyg+3EGwUId+JuAUcuQaHQxwrOnk9cuXrWbi1S2TXTtXM3QH8uoQp509TsnnXLInw+Vz9VMf8DUM0pdKM7iCEZmwfu/MAAhFPsMY9LMm2Yan+9GIHkpKpHtDkbNY7KBactFPRqhBamaundWFqwKmf3u6IGkV1yajzS5Dd6xZpWWXemx1p98Eeg8Cfj/nbAy9rfxSgI2R5XNHFjfIOrDxaVqE8h5jM1F8vZcP8me/S1G63mViQUc/0QD9Svtk5XdjkFdAzfOqVvTOuELUzk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ea1ff8-eacb-4238-7f83-08d7106a69bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 19:09:12.1953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Asmaa@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB6293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah ok! I put that message on the cover letter. Thanks! I will make an updat=
e shortly.

-----Original Message-----
From: Corey Minyard <tcminyard@gmail.com> On Behalf Of Corey Minyard
Sent: Wednesday, July 24, 2019 3:07 PM
To: Asmaa Mnebhi <Asmaa@mellanox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Fix uninitialized variable in ipmb_dev_int.c

On Wed, Jul 24, 2019 at 01:45:57PM -0400, Asmaa Mnebhi wrote:
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Sorry to be picky here, but it's considered bad style to have an empty mess=
age.  I probably wasn't clear before, but you should add some text like "Fo=
und by build regression/improvement testing."
or something like that.  Just so people know where it was found.

Could you also add a "Fixes" field?  This is important in case someone pull=
s the original patch, they can look forward and see if any bugs were fixed.=
  From the kernel docs:

If your patch fixes a bug in a specific commit, e.g. you found an issue usi=
ng ``git bisect``, please use the 'Fixes:' tag with the first 12 characters=
 of the SHA-1 ID, and the one line summary.  Do not split the tag across mu=
ltiple lines, tags are exempt from the "wrap at 75 columns" rule in order t=
o simplify parsing scripts.  For example::

        Fixes: 54a4f0239f2e ("KVM: MMU: make kvm_mmu_zap_page() return the =
number of pages it actually freed")

I was going to do that myself, but since another spin is required...

Thanks,

-corey

> ---
>  drivers/char/ipmi/ipmb_dev_int.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/char/ipmi/ipmb_dev_int.c=20
> b/drivers/char/ipmi/ipmb_dev_int.c
> index 5720433..285e0b8 100644
> --- a/drivers/char/ipmi/ipmb_dev_int.c
> +++ b/drivers/char/ipmi/ipmb_dev_int.c
> @@ -76,7 +76,7 @@ static ssize_t ipmb_read(struct file *file, char __user=
 *buf, size_t count,
>  	struct ipmb_dev *ipmb_dev =3D to_ipmb_dev(file);
>  	struct ipmb_request_elem *queue_elem;
>  	struct ipmb_msg msg;
> -	ssize_t ret;
> +	ssize_t ret =3D 0;
> =20
>  	memset(&msg, 0, sizeof(msg));
> =20
> --
> 2.1.2
>=20
