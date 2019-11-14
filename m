Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D302071B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="p/6/bLll";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DXbgHKYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfKNSDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:03:52 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:44700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfKNSDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:03:52 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAEI0suH020953;
        Thu, 14 Nov 2019 10:03:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=jKXCCScAfAFPF5gwM9xcUjl8gshll9V0AVUzoLvrVaY=;
 b=p/6/bLll+dOEv1WFNWRhTH7NexmR/o7GD4SJwEwFGJKtygbXmFkQhbOYCYTXPQw3EX8X
 mE23KADE7+AfnzJQ9GTP+w3F8d9UhvYchF+WYit3+yDu5DAhiqDbt2cflb7CfALYACRZ
 ibJEgpGnfgxnvj5O0X/o3OHoEXhzdTHWlwA= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2w8u0tc63k-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 10:03:17 -0800
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 14 Nov 2019 10:03:00 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 14 Nov 2019 10:03:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbS4jXVw01b8v3K6aYPjv3AES/Iqhhtz+qNHtcWb9vBmBtdqmKqnI2QWvQGJUZD7IrKKbcD+5bdmaaw0NqPS/fh9fOWCg6Jh93w/RLdJ3cj1lkXyx7zRXGJbiEZFsRbcbO3if5hgO0Md+5f1ZbwTJUwO+tSjECOzMq4YkyN7o+0H0Fdu+QmIagR21PxNKI70xlo1zgwCAjZvfr3g3f8hVSDeL8f+G/WXePKUOauGZSVho7JaXm0TT3XVhhHEHSkLSPjOgm4CXjEo8JANkkkcSlx8JEI4mQTMoQ2A+QkVBkRG21bF+IB7DR++QS8fTPk7ftHRNgI3rauAjlwe3RcwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKXCCScAfAFPF5gwM9xcUjl8gshll9V0AVUzoLvrVaY=;
 b=DFRYHYKAysFkYsu306zS2G1g9PiXsR5xmDS9c7kMDGZ1V8BZWLY61t1rdjTv+Ooy83mHPDrmf3uyeeY7t44sa11ZYtias6dTF7jhKMKuIDDzAdz/F+lP43gEX0Dh2RExT/JAqAGUFQ2kwhCaGtFaikdjTE56A/sKNgcNUKJYwbc7E4YvMczli5vOauAXEVY1hyER2NUBo7YL/FHVTCcTp16c0oG9ZRTgfzmZL2YoB3aY5OYHZTLQSVgJOrSsBUuyMNdYukTl6AKj19xvbvNGs3LNWwRKRGLTMsSqzQuzWKNFOB3CpiAncWsB4ohAOv+UoH8iI+TjCuZVp1h5r2cvIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKXCCScAfAFPF5gwM9xcUjl8gshll9V0AVUzoLvrVaY=;
 b=DXbgHKYLLA3QuJnP4bvsp6D9VvrS2N9AAGANuNgQ1+dVDCp01yA3SF8s98/js2YnZAOk4BZX/+hJ6ST2ESMrC+kYFj9uJrG5sXWlFzR/fpHsSPftH3WbHHGt6R2kHn4+LEWMb9s4KJpL7DH+Ec+XKp3UTzGSMsEMcwxQaUwNUpw=
Received: from BY5PR15MB3636.namprd15.prod.outlook.com (52.133.252.91) by
 BY5PR15MB3522.namprd15.prod.outlook.com (10.255.245.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 18:02:58 +0000
Received: from BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b]) by BY5PR15MB3636.namprd15.prod.outlook.com
 ([fe80::71db:9d2a:500c:d92b%4]) with mapi id 15.20.2430.027; Thu, 14 Nov 2019
 18:02:58 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     Asmaa Mnebhi <asmaa@mellanox.com>,
        "minyard@acm.org" <minyard@acm.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cminyard@mvista.com" <cminyard@mvista.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        Sai Dasari <sdasari@fb.com>
Subject: Re: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Topic: [PATCH v4] drivers: ipmi: Support raw i2c packet in IPMB
Thread-Index: AQHVmnw2JTo54xh3Oky71cdINa8VKqeKtZqAgAADIAD//7eugA==
Date:   Thu, 14 Nov 2019 18:02:58 +0000
Message-ID: <953CA2BD-8FE4-442B-8A6C-6A518E46FC55@fb.com>
References: <20191113234133.3790374-1-vijaykhemka@fb.com>
 <20191114141037.GP2882@minyard.net>
 <DB6PR0501MB27121BF4E680F14A119232B4DA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
In-Reply-To: <DB6PR0501MB27121BF4E680F14A119232B4DA710@DB6PR0501MB2712.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::2860]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42a932f7-f17d-47aa-f18b-08d7692ce1db
x-ms-traffictypediagnostic: BY5PR15MB3522:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3522E0209F724C5801A51B6ADD710@BY5PR15MB3522.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(396003)(376002)(136003)(39860400002)(13464003)(189003)(199004)(54906003)(8936002)(4326008)(76116006)(81166006)(33656002)(7736002)(81156014)(305945005)(229853002)(6116002)(36756003)(6486002)(6246003)(2906002)(6436002)(8676002)(6512007)(66946007)(478600001)(66446008)(64756008)(66556008)(11346002)(110136005)(99286004)(316002)(14444005)(256004)(5660300002)(25786009)(446003)(102836004)(6506007)(46003)(71190400001)(86362001)(76176011)(53546011)(486006)(2501003)(186003)(2616005)(14454004)(71200400001)(476003)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BY5PR15MB3522;H:BY5PR15MB3636.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjKMi4p4ny4zXBN2eCnvwe5FfwqRhN0A31Xt0Fa/nCDWK+N0hfd4MqhogOm3DUMcyv0whscN1riqB4oyYKkQbN8bpdpVKXrkvPxbdzGefuVbp5uMiM17KjFKAYeo+1TUqDztd8UVvdusYmZsi6/zcOelgQQxyNP40+0kdlRMDTzP4HwA6iSh/Nw/tj2W9+7+f9kmojDmB2l4TI2HtNL/SmB3Hx2KoRu1Abyrt/hEVJQ1J+EJ2CwI0OV/JtwaoqVG2ybbdQQaSBe1JmF+MR2LKmDUb6xKUUVxcpUkNoLOYAQXyP6SfqKtmksvTnJh6pXe3lJOmy7ZCtrhMgKvNgg7TLPos0NSG6W0HROlDH9zuGuFO89QfFKCq3jg2+oD6o+FiG89qcEZnWjhMf00L8tcxIlROp6r3FRtbQdBwxBIHs62i2mzcg38qIaMqm0MXv8Y
Content-Type: text/plain; charset="utf-8"
Content-ID: <5FE6460DA4F744419BF4768A0C8A98C3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a932f7-f17d-47aa-f18b-08d7692ce1db
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 18:02:58.3300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3e4K4f7/u/NsIPpa/kZmDONgONB8VaqmzfHW3FVt8vSK8keaeXTZ7pQ1WnbpkG6s2BYx5iMA30tQ5atRt7x+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3522
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_05:2019-11-14,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911140155
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzIEFzbWFhLCBUaGF0IHdhcyBhbHJlYWR5IGluIG15IHBsYW4uIERvIHlvdSB3YW50IHRvIGlu
Y2x1ZGUgaXQgaW4gdGhlIHNhbWUgcGF0Y2ggb3Igc2VwYXJhdGUgcGF0Y2guDQoNCu+7v09uIDEx
LzE0LzE5LCA2OjIxIEFNLCAiQXNtYWEgTW5lYmhpIiA8YXNtYWFAbWVsbGFub3guY29tPiB3cm90
ZToNCg0KICAgIFZpamF5LCBjb3VsZCB5b3UgdXBkYXRlIHRoZSBleGlzdGluZyBpcG1iIGRvY3Vt
ZW50YXRpb24gdG8gbGlzdCBhbmQgZGVzY3JpYmUgdGhpcyBuZXcgZGV2aWNlIHRyZWUvYWNwaSB2
YXJpYWJsZSBpMmMtcHJvdG9jb2wuDQogICAgDQogICAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCiAgICBGcm9tOiBDb3JleSBNaW55YXJkIDx0Y21pbnlhcmRAZ21haWwuY29tPiBPbiBCZWhh
bGYgT2YgQ29yZXkgTWlueWFyZA0KICAgIFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxNCwgMjAx
OSA5OjExIEFNDQogICAgVG86IFZpamF5IEtoZW1rYSA8dmlqYXlraGVta2FAZmIuY29tPg0KICAg
IENjOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IG9wZW5pcG1pLWRldmVsb3BlckBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQ7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGNtaW55YXJkQG12aXN0
YS5jb207IEFzbWFhIE1uZWJoaSA8QXNtYWFAbWVsbGFub3guY29tPjsgam9lbEBqbXMuaWQuYXU7
IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBzZGFzYXJpQGZiLmNvbQ0KICAgIFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjRdIGRyaXZlcnM6IGlwbWk6IFN1cHBvcnQgcmF3IGkyYyBwYWNrZXQg
aW4gSVBNQg0KICAgIA0KICAgIE9uIFdlZCwgTm92IDEzLCAyMDE5IGF0IDAzOjQxOjMzUE0gLTA4
MDAsIFZpamF5IEtoZW1rYSB3cm90ZToNCiAgICA+IE1hbnkgSVBNQiBkZXZpY2VzIGRvZXNuJ3Qg
c3VwcG9ydCBzbWJ1cyBwcm90b2NvbCBhbmQgY3VycmVudCBkcml2ZXIgDQogICAgPiBzdXBwb3J0
IG9ubHkgc21idXMgZGV2aWNlcy4gQWRkZWQgc3VwcG9ydCBmb3IgcmF3IGkyYyBwYWNrZXRzLg0K
ICAgID4gDQogICAgPiBVc2VyIGNhbiBkZWZpbmUgaTJjLXByb3RvY29sIGluIGRldmljZSB0cmVl
IHRvIHVzZSBpMmMgcmF3IHRyYW5zZmVyLg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBW
aWpheSBLaGVta2EgPHZpamF5a2hlbWthQGZiLmNvbT4NCiAgICANCiAgICBXaXRoIEFhc21hJ3Mg
cmVzcG9uc2UsIEkgYW0gb2sgd2l0aCB0aGlzLg0KICAgIA0KICAgIE9uZSB0aGluZywgdGhvdWdo
LiAgVGhpcyBpcyB0aGUgc2xhdmUgZGV2aWNlIG9uIHRoZSBJMkMsIG5vdCB0aGUgbWFzdGVyIGRl
dmljZSB0aGF0IGhhcyB0aGUgaXNzdWUsIHJpZ2h0PyAgU28gaXQncyBhdCBsZWFzdCB0aGVvcmV0
aWNhbGx5IHBvc3NpYmxlIHRvIGhhdmUgb25lIFNNQnVzIGFuZCBvbmUgSTJDIElQTUIgZGV2aWNl
IG9uIHRoZSBzYW1lIG1hc3RlciwgcmlnaHQ/DQogICAgDQogICAgRm9yIG5vcm1hbCBJMkMsIGRl
dmljZXMgYXJlIGluIHRoZSBkZXZpY2UgdHJlZSBhbmQgZ2V0IGFkZGVkIHRvIHRoZSBrZXJuZWwg
ZGV2aWNlIGhhbmRsaW5nLiAgSXQgbG9va3MgbGlrZSB0aGF0IGlzIG5vdCBiZWluZyBkb25lIGlu
IHlvdXIgY2FzZS4gIEJ1dCByZWFsbHksIHRoZSAicmlnaHQiIHdheSB0byBkbyB0aGlzIGlzIHRv
IGhhdmUgdGhlIElQTUIgc2xhdmVzIGFkZGVkIGFzIExpbnV4IGRldmljZXMgYW5kIGFkZHJlc3Mg
dGhlbSB0aGF0IHdheS4gIEknbSBub3Qgc3VyZSB0aGlzIHdpbGwgZXZlciBiZSBhIHJlYWwgaXNz
dWUsIGJ1dCBpZiBpdCBpcywgdGhlcmUgd2lsbCBiZSBzb21lIHdvcmsgdG8gZG8gdG8gZml4IGl0
Lg0KICAgIA0KICAgIC1jb3JleQ0KICAgIA0KICAgID4gLS0tDQogICAgPiAgZHJpdmVycy9jaGFy
L2lwbWkvaXBtYl9kZXZfaW50LmMgfCAzMiANCiAgICA+ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKykNCiAgICA+
IA0KICAgID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci9pcG1pL2lwbWJfZGV2X2ludC5jIA0K
ICAgID4gYi9kcml2ZXJzL2NoYXIvaXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gaW5kZXggYWUz
YmZiYTI3NTI2Li4xMDkwNGJlYzFkZTAgMTAwNjQ0DQogICAgPiAtLS0gYS9kcml2ZXJzL2NoYXIv
aXBtaS9pcG1iX2Rldl9pbnQuYw0KICAgID4gKysrIGIvZHJpdmVycy9jaGFyL2lwbWkvaXBtYl9k
ZXZfaW50LmMNCiAgICA+IEBAIC02Myw2ICs2Myw3IEBAIHN0cnVjdCBpcG1iX2RldiB7DQogICAg
PiAgCXNwaW5sb2NrX3QgbG9jazsNCiAgICA+ICAJd2FpdF9xdWV1ZV9oZWFkX3Qgd2FpdF9xdWV1
ZTsNCiAgICA+ICAJc3RydWN0IG11dGV4IGZpbGVfbXV0ZXg7DQogICAgPiArCWJvb2wgaXNfaTJj
X3Byb3RvY29sOw0KICAgID4gIH07DQogICAgPiAgDQogICAgPiAgc3RhdGljIGlubGluZSBzdHJ1
Y3QgaXBtYl9kZXYgKnRvX2lwbWJfZGV2KHN0cnVjdCBmaWxlICpmaWxlKSBAQCANCiAgICA+IC0x
MTIsNiArMTEzLDI1IEBAIHN0YXRpYyBzc2l6ZV90IGlwbWJfcmVhZChzdHJ1Y3QgZmlsZSAqZmls
ZSwgY2hhciBfX3VzZXIgKmJ1Ziwgc2l6ZV90IGNvdW50LA0KICAgID4gIAlyZXR1cm4gcmV0IDwg
MCA/IHJldCA6IGNvdW50Ow0KICAgID4gIH0NCiAgICA+ICANCiAgICA+ICtzdGF0aWMgaW50IGlw
bWJfaTJjX3dyaXRlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHU4ICptc2cpIHsNCiAgICA+
ICsJc3RydWN0IGkyY19tc2cgaTJjX21zZzsNCiAgICA+ICsNCiAgICA+ICsJLyoNCiAgICA+ICsJ
ICogc3VidHJhY3QgMSBieXRlIChycV9zYSkgZnJvbSB0aGUgbGVuZ3RoIG9mIHRoZSBtc2cgcGFz
c2VkIHRvDQogICAgPiArCSAqIHJhdyBpMmNfdHJhbnNmZXINCiAgICA+ICsJICovDQogICAgPiAr
CWkyY19tc2cubGVuID0gbXNnW0lQTUJfTVNHX0xFTl9JRFhdIC0gMTsNCiAgICA+ICsNCiAgICA+
ICsJLyogQXNzaWduIG1lc3NhZ2UgdG8gYnVmZmVyIGV4Y2VwdCBmaXJzdCAyIGJ5dGVzIChsZW5n
dGggYW5kIGFkZHJlc3MpICovDQogICAgPiArCWkyY19tc2cuYnVmID0gbXNnICsgMjsNCiAgICA+
ICsNCiAgICA+ICsJaTJjX21zZy5hZGRyID0gR0VUXzdCSVRfQUREUihtc2dbUlFfU0FfOEJJVF9J
RFhdKTsNCiAgICA+ICsJaTJjX21zZy5mbGFncyA9IGNsaWVudC0+ZmxhZ3MgJiBJMkNfQ0xJRU5U
X1BFQzsNCiAgICA+ICsNCiAgICA+ICsJcmV0dXJuIGkyY190cmFuc2ZlcihjbGllbnQtPmFkYXB0
ZXIsICZpMmNfbXNnLCAxKTsgfQ0KICAgID4gKw0KICAgID4gIHN0YXRpYyBzc2l6ZV90IGlwbWJf
d3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNoYXIgX191c2VyICpidWYsDQogICAgPiAg
CQkJc2l6ZV90IGNvdW50LCBsb2ZmX3QgKnBwb3MpDQogICAgPiAgew0KICAgID4gQEAgLTEzMyw2
ICsxNTMsMTIgQEAgc3RhdGljIHNzaXplX3QgaXBtYl93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y29uc3QgY2hhciBfX3VzZXIgKmJ1ZiwNCiAgICA+ICAJcnFfc2EgPSBHRVRfN0JJVF9BRERSKG1z
Z1tSUV9TQV84QklUX0lEWF0pOw0KICAgID4gIAluZXRmX3JxX2x1biA9IG1zZ1tORVRGTl9MVU5f
SURYXTsNCiAgICA+ICANCiAgICA+ICsJLyogQ2hlY2sgaTJjIGJsb2NrIHRyYW5zZmVyIHZzIHNt
YnVzICovDQogICAgPiArCWlmIChpcG1iX2Rldi0+aXNfaTJjX3Byb3RvY29sKSB7DQogICAgPiAr
CQlyZXQgPSBpcG1iX2kyY193cml0ZShpcG1iX2Rldi0+Y2xpZW50LCBtc2cpOw0KICAgID4gKwkJ
cmV0dXJuIChyZXQgPT0gMSkgPyBjb3VudCA6IHJldDsNCiAgICA+ICsJfQ0KICAgID4gKw0KICAg
ID4gIAkvKg0KICAgID4gIAkgKiBzdWJ0cmFjdCBycV9zYSBhbmQgbmV0Zl9ycV9sdW4gZnJvbSB0
aGUgbGVuZ3RoIG9mIHRoZSBtc2cgcGFzc2VkIHRvDQogICAgPiAgCSAqIGkyY19zbWJ1c194ZmVy
DQogICAgPiBAQCAtMjc3LDYgKzMwMyw3IEBAIHN0YXRpYyBpbnQgaXBtYl9wcm9iZShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50LA0KICAgID4gIAkJCWNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lk
ICppZCkNCiAgICA+ICB7DQogICAgPiAgCXN0cnVjdCBpcG1iX2RldiAqaXBtYl9kZXY7DQogICAg
PiArCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7DQogICAgPiAgCWludCByZXQ7DQogICAgPiAgDQog
ICAgPiAgCWlwbWJfZGV2ID0gZGV2bV9remFsbG9jKCZjbGllbnQtPmRldiwgc2l6ZW9mKCppcG1i
X2RldiksIEBAIC0zMDIsNiANCiAgICA+ICszMjksMTEgQEAgc3RhdGljIGludCBpcG1iX3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsDQogICAgPiAgCWlmIChyZXQpDQogICAgPiAgCQly
ZXR1cm4gcmV0Ow0KICAgID4gIA0KICAgID4gKwkvKiBDaGVjayBpZiBpMmMgYmxvY2sgeG1pdCBu
ZWVkcyB0byB1c2UgaW5zdGVhZCBvZiBzbWJ1cyAqLw0KICAgID4gKwlucCA9IGNsaWVudC0+ZGV2
Lm9mX25vZGU7DQogICAgPiArCWlmIChucCAmJiBvZl9nZXRfcHJvcGVydHkobnAsICJpMmMtcHJv
dG9jb2wiLCBOVUxMKSkNCiAgICA+ICsJCWlwbWJfZGV2LT5pc19pMmNfcHJvdG9jb2wgPSB0cnVl
Ow0KICAgID4gKw0KICAgID4gIAlpcG1iX2Rldi0+Y2xpZW50ID0gY2xpZW50Ow0KICAgID4gIAlp
MmNfc2V0X2NsaWVudGRhdGEoY2xpZW50LCBpcG1iX2Rldik7DQogICAgPiAgCXJldCA9IGkyY19z
bGF2ZV9yZWdpc3RlcihjbGllbnQsIGlwbWJfc2xhdmVfY2IpOw0KICAgID4gLS0NCiAgICA+IDIu
MTcuMQ0KICAgID4gDQogICAgDQoNCg==
