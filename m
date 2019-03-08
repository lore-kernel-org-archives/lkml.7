Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C359CC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC6F20643
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="oT8dK14y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCHXNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 18:13:08 -0500
Received: from mail-eopbgr770045.outbound.protection.outlook.com ([40.107.77.45]:25230
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726505AbfCHXNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 18:13:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW+KfcyyIaKIUQE5wNHY2N3PuQ2mBHTiiHT0QY49W5s=;
 b=oT8dK14yYkJspHt1d46YjxcT30GlydKysKjiQGK4PA6XxzoTg7LNq3cST+7+zw1+88RrSogVGpQvQWadjMvTRC6Q4n2osbuTJBLmOkXnXIXY8cQWX0WHG1u8K5Snok16hIxGK6zef+8XZIkO5EDIqW52TvWdEK+4SgMkyFnPMxY=
Received: from DM6PR03MB4713.namprd03.prod.outlook.com (20.179.104.87) by
 DM6PR03MB3882.namprd03.prod.outlook.com (20.176.116.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Fri, 8 Mar 2019 23:13:00 +0000
Received: from DM6PR03MB4713.namprd03.prod.outlook.com
 ([fe80::e4da:6b6d:8fa0:15db]) by DM6PR03MB4713.namprd03.prod.outlook.com
 ([fe80::e4da:6b6d:8fa0:15db%3]) with mapi id 15.20.1686.020; Fri, 8 Mar 2019
 23:13:00 +0000
From:   Christopher Heiny <Cheiny@synaptics.com>
To:     Aaron Ma <aaron.ma@canonical.com>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Thread-Topic: [PATCH 1/2] Input: synaptics-rmi4 - clear irqs before set irqs
Thread-Index: AQHUyTs5Qp0btHE2q0GPqsqH5pp/nqYCdpEA
Date:   Fri, 8 Mar 2019 23:13:00 +0000
Message-ID: <17cd420ea32a9787c56ba25e36e7661541c2f65f.camel@synaptics.com>
References: <20190220164200.31044-1-aaron.ma@canonical.com>
In-Reply-To: <20190220164200.31044-1-aaron.ma@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.147.44.15]
x-clientproxiedby: BYAPR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:a03:100::38) To DM6PR03MB4713.namprd03.prod.outlook.com
 (2603:10b6:5:181::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Cheiny@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14ed5c4b-4557-475e-d2fc-08d6a41b9bbe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR03MB3882;
x-ms-traffictypediagnostic: DM6PR03MB3882:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtETTZQUjAzTUIzODgyOzIzOjlnYVZZdmc5QzZUdFBTZUJQQ2dwZWFOTVdp?=
 =?utf-8?B?Yk5CTjZIYitSamMzSFJBaE5ieWVGaUpFQzFNVXpzNUU2ejVJai9DeGtxeGJJ?=
 =?utf-8?B?UXdSZW1OdXRZZ3FMWDBJNFZ1YXQ0dGE5SjlPUWZDeDNVTW9LcHVSMlZRQzlP?=
 =?utf-8?B?c1N5WURyTkpsQ2tiTDVHaDVTM3J2UUxSVjBPemFzZ280MENaMWdqSzdwNTJD?=
 =?utf-8?B?YTBiQUwzZlppeUVWY0tWM2czdHV6cDNOUmtRdU4xZUZoUFFHenhnY0E5MHZ5?=
 =?utf-8?B?RjZ4c0Z0eHl6dGVFQjU0WVNPZGRxRm5HNDBIdzhteXdvYTNKcUJML3VNSUYx?=
 =?utf-8?B?QzU3T1NUR01tYVp1eHYvMVJSK0R5ZVhOdW1tYnpTMk9oeDZJWjFLL0Jvamo3?=
 =?utf-8?B?L2tad2lRbHhEYWd0YUhRSGpZRWhhSEszaHJNZksrK3BIMGszTXhlaTByQS9q?=
 =?utf-8?B?eWpXYmV0RXZLL2o1bmxSdEVueER2VzlGNXpzOFhZdDVlcnpKN0lJUnBia2RZ?=
 =?utf-8?B?K3pxeDJTRGtsUG42RzNRTEVpUHl0K3NhdmgxZkRab3F6TUpkTjg2cCt0TDkx?=
 =?utf-8?B?YU5COWRKODB2S2h0RE9aZ014M0FQMmwxY3pkeWQ0UWtDL3RvNHJuUlpnSmpV?=
 =?utf-8?B?MEIwMzFVSGRMUG5PUkZhTXgrTHhucFNxWkJBUzZkYUlscUlxK1k2dmMvRDRS?=
 =?utf-8?B?Zmg1UTRVTTYwWjlNM2phUExQcjhQSEI1dVN5czc2WTBabllPajJxQklScDNm?=
 =?utf-8?B?YVJGWnVKSVFycVV0Q1NVRDh3bklValZnODNuZVV4VzVocnFvbFBRblJMYjd5?=
 =?utf-8?B?Q0l0ODFYek1kQXFYWWh5YnFmT2EyYXQ0Y3FUcytZU0ZMdDBvTFBkcWVpR05z?=
 =?utf-8?B?SkIrMTg4U0JRWnN2UWg0OThHbjRnWVM1cWMzcHB1MjhOeEZXWWJwNHFCanYw?=
 =?utf-8?B?SlAwSEIvVlhGcG5UV2pabkUzSlU1cm5iN0tTd0V2MGpySTZqQTdsV0tyeU43?=
 =?utf-8?B?Qk8wZUhiZWxIMy9SUU5aS0FGaVlFcVlMRkgrYTRzdFdyaGdNOEJaaGRXcnZU?=
 =?utf-8?B?MkNXaXFkSnU1Z0pDUG5qTFJsZjYwRWxIZllLbDY5dThHSEFrUFRHR2doTTYr?=
 =?utf-8?B?WDJVeXkrVHgrN3hnRWo5RGd6bUgvOWhUMDBuUkZ6eHVZdUoyMlc5QmtjbzBR?=
 =?utf-8?B?aXJrbnVtTzh2MmhubUdoeGRDd1BQREVsbTFLVGFubU14d21Sa05UN1RGL3lk?=
 =?utf-8?B?eU9WalE5SmdDWWZXTEU0ZGQ4RThjWkhRVU5OZm5sclJMWFZqQ1dsTDc2VWRq?=
 =?utf-8?B?bGFQcGxvTXltdkxxYkJlSGsxMGRZdmdDdE1YbzJwUDViZ21Vd1FCT1R4dEo4?=
 =?utf-8?B?dFMxbW1nRm4zUTBTajFCNDFHK1dCSDVkQVZMNGozY0loY1UzcnU5RUVTc2p2?=
 =?utf-8?B?SFBZUEFpSEhjZE1XM3FzYVcvTFBVZDBCQ1V3ekxjUTJKQmlPeVB2U0l4SG83?=
 =?utf-8?B?am13b2xSeDhISHRGRnBCRm9PRk9oSnNXQVZiS1JHbVh1bWFiSk45c01WdDJ4?=
 =?utf-8?B?M2pSK1lLazE4WVRYSFVLYXc0dTlERFpYRGRMV0o2UjN1alByTyt3b0NFTkxs?=
 =?utf-8?B?UFYvZ2VJeG1scDk4OTFNam9DOWY5cStWVDM0d29teWpjdGRlV203T0ZQYTdO?=
 =?utf-8?B?MmNoMk5nMUNUcFNDTjdPYXg1NEpOZWZFS2x0UjduVlU2b2ZIOHZWcEtwUFRB?=
 =?utf-8?B?eG15MjlhakxMQkRpK0k4MVp4TUtZdjdzcll1aUhiLy9hbGdLYjdsWU96VzIy?=
 =?utf-8?B?MXV0ZENVVnhkOTVkL24vRytiZElCdTNqMXBmMm50OVRHY2pZVk1QL1UvQkc0?=
 =?utf-8?Q?1au5UYAwDOw=3D?=
x-microsoft-antispam-prvs: <DM6PR03MB3882E15F1158C66F80DF8A00DD4D0@DM6PR03MB3882.namprd03.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(5660300002)(25786009)(2201001)(105586002)(86362001)(52116002)(106356001)(6306002)(256004)(53936002)(76176011)(14444005)(6512007)(5024004)(14454004)(50226002)(478600001)(36756003)(305945005)(6486002)(99286004)(8936002)(66066001)(6246003)(80792005)(7736002)(97736004)(6436002)(118296001)(72206003)(229853002)(110136005)(6116002)(3846002)(71200400001)(11346002)(2616005)(476003)(446003)(966005)(81156014)(81166006)(71190400001)(26005)(316002)(8676002)(2906002)(2501003)(486006)(186003)(102836004)(6506007)(386003)(68736007)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3882;H:DM6PR03MB4713.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0s7E5UB2SFtyOcg6g5lYxpLVn+8CpsiwC+nlLB3TqKWwdLmX2MvRSBBSvpQYuTiSeAI1tnD4xzdy8DtKeHiBRJcO5valgbgRmgc7riiIBj0wDS8JYdEjsx0eaxkPR1rL6E3wr3NOoKXs0v3WoPX9+somIrHW/qb6hgogJJbAeqgMcS5T24WuCsO/NAnC4ohRS5zF78/qEeqGRhZgfZ7k69Lr4TC7Vf3BITT6aMhyCRfj5ZlrsiMfcOR7kbkUsh6MSHjdUsk6/OJzJ3k4p/AXykRNKvg0XQ498rVq4sfIWOBr90t3LCDsPBpKlyU3e9okAEvn7CRQt9n0hvhBKzocGJLrRUUmn1mNNBfWtOi1LMIkowKGzxXL6WmiEr/7RwmsS2OlPcJs0o4TBSQc2fPa4++GRt/oB11dacleJEehZm4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D82E47E23F0DAB4098F488DC49326F8A@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ed5c4b-4557-475e-d2fc-08d6a41b9bbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 23:13:00.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTAyLTIwIGF0IDE3OjQxICswMTAwLCBBYXJvbiBNYSB3cm90ZToNCj4gQ0FV
VElPTjogRW1haWwgb3JpZ2luYXRlZCBleHRlcm5hbGx5LCBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3Blbg0KPiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIGFuZCBr
bm93IHRoZSBjb250ZW50IGlzDQo+IHNhZmUuDQo+IA0KPiANCj4gcm1pNCBnb3Qgc3BhbSBkYXRh
IGFmdGVyIFMzIHJlc3VtZSBvbiBzb21lIFRoaW5rUGFkcy4NCj4gVGhlbiBUcmFja1BvaW50IGxv
c3Qgd2hlbiBiZSBkZXRlY3RlZCBieSBwc21vdXNlLg0KPiBDbGVhciBpcnFzIHN0YXR1cyBiZWZv
cmUgc2V0IGlycXMgd2lsbCBtYWtlIFRyYWNrUG9pbnQgYmFjay4NCj4gDQo+IEJ1Z0xpbms6IA0K
PiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2J1
Z3MubGF1bmNocGFkLm5ldF9idWdzXzE3OTE0MjcmZD1Ed0lCQWcmYz03ZGZCSjhjWGJXamhjMEJo
SW11OHdRJnI9dmVPeHYxXzdITFhJYVdHLU9LTHFwLXF2WmMzcjd1Y1QxZC02OEpTV3FwTSZtPTNu
Tm00b2I2RzF3dGY1MDJZRnV4b3JKVmtTUXZkQmFzamUyUnJaTHhoVE0mcz1aMG5IU1BBS2hRTHpk
b0VOQVpCWXVEQzZRbVpOT2xpeWlFN2gxT09Wa0JBJmU9DQo+IENjOiA8c3RhYmxlQHZnZXIua2Vy
bmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogQWFyb24gTWEgPGFhcm9uLm1hQGNhbm9uaWNhbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pbnB1dC9ybWk0L3JtaV9kcml2ZXIuYyB8IDExICsrKysr
KysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvaW5wdXQvcm1pNC9ybWlfZHJpdmVyLmMNCj4gYi9kcml2ZXJzL2lucHV0
L3JtaTQvcm1pX2RyaXZlci5jDQo+IGluZGV4IGZjM2FiOTNiN2FlYS4uMjA2MzFiMjcyZjQzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lucHV0L3JtaTQvcm1pX2RyaXZlci5jDQo+ICsrKyBiL2Ry
aXZlcnMvaW5wdXQvcm1pNC9ybWlfZHJpdmVyLmMNCj4gQEAgLTM3NCw2ICszNzQsMTcgQEAgc3Rh
dGljIGludCBybWlfZHJpdmVyX3NldF9pcnFfYml0cyhzdHJ1Y3QNCj4gcm1pX2RldmljZSAqcm1p
X2RldiwNCj4gICAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcm1pX2Rldi0+ZGV2Ow0KPiAN
Cj4gICAgICAgICBtdXRleF9sb2NrKCZkYXRhLT5pcnFfbXV0ZXgpOw0KPiArDQo+ICsgICAgICAg
LyogRHVtbXkgcmVhZCBpbiBvcmRlciB0byBjbGVhciBpcnFzICovDQo+ICsgICAgICAgZXJyb3Ig
PSBybWlfcmVhZF9ibG9jayhybWlfZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICBkYXRh
LT5mMDFfY29udGFpbmVyLT5mZC5kYXRhX2Jhc2VfYWRkciArIDEsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIGRhdGEtPmlycV9zdGF0dXMsIGRhdGEtPm51bV9vZl9pcnFfcmVncyk7DQo+ICsg
ICAgICAgaWYgKGVycm9yIDwgMCkgew0KPiArICAgICAgICAgICAgICAgZGV2X2VycihkZXYsICIl
czogRmFpbGVkIHRvIHJlYWQgaW50ZXJydXB0IHN0YXR1cyEiLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fZnVuY19fKTsNCj4gKyAg
ICAgICAgICAgICAgIGdvdG8gZXJyb3JfdW5sb2NrOw0KPiArICAgICAgIH0NCj4gKw0KPiAgICAg
ICAgIGJpdG1hcF9vcihkYXRhLT5uZXdfaXJxX21hc2ssDQo+ICAgICAgICAgICAgICAgICAgIGRh
dGEtPmN1cnJlbnRfaXJxX21hc2ssIG1hc2ssIGRhdGEtPmlycV9jb3VudCk7DQo+IA0KPiAtLQ0K
PiAyLjE3LjENCj4gDQoNClNvcnJ5IGZvciB0aGUgbG9uZyBkZWxheSBpbiBmb2xsb3dpbmcgdXAg
b24gdGhpcy4NCg0KSSdtIG5vdCBzdXJlIHRoaXMgaXMgYSBzYWZlIGFjdGlvbiwgZHVlIHRvIGEg
cmFjZSBjb25kaXRpb24gd2l0aCB0aGUNCmFjdHVhbCBJUlEgaGFuZGxlciAocm1pX3Byb2Nlc3Nf
aW50ZXJydXB0X3JlcXVlc3RzIGZyb20gcm1pX2RyaXZlci5jKS4gDQpSZW1lbWJlciB0aGF0IHJl
YWRpbmcgdGhlIElSUSBzdGF0dXMgcmVnaXN0ZXIgY2xlYXJzIGFsbCB0aGUgSVJRIGJpdHMuIA0K
U28geW91J3JlIGZhY2VkIHdpdGggdGhpcyBwb3NzaWJsZSBzY2VuYXJpbzoNCiAgICAtIEFUVE4g
YXNzZXJ0ZWQsIGluZGljYXRpbmcgbmV3IGRhdGEgaW4gSVJRIHN0YXR1cyByZWdpc3Rlcg0KICAg
IC0gcm1pX2RyaXZlcl9zZXRfaXJxX2JpdHMgY2FsbGVkDQogICAgLSBybWlfZHJpdmVyX3NldF9p
cnFfYml0cyByZWFkcyBJUlEgc3RhdHVzLCBjbGVhcmluZyBiaXRzDQogICAgLSBybWlfcHJvY2Vz
c19pbnRlcnJ1cHRfcmVxdWVzdHMgY2FsbGVkDQogICAgLSBybWlfcHJvY2Vzc19pbnRlcnJ1cHRf
cmVxdWVzdCByZWFkcyBJUlEgc3RhdHVzLCBzZWVzIG5vDQogICAgICBiaXRzIHNldCwgbmVzdGVk
IElSUXMgYXJlIG5vdCBoYW5kbGVkDQpUaGlzIGNvdWxkIGxlYWQgdG8gbG9zcyBvZiBkYXRhIG9y
IGluY29uc2lzdGVudCBzeXN0ZW0gc3RhdGUNCmluZm9ybWF0aW9uLiAgRm9yIGV4YW1wbGUsIGEg
YnV0dG9uIHVwIG9yIGRvd24gZXZlbnQgbWF5IGJlIGxvc3QsIHdpdGgNCmNvbnNlcXVlbnQgd2Vp
cmQgYmVoYXZpb3IgYnkgdGhlIHVzZXIgaW50ZXJmYWNlLg0KDQpDQVZFQVQ6IEkgaGF2ZW4ndCBo
YWQgbXVjaCB0byBkbyB3aXRoIHRoZSBSTUk0IGRyaXZlciBmb3IgYSBsb25nIHdoaWxlLA0KYW5k
IGFtIGp1c3Qgc3RhcnRpbmcgdG8gcG9rZSBhcm91bmQgd2l0aCBpdCBhZ2Fpbi4gIEkgYW0gbm90
IHZlcnkNCmZhbWlsaWFyIHdpdGggdGhlIGN1cnJlbnQgSVJRIGhhbmRsaW5nIGltcGxlbWVudGF0
aW9uLiAgUGVyaGFwcyB0aGVyZQ0KaXMgYSBndWFyYW50ZWUgaW4gdGhlIGtlcm5lbCBJUlEgbWVj
aGFuaXNtIHRoYXQgb25jZSBBVFROIGlzIGFzc2VydGVkLA0KdGhlbiBybWlfcHJvY2Vzc19pbnRl
cnJ1cHRfcmVxdWVzdHMgd2lsbCBiZSBjYWxsZWQgYmVmb3JlIGFueW9uZSBlbHNlDQpnZXRzIGEg
Y2hhbmNlIHRvIHJlYWQgdGhlIElSUSBzdGF0dXMgcmVnaXN0ZXIuICBJZiB0aGF0J3MgdGhlIGNh
c2UsIGxldA0KbWUga25vdyBJJ20gd29ycmllZCBhYm91dCBub3RoaW5nLCBhbmQgaWdub3JlIHRo
aXMgY29tbWVudC4NCg0KQ2hlZXJzLA0KQ2hyaXMNCg0K
