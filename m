Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0182C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEA420727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="EhW6vkti";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="lhVp282x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKRJBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:01:00 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45286 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726420AbfKRJBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:01:00 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8rXsx031372;
        Mon, 18 Nov 2019 01:00:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=uTnqQjmoHeWtsO11y6eR9/54eHaUdJy5BaCFU0Q8MGY=;
 b=EhW6vktiNGsLnFuPaXhQaM6d2YTaVDiX5RytDObo3vgLaFtOrsxqBNSaaMhRzWAvtKCW
 JuCAGHd0pFVu8m3/udRgQeDJQCgSKrLTaleONKUpm9c4oeD/NJVzepsf/Qb7V0RCKhl7
 ILPnL0K1a2951BtAiMwEqIvZOBBCFp0bQM4K4aP/PzxewKy5MZ3IltW0DgoMReoCQjPA
 +Ombl0lNwFJ3b4eYisHl2uZYjzMMz++WmS2f+0RLUBNGfDxfEtIWWMDgQNWZA9kTBJxZ
 UEsqGBL0xKkcRdw9wRhinYOdQIU3Q5eNjUgdWOu8BU3SQFZtL549s6qZ55e4N9mqX8uC 2g== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2052.outbound.protection.outlook.com [104.47.48.52])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2wadjy5p8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 01:00:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMs2P9TiURK0LPdvRUiJuh8icxMETEYH/pcPaasdxaw8YkQbknmB4YejpIt7V4rYeUsFEIZL2iE0uQo1s3Otnyr0rtgOgHsduZqoMwqTSIbjN9wTgmybwdsUZZkhSChUlTUOJ4c7FRmhgtfFRTLewCczk5zPywmE0ejeaJIRiPDotY4kzXNRyIcYKRJG3/FHvtR9AwZUA/JLI30MGT7WdWcrsVVrmfwwKuwevIfqBjeujyqPcig77q1O8FpFwM0hoQgj41yPTWwMZAIKQuRZRFe1YJVLYC6D5Uit4e4YYFM+EfHnDFGPEbtnHBaGvtvcCVaFYZGeInUtoPBuw3jWuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnqQjmoHeWtsO11y6eR9/54eHaUdJy5BaCFU0Q8MGY=;
 b=ZbttCEqeVM6GY+Esk+tnx2lSitIggD/2fQJuSAM3dJXSxpCJtxbKKHMIMOfipKdzV9W6rfE+GAWreO0NnjfS3QtVlmnOWen7uxR03nc/U7Ncyu90scoqBGu6tUsdX9dweyIglFmB7qxkSeZKfkRWE96eHEnnDozVNaiar8LCVrUoW42sHKXaJtAJoLsprTUM3G/6dj+nvwV067jOL3U9tQYpLViqd1EwGH3IF1uQy6wzhtWOimS672/3qjhwdZPQNu674muOVhQYixDODqbA2pFYkkkV/c6udwSLwZn3Lw+53lzt6Fq+ajmBa5/Y+l+6gH3d+J/gOYhHiWE5I0axlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnqQjmoHeWtsO11y6eR9/54eHaUdJy5BaCFU0Q8MGY=;
 b=lhVp282xmOQCLOjOmkCE87tjiBPJHHwDNoMJUG27g8LMrVgg49g+W/+I1HsFr3sxkwgTBdc3JKUILbGTzwKm2a3GQMNZV3f57DoFS7ztRadYnVU2BLSTR/XLNzgDsWP5bvcxwav5uYtTg85cIo+MtMcJO4e+MwqmCRXznb41jZ4=
Received: from BY5PR07MB6419.namprd07.prod.outlook.com (10.255.136.12) by
 BY5PR07MB6936.namprd07.prod.outlook.com (52.133.250.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 09:00:51 +0000
Received: from BY5PR07MB6419.namprd07.prod.outlook.com
 ([fe80::25cd:11f4:7c01:a6d9]) by BY5PR07MB6419.namprd07.prod.outlook.com
 ([fe80::25cd:11f4:7c01:a6d9%7]) with mapi id 15.20.2451.029; Mon, 18 Nov 2019
 09:00:51 +0000
From:   Anil Joy Varughese <aniljoy@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Milind Parab <mparab@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>
Subject: RE: [PATCH] bindings:phy Mark phy_clk binding as deprecated in
 Cadence Sierra Phy.
Thread-Topic: [PATCH] bindings:phy Mark phy_clk binding as deprecated in
 Cadence Sierra Phy.
Thread-Index: AQHVnePhVSERbn45oUaHJtPPPnggC6eQkTCAgAANjwA=
Date:   Mon, 18 Nov 2019 09:00:51 +0000
Message-ID: <BY5PR07MB6419CF57AD7F6C451C18C840A84D0@BY5PR07MB6419.namprd07.prod.outlook.com>
References: <1574062988-4751-1-git-send-email-aniljoy@cadence.com>
 <dce65150-cbd8-eb4d-5778-47658a719eb5@ti.com>
In-Reply-To: <dce65150-cbd8-eb4d-5778-47658a719eb5@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [14.143.9.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dd347df-bff8-490c-7f1c-08d76c05cfad
x-ms-traffictypediagnostic: BY5PR07MB6936:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR07MB693685E1EA4315C4BC708905A84D0@BY5PR07MB6936.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0225B0D5BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39850400004)(366004)(36092001)(199004)(189003)(13464003)(8676002)(81156014)(53546011)(6506007)(14454004)(66556008)(7696005)(4326008)(2906002)(55236004)(76176011)(55016002)(102836004)(6436002)(33656002)(229853002)(5660300002)(26005)(11346002)(2501003)(476003)(486006)(54906003)(2201001)(446003)(6246003)(107886003)(86362001)(9686003)(6116002)(316002)(3846002)(25786009)(66066001)(8936002)(7736002)(305945005)(186003)(110136005)(52536014)(71190400001)(74316002)(99286004)(256004)(14444005)(66946007)(478600001)(66446008)(64756008)(76116006)(66476007)(81166006)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR07MB6936;H:BY5PR07MB6419.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jgJp/0YJQ5ivc0KPzN7Z53dObrQDdPDP/qmJuihwRmeUDa+HQSLZVFzh0dsyED2HTmT7+swoljt8al7rlPgZ7U33v/PmTjYNuI85cypFykU2H9vuMfuKhmsR44JZc/cmpYKIi90kAIPr8czF0X5g2AY2WcMkcRJJedkidgNNa/Tbl6cBtEyGq/Z1iACo7sUQnSbp/6c2t7NDkafs3FrYfireVmaFizv/GiA1RxZQWwi4CkFQZJIBw9HAh358jj30beEKOAc0h8ZnZhWItmY0tHcr73jNfUmaNbYoQYDaIlWmMx7G+uAfzEVpkXXnkp8rAsJJwhihtRcQbpY2z3Tw1ZuPGrNIR1+xrwlXC7qpQI6k9fr3NCVWxOij9SGVf1RBic706P9G19igWlcMfsQT6xUmOm7x67mwJOydPJ7H+gNCRkQDHbqsLe1wBBGjvBVMyFqpS1TImT1GXDdYD+poMA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd347df-bff8-490c-7f1c-08d76c05cfad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2019 09:00:51.0465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tx+2JQW//E0f2cHYMEJ7NbAUx8PMr+CVLJnh8Et52GzvRH28p8/tX8RGCX/3NtkZMBHFxHuVBXTcUXZmli1yre6yfO7/fTy/eatAp9EFPs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6936
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911180081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtpc2hv
biBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTm92ZW1i
ZXIgMTgsIDIwMTkgMTozMiBQTQ0KPiBUbzogQW5pbCBKb3kgVmFydWdoZXNlIDxhbmlsam95QGNh
ZGVuY2UuY29tPjsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IE1pbGluZCBQYXJhYiA8bXBhcmFiQGNhZGVuY2UuY29tPjsgUmFmYWwgQ2llcGll
bGENCj4gPHJhZmFsY0BjYWRlbmNlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYmluZGlu
Z3M6cGh5IE1hcmsgcGh5X2NsayBiaW5kaW5nIGFzIGRlcHJlY2F0ZWQgaW4NCj4gQ2FkZW5jZSBT
aWVycmEgUGh5Lg0KPiANCj4gRVhURVJOQUwgTUFJTA0KPiANCj4gDQo+IEFuaWwsDQo+IA0KPiBP
biAxOC8xMS8xOSAxOjEzIFBNLCBBbmlsIEpveSBWYXJ1Z2hlc2Ugd3JvdGU6DQo+ID4gVXBkYXRl
ZCB0aGUgU2llcnJhIFBoeSBiaW5kaW5nIGRvYyB0byBtYXJrIHBoeV9jbGsgYXMgZGVwcmVjYXRl
ZC4NCj4gDQo+IFRoaXMgc2hvdWxkIGFsc28gaW5kaWNhdGUgd2h5IHlvdXIgYXJlIGRlcHJlY2F0
aW5nIGl0Lg0KPiANCj4gVGhhbmtzDQo+IEtpc2hvbg0KDQpJIGFtIGRlcHJlY2F0aW5nIGl0IHNp
bmNlIHRoZXJlIGlzIGEgbmV3IHNldCBvZiBiaW5kaW5ncyAoY21uX3JlZmNsaywgY21uX3JlZmNs
azEpIGFubm91bmNlZCBieSBUSS4NCg0KV2lsbCB1cGRhdGUgYW5kIHNlbmQgbmV3IHBhdGNoLg0K
DQpUaGFua3MsDQpBbmlsDQoNCg0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQW5pbCBK
b3kgVmFydWdoZXNlIDxhbmlsam95QGNhZGVuY2UuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvcGh5LWNhZGVuY2Utc2llcnJhLnR4dCB8ICAgIDIgKy0NCj4g
PiAgMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9w
aHktY2FkZW5jZS1zaWVycmEudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9waHktY2FkZW5jZS1zaWVycmEudHh0DQo+ID4gaW5kZXggNmUxYjQ3Yi4uOWE0MmI0
NiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5
L3BoeS1jYWRlbmNlLXNpZXJyYS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGh5L3BoeS1jYWRlbmNlLXNpZXJyYS50eHQNCj4gPiBAQCAtNSw3ICs1LDcg
QEAgUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgLSBjb21wYXRpYmxlOgljZG5zLHNpZXJyYS1w
aHktdDANCj4gPiAgLSBjbG9ja3M6CU11c3QgY29udGFpbiBhbiBlbnRyeSBpbiBjbG9jay1uYW1l
cy4NCj4gPiAgCQlTZWUgLi4vY2xvY2tzL2Nsb2NrLWJpbmRpbmdzLnR4dCBmb3IgZGV0YWlscy4N
Cj4gPiAtLSBjbG9jay1uYW1lczoJTXVzdCBiZSAicGh5X2NsayINCj4gPiArLSBjbG9jay1uYW1l
czoJTXVzdCBiZSAicGh5X2NsayIuIFRoaXMgaXMgZGVwcmVjYXRlZCBhbmQgc2hvdWxkIG5vdA0K
PiBiZSB1c2VkIHdpdGggbmV3ZXIgYmluZGluZ3MuDQo+ID4gIC0gcmVzZXRzOglNdXN0IGNvbnRh
aW4gYW4gZW50cnkgZm9yIGVhY2ggaW4gcmVzZXQtbmFtZXMuDQo+ID4gIAkJU2VlIC4uL3Jlc2V0
L3Jlc2V0LnR4dCBmb3IgZGV0YWlscy4NCj4gPiAgLSByZXNldC1uYW1lczoJTXVzdCBpbmNsdWRl
ICJzaWVycmFfcmVzZXQiIGFuZCAic2llcnJhX2FwYiIuDQo+ID4NCg==
