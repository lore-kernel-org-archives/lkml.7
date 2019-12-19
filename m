Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC476C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3969222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 19:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IeudtLmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLSTPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 14:15:40 -0500
Received: from mail-bn8nam11on2045.outbound.protection.outlook.com ([40.107.236.45]:6233
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726908AbfLSTPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 14:15:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrl1UGNqNH7ZEtgHTrvFNpBfgm1QIiIJmhE8d89mKNU1ZvIYZp+0JUtHJwf6MH8wSTnci6bUzpqdcb6jSdrPFWWxOATnSahXKbCrzvNmOs3JfXHCiONFJL3axxRwwycSL4z8qUoQqSlk3jraXBIAQzaf6BRzJy/10Zp5pdkUpTgAJhhT/33MkNa/nqZMLAT4V95Soc+mKSR52SdPdLcERVEu/+5WZKIbXmFN7psl5LYUeE2TZEwd5ia+oKXs4ds7lQag1/uL4eRD6QNG51rrBXn7FSqnNpbSOGAwQDrrZB+QzwaZKLQH6aNnaKk84wMEcUT91ECAPO4i+r0+sAQpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B00Evl5Ap4uGxLA9CFlsB1BWEmflAn5Dzc0+/mQgHTU=;
 b=ZusbQBbmSL3qq+Sa7KrbUsxLN94D45AW9UhxQEJq6EC5og7nZ1xkDmU7UgxnmFVQAw+XkgtU86yJ5MWbKEfplvtGWThmZG0JnW0wmmCjuuIIhm+ZfUe17CMiios/d7KcsN1EOJ9yxaScTSIdYH5+785dzZrS78TatphQio8jHbLMRkRn3X2eXEiqiUx92nkx9LcWADzYA7G3MhkmLkakE5UN1gPwgq8ftBAKtY5EaykeX0FcqhXv1dHaspx9C21A1bsoLu57CukfzCvOdKuJ6H5Krj/nIUKut0tkCv37rFNQvWVLODgLk5Np1hvMVBM1fAdu7HnLGJNcCW2ecwS7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B00Evl5Ap4uGxLA9CFlsB1BWEmflAn5Dzc0+/mQgHTU=;
 b=IeudtLmIpsSfEFjULCqJq+J/bZNDz4hcQugXycsD9LJQsTy8bsy1jn5wokFp4xCWdjUTHZaHGYKaZlcPBXPEeVajsGl2fsX0xNumb0+qzBx0xBs46tngSA3tkhBVlJpLbU25uWlWcS6zp2a4JO0hU+1PSh+z4G7nLPTp08yGPAM=
Received: from CY4PR12MB1350.namprd12.prod.outlook.com (10.168.169.7) by
 CY4PR12MB1847.namprd12.prod.outlook.com (10.175.60.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Thu, 19 Dec 2019 19:15:33 +0000
Received: from CY4PR12MB1350.namprd12.prod.outlook.com
 ([fe80::a853:ee41:9aca:ecdd]) by CY4PR12MB1350.namprd12.prod.outlook.com
 ([fe80::a853:ee41:9aca:ecdd%9]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 19:15:33 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVpsBguKm4D8iWWkiQt39oc44V0aenFmmAgAWQOoCAEYuVgIACFhIAgAGraTA=
Date:   Thu, 19 Dec 2019 19:15:32 +0000
Message-ID: <CY4PR12MB13505BE6EFF95F7C48253120F7520@CY4PR12MB1350.namprd12.prod.outlook.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <20191202170011.GC30032@infradead.org>
 <974A8EB3-70B6-4A33-B36C-CFF69464493C@canonical.com>
 <20191217095341.GG8689@8bytes.org>
 <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
In-Reply-To: <6DC0EAB3-89B5-4A16-9A38-D7AD954DDF1C@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24d18bb8-0f56-48f5-8a3c-08d784b7d203
x-ms-traffictypediagnostic: CY4PR12MB1847:
x-microsoft-antispam-prvs: <CY4PR12MB184768C14646FBDC435BC601F7520@CY4PR12MB1847.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(189003)(199004)(13464003)(478600001)(52536014)(55016002)(186003)(81156014)(81166006)(8936002)(26005)(6506007)(86362001)(4326008)(53546011)(66556008)(66476007)(64756008)(66446008)(33656002)(9686003)(76116006)(54906003)(2906002)(7696005)(5660300002)(66946007)(110136005)(8676002)(71200400001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1847;H:CY4PR12MB1350.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eA/hRlCKVYcW38LtA1TQJFnIb9SYi1tcWlFFZXL4xDuYMqH9c/UO/inprBWueot1rGIepOfb1eFLn1pUt6CRqqmjSZWF1NbBei/rdLeRZIQrIp13vc2ZiHB2YATa3OBQJ5t/Tg3IvCgadXnJ5weZh1+R6b+1kM4slX1rgF2hjJAUFzAfsBsdalOtWwZSEo36Ltk8WUiV7sdsHv/KnC70CM/82xHeR5XZg1/NrobRJduERohNfIDmqYETDwr+drXSYQ3R2VstfA6vsq1E7bDubPNlPvnaHUda6uJVtuuI4iZen96XNlY8hcdt11/ihqBFwP/g3eBsc2kKO18VeNbOKbwUxKdG2tJLAvbxVOrTLLE2ZNcCcO0TqWHgp7hPIeRGXDqelxuzahsLiB2pJ8NdnZ1Ls0beorfSpUZ4gVMnYSLBaMY5l6kXX8XR2RVOb0N/oxxQTDsEmm1lcG/1rtAA3XRmG2MWjHmKT1Yy8PVaSJ/Z50u5s0FDkdKLZvggJkDW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d18bb8-0f56-48f5-8a3c-08d784b7d203
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 19:15:33.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cIx+oFVQMUvHF/MbgBwz5Oa2BVSrP+2cxgAzvb3aJPNJwgMTeWjScpN+sv7a3wwbBOKt8nY58+0qzCWuk1eklw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Wednesday, December 18, 2019 12:45 PM
> To: Joerg Roedel <joro@8bytes.org>
> Cc: Christoph Hellwig <hch@infradead.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; iommu@lists.linux-foundation.org; Kernel
> development list <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge
> systems
>=20
>=20
>=20
> > On Dec 17, 2019, at 17:53, Joerg Roedel <joro@8bytes.org> wrote:
> >
> > On Fri, Dec 06, 2019 at 01:57:41PM +0800, Kai-Heng Feng wrote:
> >> Hi Joerg,
> >>
> >>> On Dec 3, 2019, at 01:00, Christoph Hellwig <hch@infradead.org> wrote=
:
> >>>
> >>> On Fri, Nov 29, 2019 at 10:21:54PM +0800, Kai-Heng Feng wrote:
> >>>> Serious screen flickering when Stoney Ridge outputs to a 4K monitor.
> >>>>
> >>>> According to Alex Deucher, IOMMU isn't enabled on Windows, so let's
> >>>> do the same here to avoid screen flickering on 4K monitor.
> >>>
> >>> Disabling the IOMMU entirely seem pretty severe.  Isn't it enough to
> >>> identity map the GPU device?
> >>
> >> Ok, there's set_device_exclusion_range() to exclude the device from
> IOMMU.
> >> However I don't know how to generate range_start and range_length,
> which are read from ACPI.
> >
> > set_device_exclusion_range() is not the solution here. The best is if
> > the GPU device is put into a passthrough domain at boot, in which it
> > will be identity mapped. DMA still goes through the IOMMU in this
> > case, but it only needs to lookup the device-table, page-table walks
> > will not be done anymore.
> >
> > The best way to implement this is to put it into the
> > amd_iommu_add_device() in drivers/iommu/amd_iommu.c. There is this
> > check:
> >
> >        if (dev_data->iommu_v2)
> > 		iommu_request_dm_for_dev(dev);
> >
> > The iommu_request_dm_for_dev() function causes the device to be
> > identity mapped. The check can be extended to also check for a device
> > white-list for devices that need identity mapping.
>=20
> My patch looks like this but the original behavior (4K screen flickering)=
 is still
> the same:

Does reverting the patch to disable ATS along with this patch help?

Alex

>=20
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index bd25674ee4db..f913a25c9e92 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -42,6 +42,7 @@
>  #include <asm/iommu.h>
>  #include <asm/gart.h>
>  #include <asm/dma.h>
> +#include <asm/pci-direct.h>
>=20
>  #include "amd_iommu_proto.h"
>  #include "amd_iommu_types.h"
> @@ -2159,6 +2160,8 @@ static int amd_iommu_add_device(struct device
> *dev)
>         struct iommu_domain *domain;
>         struct amd_iommu *iommu;
>         int ret, devid;
> +       bool need_identity_mapping =3D false;
> +       u32 header;
>=20
>         if (!check_device(dev) || get_dev_data(dev))
>                 return 0;
> @@ -2184,7 +2187,11 @@ static int amd_iommu_add_device(struct device
> *dev)
>=20
>         BUG_ON(!dev_data);
>=20
> -       if (dev_data->iommu_v2)
> +       header =3D read_pci_config(0, PCI_BUS_NUM(devid), PCI_SLOT(devid)=
,
> PCI_FUNC(devid));
> +       if ((header & 0xffff) =3D=3D 0x1002 && (header >> 16) =3D=3D 0x98=
e4)
> +               need_identity_mapping =3D true;
> +
> +       if (dev_data->iommu_v2 || need_identity_mapping)
>                 iommu_request_dm_for_dev(dev);
>=20
>         /* Domains are initialized for this device - have a look what we =
ended up
> with */
>=20
>=20
> $ dmesg | grep -i direct
> [    0.011446] Using GB pages for direct mapping
> [    0.703369] pci 0000:00:01.0: Using iommu direct mapping
> [    0.703830] pci 0000:00:08.0: Using iommu direct mapping
>=20
> So the graphics device (pci 0000:00:01.0:) is using direct mapping after =
the
> change.
>=20
> Kai-Heng
>=20
> >
> > HTH,
> >
> > 	Joerg

