Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27953206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="mJkWQ/VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCKSl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:41:58 -0400
Received: from mail-eopbgr150098.outbound.protection.outlook.com ([40.107.15.98]:19615
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfCKSl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FgJvc/58uu6LklSmFvkJW7fWmfDvVUuBsPMrkz2Cio=;
 b=mJkWQ/VY773NW2TlRNwwyIaOCFXERU/P/Vj3EvvYP9eEHclpXARiYTp89z4W8dKXeNBynUaIlvU6Km3vRdN1aS/IiBc2SLlJmtkjt+LvRdjKNP/d4pENlofyCv5w/rcASfmYDsV/UBnUaLn03Udd8cEU9HTASJp8ZZteylfmxr0=
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com (20.178.12.74) by
 VI1PR02MB3680.eurprd02.prod.outlook.com (52.134.26.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 18:41:52 +0000
Received: from VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1]) by VI1PR02MB4542.eurprd02.prod.outlook.com
 ([fe80::38db:37eb:b43e:e4c1%6]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 18:41:52 +0000
From:   Peter Rosin <peda@axentia.se>
To:     Tomasz Duszynski <tduszyns@gmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: envelope-detector: fix use-after-free on device
 remove
Thread-Topic: [PATCH] iio: envelope-detector: fix use-after-free on device
 remove
Thread-Index: AQHU13gU/8/+Ff4rU0SO2i4C1VZBRaYGucEAgAALdwA=
Date:   Mon, 11 Mar 2019 18:41:51 +0000
Message-ID: <fe70de0a-9134-8942-c729-e014807d101b@axentia.se>
References: <20190310193246.31761-1-TheSven73@gmail.com>
 <20190311180042.GA17880@arch>
In-Reply-To: <20190311180042.GA17880@arch>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:7:16::15) To VI1PR02MB4542.eurprd02.prod.outlook.com
 (2603:10a6:803:b1::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20f07547-3bc5-4892-1804-08d6a6513a1e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600127)(711020)(4605104)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3680;
x-ms-traffictypediagnostic: VI1PR02MB3680:
x-microsoft-antispam-prvs: <VI1PR02MB36802A2B841061C0F9037372BC480@VI1PR02MB3680.eurprd02.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39830400003)(396003)(376002)(366004)(199004)(189003)(54906003)(58126008)(74482002)(53546011)(110136005)(3846002)(81166006)(6506007)(66066001)(6116002)(81156014)(65806001)(65956001)(8676002)(76176011)(14444005)(256004)(386003)(102836004)(316002)(99286004)(71190400001)(71200400001)(52116002)(36756003)(2906002)(5660300002)(6486002)(8936002)(68736007)(53936002)(14454004)(25786009)(486006)(508600001)(31696002)(229853002)(4326008)(64126003)(6512007)(6436002)(65826007)(31686004)(186003)(305945005)(6246003)(7736002)(26005)(97736004)(106356001)(105586002)(11346002)(2616005)(446003)(476003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR02MB3680;H:VI1PR02MB4542.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjAyTUIzNjgwOzIzOlc5Vk9wajJpYzFvY3ozbTI2T2hLbDdOdlRJ?=
 =?utf-8?B?OXdIUExuR08xZWdleFAzS1JseUV3akg3cGRVdXVvOStsamxZVGovYkJoZTVW?=
 =?utf-8?B?ZjdCUzR6TENnVXRoRE8vVFJVOFBxOVIwdmkxb2hMdnhnUkQ1MlhJdWgyS3Iw?=
 =?utf-8?B?d2toeDdveXhpSjZNUDRXaDkyTUc5aWp5WHBmQlpWTTNYb3pnamdjRWU4eDQ3?=
 =?utf-8?B?eTdkT1EzUklod0Y1MC9qeU5kUUR5em5kdHBnYURSN21JaVpzUzdqbEZEQ2VQ?=
 =?utf-8?B?VlNWbVZwbVQ3T3BHUGVKYXJIRWtCQyt5OFR6Uk11YjZrdFVybVdHSTF0ejlm?=
 =?utf-8?B?TVVRRVlZR1krS094QWRPWWFidGZSa3B3UlFHdk9aOTQxQmhPMCtwMnJsdGg0?=
 =?utf-8?B?a1RhT1F4YThiZFFuSHNVTm1reVk3d0p1MTQrVUZFZlkyT3ZFVVU2RU9jeDVj?=
 =?utf-8?B?ZVVWWTZPa2hmOW1xNGJYM2pOM0hiRDdxbk1zNWVuMUZxQTVuQWFvRUNIT3Fn?=
 =?utf-8?B?eStrMWlSMXQvbGRQcEkrdk8rM1ZCZ2FoN2Fhcnk5SHJ3YittaFczQURWQ1VH?=
 =?utf-8?B?MUVEcjIyTzB5dkU4V3F2WWg4Vmx1VTJrcWVvOVBJT0RFYUFBMCs2QUk1SUJG?=
 =?utf-8?B?SjFMZFQ3YmpRZkh3UVp2eDNKYnAvbHJjeXFDY2hQeGpOakVOMFVaY2JLcE5i?=
 =?utf-8?B?Mlp4OGlZdVNwMVRmRzlGemRFZ0l0dkx6c2ZGeWpHb2RRVjVJUmp2TjJmbnRI?=
 =?utf-8?B?a0E2aUFSLzd5NDkzc0h2RGFrSnNNN1o0a3ZQcjJtemJ4U3V6WmZyNGM2cEpn?=
 =?utf-8?B?allXbzRNWmdWRlp6NlJqTS9IckcwZ09GZDJ2MGE4aHVKVk50RWtDTlRUSFA1?=
 =?utf-8?B?dytxVlpsZGd0Nm85MnZHN3NhYlNSM3BwUUdDVktCdW1NbVBkUnpBNHI2a2pQ?=
 =?utf-8?B?elZaVTlRMndxZnh2eWxPdW8wdHdzaGF4NGVIOG1aaENrNE1wajFiVzhGRXU5?=
 =?utf-8?B?MjErUWk0aE8veW9YTmdNdkFnK0dVTmZNTy94NHBRWWxrZXh5NWpWTTlxdTdT?=
 =?utf-8?B?ODc1aXE5dFdZcmxEYWR0UjlNVUR1ZGZjS0M3RFVxNk9pR1NYVG5TZkY0VGgz?=
 =?utf-8?B?YVVuQUd0dnRjWnVvdDZtVGQvdFMyUEpGaVVtUm8vbndMQmUwMmM4T2xIbWJs?=
 =?utf-8?B?dGNCR2NHbUtJckE0Y0ZST3RjMjFub1YvdGdiUXdDTWk1VHNGcU05S2RyWTRK?=
 =?utf-8?B?WDVSREJHS1hBS3l6OXlGbjdPSHBzMkdyanRNS2tzWDdKTUdQWTB5QnNISVpT?=
 =?utf-8?B?alJIb0NIZjN1Nk5hUGVaUHh2S3ByeUcrSWx4a0orSHR5a2MxRi9UN2dqbVdI?=
 =?utf-8?B?eUpDV3V1b1crNFdXRm8xOHJEeEZSd0pSalcxRGNvdStybGx3RjhCZjg4US83?=
 =?utf-8?B?Zm9sTlcwVElxanNwOTdpd0xsRjk2Y3U2M21hajNtayt5WXJkczZ1ZWlnRkFo?=
 =?utf-8?B?YlYvVUR0SlRBcXR1aWVKQVFZWEg3QmFGQndGcDl3N3h0Q0kvcExyakM0azJG?=
 =?utf-8?B?MjhMZStlczhwUnRKanoza05CeWczWG9LRXYxUXY5bFZFVjVWSitKNE5hZXJQ?=
 =?utf-8?B?MzEySGVlWlJlaVBhSFlNRnJ0ckhjU1NGWkdsSTJmSm5ZRGxBajcxRWtWdEM0?=
 =?utf-8?B?MEtVVHpRdFljTDI5L1NidEM3cWdJd3E4ZjF0OHQ4d2FrVDczUU8vYm80THVq?=
 =?utf-8?B?T1dBWjJOTVhUaHlySnNXcTFZYUZHUWFPcTJzT0JtQXVia0psWitncVlybDg3?=
 =?utf-8?B?eThHRjBjY1cvZkM1ODlUWFNIcHJvSGZxZnV0aDRYemlrRzJ6TWgycTlEWTFk?=
 =?utf-8?B?R2lSdXFsNm13K0FOZmpYaXdMYkFSM01zWURzZFNpUWFmT3pMOE8wU3JXMDV3?=
 =?utf-8?B?SEErM3JvSWV3PT0=?=
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: gEZ3umesGKvfkJuAedQuHF3RWZBSkCHeKnFziA2jNYFnWLuqncT8e/Cxv/mkuPnwxUrJXAzcGV788jT4spzrU1E5g2hBGMKpWBO9UHKVn7BLNJDeEp1Sd+9lJYKutdhjcVVUKJnzejl0cc4s/6zEkZP6WawY4+tlia6uLuB4xGLsLEQMDorXph/LdIVFojnTb0yCuqchz2fGWots9rAt+ijlXI2a6ujL7AKHh2z3mzkvV6DLsVveAMJwDe8UPGaPfYBLHXsX2AgHA/A12nG6RqWeM+/nfnha68/3La9bFdNWAAVVOuaf0dTNLVLDzjvX9H+HeWSUXSy5qao8sV01roA0/5NNYB1eQ5ZB8+Qc0+t1BQI1lPNUi0fhZ3tQlgg9vQ8MfcSJeR6ShTwP/hAMwiIFNF7O6WA5sQOXafSPCAc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14438555E1BA634084DE71AC29A66B91@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f07547-3bc5-4892-1804-08d6a6513a1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 18:41:52.0408
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0wMy0xMSAxOTowMCwgVG9tYXN6IER1c3p5bnNraSB3cm90ZToNCj4gT24gU3VuLCBN
YXIgMTAsIDIwMTkgYXQgMDM6MzI6NDZQTSAtMDQwMCwgU3ZlbiBWYW4gQXNicm9lY2sgd3JvdGU6
DQo+PiBUaGlzIGRyaXZlcidzIHJlbW92ZSBwYXRoIG5ldmVyIGV4cGxpY2l0bHkgY2FuY2VscyB0
aGUNCj4+IGRlbGF5ZWQgd29yay4gU28gaXQgaXMgcG9zc2libGUgZm9yIHRoZSBkZWxheWVkIHdv
cmsgdG8NCj4+IHJ1biBhZnRlciB0aGUgY29yZSBoYXMgZnJlZWQgdGhlIHByaXZhdGUgc3RydWN0
dXJlDQo+PiAoc3RydWN0IGVudmVsb3BlKS4gVGhpcyBpcyBhIHBvdGVudGlhbCB1c2UtYWZ0ZXIt
ZnJlZS4NCj4+DQo+PiBGaXggYnkgYWRkaW5nIGEgZGV2bV9hZGRfYWN0aW9uIGNhbGxiYWNrIHRv
IHRoZSByZW1vdmUNCj4+IHBhdGgsIGNhbGxlZCByaWdodCBhZnRlciBpaW9fZGV2aWNlX3VucmVn
aXN0ZXIoKSwgd2hpY2gNCj4+IGV4cGxpY2l0bHkgY2FuY2VscyB0aGUgZGVsYXllZCB3b3JrLg0K
Pj4NCj4+IFRoaXMgaXNzdWUgd2FzIGRldGVjdGVkIHdpdGggdGhlIGhlbHAgb2YgQ29jY2luZWxs
ZS4NCg0KSGkgU3ZlbiwNCg0KKEkgZGlkbid0IGdldCB0aGUgb3JpZ2luYWwgbXNnIGZvciBzb21l
IHJlYXNvbiwgc28gSSdtIHJlc3BvbmRpbmcNCnRvIHRoaXMgcmVwbHkgaW5zdGVhZCkNCg0KVGhp
cyBpcyBmYWxzZSBwb3NpdGl2ZSwgQUZBSUNULiBUaGUgZGVsYXllZCB3b3JrIG11c3QgaGF2ZQ0K
ZmluaXNoZWQgd2hpbGUgZW52ZWxvcGVfZGV0ZWN0b3JfcmVhZF9yYXcoKSBob2xkcyB0aGUgcmVh
ZF9sb2NrDQptdXRleCwgYW5kIGl0IHdvdWxkIGJlIGhpZ2hseSBzdXJwcmlzaW5nIGlmIHRoZSBk
ZXZpY2UgY2FuIGdvDQphd2F5IHdoaWxlIGl0IGlzIGhhbmRsaW5nIGFuIElJTyAtPnJlYWRfcmF3
IGNhbGwuIChUSEFUIHdvdWxkIGJlDQphbiBpbnRlcmVzdGluZyBidWcuLi4pDQoNClRoYXQgc2Fp
ZCwgSSBtaWdodCBiZSBtaXN0YWtlbiwgYnV0IHlvdSBuZWVkIHRvIGV4cGxhaW4gYSBzZXF1ZW5j
ZQ0Kb2YgZXZlbnRzIHRoYXQgbGVhZHMgdG8gdGhlIGNsYWltZWQgZGFuZ2xpbmcgZGVsYXllZCB3
b3JrLiBJLmUuLA0KaG93IGRvIHlvdSBwcm9wb3NlIHRoYXQgZW52LT5kb25lIGNvbXBsZXRlcyB3
aGlsZSB0aGVyZSBpcyB3b3JrDQpzY2hlZHVsZWQ/IFNob3J0IG9mIHRoYXQsIGFuZCBzaW5jZSB0
aGlzIGlzIGFsbCB0aGVvcnkgd2l0aG91dA0KZW1waXJpY2FsIGV2aWRlbmNlLCB0aGlzIHBhdGNo
IGdldHMgYSBOQUNLIGZyb20gbWUuDQoNCkNoZWVycywNClBldGVyDQoNCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBTdmVuIFZhbiBBc2Jyb2VjayA8VGhlU3ZlbjczQGdtYWlsLmNvbT4NCj4+IC0tLQ0K
Pj4gIGRyaXZlcnMvaWlvL2FkYy9lbnZlbG9wZS1kZXRlY3Rvci5jIHwgMTIgKysrKysrKysrKysr
DQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vYWRjL2VudmVsb3BlLWRldGVjdG9yLmMgYi9kcml2ZXJzL2lpby9hZGMv
ZW52ZWxvcGUtZGV0ZWN0b3IuYw0KPj4gaW5kZXggMmYyYjU2M2MxMTYyLi4yZjFjNzhiM2ZmNDQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvZW52ZWxvcGUtZGV0ZWN0b3IuYw0KPj4g
KysrIGIvZHJpdmVycy9paW8vYWRjL2VudmVsb3BlLWRldGVjdG9yLmMNCj4+IEBAIC0zMjEsNiAr
MzIxLDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaWlvX2luZm8gZW52ZWxvcGVfZGV0ZWN0b3Jf
aW5mbyA9IHsNCj4+ICAJLnJlYWRfcmF3ID0gJmVudmVsb3BlX2RldGVjdG9yX3JlYWRfcmF3LA0K
Pj4gIH07DQo+Pg0KPj4gK3N0YXRpYyB2b2lkIGVudmVsb3BlX2RldGVjdG9yX3N0b3Bfd29yayh2
b2lkICpkYXRhKQ0KPj4gK3sNCj4+ICsJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiA9IGRhdGE7
DQo+PiArCXN0cnVjdCBlbnZlbG9wZSAqZW52ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4+ICsN
Cj4+ICsJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZlbnYtPmNvbXBfdGltZW91dCk7DQo+PiAr
fQ0KPj4gKw0KPj4gIHN0YXRpYyBpbnQgZW52ZWxvcGVfZGV0ZWN0b3JfcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikNCj4+ICB7DQo+PiAgCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZw
ZGV2LT5kZXY7DQo+PiBAQCAtMzk1LDYgKzQwMywxMCBAQCBzdGF0aWMgaW50IGVudmVsb3BlX2Rl
dGVjdG9yX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgCQlyZXR1cm4g
cmV0Ow0KPj4gIAl9DQo+Pg0KPj4gKwlyZXQgPSBkZXZtX2FkZF9hY3Rpb24oZGV2LCBlbnZlbG9w
ZV9kZXRlY3Rvcl9zdG9wX3dvcmssIGluZGlvX2Rldik7DQo+PiArCWlmIChyZXQpDQo+PiArCQly
ZXR1cm4gcmV0Ow0KPiANCj4gSnVzdCBhIHJhbmRvbSB0aG91Z2h0LiBXb3VsZG4ndCBkZXZtX2Fk
ZF9hY3Rpb25fb3JfcmVzZXQoKSBiZSBhIGJldHRlciBmaXQ/DQo+IEluIGNhc2UgYWRkaW5nIGFj
dGlvbiByZXN1bHRzIGluIGZhaWx1cmUgd2Ugd2lsbCBub3QgZ2V0IHRoZSBjaGFuY2UgdG8gY2Fu
Y2VsDQo+IHdvcmsuDQo+IA0KPj4gKw0KPj4gIAlyZXR1cm4gZGV2bV9paW9fZGV2aWNlX3JlZ2lz
dGVyKGRldiwgaW5kaW9fZGV2KTsNCj4+ICB9DQo+Pg0KPj4gLS0NCj4+IDIuMTcuMQ0KPj4NCg0K
