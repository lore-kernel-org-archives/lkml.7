Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97747CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 599D121D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 07:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZRVSSbrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406251AbfJYHHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 03:07:31 -0400
Received: from mail-eopbgr800084.outbound.protection.outlook.com ([40.107.80.84]:9036
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405094AbfJYHHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 03:07:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHOEnD/mKKtqXl5VtbWzJZwqKASE6w5xqLsLFPWji0ozZGLvVZFjzGnn1dB0tLTCcyA0DZuM9yNN4CQNhJolBCd1bRKrvtiTRRIy7ZD3ArUDNTn9IFwbmSZHMJOBpNh+jiRdfecgL8qSCGkhDh3p9HnR801NkGYOG269iiqST0KNheZYLKJq4KYQu/1gDvULx4RysgAfWo7g3TozrUjnou4XearShkcEOM2qcrDrfrZcvtko3yV8x6jfSD63WU1ELX7sxKjk7n/84l1InG6yaL+dS3LgxDcBJWyodALWtNwpoobAr2Y6i5FHg960VG23jjJBEhKlVBcDMjcYU3FgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBtKHtvMJuicEnmF6SA6UWD0aIFDLI/MpBFkzDohan4=;
 b=m0Ipr6swP3DtvVhfMvESiaFuAoFY5aldfa8L7ZLFsdiHAEHKsa3Ctf+q4SRIIGq2+qsTEJliOvZW8SHeNbOajolFFDLGfJkEMcaepkmUI9Z3HufJxKoAzzoVCI0rVhenZjaFy1oCnj5Kc3EaDWxy2MBYpTVUxW41piOTae9uUXfi024kLjTCFkodEsfRhVKR5OzB07TT7hsPQFai8TL2na0CjhS2A+rfZQ5GgWMsKeN8eKxBnEU/G3WbOFymsHVlpBdR7tGch/2ydI/QsAIoZRQZZpltMxqlfN2GQtDVI6uogObZJz+vHbs3YJ57ma09uM8+35mAQF+hDIgRM4uH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBtKHtvMJuicEnmF6SA6UWD0aIFDLI/MpBFkzDohan4=;
 b=ZRVSSbrYOl4CV1AvchVNSIZWw/v/FKJ8nUBjPWqWWxlttH+NLiCmemQ68RfWnaXtqFZrXybCV3fPXnKbaPwPEVeF5yJIaTFU0yVmj8/auRhFL/gxH6hS0EhrU8HJuRkiWMVN8/TaMWQmcDQnMwM0Izzzvl19EUosQXrc9oRtSgo=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB2747.namprd12.prod.outlook.com (20.176.116.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Fri, 25 Oct 2019 07:06:54 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::64dd:646d:6fa1:15a1%4]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 07:06:54 +0000
From:   vishnu <vravulap@amd.com>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] ASoC: amd: add ACP3x TDM mode support
Thread-Topic: [PATCH 4/7] ASoC: amd: add ACP3x TDM mode support
Thread-Index: AQHVhZzKIQ2mYhOalE23ZXkh46pFtadq+sQA
Date:   Fri, 25 Oct 2019 07:06:54 +0000
Message-ID: <ae25c498-dac1-ec27-cd47-622d94d45e5b@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
In-Reply-To: <1571432760-3008-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0044.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::30) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 10a3a71f-0d45-40e8-fec7-08d75919ea7d
x-ms-traffictypediagnostic: DM6PR12MB2747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB27476B79D30F429CD9CD7957E7650@DM6PR12MB2747.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(189003)(199004)(52116002)(102836004)(53546011)(71200400001)(386003)(6506007)(486006)(26005)(71190400001)(6862004)(36756003)(229853002)(8936002)(6512007)(81156014)(4326008)(6486002)(6246003)(6436002)(256004)(6636002)(478600001)(99286004)(66446008)(66556008)(76176011)(316002)(8676002)(31686004)(2906002)(64756008)(66476007)(31696002)(66946007)(7736002)(3846002)(186003)(54906003)(37006003)(11346002)(305945005)(2616005)(476003)(446003)(5660300002)(6116002)(66066001)(14454004)(81166006)(25786009)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2747;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wQuOXALPdAbjn9JYHHV3sDaSIIAkPKo2qTHjoSmXyM4SEO4vIkZYak5k3I8K7STuckB93f2tCw6uv43hMQHnqidIOkgaewB0xjhsMSC77wk83raKZ3shzijITfXo+BFq7cPrSe0BCAwgdO9L3sW7P/2IftRq6kemd4GyIF2SMgbNwfbEybEbX14bpknzAHEjtO5n+LEiSkBVoKeVsh3v2IDXzpjBrBEm5SMEFX6pT6My5xlKtKt8bAubvRGDWOskxi+Lx/S3NvkA+rQomNSVLC98TXUjnF3t7/vkAFxzjmO8GILfsdafTVy2EFHkYT1vmEAj9P6DptMuMe4A9j5z/iV3iK9+WBY1pQwnJspyl9TYa159cS0H07+jm6tOdkdR8RIGTWM+tmKigNZ+jdyLu5AFd4xUCQ4S5Z/j244eWQhQsEpgVoKt/QS3or/fGVw/
Content-Type: text/plain; charset="utf-8"
Content-ID: <ECFAE3E7CBA0EB4C9B914B06A8843620@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10a3a71f-0d45-40e8-fec7-08d75919ea7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 07:06:54.1323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVE84XyDxccTngrUal4t5oKJIYrIGmPY3uYnchsHfXX1e/ew1Zns31dVnEIdZvAwWYe+UmoRRtduQRrhmWI/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KQW55IHVwZGF0ZXMgb24gdGhpcyBwYXRjaC4NCg0KUmVnYXJkcywNClZpc2hu
dQ0KDQpPbiAxOS8xMC8xOSAyOjM1IEFNLCBSYXZ1bGFwYXRpIFZpc2hudSB2YXJkaGFuIHJhbyB3
cm90ZToNCj4gQUNQM3ggSTJTIChDUFUgREFJKSBjYW4gYWN0IGluIG5vcm1hbCBJMlMgYW5kIFRE
TSBtb2Rlcy4gQWRkZWQgc3VwcG9ydA0KPiBmb3IgVERNIG1vZGUuIERlc2lyZWQgbW9kZSBjYW4g
YmUgc2VsZWN0ZWQgZnJvbSBBU29DIG1hY2hpbmUgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUmF2dWxhcGF0aSBWaXNobnUgdmFyZGhhbiByYW8gPFZpc2hudXZhcmRoYW5yYW8uUmF2dWxh
cGF0aUBhbWQuY29tPg0KPiAtLS0NCj4gICBzb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4LWkycy5j
IHwgNTEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gICBzb3Vu
ZC9zb2MvYW1kL3JhdmVuL2FjcDN4LmggICAgIHwgIDIgKysNCj4gICAyIGZpbGVzIGNoYW5nZWQs
IDQzIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Nv
dW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3gtaTJzLmMgYi9zb3VuZC9zb2MvYW1kL3JhdmVuL2FjcDN4
LWkycy5jDQo+IGluZGV4IGI3ZjYxMGYuLjdlMjJkMjIgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3Nv
Yy9hbWQvcmF2ZW4vYWNwM3gtaTJzLmMNCj4gKysrIGIvc291bmQvc29jL2FtZC9yYXZlbi9hY3Az
eC1pMnMuYw0KPiBAQCAtNDMsNyArNDMsOCBAQCBzdGF0aWMgaW50IGFjcDN4X2kyc19zZXRfdGRt
X3Nsb3Qoc3RydWN0IHNuZF9zb2NfZGFpICpjcHVfZGFpLCB1MzIgdHhfbWFzaywNCj4gICAJCXUz
MiByeF9tYXNrLCBpbnQgc2xvdHMsIGludCBzbG90X3dpZHRoKQ0KPiAgIHsNCj4gICAJdTMyIHZh
bCA9IDA7DQo+IC0JdTE2IHNsb3RfbGVuOw0KPiArCXUzMiBtb2RlID0gMDsNCj4gKwl1MTYgc2xv
dF9sZW4sIGZsZW47DQo+ICAgDQo+ICAgCXN0cnVjdCBpMnNfZGV2X2RhdGEgKmFkYXRhID0gc25k
X3NvY19kYWlfZ2V0X2RydmRhdGEoY3B1X2RhaSk7DQo+ICAgDQo+IEBAIC02NCwxNiArNjUsNDYg
QEAgc3RhdGljIGludCBhY3AzeF9pMnNfc2V0X3RkbV9zbG90KHN0cnVjdCBzbmRfc29jX2RhaSAq
Y3B1X2RhaSwgdTMyIHR4X21hc2ssDQo+ICAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gICAJfQ0KPiAg
IA0KPiAtCXZhbCA9IHJ2X3JlYWRsKGFkYXRhLT5hY3AzeF9iYXNlICsgbW1BQ1BfQlRURE1fSVRF
Uik7DQo+IC0JcnZfd3JpdGVsKCh2YWwgfCAweDIpLCBhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQ
X0JUVERNX0lURVIpOw0KPiAtCXZhbCA9IHJ2X3JlYWRsKGFkYXRhLT5hY3AzeF9iYXNlICsgbW1B
Q1BfQlRURE1fSVJFUik7DQo+IC0JcnZfd3JpdGVsKCh2YWwgfCAweDIpLCBhZGF0YS0+YWNwM3hf
YmFzZSArIG1tQUNQX0JUVERNX0lSRVIpOw0KPiArCS8qIEVuYWJsZSBJMlMgLyBCVCBjaGFubmVs
cyBURE0gYW5kIHJlc3BlY3RpdmUNCj4gKwkgKiBJMlMvQlRgcyBUWC9SWCBGb3JtYXRzIGZyYW1l
IGxlbmd0aHMuDQo+ICsJICovDQo+ICsJZmxlbiA9IChGUk1fTEVOIHwgKHNsb3RzIDw8IDE1KSB8
IChzbG90X2xlbiA8PCAxOCkpOw0KPiAgIA0KPiAtCXZhbCA9IChGUk1fTEVOIHwgKHNsb3RzIDw8
IDE1KSB8IChzbG90X2xlbiA8PCAxOCkpOw0KPiAtCXJ2X3dyaXRlbCh2YWwsIGFkYXRhLT5hY3Az
eF9iYXNlICsgbW1BQ1BfQlRURE1fVFhGUk1UKTsNCj4gLQlydl93cml0ZWwodmFsLCBhZGF0YS0+
YWNwM3hfYmFzZSArIG1tQUNQX0JUVERNX1JYRlJNVCk7DQo+IC0NCj4gLQlhZGF0YS0+dGRtX2Zt
dCA9IHZhbDsNCj4gKwlpZiAoYWRhdGEtPnN1YnN0cmVhbV90eXBlID09IFNORFJWX1BDTV9TVFJF
QU1fUExBWUJBQ0spIHsNCj4gKwkJc3dpdGNoIChhZGF0YS0+aTJzX2luc3RhbmNlKSB7DQo+ICsJ
CWNhc2UgSTJTX0JUX0lOU1RBTkNFOg0KPiArCQkJdmFsID0gcnZfcmVhZGwoYWRhdGEtPmFjcDN4
X2Jhc2UgKyBtbUFDUF9CVFRETV9JVEVSKTsNCj4gKwkJCXJ2X3dyaXRlbCgodmFsIHwgMHgyKSwN
Cj4gKwkJCQlhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQX0JUVERNX0lURVIpOw0KPiArCQkJcnZf
d3JpdGVsKGZsZW4sDQo+ICsJCQkJYWRhdGEtPmFjcDN4X2Jhc2UgKyBtbUFDUF9CVFRETV9UWEZS
TVQpOw0KPiArCQlicmVhazsNCj4gKwkJY2FzZSBJMlNfU1BfSU5TVEFOQ0U6DQo+ICsJCQl2YWwg
PSBydl9yZWFkbChhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQX0kyU1RETV9JVEVSKTsNCj4gKwkJ
CXJ2X3dyaXRlbCgodmFsIHwgMHgyKSwNCj4gKwkJCQlhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQ
X0kyU1RETV9JVEVSKTsNCj4gKwkJCXJ2X3dyaXRlbChmbGVuLA0KPiArCQkJCWFkYXRhLT5hY3Az
eF9iYXNlICsgbW1BQ1BfSTJTVERNX1RYRlJNVCk7DQo+ICsJCX0NCj4gKwl9IGVsc2Ugew0KPiAr
CQlzd2l0Y2ggKGFkYXRhLT5pMnNfaW5zdGFuY2UpIHsNCj4gKwkJY2FzZSBJMlNfQlRfSU5TVEFO
Q0U6DQo+ICsJCQl2YWwgPSBydl9yZWFkbChhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQX0JUVERN
X0lSRVIpOw0KPiArCQkJcnZfd3JpdGVsKCh2YWwgfCAweDIpLA0KPiArCQkJCWFkYXRhLT5hY3Az
eF9iYXNlICsgbW1BQ1BfQlRURE1fSVJFUik7DQo+ICsJCQlydl93cml0ZWwoZmxlbiwNCj4gKwkJ
CQlhZGF0YS0+YWNwM3hfYmFzZSArIG1tQUNQX0JUVERNX1JYRlJNVCk7DQo+ICsJCWJyZWFrOw0K
PiArCQljYXNlIEkyU19TUF9JTlNUQU5DRToNCj4gKwkJZGVmYXVsdDoNCj4gKwkJCXZhbCA9IHJ2
X3JlYWRsKGFkYXRhLT5hY3AzeF9iYXNlICsgbW1BQ1BfSTJTVERNX0lSRVIpOw0KPiArCQkJcnZf
d3JpdGVsKCh2YWwgfCAweDIpLA0KPiArCQkJCWFkYXRhLT5hY3AzeF9iYXNlICsgbW1BQ1BfSTJT
VERNX0lSRVIpOw0KPiArCQkJcnZfd3JpdGVsKGZsZW4sDQo+ICsJCQkJYWRhdGEtPmFjcDN4X2Jh
c2UgKyBtbUFDUF9JMlNURE1fUlhGUk1UKTsNCj4gKwkJfQ0KPiArCX0NCj4gKwlhZGF0YS0+dGRt
X2ZtdCA9IGZsZW47DQo+ICAgCXJldHVybiAwOw0KPiAgIH0NCj4gICANCj4gZGlmZiAtLWdpdCBh
L3NvdW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3guaCBiL3NvdW5kL3NvYy9hbWQvcmF2ZW4vYWNwM3gu
aA0KPiBpbmRleCBiMTk5MGM5Li5kYmE3MDY1IDEwMDY0NA0KPiAtLS0gYS9zb3VuZC9zb2MvYW1k
L3JhdmVuL2FjcDN4LmgNCj4gKysrIGIvc291bmQvc29jL2FtZC9yYXZlbi9hY3AzeC5oDQo+IEBA
IC03Niw2ICs3Niw4IEBAIHN0cnVjdCBpMnNfZGV2X2RhdGEgew0KPiAgIAlib29sIHRkbV9tb2Rl
Ow0KPiAgIAl1bnNpZ25lZCBpbnQgaTJzX2lycTsNCj4gICAJdTMyIHRkbV9mbXQ7DQo+ICsJdTE2
IGkyc19pbnN0YW5jZTsNCj4gKwl1MzIgc3Vic3RyZWFtX3R5cGU7DQo+ICAgCXZvaWQgX19pb21l
bSAqYWNwM3hfYmFzZTsNCj4gICAJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpwbGF5X3N0cmVh
bTsNCj4gICAJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpjYXB0dXJlX3N0cmVhbTsNCj4gDQo=
