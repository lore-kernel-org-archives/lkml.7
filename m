Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC46C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDA72071F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 16:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VsG4B7Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfLBQgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 11:36:46 -0500
Received: from mail-eopbgr820059.outbound.protection.outlook.com ([40.107.82.59]:7124
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727533AbfLBQgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 11:36:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHhdbGOL8+OvYev3Q5h8mY/CrA8mfSLJEVvNd5SY3VcOeF8DPjHTJNS/UhkEdIIzIk8pqAdmitWw8LVy5Vq44Nizt07tUE0LOrnwcz2lzd9xMoUyFKso+kgBO5wIdh9CJZXwTAtvQ4oMoxjuqVDCuZANzaZiUB/7pkoExIJMOZyKDThP15V6w/Pn+sWBHUofKY4AsvA/fGzjsWVhjZ2CRy7ZVdZKP9veSBGdWyLCsNFocQGLirQIFhXoP5OhdHEXrDBxgyJJKCfSokuZViE8IONbsYX0n59HOYa1ySqcOrE+Eryw6S2cL1lwMmuI03aJBmcJmB/AMzQMpx2n92o30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5YWtc6I5Mg9xMqRc4g5g0bNtSPaKsedMJs0Dvfzfc=;
 b=AqpTZnWnKaFEwdLu2j+NzVWZTSxrG4m02ErJoAmDpEN7T8WgafFhlVj+oDVAArU7iZDv/1Pbll2YgCkP+NtDIARJIRVy0hpdoSOe0a0hJqqrJ2o/etAzWhuql9vhjkCyILCeQb/H8KvEgaOJdmTChGfGh2j1mbaO2/OMVcmKNMOt1WiKL9eeTk/1ai3k9o+Q3wksA87CtoXaUFRcquUOv4olnOPbx/VaPQx0QNgAyCZEp3KU8m62MRc4Ms2h2OKnAsw6uOCsOBDjqlEv+kYn5mVCyFU9zHeEZ77rcEQ3nsjkhT6D7pw90rLaZ3EGsIVWD3NERZed3NgVVJspK/iZ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xx5YWtc6I5Mg9xMqRc4g5g0bNtSPaKsedMJs0Dvfzfc=;
 b=VsG4B7FmJOJS8J45OCIGpbEQsrLzsBQs5uhQoyD9TBlP16GkRcvAujOFPSDRGk4QQdnfykDnh4g2rMRuh7msuiSl5qZpzu5Q6u9nWGqjWMayVqBsJMVb3KvyeuqhdSZ6jiPqORHE1MlJjvwEb99BMu73YB2fAm7XWc04rML0lXQ=
Received: from MWHPR12MB1358.namprd12.prod.outlook.com (10.169.203.148) by
 MWHPR12MB1936.namprd12.prod.outlook.com (10.175.56.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Mon, 2 Dec 2019 16:36:43 +0000
Received: from MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f]) by MWHPR12MB1358.namprd12.prod.outlook.com
 ([fe80::b94d:fcd8:729d:a94f%3]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 16:36:42 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Lucas Stach <dev@lynxeye.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Topic: [PATCH v2] iommu/amd: Disable IOMMU on Stoney Ridge systems
Thread-Index: AQHVpsBguKm4D8iWWkiQt39oc44V0aelPBeAgAHRwGA=
Date:   Mon, 2 Dec 2019 16:36:42 +0000
Message-ID: <MWHPR12MB1358891F2AC2AAA41E9BA835F7430@MWHPR12MB1358.namprd12.prod.outlook.com>
References: <20191129142154.29658-1-kai.heng.feng@canonical.com>
 <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
In-Reply-To: <5b2097e8c4172a8516fcfc8c56dc98e3d105ffe2.camel@lynxeye.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea1878a8-fac6-4dc2-0a8b-08d77745d074
x-ms-traffictypediagnostic: MWHPR12MB1936:|MWHPR12MB1936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB1936F823EA139D6808CE64BBF7430@MWHPR12MB1936.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(189003)(199004)(13464003)(110136005)(54906003)(5660300002)(6636002)(7736002)(256004)(14444005)(71190400001)(55016002)(6506007)(81156014)(71200400001)(6436002)(33656002)(4326008)(66066001)(6246003)(14454004)(478600001)(966005)(2501003)(86362001)(25786009)(2906002)(3846002)(45080400002)(6116002)(6306002)(66946007)(316002)(9686003)(229853002)(66556008)(76176011)(66446008)(7696005)(52536014)(76116006)(74316002)(305945005)(11346002)(446003)(99286004)(186003)(26005)(81166006)(66476007)(102836004)(8676002)(8936002)(64756008)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1936;H:MWHPR12MB1358.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2IaOJCxpBgPn0lbPxuRo/l6ThleHjqnL1vofXGVZbThg0zpTnxvwXpg2lIF1peRAnvyfFfJoH4go0h3HUn7pmpTNtLYORWUH7Y2uRSgN+ceO6YcQ81nwvT5yERm91OQ8y/uv1GwNL8iBUyii692zsBykxRToOKhnzT5ank8kd//pRVDeVYtyiCyb7TSd8qANzEUrGoEvSNaYt6cGa25L/4R+wcygs/enI6XYlwm35A6isl6mP6voK+jdANSIj26a9d/fnVebDrOy6b4i37nEw0RSARQU+b2OxsO6pNa9Gnto34a/Ss7j7a77fEomD5yJvlusxe2tBiRhxOXcz0rbeLluDacOA0bY+0zRGlufpFxnTAL402RO3qgXChxSgGwFr0X7KpkhcUpiq1SqsqGBbW3HU6nwqjNWOYV5kMBc2Ma/r6J4+UnJjFGkenJdZqxz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1878a8-fac6-4dc2-0a8b-08d77745d074
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 16:36:42.8789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: orAiYRdyKAfQ90R3JcERFzyfs/zbILTXFtow24+3lpVgoGkp2V/p5picH1FEQmSROdSWjlqfbWXlPrHoGgprIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1936
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8ZGV2QGx5
bnhleWUuZGU+DQo+IFNlbnQ6IFN1bmRheSwgRGVjZW1iZXIgMSwgMjAxOSA3OjQzIEFNDQo+IFRv
OiBLYWktSGVuZyBGZW5nIDxrYWkuaGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+OyBqb3JvQDhieXRl
cy5vcmcNCj4gQ2M6IERldWNoZXIsIEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNv
bT47DQo+IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIGlvbW11L2FtZDogRGlzYWJs
ZSBJT01NVSBvbiBTdG9uZXkgUmlkZ2UNCj4gc3lzdGVtcw0KPiANCj4gQW0gRnJlaXRhZywgZGVu
IDI5LjExLjIwMTksIDIyOjIxICswODAwIHNjaHJpZWIgS2FpLUhlbmcgRmVuZzoNCj4gPiBTZXJp
b3VzIHNjcmVlbiBmbGlja2VyaW5nIHdoZW4gU3RvbmV5IFJpZGdlIG91dHB1dHMgdG8gYSA0SyBt
b25pdG9yLg0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIEFsZXggRGV1Y2hlciwgSU9NTVUgaXNuJ3Qg
ZW5hYmxlZCBvbiBXaW5kb3dzLCBzbyBsZXQncyBkbw0KPiA+IHRoZSBzYW1lIGhlcmUgdG8gYXZv
aWQgc2NyZWVuIGZsaWNrZXJpbmcgb24gNEsgbW9uaXRvci4NCj4gDQo+IFRoaXMgZG9lc24ndCBz
ZWVtIGxpa2UgYSBnb29kIHNvbHV0aW9uLCBlc3BlY2lhbGx5IGlmIHRoZXJlIGlzbid0IGEgbWV0
aG9kIGZvcg0KPiB0aGUgdXNlciB0byBvcHQtb3V0LiAgU29tZSB1c2VycyBtaWdodCBwcmVmZXIg
aGF2aW5nIHRoZSBJT01NVSBzdXBwb3J0IHRvDQo+IDRLIGRpc3BsYXkgb3V0cHV0Lg0KPiANCj4g
QnV0IGJlZm9yZSB1c2luZyB0aGUgYmlnIGhhbW1lciBvZiBkaXNhYmxpbmcgb3IgYnJlYWtpbmcg
b25lIG9mIHRob3NlDQo+IGZlYXR1cmVzLCB3ZSBzaG91bGQgdGFrZSBhIGxvb2sgYXQgd2hhdCdz
IHRoZSBpc3N1ZSBoZXJlLiBTY3JlZW4gZmxpY2tlcmluZw0KPiBjYXVzZWQgYnkgdGhlIElPTU1V
IGJlaW5nIGFjdGl2ZSBoaW50cyB0byB0aGUgSU9NTVUgbm90IGJlaW5nIGFibGUgdG8NCj4gc3Vz
dGFpbiB0aGUgdHJhbnNsYXRpb24gYmFuZHdpZHRoIHJlcXVpcmVkIGJ5IHRoZSBoaWdoLSBiYW5k
d2lkdGgNCj4gaXNvY2hyb25vdXMgdHJhbnNmZXJzIGNhdXNlZCBieSA0SyBzY2Fub3V0LCBtb3N0
IGxpa2VseSBkdWUgdG8gaW5zdWZmaWNpZW50DQo+IFRMQiBzcGFjZS4NCj4gDQo+IEFzIGZhciBh
cyBJIGtub3cgdGhlIGZyYW1lYnVmZmVyIG1lbW9yeSBmb3IgdGhlIGRpc3BsYXkgYnVmZmVycyBp
cyBsb2NhdGVkIGluDQo+IHN0b2xlbiBSQU0sIGFuZCB0aHVzIGNvbnRpZ291cyBpbiBtZW1vcnku
IEkgZG9uJ3Qga25vdyB0aGUgZGV0YWlscyBvZiB0aGUNCj4gR1BVIGludGVncmF0aW9uIG9uIHRo
b3NlIEFQVXMsIGJ1dCBtYXliZSB0aGVyZSBldmVuIGlzIGEgd2F5IHRvIGJ5cGFzcyB0aGUNCj4g
SU9NTVUgZm9yIHRoZSBzdG9sZW4gVlJBTSByZWdpb25zPw0KPiANCj4gSWYgdGhlcmUgaXNuJ3Qg
YW5kIGFsbCBHUFUgdHJhZmZpYyBwYXNzZXMgdGhyb3VnaCB0aGUgSU9NTVUgd2hlbiBhY3RpdmUs
IHdlDQo+IHNob3VsZCBjaGVjayBpZiB0aGUgc3RvbGVuIFJBTSBpcyBtYXBwZWQgd2l0aCBodWdl
cGFnZXMgb24gdGhlIElPTU1VDQo+IHNpZGUuIEFsbCB0aGUgc3RvbGVuIFJBTSBjYW4gbW9zdCBs
aWtlbHkgYmUgbWFwcGVkIHdpdGggYSBmZXcgaHVnZXBhZ2UNCj4gbWFwcGluZ3MsIHdoaWNoIHNo
b3VsZCByZWR1Y2UgSU9NTVUgVExCIGRlbWFuZCBieSBhIGxhcmdlIG1hcmdpbi4NCg0KVGhlIGlz
IG5vIGlzc3VlIHdoZW4gd2Ugc2NhbiBvdXQgb2YgdGhlIGNhcnZlIG91dCByZWdpb24uICBUaGUg
aXNzdWUgb2NjdXJzIHdoZW4gd2Ugc2NhbiBvdXQgb2YgcmVndWxhciBzeXN0ZW0gbWVtb3J5IChz
Y2F0dGVyL2dhdGhlcikuICBNYW55IG5ld2VyIGxhcHRvcHMgaGF2ZSB2ZXJ5IHNtYWxsIGNhcnZl
IG91dCByZWdpb25zIChlLmcuLCAzMiBNQiksIHNvIHdlIGhhdmUgdG8gdXNlIHJlZ3VsYXIgc3lz
dGVtIHBhZ2VzIHRvIHN1cHBvcnQgbXVsdGlwbGUgaGlnaCByZXNvbHV0aW9uIGRpc3BsYXlzLiAg
VGhlIHByb2JsZW0gaXMsIHRoZSBsYXRlbmN5IGdldHMgdG9vIGhpZ2ggYXQgc29tZSBwb2ludCB3
aGVuIHRoZSBJT01NVSBpcyBpbnZvbHZlZC4gIEh1Z2UgcGFnZXMgd291bGQgcHJvYmFibHkgaGVs
cCBpbiB0aGlzIGNhc2UsIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlcmUgaXMgYW55IHdheSB0byBn
dWFyYW50ZWUgdGhhdCB3ZSBnZXQgaHVnZSBwYWdlcyBmb3Igc3lzdGVtIG1lbW9yeS4gIEkgZ3Vl
c3Mgd2UgY291bGQgdXNlIENNQSBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KDQpBbGV4DQoNCj4g
DQo+IFJlZ2FyZHMsDQo+IEx1Y2FzDQo+IA0KPiA+IENjOiBBbGV4IERldWNoZXIgPGFsZXhhbmRl
ci5kZXVjaGVyQGFtZC5jb20+DQo+ID4gQnVnOg0KPiA+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdGwNCj4gPg0KPiBh
Yi5mcmVlZGVza3RvcC5vcmclMkZkcm0lMkZhbWQlMkZpc3N1ZXMlMkY5NjEmYW1wO2RhdGE9MDIl
N0MwMSUNCj4gN0NhbGV4YQ0KPiA+DQo+IG5kZXIuZGV1Y2hlciU0MGFtZC5jb20lN0MzMDU0MGIy
YmYyYmU0MTdjNGQ5NTA4ZDc3NjViZjA3ZiU3QzNkZA0KPiA4OTYxZmU0DQo+ID4NCj4gODg0ZTYw
OGUxMWE4MmQ5OTRlMTgzZCU3QzAlN0MwJTdDNjM3MTA4MDEwMDc1NDYzMjY2JmFtcDtzZGF0YT0x
DQo+IFpJWlVXb3MNCj4gPiBjUGlCNGF1T1kxMGpsR3pvRmVXc3pZTURCUUcwQ3Ryck9POCUzRCZh
bXA7cmVzZXJ2ZWQ9MA0KPiA+IFNpZ25lZC1vZmYtYnk6IEthaS1IZW5nIEZlbmcgPGthaS5oZW5n
LmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjoNCj4gPiAtIEZpbmQgU3RvbmV5
IGdyYXBoaWNzIGluc3RlYWQgb2YgaG9zdCBicmlkZ2UuDQo+ID4NCj4gPiAgZHJpdmVycy9pb21t
dS9hbWRfaW9tbXVfaW5pdC5jIHwgMTMgKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvYW1kX2lvbW11X2luaXQuYw0KPiA+IGIvZHJpdmVycy9pb21tdS9hbWRf
aW9tbXVfaW5pdC5jIGluZGV4IDU2OGM1MjMxNzc1Ny4uMTM5YWE2ZmRhZGRhDQo+ID4gMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+ID4gKysrIGIvZHJp
dmVycy9pb21tdS9hbWRfaW9tbXVfaW5pdC5jDQo+ID4gQEAgLTI1MTYsNiArMjUxNiw3IEBAIHN0
YXRpYyBpbnQgX19pbml0IGVhcmx5X2FtZF9pb21tdV9pbml0KHZvaWQpDQo+ID4gIAlzdHJ1Y3Qg
YWNwaV90YWJsZV9oZWFkZXIgKml2cnNfYmFzZTsNCj4gPiAgCWFjcGlfc3RhdHVzIHN0YXR1czsN
Cj4gPiAgCWludCBpLCByZW1hcF9jYWNoZV9zeiwgcmV0ID0gMDsNCj4gPiArCXUzMiBwY2lfaWQ7
DQo+ID4NCj4gPiAgCWlmICghYW1kX2lvbW11X2RldGVjdGVkKQ0KPiA+ICAJCXJldHVybiAtRU5P
REVWOw0KPiA+IEBAIC0yNjAzLDYgKzI2MDQsMTYgQEAgc3RhdGljIGludCBfX2luaXQgZWFybHlf
YW1kX2lvbW11X2luaXQodm9pZCkNCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290byBvdXQ7DQo+
ID4NCj4gPiArCS8qIERpc2FibGUgSU9NTVUgaWYgdGhlcmUncyBTdG9uZXkgUmlkZ2UgZ3JhcGhp
Y3MgKi8NCj4gPiArCWZvciAoaSA9IDA7IGkgPCAzMjsgaSsrKSB7DQo+ID4gKwkJcGNpX2lkID0g
cmVhZF9wY2lfY29uZmlnKDAsIGksIDAsIDApOw0KPiA+ICsJCWlmICgocGNpX2lkICYgMHhmZmZm
KSA9PSAweDEwMDIgJiYgKHBjaV9pZCA+PiAxNikgPT0gMHg5OGU0KSB7DQo+ID4gKwkJCXByX2lu
Zm8oIkRpc2FibGUgSU9NTVUgb24gU3RvbmV5IFJpZGdlXG4iKTsNCj4gPiArCQkJYW1kX2lvbW11
X2Rpc2FibGVkID0gdHJ1ZTsNCj4gPiArCQkJYnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiAgCS8qIERpc2FibGUgYW55IHByZXZpb3VzbHkgZW5hYmxlZCBJT01NVXMgKi8NCj4g
PiAgCWlmICghaXNfa2R1bXBfa2VybmVsKCkgfHwgYW1kX2lvbW11X2Rpc2FibGVkKQ0KPiA+ICAJ
CWRpc2FibGVfaW9tbXVzKCk7DQo+ID4gQEAgLTI3MTEsNyArMjcyMiw3IEBAIHN0YXRpYyBpbnQg
X19pbml0IHN0YXRlX25leHQodm9pZCkNCj4gPiAgCQlyZXQgPSBlYXJseV9hbWRfaW9tbXVfaW5p
dCgpOw0KPiA+ICAJCWluaXRfc3RhdGUgPSByZXQgPyBJT01NVV9JTklUX0VSUk9SIDoNCj4gSU9N
TVVfQUNQSV9GSU5JU0hFRDsNCj4gPiAgCQlpZiAoaW5pdF9zdGF0ZSA9PSBJT01NVV9BQ1BJX0ZJ
TklTSEVEICYmDQo+IGFtZF9pb21tdV9kaXNhYmxlZCkgew0KPiA+IC0JCQlwcl9pbmZvKCJBTUQg
SU9NTVUgZGlzYWJsZWQgb24ga2VybmVsIGNvbW1hbmQtDQo+IGxpbmVcbiIpOw0KPiA+ICsJCQlw
cl9pbmZvKCJBTUQgSU9NTVUgZGlzYWJsZWRcbiIpOw0KPiA+ICAJCQlpbml0X3N0YXRlID0gSU9N
TVVfQ01ETElORV9ESVNBQkxFRDsNCj4gPiAgCQkJcmV0ID0gLUVJTlZBTDsNCj4gPiAgCQl9DQoN
Cg==
