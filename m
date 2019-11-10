Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B413206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 22:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rxj5zxQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfKJWSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 17:18:15 -0500
Received: from mail-eopbgr790085.outbound.protection.outlook.com ([40.107.79.85]:4785
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726648AbfKJWSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 17:18:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g84egq9xvLePxmRJ7DFPyOPd2VKHu5ws0CpgjE64QnnKHF+imA9ac5ys/uLfsWe46LqzAJoTLcT5xzbQNC+uX8agLmFl3RXzOsCIAO3kBTPnKl3jHzwvxKB4dyUKbt143YbOoPGDx9uhlZZkYvAzu81JNEoDruNIi5WXtNEmXyG8oOnwSjumhqGbIb+Im4xbGNUgHBIJndvGaFFmiZ6veSyMcymT8Iwni6rYXpUi+aYnAEfcDOLrP3cVbRTfQJTZdlbncZhkROCaraiz3DsJXHS0tjmrY7UuG3jwC+Rgj+2i+f/KMxzyBuAIikm4TyFeaVBPqj5N7qC+GohpDuYCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjyNqcgjxhJEzaKVJmgi+1lMozkHfc57jW2bfabBHlk=;
 b=R77lC5q7zCOZzbjyBy35oZwXlJOboF+SD99MAx14VILsGvI2rUebm22B5IksFazKVTl+rm4kAzPU8rx4j4+Pck0MDiO3iEB1VsjYNsMG3lMY0hNMpaZYrrd6p6qpvd6uPjYRbiD5Ijel9FDs1sWjDfbA5RQMVmbIyQdmBN5x+sjp0z6NoDnyAQUN15vTDubBiZBCnFqQB/4l6MSySjeoOFFQ4+TMY/CyjlZcGaeF/f9T0iNrwem9+muKiF4JxCL5lQKu3uv+ZPhIKsEH7e5ZwCi4a6tWlw7UDN1NaqWchTATczgZBoOS0UvHqn2GTiGOUHI8h1x2BFWxLNQeEBFyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjyNqcgjxhJEzaKVJmgi+1lMozkHfc57jW2bfabBHlk=;
 b=rxj5zxQg8baYozaGy6JpcbBDeDYfOlCGuFjVa1A9RyL/FFfN/4eRtNZIIH2FS90pmC8vauvLksbOpHQrZRFnn7Q2CvzGTCMFUybbDhg5JUMuH8Eu4JO8b8RaR5SLfIuU8A+FuZKqwcxLAWBPHUB8pfH7nzWv5z1Tfiva5bzS8kg=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6406.namprd02.prod.outlook.com (10.255.156.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Sun, 10 Nov 2019 22:18:10 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2430.023; Sun, 10 Nov 2019
 22:18:10 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 1/2] misc: xilinx_sdfec: Use memdup_user() rather than
 duplicating its implementation
Thread-Topic: [PATCH 1/2] misc: xilinx_sdfec: Use memdup_user() rather than
 duplicating its implementation
Thread-Index: AQHVlAp4a7DAmwL3UEy4xr76jpF77qeFAR/w
Date:   Sun, 10 Nov 2019 22:18:10 +0000
Message-ID: <CH2PR02MB63595AA5F7192DA2186EAC5CCB750@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <af1ff373-56c0-ca49-36dd-15666d183c95@web.de>
 <f6f8f94b-295f-48f5-902e-3d6d4052d76b@web.de>
In-Reply-To: <f6f8f94b-295f-48f5-902e-3d6d4052d76b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [149.199.80.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fea71f34-3e97-4109-eb58-08d7662bdedf
x-ms-traffictypediagnostic: CH2PR02MB6406:|CH2PR02MB6406:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB6406A024160037452DC4B366CB750@CH2PR02MB6406.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:343;
x-forefront-prvs: 02176E2458
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(13464003)(189003)(199004)(71190400001)(6506007)(71200400001)(486006)(76176011)(102836004)(2906002)(99286004)(53546011)(7736002)(2501003)(446003)(476003)(26005)(33656002)(25786009)(74316002)(66066001)(305945005)(4326008)(86362001)(6436002)(6116002)(3846002)(11346002)(66476007)(66556008)(64756008)(229853002)(14454004)(478600001)(186003)(9686003)(8936002)(66446008)(316002)(8676002)(81156014)(81166006)(55016002)(256004)(5660300002)(66946007)(76116006)(52536014)(110136005)(54906003)(6246003)(6636002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6406;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukRpOZmTPU5Jfm28PgDdr/KvBnw1R6GibydZPO4Xx4VQeos73gGKrgV61CXZycG/5lZyT8ZmpfFFI+GAV9WM7yCNRk4UJLwqj2Mye4smLywPfvy760CL7NEY1PdwVA06BGZ9RVHkeS9oj0a7s+LXJnJI0PSMBOJW+V6tAQ7jV/EevROEBGSkQ1m0Iu4RazXa9YoYSaZLUmuuL/9rQDB6T7fZm4C15gtUVwe3UU2X3sN1IYAEnKcbjil1EcqFKt0HWVVesV9MTIKHvKKp9C5Nhs+xeNpaDtBjUauwGxPjcIiiae0v9Z47r3lxuRSFqIHEPmsBGh2F4VRJ57VYaNGKtLJv9uu/X51Npj7a8pqAVDOku4vKUAR5EL+lFFtcnnNQIyScY72vN/h/8sbXizcNSv3D/wb/Rdwewbfn+0IdfsgkEXRawymkIz0P4pTRI5WF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea71f34-3e97-4109-eb58-08d7662bdedf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2019 22:18:10.3648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOKMBiAlv/0yBuC+QF9QyZJcAF2/0IdmIY8mI3QPsTNSAo826RwPXrf81j16Si8bGfy8jOSjMNzHAjxX5R9s7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6406
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzLA0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFy
a3VzIEVsZnJpbmcgW21haWx0bzpNYXJrdXMuRWxmcmluZ0B3ZWIuZGVdDQo+IFNlbnQ6IFR1ZXNk
YXkgNSBOb3ZlbWJlciAyMDE5IDE4OjU1DQo+IFRvOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBEZXJlayBLaWVybmFu
IDxka2llcm5hbkB4aWxpbnguY29tPjsgRHJhZ2FuIEN2ZXRpYw0KPiA8ZHJhZ2FuY0B4aWxpbngu
Y29tPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1p
Y2hhbCBTaW1layA8bWljaGFsc0B4aWxpbnguY29tPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZz47IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogW1BBVENIIDEvMl0gbWlzYzogeGlsaW54X3NkZmVjOiBVc2UgbWVtZHVwX3VzZXIoKSBy
YXRoZXIgdGhhbiBkdXBsaWNhdGluZyBpdHMgaW1wbGVtZW50YXRpb24NCj4gDQo+IEZyb206IE1h
cmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVzZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gRGF0ZTogVHVl
LCA1IE5vdiAyMDE5IDE5OjA5OjE1ICswMTAwDQo+IA0KPiBSZXVzZSBleGlzdGluZyBmdW5jdGlv
bmFsaXR5IGZyb20gbWVtZHVwX3VzZXIoKSBpbnN0ZWFkIG9mIGtlZXBpbmcNCj4gZHVwbGljYXRl
IHNvdXJjZSBjb2RlLg0KPiANCj4gR2VuZXJhdGVkIGJ5OiBzY3JpcHRzL2NvY2NpbmVsbGUvYXBp
L21lbWR1cF91c2VyLmNvY2NpDQo+IA0KPiBGaXhlczogMjBlYzYyOGU4MDA3ZWM3NWMyZjg4NGUw
MDAwNGYzOWVhYjYyODliNSAoIm1pc2M6IHhpbGlueF9zZGZlYzogQWRkIGFiaWxpdHkgdG8gY29u
ZmlndXJlIExEUEMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgRWxmcmluZyA8ZWxmcmluZ0B1
c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IC0tLQ0KPiAgZHJpdmVycy9taXNjL3hpbGlueF9zZGZl
Yy5jIHwgMTEgKysrLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyks
IDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3hpbGlueF9z
ZGZlYy5jIGIvZHJpdmVycy9taXNjL3hpbGlueF9zZGZlYy5jDQo+IGluZGV4IDExODM1OTY5ZTk4
Mi4uYTYyMmZjZjQ5NTRhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVj
LmMNCj4gKysrIGIvZHJpdmVycy9taXNjL3hpbGlueF9zZGZlYy5jDQo+IEBAIC02NDksMTQgKzY0
OSw5IEBAIHN0YXRpYyBpbnQgeHNkZmVjX2FkZF9sZHBjKHN0cnVjdCB4c2RmZWNfZGV2ICp4c2Rm
ZWMsIHZvaWQgX191c2VyICphcmcpDQo+ICAJc3RydWN0IHhzZGZlY19sZHBjX3BhcmFtcyAqbGRw
YzsNCj4gIAlpbnQgcmV0LCBuOw0KPiANCj4gLQlsZHBjID0ga3phbGxvYyhzaXplb2YoKmxkcGMp
LCBHRlBfS0VSTkVMKTsNCj4gLQlpZiAoIWxkcGMpDQo+IC0JCXJldHVybiAtRU5PTUVNOw0KPiAt
DQo+IC0JaWYgKGNvcHlfZnJvbV91c2VyKGxkcGMsIGFyZywgc2l6ZW9mKCpsZHBjKSkpIHsNCj4g
LQkJcmV0ID0gLUVGQVVMVDsNCj4gLQkJZ290byBlcnJfb3V0Ow0KPiAtCX0NCj4gKwlsZHBjID0g
bWVtZHVwX3VzZXIoYXJnLCBzaXplb2YoKmxkcGMpKTsNCj4gKwlpZiAoSVNfRVJSKGxkcGMpKQ0K
PiArCQlyZXR1cm4gUFRSX0VSUihsZHBjKTsNCg0KQWNrZWQtYnk6IERyYWdhbiBDdmV0aWMgPGRy
YWdhbi5jdmV0aWNAeGlsaW54LmNvbT4NCg0KPiANCj4gIAlpZiAoeHNkZmVjLT5jb25maWcuY29k
ZSA9PSBYU0RGRUNfVFVSQk9fQ09ERSkgew0KPiAgCQlyZXQgPSAtRUlPOw0KPiAtLQ0KPiAyLjI0
LjANCg0K
