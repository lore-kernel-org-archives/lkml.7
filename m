Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02DC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15E920709
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 01:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GLDmQ/zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfKUBxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:53:53 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:26598 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbfKUBxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 20:53:53 -0500
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd5ee2f0000>; Thu, 21 Nov 2019 09:53:51 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 20 Nov 2019 17:53:49 -0800
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 20 Nov 2019 17:53:49 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Nov
 2019 01:53:48 +0000
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.56) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 21 Nov 2019 01:53:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvgObiOIu/9r3CDoxCjQKGDe+5ySVMzDDsKT5xoZJj2fpvyNluhtV/qBg1vA42kuKN9WnDvMHYXLtbVDYapToq9NsUvaPQRQSyZhmdZxnrTX8h7SZdaUAqf0a5QMuKSEqoS8jTtf/lQdocAUsyf1RrpSkCFkErrwlY51mlJ9Y+9AYhHDvUTjbU6tvGN0240qFNWiSOKDpJztJsaL2DMlMNdBvTiEqgCIpXQncpAbOPF155F7iolpx7zhlT1z5JErXde0PyFv8uJi6wEr16SsU4F7hZLCScHyaIlqRasL/AiDwdZGAALrLiZ6vfVpXpYVQJ2fGANwTLEiy9De7Q+wrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=as+OtNCW2+16zGX976SmPal+sVVgxX+4F/Ac+dE8XCM=;
 b=np0sjRzu2K0BDUfEqS6cMXlDvNAVdmn1QqcQ54ikYQtkm+b2i7diICYj8bLO2xcPOqcoIHBrZVjhULgCK8H5DiWM6RtTwy48hCLqs9O0x7Jh3/83hQrw9zzQP2T8asKkHCG9IoMudXvrCmAEETfDTLL4kc6a87YJX+UZWX1XSFfeUyAfZr+XmLKyixmsSxJn2pp5vCWdDV+n74jQImWGJ1ZyGXPdYuKrDw33PsyOcYa3b+2v3r5DKoFDfGhs/yemhxl+GtX4NPy7cup8MPI+B11LMFVZRiNgNlVBHK0JqTMXoPCvEXs24dwPxJPabgPX4qDGvlPoJYn4MG/82KdiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from MN2PR12MB3389.namprd12.prod.outlook.com (20.178.242.161) by
 MN2PR12MB3136.namprd12.prod.outlook.com (20.178.244.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 21 Nov 2019 01:53:43 +0000
Received: from MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce]) by MN2PR12MB3389.namprd12.prod.outlook.com
 ([fe80::457a:dc11:397f:d4ce%7]) with mapi id 15.20.2451.032; Thu, 21 Nov 2019
 01:53:43 +0000
From:   Henry Lin <henryl@nvidia.com>
To:     Jack Pham <jackp@codeaurora.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] usb: xhci: only set D3hot for pci device
Thread-Topic: [PATCH v3] usb: xhci: only set D3hot for pci device
Thread-Index: AQHVnrHTQOCmI7fogkC/eeXWnSpur6eUcLKAgABuKww=
Date:   Thu, 21 Nov 2019 01:53:42 +0000
Message-ID: <MN2PR12MB33896F7985965196603FE7FCAC4E0@MN2PR12MB3389.namprd12.prod.outlook.com>
References: <20191113014927.11915-1-henryl@nvidia.com>
 <20191119081656.8746-1-henryl@nvidia.com>,<0101016e8a3ed405-a70f7e87-8c4b-4759-910f-9b9753a9dabb-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016e8a3ed405-a70f7e87-8c4b-4759-910f-9b9753a9dabb-000000@us-west-2.amazonses.com>
Accept-Language: en-US, zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=henryl@nvidia.com; 
x-originating-ip: [59.124.78.18]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bdb6837-589a-4d1c-df15-08d76e25a375
x-ms-traffictypediagnostic: MN2PR12MB3136:
x-microsoft-antispam-prvs: <MN2PR12MB313675B1AC8F1D51E2234C6FAC4E0@MN2PR12MB3136.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(9686003)(74316002)(33656002)(66476007)(6436002)(54906003)(26005)(14454004)(52536014)(66446008)(66556008)(66946007)(316002)(446003)(8676002)(7736002)(11346002)(476003)(486006)(6246003)(81166006)(6916009)(229853002)(25786009)(2906002)(102836004)(478600001)(4326008)(186003)(81156014)(55016002)(8936002)(4744005)(305945005)(3846002)(6116002)(66066001)(86362001)(6506007)(76116006)(91956017)(71200400001)(71190400001)(76176011)(256004)(5660300002)(99286004)(64756008)(7696005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3136;H:MN2PR12MB3389.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ViUEaG1GUTGJq+SlQ83Xf3ADpWWkDpZipOE3J7Cj5crWzqnlXSquQpuNKAsfdbOi5Dmqlj7l40KuNNdCiOX8NgUSOFaK7Z+ETNBX1PWL6Jykvx5I4Lqtl+pPlecuEsOcX2Qc2TowIvsI39WZ7Bse7zi8Cjhjf457hXSXMZYyv0BEX/Gl6tLBpWaJegwD+EOkR2LS+xL9jhg33xtvIRxg9afYqj/cJT0OTIPLJ8kj6Hr26/e7jdNBc9nS9dI8zC7sGjP/4xT+3O604LHxOchmNJSuh0FGz68jVMLnu2qNwBR9Gn7M+F49guhksPmNYO6LXiO+bS1RDw2qTO81W1hl4qIvZIxONqFpqammkJn/SpLjgboBFXfsqMdqvY7mgV+YoOlLApWlB9rGjDtllYRZlhw3VAPXTwl/rCEKMnWlTfXr3s85Fnbs0bTXXReWXJC4
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdb6837-589a-4d1c-df15-08d76e25a375
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 01:53:43.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjJx8wNbSi+zNVkxaSmO6ZNtoDW5KL5E2QPAFXG3eaUiikV6CLHXcd3sfJQTyGfomjfT+WNcG+zspi2GEliOXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3136
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574301231; bh=as+OtNCW2+16zGX976SmPal+sVVgxX+4F/Ac+dE8XCM=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-ms-exchange-transport-forked:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=GLDmQ/zqldOZ/0r6ScD/9fL6tM14HDx/N47iQXhi7pI1yCSlPUSjM/ekaDFvmhuGZ
         WDe+aN2h+yMXYbuhK/BlsXEmS1qOf8VMb5J2bCSj0bQ8ZP50DPkm0newGDgAttPTgf
         Vrjn5ZwQkBjtJEpmFXckYICIQAWPVFRzKq8FR0g8o3PtTbU1Sk1KOinlzweNSgpeqE
         OXEjAMvmm/qhzjGfX/Crc/FPfeEAWhPKMKpoWkeezX5A1giOHbBcEKTwyh5eQbtRuf
         t0J7QZrueB/OST6yey/EnJtBlfwrzVQWyLSgPC3OeBdU1RS8vXNkhTGhmRKbhd5DOv
         Fyi9wYXXd1kzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -770,7 +770,7 @@ static void xhci_stop(struct usb_hcd *hcd)=0A=
>>   *=0A=
>>   * This will only ever be called with the main usb_hcd (the USB3 roothu=
b).=0A=
>>   */=0A=
>> -static void xhci_shutdown(struct usb_hcd *hcd)=0A=
>> +void xhci_shutdown(struct usb_hcd *hcd)=0A=
>>  {=0A=
>>       struct xhci_hcd *xhci =3D hcd_to_xhci(hcd);=0A=
>>=0A=
>> @@ -789,10 +789,6 @@ static void xhci_shutdown(struct usb_hcd *hcd)=0A=
>>       xhci_dbg_trace(xhci, trace_xhci_dbg_init,=0A=
>>                       "xhci_shutdown completed - status =3D %x",=0A=
>>                       readl(&xhci->op_regs->status));=0A=
>> -=0A=
>> -     /* Yet another workaround for spurious wakeups at shutdown with HS=
W */=0A=
>> -     if (xhci->quirks & XHCI_SPURIOUS_WAKEUP)=0A=
>> -             pci_set_power_state(to_pci_dev(hcd->self.sysdev), PCI_D3ho=
t);=0A=
>>  }=0A=
=0A=
>Shouldn't this function also now need to be EXPORTed?=0A=
Yes. I will add EXPORT_SYMBOL_GPL() for it.=
