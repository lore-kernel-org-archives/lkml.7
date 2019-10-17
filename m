Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440BFECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4DD2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 13:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d9mez6wv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437304AbfJQN5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 09:57:07 -0400
Received: from mail-eopbgr810072.outbound.protection.outlook.com ([40.107.81.72]:30064
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726470AbfJQN5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 09:57:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDTZB/Xja+y1t6xiCpPqzL46SaMR8A5LPmoDJb12Kmz5k8yzesaVXZPuRMCerElADED0Y/LmKrWAcHKPoXxKM/3ii6seUCQQ0mP+mRNOpqyZvND5UsdidduWgYuv1ici9iNG7culKKndvqI3tJww/znaqT7v1v0Yg7NfyQ+lv+TmxXmAPJoo2T/wB6T/Lfl3ldMGpkalTlim3sGJpbuUlatwFeaveTqFEh1t1or+oGealLc91b5GaO+aCz2jns5ruTO9uXMLKhq3vxz8I8mrthCOn18QLwGnGPd03r6+ekqcmSz/NXAj9cxTUQhZjxHAnPorAHV5gQX7Tux/yu44eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVrBsS1v9msEt9SREadT+7tJ/+srtvuv1XI/SWls5Xw=;
 b=UFsNjx/+OPqEHS/eqxhcsZXNL3qmvTvpB2H78MWNdwqkG4oyDzMDNz1hGkZluK6+LaG1SRmUQWGcbIoV+gEqvGU87OxTgNOej7iCDGwGy+Y3+gxZPVRFMYP6mVmlC6MvsjjtL/mFN7xgWJMSCF/hH3V6/63KQ3f0zCCwXXgxvvqnvX3Mxcc7ZyGCrzzzL65PJb0+/llBUYyQ87lCDLzsFqDLXow6ghIY4xHUv0g0kkLb12bGh+hHrhUE9yILCptEhJWRqWYnKy0Ik9I4p6ReoHDL3WB9WS7uKE7xE1h4ESZUnA2fkOfAy+Lm/YMLd8rC6PgxCNjnYiV/KuNcbHjloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVrBsS1v9msEt9SREadT+7tJ/+srtvuv1XI/SWls5Xw=;
 b=d9mez6wvcyXCaOzcQxMPYNhBl8XNYbYnyrgbZtnwDjW29A6IHwy2rec/2Mma9tWplAEXvb9EWushPapYxOhT4SzyfvuDINsTKmE5HtMq1f0vjnLuaY0BBpozg9+XrZFDbUZ5gKu3toZ1szEIdQauWMe2/pNTXLZt5iiLw/ICNBc=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.17) by
 BN6PR12MB1601.namprd12.prod.outlook.com (10.172.20.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Thu, 17 Oct 2019 13:56:22 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::f16d:2fda:9e18:a554%12]) with mapi id 15.20.2347.023; Thu, 17 Oct
 2019 13:56:22 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Topic: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
Thread-Index: AQHVd5goxXKghNLRDkOKQUyI++DOdKdGClsQgAACEYCADbLCgIAK7WQAgABJLVA=
Date:   Thu, 17 Oct 2019 13:56:21 +0000
Message-ID: <BN6PR12MB1809562679A0266AF1C43A81F76D0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1569891524-18875-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <BN6PR12MB18093C8EDE60811B3D917DEAF79D0@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20191001172941.GC4786@sirena.co.uk>
 <f9b1c3d5-6e02-354f-91b6-3b57e2f88bde@amd.com>
 <76668467-5edf-407a-a063-50f322fe785d@amd.com>
In-Reply-To: <76668467-5edf-407a-a063-50f322fe785d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06cc8126-30a9-4f9f-e888-08d75309cafe
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BN6PR12MB1601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR12MB1601B31FA1966D42E01A7AE6F76D0@BN6PR12MB1601.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 01930B2BA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(199004)(189003)(13464003)(8676002)(33656002)(99286004)(229853002)(3846002)(6116002)(81166006)(26005)(81156014)(102836004)(8936002)(446003)(11346002)(478600001)(76176011)(7696005)(6506007)(53546011)(25786009)(14454004)(4326008)(186003)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(256004)(9686003)(74316002)(110136005)(54906003)(86362001)(2906002)(316002)(66066001)(5660300002)(71190400001)(71200400001)(305945005)(486006)(52536014)(55016002)(476003)(6436002)(7736002)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1601;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mil2QAK0l2+kcjr96khjksu4e7ROlth3rXCBdtd2wmm64lAi3D44WCRudQ5jVhkI0KS5mHvgq4/14Sqm/OHjal+q976ZiOs1GWXT4xwsQPKeovE6sE6BFetPkUhMbVEZb1TIi6YVTCtVBfeXasb6wbvqJYSTs48SxeIwOApoJ6h9xUc+mYmmejM06PCeR/aLNwMcENBlgtfGMSfnpZYQqkyKE+BJFBm3+ofj393joIemXIbtSVQaflprquPS5Uvz1o4fVgqZzbJZad4BMszwTNoBb9320Fns7O3zHa2c615uv/xhqACMwjAzRfx2/fFHQCAquQkXT+PTGNKO7bHkjyCyLWoxfzKXSPX8pT2XSLeZjK1+KNBUGsxITI/k+JrQBzxkA7K462H3kuAcvkraZNlaBGaa33sBxyy3ghqWa34=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06cc8126-30a9-4f9f-e888-08d75309cafe
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2019 13:56:22.0679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBAIWOAB3AlQDVC97ri+Kqc2O8tFcDrytvGrlnuxCI0qjChYFY5lOOCgKMUyRO5J9FIolJcQIerz4yJ7JcEssg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1601
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: RAVULAPATI, VISHNU VARDHAN RAO
> <Vishnuvardhanrao.Ravulapati@amd.com>
> Sent: Thursday, October 17, 2019 5:33 AM
> To: Mark Brown <broonie@kernel.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: RAVULAPATI, VISHNU VARDHAN RAO
> <Vishnuvardhanrao.Ravulapati@amd.com>; Liam Girdwood
> <lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
> <tiwai@suse.com>; Mukunda, Vijendar <Vijendar.Mukunda@amd.com>;
> Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>; Colin Ian
> King <colin.king@canonical.com>; Dan Carpenter
> <dan.carpenter@oracle.com>; moderated list:SOUND - SOC LAYER /
> DYNAMIC AUDIO POWER MANAGEM... <alsa-devel@alsa-project.org>; open
> list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH 1/7] ASoC: amd: No need PCI-MSI interrupts
>=20
>=20
>=20
> On 11/10/19 3:03 AM, vishnu wrote:
> > Hi,
> > Please find my inline comments.
> >
> > Thanks,
> > Vishnu
> >
> > On 01/10/19 10:59 PM, Mark Brown wrote:
> >> On Tue, Oct 01, 2019 at 05:23:43PM +0000, Deucher, Alexander wrote:
> >>
> >>>> ACP-PCI controller driver does not depends msi interrupts.
> >>>> So removed msi related pci functions which have no use and does not
> >>>> impact on existing functionality.
> >>
> >>> In general, however, aren't MSIs preferred to legacy interrupts?
> >>
> >> As I understand it.=A0 Or at the very least I'm not aware of any
> >> situation where they're harmful.=A0 It'd be good to have a clear
> >> explanation of why we're removing the support.
> >
> > Actually our device is audio device and it does not depends on MSI`s.
> > So we thought to remove it as it has no purpose or meaning to have
> > this code in our audio based ACP-PCI driver.
> >
> >>> Doesn't the driver have to opt into MSI support?=A0 As such, won't
> >>> removing this code effectively disable MSI support?
> >>
> >> Yes.
> >
> >
>=20
> Hi Mark,
>=20
> Any updates on this patch.

You are removing functionality from the driver with no rational as to why i=
t's necessary.  What's the point of this patch?  Does it fix a particular i=
ssue?  If not, I suggest just dropping it.  The hw supports MSIs, why not u=
se them?

Alex

