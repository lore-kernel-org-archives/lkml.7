Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91001C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C64A2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LGVxIOK1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfLCUhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:37:42 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:34332 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfLCUhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:37:41 -0500
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de6c7900000>; Wed, 04 Dec 2019 04:37:36 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Dec 2019 12:37:36 -0800
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Tue, 03 Dec 2019 12:37:36 -0800
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Dec
 2019 20:37:36 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.57) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 3 Dec 2019 20:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0+cUdGEbZ/EQUqEh+nsAh3HiPfVvOgDZIQF03WmK2RPPMEcdCQ/ukIwIqwmb39K8EQHbPBER7jVUy3aEs2jCPPObNlzOFKXW5BO1DIizU7jg0fV+MLha0NvERt1qAi83geHtQkr6J/2rlw/xrQgX48f7G0D1Bc4BcnZbcVwtoLnuNyoT6Y6ATfAmpALiTzamtNm1O+juyfA0tRE/LrrYFXRIpfGeJmsme++lrv1JKQ+yD5Bl6RaeJ3MNavgvZj2xtP+17vTFViUk59ao1iHaG7puU6gj9rjOz2hAR5c6MicgoV4Z7R87hFkPmVnx2gv3C7k74pgz8E/XMzKbyH9Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGGitrvx+p8lfSSQGCxyeGYl5kR+PMH214sVaQGdAEU=;
 b=NS2+Duuwdbryw47cW3Y+lDZZ5s1R5iatxWAk8ynd0CEA5sRuHe2vbQKxGLDI0kv2fnQdx1IBZjqZ+etkuhfekjYAeJy8BdGx9qmWtb+LU7MTbTSoCgD6EWTM4MagiadSbOOhcTdcny/76fZsAu6EUpi3rC3pqGLhs1keJ+Fh/sn2w6x7eXzyeHCEvDEjPPqg+82OqIBdoS6IDatE8P8q83lXJMMxQh2m17xKnix1WUitovv2amhlNgK96PszcI3zkGeKzLuGejM+Pp00KUABduqzZDbADoT996tCxUcDCGI/bhLxd/qofbMgP8nf8s9wExBkVH0vEVqCqqPSP36ohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB3015.namprd12.prod.outlook.com (20.178.55.78) by
 BYAPR12MB3511.namprd12.prod.outlook.com (20.179.92.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Tue, 3 Dec 2019 20:37:31 +0000
Received: from BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::bcfa:1ecd:5fa6:dd82]) by BYAPR12MB3015.namprd12.prod.outlook.com
 ([fe80::bcfa:1ecd:5fa6:dd82%5]) with mapi id 15.20.2516.003; Tue, 3 Dec 2019
 20:37:31 +0000
From:   Nitin Gupta <nigupta@nvidia.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khalid.aziz@oracle.com" <khalid.aziz@oracle.com>
Subject: RE: [PATCH] mm: Proactive compaction
Thread-Topic: [PATCH] mm: Proactive compaction
Thread-Index: AQHVnAMyhSo8h2p0sUG1kpKJrnj4E6eiQTKAgAa0LFA=
Date:   Tue, 3 Dec 2019 20:37:31 +0000
Message-ID: <BYAPR12MB301580F67F1DD4F18867ED49D8420@BYAPR12MB3015.namprd12.prod.outlook.com>
References: <20191115222148.2666-1-nigupta@nvidia.com>
 <1deccc9c-0aea-880e-772b-9b965a457d0a@suse.cz>
In-Reply-To: <1deccc9c-0aea-880e-772b-9b965a457d0a@suse.cz>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=nigupta@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2019-12-03T20:38:15.5386355Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=c0e873a7-da16-4b0e-b978-3298a321f9a8;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nigupta@nvidia.com; 
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c72c52b6-5579-43be-04a0-08d778309ee0
x-ms-traffictypediagnostic: BYAPR12MB3511:
x-microsoft-antispam-prvs: <BYAPR12MB351108EF3F7C4B087966ACE4D8420@BYAPR12MB3511.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(366004)(396003)(136003)(13464003)(189003)(199004)(966005)(478600001)(71200400001)(76116006)(71190400001)(8676002)(76176011)(6306002)(66556008)(64756008)(5660300002)(7696005)(52536014)(25786009)(2906002)(54906003)(86362001)(66476007)(110136005)(99286004)(7416002)(316002)(6116002)(81166006)(14454004)(74316002)(14444005)(33656002)(6436002)(8936002)(3846002)(66946007)(53546011)(6506007)(66446008)(26005)(256004)(7736002)(81156014)(9686003)(102836004)(446003)(186003)(11346002)(6246003)(305945005)(4326008)(229853002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3511;H:BYAPR12MB3015.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sdbmpv4YwRmJQM1Uq8RE35AcJXFraIqEGcgaQCfOGwJ5hVvykLnFb/S8nxcW9WI0NKWy7sYd1IxJ+RvXKXCSsUQK8Hp1visiLVnnSzWJ+Md0jV1l7RAMh7qF3fkCnruTTRpvWKWjWhfVzOaZhjEz7loIO9n2q2UyfqldqUni3SOqruY5yW1XpvfBeAeELoXkBkNX4BlH7sxEHNvptXcQSGg85TfWlWh9b3ouQ+oz7fkcNJZxLQp7uh5lWBM+YS3mMMDfW7jLPgbWVSqBTs9rNNnEGL9iJYVsRTBUeFJmEpljb1UdFTC1fZw1wcEbt2I/JqTxwPNOn8+Xbpe80sKXUutcWbjV8CwseqEW5oG8j9J2MYgis/d17gbHJgO9MjAHOrZdZT67P3KbJGpG1YNrpGbmdPoc2DzKOmKN0SWWt1edcs7mwdaVO53kTLDTGcpl2VMX1V2wKSg7lGcaoi8YgktdBh3i3Z7mMmWpfqLI1v0=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c72c52b6-5579-43be-04a0-08d778309ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 20:37:31.3700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4GyD6bvyRofzd9tZzNaxAUrmf4J4EjluzY9iHJkCkdxqB3jzxbD+4SVam8UCLYRnyokksJi9IaW2Uh+NVipyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3511
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575405456; bh=NGGitrvx+p8lfSSQGCxyeGYl5kR+PMH214sVaQGdAEU=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
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
        b=LGVxIOK19j+sUqM6MRW/DtjIZ3vce/gKUzGCRlVisO9dILQg7IX5ofqwnhOeObI+o
         N8o7twrJq2CfSVgYOO2s357fxaYaydYjCQrwWg/4itzOepjyAb/rrgLe6C4U9YezNO
         EXGcWHSy+WURG6imbjNHvELwEFWUscvr6iJ0KptpCO3LrzwFjSrPmnveWl9TNT4dEP
         V7io9oUrhyOmQGo09f9Njvneb2W8cfizM5GKthDTnCYWQakqcN4PQqISRwO4Op/JOr
         1ff5kw4LXUbq2OijNJJY1i218/HCvsfsOpTyhJVHQ+HpOA2JbwpzIVoz97EIj3LYhX
         al2Ry8T94OiOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBvd25lci1saW51eC1tbUBrdmFj
ay5vcmcgPG93bmVyLWxpbnV4LW1tQGt2YWNrLm9yZz4gT24gQmVoYWxmDQo+IE9mIFZsYXN0aW1p
bCBCYWJrYQ0KPiBTZW50OiBGcmlkYXksIE5vdmVtYmVyIDI5LCAyMDE5IDU6NTUgQU0NCj4gVG86
IE5pdGluIEd1cHRhIDxuaWd1cHRhQG52aWRpYS5jb20+OyBNZWwgR29ybWFuDQo+IDxtZ29ybWFu
QHRlY2hzaW5ndWxhcml0eS5uZXQ+OyBNaWNoYWwgSG9ja28gPG1ob2Nrb0BzdXNlLmNvbT4NCj4g
Q2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBZdSBaaGFvDQo+
IDx5dXpoYW9AZ29vZ2xlLmNvbT47IE1pa2UgS3JhdmV0eiA8bWlrZS5rcmF2ZXR6QG9yYWNsZS5j
b20+OyBNYXR0aGV3DQo+IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz47IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBtbUBrdmFjay5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gbW06IFByb2FjdGl2ZSBjb21wYWN0aW9uDQo+IA0KPiBPbiAxMS8xNS8xOSAxMToy
MSBQTSwgTml0aW4gR3VwdGEgd3JvdGU6DQo+ID4gRm9yIHNvbWUgYXBwbGljYXRpb25zIHdlIG5l
ZWQgdG8gYWxsb2NhdGUgYWxtb3N0IGFsbCBtZW1vcnkgYXMNCj4gPiBodWdlcGFnZXMuIEhvd2V2
ZXIsIG9uIGEgcnVubmluZyBzeXN0ZW0sIGhpZ2hlciBvcmRlciBhbGxvY2F0aW9ucyBjYW4NCj4g
PiBmYWlsIGlmIHRoZSBtZW1vcnkgaXMgZnJhZ21lbnRlZC4gTGludXgga2VybmVsIGN1cnJlbnRs
eSBkb2VzDQo+ID4gb24tZGVtYW5kIGNvbXBhY3Rpb24gYXMgd2UgcmVxdWVzdCBtb3JlIGh1Z2Vw
YWdlcyBidXQgdGhpcyBzdHlsZSBvZg0KPiA+IGNvbXBhY3Rpb24gaW5jdXJzIHZlcnkgaGlnaCBs
YXRlbmN5LiBFeHBlcmltZW50cyB3aXRoIG9uZS10aW1lIGZ1bGwNCj4gPiBtZW1vcnkgY29tcGFj
dGlvbiAoZm9sbG93ZWQgYnkgaHVnZXBhZ2UgYWxsb2NhdGlvbnMpIHNob3dzIHRoYXQga2VybmVs
DQo+ID4gaXMgYWJsZSB0byByZXN0b3JlIGEgaGlnaGx5IGZyYWdtZW50ZWQgbWVtb3J5IHN0YXRl
IHRvIGEgZmFpcmx5DQo+ID4gY29tcGFjdGVkIG1lbW9yeSBzdGF0ZSB3aXRoaW4gPDEgc2VjIGZv
ciBhIDMyRyBzeXN0ZW0uIFN1Y2ggZGF0YQ0KPiA+IHN1Z2dlc3RzIHRoYXQgYSBtb3JlIHByb2Fj
dGl2ZSBjb21wYWN0aW9uIGNhbiBoZWxwIHVzIGFsbG9jYXRlIGEgbGFyZ2UNCj4gPiBmcmFjdGlv
biBvZiBtZW1vcnkgYXMgaHVnZXBhZ2VzIGtlZXBpbmcgYWxsb2NhdGlvbiBsYXRlbmNpZXMgbG93
Lg0KPiA+DQo+ID4gRm9yIGEgbW9yZSBwcm9hY3RpdmUgY29tcGFjdGlvbiwgdGhlIGFwcHJvYWNo
IHRha2VuIGhlcmUgaXMgdG8gZGVmaW5lDQo+ID4gcGVyIHBhZ2Utbm9kZSB0dW5hYmxlIGNhbGxl
ZCDigJhocGFnZV9jb21wYWN0aW9uX2VmZm9ydOKAmSB3aGljaCBkaWN0YXRlcw0KPiA+IGJvdW5k
cyBmb3IgZXh0ZXJuYWwgZnJhZ21lbnRhdGlvbiBmb3IgSFBBR0VfUE1EX09SREVSIHBhZ2VzIHdo
aWNoDQo+ID4ga2NvbXBhY3RkIHNob3VsZCB0cnkgdG8gbWFpbnRhaW4uDQo+ID4NCj4gPiBUaGUg
dHVuYWJsZSBpcyBleHBvc2VkIHRocm91Z2ggc3lzZnM6DQo+ID4gICAvc3lzL2tlcm5lbC9tbS9j
b21wYWN0aW9uL25vZGUtbi9ocGFnZV9jb21wYWN0aW9uX2VmZm9ydA0KPiA+DQo+ID4gVGhlIHZh
bHVlIG9mIHRoaXMgdHVuYWJsZSBpcyB1c2VkIHRvIGRldGVybWluZSBsb3cgYW5kIGhpZ2ggdGhy
ZXNob2xkcw0KPiA+IGZvciBleHRlcm5hbCBmcmFnbWVudGF0aW9uIHdydCBIUEFHRV9QTURfT1JE
RVIgb3JkZXIuDQo+IA0KPiBDb3VsZCB3ZSBpbnN0ZWFkIHN0YXJ0IHdpdGggYSBub24tdHVuYWJs
ZSB2YWx1ZSB0aGF0IHdvdWxkIGJlIGxpbmtlZCB0byAgdG8NCj4gZS5nLiB0aGUgbnVtYmVyIG9m
IFRIUCBhbGxvY2F0aW9ucyBiZXR3ZWVuIGtjb21wYWN0ZCBjeWNsZXM/DQo+IEFueXRoaW5nIHdl
IGV4cG9zZSB3aWxsIGluZXZpdGFibHkgZ2V0IHNldCB0byBzdG9uZSwgSSdtIGFmcmFpZCwgc28g
SSB3b3VsZA0KPiBpbnRyb2R1Y2UgaXQgb25seSBhcyBhIGxhc3QgcmVzb3J0Lg0KPg0KDQpUaGVy
ZSBoYXZlIGJlZW4gYXR0ZW1wdHMgaW4gdGhlIHBhc3QgdG8gZG8gcHJvYWN0aXZlIGNvbXBhY3Rp
b24gd2l0aG91dA0KYWRkaW5nIGFueSBuZXcgdHVuYWJsZXMuIEZvciBpbnN0YW5jZSwgc2VlIHRo
aXMgcGF0Y2ggZnJvbSBLaGFsaWQgKENDJ2VkKToNCg0KaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIw
MTkvOC8xMi8xMzAyDQoNClRoaXMgcGF0Y2ggY29sbGVjdHMgYWxsb2NhdGlvbiBhbmQgZnJhZ21l
bnRhdGlvbiBkYXRhIHBvaW50cyB0byBwcmVkaWN0DQptZW1vcnkgZXhoYXVzdGlvbiBvciBmcmFn
bWVudGF0aW9uIGFuZCB0cmlnZ2VycyByZWNsYWltIG9yIGNvbXBhY3Rpb24NCnByb2FjdGl2ZWx5
LiBUaGUgbWFpbiBjb25jZXJuIGluIHRoZSBkaXNjdXNzaW9uIGZvciB0aGlzIHBhdGNoIHdhcyB0
aGF0IHN1Y2gNCmRhdGEgY29sbGVjdGlvbiBhbmQgcHJlZGljdGl2ZSBhbmFseXNpcyBjYW4gYmUg
ZG9uZSBmcm9tIHVzZXJzcGFjZSB0b2dldGhlcg0Kd2l0aCB3bWFyayBhZGp1c3RtZW50IChhbHJl
YWR5IGV4cG9zZWQpLCBzbyBubyBrZXJuZWwgY2hhbmdlcyBhcmUNCnBvdGVudGlhbGx5IG5lY2Vz
c2FyeS4NCg0KSG93ZXZlciwgaW4gdGhlIHNhbWUgZGlzY3Vzc2lvbiwgTWljaGFsIHBvaW50ZWQg
b3V0IGEgbGFjayBvZiBzaW1pbGFyDQppbnRlcmZhY2UgKGxpa2Ugd21hcmtzIGZvciBrc3dhcGQp
IG1pc3NpbmcgdG8gZ3VpZGUga2NvbXBhY3RkOg0KDQpodHRwczovL2xrbWwub3JnL2xrbWwvMjAx
OS84LzEzLzczMA0KDQpNeSBwYXRjaCBpcyBhZGRyZXNzaW5nIHRoZSBuZWVkIGZvciB0aGF0IG1p
c3NpbmcgdXNlcnNwYWNlIHR1bmFibGUuIEEgdXNlcnNwYWNlDQpkYWVtb24gIGNhbiBtZWFzdXJl
IGZyYWdtZW50YXRpb24gdHJlbmRzIGFuZCBhZGp1c3QgdGhpcyB0dW5hYmxlIHRvIGxldA0Ka2Vy
bmVsIGtub3cgYW1vdW50IG9mIGVmZm9ydCB0byBwdXQgaW50byBjb21wYWN0aW9uIHRvIGF2b2lk
IGhpdHRpbmcgZGlyZWN0DQpjb21wYWN0IHBhdGguDQoNCiANCj4gPiBOb3RlIHRoYXQgcHJldmlv
dXMgdmVyc2lvbiBvZiB0aGlzIHBhdGNoIFsxXSB3YXMgZm91bmQgdG8gaW50cm9kdWNlDQo+ID4g
dG9vIG1hbnkgdHVuYWJsZXMgKHBlci1vcmRlciwgZXh0ZnJhZ197bG93LCBoaWdofSkgYnV0IHRo
aXMgb25lDQo+ID4gcmVkdWNlcyB0aGVtIHRvIGp1c3QgKHBlci1ub2RlLCBocGFnZV9jb21wYWN0
aW9uX2VmZm9ydCkuIEFsc28sIHRoZQ0KPiA+IG5ldyB0dW5hYmxlIGlzIGFuIG9wYXF1ZSB2YWx1
ZSBpbnN0ZWFkIG9mIGFza2luZyBmb3Igc3BlY2lmaWMgYm91bmRzDQo+ID4gb2Yg4oCcZXh0ZXJu
YWwgZnJhZ21lbnRhdGlvbuKAnSB3aGljaCB3b3VsZCBoYXZlIGJlZW4gZGlmZmljdWx0IHRvDQo+
ID4gZXN0aW1hdGUuIFRoZSBpbnRlcm5hbCBpbnRlcnByZXRhdGlvbiBvZiB0aGlzIG9wYXF1ZSB2
YWx1ZSBhbGxvd3MgZm9yIGZ1dHVyZQ0KPiBmaW5lLXR1bmluZy4NCj4gPg0KPiA+IEN1cnJlbnRs
eSwgd2UgdXNlIGEgc2ltcGxlIHRyYW5zbGF0aW9uIGZyb20gdGhpcyB0dW5hYmxlIHRvIFtsb3cs
DQo+ID4gaGlnaF0gZXh0ZnJhZyB0aHJlc2hvbGRzIChsb3c9MTAwLWhwYWdlX2NvbXBhY3Rpb25f
ZWZmb3J0LA0KPiA+IGhpZ2g9bG93KzEwJSkuIFRvIHBlcmlvZGljYWxseSBjaGVjayBwZXItbm9k
ZSBleHRmcmFnIHN0YXR1cywgd2UgcmV1c2UNCj4gPiBwZXItbm9kZSBrY29tcGFjdGQgdGhyZWFk
cyB3aGljaCBhcmUgd29rZW4gdXAgZXZlcnkgZmV3IG1pbGxpc2Vjb25kcw0KPiA+IHRvIGNoZWNr
IHRoZSBzYW1lLiBJZiBhbnkgem9uZSBvbiBpdHMgY29ycmVzcG9uZGluZyBub2RlIGhhcyBleHRm
cmFnDQo+ID4gYWJvdmUgdGhlIGhpZ2ggdGhyZXNob2xkIGZvciB0aGUgSFBBR0VfUE1EX09SREVS
IG9yZGVyLCB0aGUgdGhyZWFkDQo+ID4gc3RhcnRzIGNvbXBhY3Rpb24gaW4gYmFja2dyb3VuZCB0
aWxsIGFsbCB6b25lcyBhcmUgYmVsb3cgdGhlIGxvdw0KPiA+IGV4dGZyYWcgbGV2ZWwgZm9yIHRo
aXMgb3JkZXIuIEJ5IGRlZmF1bHQuIEJ5IGRlZmF1bHQsIHRoZSB0dW5hYmxlIGlzDQo+ID4gc2V0
IHRvIDAgKD0+IGxvdz0xMDAlLCBoaWdoPTEwMCUpLg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBpcyBs
YXJnZWx5IGJhc2VkIG9uIGlkZWFzIGZyb20gTWljaGFsIEhvY2tvIHBvc3RlZCBoZXJlOg0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LQ0KPiBtbS8yMDE2MTIzMDEzMTQxMi5HSTEz
MzAxQGRoY3AyMi5zdXNlLmN6DQo+ID4gLw0KPiA+DQo+ID4gKiBQZXJmb3JtYW5jZSBkYXRhDQo+
ID4NCj4gPiBTeXN0ZW06IHg2NF82NCwgMzJHIFJBTSwgMTItY29yZXMuDQo+ID4NCj4gPiBJIG1h
ZGUgYSBzbWFsbCBkcml2ZXIgdGhhdCBhbGxvY2F0ZXMgYXMgbWFueSBodWdlcGFnZXMgYXMgcG9z
c2libGUgYW5kDQo+ID4gbWVhc3VyZXMgYWxsb2NhdGlvbiBsYXRlbmN5Og0KPiA+DQo+ID4gVGhl
IGRyaXZlciBmaXJzdCB0cmllcyB0byBhbGxvY2F0ZSBodWdlcGFnZSB1c2luZyBHRlBfVFJBTlNI
VUdFX0xJR0hUDQo+ID4gYW5kIGlmIHRoYXQgZmFpbHMsIHRyaWVzIHRvIGFsbG9jYXRlIHdpdGgg
YEdGUF9UUkFOU0hVR0UgfA0KPiA+IF9fR0ZQX1JFVFJZX01BWUZBSUxgLiBUaGUgZHJpdmVzIHN0
b3BzIHdoZW4gYm90aCBtZXRob2RzIGZhaWwgZm9yIGENCj4gPiBodWdlcGFnZSBhbGxvY2F0aW9u
Lg0KPiA+DQo+ID4gQmVmb3JlIHN0YXJ0aW5nIHRoZSBkcml2ZXIsIHRoZSBzeXN0ZW0gd2FzIGZy
YWdtZW50ZWQgZnJvbSBhIHVzZXJzcGFjZQ0KPiA+IHByb2dyYW0gdGhhdCBhbGxvY2F0ZXMgYWxs
IG1lbW9yeSBhbmQgdGhlbiBmb3IgZWFjaCAyTSBhbGlnbmVkDQo+ID4gc2VjdGlvbiwgZnJlZXMg
My80IG9mIGJhc2UgcGFnZXMgdXNpbmcgbXVubWFwLiBUaGUgd29ya2xvYWQgaXMgbWFpbmx5DQo+
ID4gYW5vbnltb3VzIHVzZXJzcGFjZSBwYWdlcyB3aGljaCBhcmUgZWFzeSB0byBtb3ZlIGFyb3Vu
ZC4gSQ0KPiA+IGludGVudGlvbmFsbHkgYXZvaWRlZCB1bm1vdmFibGUgcGFnZXMgaW4gdGhpcyB0
ZXN0IHRvIHNlZSBob3cgbXVjaA0KPiA+IGxhdGVuY3kgd2UgaW5jdXIganVzdCBieSBoaXR0aW5n
IHRoZSBzbG93IHBhdGggZm9yIG1vc3QgYWxsb2NhdGlvbnMuDQo+ID4NCj4gPiAoYWxsIGxhdGVu
Y3kgdmFsdWVzIGFyZSBpbiBtaWNyb3NlY29uZHMpDQo+ID4NCj4gPiAtIFdpdGggdmFuaWxsYSBr
ZXJuZWwgNS40LjAtcmM1Og0KPiA+DQo+ID4gcGVyY2VudGlsZSBsYXRlbmN5DQo+ID4gLS0tLS0t
LS0tLSAtLS0tLS0tDQo+ID4gICAgICAgICAgNSAgICAgICA3DQo+ID4gICAgICAgICAxMCAgICAg
ICA3DQo+ID4gICAgICAgICAyNSAgICAgICA4DQo+ID4gICAgICAgICAzMCAgICAgICA4DQo+ID4g
ICAgICAgICA0MCAgICAgICA4DQo+ID4gICAgICAgICA1MCAgICAgICA4DQo+ID4gICAgICAgICA2
MCAgICAgICA5DQo+ID4gICAgICAgICA3NSAgICAgMjE1DQo+ID4gICAgICAgICA4MCAgICAgMjIy
DQo+ID4gICAgICAgICA5MCAgICAgMzIzDQo+ID4gICAgICAgICA5NSAgICAgNDI5DQo+ID4NCj4g
PiBUb3RhbCAyTSBodWdlcGFnZXMgYWxsb2NhdGVkID0gMTgyOSAoMy41RyB3b3J0aCBvZiBodWdl
cGFnZXMgb3V0IG9mDQo+ID4gMjVHIHRvdGFsIGZyZWUgPT4gMTQlIG9mIGZyZWUgbWVtb3J5IGNv
dWxkIGJlIGFsbG9jYXRlZCBhcyBodWdlcGFnZXMpDQo+ID4NCj4gPiAtIE5vdyB3aXRoIGtlcm5l
bCA1LjQuMC1yYzUgKyB0aGlzIHBhdGNoOg0KPiA+IChocGFnZV9jb21wYWN0aW9uX2VmZm9ydCA9
IDYwKQ0KPiA+DQo+ID4gcGVyY2VudGlsZSBsYXRlbmN5DQo+ID4gLS0tLS0tLS0tLSAtLS0tLS0t
DQo+ID4gICAgICAgICAgNSAgICAgICAzDQo+ID4gICAgICAgICAxMCAgICAgICAzDQo+ID4gICAg
ICAgICAyNSAgICAgICA0DQo+ID4gICAgICAgICAzMCAgICAgICA0DQo+ID4gICAgICAgICA0MCAg
ICAgICA0DQo+ID4gICAgICAgICA1MCAgICAgICA0DQo+ID4gICAgICAgICA2MCAgICAgICA1DQo+
ID4gICAgICAgICA3NSAgICAgICA2DQo+ID4gICAgICAgICA4MCAgICAgICA5DQo+ID4gICAgICAg
ICA5MCAgICAgMzcwDQo+ID4gICAgICAgICA5NSAgICAgNjUyDQo+ID4NCj4gPiBUb3RhbCAyTSBo
dWdlcGFnZXMgYWxsb2NhdGVkID0gMTExMjAgKDIxLjdHIHdvcnRoIG9mIGh1Z2VwYWdlcyBvdXQg
b2YNCj4gPiAyNUcgdG90YWwgZnJlZSA9PiA4NiUgb2YgZnJlZSBtZW1vcnkgY291bGQgYmUgYWxs
b2NhdGVkIGFzIGh1Z2VwYWdlcykNCj4gDQo+IEkgd29uZGVyIGFib3V0IHRoZSAxNC0+ODYlIGlt
cHJvdmVtZW50LiBBcyB5b3Ugc2F5LCB0aGlzIGtpbmQgb2YNCj4gZnJhZ21lbnRhdGlvbiBpcyBl
YXN5IHRvIGNvbXBhY3QuIFdoeSB3b3VsZG4ndCBHRlBfVFJBTlNIVUdFIHwNCj4gX19HRlBfUkVU
UllfTUFZRkFJTCBhdHRlbXB0cyBzdWNjZWVkPw0KPiANCg0KSSdtIG5vdCB0b28gc3VyZSBhdCB0
aGlzIHBvaW50LiBXaXRoIGtlcm5lbCA1LjMuMCBJIGNvdWxkIGFsbG9jYXRlIDgwLTkwJSBvZg0K
bWVtb3J5IGFzIGh1Z2VwYWdlcyB1bmRlciBzaW1pbGFyIGNvbmRpdGlvbnMgdGhvdWdoIHdpdGgg
dmVyeSBoaWdoDQpsYXRlbmNpZXMgKGFzIEkgcmVwb3J0ZWQgaGVyZTogaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMTA5ODI4OS8pDQoNCldpdGgga2VybmVsIDUuNC4wLXggSSBv
YnNlcnZlZCB0aGlzIHNpZ25pZmljYW50IGRyb3AuIFBlcmhhcHMNCkdGUF9UUkFOU0hVR0UgZmxh
ZyB3YXMgY2hhbmdlZCBiZXR3ZWVuIHRoZXNlIHZlcnNpb25zLiBJIHdpbGwgcG9zdA0KZnV0dXJl
IG51bWJlcnMgd2l0aCBiYXNlIGZsYWdzIHRvIGF2b2lkIHN1Y2ggc3VycHJpc2VzIGluIGZ1dHVy
ZS4NCg0KVGhhbmtzLA0KTml0aW4NCg0KDQoNCg0KPiA+IEFib3ZlIHdvcmtsb2FkIHByb2R1Y2Vz
IGEgbWVtb3J5IHN0YXRlIHdoaWNoIGlzIGVhc3kgdG8gY29tcGFjdC4NCj4gPiBIb3dldmVyLCBp
ZiBtZW1vcnkgaXMgZmlsbGVkIHdpdGggdW5tb3ZhYmxlIHBhZ2VzLCBwcm8tYWN0aXZlDQo+ID4g
Y29tcGFjdGlvbiBzaG91bGQgZXNzZW50aWFsbHkgYmFjayBvZmYuIFRvIHRlc3QgdGhpcyBhc3Bl
Y3QsIEkgcmFuIGENCj4gPiBtaXggb2YgdGhpcyB3b3JrbG9hZCAodGhhbmtzIHRvIE1hdHRoZXcg
V2lsY294IGZvciBzdWdnZXN0aW5nIHRoZXNlKToNCj4gPg0KPiA+IC0gZGVudHJ5X3RocmFzaDog
aXQgb3BlbnMgL3RtcC9taXNzaW5nLnggZm9yIHggaW4gWzEsIDEwMDAwMDBdIHdoZXJlDQo+ID4g
Zmlyc3QgMTAwMDAgZmlsZXMgYWN0dWFsbHkgZXhpc3QuDQo+ID4gLSBwYWdlY2FjaGVfdGhyYXNo
OiBpdCBvcGVucyBhIDEyOEcgZmlsZSAob24gYSAzMkcgc3lzdGVtKSBhbmQgdGhlbg0KPiA+IHJl
YWRzIGF0IHJhbmRvbSBvZmZzZXRzLg0KPiA+DQo+ID4gV2l0aCB0aGlzIG1peCBvZiB3b3JrbG9h
ZCwgc3lzdGVtIHF1aWNrbHkgcmVhY2hlcyA5MC0xMDAlDQo+ID4gZnJhZ21lbnRhdGlvbiB3cnQg
b3JkZXItOS4gVHJhY2Ugb2YgY29tcGFjdGlvbiBldmVudHMgc2hvd3MgdGhhdCB3ZQ0KPiA+IGtl
ZXAgaGl0dGluZyBjb21wYWN0aW9uX2RlZmVycmVkIGV2ZW50LCBhcyBleHBlY3RlZC4NCj4gPg0K
PiA+IEFmdGVyIHRlcm1pbmF0aW5nIGRlbnRyeV90aHJhc2ggYW5kIGRyb3BwaW5nIGRlbnR5IGNh
Y2hlcywgdGhlIHN5c3RlbQ0KPiA+IGNvdWxkIHByb2NlZWQgd2l0aCBjb21wYWN0aW9uIGFjY29y
ZGluZyB0byBzZXQgdmFsdWUgb2YNCj4gPiBocGFnZV9jb21wYWN0aW9uX2VmZm9ydCAoNjApLg0K
PiA+DQo+ID4gWzFdIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTEwOTgyODkv
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaXRpbiBHdXB0YSA8bmlndXB0YUBudmlkaWEuY29t
Pg0KDQo=
