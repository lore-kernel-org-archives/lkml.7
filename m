Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61510C3A59E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218F02339D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 01:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cxq19L9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfICBHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 21:07:51 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6062 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfICBHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 21:07:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6dbce60000>; Mon, 02 Sep 2019 18:07:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Sep 2019 18:07:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Sep 2019 18:07:49 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Sep
 2019 01:07:48 +0000
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (104.47.44.51) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 3 Sep 2019 01:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBIyUBZ3/oN0IY4BSDsJED4DMcfXY6mNfzYxf2PfUy/VNpGAbtQZqGKY0BXOMTjJPMNS0tnB01y28Gi4Z6/KoKNNySxzlj+wuUAji22CTgzWoGngEMpodZvcliOQVjo1VveXb7yHWUU54/23W4C7XTkXD+pLl6xFfYbvloEbRnoBRxfg6lUpgjghG0V482PW2WrvzXagDAVK42By7erEN/apmxKaTehllj9uhaGMfGS65i2PqnmjQnu7mfqb6ZfCD6ibmQXjlclRT5UJnOPl/lgf2DxGhkd2j0GKjjOTN+iQV/htl/CZpFhl84aOjzKYG4LuH5I3BvL+e842CXD5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II5YpH+8PRxBxFj/7eMCnK9NqZPLJ4fvtlS+yvAit0Y=;
 b=TUJ9//4xzOa41DaG3dLXVKws7+Ki8puV7GHPpLFFyuZTtpFf0ktm0cCQeaDwRXDmLLZ9VTNAmPLqF6nkY5yhqk9vdnqnsuIh4NWFiIaEJ/QtB7p1IiI6jGAPTIuLXfq6Pu+N58zNxmohTA+HdbGO4Mtgvc2r0yLYxwgI8iPssYNQsmH8sX2lgqxwDduwMieWGeN3Ign0kYCFH3JApAyttGF0Me9SUWv7PjI0VJfTh5IDbnaYIuEEqQcq/Iq2f59j462WJS+DgNfF2CG+GvrqOzNMCb8vyFovMwzLnGGye1fajuG+Bb7vtVcIeCJLh/8MEJqBzNbmXqlN1nk+uxUinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (20.177.124.11) by
 BYAPR12MB3160.namprd12.prod.outlook.com (20.179.92.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.20; Tue, 3 Sep 2019 01:07:46 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::60a8:9757:8be2:2c56%6]) with mapi id 15.20.2220.013; Tue, 3 Sep 2019
 01:07:46 +0000
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
Thread-Index: AQHVXruJtN0dV6uzzEqjzwhw4G/PK6cTynmAgAA1HECABGrEAIAAvVrg
Date:   Tue, 3 Sep 2019 01:07:46 +0000
Message-ID: <BYAPR12MB2710D40B168C7029758C5481B3B90@BYAPR12MB2710.namprd12.prod.outlook.com>
References: <1567118827-26358-1-git-send-email-vdumpa@nvidia.com>
 <1567118827-26358-2-git-send-email-vdumpa@nvidia.com>
 <2ae9e0c4-6916-b005-f4bd-29e06d2056c6@arm.com>
 <BYAPR12MB2710D045303BE89A7D3FF2C1B3BD0@BYAPR12MB2710.namprd12.prod.outlook.com>
 <3f2cbbe2-f6d7-07e3-3fef-18af518dedef@arm.com>
In-Reply-To: <3f2cbbe2-f6d7-07e3-3fef-18af518dedef@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-09-03T01:07:42.8379649Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=11141f53-2ea3-4aee-8f22-cdc149af4425;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vdumpa@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1ee91bd-d7a2-44a7-672e-08d7300b21cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR12MB3160;
x-ms-traffictypediagnostic: BYAPR12MB3160:|BYAPR12MB3160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB31601FE1B60E512357DD9D06B3B90@BYAPR12MB3160.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01494FA7F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(4326008)(25786009)(305945005)(55016002)(9686003)(8936002)(6246003)(6436002)(7696005)(52536014)(4744005)(6916009)(256004)(14444005)(86362001)(71190400001)(71200400001)(74316002)(66066001)(7736002)(8676002)(81166006)(81156014)(5660300002)(66946007)(76116006)(2906002)(53936002)(66446008)(99286004)(446003)(14454004)(11346002)(6506007)(33656002)(66476007)(76176011)(316002)(486006)(26005)(186003)(6116002)(3846002)(102836004)(54906003)(66556008)(64756008)(229853002)(476003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3160;H:BYAPR12MB2710.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FgmsUqf06dYWePSbd1dQ9CurTzob97/NVwiYcew8CrlLzEocnfJXcwRcSRo5Mg+h0nSiV0ew9Jb89gmnx7DRFwVpQj1ys+1hjowZ19QYgGHC5HEkli0po3sFuTGznm9kBejGEwKzg8GGQycbpTZ38A24uq+pXR6BahGVuEnI9F0LGsUJY+rwoFJXrvqPrf+LOBZsYVgjeGFijI/YJI+iSMpNtMqyvACykLKWGsMiwuN+EE3bmYSaNbT6lRI63YcmcHfucory730kHtUFzxym4xdePl3N05nkFxg0Xkz+DZnkpUz620/tKjiQva5JEeyzk5hU+igYFk2+Ljbky1tROVBXrkwS1rB8lv2xVVdbODc04TVwLTbN0tOnP8ELurL5n2skmVMACThBu7K9NFZMMKQsNbP8IIoiGWcmOjASzgQ=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ee91bd-d7a2-44a7-672e-08d7300b21cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2019 01:07:46.4249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3urcSXR4J4vHeEes5yfk1FZn/wC77G+xupPR7HDYQK9UyuY6dqkpfiWjl3A2swcaSS07NOh8rV3ic2/QZNT0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3160
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567472870; bh=II5YpH+8PRxBxFj/7eMCnK9NqZPLJ4fvtlS+yvAit0Y=;
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
        b=cxq19L9vieEGoDOWp93qfgyCgePSYf+Eml6NcNeGzizhg+JKg3dpuhXzPN+yV0i2S
         utOXURY7PcvnlT5rCxbZ/9i7WQ6zAlnRkCfrBy/HL/2ilhQBiWAdXwd00GWK6a3pf8
         Wes/6vaPQDeUs1Repb0JyjF36dIzBxtIfZw0KC1ZiyPcu9Lp6l2bFeH02DFxAQWD1K
         LmQHd53S/TP23oDnLNBArd0c0OqETqcX2xnsIDQ+bb9AjlsZfwArpY/WE4ORECjp48
         +cYpOcUwsaxs2QITHBM6nIbQAwhD3Gkyad+hZETqeV6iR0GUinDXVXxsaKY/vHMdxB
         rsLE0mGsVA0pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+ICtBUk1fU01NVV9NQVRDSF9EQVRBKG52aWRpYV9zbW11djIsIEFSTV9TTU1VX1YyLCBOVklE
SUFfU01NVVYyKTsNCiANCj4+IFRoZSBBUk0gTU1VLTUwMCBpbXBsZW1lbnRhdGlvbiBpcyB1bm1v
ZGlmaWVkLiAgSXQgaXMgdGhlIHdheSB0aGUgYXJlIGludGVncmF0ZWQgYW5kIHVzZWQgdG9nZXRo
ZXIoZm9yIGludGVybGVhdmVkIGFjY2Vzc2VzKSBpcyBkaWZmZXJlbnQgZnJvbSByZWd1bGFyIEFS
TSBNTVUtNTAwLg0KPj4gSSBoYXZlIGFkZGVkIGl0IHRvIGdldCB0aGUgbW9kZWwgbnVtYmVyIGFu
ZCB0byBiZSBhYmxlIGRpZmZlcmVudGlhdGUgdGhlIFNNTVUgaW1wbGVtZW50YXRpb24gaW4gYXJt
LXNtbXUtaW1wbC5jLg0KDQo+SW4gdGhhdCBjYXNlLCBJIHdvdWxkIHJhdGhlciBrZWVwIHNtbXUt
Pm1vZGVsIHJlcHJlc2VudGluZyB0aGUgTU1VLTUwMCBtaWNyb2FyY2hpdGVjdHVyZSAtIA0KPnNp
bmNlIHlvdSdsbCBzdGlsbCB3YW50IHRvIHBpY2sgdXAgZXJyYXRhIHdvcmthcm91bmRzIGV0Yy4g
Zm9yIHRoYXQgLSBhbmQgZGV0ZWN0IHRoZSBUZWdyYSBpbnRlZ3JhdGlvbiB2aWEgYW4gZXhwbGlj
aXQgb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoKQ0KPiBjaGVjayBpbiBhcm1fc21tdV9pbXBsX2lu
aXQoKS4NCg0KTG9va3MgZ29vZCB0byBtZS4gDQoNCj5Gb3IgY29tcGFyaXNvbiwgdW5kZXIgQUNQ
SSB3ZSdkIHByb2JhYmx5IGhhdmUgdG8gZGV0ZWN0IGludGVncmF0aW9uIGRldGFpbHMgYnkgbG9v
a2luZyBhdCB0YWJsZSBoZWFkZXJzLCBzZXBhcmF0ZWx5DQo+IGZyb20gdGhlIElPUlQgIk1vZGVs
IiBmaWVsZCwgc28gSSdkIHByZWZlciBpZiB0aGUgRFQgdnMuIEFDUEkgaGFuZGxpbmcgZGlkbid0
IGRpdmVyZ2UgbW9yZSB0aGFuIG5lY2Vzc2FyeS4NCg0KQUNQSSBzdXBwb3J0IGZvciBUMTk0IGNh
biBiZSBhZGRlZCBiYXNlZCBvbiBuZWVkIGluIHN1YnNlcXVlbnQgcGF0Y2hlcy4gRm9yIG5vdywg
SSBhbSB1cGRhdGluZyBpdCBmb3IgRFQgc3VwcG9ydC4NCg0KLUtSDQo=
