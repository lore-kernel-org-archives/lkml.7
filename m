Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE021C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695932087E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 09:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NtKRA4Jb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbfKFJjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 04:39:02 -0500
Received: from mail-eopbgr790058.outbound.protection.outlook.com ([40.107.79.58]:20458
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKFJjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 04:39:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enpaAyr4uoli17S/HQ9ZsQup3xEWqMx7ssxRk05SP7XrjPgkxnxSXhG169pYM1OHeAKMxxRD8QCJupSyRUJw9abxczfu3oR7lGln4sHNm1PK7TdAChcNQ45fuaHYhKkwlkr8DIzXQCehFmZ6v6YRgtv3b2ZwnUVWOSyydfbb1VDE8OWYliiB9pJVnnzGj8frqXmOBdMhMmmbQWHTuTfEH7/HlJoYrdPLQAOefOMPLMaGhTg7Ci8tdIzwuqf5+UGCc39M85ZYzxCXSqcRSbm1xFYxUhBalTG3wU0rkUvyU2pcNcCF4oWhG4n4p28jbrLd2idxYRWmhC2ZpFsiIa5QlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsNGuWCbRlY2FoNdJQI/93our1lmyft/QuPpXldlCkI=;
 b=csojIM8oNWz17kAxiLPZcs6eahfwMy6kWpXNok47ooWptOAFz16Avt7ymfXFFg32/5RQ2/Yd3VwjDiZgfG1srCdvhvpxFq62wA5/2f5GP4rUBwlMvQn5OGOtmnviveM+WrK8HFXGOUPMlS3LRAMu7H8HdXw2/oy4SeNa5aLst4U+btDE0lL5ffP9Q62S/eX5GoeekZLDP2hfw6+xwikvd9XO3oPCo6fmAlj222mp8/N7PiZxnOapmnNpVWqBuVdj1zpTHKu9NJwmLl13nRD/wp/YOl/O7TbxZBggCfKlaV3wfQ1EYM9NHG9wkJE311TUeOa4xT7imsys4J4+mrBzmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsNGuWCbRlY2FoNdJQI/93our1lmyft/QuPpXldlCkI=;
 b=NtKRA4Jb1jLIW4o7Ia+Rfz/9aA8UjH6ZYdVUvwcrxrDT+4RQI17/gLRKOKR121KhZGNQesyR83MfztrjR3Oj+J5SnKg4tvV8wYsKYiFAcbChsSglJ+QDcrJj8SFzH2Orw+LWwTwOq5IMjbhGUdgef5UQDqWVsZVTKJii/mc5k00=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1644.namprd12.prod.outlook.com (10.172.39.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 09:38:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 09:38:57 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Pan Bian <bianpan2016@163.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix potential double drop fence reference
Thread-Topic: [PATCH] drm/amdgpu: fix potential double drop fence reference
Thread-Index: AQHVlIKmM8yOPAC240CTNYmuotsvxad94vmA
Date:   Wed, 6 Nov 2019 09:38:57 +0000
Message-ID: <52555cc3-b8ea-63c0-1c8c-ae8318c4f469@amd.com>
References: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
In-Reply-To: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: AM0PR10CA0033.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::13) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 022dc6d4-8fb2-4c61-e0bf-08d7629d259d
x-ms-traffictypediagnostic: DM5PR12MB1644:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB16444FBDE734D5E80049309683790@DM5PR12MB1644.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(46003)(14454004)(6486002)(2616005)(486006)(66556008)(5660300002)(99286004)(54906003)(66476007)(66446008)(64756008)(6246003)(6512007)(110136005)(58126008)(11346002)(476003)(446003)(316002)(86362001)(52116002)(102836004)(31696002)(386003)(76176011)(186003)(6506007)(229853002)(71190400001)(2906002)(71200400001)(6436002)(256004)(6116002)(4326008)(305945005)(66946007)(7736002)(81156014)(81166006)(8676002)(65806001)(478600001)(65956001)(8936002)(31686004)(36756003)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1644;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pukkGJ9WJ1wAUffHMTO1lKheTzZF9AbONU4H5PUcGIXM8Q8ALot8BhvVP2HuCF7U/qztB2mMY/hc0B5ZbVnBCDR1Em4fKEPMVcJsbU22B4T+Od+GNLvdmZrcEHNoTd3tiowG50zXcZWI47AZ8HSACexuaGS6T5m7xBi3idWBOBfmLrLFuP1pXzLuY7MTl5ZsnuKSTjgsT055ZaLI/eOtV9Jds7/ePcJWR/1p+9CzfRyd4r97DAZLbYg8B4MFVT+hsGdOCkWdIbhz2+pmnGNeR2CmVjzjaSvGhDkqMKj4BXuO4SnGkwRsbaI4whB/8Nd0qPGGuO4uDPbEWbAdlhsLjFFwSr/H+U0b2Fmu8OPdHVdZP3kTtWk6fdQE5YzTDS2KSIA446SYBH5GJivSKeL7Y8gLazYU9iYGhIHhYYrVdOZBoDD9+CpzvbSrHH6djxz9
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA7B777B3409E543A5BA1215D9CE8C5F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022dc6d4-8fb2-4c61-e0bf-08d7629d259d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 09:38:57.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pAouez+Rlxz59MH2ALoUNKmGXC+IrShaMSSE/bFWSvihNXeuakitI5OUmSzGN+lA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMDYuMTEuMTkgdW0gMTA6MTQgc2NocmllYiBQYW4gQmlhbjoNCj4gVGhlIG9iamVjdCBmZW5j
ZSBpcyBub3Qgc2V0IHRvIE5VTEwgYWZ0ZXIgaXRzIHJlZmVyZW5jZSBpcyBkcm9wcGVkLiBBcyBh
DQo+IHJlc3VsdCwgaXRzIHJlZmVyZW5jZSBtYXkgYmUgZHJvcHBlZCBhZ2FpbiBpZiBlcnJvciBv
Y2N1cnMgYWZ0ZXIgdGhhdCwNCj4gd2hpY2ggbWF5IGxlYWQgdG8gYSB1c2UgYWZ0ZXIgZnJlZSBi
dWcuIFRvIGF2b2lkIHRoZSBpc3N1ZSwgZmVuY2UgaXMNCj4gZXhwbGljaXRseSBzZXQgdG8gTlVM
TCBhZnRlciBkcm9wcGluZyBpdHMgcmVmZXJlbmNlLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBQYW4g
QmlhbiA8YmlhbnBhbjIwMTZAMTYzLmNvbT4NCg0KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4NCg0KPiAtLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV90ZXN0LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5j
DQo+IGluZGV4IGI2NmQyOWQ1ZmZhMi4uYjE1ODIzMGFmOGRiIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdGVzdC5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90ZXN0LmMNCj4gQEAgLTEzOCw2ICsxMzgsNyBAQCBzdGF0
aWMgdm9pZCBhbWRncHVfZG9fdGVzdF9tb3ZlcyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikN
Cj4gICAJCX0NCj4gICANCj4gICAJCWRtYV9mZW5jZV9wdXQoZmVuY2UpOw0KPiArCQlmZW5jZSA9
IE5VTEw7DQo+ICAgDQo+ICAgCQlyID0gYW1kZ3B1X2JvX2ttYXAodnJhbV9vYmosICZ2cmFtX21h
cCk7DQo+ICAgCQlpZiAocikgew0KPiBAQCAtMTgzLDYgKzE4NCw3IEBAIHN0YXRpYyB2b2lkIGFt
ZGdwdV9kb190ZXN0X21vdmVzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQ0KPiAgIAkJfQ0K
PiAgIA0KPiAgIAkJZG1hX2ZlbmNlX3B1dChmZW5jZSk7DQo+ICsJCWZlbmNlID0gTlVMTDsNCj4g
ICANCj4gICAJCXIgPSBhbWRncHVfYm9fa21hcChndHRfb2JqW2ldLCAmZ3R0X21hcCk7DQo+ICAg
CQlpZiAocikgew0KDQo=
