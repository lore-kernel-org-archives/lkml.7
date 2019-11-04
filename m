Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAEECA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C5E20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SgC1Lftj";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vdPMd+A4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfKDPQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:16:55 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47690 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727796AbfKDPQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:16:54 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4FAu7j026824;
        Mon, 4 Nov 2019 07:16:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zmSaHKx8q84rbKrghSSmzPWPCEl5ZZkjh9SxFnSB48Q=;
 b=SgC1LftjkSpKrQ09W35pe5RGtyuiY9ZHx3XrsNVdAA2VZV8K+5M9KZTdN618gxBxKE0E
 pvbfLO3huaEnSzV4e1St5RfpeZKt/3hzSWHOMHmedS4fpEFvux5jBOTjvhIdwK4Y2nmS
 pruvf3Q+e3UmihOEDSb+UBvBU53+OgAS7PHcqnoGv2m8bap+1CCPsfCSFIp1hv/jNvwH
 KRyHcRJa0yhYKlY2GAXu+9nziITVdjiLOxx8Abo22NrdRq9cRd6pDWXXfW9aWO8LUy7z
 PXTfShU29mqJFU712AZAy4BapwSNQQOVa5Y8tfA2gHL9B99RG3kijpoHtzH+FYyU9hzA 8w== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2w15cx74r1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 04 Nov 2019 07:16:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1c96PvK5eh9dpWYInkkGFvHmEUQhIPgzUWnDLtMzRhS3OkWcQ02kQZMokHVmGTfwXw+HCgGubgKS04y/3tETPEPAdyeT4S6A69BgF2asLkexi6ghCKC8mKekSI3GuM1QNl24NHeam/9rH7nrRvbb+M+bO70Ds3rm1a6ZWWpf+9QHFhfJpir+2B4LD9IQDqhTIBDPCadu/pfjNbFqDs+0J+iMB7IguNNEBRGxYaTdUdH62OSaueYhYu7YSLpE4Gohc+nRLI6ooCFrUbW3ER06tNAMTYHDs/lvUXdvS8ujhxgqaZC9zyTlrK43QEFgzyvNIXBr35Nn+mF7spNHNc1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmSaHKx8q84rbKrghSSmzPWPCEl5ZZkjh9SxFnSB48Q=;
 b=AdglxUFlRZue0633bf/4Gu28U4loxQj5T+sV5WVCggumRhTV2aXfjGaErOwzLyr2Wse/ONDL96GsAzgFN1wTIEmOAOrYyDd6MIHMRwl3c5+jjv3UUrmy1p81wub3ARLwrb8fJy5dnj7q80vCwuiV86KuzXhzifN6T28WTmNMuiXZhi5Ec9K03jcUW8Y81+VtJre+YJbwN+RLUbW6Kn3QcuRenuMfBtP8IbXVK0ywIgqEh6uF2VL0oDByTFI4bVn9tmVygf+pYAg7yWhz4RyN0VLyzVra09L5yR/oFCb7EJ+fKEFbZBK0vnoMzbGbWvOMpdQu0NyLaxbWbi/w7JU+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmSaHKx8q84rbKrghSSmzPWPCEl5ZZkjh9SxFnSB48Q=;
 b=vdPMd+A4b+GU82eJDqkz+9/RxVqrG3TGWdhy/EjGFjQv1V/89dzhXTdSAsexsTPZCn0NenX9XmgPGaEDZiEi3l9Qmr4TkEjzvvX8vQo9mEnqcxaq0q74GcKN/wXLNqWkPxCXppl0qFmwfbv4I27dK3zgaNn7UDBp4Ru2rEAYv+0=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5606.namprd07.prod.outlook.com (20.177.231.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Mon, 4 Nov 2019 15:16:41 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::8dae:bee9:340a:b770%6]) with mapi id 15.20.2408.024; Mon, 4 Nov 2019
 15:16:41 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
Thread-Topic: [PATCH v2] usb: cdns3: gadget: Fix g_audio use case when
 connected to Super-Speed host
Thread-Index: AQHVjxvVqFJYSBv4q0KQRfTJbi0lwqd0c8cAgAAb1ACAAAWhgIAAAdkAgASD/LCAAahggIAAYXTg
Date:   Mon, 4 Nov 2019 15:16:41 +0000
Message-ID: <BYAPR07MB4709C1750988DBD0F4AC5FB9DD7F0@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <20191029151514.28495-1-rogerq@ti.com>
 <20191030121607.21739-1-rogerq@ti.com> <87pnide1k7.fsf@gmail.com>
 <44b07e90-a9de-ea99-25c6-dc72cf39bbe1@ti.com> <875zk5dw0m.fsf@gmail.com>
 <86a7fbc4-136f-78bb-4677-784199842c9f@ti.com>
 <BYAPR07MB4709B96934FAED77689ED89EDD7C0@BYAPR07MB4709.namprd07.prod.outlook.com>
 <03bb6f7e-5545-3047-d3f4-4fa9789d0bcb@ti.com>
In-Reply-To: <03bb6f7e-5545-3047-d3f4-4fa9789d0bcb@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4df41fc5-ec50-4e36-823e-08d76139fee0
x-ms-traffictypediagnostic: BYAPR07MB5606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB56064FAA8B84AD93C0A54CD6DD7F0@BYAPR07MB5606.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0211965D06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(36092001)(51444003)(199004)(189003)(54534003)(7736002)(229853002)(66066001)(26005)(2501003)(11346002)(476003)(486006)(8676002)(53546011)(6506007)(76176011)(7696005)(81156014)(81166006)(102836004)(8936002)(66476007)(66946007)(186003)(66556008)(76116006)(64756008)(6436002)(110136005)(86362001)(54906003)(316002)(6116002)(3846002)(305945005)(74316002)(2906002)(66446008)(446003)(99286004)(4326008)(14454004)(52536014)(5660300002)(256004)(14444005)(33656002)(25786009)(71200400001)(71190400001)(6246003)(478600001)(9686003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5606;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k14iPajh/Alv5zY1MLQwcYtIhecVi96cug6aXxDS6tTWX/TpmY+0WxQnAKka0zcL6dosZza+wzMlOFoFD0tb4blISkiqNuvo/eabolLeTcGsQi5Z1wUX2XbWoKv0XTOtfkE2rRVoyJwsquM7rYx70diVUqJgiqDfpVSHs1a+XtZ6CJLIh1SyLxmJ44yAmxhQBCfpOXNOBwIXrBhxTK/hKoXPovpxwNMdPomrGUxOqUF66UnKMn0Ta81eXC1pu5IYG1o5dkH2OcxrE/LdqV9bmwlTM7LxAo0rPMgP9AXgM97WNtjQm/yvnZGDsu8GzYC+JcJ6WgjjB7Kj1kKWyzRacOezqIMeAnEdnmeUYs9Q34mdMCueq+Ar6KPLA2RkclMFt0Jr0AADBdomMp3ad19UQ2C3BmylkO/R3f3OBhO6gIiR2LA2K0iGRuMyfZ2TkIxEfIl0pgil8Nyq1oisLdTicw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df41fc5-ec50-4e36-823e-08d76139fee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2019 15:16:41.2261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hIZ9VS8SaWqPXf/xsET+t4U5ecrrlOkTdNg1c8txNM0+2PxnvhK95RpHcsT3PfwWtIr+XMg6kET4f88haXAwuxaI+eI9FJAJwoLNe38H0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5606
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-04_09:2019-11-04,2019-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=926
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 clxscore=1015 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1911040151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj4NCj5PbiAwMy8xMS8yMDE5IDEwOjE3LCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4+
IEhpLA0KPj4NCj4+Pj4NCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+IFJvZ2VyIFF1YWRyb3MgPHJvZ2Vy
cUB0aS5jb20+IHdyaXRlczoNCj4+Pj4NCj4+Pj4+IEhpLA0KPj4+Pj4NCj4+Pj4+IE9uIDMxLzEw
LzIwMTkgMTA6NTUsIEZlbGlwZSBCYWxiaSB3cm90ZToNCj4+Pj4+Pg0KPj4+Pj4+IEhpLA0KPj4+
Pj4+DQo+Pj4+Pj4gUm9nZXIgUXVhZHJvcyA8cm9nZXJxQHRpLmNvbT4gd3JpdGVzOg0KPj4+Pj4+
DQo+Pj4+Pj4+IFRha2UgaW50byBhY2NvdW50IGdhZGdldCBkcml2ZXIncyBzcGVlZCBsaW1pdCB3
aGVuIHByb2dyYW1taW5nDQo+Pj4+Pj4+IGNvbnRyb2xsZXIgc3BlZWQuDQo+Pj4+Pj4+DQo+Pj4+
Pj4+IEZpeGVzOiBjb21taXQgNzczM2Y2YzMyZTM2ICgidXNiOiBjZG5zMzogQWRkIENhZGVuY2Ug
VVNCMyBEUkQgRHJpdmVyIikNCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogUm9nZXIgUXVhZHJvcyA8
cm9nZXJxQHRpLmNvbT4NCj4+Pj4+Pj4gQWNrZWQtYnk6IFBldGVyIENoZW4gPHBldGVyLmNoZW5A
bnhwLmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+DQo+Pj4+Pj4+IENoYW5nZWxvZzoNCj4+Pj4+
Pj4gdjINCj4+Pj4+Pj4gLSBBZGQgRml4ZXMgbGluZQ0KPj4+Pj4+Pg0KPj4+Pj4+PiAgICAgZHJp
dmVycy91c2IvY2RuczMvZ2FkZ2V0LmMgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKy0t
LS0tDQo+Pj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNSBkZWxl
dGlvbnMoLSkNCj4+Pj4+Pj4NCj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvY2RuczMvZ2FkZ2V0LmMNCj4+Pj4+Pj4gaW5kZXggNDBk
YWQ0ZThkMGRjLi4xYzcyNGMyMGQ0NjggMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvdXNi
L2NkbnMzL2dhZGdldC5jDQo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdXNiL2NkbnMzL2dhZGdldC5j
DQo+Pj4+Pj4+IEBAIC0yMzM4LDkgKzIzMzgsMzUgQEAgc3RhdGljIGludCBjZG5zM19nYWRnZXRf
dWRjX3N0YXJ0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnYWRnZXQsDQo+Pj4+Pj4+ICAgICB7DQo+Pj4+
Pj4+ICAgICAJc3RydWN0IGNkbnMzX2RldmljZSAqcHJpdl9kZXYgPSBnYWRnZXRfdG9fY2RuczNf
ZGV2aWNlKGdhZGdldCk7DQo+Pj4+Pj4+ICAgICAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4+Pj4+
Pj4gKwllbnVtIHVzYl9kZXZpY2Vfc3BlZWQgbWF4X3NwZWVkID0gZHJpdmVyLT5tYXhfc3BlZWQ7
DQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgICAJc3Bpbl9sb2NrX2lycXNhdmUoJnByaXZfZGV2LT5sb2Nr
LCBmbGFncyk7DQo+Pj4+Pj4+ICAgICAJcHJpdl9kZXYtPmdhZGdldF9kcml2ZXIgPSBkcml2ZXI7
DQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gKwkvKiBsaW1pdCBzcGVlZCBpZiBuZWNlc3NhcnkgKi8NCj4+
Pj4+Pj4gKwltYXhfc3BlZWQgPSBtaW4oZHJpdmVyLT5tYXhfc3BlZWQsIGdhZGdldC0+bWF4X3Nw
ZWVkKTsNCj4+Pj4+Pj4gKw0KPj4+Pj4+PiArCXN3aXRjaCAobWF4X3NwZWVkKSB7DQo+Pj4+Pj4+
ICsJY2FzZSBVU0JfU1BFRURfRlVMTDoNCj4+Pj4+Pj4gKwkJd3JpdGVsKFVTQl9DT05GX1NGT1JD
RV9GUywgJnByaXZfZGV2LT5yZWdzLT51c2JfY29uZik7DQo+Pj4+DQo+Pj4+IHNvIHRoaXMgZm9y
Y2VzIHRoZSBjb250cm9sbGVyIHRvIEZTDQo+Pj4NCj4+PiBSaWdodC4NCj4+Pg0KPj4+Pg0KPj4+
Pj4+PiArCQl3cml0ZWwoVVNCX0NPTkZfVVNCM0RJUywgJnByaXZfZGV2LT5yZWdzLT51c2JfY29u
Zik7DQo+Pj4+DQo+Pj4+IGFuZCB0aGlzIGRpc2Nvbm5lY3RzIGluIHN1cGVyc3BlZWQ/IFdoYXQg
aXMgdGhpcyBzdXBwb3NlZCB0byBkbz8NCj4+Pj4NCj4+Pg0KPj4+IEl0IHNheXMgIkRpc2Nvbm5l
Y3QgVVNCIGRldmljZSBpbiBTdXBlclNwZWVkIi4NCj4+Pg0KPj4+IFdlIHdlcmUgYXNrZWQgdG8g
c2V0IHRoYXQgYml0IHRvIGxpbWl0IGl0IHRvIEhTLg0KPj4+DQo+Pj4+Pj4+ICsJCWJyZWFrOw0K
Pj4+Pj4+PiArCWNhc2UgVVNCX1NQRUVEX0hJR0g6DQo+Pj4+Pj4+ICsJCXdyaXRlbChVU0JfQ09O
Rl9VU0IzRElTLCAmcHJpdl9kZXYtPnJlZ3MtPnVzYl9jb25mKTsNCj4+Pj4+Pj4gKwkJYnJlYWs7
DQo+Pj4+Pj4+ICsJY2FzZSBVU0JfU1BFRURfU1VQRVI6DQo+Pj4+Pj4+ICsJCWJyZWFrOw0KPj4+
Pj4+PiArCWRlZmF1bHQ6DQo+Pj4+Pj4+ICsJCWRldl9lcnIocHJpdl9kZXYtPmRldiwNCj4+Pj4+
Pj4gKwkJCSJpbnZhbGlkIG1heGltdW1fc3BlZWQgcGFyYW1ldGVyICVkXG4iLA0KPj4+Pj4+PiAr
CQkJbWF4X3NwZWVkKTsNCj4+Pj4+Pj4gKwkJLyogZmFsbCB0aHJvdWdoICovDQo+Pj4+Pj4+ICsJ
Y2FzZSBVU0JfU1BFRURfVU5LTk9XTjoNCj4+Pj4+Pj4gKwkJLyogZGVmYXVsdCB0byBzdXBlcnNw
ZWVkICovDQo+Pj4+Pj4+ICsJCW1heF9zcGVlZCA9IFVTQl9TUEVFRF9TVVBFUjsNCj4+Pj4+Pj4g
KwkJYnJlYWs7DQo+Pj4+Pj4+ICsJfQ0KPj4+Pj4+DQo+Pj4+Pj4gSSBoYWQgc3VnZ2VzdGVkIHNv
bWUgc2ltcGxpZmljYXRpb24gZm9yIHRoaXMgY2FzZSBzdGF0ZW1lbnQuDQo+Pj4+Pj4NCj4+Pj4+
DQo+Pj4+PiBvb3BzLCBsb29rcyBsaWtlIEdyZWcgcGlja2VkIHRoaXMgYWxyZWFkeS4NCj4+Pj4+
DQo+Pj4+PiBEdXJpbmcgbW9yZSB0ZXN0cyB0b2RheSBJIGp1c3Qgb2JzZXJ2ZWQgdGhhdCB0aGlz
IHBhdGNoIGNhdXNlcw0KPj4+Pj4gdGhlIGZvbGxvd2luZyByZWdyZXNzaW9uLg0KPj4+Pj4NCj4+
Pj4+IENvbm5lY3QgRVZNIHRvIFN1cGVyLVNwZWVkIGhvc3QNCj4+Pj4+IExvYWQgZ19hdWRpby4g
KHRoaXMgZW51bWVyYXRlcyBhcyBIUyB3aGljaCBpcyBmaW5lKQ0KPj4+Pj4gdW5sb2FkIGdfYXVk
aW8NCj4+Pj4+IGxvYWQgZ196ZXJvICh0aGlzIGVudW1lcmF0ZXMgYXQgSFMgaW5zdGVhZCBvZiBT
UykuDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBpcyBiZWNhdXNlIHRoZSBzcGVlZCBsaW1pdCB0aGF0IHdl
IHNldCBkb2Vzbid0IGdldCBjbGVhcmVkLg0KPj4+Pj4NCj4+Pj4+IE5vdyB0aGUgYml0cyBhcmUg
d3JpdGUgb25seSBhbmQgdGhlcmUgaXMgYSB3YXkgdG8gdW5kbyBVU0JfQ09ORl9TRk9SQ0VfRlMN
Cj4+Pj4+IGJ5IHdyaXRpbmcgVVNCX0NPTkZfQ0ZPUkNFX0ZTLCBob3dldmVyIHRoZXJlIGlzIG5v
IGNvcnJlc3BvbmRpbmcgYml0DQo+Pj4+PiB0byBjbGVhciBVU0JfQ09ORl9VU0IzRElTLiBPbmx5
IHdheSBzZWVtcyB0byBiZSBVU0JfQ0ZHX1NXUlNUIHdoaWNoDQo+Pj4+PiBpcyBhIGJpdCBoYXJz
aCBJTU8uDQo+Pj4+DQo+Pj4+IElzbid0IGJpdCAwIGVub3VnaD8NCj4+Pj4NCj4+Pj4gLyogUmVz
ZXQgVVNCIGRldmljZSBjb25maWd1cmF0aW9uLiAqLw0KPj4+PiAjZGVmaW5lIFVTQl9DT05GX0NG
R1JTVAkJQklUKDApDQo+Pj4NCj4+PiBQcm9iYWJseSBub3QsIGFzIGV4cGxhbmF0aW9uIG9mIFVT
QjNESVMgYml0IHNheXMsDQo+Pj4gIlRvIGNvbm5lY3QgZGlzY29ubmVjdGVkIGRldmljZSwgQ1BV
IHBlcmZvcm1zDQo+Pj4gc29mdHdhcmUgcmVzZXQgKENGRy5TV1JTVCkuIiB3aGljaCBpcyBiaXQg
Ny4gIkRldmljZSBzb2Z0d2FyZSByZXNldC4NCj4+Pg0KPj4+IEJ1dCBJJ2xsIGxldCBQYXdlbCBj
b21tZW50IG9uIHRoaXMuDQo+Pg0KPj4gWWVzIGl0J3MgdGhlIG9ubHkgd2F5IHRvIHJldHVybiBi
YWNrIHRvIFNTIG1vZGUuDQo+PiBUaGUgVVNCIHNwZWVkIGlzIGRldGVjdGluZyBkdXJpbmcgY29u
bmVjdGluZy4NCj4+IENGRy5TV1JTVCBtYWtlIHJlY29ubmVjdC4NCj4NCj5DYW4gdGhpcyBiZSBk
b25lIGFzIHBhcnQgb2YgdWRjX3N0YXJ0IG9yIHVkY19zdG9wPw0KDQpJIHRoaW5rIHRoYXQgaXQg
c2hvdWxkIHdvcmsgaW4gYm90aCBjYXNlcywgaG93ZXZlciBiZWNhdXNlIGl0IGZpbmlzaCB3aXRo
IGNvbm5lY3Rpb24gDQpzbyBwcm9iYWJseSB0aGUgYmV0dGVyIHdpbGwgYmUgdWRjX3N0YXJ0IGZ1
bmN0aW9uLiANCg0KPg0KPj4NCj4+IE1heWJlIGl0IHdvdWxkIGJlIGJldHRlciB0byBhZGQgU1Mg
c3VwcG9ydCBpbiBnX2F1ZGlvIGZ1bmN0aW9uLg0KPg0KPk5vdCBldmVyeSBnYWRnZXQgbmVlZHMg
U1MsIHNvIHRoaXMgaXMgbm90IHRoZSByaWdodCB3YXkgSU1PLg0KPg0KPj4NCj4+Pj4NCj4+Pj4g
QWxzbywgbm93IHRoYXQgSSBsb29rIGF0IHRoaXMgbW9yZSBjYXJlZnVsbHksIHlvdSBzaG91bGQg
bW92ZSB0aGF0IGNvZGUNCj4+Pj4gdG8gdWRjX3NldF9zcGVlZCgpLg0KPj4+Pg0KPj4+DQo+Pj4g
QWdyZWVkLiBJJ2xsIHJldmlzZSB0aGUgaW1wbGVtZW50YXRpb24gdG8gbW92ZSBpdCB0byB1ZGNf
c2V0X3NwZWVkKCkNCj4+PiBvbmNlIEkga25vdyBob3cgdG8gdW5kbyB0aGUgVVNCM0RJUy4NCj4+
Pg0KPg0KPg0KPi0tDQo+Y2hlZXJzLA0KPi1yb2dlcg0KPlRleGFzIEluc3RydW1lbnRzIEZpbmxh
bmQgT3ksIFBvcmtrYWxhbmthdHUgMjIsIDAwMTgwIEhlbHNpbmtpLg0KPlktdHVubnVzL0J1c2lu
ZXNzIElEOiAwNjE1NTIxLTQuIEtvdGlwYWlra2EvRG9taWNpbGU6IEhlbHNpbmtpDQo=
