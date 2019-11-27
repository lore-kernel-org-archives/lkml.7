Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EDFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267B220674
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 14:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="NHVHd4iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfK0OWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:22:35 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9132 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbfK0OWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 09:22:34 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARDwKaE009991;
        Wed, 27 Nov 2019 09:22:02 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2052.outbound.protection.outlook.com [104.47.40.52])
        by mx0a-00128a01.pphosted.com with ESMTP id 2whcy0t8f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Nov 2019 09:22:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUaoFvXjKATo8Z4SwA/zR3KVwriC57fF/dlmqgxmiq/H7cDIauatSiJ2htk73IHIt6mhHthBvDfeqT4ohtP/+OESDqlKb0hHfysRYOrP85mmuPk87G6DaSr/WDWgMLPydBW85mMpB20Xy4rzmlmUMk41gMgIbFPE9i1f2cH7wguZcLwhnnEeB+7XZebCuAO7uypvHubsET0qWYLukezOjdG/Efc38wv0vJKrJfx0O7a/zTtPru1GEcW96M3GesK6CixTEtKMvP637Y1eNWytli8K5gMd1/WatCKDldwkTiOPsC5/+DeDMdiBu2t8hGxj/Ir8w/WurkCrECg7CxfHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mn7KvkWzVcsmvyDWlDwFLlI901N0UpKdaRWGOGEEyE=;
 b=T3Ep9mHln9ilDqxR7o/j3xI1tEWWgu+kLgus/YPeWouip71t8/4P+32GUGiqFJmJjoUWB0iWxsjhLdhfjgzVRjBHDdWTjSAiYy4S9yfHJJ2X+QEMx/BnPHrIz2owl7tUJXwLgFfERrF8RXcpuEbNrdP6Fd8l/6lebqgh3uzIS4D902T6wvf2O+NtCH2oGDHsR2Ly2HZoByt9Oanhq7Qe0LEnt0EVvzQVnov7/n5s+QPZzTjdG/yJKQgkCtnXpe4rGDWmvMmsY5Axyox0Lh7i8zoPpuIX4nF47erAX7j+1elmQaK5aRVt6E6CzcXZCYvjrDMykrh9ZSVmL0xkFO2EVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Mn7KvkWzVcsmvyDWlDwFLlI901N0UpKdaRWGOGEEyE=;
 b=NHVHd4iVEGAQc+VwFrSw/yT81eIM27XabzaySTt9caKun3eco5BxybVy5Iez6IOAbQtB8OdkVXXKcWjHNWI2PcBv3JO51m1/+gkKlhbrw9JKEnUfb7Qufgavrppac7xY9rYFcD5+wU3NvS2mskFJAFzgNBya3Rq0vrJGl19GB5A=
Received: from DM6PR03MB5209.namprd03.prod.outlook.com (10.186.142.17) by
 DM6PR03MB4490.namprd03.prod.outlook.com (20.178.26.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 27 Nov 2019 14:22:00 +0000
Received: from DM6PR03MB5209.namprd03.prod.outlook.com
 ([fe80::c9ff:48f8:2b9b:1212]) by DM6PR03MB5209.namprd03.prod.outlook.com
 ([fe80::c9ff:48f8:2b9b:1212%4]) with mapi id 15.20.2495.014; Wed, 27 Nov 2019
 14:22:00 +0000
From:   "Togorean, Bogdan" <Bogdan.Togorean@analog.com>
To:     "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>
CC:     "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matt.redfearn@thinci.com" <matt.redfearn@thinci.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Thread-Topic: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Thread-Index: AQHVTr0hmVnX1zVUNEq8UIbUXOMh2qby78kAgA9LnQCAAB3GAIABctKAgAGM+wCAmjvIgIAAS1kA
Date:   Wed, 27 Nov 2019 14:22:00 +0000
Message-ID: <d8470738b044d6559aa8e7b07f8d50ce6791f980.camel@analog.com>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
         <20190809141611.9927-3-bogdan.togorean@analog.com>
         <20190809152510.GA23265@ravnborg.org>
         <c99cfbd3dc45bb02618e7653c33022f3553e1cce.camel@analog.com>
         <20190819104616.GA15890@ravnborg.org>
         <20190820085329.GC11147@phenom.ffwll.local>
         <ccba9a66c6d5db8a295353b16084c6a1199f31dc.camel@analog.com>
         <4c60f287-eb6b-d5b3-8d40-89172755887d@kontron.de>
In-Reply-To: <4c60f287-eb6b-d5b3-8d40-89172755887d@kontron.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7276c4a7-33f7-4eb3-019d-08d773452ae1
x-ms-traffictypediagnostic: DM6PR03MB4490:
x-microsoft-antispam-prvs: <DM6PR03MB44902FEC2742127CB987DE559B440@DM6PR03MB4490.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 023495660C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(39860400002)(376002)(136003)(189003)(199004)(229853002)(76176011)(2351001)(53546011)(118296001)(99286004)(6436002)(2906002)(81166006)(81156014)(3846002)(6512007)(6116002)(6486002)(5640700003)(8936002)(14454004)(76116006)(256004)(66556008)(66946007)(2501003)(478600001)(91956017)(25786009)(66476007)(64756008)(6916009)(316002)(71190400001)(66446008)(305945005)(446003)(71200400001)(86362001)(7736002)(11346002)(2616005)(186003)(6246003)(4326008)(36756003)(66066001)(6506007)(54906003)(102836004)(4001150100001)(5660300002)(26005)(8676002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4490;H:DM6PR03MB5209.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14gNcWrH5jw9H3U3987T9X76arDWQFUxqDDDoMztuuBAg5UuxFpV545jlIGyfm+TeCqkc7MdOOJuHqJNURZXaCKOlrBXrss8Sg98qa481NMeJEH+kzWVEV8gUAuMZrA2mlVWoOTbcmGvYjwoScv1bSvsxjw53MZtUCV1jvzVQ+N+xklyQYpu7b+Qki5lqDx9hUYD/5r+KH4ijQZ38I1tq7Dkp+oeNRhzF49F5pgA+996yqm/ZeOkQPCuo0T7HaHeqaSHraB33BRfwKZ9Y45DBbna7qr5uZ88Vr/pShVtMlqA0A5gKTgUHYCkBD0BGxakpMQR5uNecBWdq9KNdMI2mcPmOjx5zVtCbdLyMKb98VqBbcp6/mA95LCDgtDoZg7f248RwYBncpPXmG0IEeIQBaH450CmLyV6lncOKfeAL07YA1pHPtkKs30HlLo+mUDC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A05E3EF8D80A3246BA0E2B439301EA2D@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7276c4a7-33f7-4eb3-019d-08d773452ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2019 14:22:00.4446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWb+eeMbWPv3carjI9opkV3Eu0YtCkStcv3N0erR+JL5nx2DSl5gOZESx/L1NrR8AjBOprZQ1ib+/34g7h/W2QkWT4G59k/pdqofHvgre+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4490
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-27_03:2019-11-27,2019-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911270124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJpZWRlciwNCg0KSSdtIGdsYWQgdG8gZmluZCB0aGVyZSBhcmUgb3RoZXIgcGVyc29ucyBp
bnRlcmVzdGVkIGluIHRoaXMgZHJpdmVyIGFuZA0KZXNwZWNpYWxseSBzdXBwb3J0IGZvciBBRFY3
NTM1LiBVbmZvcnR1bmF0ZWx5IEkgaGFkIHRvIHB1dCBvbiBob2xkIHRoZQ0KZGV2ZWxvcG1lbnQg
ZHVlIHRvIG90aGVyIGFjdGl2aXRpZXMgYnV0IEknbGwgc2VuZCBWMyB0b21vcnJvdy4NCg0KSSBh
bHNvIHN0YXJ0ZWQgd29yayBvbiBIRENQIHN1cHBvcnQgZm9yIHRoaXMgZHJpdmVyIGFuZCBob3Bl
IHRvIHNlbmQNCnNvb24gYSBwYXRjaCBmb3IgdGhhdC4NCg0KQmVzdCByZWdhcmRzLA0KQm9nZGFu
IA0KDQpPbiBXZWQsIDIwMTktMTEtMjcgYXQgMTE6NTIgKzAwMDAsIFNjaHJlbXBmIEZyaWVkZXIg
d3JvdGU6DQo+IFtFeHRlcm5hbF0NCj4gDQo+IEhpIEJvZ2RhbiwNCj4gDQo+IE9uIDIxLjA4LjE5
IDA3OjM0LCBUb2dvcmVhbiwgQm9nZGFuIHdyb3RlOg0KPiA+IE9uIFR1ZSwgMjAxOS0wOC0yMCBh
dCAxMDo1MyArMDIwMCwgRGFuaWVsIFZldHRlciB3cm90ZToNCj4gPiA+IFtFeHRlcm5hbF0NCj4g
PiA+IA0KPiA+ID4gT24gTW9uLCBBdWcgMTksIDIwMTkgYXQgMTI6NDY6MTZQTSArMDIwMCwgU2Ft
IFJhdm5ib3JnIHdyb3RlOg0KPiA+ID4gPiBIaSBCb2dkYW4uDQo+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiAgIAkJYWR2NzUzM19kZXRhY2hfZHNpKGFkdjc1MTEpOw0KPiA+ID4gPiA+ID4gPiAgIAlp
MmNfdW5yZWdpc3Rlcl9kZXZpY2UoYWR2NzUxMS0+aTJjX2NlYyk7DQo+ID4gPiA+ID4gPiA+ICAg
CWlmIChhZHY3NTExLT5jZWNfY2xrKQ0KPiA+ID4gPiA+ID4gPiBAQCAtMTI2Niw4ICsxMjc4LDkg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkDQo+ID4gPiA+ID4gPiA+IGFkdjc1
MTFfaTJjX2lkc1tdID0gew0KPiA+ID4gPiA+ID4gPiAgIAl7ICJhZHY3NTExIiwgQURWNzUxMSB9
LA0KPiA+ID4gPiA+ID4gPiAgIAl7ICJhZHY3NTExdyIsIEFEVjc1MTEgfSwNCj4gPiA+ID4gPiA+
ID4gICAJeyAiYWR2NzUxMyIsIEFEVjc1MTEgfSwNCj4gPiA+ID4gPiA+ID4gLSNpZmRlZiBDT05G
SUdfRFJNX0kyQ19BRFY3NTMzDQo+ID4gPiA+ID4gPiA+ICsjaWZkZWYgQ09ORklHX0RSTV9JMkNf
QURWNzUzeA0KPiA+ID4gPiA+ID4gPiAgIAl7ICJhZHY3NTMzIiwgQURWNzUzMyB9LA0KPiA+ID4g
PiA+ID4gPiArCXsgImFkdjc1MzUiLCBBRFY3NTM1IH0sDQo+ID4gPiA+ID4gPiA+ICAgI2VuZGlm
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoaXMgaWZkZWYgbWF5IG5vdCBiZSBuZWVkZWQ/
Pw0KPiA+ID4gPiA+ID4gSWYgd2UgZGlkIG5vdCBnZXQgdGhpcyB0eXBlIHdlIHdpbGwgbm90IGxv
b2sgaXQgdXAuDQo+ID4gPiA+ID4gQnV0IGlmIHdlIGhhdmUgZGVmaW5lZCBpbiBEVCBhZHY3NTMz
LzUgZGV2aWNlIGJ1dA0KPiA+ID4gPiA+IENPTkZJR19EUk1fSTJDX0FEVjc1M3ggbm90IHNlbGVj
dGVkIHByb2JlIHdpbGwgZmFpbCB3aXRoDQo+ID4gPiA+ID4gRU5PREVWLg0KPiA+ID4gPiA+IFRo
YXQNCj4gPiA+ID4gPiB3b3VsZCBiZSBvaz8NCj4gPiA+ID4gDQo+ID4gPiA+IFdoYXQgZG8gd2Ug
Z2FpbiBmcm9tIHRoaXMgY29tcGxleGl0eSBpbiB0aGUgZW5kLg0KPiA+ID4gPiBXaHkgbm90IGxl
dCB0aGUgZHJpdmVyIGFsd2F5cyBzdXBwb3J0IGFsbCB2YXJpYW50cy4NCj4gPiA+ID4gDQo+ID4g
PiA+IElmIHRoaXMgcmVzdWx0IGluIGEgc2ltcGxlciBkcml2ZXIsIGFuZCBsZXNzIGNob2ljZXMg
aW4gS2NvbmZpZw0KPiA+ID4gPiB0aGVuIGl0IGlzIGEgd2luLXdpbi4NCj4gPiA+IA0KPiA+ID4g
WWVhaCBpbiBnZW5lcmFsIHdlIGRvbid0IEtjb25maWcgd2l0aGluIGRyaXZlcnMgaW4gZHJtIHRv
IGRpc2FibGUNCj4gPiA+IHNwZWNpZmljDQo+ID4gPiBjb2RlLXBhdGhzLiBJdCdzIG5vdCB3b3J0
aCB0aGUgcGFpbi4NCj4gID4NCj4gPiBBY2ssDQo+ID4gVGhhbmsgeW91IGZvciBjbGFyaWZpY2F0
aW9uLiBXaWxsIHJlbW92ZSBpbiBWMy4NCj4gDQo+IEFyZSB5b3Ugc3RpbGwgd29ya2luZyBvbiB0
aGlzPyBEbyB5b3UgcGxhbiB0byBzZW5kIGEgdjM/DQo+IEkgd2lsbCBzb29uIGxheSBteSBoYW5k
cyBvbiBhIGJvYXJkIHdpdGggdGhlIEFEVjc1MzUgYW5kIHdvdWxkIGxpa2UNCj4gdG8gDQo+IHNl
ZSB0aGlzIG1lcmdlZC4NCj4gQWxzbyBmb3IgcGF0Y2ggMS8yLCBpdCBzZWVtcyB5b3UgYWxyZWFk
eSBoYXZlIGEgUi1iIGZvciB2MSBmcm9tDQo+IExhdXJlbnQsIA0KPiBidXQgeW91IGRpZG4ndCBj
YXJyeSB0aGUgdGFnIHRvIHYyLg0KPiANCj4gVGhhbmtzLA0KPiBGcmllZGVyDQo=
