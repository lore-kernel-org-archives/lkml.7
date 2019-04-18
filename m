Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D18C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982B4214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iLZ5+ncT";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="REqCa1xK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbfDRUeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:34:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729198AbfDRUeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:34:07 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3IKIhoh008863;
        Thu, 18 Apr 2019 13:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TDzSchkoNGgawXWNyRMhSGt8TL2Kt05SrFYgYYhLgnQ=;
 b=iLZ5+ncTGAZwykV7kk1dm0Ilm6VVMtcg0cpNyxuBHsyoZQzY5GhNNJtuDD5TtS+dG7qR
 A+SfnzeQL3tfa1gDCYIR8WnnQrJs64967/rR7DNLtPmXMizoeWqSjOLAtGAYa1vaSUWB
 AQ47gHjsqhFAPIeA3eyhNWAtL66eh0PeWys= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rxw16gtjk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 18 Apr 2019 13:33:44 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub06.TheFacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 18 Apr 2019 13:33:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 18 Apr 2019 13:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDzSchkoNGgawXWNyRMhSGt8TL2Kt05SrFYgYYhLgnQ=;
 b=REqCa1xKPTs+JauX45+h2mldLmRHNp4GNLAvXsYl5Wr3Hr8oq7y6cypSjKzqP+BNKWWk4REM6Kb33cEJbuq+Z6HFDGsCiFdTlubgi+/Bm8ADFoz6PZ/ZsXMyohwn051q8VhvhfexpMli/cIxD6fiABtNLv2J35vwLl3nC3BHFTg=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2966.namprd15.prod.outlook.com (20.178.237.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Thu, 18 Apr 2019 20:33:40 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 20:33:40 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Wang YanQing <udknight@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/bpf: fix compile errors with older glibc
Thread-Topic: [PATCH] selftests/bpf: fix compile errors with older glibc
Thread-Index: AQHU9UaFFkKU6i/cyUuyOavKVHyDo6ZA6f6AgAFMw4CAACqzAA==
Date:   Thu, 18 Apr 2019 20:33:40 +0000
Message-ID: <895678d5-97ae-61fd-1484-4657c91fc541@fb.com>
References: <20190417174839.GA16679@udknight>
 <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
 <20190418180049.GA4716@udknight>
In-Reply-To: <20190418180049.GA4716@udknight>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::36) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:2ecd]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ff3e46c-f3ed-498a-1ae0-08d6c43d2455
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2966;
x-ms-traffictypediagnostic: BYAPR15MB2966:
x-microsoft-antispam-prvs: <BYAPR15MB296661406C64660E19AFB17CD3260@BYAPR15MB2966.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(54534003)(189003)(199004)(31696002)(6116002)(256004)(8676002)(2501003)(14444005)(478600001)(8936002)(2906002)(2201001)(476003)(86362001)(6512007)(5660300002)(305945005)(68736007)(66946007)(66446008)(64756008)(53936002)(2616005)(316002)(110136005)(46003)(52116002)(97736004)(186003)(7736002)(229853002)(386003)(71190400001)(71200400001)(99286004)(486006)(446003)(81156014)(6506007)(25786009)(31686004)(6246003)(36756003)(53546011)(6436002)(6486002)(76176011)(11346002)(81166006)(102836004)(66476007)(66556008)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2966;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSGGXLY5EDbG8T9ZYR7sWUclloRwyxQpopkuiVxOXearSnhrMvVr6kBG47NULKTYpGVBE2yKZ+jpFV9YPeJlJ+7uONhEEnkAEl2p1vvMaVdJrlYv8IwVa1XmDtsrzZotnz3t4UoNt+t9HuLSXtcUVZzgz2qvbmneWGmUfkiFKoQohLqx2TjkRV47ZMo6c973ngXyfP8CmkSYSFOQZT1Ou9OMuzgKXpdheJXcgh8hVHgUwUN7AtO0Dr42AXqGSz56eMhm6gl3UJQX0SLPTQYpZ8CbxcOiAU10mWGJOwcnGoXeS4ZIScDzyJaQg5S0LkKqI7n+asU4Gji4yDYYP8T9awCnhsd+qlJzSJRiBxnddvJG2AzQr84VYE84pB03SPMYBhdSbNls8cpo+V/jS7I4rpNrMhnjBoLH7dgD3aN8GRw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DD49165511D23458418DF5C9D9CA7F4@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff3e46c-f3ed-498a-1ae0-08d6c43d2455
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 20:33:40.4332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2966
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTgvMTkgMTE6MDAgQU0sIFdhbmcgWWFuUWluZyB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMTgsIDIwMTkgYXQgMDU6MDk6NTNBTSArMDAwMCwgWW9uZ2hvbmcgU29uZyB3cm90ZToNCj4+
DQo+Pg0KPj4gT24gNC8xNy8xOSAxMDo0OCBBTSwgV2FuZyBZYW5RaW5nIHdyb3RlOg0KPj4+IFRo
ZSBvbGRlciBnbGliYyAoZm9yIGV4YW1wbGUsIDIuMjMpIGRvZXNuJ3QgaGFuZGxlIF9fVUFQSV9E
RUZfKg0KPj4+IGluIGxpYmMtY29tcGF0LmggcHJvcGVybHksIGFuZCBpdCBicmluZyBiZWxvdyBj
b21waWxlIGVycm9yczoNCj4+DQo+PiBJIGhhdmUgYW4gZXZlbiBvbGQgZ2xpYmMgMi4xNyBhbmQg
aXQgc3RpbGwgd29ya3MuIE5vdCBzdXJlDQo+PiB3aHkgaXQgZmFpbGVkIGhlcmUuIENvdWxkIHlv
dSBleHBsYWluIG1vcmU/DQo+IA0KPiBXZSB3aWxsIG1lZXQgdGhlc2UgZXJyb3JzIHdpdGggdGhl
IGNvbWJpbmF0aW9uIG9mIHNvbWUgdmVyc2lvbnMgb2Yga2VybmVsIGhlYWRlcnMgYW5kDQo+IHNv
bWUgdmVyc2lvbnMgb2YgZ2xpYmMgaGVhZGVycy4NCj4gDQo+IEFmdGVyIHNvbWUgcmVzZWFyY2gg
b24gdGhlIGdpdCBoaXN0b3J5IG9mIGdsaWJjIGFuZCBrZXJuZWwsIEkgZmluZCB0aGUgcmVhc29u
IGJlaGluZA0KPiB0aGUgc2NlbmUgaXMgYSBsaXR0bGUgY29tcGxleDoNCj4gVGhlcmUgYXJlIHNv
bWUgc2FtZSBkZWZpbml0aW9ucyBiZXR3ZWVuIGdsaWJjJ3MgbmV0aW5ldC9pbi5oIGFuZCBrZXJu
ZWwncyBsaW51eC9pbjYuaCwNCj4gSVBQUk9UT19IT1BPUFRTLCBldGMuDQo+IFRoZXNlIHNhbWUg
ZGVmaW5pdGlvbnMgd2lsbG4ndCBicmluZyB0cm91YmxlIHdoZW4gd2UgaW5jbHVkZSBib3RoIG9m
IHRoZW0gaWYga2VybmVsIGFuZA0KPiBnbGliYyBjb29yZGluYXRlcyB3aXRoIGVhY2ggb3RoZXIg
d2VsbCwgYnV0IHRoZSByZWFsaXR5IGlzIHRoZSBjb29yZGluYXRpb24gaXMgcG9vciBhbmQNCj4g
dW5zeW5jaHJvbm91cyBpbiBoaXN0b3J5Lg0KPiANCj4gS2VybmVsIGFuZCBnbGliYyB1c2VzIGd1
YXJkIG1hY3JvcyB0byBkZXRlY3Qgd2hldGhlciBuZWVkIHRvIGV4cG9ydCB0aGVpciBkZWZpbml0
aW9ucywNCj4gbGludXgvaW42LmggaW5jbHVkZXMgbGliYy1jb21wYXQuaCB3aGljaCB3aWxsIGNo
ZWNrIHRoZSBndWFyZCBtYWNybywgX05FVElORVRfSU5fSCwgYW5kDQo+IG5ldGluZXQvaW4uaCBp
bmNsdWRlcyBiaXRzL2luLmggd2hpY2ggd2lsbCBjaGVjayB0aGUgZ3VhcmQgbWFjcm8sIF9VQVBJ
X0xJTlVYX0lONl9IDQo+IChnbGliYy0yLjE5fjgyMSA2YzgyYTJmOGQ3YzhlMjFlMzkyMzcyMjVj
ODE5ZjE4MmFlNDM4ZGIzICJDb29yZGluYXRlIElQdjYgZGVmaW5pdGlvbnMgZm9yIExpbnV4IGFu
ZCBnbGliYyIpLA0KPiANCj4gdGhlIHByb2JsZW0gaXMgaW4gdGhlIGluc3RhbGxhdGlvbiBwcm9j
ZXNzIG9mIGtlcm5lbCBoZWFkZXJzLCB0aGUgIl9VQVBJIiBpbiBfVUFQSV9MSU5VWF9JTjZfSA0K
PiBpbiBsaW51eC9pbjYuaCB3aWxsIGJlIHN0cmlwcGVkIGR1ZSB0byBjb21taXQgNTZjMTc2Yzlj
YWM5DQo+ICgiVUFQSTogc3RyaXAgdGhlIF9VQVBJIHByZWZpeCBmcm9tIGhlYWRlciBndWFyZHMg
ZHVyaW5nIGhlYWRlciBpbnN0YWxsYXRpb24iKS4NCj4gDQo+IFRoZSBnb29kIG5ld3MgaXMgdGhl
IGdsaWJjIGZpeCB0aGlzIHRoZSB0cm91YmxlIGJ5IGNoZWNraW5nIHRoZSBndWFyZCBtYWNybywg
X0xJTlVYX0lONl9ILCB0b28uDQo+IChnbGliYyBjOWJkNDBkYWFlZTE4Y2YxZDk4MjRlNGE3ZWJh
ZWJlMzIxZTBhNWE4ICJCdWcgMjAyMTQ6IEZpeCBsaW51eC9pbjYuaCBhbmQgbmV0aW5ldC9pbi5o
IHN5bmMuIikuDQoNClRoYW5rcyBmb3IgZXhwbGFuYXRpb24sIG15IHN5c3RlbSBjb250YWlucyB0
aGlzIGdsaWJjIGZpeCAoX0xJTlVYX0lONl9IIA0KaXMgY2hlY2tlZCkgc28gdGhhdCBpcyB3aHkg
SSBkaWQgbm90IGhhdmUgdGhlIGlzc3VlLg0KDQo+IA0KPiBNeSBlbnZpcm9ubWVudCBzdGlsbCBo
YXZlIHRoaXMgdHJvdWJsZToNCj4gbHNiX3JlbGVhc2UgLWE6DQo+IE5vIExTQiBtb2R1bGVzIGFy
ZSBhdmFpbGFibGUuDQo+IERpc3RyaWJ1dG9yIElEOglVYnVudHUNCj4gRGVzY3JpcHRpb246CVVi
dW50dSAxNi4wNC42IExUUw0KPiBSZWxlYXNlOgkxNi4wNA0KPiBDb2RlbmFtZToJeGVuaWFsDQo+
IA0KPiBkcGtnIC1sIHwgZ3JlcCBsaWJjLWRldjoNCj4gaWkgIGxpYmMtZGV2LWJpbiAgICAgICAg
ICAgICAgMi4yMy0wdWJ1bnR1MTEgICAgICAgICAgIGFtZDY0ICAgICAgICBHTlUgQyBMaWJyYXJ5
OiBEZXZlbG9wbWVudCBiaW5hcmllcw0KPiBpaSAgbGludXgtbGliYy1kZXY6YW1kNjQgICAgICA0
LjQuMC0xNDUuMTcxICAgICAgICAgICAgYW1kNjQgICAgICAgIExpbnV4IEtlcm5lbCBIZWFkZXJz
IGZvciBkZXZlbG9wbWVudC4NCj4gDQo+IA0KPiBJIHdpbGwgc2VuZCBvdXQgdGhlIHYyIHdoaWNo
IEkgd2lsbCBjaGFuZ2Ugc29tZSB3b3JkcyBpbiBjaGFuZ2Vsb2cuDQo+IA0KPiBUaGFua3MgZm9y
IHJldmlldy4NCj4gDQo=
