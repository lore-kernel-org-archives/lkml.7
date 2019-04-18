Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308A2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E272083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 05:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NfKfuqtk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="dFXXibj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfDRFKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 01:10:22 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46388 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbfDRFKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 01:10:22 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3I58Qsi006991;
        Wed, 17 Apr 2019 22:09:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LCdLkHnIv8RBloVLt3O3UNqpMBuBPyb5TJpzjduNL2g=;
 b=NfKfuqtkLUWGtdC3ar5VaA0QMWhzWKqxFZdwwE4mWrH8e4vp+l7MHUPCukBkuR+C5hJz
 ditoZfZxrtwQCKLGsBebopxzOQ/jQU+j+yWDHU+TJE5sFmiasyhhvffB5KDaP49UN2rh
 ojK7VwsrWeg1DuzoCTBCH5L/aRTEzC+vFvo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rx0t2upga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Apr 2019 22:09:57 -0700
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 22:09:56 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 17 Apr 2019 22:09:55 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 17 Apr 2019 22:09:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCdLkHnIv8RBloVLt3O3UNqpMBuBPyb5TJpzjduNL2g=;
 b=dFXXibj45X29ufOWB4V1hqZSkmuApIjF24HDnD3NjCrlXHSLfh0HnydFm5cgUB4nC7E7bjK9fkNa23KuLkh7fVCXBB4uISi3ZFeICq4ha+Qv64p/8TTWyFxGPudEDEuxNn4Y91iqo0RPV/8GSa/M9r/2tSW9uuaortJqT//qESM=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB3366.namprd15.prod.outlook.com (20.179.58.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Thu, 18 Apr 2019 05:09:53 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::750c:2d8e:bf62:4d0d%5]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 05:09:53 +0000
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
Thread-Index: AQHU9UaFFkKU6i/cyUuyOavKVHyDo6ZBX1eA
Date:   Thu, 18 Apr 2019 05:09:53 +0000
Message-ID: <ecd56ebd-d19f-8834-9373-088ad7c9a725@fb.com>
References: <20190417174839.GA16679@udknight>
In-Reply-To: <20190417174839.GA16679@udknight>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0014.namprd14.prod.outlook.com
 (2603:10b6:301:4b::24) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::c88a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f5ae03a-0fbf-4163-65a5-08d6c3bc1766
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB3366;
x-ms-traffictypediagnostic: BYAPR15MB3366:
x-microsoft-antispam-prvs: <BYAPR15MB3366269FE1D9D6CE2DFC1605D3260@BYAPR15MB3366.namprd15.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(81156014)(53936002)(81166006)(53546011)(102836004)(486006)(36756003)(6116002)(71200400001)(52116002)(99286004)(5660300002)(386003)(8936002)(2906002)(6506007)(2201001)(8676002)(14454004)(97736004)(76176011)(478600001)(446003)(6246003)(476003)(31696002)(31686004)(2501003)(6512007)(86362001)(71190400001)(186003)(2616005)(229853002)(46003)(25786009)(110136005)(316002)(6436002)(6486002)(11346002)(305945005)(256004)(68736007)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3366;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ww7dycN57xD/0VEmi/wnfb1bnoPT5v/JUASqlnpv41vC+MvPVJdTxxzIMKwHOkaaRLSCb7ja19+toRbkoJ0OJii/Sg7364Y/cYhXMWnMGW2zgA4ImLPBk+IOhheTIrGn51eslQwgqXJMGgf3uecuS+mqnZmxXoFs5W+D/N3Fxt4+mSFRIfzRCeKbF39huOPe2kgEXtUg5Gs5lvJyFP15QlBgEhz/qABNnaNQ686b+EyoFaDiyTSmGKUStw0wlQl9ZRFEj27FASSz+T7/W4YDg0E2AZ7GBrj58AIeDfGR8Rx5QezTTXLV4zwkq47u9hbmSQob863j2Mg7Qx6ChSzD2QHXvNaI9hOXQYgwoxtW+fbNMhkjnIQvbvdPDjulmjb/ZUa+DFcBmI0jdWnc8Xt9ePhdCG4prEhC4jOV1E3alek=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31D27EBE8FE5D744A3948E8D66C05C53@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5ae03a-0fbf-4163-65a5-08d6c3bc1766
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 05:09:53.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3366
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-18_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDQvMTcvMTkgMTA6NDggQU0sIFdhbmcgWWFuUWluZyB3cm90ZToNCj4gVGhlIG9sZGVy
IGdsaWJjIChmb3IgZXhhbXBsZSwgMi4yMykgZG9lc24ndCBoYW5kbGUgX19VQVBJX0RFRl8qDQo+
IGluIGxpYmMtY29tcGF0LmggcHJvcGVybHksIGFuZCBpdCBicmluZyBiZWxvdyBjb21waWxlIGVy
cm9yczoNCg0KSSBoYXZlIGFuIGV2ZW4gb2xkIGdsaWJjIDIuMTcgYW5kIGl0IHN0aWxsIHdvcmtz
LiBOb3Qgc3VyZQ0Kd2h5IGl0IGZhaWxlZCBoZXJlLiBDb3VsZCB5b3UgZXhwbGFpbiBtb3JlPw0K
DQpCdXQgSSBhcHBsaWVkIHRoZSBjaGFuZ2UsIGl0IHN0aWxsIHdvcmtzIHdpdGggMi4xNyBnbGli
YyBhbmQgZ2NjIDQuOC41Lg0KU28gY2hhbmdlIHByb2JhYmx5IHNhZmUuDQoNCj4gIg0KPiBJbiBm
aWxlIGluY2x1ZGVkIGZyb20gdGVzdF90Y3Bub3RpZnlfa2Vybi5jOjEyOg0KPiAvdXNyL2luY2x1
ZGUvbmV0aW5ldC9pbi5oOjEwMTo1OiBlcnJvcjogZXhwZWN0ZWQgaWRlbnRpZmllcg0KPiAgICAg
IElQUFJPVE9fSE9QT1BUUyA9IDAsICAgLyogSVB2NiBIb3AtYnktSG9wIG9wdGlvbnMuICAqLw0K
PiAgICAgIF4NCj4gL3Vzci9pbmNsdWRlL2xpbnV4L2luNi5oOjEzMToyNjogbm90ZTogZXhwYW5k
ZWQgZnJvbSBtYWNybyAnSVBQUk9UT19IT1BPUFRTJw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSB0ZXN0X3RjcG5vdGlmeV9rZXJu
LmM6MTI6DQo+IC91c3IvaW5jbHVkZS9uZXRpbmV0L2luLmg6MTAzOjU6IGVycm9yOiBleHBlY3Rl
ZCBpZGVudGlmaWVyDQo+ICAgICAgSVBQUk9UT19ST1VUSU5HID0gNDMsICAvKiBJUHY2IHJvdXRp
bmcgaGVhZGVyLiAgKi8NCj4gICAgICBeDQo+IC91c3IvaW5jbHVkZS9saW51eC9pbjYuaDoxMzI6
MjY6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ0lQUFJPVE9fUk9VVElORycNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gdGVz
dF90Y3Bub3RpZnlfa2Vybi5jOjEyOg0KPiAvdXNyL2luY2x1ZGUvbmV0aW5ldC9pbi5oOjEwNTo1
OiBlcnJvcjogZXhwZWN0ZWQgaWRlbnRpZmllcg0KPiAgICAgIElQUFJPVE9fRlJBR01FTlQgPSA0
NCwgLyogSVB2NiBmcmFnbWVudGF0aW9uIGhlYWRlci4gICovDQo+ICAgICAgXg0KPiAvdXNyL2lu
Y2x1ZGUvbGludXgvaW42Lmg6MTMzOjI2OiBub3RlOiBleHBhbmRlZCBmcm9tIG1hY3JvICdJUFBS
T1RPX0ZSQUdNRU5UJw0KPiAiDQo+IFRoZSBzYW1lIGNvbXBpbGUgZXJyb3JzIGFyZSByZXBvcnRl
ZCBmb3IgdGVzdF90Y3BicGZfa2Vybi5jIHRvby4NCj4gDQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhl
IGNvbXBpbGUgZXJyb3JzIGJ5IG1vdmluZyA8bmV0aW5ldC9pbi5oPiB0byBiZWZvcmUgdGhlDQo+
IDxsaW51eC8qLmg+Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2FuZyBZYW5RaW5nIDx1ZGtuaWdo
dEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9n
cy90ZXN0X3RjcGJwZl9rZXJuLmMgICAgfCAyICstDQo+ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvYnBmL3Byb2dzL3Rlc3RfdGNwbm90aWZ5X2tlcm4uYyB8IDIgKy0NCj4gICAyIGZpbGVzIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3BicGZfa2Vybi5jIGIv
dG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfdGNwYnBmX2tlcm4uYw0KPiBp
bmRleCA3NGY3M2IzLi5jN2MzMjQwIDEwMDY0NA0KPiAtLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3BicGZfa2Vybi5jDQo+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcGJwZl9rZXJuLmMNCj4gQEAgLTEsNiArMSw3IEBA
DQo+ICAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gICAjaW5jbHVkZSA8
c3RkZGVmLmg+DQo+ICAgI2luY2x1ZGUgPHN0cmluZy5oPg0KPiArI2luY2x1ZGUgPG5ldGluZXQv
aW4uaD4NCj4gICAjaW5jbHVkZSA8bGludXgvYnBmLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2lm
X2V0aGVyLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2lmX3BhY2tldC5oPg0KPiBAQCAtOSw3ICsx
MCw2IEBADQo+ICAgI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L3NvY2tldC5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC90Y3AuaD4NCj4gLSNpbmNsdWRlIDxuZXRp
bmV0L2luLmg+DQo+ICAgI2luY2x1ZGUgImJwZl9oZWxwZXJzLmgiDQo+ICAgI2luY2x1ZGUgImJw
Zl9lbmRpYW4uaCINCj4gICAjaW5jbHVkZSAidGVzdF90Y3BicGYuaCINCj4gZGlmZiAtLWdpdCBh
L3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcG5vdGlmeV9rZXJuLmMg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ3MvdGVzdF90Y3Bub3RpZnlfa2Vybi5j
DQo+IGluZGV4IGVkYmNhMjAuLmVjNmRiNmUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL2JwZi9wcm9ncy90ZXN0X3RjcG5vdGlmeV9rZXJuLmMNCj4gKysrIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvYnBmL3Byb2dzL3Rlc3RfdGNwbm90aWZ5X2tlcm4uYw0KPiBAQCAt
MSw2ICsxLDcgQEANCj4gICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiAg
ICNpbmNsdWRlIDxzdGRkZWYuaD4NCj4gICAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+ICsjaW5jbHVk
ZSA8bmV0aW5ldC9pbi5oPg0KPiAgICNpbmNsdWRlIDxsaW51eC9icGYuaD4NCj4gICAjaW5jbHVk
ZSA8bGludXgvaWZfZXRoZXIuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvaWZfcGFja2V0Lmg+DQo+
IEBAIC05LDcgKzEwLDYgQEANCj4gICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gICAjaW5j
bHVkZSA8bGludXgvc29ja2V0Lmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L3RjcC5oPg0KPiAtI2lu
Y2x1ZGUgPG5ldGluZXQvaW4uaD4NCj4gICAjaW5jbHVkZSAiYnBmX2hlbHBlcnMuaCINCj4gICAj
aW5jbHVkZSAiYnBmX2VuZGlhbi5oIg0KPiAgICNpbmNsdWRlICJ0ZXN0X3RjcG5vdGlmeS5oIg0K
PiANCg==
