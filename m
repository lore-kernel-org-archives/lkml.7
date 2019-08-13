Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0553C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC272067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbfHMPHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:07:36 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:45498 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbfHMPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:07:35 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DEql5q027550;
        Tue, 13 Aug 2019 15:07:27 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ubv9khpgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 15:07:27 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id D1BC8BD;
        Tue, 13 Aug 2019 15:07:26 +0000 (UTC)
Received: from G9W8669.americas.hpqcorp.net (16.220.49.28) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 13 Aug 2019 15:07:26 +0000
Received: from G9W9209.americas.hpqcorp.net (2002:10dc:429c::10dc:429c) by
 G9W8669.americas.hpqcorp.net (2002:10dc:311c::10dc:311c) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Tue, 13 Aug 2019 15:07:26 +0000
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (15.241.52.11) by
 G9W9209.americas.hpqcorp.net (16.220.66.156) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Tue, 13 Aug 2019 15:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO8nPzYtU6zYWxSA8yuk2GR+g0rDG7V5dfZLf2s4idFwEFmcNFToqGMoZWcEmh6i+4MOUWQiPDWlOmJTLS6i+M2vYZjvu+jR0QqJ/cnLSLZyUb4BDwu7GqHXXG3OR96k3m+Z+Mo1mI5FF4i27D1b77TjyKz3fblN099Oxwmoz5+weqtdFQr7nXN8EpCSrzasXpvMdaPaE62HOsYAScJOIZiAcg66PwSOnbvGCE3VVVTG58P6YSBsjKwF77xn+Bu95CGOtZDMd8fcwmepW7dtoqrLc44hHyrPRqv+XuQDAQkWvwCNzbiiZv89kclXMn1OHDWcZbRYxU0GGqvkbt0gng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/KyaPdUgDcAsH6Wljpfyi+5TQMSLf41eFRe/a5SqlA=;
 b=AGId5Vj+tYKxNK//+WtVCf+RDJnmlKgAYAQc2amJbGQWbV7Y5FriwiSvPN2IOTVE8m2OtqjWgBR3ToRvANit7km7bPoOJxeie9+XLOgAPYacE4HA7ofru4wfsPL2c4QDcVahzX/v2WhMC1ysORKbea/JU/6H4TTjHcHQbKx4K72IpAZootelDK0CUyfVrf6wqQKfGha73usR6lmfN9yUi4adpBwTK10EFdDIZaBZ1RMTl6PaXJvx+qOYQJbT9RznMgw3qb+PcAAdB+ciIFv3OPzqJxvsVEdAbH+EKyuKIb2uviww/1IMdnpiebjhRUFLVaxcXPhRkzime1jOv1NCtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM (10.169.44.19) by
 TU4PR8401MB0975.NAMPRD84.PROD.OUTLOOK.COM (10.169.48.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 15:07:24 +0000
Received: from TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9cc4:8a7f:f761:f990]) by TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9cc4:8a7f:f761:f990%11]) with mapi id 15.20.2157.022; Tue, 13 Aug
 2019 15:07:24 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "isaku.yamahata@gmail.com" <isaku.yamahata@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fei1.li@intel.com" <fei1.li@intel.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Thread-Topic: [PATCH 0/3] x86/mtrr, pat: make PAT independent from MTRR
Thread-Index: AQHVTmYqsSEI/GfXwEqOxUs01+wmX6byZTeAgADT14CABYFgAIAAeJsA
Date:   Tue, 13 Aug 2019 15:07:24 +0000
Message-ID: <dd7663d11e02923240f28f1e6f71fb878750ee70.camel@hpe.com>
References: <cover.1565300606.git.isaku.yamahata@gmail.com>
         <20190809070647.GA2152@zn.tnic>
         <3355d77da5e094ad1d3149b9236cdd204486fd69.camel@hpe.com>
         <20190813074920.GA24196@private.email.ne.jp>
In-Reply-To: <20190813074920.GA24196@private.email.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.219.163.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed36515c-33d7-45ef-3049-08d71ffff2c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:TU4PR8401MB0975;
x-ms-traffictypediagnostic: TU4PR8401MB0975:
x-microsoft-antispam-prvs: <TU4PR8401MB09752462DC25C6D9A217F40282D20@TU4PR8401MB0975.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(346002)(39860400002)(366004)(199004)(189003)(2351001)(5640700003)(316002)(8936002)(76176011)(26005)(6486002)(99286004)(102836004)(8676002)(5660300002)(86362001)(2501003)(54906003)(6506007)(6512007)(4326008)(6916009)(81156014)(81166006)(486006)(11346002)(14454004)(2906002)(6116002)(7736002)(2616005)(25786009)(1361003)(14444005)(53936002)(478600001)(446003)(256004)(476003)(36756003)(118296001)(305945005)(66066001)(6436002)(66446008)(64756008)(66556008)(66476007)(229853002)(3846002)(6246003)(186003)(76116006)(66946007)(71190400001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TU4PR8401MB0975;H:TU4PR8401MB0607.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c5Od6fJMowo4b7Ro9Zr/8ZEbYq7zrMvaorTv8rl1BU4sS56AI134zbGt6Kc0x1vV0D3dya+lZrml9DfxCS/pTY1XC/01G0JfrHlXa3wKZT7rj/AszvdZbLokvX7psVEwgRt8gbXqpiSH+JQU2KyKSLAKWW1ujnNlCv3ceTTBM4h2mzG7yrrmQTTRVAdmhQLIN36hWu/e9EgFdSfsWTjurlLkSUGjQ09pZjya1cA8RR+leT9x8jHB+6Uh9StZeaDBVzEU+S3PNyuNJoTac2e59TuMrEKoAmykZDYxazRoSABXpAJsAKcPPLkTXAvy+2QS+Id5NOSYm6yGuxAG9Z9WLbGoZsDA/re15OKRtnGCr831pruny5X0d+s7CKdSo/npgbYiA5bOzOIeUR7SrfUlsi4RJQALYX9vD5hnp04J8MM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <212C2DBC99B08742A8C19159443C2102@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ed36515c-33d7-45ef-3049-08d71ffff2c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 15:07:24.4980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D72H2+JOda/YvtxKwzTz72ItzxNRsyzSH2KSyKH/J+PR06eVMUsoah7Wuzend7++BIxlkl2L7Ig4M8yQ13APkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0975
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=567 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDAwOjQ5IC0wNzAwLCBJc2FrdSBZYW1haGF0YSB3cm90ZToN
Cj4gT24gRnJpLCBBdWcgMDksIDIwMTkgYXQgMDc6NTE6MTdQTSArMDAwMCwNCj4gIkthbmksIFRv
c2hpIiA8dG9zaGkua2FuaUBocGUuY29tPiB3cm90ZToNCj4gDQo+ID4gT24gRnJpLCAyMDE5LTA4
LTA5IGF0IDA5OjA2ICswMjAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6DQo+ID4gPiBPbiBUaHUs
IEF1ZyAwOCwgMjAxOSBhdCAwODo1NDoxN1BNIC0wNzAwLCBJc2FrdSBZYW1haGF0YSB3cm90ZToN
Cj4gPiA+ID4gTWFrZSBQQVQoUGFnZSBBdHRyaWJ1dGUgVGFibGUpIGluZGVwZW5kZW50IGZyb20N
Cj4gPiA+ID4gTVRSUihNZW1vcnkgVHlwZSBSYW5nZSBSZWdpc3RlcikuDQo+ID4gPiA+IFNvbWUg
ZW52aXJvbm1lbnRzIChtYWlubHkgdmlydHVhbCBvbmVzKSBzdXBwb3J0IG9ubHkgUEFULCBidXQg
bm90IE1UUlINCj4gPiA+ID4gYmVjYXVzZSBQQVQgcmVwbGFjZXMgTVRSUi4NCj4gPiA+ID4gSXQn
cyB0cmlja3kgYW5kIG5vIGdhaW4gdG8gc3VwcG9ydCBib3RoIE1UUlIgYW5kIFBBVCBleGNlcHQg
Y29tcGF0aWJpbGl0eS4NCj4gPiA+ID4gU28gc29tZSBWTSB0ZWNobm9sb2dpZXMgZG9uJ3Qgc3Vw
cG9ydCBNVFJSLCBidXQgb25seSBQQVQuDQo+ID4gDQo+ID4gSSBkbyBub3QgdGhpbmsgaXQgaXMg
dGVjaG5pY2FsbHkgY29ycmVjdCBvbiBiYXJlIG1ldGFsLiAgQUZBSUssIE1UUlIgaXMNCj4gPiBz
dGlsbCB0aGUgb25seSB3YXkgdG8gc2V0dXAgY2FjaGUgYXR0cmlidXRlIGluIHJlYWwtbW9kZSwg
d2hpY2ggQklPUyBTTUkNCj4gPiBoYW5kbGVyIHJlbGllcyBvbiBpbiBTTU0uDQo+IA0KPiBUaGVu
IHlvdSdyZSBjbGFpbWluZyBpZiBpdCdzIGJhcmVtZXRhbCwgYm90aCBNVFJSIGFuZCBQQVQgc2hv
dWxkIGJlDQo+IGVuYWJsZWQvZGlzYWJsZWQgYXQgdGhlIHNhbWUgdGltZT8NCg0KTm8sIEkgZGlk
IG5vdCBzYXkgdGhhdC4gTXkgcG9pbnQ6DQotIFlvdXIgc3RhdGVtZW50IG9mIE1UVFIgYmVpbmcg
dXNlbGVzcyBpcyBub3QgY29ycmVjdC4gSXQncyBzdGlsbCB1c2VkLg0KVGhlIE9TIHNob3VsZCBs
ZWF2ZSB0aGUgTVRUUiBoYW5kLW9mZiBzdGF0ZS4NCg0KSSBhZ3JlZSB3aXRoIHlvdSBpbiBnZW5l
cmFsIHRoYXQgUEFUIGFuZCBNVFRSIGluaXQgc2hvdWxkIGJlDQppbmRlcGVuZGVudC4gSG93ZXZl
ciwgYXMgQm9yaXMgc2FpZCwgcGxlYXNlIHZlcmlmeSB0aGUgaW1wYWN0IG9mIHlvdXINCmNoYW5n
ZS4gQXMgSSBtZW50aW9uZWQgaW4gdGhlIFhlbidzIGV4YW1wbGUsIGh5cGVydmlzb3IgbWF5IGhh
dmUgbm9uLQ0KZGVmYXVsdCBQQVQgaGFuZC1vZmYgc2V0dGluZy4NCg0KVGhhbmtzLA0KLVRvc2hp
DQoNCg==
