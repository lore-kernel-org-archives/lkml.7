Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E9FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34EC2184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WhzoXxUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfC2PGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:06:45 -0400
Received: from mail-eopbgr780050.outbound.protection.outlook.com ([40.107.78.50]:54816
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728720AbfC2PGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjPVuGMGM9X9DfF0U08yWvyT6XyEBbKHBcLNd0XUlJk=;
 b=WhzoXxUNwKMFi8L8RK80MAvQznwMSIlwfLazzAilekayvVHxmYv0V1gXdBRVUlzvk1Byj3N4U9MsF+CeFNWKcCOKh25fll92jccEW/Bx0/OMcFgSSOmUVFDt7TmqLpuEPcZP82oepHCLPdnuM+wEx+XjVr6oybyfF9R9TbFaxxQ=
Received: from DM5PR12MB1449.namprd12.prod.outlook.com (10.172.38.138) by
 DM5PR12MB1419.namprd12.prod.outlook.com (10.168.238.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Fri, 29 Mar 2019 15:06:41 +0000
Received: from DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1]) by DM5PR12MB1449.namprd12.prod.outlook.com
 ([fe80::890d:8adb:6785:6ca1%4]) with mapi id 15.20.1750.017; Fri, 29 Mar 2019
 15:06:41 +0000
From:   Gary R Hook <ghook@amd.com>
To:     Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Thread-Topic: [PATCH] iommu/amd: Reserve exclusion range in iova-domain
Thread-Index: AQHU5VNRZt3XbAojqUi3B+DRJlpqRKYhIQOAgAGR/YCAAARegA==
Date:   Fri, 29 Mar 2019 15:06:41 +0000
Message-ID: <241612a5-b041-e419-a3bc-e2a2e6ef1687@amd.com>
References: <20190328104459.18589-1-joro@8bytes.org>
 <3850c381-30d6-b2a3-d976-66939d8e612a@amd.com>
 <20190329145101.GA27670@8bytes.org>
In-Reply-To: <20190329145101.GA27670@8bytes.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0017.prod.exchangelabs.com (2603:10b6:805:1::30)
 To DM5PR12MB1449.namprd12.prod.outlook.com (2603:10b6:4:d::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d622f4b-fe0a-4fe9-d5cc-08d6b4582666
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1419;
x-ms-traffictypediagnostic: DM5PR12MB1419:
x-microsoft-antispam-prvs: <DM5PR12MB14192864C01FC076B05CBC96FD5A0@DM5PR12MB1419.namprd12.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(396003)(136003)(366004)(199004)(189003)(4326008)(25786009)(72206003)(71200400001)(478600001)(8936002)(2906002)(68736007)(256004)(14454004)(26005)(186003)(3846002)(6116002)(102836004)(53546011)(6506007)(52116002)(76176011)(99286004)(54906003)(316002)(71190400001)(386003)(31696002)(31686004)(5660300002)(106356001)(97736004)(6246003)(81166006)(105586002)(6916009)(6436002)(6486002)(229853002)(36756003)(305945005)(6512007)(7736002)(81156014)(66066001)(476003)(446003)(486006)(2616005)(11346002)(53936002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1419;H:DM5PR12MB1449.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rttm3Qt+reDNP3q+W5SW0Q2uQRVB0y9LxRfUlLf01BWMGXLHEC38U+kTFmmL9QFV+WFA0ScMiMigQXEgzqx+2nXlG8aCDzTd56Dcm0vTYqRkrpW+IVjPfBbLgwt9iqAOJq9RsFU9HW9WdrH+KsrdpRhov/SjSkI/ioUGrXdgvzzrX4C0eUAWnAVkOLvCSEq2gX8j4mODVD1rkbmEm79YY51UitL80PQCd2jqu4BLsMtnTKhGq9J/TcD0Cv2Ujn8T605xb0bHEXXpUzy07RAb/ojbiH6Gw8UTlfYGdHukYlk+qyG/BA4HyvOKVjcV3gURs5ZzPLfgCUwAUegTryyNcrRBttlM2baD++RWEHMrltXqa3zg46IUR5NrvpS0Z4rG+Mrmh9bHCXDy+uvO0H2rJux8UN+jyGHvunZcCiyrF+c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FCFB7220A210641957EFD4281705B35@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d622f4b-fe0a-4fe9-d5cc-08d6b4582666
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 15:06:41.6481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yOS8xOSA5OjUxIEFNLCBKb2VyZyBSb2VkZWwgd3JvdGU6DQo+IEhpIEdhcnksDQo+IA0K
PiBPbiBUaHUsIE1hciAyOCwgMjAxOSBhdCAwMjo1MjoxOVBNICswMDAwLCBHYXJ5IFIgSG9vayB3
cm90ZToNCj4+IE9uIDMvMjgvMTkgNTo0NCBBTSwgSm9lcmcgUm9lZGVsIHdyb3RlOg0KPj4+ICsJ
CWlmIChlbnRyeS0+cHJvdCAmICgxIDw8IDIpKQ0KPj4NCj4+IENvdWxkIHdlIGFkZCAjZGVmaW5l
IElPTU1VX1dSSVRFX0VYQ0wgKDEgPDwgMikgdG8gYW1kX2lvbW11X3R5cGVzLmg/DQo+IA0KPiBZ
ZXMsIEkgcmVwbGFjZSB0aGF0IG1hZ2ljIG51bWJlciB3aXRoIGEgZGVzY3JpcHRpdmUgbmFtZS4N
Cg0KU3VwZXI7IHRoYW5rcy4NCg0KPj4gVGhlIHByb2JsZW0gSSBzZWUgaGVyZSBpcyB0aGF0IGlm
LCBmb3Igc29tZSB1bnRvbGQgcmVhc29uLCB0aGVyZSBpcyBtb3JlDQo+PiB0aGFuIG9uZSBleGNs
dXNpb24gcmFuZ2UgZW1pdHRlZCwgd2hlcmUgb25seSB0aGUgbGFzdCBvbmUgd2lucyBpbiB0aGUN
Cj4+IGhhcmR3YXJlLCB3ZSdkIHN0aWxsIGVuZCB1cCB3aXRoIG1vcmUgdGhhbiBvbmUgcmFuZ2Ug
cmVzZXJ2ZWQgaW4gdGhlDQo+PiBJT1ZBIHRyZWUuIENsZWFybHksIHRoaXMgaXMgZXh0cmVtZWx5
IHVubGlrZWx5LCBidXQgd291bGRuJ3Qgd2Ugd2FudCB0bw0KPj4gcHJvdGVjdCBhZ2FpbnN0IHRo
YXQgc29ydCBvZiBtaXN1c2UvbWlzdGFrZT8NCj4+DQo+PiBJIGNvdWxkIGJlIG1pc3Npbmcgc29t
ZXRoaW5nLg0KPiANCj4gTm8sIHlvdSBhcmUgbm90LCB0aGlzIGNvdWxkIHN0aWxsIGJlIGEgcHJv
YmxlbS4gVW50aWwgbm93IGl0IGlzbid0LA0KPiBiZWNhdXNlIHRoaXMgd2VlayB3YXMgdGhlIGZp
cnN0IHRpbWUgSSBoYXZlIGV2ZXJ5IHNlZW4gYW4gQU1EIElPTU1VDQo+IHN5c3RlbSBtYWtpbmcg
dXNlIG9mIGV4Y2x1c2lvbiByYW5nZXMsIGFuZCBpdCBkb2Vzbid0IGhhdmUgdGhpcyBwcm9ibGVt
Lg0KPiANCj4gQnV0IHRoaXMgcHJvYmxlbSBoYXMgYmVlbiBpbiB0aGUgY29kZSBldmVuIGJlZm9y
ZSB0aGlzIHBhdGNoIGFuZCBuZWVkcw0KPiB0byBiZSBhZGRyZXNzZWQgc2VwYXJhdGx5LiBJIHRo
aW5rIGl0IGlzIHRoZSBiZXN0IG9wdGlvbiB0byBjYW5jZWwgSU9NTVUNCj4gaW5pdGlhbGl6YXRp
b24gd2hlbiB0aGUgSVZSUyB0YWJsZSBkZWZpbmVzIGNvbmZsaWN0aW5nIGV4Y2x1c2lvbiByYW5n
ZXMNCj4gZm9yIGEgc2luZ2xlIElPTU1VIGluc3RhbmNlLg0KDQpSZWFsbHk/IEludGVyZXN0aW5n
LiBNYXkgSSBhc2sgd2hvLCBhcyBJJ3ZlIG5vdCBzZWVuIGl0IHlldCwgZWl0aGVyPw0KDQpUaGlz
IGNoYW5nZSBhY2NvbXBsaXNoZXMgdGhlIGdvYWwgb2Ygc2V0dGluZyBleGNsdXNpb24gKyByZXNl
cnZpbmcgdGhlIA0KSU9WQSByYW5nZSwgYW5kIGlzIHZlcmlmaWVkIHdpdGggdGVzdGluZz8gQ29v
bC4gT25lIHdvbmRlcnMgaWYgdGhleSd2ZSANCmNvbnNpZGVyZWQgYSB1bml0eSByYW5nZT8NCg0K
QWdyZWUgdGhhdCBhZGRyZXNzaW5nIHRoZSB1bmlxdWVuZXNzIGlzc3VlIHNlcGFyYXRlbHkgaXMg
ZmluZS4gSSdkIA0KcHJvYmFibHkgcHJlZmVyICJmaXJzdCBvbmUgd2lucyIgdW50aWwgSU9WQSB0
cmVlIGNsZWFuLXVwIGNvdWxkIGJlIA0KaW1wbGVtZW50ZWQgZm9yICJsYXN0IG9uZSB3aW5zIi4u
Li4gYnV0IEknbSBzZWVpbmcgdGhhdCB0aGVyZSBhcmUgYXQgDQpsZWFzdCB0d28gc3BvdHMgaW4g
dGhlIGNvZGUgdGhhdCBuZWVkIGF0dGVudGlvbi4gSSBtYXkgZ28gZXhwZXJpbWVudCANCndpdGgg
dGhpcy4NCg0KQWxsIHRvbGQsIHRoaXMgaXMgcmVhbGx5IGFib3V0IGhhbmRsaW5nIGEgY29ybmVy
IGNhc2UsIGFzIHRoZSBsaWtlbGlob29kIA0Kb2YgYSBCSU9TIHRyeWluZyB0byBzZXQgdXAgPjEg
ZXhjbHVzaW9uIHJhbmdlcyBzZWVtcyBpbXByb2JhYmxlLCBpZiBub3QgDQppbXBvc3NpYmxlLg0K
DQoNCmdyaA0K
