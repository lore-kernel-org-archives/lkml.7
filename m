Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB11C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DB92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="TU7RUfJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfFXJQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:16:32 -0400
Received: from mail-eopbgr40137.outbound.protection.outlook.com ([40.107.4.137]:21998
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbfFXJQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:16:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONBoS4+/cYKEhGNhFcvb0kYLefbOJMoYDe0cypw29T4=;
 b=TU7RUfJpx2ccG/EAegbStrpa5C7M2PLBH4skgqZQn1eV/QdDJIMLgCOuCLalVQdGAJOqEgj4JeFxpwsJmk48o7xs0jLZtl3rQsBdnL3QREoA/XiU3DCgQhG/jXOm6tFwRURBMCtUYjxNrQXKSiXFxYLtmhu0iHZhr5GjlA0/+wY=
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com (20.177.202.24) by
 VI1PR07MB4320.eurprd07.prod.outlook.com (20.176.7.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.8; Mon, 24 Jun 2019 09:16:26 +0000
Received: from VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db]) by VI1PR07MB5744.eurprd07.prod.outlook.com
 ([fe80::fcde:79c2:8330:b9db%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 09:16:26 +0000
From:   "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jason Vas Dias <jason.vas.dias@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct vgtod_ts
Thread-Topic: [PATCH v3 1/2] x86/vdso: Move mult and shift into struct
 vgtod_ts
Thread-Index: AQHVG6zLWVr+SmJGqUG78zQ8oYIU56apIqMAgAGA/gA=
Date:   Mon, 24 Jun 2019 09:16:26 +0000
Message-ID: <df6b6311-ac67-857f-5a81-aee4eabd9f47@nokia.com>
References: <20190605144116.28553-1-alexander.sverdlin@nokia.com>
 <20190605144116.28553-2-alexander.sverdlin@nokia.com>
 <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906231008170.32342@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.32.167]
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
x-clientproxiedby: HE1PR05CA0269.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::21) To VI1PR07MB5744.eurprd07.prod.outlook.com
 (2603:10a6:803:98::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2930869f-d999-47a0-b0f4-08d6f884a241
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR07MB4320;
x-ms-traffictypediagnostic: VI1PR07MB4320:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR07MB4320EB7BD5BD8740600A852A88E00@VI1PR07MB4320.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(53936002)(8936002)(6436002)(2906002)(14454004)(476003)(486006)(6116002)(3846002)(478600001)(7736002)(11346002)(446003)(99286004)(305945005)(2616005)(81156014)(81166006)(966005)(6486002)(8676002)(65826007)(36756003)(31696002)(6512007)(65806001)(6306002)(66066001)(65956001)(4326008)(6916009)(71200400001)(71190400001)(4744005)(256004)(26005)(31686004)(64126003)(386003)(25786009)(68736007)(316002)(229853002)(76176011)(102836004)(52116002)(86362001)(54906003)(73956011)(66946007)(5660300002)(6246003)(66446008)(64756008)(66556008)(66476007)(58126008)(186003)(6506007)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB4320;H:VI1PR07MB5744.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RnTmfW7XCmTMGlN/m9IFOHJkhx2i2RPHOAXocwwS4QWutVxCiVQn6QqY22xakLSWI/GPZmLPbMIDD5NsFapM9v164dq/C6FGoAExd+8gERuba5VUhwpnorcglvj+8tHeTeGBF3ERG1Osv11gxpNqIabtgXUJ1lUa+pWsTbracoIr8RWUqdu6riZYMLlBE7N4Zcc9JF6NW48gmNbGStLbUlC2lZs1MKV8C588ppMqabcIJ3KSEYyW6s3Iox/6hea9QjzMr5WzwaJn5grVQWv8Aew171tarYdIluFPDCHWHcRY2Umbfe/RetUQpOfIZD3ciUSfOd+IGyQrPLnFh1yTKsDqrUtYj9Hf2Pe0YUx8sU9G+NAFFdMAgn8OmJl8cG+amDXF17q6m8PNcVLu8dXCDkRaOeJLuapqAlMWvnkM2ng=
Content-Type: text/plain; charset="utf-8"
Content-ID: <057FFE676D915D44BE810FBE1FA5F154@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2930869f-d999-47a0-b0f4-08d6f884a241
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 09:16:26.3598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alexander.sverdlin@nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzLA0KDQpPbiAyMy8wNi8yMDE5IDEyOjE4LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6
DQo+IFRoZSBhbHRlcm5hdGl2ZSBzb2x1dGlvbiBmb3IgdGhpcyBpcyB3aGF0IFZpbmNlbnpvIGhh
cyBpbiBoaXMgdW5pZmllZCBWRFNPDQo+IHBhdGNoIHNlcmllczoNCj4gDQo+ICAgaHR0cHM6Ly9s
a21sLmtlcm5lbC5vcmcvci8yMDE5MDYyMTA5NTI1Mi4zMjMwNy0xLXZpbmNlbnpvLmZyYXNjaW5v
QGFybS5jb20NCj4gDQo+IEl0IGxlYXZlcyB0aGUgZGF0YSBzdHJ1Y3QgdW5tb2RpZmllZCBhbmQg
aGFzIGEgc2VwYXJhdGUgYXJyYXkgZm9yIHRoZSByYXcNCj4gY2xvY2suIFRoYXQgZG9lcyBub3Qg
aGF2ZSB0aGUgc2lkZSBlZmZlY3RzIGF0IGFsbC4NCj4gDQo+IEknbSBpbiB0aGUgcHJvY2VzcyBv
ZiBtZXJnaW5nIHRoYXQgc2VyaWVzIGFuZCBJIGFjdHVhbGx5IGFkYXB0ZWQgeW91cg0KPiBzY2hl
bWUgdG8gdGhlIG5ldyB1bmlmaWVkIGluZnJhc3RydWN0dXJlIHdoZXJlIGl0IGhhcyBleGFjdGx5
IHRoZSBzYW1lDQo+IGVmZmVjdHMgYXMgd2l0aCB5b3VyIG9yaWdpbmFsIHBhdGNoZXMgYWdhaW5z
dCB0aGUgeDg2IHZlcnNpb24uDQoNCnBsZWFzZSBsZXQgbWUga25vdyBpZiBJIG5lZWQgdG8gcmV3
b3JrIFsyLzJdIGJhc2VkIG9uIHNvbWUgbm90LXlldC1wdWJsaXNoZWQNCmJyYW5jaCBvZiB5b3Vy
cy4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpBbGV4YW5kZXIgU3ZlcmRsaW4uDQo=
