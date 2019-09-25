Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CA5C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EDB21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AtPQRCfR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407150AbfIYNyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 09:54:40 -0400
Received: from mail-eopbgr690059.outbound.protection.outlook.com ([40.107.69.59]:5750
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406357AbfIYNyk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 09:54:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5nz8ZfzzHnRVx7NF+kr9iGNt8hR3d3kHEfmCIwiJ9kQiYyUc0vYyHgFjZeDBKEaw+2fvi3tRzzkyf6PDsmFBOiT1IuF9jv2RNkDQYDqIw0w96x23z0NRtzrZS601Lb71BgVllrka9Kb8AdoObm411k6kdUTnXRLWHtlV5Vs9DsI1/+r3b7frAUDRWcvo+llH6WYIuX1zk0tayxRmtbLYM2S5Lx6Q3CiepzhVhYqiimVW1+YW5WyBmBQan//aDYwZf39VHcBBBZny1uSqSGvfFjmu8QcOKotW226D+Tf0RHE+sbzjA9hl9K9T+0hWV6jVwgyfiK7ocNZvrN1MZL5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2ydxTLmPCfFZknRrOCK+3TjktMEaIGlzTykOyA2MjA=;
 b=G1sU/hKgs8wi7iMj5N24xopwUvEhhi6MTQ7Z6R22rxlftzzxM4GgjwQOx8qY0iR7DY6vztNbonGP3j5xYqk7Ja17Q1ieodbhb7NpM3FuZIJ41/06xezjhI9o/KRqK/LVSHPzDWFgDsve0lEK5orG4Iq0HkkrbPeggFj4n2HwOqXGOXP8tDn4mQL2b2/WbrivNTAc9CoM8X7PLfdMbAMEfhrvjPDLHqFBnOJcIADeKh+a0rfAlr8QBJIFSwMohb6QdW0PVauknpZOHxWXophJuyENtgH83whAkyG3xWbk4e58ujAkWuSetHd5oHVEGgnGNcTHyj3eSHv3oFsZfW0DXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2ydxTLmPCfFZknRrOCK+3TjktMEaIGlzTykOyA2MjA=;
 b=AtPQRCfRNTQdUJHSpvGJHg0j23+nCr64ShbvC25DPM0NQyRusRtlx5ccCm1k1PYNRHpHc1oEFpR9v/E4Chhw4nTNuQHB/1CLX3apJ+gJje2LN311q6IF1YA1IGETapq+xceu3UGcd3yfD+AZQj9yLPQIrwDyGCM2PCB+OAuL/Ws=
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com (10.172.79.7) by
 CY4PR1201MB0199.namprd12.prod.outlook.com (10.172.78.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.23; Wed, 25 Sep 2019 13:54:32 +0000
Received: from CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::708e:c826:5b05:e3f0]) by CY4PR1201MB0230.namprd12.prod.outlook.com
 ([fe80::708e:c826:5b05:e3f0%11]) with mapi id 15.20.2284.023; Wed, 25 Sep
 2019 13:54:31 +0000
From:   Harry Wentland <hwentlan@amd.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        "Laktyushkin, Dmytro" <Dmytro.Laktyushkin@amd.com>,
        "Yang, Eric" <Eric.Yang2@amd.com>, "Lei, Jun" <Jun.Lei@amd.com>,
        "Chalmers, Wesley" <Wesley.Chalmers@amd.com>,
        "Francis, David" <David.Francis@amd.com>,
        "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
        Aidan Wood <Aidan.Wood@amd.com>,
        "Chalmers, Kenneth" <Ken.Chalmers@amd.com>,
        "Bernstein, Eric" <Eric.Bernstein@amd.com>,
        "Wu, Hersen" <hersenxs.wu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Li, Roman" <Roman.Li@amd.com>, Wang Hai <wanghai26@huawei.com>,
        Thomas Lim <Thomas.Lim@amd.com>,
        Su Sung Chung <Su.Chung@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: prevent memory leak
Thread-Topic: [PATCH] drm/amd/display: prevent memory leak
Thread-Index: AQHVc1kbvHp61ogjKEqfC8ERTPROwac8aswA
Date:   Wed, 25 Sep 2019 13:54:31 +0000
Message-ID: <5cb6dec0-7f88-5d14-82cb-919f1d190b2f@amd.com>
References: <20190925042407.31383-1-navid.emamdoost@gmail.com>
In-Reply-To: <20190925042407.31383-1-navid.emamdoost@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
x-clientproxiedby: YTOPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::49) To CY4PR1201MB0230.namprd12.prod.outlook.com
 (2603:10b6:910:1e::7)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60252066-1076-43ca-47d5-08d741bfe3e3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR1201MB0199;
x-ms-traffictypediagnostic: CY4PR1201MB0199:|CY4PR1201MB0199:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0199F227888A92E6C61A31A78C870@CY4PR1201MB0199.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(6512007)(6436002)(229853002)(6486002)(6116002)(3846002)(2906002)(5660300002)(81166006)(316002)(54906003)(8676002)(58126008)(36756003)(11346002)(2616005)(476003)(486006)(81156014)(8936002)(446003)(71200400001)(71190400001)(6246003)(305945005)(66946007)(6916009)(66556008)(64756008)(4326008)(66476007)(25786009)(14454004)(31686004)(7736002)(66446008)(256004)(99286004)(52116002)(186003)(386003)(6506007)(53546011)(102836004)(31696002)(26005)(66066001)(65956001)(65806001)(76176011)(7416002)(478600001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0199;H:CY4PR1201MB0230.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k1W5/6/LbhUof5r7DYjyuYhjBTOZ1yvrWw3uDlcaQexKSzbB3DkUzxRnUR/6S8CilxDJeNlcJMx3L9uI4VXldP+iKTHOhFJBJtTTtgPcfDeqCk1dmt/8iMTbcd8gf/e0y6VjJsiBuut+8+QVbfQFUC+DwexNxSNjWieBHWtcEo6PyFk2IMvFhgoJk0Y9dJqre5E8H9Y2iXgzBLvc6fqZhfs7ZIYByChND11ym9XkPUHTsoA32gQkdQpjuxRYp+eKTB0XLlpLIIO2ElGe2RYAu+6cX45Zo5n7izhaS8uLGRcK6iwc8ZuNWnfwfPhPkKPHoqMt/jsf1BbCTwfJo6B834YR7FeQIzgpWPG4zk8G4a2W+44C/PAo5hIBFMF0sRMwRVLYsvulqq8RkdQh8zhaKxDMNAE/1PFRm11BmOaxdho=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CBCF80F33823D4A8737F0CA339E9915@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60252066-1076-43ca-47d5-08d741bfe3e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 13:54:31.6765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzYHcTQSlmtLgP7rAtg2YHEjKwEIxcd0f8Y/p00V7bNjVOxnDSWVxP/+39Afc4e8oRWxld6r2rjlGdJuTCm8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0199
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwMTktMDktMjUgMTI6MjMgYS5tLiwgTmF2aWQgRW1hbWRvb3N0IHdyb3RlOg0KPiBJ
biBkY24qX2NyZWF0ZV9yZXNvdXJjZV9wb29sIHRoZSBhbGxvY2F0ZWQgbWVtb3J5IHNob3VsZCBi
ZSByZWxlYXNlZCBpZg0KPiBjb25zdHJ1Y3QgcG9vbCBmYWlscy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE5hdmlkIEVtYW1kb29zdCA8bmF2aWQuZW1hbWRvb3N0QGdtYWlsLmNvbT4NCg0KUmV2aWV3
ZWQtYnk6IEhhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPg0KDQpIYXJyeQ0K
DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBf
cmVzb3VyY2UuYyB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEx
MC9kY2UxMTBfcmVzb3VyY2UuYyB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYyB8IDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL2Ft
ZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfcmVzb3VyY2UuYyB8IDEgKw0KPiAgZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMgICB8IDEgKw0KPiAg
NSBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYw0KPiBp
bmRleCBhZmM2MTA1NWVjYTEuLjE3ODdiOWJmODAwYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEwMC9kY2UxMDBfcmVzb3VyY2UuYw0KPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTAwL2RjZTEwMF9yZXNvdXJjZS5jDQo+
IEBAIC0xMDkxLDYgKzEwOTEsNyBAQCBzdHJ1Y3QgcmVzb3VyY2VfcG9vbCAqZGNlMTAwX2NyZWF0
ZV9yZXNvdXJjZV9wb29sKA0KPiAgCWlmIChjb25zdHJ1Y3QobnVtX3ZpcnR1YWxfbGlua3MsIGRj
LCBwb29sKSkNCj4gIAkJcmV0dXJuICZwb29sLT5iYXNlOw0KPiAgDQo+ICsJa2ZyZWUocG9vbCk7
DQo+ICAJQlJFQUtfVE9fREVCVUdHRVIoKTsNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEwX3Jl
c291cmNlLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9y
ZXNvdXJjZS5jDQo+IGluZGV4IGM2NmZlMTcwZTFlOC4uMzE4ZTljMmUyY2E4IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTEwL2RjZTExMF9yZXNvdXJj
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY2UxMTAvZGNlMTEw
X3Jlc291cmNlLmMNCj4gQEAgLTE0NjIsNiArMTQ2Miw3IEBAIHN0cnVjdCByZXNvdXJjZV9wb29s
ICpkY2UxMTBfY3JlYXRlX3Jlc291cmNlX3Bvb2woDQo+ICAJaWYgKGNvbnN0cnVjdChudW1fdmly
dHVhbF9saW5rcywgZGMsIHBvb2wsIGFzaWNfaWQpKQ0KPiAgCQlyZXR1cm4gJnBvb2wtPmJhc2U7
DQo+ICANCj4gKwlrZnJlZShwb29sKTsNCj4gIAlCUkVBS19UT19ERUJVR0dFUigpOw0KPiAgCXJl
dHVybiBOVUxMOw0KPiAgfQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNw
bGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9kYy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmMNCj4gaW5kZXggM2FjNGM3ZTczMDUwLi4z
MTk5ZDQ5M2QxM2IgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kY2UxMTIvZGNlMTEyX3Jlc291cmNlLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2RjL2RjZTExMi9kY2UxMTJfcmVzb3VyY2UuYw0KPiBAQCAtMTMzOCw2ICsxMzM4LDcg
QEAgc3RydWN0IHJlc291cmNlX3Bvb2wgKmRjZTExMl9jcmVhdGVfcmVzb3VyY2VfcG9vbCgNCj4g
IAlpZiAoY29uc3RydWN0KG51bV92aXJ0dWFsX2xpbmtzLCBkYywgcG9vbCkpDQo+ICAJCXJldHVy
biAmcG9vbC0+YmFzZTsNCj4gIA0KPiArCWtmcmVlKHBvb2wpOw0KPiAgCUJSRUFLX1RPX0RFQlVH
R0VSKCk7DQo+ICAJcmV0dXJuIE5VTEw7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfcmVzb3VyY2UuYw0KPiBpbmRleCA3
ZDA4MTU0ZTk2NjIuLmJiNDk3ZjQzZjZlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9kaXNwbGF5L2RjL2RjZTEyMC9kY2UxMjBfcmVzb3VyY2UuYw0KPiArKysgYi9kcml2ZXJz
L2dwdS9kcm0vYW1kL2Rpc3BsYXkvZGMvZGNlMTIwL2RjZTEyMF9yZXNvdXJjZS5jDQo+IEBAIC0x
MjAzLDYgKzEyMDMsNyBAQCBzdHJ1Y3QgcmVzb3VyY2VfcG9vbCAqZGNlMTIwX2NyZWF0ZV9yZXNv
dXJjZV9wb29sKA0KPiAgCWlmIChjb25zdHJ1Y3QobnVtX3ZpcnR1YWxfbGlua3MsIGRjLCBwb29s
KSkNCj4gIAkJcmV0dXJuICZwb29sLT5iYXNlOw0KPiAgDQo+ICsJa2ZyZWUocG9vbCk7DQo+ICAJ
QlJFQUtfVE9fREVCVUdHRVIoKTsNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9yZXNvdXJjZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2RjL2RjbjEwL2RjbjEwX3Jlc291cmNlLmMN
Cj4gaW5kZXggNWE4OWU0NjJlN2NjLi41OTMwNWU0MTFhNjYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9yZXNvdXJjZS5jDQo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9kYy9kY24xMC9kY24xMF9yZXNvdXJjZS5jDQo+
IEBAIC0xNTcwLDYgKzE1NzAsNyBAQCBzdHJ1Y3QgcmVzb3VyY2VfcG9vbCAqZGNuMTBfY3JlYXRl
X3Jlc291cmNlX3Bvb2woDQo+ICAJaWYgKGNvbnN0cnVjdChpbml0X2RhdGEtPm51bV92aXJ0dWFs
X2xpbmtzLCBkYywgcG9vbCkpDQo+ICAJCXJldHVybiAmcG9vbC0+YmFzZTsNCj4gIA0KPiArCWtm
cmVlKHBvb2wpOw0KPiAgCUJSRUFLX1RPX0RFQlVHR0VSKCk7DQo+ICAJcmV0dXJuIE5VTEw7DQo+
ICB9DQo+IA0K
