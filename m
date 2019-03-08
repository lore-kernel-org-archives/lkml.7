Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52F820684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 05:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="pTDk6cZc";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="RL8LAP43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHFqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 00:46:45 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44134 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbfCHFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 00:46:45 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x285htZN027795;
        Thu, 7 Mar 2019 21:45:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+0y3TgGs/lWZiphOA0VzlF57PwFOSS0X4EkL+S96VoA=;
 b=pTDk6cZcUC8N57PkSHLQE8+9j9asEphw40KL7B+T3iii8JOUQxQfaajQHod2ngxUvE1N
 VZedzoG4jX0zLefdE6jGTOy2B6JX/nYOxDgwxBc8UJPlh2mZ4NCyLMjRxLBhBULTqnp5
 4DUw4U01OZVpQVeIbZIZcEg7OAc+i8AzgMg= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r3hku0480-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 07 Mar 2019 21:45:31 -0800
Received: from frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 21:44:59 -0800
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx05.TheFacebook.com (2620:10d:c0a1:f82::29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 7 Mar 2019 21:44:58 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 7 Mar 2019 21:44:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0y3TgGs/lWZiphOA0VzlF57PwFOSS0X4EkL+S96VoA=;
 b=RL8LAP43MYt9KWaOPHXz4Gj0wpgHLtoEg6ahLwckFujuQJIVIzOg9IgDbmSNgCYSMOz5bUmSC/p73l9tegC9zFud9gPw8YGLl7+HK2Dn2Z//aj2Bo20AY4CEGjDg418iovQW6/VyUTURxqG7yElXzKCK5Jt1gfaMlfbYUp4NRVU=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2229.namprd15.prod.outlook.com (52.135.196.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 05:44:56 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d051:e43:9e14:b94%4]) with mapi id 15.20.1686.019; Fri, 8 Mar 2019
 05:44:56 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Bo YU <tsu.yubo@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>,
        "ongliubraving@fb.com" <ongliubraving@fb.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yuzibode@126.com" <yuzibode@126.com>
Subject: Re: [PATCH] bpf: fix warning about using plain integer as NULL
Thread-Topic: [PATCH] bpf: fix warning about using plain integer as NULL
Thread-Index: AQHU1WkT5TsNqaTcYkC9CvQ4/Ljy+KYBOUcA
Date:   Fri, 8 Mar 2019 05:44:56 +0000
Message-ID: <ffd0ded7-77b3-f0fc-920d-365510d00e6c@fb.com>
References: <20190308043956.16906-1-tsu.yubo@gmail.com>
In-Reply-To: <20190308043956.16906-1-tsu.yubo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::d0f4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0054d745-df4f-49f8-f094-08d6a3893201
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2229;
x-ms-traffictypediagnostic: BYAPR15MB2229:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2229;20:fNasWSTfhZ5/CB7XPmbvUFDyJ6ER379YNMH1eA6IFgV161KUqNo2T1Ls5V+3BA518on2YPTuZPOEg9WCrGfS9FxMly7Uf7VmLOXsGt1L5IvVFDmZZrno75YnlilIo11GP6HhK31XETMxiYMvk60GRf3J9xVo8+6jjpWW3g9E3Rk=
x-microsoft-antispam-prvs: <BYAPR15MB2229D07D153B3E124988F94AD34D0@BYAPR15MB2229.namprd15.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(2201001)(8676002)(229853002)(86362001)(81156014)(81166006)(31696002)(2501003)(105586002)(106356001)(486006)(476003)(446003)(11346002)(2616005)(46003)(68736007)(305945005)(31686004)(7736002)(478600001)(14444005)(256004)(14454004)(5660300002)(97736004)(6246003)(102836004)(53546011)(386003)(6506007)(36756003)(6436002)(316002)(53936002)(71200400001)(71190400001)(6116002)(6512007)(99286004)(8936002)(52116002)(54906003)(25786009)(2906002)(76176011)(110136005)(6486002)(4326008)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2229;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DgNlTdx103ceoyUnIuqMsh509LDcgwovoIp61gOiKyqSZ1muIr2aNwOTNa/1YcfAC/mI4kiVpex9TnhIs6uVnOKbbLczg8rc1cHLiH8PBEjQd87A/hWw1OBwoWv42A7Ewfwgt78/D6qxl2JY6LoOpOsTdqLqYd3HdVZ1OwLXtqrwVTcLqLjVWDQay1iqw3DAB6htrfv5t8Snmr2q5xHrm8eQG+eUcB2OvUrAewDSs4ZMYay3Tz9+60zBpHtKcSIJGrCrNTNL3QoeQhtd0xVr3a3fbqXQ6u7jtbDBR+2pyY6S8OvIPVsG+tFq0zzQdiDqaXLDZLW+PISe0NCtqCihcSPYvLbEEgk5Qy3ZGYfWRqFhJG+xufpkEv52czM1Ue+jZZMrZ3vN0+Rz2Lb9qBDT0p8bqJQZPun95UoxOBVG/00=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C3E59C18CBF0194CBEE8906233FD2F9A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0054d745-df4f-49f8-f094-08d6a3893201
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 05:44:56.6760
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2229
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvNy8xOSA4OjM5IFBNLCBCbyBZVSB3cm90ZToNCj4gU3BhcnNlIHdhcm5pbmcgYmVs
b3c6DQo+IA0KPiBzdWRvIG1ha2UgQz0yIENGPS1EX19DSEVDS19FTkRJQU5fXyBNPW5ldC9icGYv
DQo+IENIRUNLICAgbmV0L2JwZi8vdGVzdF9ydW4uYw0KPiBuZXQvYnBmLy90ZXN0X3J1bi5jOjE5
Ojc3OiB3YXJuaW5nOiBVc2luZyBwbGFpbiBpbnRlZ2VyIGFzIE5VTEwgcG9pbnRlcg0KPiAuL2lu
Y2x1ZGUvbGludXgvYnBmLWNncm91cC5oOjI5NTo3Nzogd2FybmluZzogVXNpbmcgcGxhaW4gaW50
ZWdlciBhcyBOVUxMIHBvaW50ZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJvIFlVIDx0c3UueXVi
b0BnbWFpbC5jb20+DQoNCkNvdWxkIHlvdSBhZGQgcHJvcGVyIGZpeGVzIGxpa2UgYmVsb3c6DQpG
aXhlczogOGJhZDc0Zjk4NDBmICgiYnBmOiBleHRlbmQgY2dyb3VwIGJwZiBjb3JlIHRvIGFsbG93
IG11bHRpcGxlIA0KY2dyb3VwIHN0b3JhZ2UgdHlwZXMiKQ0KDQpXaXRoIHRoYXQsDQpBY2tlZC1i
eTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4
L2JwZi1jZ3JvdXAuaCB8IDIgKy0NCj4gICBuZXQvYnBmL3Rlc3RfcnVuLmMgICAgICAgICB8IDIg
Ky0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaCBiL2luY2x1ZGUv
bGludXgvYnBmLWNncm91cC5oDQo+IGluZGV4IDY5NWIyYTg4MGQ5YS4uYTRjNjQ0YzFjMDkxIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2JwZi1jZ3JvdXAuaA0KPiArKysgYi9pbmNsdWRl
L2xpbnV4L2JwZi1jZ3JvdXAuaA0KPiBAQCAtMjkyLDcgKzI5Miw3IEBAIHN0YXRpYyBpbmxpbmUg
aW50IGJwZl9jZ3JvdXBfc3RvcmFnZV9hc3NpZ24oc3RydWN0IGJwZl9wcm9nICpwcm9nLA0KPiAg
IHN0YXRpYyBpbmxpbmUgdm9pZCBicGZfY2dyb3VwX3N0b3JhZ2VfcmVsZWFzZShzdHJ1Y3QgYnBm
X3Byb2cgKnByb2csDQo+ICAgCQkJCQkgICAgICBzdHJ1Y3QgYnBmX21hcCAqbWFwKSB7fQ0KPiAg
IHN0YXRpYyBpbmxpbmUgc3RydWN0IGJwZl9jZ3JvdXBfc3RvcmFnZSAqYnBmX2Nncm91cF9zdG9y
YWdlX2FsbG9jKA0KPiAtCXN0cnVjdCBicGZfcHJvZyAqcHJvZywgZW51bSBicGZfY2dyb3VwX3N0
b3JhZ2VfdHlwZSBzdHlwZSkgeyByZXR1cm4gMDsgfQ0KPiArCXN0cnVjdCBicGZfcHJvZyAqcHJv
ZywgZW51bSBicGZfY2dyb3VwX3N0b3JhZ2VfdHlwZSBzdHlwZSkgeyByZXR1cm4gTlVMTDsgfQ0K
PiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBicGZfY2dyb3VwX3N0b3JhZ2VfZnJlZSgNCj4gICAJc3Ry
dWN0IGJwZl9jZ3JvdXBfc3RvcmFnZSAqc3RvcmFnZSkge30NCj4gICBzdGF0aWMgaW5saW5lIGlu
dCBicGZfcGVyY3B1X2Nncm91cF9zdG9yYWdlX2NvcHkoc3RydWN0IGJwZl9tYXAgKm1hcCwgdm9p
ZCAqa2V5LA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2JwZi90ZXN0X3J1bi5jIGIvbmV0L2JwZi90ZXN0
X3J1bi5jDQo+IGluZGV4IGRhNzA1MWQ2MjcyNy4uZmFiMTQyYjc5NmVmIDEwMDY0NA0KPiAtLS0g
YS9uZXQvYnBmL3Rlc3RfcnVuLmMNCj4gKysrIGIvbmV0L2JwZi90ZXN0X3J1bi5jDQo+IEBAIC0x
Niw3ICsxNiw3IEBADQo+ICAgc3RhdGljIGludCBicGZfdGVzdF9ydW4oc3RydWN0IGJwZl9wcm9n
ICpwcm9nLCB2b2lkICpjdHgsIHUzMiByZXBlYXQsDQo+ICAgCQkJdTMyICpyZXR2YWwsIHUzMiAq
dGltZSkNCj4gICB7DQo+IC0Jc3RydWN0IGJwZl9jZ3JvdXBfc3RvcmFnZSAqc3RvcmFnZVtNQVhf
QlBGX0NHUk9VUF9TVE9SQUdFX1RZUEVdID0geyAwIH07DQo+ICsJc3RydWN0IGJwZl9jZ3JvdXBf
c3RvcmFnZSAqc3RvcmFnZVtNQVhfQlBGX0NHUk9VUF9TVE9SQUdFX1RZUEVdID0geyBOVUxMIH07
DQo+ICAgCWVudW0gYnBmX2Nncm91cF9zdG9yYWdlX3R5cGUgc3R5cGU7DQo+ICAgCXU2NCB0aW1l
X3N0YXJ0LCB0aW1lX3NwZW50ID0gMDsNCj4gICAJaW50IHJldCA9IDA7DQo+IA0K
