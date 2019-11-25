Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2A3C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802B2071E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 19:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ImH41AaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfKYTva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 14:51:30 -0500
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:3301
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfKYTv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 14:51:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTN6IMJj3WIpTaWkyggyI3xUQ88+87T75/eQbkvRgBgVFx1EQbeIXHTIcbhwsT5QIw/l+B9R+9odphSawgXProMgKFrDjq2R65OxgFrNImIm/pXzQPdcs1Piqvb5Ufln7/XsdnbiVPQCdMEod8SJSEhb0JpEabaPmc7Y6W9WTGd7+8y9uhejLsw8s3XdedchhfQqB7SjjsIbaTkYhPWnYQY/Z9MRbnXALcrnB8tvmoH7uCa4EL068TitwIqAwRT15uqF3qlMP33fEaFJ1DoCgLJscoi2vhLtSpcBnf+5hDRbSEnNqQPCfiEe/yk+t0vnDacwEzaOBGNIndFzblOhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvzCXSvZfaG21xkQ7plfiyUnK3tVBGIx55sp7HPeY7M=;
 b=U5QgVpIfnC3h+pL9JCGH3mN2DfjtQ9Hd6aGMszp1T80dlXN1WJI0MZHnvn132sLXZUrcl5YXjF9K8r+Ssxx8hsLDiuukg/5bjtnKFd8r4Q1GZYd41G6tbU4lwytRXRjGoFGK3gvzzM3cxU03GyprGhq4EPa1G7bhQ7G16R6HCLhuqce6qz8+Rl+JuRC64pvHFHCdYF8sVkN0UmlYBWnkFlClYi3pFlVSIv4zgFc+Pi4LpHfDHSlG/QVwiwxRiP5tp1wvIlzL/iCIH7fY3fSYtsMBLOOw5aOjVMOrBNL176X5dzOp5itRbJxwNLhzVV1NetBywtYjNZXS+DEc+Vy74w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvzCXSvZfaG21xkQ7plfiyUnK3tVBGIx55sp7HPeY7M=;
 b=ImH41AaWi2/UZrXykXStjKBKErM+xmgvAtlEeMKSZvnFKmIzUFq2ST+iKQjydgFRhG5vZd2kkqrK86XJ9YqNCq+zZXY7fisp7ihziz5rKxR9vwfqm+hf8NKRlElyahAjS4RmPhP2QuR5ZQa6d0cgkzoUCbyChtZc1Ov6dZD66X8=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1873.namprd12.prod.outlook.com (10.175.99.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Mon, 25 Nov 2019 19:51:26 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::a53c:342f:cd6e:a616]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::a53c:342f:cd6e:a616%9]) with mapi id 15.20.2474.022; Mon, 25 Nov 2019
 19:51:26 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVoquTUTVQaSMM2UiGavCfZW6oraecTBeQ
Date:   Mon, 25 Nov 2019 19:51:26 +0000
Message-ID: <BN6PR12MB18096EFA4FC32961BFED87B2F74A0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20191124094253.3433-1-kai.heng.feng@canonical.com>
In-Reply-To: <20191124094253.3433-1-kai.heng.feng@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7505e1db-0302-441b-362e-08d771e0db69
x-ms-traffictypediagnostic: BN6PR12MB1873:|BN6PR12MB1873:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB18737785F30471D50BC18CADF74A0@BN6PR12MB1873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(13464003)(199004)(189003)(7736002)(102836004)(6506007)(71200400001)(74316002)(33656002)(2906002)(52536014)(76116006)(8676002)(81156014)(81166006)(71190400001)(53546011)(2501003)(6436002)(26005)(25786009)(54906003)(6246003)(110136005)(186003)(5660300002)(229853002)(3846002)(6116002)(446003)(11346002)(14454004)(316002)(8936002)(7696005)(76176011)(66066001)(64756008)(66556008)(66946007)(55016002)(4326008)(6636002)(478600001)(99286004)(14444005)(9686003)(256004)(6306002)(66446008)(966005)(86362001)(305945005)(45080400002)(66476007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1873;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9iAxaGrss4BCZB/Kpu+g0NAmO7bh6zEkitdtFR82YYTL/NSIKedpIwtDvvL/4f/ym1vcN8pFLfBoqKWVjcGkwHMudVRRmWL5WJdNT6tnj/3gPzYEYRCRNGQhF5nZ0WJWqWEXUNe8173SY1vc4RJPJJSMPi6FM4OVPbbAvr+nz9qf1MW52jPhHQn6URiI85nlcOlIKIea4N98i8nr2Yp/OrrI5izWyPteIIVMwvT+lfzFt9LsV4Khsab/LGfPp+FYzaWP8qKgtXxSid0ustZHKYadFFSgduLoqL2uEOHgAI8+iX/odJhx6gnD57GURDFoMp0g6VUqLqBURE/QHVFVb+ar7URI6AYC2bpMv3pUc1cpOnuZeGW8HZhsU5bK0uaQG5DeWwKoPSiRriBMzl76vfaziHXVxG13UorpUQl+ZB0wPxJTdAOm93tMkRqUVNe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7505e1db-0302-441b-362e-08d771e0db69
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 19:51:26.2443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 82EZozwDpJrT0kLpxNQp5W9ELrkxiW88yK2tGSnk1xa8JHVeJv+59iMZWZ2kwe+gm0u3gCKvJRdU+EBlXDEsSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1873
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Sunday, November 24, 2019 4:43 AM
> To: joro@8bytes.org
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Kai-
> Heng Feng <kai.heng.feng@canonical.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH] iommu/amd: Disable IOMMU on Stoney Ridge systems
>=20
> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
>=20
> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's do th=
e
> same here to avoid screen flickering on 4K monitor.
>=20
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla
> b.freedesktop.org%2Fdrm%2Famd%2Fissues%2F961&amp;data=3D02%7C01%7
> Calexander.deucher%40amd.com%7C75a108e9888645728fc208d770c2b418%
> 7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637101853875648481
> &amp;sdata=3DeQ%2FmiFfy%2FHRJSVurfdnvT%2FLdNMYetIPQdFgnU93l%2Fks
> %3D&amp;reserved=3D0
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/iommu/amd_iommu_init.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iommu/amd_iommu_init.c
> b/drivers/iommu/amd_iommu_init.c index 568c52317757..e05f1b269be6
> 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -2516,6 +2516,7 @@ static int __init early_amd_iommu_init(void)
>  	struct acpi_table_header *ivrs_base;
>  	acpi_status status;
>  	int i, remap_cache_sz, ret =3D 0;
> +	u32 pci_id;
>=20
>  	if (!amd_iommu_detected)
>  		return -ENODEV;
> @@ -2603,6 +2604,13 @@ static int __init early_amd_iommu_init(void)
>  	if (ret)
>  		goto out;
>=20
> +	/* Get the host bridge VID/PID and disable IOMMU if it's Stoney
> Ridge */
> +	pci_id =3D read_pci_config(0, 0, 0, 0);
> +	if ((pci_id & 0xffff) =3D=3D 0x1022 && (pci_id >> 16) =3D=3D 0x1576) {

I'm not sure if the IOMMU device id is unique to stoney.  I think it's the =
same DID for the entire APU generation.   I think it would be better to wal=
k the bus and try and find the stoney GPU and only in that case, disable th=
e IOMMU.  E.g., if the user has disabled the GPU portion of the APU or has =
a dGPU installed, they may will want to use the IOMMU.  It's only the integ=
rated GPU that has a problem when trying to display high res modes out of s=
ystem memory with the IOMMU due to the added latency.
The stoney GPU is VID 0x1002, DID 0x98E4.

Alex

> +		pr_info("Disable IOMMU on Stoney Ridge\n");
> +		amd_iommu_disabled =3D true;
> +	}
> +
>  	/* Disable any previously enabled IOMMUs */
>  	if (!is_kdump_kernel() || amd_iommu_disabled)
>  		disable_iommus();
> @@ -2711,7 +2719,7 @@ static int __init state_next(void)
>  		ret =3D early_amd_iommu_init();
>  		init_state =3D ret ? IOMMU_INIT_ERROR :
> IOMMU_ACPI_FINISHED;
>  		if (init_state =3D=3D IOMMU_ACPI_FINISHED &&
> amd_iommu_disabled) {
> -			pr_info("AMD IOMMU disabled on kernel command-
> line\n");
> +			pr_info("AMD IOMMU disabled\n");
>  			init_state =3D IOMMU_CMDLINE_DISABLED;
>  			ret =3D -EINVAL;
>  		}
> --
> 2.17.1

