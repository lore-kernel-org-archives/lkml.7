Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ADFC49EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24A0217F5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 09:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="iSsiuzSZ";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="0hASMguK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfKEJkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 04:40:37 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:16232 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730537AbfKEJkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 04:40:36 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA59cst3026560;
        Tue, 5 Nov 2019 01:40:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=DZCbH7aD6+rAhHyYtj2r01NThLRZdjHznpC8NWnvhRU=;
 b=iSsiuzSZlA9IiBS/1v91ZvcMGoGVhgJWjIrSdAjwcUS1WeoEL+87/un38ZiflGHqFEEw
 0pkUxYw5Zw0tQqD4brHD3Y3xcZyNQ+fvp+7/9Mf/DiJc0sYR5POSSQm5vbYpktYNKq1w
 hQjRIJx+HQtsdkfnc+Y+XWzCRJOdFLnzSRZQZB9Oqd2/hzHthqwWBdLP+6bunvsAwaJ1
 gLgIyF5nz7ovTsYv+pSjftKF6q+BejuIqQ2430IZxjIkDATAh5At1FWwEvfLJGlpQMgu
 3KbpYD1ZqGoIQzxo/zVoJjkZCMvv1vI85G2NTrjh94XlDV6NQ4L9yl1k7Qa5iykzF9de zA== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2057.outbound.protection.outlook.com [104.47.38.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2w2t0q3fau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 05 Nov 2019 01:40:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rir7yLdO7/Wm4rTnpko+w7NZepVYJBoneFRFgLPDKp2fWxgAyNsM9RaKddMOlxEundFlsQrjK/PE3M1Bxe8QL/vadOERtEwvZT/JZnYQswkPl78wC7QQSMabjzWX4phqNpobywLnI6ux+Pf7z/Bp10JuXyZIV2go3qY2IkCP78NO6XmRKreRItgNcItDOLQE7Xplfnj4cjGaF+cY1lkgQpvLp05Xh4FPyFMJpwd06hL4hJO2yqmkLos26EdTaAhi9MG2kGLmc7La6Ru52ybTPT02EEEAYyoB2v04v6SvOSDfJAoDrhQi/AH78zq9HhjeWKfWuYE4YvTX6GaMc/6n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZCbH7aD6+rAhHyYtj2r01NThLRZdjHznpC8NWnvhRU=;
 b=H8pA57qhHDgjjB7PP5p4JkFu3pXcvZOGEAY4US+wfKWXfwbOhjt/BLg5iOb57QWsh2I2qj2aDpplHLgQzycQ9J/KYl0Y4Bzs8vaVxGZ2H4tCGi2Byz1+tjch/amB9ZPmFKrsHgbS8X6oiQhHq0c2QJJPUYgoKdc2vjHBobZojcU23nC8ioB1sk9/E1Vx+ZKIPEWHaipsJPlZYHIY+Ebw9Rbvzl6P6ziNEU4sCe9rQ8BwQyJWENOa1DNthPlmZIfLB8/7nEPGr1fwD/DBcI9Wge4WLztaeW5zVTPBqRq6KDtMis1j+NBxnQTp3BYdSn3lbAWk/M/JJbKQBtqNp608Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZCbH7aD6+rAhHyYtj2r01NThLRZdjHznpC8NWnvhRU=;
 b=0hASMguK+uRB7eQClrlgqS7eGm0bDmyK+rEvzmOARbhpdfv6bmhbBhQwumcl2VpVA5j5Ddz6ypStJZ8Z/qBQWyj7pp2NSzzvPrkVdGusX3lm1SQI142nTFlfVESduV9ltsuK9CLupepydHIU7P5z9WrLY+3C4p6pY2b7Jf6Bxes=
Received: from BY5PR07MB6419.namprd07.prod.outlook.com (10.255.136.12) by
 BY5PR07MB6983.namprd07.prod.outlook.com (52.133.250.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 09:40:28 +0000
Received: from BY5PR07MB6419.namprd07.prod.outlook.com
 ([fe80::25a9:21ee:a52f:7844]) by BY5PR07MB6419.namprd07.prod.outlook.com
 ([fe80::25a9:21ee:a52f:7844%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 09:40:28 +0000
From:   Anil Joy Varughese <aniljoy@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 01/14] dt-bindings: phy: Sierra: Add bindings for
 Sierra in TI's J721E
Thread-Topic: [PATCH v2 01/14] dt-bindings: phy: Sierra: Add bindings for
 Sierra in TI's J721E
Thread-Index: AQHViaGJO6awF8G6i0KYtDRBBMF/BKdyAqmAgACx+wCACaJF8A==
Date:   Tue, 5 Nov 2019 09:40:27 +0000
Message-ID: <BY5PR07MB641954D31EA7C8149FB2073EA87E0@BY5PR07MB6419.namprd07.prod.outlook.com>
References: <20191023125735.4713-1-kishon@ti.com>
 <20191023125735.4713-2-kishon@ti.com> <20191029185916.GA19313@bogus>
 <8ec5a9bd-4283-04bf-af4c-c5b7b912a342@ti.com>
In-Reply-To: <8ec5a9bd-4283-04bf-af4c-c5b7b912a342@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3bc38f0-d566-4d64-3548-08d761d43119
x-ms-traffictypediagnostic: BY5PR07MB6983:
x-microsoft-antispam-prvs: <BY5PR07MB698333ED6F8DACD8719F8F2AA87E0@BY5PR07MB6983.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(189003)(199004)(13464003)(36092001)(99286004)(186003)(2906002)(54906003)(55016002)(81166006)(55236004)(316002)(53546011)(6506007)(66556008)(7696005)(7736002)(25786009)(6246003)(110136005)(102836004)(71190400001)(8936002)(66946007)(66476007)(64756008)(71200400001)(66446008)(76116006)(305945005)(76176011)(3846002)(6116002)(81156014)(8676002)(4326008)(86362001)(11346002)(446003)(6436002)(14454004)(256004)(476003)(486006)(52536014)(33656002)(5660300002)(229853002)(9686003)(478600001)(66066001)(74316002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6983;H:BY5PR07MB6419.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8yWrSa24TNT0YZN8XCsZl/2xiva9g7q3n3eZpdGYWSoAfdtUQOM2h9LS4CbqdAQNtMNjmHcFINBZOPjzHc1FvUVn7eksG7xvmH9GI7wZdWDtSU1j2RfaRDMdMV45W7IcWu5IFhlwUUtL0mncMD2qo8B0YLMTXy/G63aA+lzKB+wLmJYC374xCp8jluc3pCsYwXXBu1lTpR5pXmoEEl7pTUhpNHKxViuVSu1pxfXFpQI7FDwx08aoVL9iGZ0F0KKrxLOSgaJtHwusIbY93o+JHcF8+2lwRS3zDiG9eYpayhC2uXemt4q8b/ezBALnJ9Ug7uP9EnOS/TytpQF4mG1GiiwTEZMvMYbjqDWFad+8Rxg2wohsnv9KXFdkRIejMAJ79CsGP0TyHirYG+WkanhaEHcqQ29spYqOSTwv0qb2bkCvaIFatgXWa1ZpuoKeCeuBYnffhb69ux0aYfmwk0vPA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bc38f0-d566-4d64-3548-08d761d43119
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 09:40:27.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NESN8z83FGoMTDnQ88nxdns5PE6MB0vZgg1wH1JqmHNPvXLAur7SGNaWabZ7wl5WFGCJ4Sg5Qmy+q3A6CAjsL9GGsrzflBhIgyfihZhzz2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6983
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-05_03:2019-11-04,2019-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911050083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uL1JvYg0KDQpNeSBjb21tZW50cyBhcmUgYmVsb3cuDQoNCj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRp
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDMwLCAyMDE5IDExOjA2IEFNDQo+IFRv
OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQW5pbCBKb3kgVmFydWdoZXNlDQo+IDxh
bmlsam95QGNhZGVuY2UuY29tPg0KPiBDYzogUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT47
IEp5cmkgU2FyaGEgPGpzYXJoYUB0aS5jb20+OyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAwMS8xNF0gZHQtYmluZGluZ3M6IHBoeTogU2llcnJhOiBBZGQgYmluZGluZ3MgZm9yIFNpZXJy
YQ0KPiBpbiBUSSdzIEo3MjFFDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+IA0KPiANCj4gSGkgUm9i
LA0KPiANCj4gT24gMzAvMTAvMTkgMTI6MjkgQU0sIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+IE9u
IFdlZCwgT2N0IDIzLCAyMDE5IGF0IDA2OjI3OjIyUE0gKzA1MzAsIEtpc2hvbiBWaWpheSBBYnJh
aGFtIEkgd3JvdGU6DQo+ID4+IEFkZCBEVCBiaW5kaW5nIGRvY3VtZW50YXRpb24gZm9yIFNpZXJy
YSBQSFkgSVAgdXNlZCBpbiBUSSdzIEo3MjFFDQo+ID4+IFNvQy4NCj4gPj4NCj4gPj4gU2lnbmVk
LW9mZi1ieTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNvbT4NCj4gPj4gLS0t
DQo+ID4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LWNhZGVuY2Utc2llcnJhLnR4
dCAgfCAxMw0KPiA+PiArKysrKysrKy0tLS0tDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0DQo+ID4+IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS1zaWVycmEu
dHh0DQo+ID4+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktY2Fk
ZW5jZS1zaWVycmEudHh0DQo+ID4+IGluZGV4IDZlMWI0N2JmY2U0My4uYmY5MGVmN2UwMDVlIDEw
MDY0NA0KPiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3Bo
eS1jYWRlbmNlLXNpZXJyYS50eHQNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9waHktY2FkZW5jZS1zaWVycmEudHh0DQo+ID4+IEBAIC0yLDIxICsyLDI0
IEBAIENhZGVuY2UgU2llcnJhIFBIWQ0KPiA+PiAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
Pj4NCj4gPj4gIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4+IC0tIGNvbXBhdGlibGU6CWNkbnMs
c2llcnJhLXBoeS10MA0KPiA+PiAtLSBjbG9ja3M6CU11c3QgY29udGFpbiBhbiBlbnRyeSBpbiBj
bG9jay1uYW1lcy4NCj4gPj4gLQkJU2VlIC4uL2Nsb2Nrcy9jbG9jay1iaW5kaW5ncy50eHQgZm9y
IGRldGFpbHMuDQo+ID4+IC0tIGNsb2NrLW5hbWVzOglNdXN0IGJlICJwaHlfY2xrIg0KPiA+PiAr
LSBjb21wYXRpYmxlOglNdXN0IGJlICJjZG5zLHNpZXJyYS1waHktdDAiIGZvciBTaWVycmEgaW4g
Q2FkZW5jZQ0KPiBwbGF0Zm9ybQ0KPiA+PiArCQlNdXN0IGJlICJ0aSxzaWVycmEtcGh5LXQwIiBm
b3IgU2llcnJhIGluIFRJJ3MgSjcyMUUgU29DLg0KPiA+PiAgLSByZXNldHM6CU11c3QgY29udGFp
biBhbiBlbnRyeSBmb3IgZWFjaCBpbiByZXNldC1uYW1lcy4NCj4gPj4gIAkJU2VlIC4uL3Jlc2V0
L3Jlc2V0LnR4dCBmb3IgZGV0YWlscy4NCj4gPj4gIC0gcmVzZXQtbmFtZXM6CU11c3QgaW5jbHVk
ZSAic2llcnJhX3Jlc2V0IiBhbmQgInNpZXJyYV9hcGIiLg0KPiA+PiAgCQkic2llcnJhX3Jlc2V0
IiBtdXN0IGNvbnRyb2wgdGhlIHJlc2V0IGxpbmUgdG8gdGhlIFBIWS4NCj4gPj4gIAkJInNpZXJy
YV9hcGIiIG11c3QgY29udHJvbCB0aGUgcmVzZXQgbGluZSB0byB0aGUgQVBCIFBIWQ0KPiA+PiAt
CQlpbnRlcmZhY2UuDQo+ID4+ICsJCWludGVyZmFjZSAoInNpZXJyYV9hcGIiIGlzIG9wdGlvbmFs
KS4NCj4gPj4gIC0gcmVnOgkJcmVnaXN0ZXIgcmFuZ2UgZm9yIHRoZSBQSFkuDQo+ID4+ICAtICNh
ZGRyZXNzLWNlbGxzOiBNdXN0IGJlIDENCj4gPj4gIC0gI3NpemUtY2VsbHM6CU11c3QgYmUgMA0K
PiA+Pg0KPiA+PiAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPj4gKy0gY2xvY2tzOgkJTXVzdCBj
b250YWluIGFuIGVudHJ5IGluIGNsb2NrLW5hbWVzLg0KPiA+PiArCQkJU2VlIC4uL2Nsb2Nrcy9j
bG9jay1iaW5kaW5ncy50eHQgZm9yIGRldGFpbHMuDQo+ID4+ICstIGNsb2NrLW5hbWVzOgkJTXVz
dCBiZSAicGh5X2NsayIuIE11c3QgY29udGFpbiAiY21uX3JlZmNsayINCj4gYW5kDQo+ID4+ICsJ
CQkiY21uX3JlZmNsazEiIGZvciBjb25maWd1cmluZyB0aGUgZnJlcXVlbmN5IG9mIHRoZQ0KPiA+
PiArCQkJY2xvY2sgdG8gdGhlIGxhbmVzLg0KPiA+DQo+ID4gSSBkb24ndCB1bmRlcnN0YW5kIGhv
dyB0aGUgc2FtZSBibG9jayBjYW4gaGF2ZSBjb21wbGV0ZWx5IGRpZmZlcmVudA0KPiA+IGNsb2Nr
cy4gRGlkIHRoZSBvcmlnaW5hbCBiaW5kaW5nIGZvcmdldCBzb21lPw0KPiA+DQo+ID4gVEkgbmVl
ZHMgMCwgMSBvciAzIGNsb2Nrcz8gUmVhZHMgbGlrZSBpdCBjb3VsZCBiZSBhbnkuDQo+IA0KPiBG
b3IgVEksIHBoeV9jbGsgaXMgbm90IG5lZWRlZC4gQW5pbCwgY2FuIHlvdSBjbGFyaWZ5IHdoYXQg
dGhpcyBjbG9jayBhY3R1YWxseQ0KPiBjb3JyZXNwb25kcyB0bz8gSXMgaXQgYSBmdW5jdGlvbmFs
IGNsb2NrIG9mIFBIWT8NCg0KV2hlbiB3ZSBoYWQgZGVzaWduZWQgdGhlIERUIGJpbmRpbmcgZm9y
IFNpZXJyYSB3ZSB0aG91Z2h0IG9mIHVzaW5nIHBoeV9jbGsgYXMgYSBjb21tb24gaW50ZXJmYWNl
IGZvciB0aGUgY2xvY2sgaW5wdXRzIGFuZCB0aGVyZSB3YXMgbm8gc3BlY2lmaWMgcmVxdWlyZW1l
bnQgZm9yIHNwbGl0dGluZyBpdCBpbnRvIG11bHRpcGxlIGNsb2NrcyB0aGVuIGFuZCBhbHNvIHdl
IGhhZCB1c2VkIGEgc2ltdWxhdGlvbiBlbnZpcm9ubWVudCBmb3IgdGVzdGluZyBvdXIgSVAuIFdl
IGNhbiBkZXByZWNhdGUgdGhlIHBoeV9jbGsgcHJvcGVydHkuIA0KDQpUaGFua3MsDQpBbmlsDQoN
Cj4gU2llcnJhIFNFUkRFUyBhY3R1YWxseSBoYXMgYSBudW1iZXIgb2YgY2xvY2tzIHdoaWNoIGNh
biBiZSBjb25maWd1cmVkLiBUaGUNCj4gaW5pdGlhbCBkdC1iaW5kaW5nIGRpZG4ndCBtb2RlbCBh
bGwgdGhlc2UgY2xvY2tzLiBUaGUgImNtbl9yZWZjbGsiIGFuZA0KPiAiY21uX3JlZmNsazEiIGFy
ZSB1c2VkIHRvIHByb2dyYW0gdGhlIGRpdmlkZXJzIHdpdGhpbmcgdGhlIFNpZXJyYS4gVGhlIGFj
dHVhbA0KPiByZWdpc3RlcnMgZm9yIHByb2dyYW1taW5nIHRoZSBkaXZpZGVycyBhcmUgaW4gdGhl
IFNpZXJyYSB3cmFwcGVyIHRob3VnaC4gVGhlDQo+IG9yaWdpbmFsIFNpZXJyYSBkcml2ZXIgYW5k
IGR0LWJpbmRpbmcgZGlkbid0IHRyeSB0byBjaGFuZ2UgdGhlIGRlZmF1bHQgZGl2aWRlcg0KPiB2
YWx1ZXMuDQo+IA0KPiBUaGFua3MNCj4gS2lzaG9uDQo+ID4NCj4gPiBSb2INCj4gPg0K
