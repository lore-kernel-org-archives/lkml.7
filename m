Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186C4C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858D2342F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bi+67q9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfH3SQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 14:16:11 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9275 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3SQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 14:16:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6967ea0001>; Fri, 30 Aug 2019 11:16:10 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 30 Aug 2019 11:16:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 30 Aug 2019 11:16:08 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Aug
 2019 18:16:08 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.54) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 30 Aug 2019 18:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l60QvOkITuq4NumLGWaweQmOFZ9gK1caZ3YQ9S1p+HwRsrBgB5EF206tY+qDKp3ETcd9QSJ0wg6e7pU3ozLKwX3d+KV0bQmxa6neIyOASHd2sOvQCzWWrwccENuoF3IvYUfeYc8/qBaWiTcyzsR78x45N74fQFU9vPQe94aIi+nXKWa0WGWslO7tJK7OtVOcmfYj4OqpyJu1hdVl5r1+Eif8f7ymYWnb1j9GzsyAXeB0O/SvkUekXog+tYPnH9so+9+o++XL23wXQpBgZ9+nHB1qcNSRnyU6bRMRij7JIKRkVBPY28Tzhqfwib5C0oXc9CTOO0lyRZUQGxYW8O9uMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q58EjWQJyW0GmdS5OjjpB5SaY8gDQCjHZ9Z5EE9pOu4=;
 b=G75FGwBACgBHuTfIOG5h2OlxQRyNttr/CutK56vf15WiqZcPpyrxznhjshwKs4ds4o6h0iQUszyp1woMOjFIHHKfa/MUpYqnM+RAxSe3eAbqeToUSIlfQionqmoE1INpBUjmeI/w6p7+WXB9D1cD8jUWgWAMZMamCD4O/XSIc9UUoLrpq8QkQedHidjOx36TAbm5FYVKuJhhlKAympH0NzzqiZuc5v8BmrriNYOQZcmCwcLCo8Gp366u+36pBYW7kijNI1PWN798vdh+4v3yfRc32LgsKVQDmlzbGZ1G1kPkdwFKUapMFiRgkfwaIIiEX8w9/C52/h7u71SOY9+RJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3576.namprd12.prod.outlook.com (20.178.197.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Fri, 30 Aug 2019 18:16:05 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Fri, 30 Aug 2019
 18:16:05 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Sachin Nikam <Snikam@nvidia.com>,
        "Thomas Zeng (SW-TEGRA)" <thomasz@nvidia.com>,
        Juha Tukkinen <jtukkinen@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Pritesh Raithatha <praithatha@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Timo Alho <talho@nvidia.com>, Yu-Huan Hsu <YHsu@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Alexander Van Brunt <avanbrunt@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH 1/7] iommu/arm-smmu: add Nvidia SMMUv2 implementation
Thread-Topic: [PATCH 1/7] iommu/arm-smmu: add Nvidia SMMUv2 implementation
Thread-Index: AQHVXruJtN0dV6uzzEqjzwhw4G/PK6cTynmAgAA1HEA=
Date:   Fri, 30 Aug 2019 18:16:05 +0000
Message-ID: <BYAPR12MB2710D045303BE89A7D3FF2C1B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-2-git-send-email-vdumpa@nvidia.com>
 <2ae9e0c4-6916-b005-f4bd-29e06d2056c6@arm.com>
In-Reply-To: <2ae9e0c4-6916-b005-f4bd-29e06d2056c6@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-08-30T18:16:02.1702597Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=719396a2-db9b-4c3c-af08-b4b130e729d4;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa2a69b-de19-44e8-7242-08d72d761f7c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3576;
x-ms-traffictypediagnostic: BYAPR12MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3576966C6D06F6D843283452B3BD0@BYAPR12MB3576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0145758B1D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(199004)(189003)(5660300002)(229853002)(186003)(8936002)(14454004)(316002)(25786009)(4326008)(76176011)(52536014)(33656002)(7736002)(26005)(8676002)(64756008)(66946007)(99286004)(6116002)(81156014)(3846002)(66446008)(66476007)(76116006)(7696005)(81166006)(66556008)(102836004)(71190400001)(71200400001)(2906002)(55016002)(4744005)(54906003)(6506007)(11346002)(446003)(478600001)(53936002)(66066001)(256004)(74316002)(6246003)(6916009)(486006)(6436002)(9686003)(86362001)(305945005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3576;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3i9CPVbSRcLguZUCbBmUl7xt0RS8Kr57XabDmKQ9z9hx16tGlmELV4PdbEE8c9J7recYDNYkqKigAUAeCheyH/R1PXWSSTDYcwcKcu7hLbPFMZp0iMXrDwilDHAiqy5ShOBFdly1ImwaSBwWc+K1CoP8iOeTNVeL+i1GU9pFSzAdK91onM55tDBZwt2nvq7hdGeFr930+hWJy8C9MUj17bCaD+YCExddZUHawgOTsuGcKKx/9hfrf4r4B4ZZqaqEI5sppeckVOXVO8fs7LogDrM50iiOk3Xe4WcI+4xd0DUxFlvk5HWmiQDy42Ey/bhsDc9eoyZpwRvUVa2JrlIF9/h366+uwFtK7XtyaRFn+HT5L/f7bXROQINJ133k0v51nRjkYhbLFVRG4OWCVaz76I/pxoNiqjFnq0b0KPWmCw8=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa2a69b-de19-44e8-7242-08d72d761f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2019 18:16:05.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tR9IcYUTaJtovJoe63L5+hflVH7kcpeNMtqlaZ6+QKFDQGAAP+JxvVC21eOuy/fDai+1wfQEvx+jhrpR81meyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567188970; bh=Q58EjWQJyW0GmdS5OjjpB5SaY8gDQCjHZ9Z5EE9pOu4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-microsoft-antispam:
         x-ms-traffictypediagnostic:x-ms-exchange-transport-forked:
         x-microsoft-antispam-prvs:x-ms-oob-tlc-oobclassifiers:
         x-forefront-prvs:x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=bi+67q9/gXF511pd+SesAp24kh9ZBbopRbDLkPA5OqVaN+D4PPMnjPmre14Flf9WW
         zpP/fYqIazYmtdykC1UeNGxKCj8CDjdY0z4b2HNio97KFW38Q5zH/B/SkZ4A1g+lmI
         r8ZBQtAxoExdF/dhlYcXQVUNiQjjEE6fYph69uWAl0JruQh3l7tRWUJ/ibqGkA0Ldy
         /m0zDkXDbyOE//jLlwBKtlb4BGVbf/YBfTBICaAtPtshdhUL4C4Ys4eoPV3LGSljDP
         Ia1Nqh5wPyiYH+G6E5HKlUYeSzRpxgkywZ09uscJ9uzTgn94h0/fL6jYEJ8+Q9XG0o
         7U8fBSV53Rv3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gK0FSTV9TTU1VX01BVENIX0RBVEEobnZpZGlhX3NtbXV2MiwgQVJNX1NNTVVfVjIsIE5WSURJ
QV9TTU1VVjIpOw0KDQo+IEZyb20gdGhlIHByZXZpb3VzIGRpc2N1c3Npb25zLCBJIGdvdCB0aGUg
aW1wcmVzc2lvbiB0aGF0IG90aGVyIHRoYW4gdGhlICdub3ZlbCcgd2F5IHRoZXkncmUgaW50ZWdy
YXRlZCwgdGhlIGFjdHVhbCBTTU1VIGltcGxlbWVudGF0aW9ucyB3ZXJlIHVubW9kaWZpZWQgQXJt
IE1NVS01MDBzLiBJcyB0aGF0IHRoZSBjYXNlLCBvciBoYXZlIEkgbWlzcmVhZCBzb21ldGhpbmc/
DQoNClRoZSBBUk0gTU1VLTUwMCBpbXBsZW1lbnRhdGlvbiBpcyB1bm1vZGlmaWVkLiAgSXQgaXMg
dGhlIHdheSB0aGUgYXJlIGludGVncmF0ZWQgYW5kIHVzZWQgdG9nZXRoZXIoZm9yIGludGVybGVh
dmVkIGFjY2Vzc2VzKSBpcyBkaWZmZXJlbnQgZnJvbSByZWd1bGFyIEFSTSBNTVUtNTAwLg0KSSBo
YXZlIGFkZGVkIGl0IHRvIGdldCB0aGUgbW9kZWwgbnVtYmVyIGFuZCB0byBiZSBhYmxlIGRpZmZl
cmVudGlhdGUgdGhlIFNNTVUgaW1wbGVtZW50YXRpb24gaW4gYXJtLXNtbXUtaW1wbC5jLg0KDQot
S1INCg0KIA0K
