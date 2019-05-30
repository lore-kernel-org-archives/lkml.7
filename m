Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F9EC46460
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675F42603A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="m1KxTw3k";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="nBAkLFES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfE3Szx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:55:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47514 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3Szv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:55:51 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UImgSG003351;
        Thu, 30 May 2019 11:55:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=oG70EMUxor0nCbXima+mNHyc8gbs729ZIs1Pfrsm60c=;
 b=m1KxTw3klWVWD6JTLohJwBnXcuIPo8x9EQzOiuDVlijGhMTravvTlqE8P+b96KdLmG6S
 DtSDkdpjcwxT1QZBbaOXw7X15KMDbvla+If6iBft7Am3bzx4GTux/4znM3WkF+In8f/5
 7KrvRoRU9jYYRgI3V8ZdqA2utzmhGDGK9ek= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2stj1c8p77-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 May 2019 11:55:19 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 30 May 2019 11:55:19 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 11:55:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oG70EMUxor0nCbXima+mNHyc8gbs729ZIs1Pfrsm60c=;
 b=nBAkLFES2cYUs0qJwnkBDQRzfsiPucjPzj90c2eg9H//Ud980fthJXpRwGmv6zvO6qm3d1Gmai50JDecEfbsJ9585Z9QUzK1t2ZuJLCs661t1VkUkTFIBrVvhdEnqskOE2ZipxIcfq4h4UPDxTjCR2Wvc9FW4VYNHHXY049yCYg=
Received: from CY4PR15MB1269.namprd15.prod.outlook.com (10.172.177.11) by
 CY4PR15MB1783.namprd15.prod.outlook.com (10.174.53.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Thu, 30 May 2019 18:55:17 +0000
Received: from CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f]) by CY4PR15MB1269.namprd15.prod.outlook.com
 ([fe80::c026:bca5:3f4e:9b1f%3]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 18:55:17 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
Thread-Topic: [PATCH 1/2] hwmon: pmbus: Add Infineon PXE1610 VR driver
Thread-Index: AQHVFm7g9tWDmnKUD02ZaFKiFMQM7aaC2UYAgAC28wA=
Date:   Thu, 30 May 2019 18:55:17 +0000
Message-ID: <917858C9-2E51-442F-80A2-420A7460477D@fb.com>
References: <20190529223511.4059120-1-vijaykhemka@fb.com>
 <e72ae680-e8b7-455a-fdde-af79d429dd8c@roeck-us.net>
In-Reply-To: <e72ae680-e8b7-455a-fdde-af79d429dd8c@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2:3b87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dbbedff-3f01-42bd-5e5a-08d6e5305b8d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR15MB1783;
x-ms-traffictypediagnostic: CY4PR15MB1783:
x-microsoft-antispam-prvs: <CY4PR15MB17833486705DE3880453D55FDD180@CY4PR15MB1783.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(54094003)(83716004)(71190400001)(6506007)(86362001)(256004)(71200400001)(14444005)(76176011)(2201001)(53546011)(11346002)(316002)(2501003)(2616005)(6512007)(7736002)(6436002)(476003)(110136005)(6116002)(36756003)(305945005)(102836004)(229853002)(6486002)(186003)(54906003)(68736007)(66946007)(66556008)(25786009)(66476007)(64756008)(486006)(446003)(33656002)(5660300002)(4326008)(46003)(2906002)(478600001)(6246003)(82746002)(81156014)(8676002)(8936002)(99286004)(53936002)(81166006)(14454004)(66446008)(91956017)(76116006)(73956011);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1783;H:CY4PR15MB1269.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: lB/chebdLB4yZYgMpyMKq0uR3rRNbIhfv/u3BZQ/gbtA4KGUb9j1Q5mhFp9y1Lom9xd+M+mkF1TnZi5Z/KaOuEQrhDBxx1u4ADb364NtKbrbiDz2Eemq5H0i1UWo7xp46uVMRiWoIURKQIOWCfgdFL5vKpiPthtenzISItuDbYZBPtIJYlhdi6tRwDapHQWiQyc+2S7ZHncB+AUoU1qQcAHmAzrephISxhVAfKi8cYOuWhueGodMcSzTcVP/G4itFXpzKIEubXgwUs9ThD2zanG3d9HfZHOk2TBqF2KSgeM1LyY7jq5cvs6yGq5/RIEddHdybdy4rP9rds/74gJdp3TYgTmQm1EiG21Q/iDpKp77msxgVXwGcZco3S0UWw82ciqaxkTfIUuCRg00PFSh3w/YxRDyw1zWICcYbVKmS1g=
Content-Type: text/plain; charset="utf-8"
Content-ID: <540BF7348AD75F40BC4F1C5DD0E269E7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbbedff-3f01-42bd-5e5a-08d6e5305b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 18:55:17.5154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vijaykhemka@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1783
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300132
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCu+7v09uIDUvMjkvMTksIDY6MDEgUE0sICJHdWVudGVyIFJvZWNrIiA8Z3JvZWNrN0BnbWFp
bC5jb20gb24gYmVoYWxmIG9mIGxpbnV4QHJvZWNrLXVzLm5ldD4gd3JvdGU6DQoNCiAgICBPbiA1
LzI5LzE5IDM6MzUgUE0sIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+IEFkZGVkIHBtYnVzIGRy
aXZlciBmb3IgdGhlIG5ldyBkZXZpY2UgSW5maW5lb24gcHhlMTYxMA0KICAgID4gdm9sdGFnZSBy
ZWd1bGF0b3IuIEl0IGFsc28gc3VwcG9ydHMgc2ltaWxhciBmYW1pbHkgZGV2aWNlDQogICAgPiBQ
WEUxMTEwIGFuZCBQWE0xMzEwLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBWaWpheSBL
aGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gICBkcml2ZXJzL2h3
bW9uL3BtYnVzL0tjb25maWcgICB8ICAgOSArKysNCiAgICA+ICAgZHJpdmVycy9od21vbi9wbWJ1
cy9NYWtlZmlsZSAgfCAgIDEgKw0KICAgID4gICBkcml2ZXJzL2h3bW9uL3BtYnVzL3B4ZTE2MTAu
YyB8IDExOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogICAgPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKykNCiAgICA+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGRyaXZlcnMvaHdtb24vcG1idXMvcHhlMTYxMC5jDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2h3bW9uL3BtYnVzL0tjb25maWcgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL0tjb25m
aWcNCiAgICA+IGluZGV4IDMwNzUxZWI5NTUwYS4uMzM4ZWY5YjVhMzk1IDEwMDY0NA0KICAgID4g
LS0tIGEvZHJpdmVycy9od21vbi9wbWJ1cy9LY29uZmlnDQogICAgPiArKysgYi9kcml2ZXJzL2h3
bW9uL3BtYnVzL0tjb25maWcNCiAgICA+IEBAIC0xNTQsNiArMTU0LDE1IEBAIGNvbmZpZyBTRU5T
T1JTX01BWDg2ODgNCiAgICA+ICAgCSAgVGhpcyBkcml2ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMg
YSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlIHdpbGwNCiAgICA+ICAgCSAgYmUgY2FsbGVkIG1h
eDg2ODguDQogICAgPiAgIA0KICAgID4gK2NvbmZpZyBTRU5TT1JTX1BYRTE2MTANCiAgICA+ICsJ
dHJpc3RhdGUgIkluZmluZW9uIFBYRTE2MTAiDQogICAgPiArCWhlbHANCiAgICA+ICsJICBJZiB5
b3Ugc2F5IHllcyBoZXJlIHlvdSBnZXQgaGFyZHdhcmUgbW9uaXRvcmluZyBzdXBwb3J0IGZvciBJ
bmZpbmVvbg0KICAgID4gKwkgIFBYRTE2MTAuDQogICAgPiArDQogICAgPiArCSAgVGhpcyBkcml2
ZXIgY2FuIGFsc28gYmUgYnVpbHQgYXMgYSBtb2R1bGUuIElmIHNvLCB0aGUgbW9kdWxlIHdpbGwN
CiAgICA+ICsJICBiZSBjYWxsZWQgcHhlMTYxMC4NCiAgICA+ICsNCiAgICA+ICAgY29uZmlnIFNF
TlNPUlNfVFBTNDA0MjINCiAgICA+ICAgCXRyaXN0YXRlICJUSSBUUFM0MDQyMiINCiAgICA+ICAg
CWhlbHANCiAgICA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL01ha2VmaWxlIGIv
ZHJpdmVycy9od21vbi9wbWJ1cy9NYWtlZmlsZQ0KICAgID4gaW5kZXggMjIxOWI5MzAwMzE2Li5i
MGZiZDAxN2E5MWEgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL2h3bW9uL3BtYnVzL01ha2Vm
aWxlDQogICAgPiArKysgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL01ha2VmaWxlDQogICAgPiBAQCAt
MTgsNiArMTgsNyBAQCBvYmotJChDT05GSUdfU0VOU09SU19NQVgyMDc1MSkJKz0gbWF4MjA3NTEu
bw0KICAgID4gICBvYmotJChDT05GSUdfU0VOU09SU19NQVgzMTc4NSkJKz0gbWF4MzE3ODUubw0K
ICAgID4gICBvYmotJChDT05GSUdfU0VOU09SU19NQVgzNDQ0MCkJKz0gbWF4MzQ0NDAubw0KICAg
ID4gICBvYmotJChDT05GSUdfU0VOU09SU19NQVg4Njg4KQkrPSBtYXg4Njg4Lm8NCiAgICA+ICtv
YmotJChDT05GSUdfU0VOU09SU19QWEUxNjEwKQkrPSBweGUxNjEwLm8NCiAgICA+ICAgb2JqLSQo
Q09ORklHX1NFTlNPUlNfVFBTNDA0MjIpCSs9IHRwczQwNDIyLm8NCiAgICA+ICAgb2JqLSQoQ09O
RklHX1NFTlNPUlNfVFBTNTM2NzkpCSs9IHRwczUzNjc5Lm8NCiAgICA+ICAgb2JqLSQoQ09ORklH
X1NFTlNPUlNfVUNEOTAwMCkJKz0gdWNkOTAwMC5vDQogICAgPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9od21vbi9wbWJ1cy9weGUxNjEwLmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL3B4ZTE2MTAuYw0K
ICAgID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCiAgICA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMDFl
MjY3OTQ0ZGY1DQogICAgPiAtLS0gL2Rldi9udWxsDQogICAgPiArKysgYi9kcml2ZXJzL2h3bW9u
L3BtYnVzL3B4ZTE2MTAuYw0KICAgID4gQEAgLTAsMCArMSwxMTkgQEANCiAgICA+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCiAgICA+ICsvKg0KICAgID4gKyAqIEhhcmR3
YXJlIG1vbml0b3JpbmcgZHJpdmVyIGZvciBJbmZpbmVvbiBQWEUxNjEwDQogICAgPiArICoNCiAg
ICA+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMTkgRmFjZWJvb2sgSW5jDQogICAgPiArICoNCiAgICA+
ICsgKi8NCiAgICA+ICsNCiAgICA+ICsjaW5jbHVkZSA8bGludXgvZXJyLmg+DQogICAgPiArI2lu
Y2x1ZGUgPGxpbnV4L2kyYy5oPg0KICAgID4gKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQogICAg
PiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICAgID4gKyNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCiAgICA+ICsjaW5jbHVkZSAicG1idXMuaCINCiAgICA+ICsNCiAgICA+ICsvKg0KICAg
ID4gKyAqIElkZW50aWZ5IGNoaXAgcGFyYW1ldGVycy4NCiAgICA+ICsgKi8NCiAgICA+ICtzdGF0
aWMgaW50IHB4ZTE2MTBfaWRlbnRpZnkoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwNCiAgICA+
ICsJCQkgIHN0cnVjdCBwbWJ1c19kcml2ZXJfaW5mbyAqaW5mbykNCiAgICANCiAgICBQbGVhc2Ug
YWxpZ24gY29udGludWF0aW9uIGxpbmVzIHdpdGggJygnLg0KQWNrLg0KICAgIA0KICAgID4gK3sN
CiAgICA+ICsJaWYgKHBtYnVzX2NoZWNrX2J5dGVfcmVnaXN0ZXIoY2xpZW50LCAwLCBQTUJVU19W
T1VUX01PREUpKSB7DQogICAgPiArCQlpbnQgdm91dF9tb2RlOw0KICAgID4gKw0KICAgID4gKwkJ
dm91dF9tb2RlID0gcG1idXNfcmVhZF9ieXRlX2RhdGEoY2xpZW50LCAwLCBQTUJVU19WT1VUX01P
REUpOw0KICAgIA0KICAgIHBtYnVzX3JlYWRfYnl0ZV9kYXRhKCkgY2FuIHJldHVybiBhbiBlcnJv
ci4gQ2FsbGluZyBwbWJ1c19jaGVja19ieXRlX3JlZ2lzdGVyKCkNCiAgICBkb2Vzbid0IHJlYWxs
eSBhZGQgYW55IHZhbHVlIGhlcmUsIHNpbmNlIHRoZSBzZWNvbmQgY2FsbCBjYW4gc3RpbGwgZmFp
bCwNCiAgICB3aGljaCBuZWVkcyB0byBiZSBjaGVja2VkLg0KQWNrLg0KICAgIA0KICAgID4gKwkJ
c3dpdGNoICh2b3V0X21vZGUgJiAweDFmKSB7DQogICAgPiArCQljYXNlIDE6DQogICAgPiArCQkJ
aW5mby0+dnJtX3ZlcnNpb24gPSB2cjEyOw0KICAgID4gKwkJYnJlYWs7DQogICAgDQogICAgQWxp
Z25tZW50IGlzIG9mZi4NCkFjay4NCiAgICANCiAgICA+ICsJCWNhc2UgMjoNCiAgICA+ICsJCQlp
bmZvLT52cm1fdmVyc2lvbiA9IHZyMTM7DQogICAgPiArCQlicmVhazsNCiAgICANCiAgICBTYW1l
IGhlcmUuDQogICAgDQogICAgPiArCQlkZWZhdWx0Og0KICAgID4gKwkJCXJldHVybiAtRU5PREVW
Ow0KICAgID4gKwkJfQ0KICAgID4gKwl9DQogICAgPiArCXJldHVybiAwOw0KICAgID4gK30NCiAg
ICA+ICsNCiAgICA+ICtzdGF0aWMgaW50IHB4ZTE2MTBfcHJvYmUoc3RydWN0IGkyY19jbGllbnQg
KmNsaWVudCwNCiAgICA+ICsJCQkgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkKQ0KICAg
ID4gK3sNCiAgICA+ICsJc3RydWN0IHBtYnVzX2RyaXZlcl9pbmZvICppbmZvOw0KICAgID4gKwl1
OCBidWZbSTJDX1NNQlVTX0JMT0NLX01BWF07DQogICAgPiArCWludCByZXQ7DQogICAgPiArDQog
ICAgPiArCWlmICghaTJjX2NoZWNrX2Z1bmN0aW9uYWxpdHkoY2xpZW50LT5hZGFwdGVyLA0KICAg
ID4gKwkJCQkgICAgIEkyQ19GVU5DX1NNQlVTX1JFQURfQllURV9EQVRBDQogICAgPiArCQkJCXwg
STJDX0ZVTkNfU01CVVNfUkVBRF9XT1JEX0RBVEENCiAgICA+ICsJCQkJfCBJMkNfRlVOQ19TTUJV
U19SRUFEX0JMT0NLX0RBVEEpKQ0KICAgID4gKwkJcmV0dXJuIC1FTk9ERVY7DQogICAgPiArDQog
ICAgPiArCS8qIEJ5IGRlZmF1bHQgdGhpcyBkZXZpY2UgZG9lc24ndCBib290IHRvIHBhZ2UgMCwg
c28gc2V0IHBhZ2UgMA0KICAgID4gKwkgKiB0byBhY2Nlc3MgYWxsIHBtYnVzIHJlZ2lzdGVycy4N
CiAgICA+ICsJICovDQogICAgDQogICAgUGxlYXNlIHVzZSBzdGFuZGFyZCBtdWx0aS1saW5lIGNv
bW1lbnRzLg0KQWNrLg0KICAgIA0KICAgID4gKwlpMmNfc21idXNfd3JpdGVfYnl0ZV9kYXRhKGNs
aWVudCwgMCwgMCk7DQogICAgPiArDQogICAgDQogICAgUGxlYXNlIHVzZSB0aGUgUE1CVVNfUEFH
RSBjb21tYW5kIGRlZmluaXRpb24uDQpXaWxsIHVzZS4NCiAgICANCiAgICBJIHdvbmRlciBpZiBp
dCB3b3VsZCBtYWtlIHNlbnNlIHRvIGluaXRpYWxpemUgY3VycnBhZ2UgaW4gdGhlIGNvcmUgdG8g
YW4gdW5yZWFzb25hYmxlDQogICAgbnVtYmVyIGZvciBtdWx0aS1wYWdlIGNoaXBzLCBidXQgSSBn
dWVzcyB0aGF0IGlzIGEgZGlmZmVyZW50IHF1ZXN0aW9uLg0KICAgIA0KICAgID4gKwkvKiBSZWFk
IE1hbnVmYWN0dXJlciBpZCAqLw0KICAgID4gKwlyZXQgPSBpMmNfc21idXNfcmVhZF9ibG9ja19k
YXRhKGNsaWVudCwgUE1CVVNfTUZSX0lELCBidWYpOw0KICAgID4gKwlpZiAocmV0IDwgMCkgew0K
ICAgID4gKwkJZGV2X2VycigmY2xpZW50LT5kZXYsICJGYWlsZWQgdG8gcmVhZCBQTUJVU19NRlJf
SURcbiIpOw0KICAgID4gKwkJcmV0dXJuIHJldDsNCiAgICA+ICsJfQ0KICAgID4gKwlpZiAocmV0
ICE9IDIgfHwgc3RybmNtcChidWYsICJYUCIsIHN0cmxlbigiWFAiKSkpIHsNCiAgICANCiAgICBU
aGUgc3RybGVuKCkgaXMgcmVhbGx5IHVubmVjZXNzYXJ5IGhlcmUuIEp1c3QgdXNlIDIgKGFuZCBh
IGRlZmluZQ0KICAgIGZvciBpdCBpZiB5b3UgbGlrZSkuDQpBY2sNCiAgICANCiAgICA+ICsJCWRl
dl9lcnIoJmNsaWVudC0+ZGV2LCAiTUZSX0lEIHVucmVjb2duaXNlZFxuIik7DQogICAgDQogICAg
dW5yZWNvZ25pemVkLiBPaCB3ZWxsLCB0dXJucyBvdXQgdW5yZWNvZ25pc2VkIGlzIHRoZSBCcml0
aXNoIHNwZWxsaW5nIGFuZA0KICAgIGp1c3QgYXMgdmFsaWQsIHNvIGZlZWwgZnJlZSB0byBrZWVw
IGl0IGlmIHlvdSBsaWtlLg0KICAgIA0KICAgID4gKwkJcmV0dXJuIC1FTk9ERVY7DQogICAgPiAr
CX0NCiAgICA+ICsNCiAgICA+ICsJaW5mbyA9IGRldm1fa3phbGxvYygmY2xpZW50LT5kZXYsIHNp
emVvZihzdHJ1Y3QgcG1idXNfZHJpdmVyX2luZm8pLA0KICAgID4gKwkJCSAgICBHRlBfS0VSTkVM
KTsNCiAgICA+ICsJaWYgKCFpbmZvKQ0KICAgID4gKwkJcmV0dXJuIC1FTk9NRU07DQogICAgPiAr
DQogICAgPiArCWluZm8tPmZvcm1hdFtQU0NfVk9MVEFHRV9JTl0gPSBsaW5lYXI7DQogICAgPiAr
CWluZm8tPmZvcm1hdFtQU0NfVk9MVEFHRV9PVVRdID0gdmlkOw0KICAgID4gKwlpbmZvLT5mb3Jt
YXRbUFNDX0NVUlJFTlRfSU5dID0gbGluZWFyOw0KICAgID4gKwlpbmZvLT5mb3JtYXRbUFNDX0NV
UlJFTlRfT1VUXSA9IGxpbmVhcjsNCiAgICA+ICsJaW5mby0+Zm9ybWF0W1BTQ19QT1dFUl0gPSBs
aW5lYXI7DQogICAgPiArCWluZm8tPmZvcm1hdFtQU0NfVEVNUEVSQVRVUkVdID0gbGluZWFyOw0K
ICAgID4gKw0KICAgID4gKwlpbmZvLT5mdW5jWzBdID0gUE1CVVNfSEFWRV9WSU4NCiAgICA+ICsJ
CXwgUE1CVVNfSEFWRV9WT1VUIHwgUE1CVVNfSEFWRV9JSU4NCiAgICA+ICsJCXwgUE1CVVNfSEFW
RV9JT1VUIHwgUE1CVVNfSEFWRV9QSU4NCiAgICA+ICsJCXwgUE1CVVNfSEFWRV9QT1VUIHwgUE1C
VVNfSEFWRV9URU1QDQogICAgPiArCQl8IFBNQlVTX0hBVkVfU1RBVFVTX1ZPVVQgfCBQTUJVU19I
QVZFX1NUQVRVU19JT1VUDQogICAgPiArCQl8IFBNQlVTX0hBVkVfU1RBVFVTX0lOUFVUIHwgUE1C
VVNfSEFWRV9TVEFUVVNfVEVNUDsNCiAgICA+ICsJaW5mby0+ZnVuY1sxXSA9IGluZm8tPmZ1bmNb
MF07DQogICAgPiArCWluZm8tPmZ1bmNbMl0gPSBpbmZvLT5mdW5jWzBdOw0KICAgID4gKw0KICAg
ID4gKwlpbmZvLT5wYWdlcyA9IGlkLT5kcml2ZXJfZGF0YTsNCiAgICA+ICsJaW5mby0+aWRlbnRp
ZnkgPSBweGUxNjEwX2lkZW50aWZ5Ow0KICAgID4gKw0KICAgIA0KICAgIEl0IGRvZXNuJ3QgcmVh
bGx5IGFkZCB2YWx1ZSB0byBpbml0aWFsaXplIGFsbCB0aGVzZSBwYXJhbWV0ZXJzIG1hbnVhbGx5
Lg0KICAgIEkgd291bGQgc3VnZ2VzdCB0byB1c2UgdGhlIGFwcHJvYWNoIGZyb20gdHBzNTM2Nzku
YywgaWUgaGF2ZSBhIHN0YXRpYw0KICAgIHN0cnVjdHVyZSBhbmQgdXNlIGRldm1fa21lbWR1cCgp
IHRvIHBhc3MgYSBjb3B5IHRvIHBtYnVzX2RvX3Byb2JlKCkuDQpXaWxsIGxvb2sgaW50byB0aGlz
Lg0KICAgIA0KICAgID4gKwlyZXR1cm4gcG1idXNfZG9fcHJvYmUoY2xpZW50LCBpZCwgaW5mbyk7
DQogICAgPiArfQ0KICAgID4gKw0KICAgID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgaTJjX2Rldmlj
ZV9pZCBweGUxNjEwX2lkW10gPSB7DQogICAgPiArCXsicHhlMTYxMCIsIDN9LA0KICAgID4gKwl7
InB4ZTExMTAiLCAzfSwNCiAgICA+ICsJeyJweG0xMzEwIiwgM30sICAgIA0KDQogICAgVW5sZXNz
IHRoZXJlIGFyZSBjaGlwcyB3aXRoIGRpZmZlcmVudCBwYWdlIGNvdW50cyBpbiB0aGUgcXVldWUs
IHVzaW5nDQogICAgZHJpdmVyX2RhdGEgdG8gcGFzcyB0aGUgbnVtYmVyIG9mIHBhZ2VzIGRvZXMg
bm90IGFkZCBhbnkgdmFsdWUuIEp1c3QNCiAgICBzZXQgbnVtX3BhZ2VzIHRvIDMuDQogICAgDQog
ICAgSWYgeW91IGxpa2UsIGZlZWwgZnJlZSB0byB1c2UgYSBkZWZpbmUgaW5zdGVhZCBvZiBhIGNv
bnN0YW50Lg0KQWNrLiAgICANCg0KICAgID4gKwl7fQ0KICAgID4gK307DQogICAgPiArDQogICAg
PiArTU9EVUxFX0RFVklDRV9UQUJMRShpMmMsIHB4ZTE2MTBfaWQpOw0KICAgID4gKw0KICAgID4g
Ky8qIFRoaXMgaXMgdGhlIGRyaXZlciB0aGF0IHdpbGwgYmUgaW5zZXJ0ZWQgKi8NCiAgICANCiAg
ICBUaGlzIGNvbW1lbnQgZG9lcyBub3QgYWRkIGFueSB2YWx1ZS4NCiAgICANCiAgICA+ICtzdGF0
aWMgc3RydWN0IGkyY19kcml2ZXIgcHhlMTYxMF9kcml2ZXIgPSB7DQogICAgPiArCS5kcml2ZXIg
PSB7DQogICAgPiArCQkgICAubmFtZSA9ICJweGUxNjEwIiwNCiAgICA+ICsJCSAgIH0sDQogICAg
PiArCS5wcm9iZSA9IHB4ZTE2MTBfcHJvYmUsDQogICAgPiArCS5yZW1vdmUgPSBwbWJ1c19kb19y
ZW1vdmUsDQogICAgPiArCS5pZF90YWJsZSA9IHB4ZTE2MTBfaWQsDQogICAgPiArfTsNCiAgICA+
ICsNCiAgICA+ICttb2R1bGVfaTJjX2RyaXZlcihweGUxNjEwX2RyaXZlcik7DQogICAgPiArDQog
ICAgPiArTU9EVUxFX0FVVEhPUigiVmlqYXkgS2hlbWthIDx2aWpheWtoZW1rYUBmYi5jb20+Iik7
DQogICAgPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJQTUJ1cyBkcml2ZXIgZm9yIEluZmluZW9uIFBY
RTE2MTAsIFBYRTExMTAgYW5kIFBYTTEzMTAiKTsNCiAgICA+ICtNT0RVTEVfTElDRU5TRSgiR1BM
Iik7DQogICAgPiANCiAgICANCiAgICANCg0K
