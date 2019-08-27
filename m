Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BA7C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591E520674
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 19:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="HzH3KFGG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfH0Tq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 15:46:58 -0400
Received: from mail-eopbgr680079.outbound.protection.outlook.com ([40.107.68.79]:44423
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726584AbfH0Tq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 15:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De8QesjREvh829m2qYuMukITtmszj1/h3inVixTQ32IAb7v2JVWIR115zoqRyUo0VseD/bo+vIaEGpK6jRWoDtVuRyyP8wyKsjsOvmGYjZffsChdFxkkH5J49SXsBCIhYrbWpK2VIf3IlL0qSRn2gd5dnfcWTfBK7fQFosNDDhziQHHDo+Oe7w6JwkhqEhueoSuv1Y9ey4yVHxtKiUkARm458C1xq9wk7B0G3tAcYKsCM0YDU09qEOvoT2y0DrBP29en3dVzowoGNM5z/ZpbFatwq+1Vc2IrLJDb/HWCFYrLzJgf5SXYYq6dv2LxUWMjomxBBDHcNi8RdH5PNXpbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMk4hWRAxYPZGjJS7x0IYFG+LwcLOygdSFWLndkYy9g=;
 b=V01gpqi7MNS9mssV8yurXgaFGLxOyDLCS9pj2YwHXlWh4Wv4ahPiN2lJNervZdFZeDWuRL4A67XaIMt0+U+OTBp9oS9aPqkP0PQni8WWGK6UR5ELODrgkH/hOETaTFk2FFP7GOwd5TpJt3n2FuJ+ZL6nfue6eIlSQuHPV2unT9aZSZo4kONUqUN0/94HKt022e0srFDOeqa10AOV6lHeP+sbLm/pHPCKKe9eMmVbGSKPLUHXSbB6TdSmQmc7Xl+rEBd/WJu93nAuYsDwbia70+yR1rmwhEVFxgq2FLRlMMczK4uhCvWamX93MBlDuytmBWwzmKzxJaRz6THnS2Df+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMk4hWRAxYPZGjJS7x0IYFG+LwcLOygdSFWLndkYy9g=;
 b=HzH3KFGGmfYrAghSkOEARzVP7F+JQLx3v+XeSKPGiN4fRjQwOwvrt6ESG96GMcpZfGT3oJjq4Ca9b5trWppwc4C1H5ktARiROtbY3Q0BxPmsTD+l2AmQCVm3rWM2B/sy1F48K9/m/DfCGUxigraqSMTPY/rPtBAZYfS5G1VT5tQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5319.namprd05.prod.outlook.com (20.177.127.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.15; Tue, 27 Aug 2019 19:46:52 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Tue, 27 Aug 2019
 19:46:52 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
Thread-Topic: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
Thread-Index: AQHVWkMLtq80nSu65U6cmIhUDbm/8KcPVgiAgAAVyYA=
Date:   Tue, 27 Aug 2019 19:46:52 +0000
Message-ID: <3B6DF400-FF8B-4B9B-8F3D-8B8CB21A9CF4@vmware.com>
References: <20190823225248.15597-1-namit@vmware.com>
 <20190823225248.15597-3-namit@vmware.com>
 <d68bef6d-d71c-7881-87e8-133f657e495a@intel.com>
In-Reply-To: <d68bef6d-d71c-7881-87e8-133f657e495a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4580:b719:cc3a:fcc:d5fc:5ff2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eda496b5-7c7e-4186-4e4d-08d72b274ef0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR05MB5319;
x-ms-traffictypediagnostic: BYAPR05MB5319:
x-microsoft-antispam-prvs: <BYAPR05MB5319574BCBB0E8369FB0B0B9D0A00@BYAPR05MB5319.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(189003)(199004)(476003)(6246003)(66946007)(76116006)(256004)(66476007)(66556008)(64756008)(66446008)(305945005)(54906003)(2906002)(99286004)(6486002)(6512007)(7736002)(71200400001)(71190400001)(86362001)(4326008)(8936002)(229853002)(53936002)(316002)(486006)(46003)(76176011)(102836004)(6436002)(478600001)(6506007)(53546011)(186003)(6916009)(8676002)(81166006)(81156014)(2616005)(36756003)(14454004)(11346002)(5660300002)(6116002)(25786009)(33656002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5319;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oLmtIZdd9zyuDfXWRGTn2Ao0qaqKrTd4XpMIyGf5z6+Sk8nh5yUAHY4/EBkTKEQ5zZ0Abr6WYCUeI1F11rgQNbM1d0dgPNLJ/GmdxyT06qTApoeRSzUpHfgoLF7fkexJwJian3ftwwUHZkVzlKGqYEBjrr9qS/VlbIMgkdOeWKyoCIquXrPz4Ja8Gd5RYYJEeEveJFNX8W56XMHam4m6KvBb3XUy463zyj2J7ddBBYPHAjFyslxQVEq5wbn9wb0FN9CGx9qQhBDGEi+Lp+LmFhjnVVV4/87haR4wpC+802Ic4ThM55lpikxMGN3WhurBs6N3TVKj7eSQGtdHkrg+gDpI6wLCLbrfsn5uExG8gJx/v/KB9WNd8Jz0FFB1iPFPyZFmUp2Khn3wTvdDX8C9RKLUgCSQ7H3XZUwiChliCP0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <28A9D5AF6E641A4984EB0494F8D72C12@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda496b5-7c7e-4186-4e4d-08d72b274ef0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 19:46:52.0237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qm4Gb4WGI3v3U9sEv7GOLH+YWPwWH8X8C4RoHIw/z/ePIEXU3REuez5OezZAvuJxEV3g/hB116G6FSgdPzWLxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBBdWcgMjcsIDIwMTksIGF0IDExOjI4IEFNLCBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPiB3cm90ZToNCj4gDQo+IE9uIDgvMjMvMTkgMzo1MiBQTSwgTmFkYXYgQW1pdCB3
cm90ZToNCj4+IElOVlBDSUQgaXMgY29uc2lkZXJhYmx5IHNsb3dlciB0aGFuIElOVkxQRyBvZiBh
IHNpbmdsZSBQVEUuIFVzaW5nIGl0IHRvDQo+PiBmbHVzaCB0aGUgdXNlciBwYWdlLXRhYmxlcyB3
aGVuIFBUSSBpcyBlbmFibGVkIHRoZXJlZm9yZSBpbnRyb2R1Y2VzDQo+PiBzaWduaWZpY2FudCBv
dmVyaGVhZC4NCj4gDQo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIHdvcnRoIGFsbCB0aGUgY2h1cm4s
IGVzcGVjaWFsbHkgaW4gdGhlIGVudHJ5IGNvZGUuDQo+IEZvciBsYXJnZSBmbHVzaGVzICg+IHRs
Yl9zaW5nbGVfcGFnZV9mbHVzaF9jZWlsaW5nKSwgd2UgZG9uJ3QgZG8NCj4gSU5WUENJRHMgaW4g
dGhlIGZpcnN0IHBsYWNlLg0KDQpJdCBpcyBwb3NzaWJsZSB0byBqdW1wIGZyb20gZmx1c2hfdGxi
X2Z1bmMoKSBpbnRvIHRoZSB0cmFtcG9saW5lIHBhZ2UsDQppbnN0ZWFkIG9mIGZsdXNoaW5nIHRo
ZSBUTEIgaW4gdGhlIGVudHJ5IGNvZGUuIEhvd2V2ZXIsIGl0IGluZHVjZXMgaGlnaGVyDQpvdmVy
aGVhZCAoc3dpdGNoaW5nIENSM3MpLCBzbyBpdCB3aWxsIG9ubHkgYmUgdXNlZnVsIGlmIG11bHRp
cGxlIFRMQiBlbnRyaWVzDQphcmUgZmx1c2hlZCBhdCBvbmNlLiBJdCBhbHNvIHByZXZlbnRzIGV4
cGxvaXRpbmcgb3Bwb3J0dW5pdGllcyBvZiBwcm9tb3RpbmcNCmluZGl2aWR1YWwgZW50cnkgZmx1
c2hlcyBpbnRvIGEgZnVsbC1UTEIgZmx1c2ggd2hlbiBtdWx0aXBsZSBmbHVzaGVzIGFyZQ0KaXNz
dWVkIG9yIHdoZW4gY29udGV4dCBzd2l0Y2ggdGFrZXMgcGxhY2UgYmVmb3JlIHJldHVybmluZy10
by11c2VyLXNwYWNlLg0KDQpUaGVyZSBhcmUgY2FzZXMvd29ya2xvYWRzIHRoYXQgZmx1c2ggbXVs
dGlwbGUgKGJ1dCBub3QgdG9vIG1hbnkpIFRMQiBlbnRyaWVzDQpvbiBldmVyeSBzeXNjYWxsLCBm
b3IgaW5zdGFuY2UgaXNzdWluZyBtc3luYygpIG9yIHJ1bm5pbmcgQXBhY2hlIHdlYnNlcnZlci4N
ClNvIEkgYW0gbm90IHN1cmUgdGhhdCB0bGJfc2luZ2xlX3BhZ2VfZmx1c2hfY2VpbGluZyBzYXZl
cyB0aGUgZGF5LiBCZXNpZGVzLA0KeW91IG1heSB3YW50IHRvIHJlY2FsaWJyYXRlIChsb3dlcikg
dGxiX3NpbmdsZV9wYWdlX2ZsdXNoX2NlaWxpbmcgd2hlbiBQVEkNCmlzIHVzZWQuDQoNCj4gSSdk
IHJlYWxseSB3YW50IHRvIHVuZGVyc3RhbmQgd2hhdCB0aGUgaGVjayBpcyBnb2luZyBvbiB0aGF0
IG1ha2VzDQo+IElOVlBDSUQgc28gc2xvdywgZmlyc3QuDQoNCklOVlBDSUQtc2luZ2xlIGlzIHNs
b3cgKGV2ZW4gbW9yZSB0aGFuIDEzMyBjeWNsZXMgc2xvd2VyIHRoYW4gSU5WTFBHIHRoYXQNCnlv
dSBtZW50aW9uZWQ7IEkgZG9u4oCZdCBoYXZlIHRoZSBudW1iZXJzIGlmIGZyb250IG9mIG1lKS4g
SSB0aG91Z2h0IHRoYXQgdGhpcw0KaXMgYSBrbm93biBmYWN0LCBhbHRob3VnaCwgb2J2aW91c2x5
LCBpdCBkb2VzIG5vdCBtYWtlIG11Y2ggc2Vuc2UuDQoNCg==
