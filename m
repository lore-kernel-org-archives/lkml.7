Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632D9C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFEA223A0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="XSyHigZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733045AbfGWPSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:18:32 -0400
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:53765
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfGWPSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 11:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzi2XSKPCKfORjsb9fbpuWHNKISyCgXGSFaF0wxrWFLXxQ5Lca5iHR0lnihyB0eQiCmkChvh4g/YAONibmw/iMOYu6m42b0MLDJYX8TZCq1B5aRevNxF2ezPyorInBzjk79wU+SK6Tdr7WjlEfGpoZvALA0PH3mpSLAc1AZCavna9iWIJu5h87wGVWB3TrANqxRoHtgCZaJSZJwsajdj15++oDEWCsHrK089HORnCLz04RdHHKLfb7ZOEOB/a2OLTCjItjafPMpn7hEqwwF2FrSC+C717YWvpr4W/PcUcXATGku5OSP8jwb3G+FL7X61KC1TQNljgvkLysrAQPfrJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qupE79+S4pFt3NIw03qKjajQx0W37foPBww2k5QXFh4=;
 b=J2HGDWctWiQD4MxK4w/E5A1n1cGef70O5gMb2biobaB3MWepGUEXhnXd+ryff0HYDWgLTJmxutq/Z6GAcMyy4TdWnWcj0En45LtsI6j1/J6766AZKv2usuT5OD0NC+rWPgv8ULeSix88aypI3mdvMaDXoN29YwdA7ELM7xIty4XWXvZiyLkYeH4KOrYaTYpVQuhNZ+WGkfhZo7JuhGVXbJpt/96Ut5EM/xW90xKGvm7IKtUYkT2NjD47+mwG+2HtuC5u0hX6Uhagq+xC/1hUf0R2IjkXLaSLN7dYPqBMOUcZAqmeVrWLxNDu2nUKiu+gtxU8AxMPFmQFmkgQWE0ZvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=mellanox.com;dmarc=pass action=none
 header.from=mellanox.com;dkim=pass header.d=mellanox.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qupE79+S4pFt3NIw03qKjajQx0W37foPBww2k5QXFh4=;
 b=XSyHigZaEDLMnvA81SUiitaYIfqnvj+DJlUy9D5KgViGOGjEqHM7DPdx+UqJwV+bzXuuM4OBCTgNp4U4F8raqq1wS92/8VJffPfYQVhMc6mXh8Z4/6aSJ99DRioCoz1rbn+YITV+zt7M8hvbRnuGv08O1w73LrlJNurrT/b5E6c=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.14; Tue, 23 Jul 2019 15:18:28 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::5c6f:6120:45cd:2880%4]) with mapi id 15.20.2094.013; Tue, 23 Jul 2019
 15:18:28 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Thread-Topic: [PATCH 4/6] nouveau: unlock mmap_sem on all errors from
 nouveau_range_fault
Thread-Index: AQHVQHIXnahvVYvmJ0qDJVLVLXdOZabYUtkA
Date:   Tue, 23 Jul 2019 15:18:28 +0000
Message-ID: <20190723151824.GL15331@mellanox.com>
References: <20190722094426.18563-1-hch@lst.de>
 <20190722094426.18563-5-hch@lst.de>
In-Reply-To: <20190722094426.18563-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:208:120::43) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.55.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1eba60d3-5cbe-48a4-8560-08d70f810399
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR05MB3279;
x-ms-traffictypediagnostic: VI1PR05MB3279:
x-microsoft-antispam-prvs: <VI1PR05MB32792EDA5AB184B9309EA75FCFC70@VI1PR05MB3279.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0107098B6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(189003)(199004)(8936002)(5660300002)(11346002)(81166006)(476003)(316002)(66066001)(33656002)(478600001)(305945005)(76176011)(54906003)(68736007)(36756003)(8676002)(7736002)(81156014)(99286004)(102836004)(2616005)(86362001)(6506007)(25786009)(386003)(26005)(186003)(446003)(6436002)(52116002)(6486002)(229853002)(6116002)(3846002)(486006)(1076003)(6512007)(2906002)(256004)(66446008)(53936002)(6246003)(71200400001)(14444005)(14454004)(4326008)(64756008)(66556008)(66476007)(66946007)(6916009)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB3279;H:VI1PR05MB4141.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s5E7ECNlhK2mr8Uxu41Us2POD4lN6Dl5hrcymzzumh5bUY9XScrftM244KymTbwCzxyAGy4LyNwaiOXmsj1Mwh+qwQB1EDUSv8AdFRpOkNRG4ejghxBpGArUw9aThHzllQ0mLNQAhuiwmIfAcjQTv3fJO+FZXT/0no9pl2kA5Af4egyWgYyTLgRsy4O0m1H+zg+ZsrfKBcOjOBj/Q20nT0H55ffVftliCBoKPVspOm8MkJBxhTsUQSZcThFje8HUDGEp2d/wGA2QMsYx3v4rlUzqsnWgiAG6GvIZpvz4gS69GSw91X7Zb5pvJt1Z7uofJC9f3OY/epYWkAhM8jgaBgWE+BFYZXQHUPUMjsGN57cWX4dlScwxeHwcWcfqs1QFOaHlvFo+bse6gf2mKu9YMTkAIexcEUbEQaK85uyILps=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B925593E81AF184DBCA6A2F968BAEBF5@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eba60d3-5cbe-48a4-8560-08d70f810399
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2019 15:18:28.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgg@mellanox.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:44:24AM +0200, Christoph Hellwig wrote:
> Currently nouveau_svm_fault expects nouveau_range_fault to never unlock
> mmap_sem, but the latter unlocks it for a random selection of error
> codes. Fix this up by always unlocking mmap_sem for non-zero return
> values in nouveau_range_fault, and only unlocking it in the caller
> for successful returns.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  drivers/gpu/drm/nouveau/nouveau_svm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouv=
eau/nouveau_svm.c
> index 5dd83a46578f..5de2d54b9782 100644
> +++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
> @@ -494,8 +494,10 @@ nouveau_range_fault(struct hmm_mirror *mirror, struc=
t hmm_range *range)
>  	ret =3D hmm_range_register(range, mirror,
>  				 range->start, range->end,
>  				 PAGE_SHIFT);
> -	if (ret)
> +	if (ret) {
> +		up_read(&range->vma->vm_mm->mmap_sem);
>  		return (int)ret;
> +	}
> =20
>  	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
>  		up_read(&range->vma->vm_mm->mmap_sem);
> @@ -504,11 +506,9 @@ nouveau_range_fault(struct hmm_mirror *mirror, struc=
t hmm_range *range)
> =20
>  	ret =3D hmm_range_fault(range, true);
>  	if (ret <=3D 0) {
> -		if (ret =3D=3D -EBUSY || !ret) {
> -			up_read(&range->vma->vm_mm->mmap_sem);
> -			ret =3D -EBUSY;
> -		} else if (ret =3D=3D -EAGAIN)
> +		if (ret =3D=3D 0)
>  			ret =3D -EBUSY;
> +		up_read(&range->vma->vm_mm->mmap_sem);
>  		hmm_range_unregister(range);
>  		return ret;

Hum..

The caller does this:

again:
		ret =3D nouveau_range_fault(&svmm->mirror, &range);
		if (ret =3D=3D 0) {
			mutex_lock(&svmm->mutex);
			if (!nouveau_range_done(&range)) {
				mutex_unlock(&svmm->mutex);
				goto again;

And we can't call nouveau_range_fault() -> hmm_range_fault() without
holding the mmap_sem, so we can't allow nouveau_range_fault to unlock
it.

Maybe this instead?=20

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouvea=
u/nouveau_svm.c
index a9c5c58d425b3d..92cf760a9bcc5d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -494,21 +494,16 @@ nouveau_range_fault(struct hmm_mirror *mirror, struct=
 hmm_range *range)
 	ret =3D hmm_range_register(range, mirror,
 				 range->start, range->end,
 				 PAGE_SHIFT);
-	if (ret) {
-		up_read(&range->vma->vm_mm->mmap_sem);
+	if (ret)
 		return (int)ret;
-	}
=20
-	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
-		up_read(&range->vma->vm_mm->mmap_sem);
+	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT))
 		return -EBUSY;
-	}
=20
 	ret =3D hmm_range_fault(range, true);
 	if (ret <=3D 0) {
 		if (ret =3D=3D 0)
 			ret =3D -EBUSY;
-		up_read(&range->vma->vm_mm->mmap_sem);
 		hmm_range_unregister(range);
 		return ret;
 	}
@@ -706,8 +701,8 @@ nouveau_svm_fault(struct nvif_notify *notify)
 						NULL);
 			svmm->vmm->vmm.object.client->super =3D false;
 			mutex_unlock(&svmm->mutex);
-			up_read(&svmm->mm->mmap_sem);
 		}
+		up_read(&svmm->mm->mmap_sem);
=20
 		/* Cancel any faults in the window whose pages didn't manage
 		 * to keep their valid bit, or stay writeable when required.
