Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC1AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7826206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A2CKSBPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbfISQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:48:50 -0400
Received: from mail-eopbgr700050.outbound.protection.outlook.com ([40.107.70.50]:2145
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729629AbfISQsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:48:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEX7hIajdnIIG530HSmkOi2mHD+YzIS34BMSAqbhdpxL9+1Cr8dHo3xxnArjvCpfR8/QablbM/uabkxFPVL2oCfQ4BgPVMlSkd3oYrF1SecyACmv4jies4B4PcaACDsoMor5LQ9J7RVBMkQB0ZZEs+dso1gc0eX/0hE34WZ4Z7IiujuzOzr9DkpvHQTBUanIdKNt2s9OvRRhhWNMWFRG48bx0hlKG4V6I/hKk4Odvf/fKMUq13m7jn4LOC4zkSSvDvsJwKmoTpJQyGms7SYW+2QczYRGGG26TOfj54epG/8LaxhbPZDxIaO0ZNcYNedF4ww2smKbb99NZzmCQkM6yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alUFO1FzDl5LqJnYVULaBzHheIXyFkppbnJHg/TSVXE=;
 b=UiUjQggbiFm6qEOULZhU/Kko8qRsvzC2Q3mJ0dxTVuieLZc+DjVAK1kFq4VWHZp7I5Ps1nWn2Gvm092tBxJg6ydWYntbKpuCZE+G1Iel39AnkC7KmkfBDQ1rxF8Jwn1iCZGkZb11VHPE3EiJNVAuj1/lTUKgIZj/rK01/r0sL9TZJn3T3zAijNM6K02IqU8rHl0G10qRFvQ43+COq3dTKf6xui5FIT2XGajeZ7v+Q4dLCArzAwkE4RwMZ8qFMo38d146d3jd0K3RZSiIohdV0Jxe+CVBAlS5KQYAjsscEpUq9TSTbl/M1jYtA6StklvHHbI2emdgaZ/OfqxsHYkVUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alUFO1FzDl5LqJnYVULaBzHheIXyFkppbnJHg/TSVXE=;
 b=A2CKSBPc1+/LrM73s+cYlhp7SqDOfnihHFV3f521fH7NsOuBAv+Zt4BiN8qQy1zyyh5sHplWO4fnfRXQbo29Pt568iiR/v8PV0CK63SGDskjN4y8B8ufcN3Njas5mpuCijzo37g1jCKk09XAH0lXb9qzqLICxZY71NJR/KsqX5w=
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5SPR00MB111.namprd12.prod.outlook.com (10.174.247.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.18; Thu, 19 Sep 2019 16:48:47 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::9d43:b3d4:9ef:29fc]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::9d43:b3d4:9ef:29fc%8]) with mapi id 15.20.2263.023; Thu, 19 Sep 2019
 16:48:47 +0000
From:   "Koenig, Christian" <Christian.Koenig@amd.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
CC:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        "emamd001@umn.edu" <emamd001@umn.edu>,
        "smccaman@umn.edu" <smccaman@umn.edu>,
        "kjlu@umn.edu" <kjlu@umn.edu>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Thread-Topic: [PATCH v2] drm/amdgpu: fix multiple memory leaks
Thread-Index: AQHVblQS6/8T9OuguEStJ7+but2+fKcypL4AgABrlACAACcxAA==
Date:   Thu, 19 Sep 2019 16:48:47 +0000
Message-ID: <7450dab5-3c3f-0b91-4656-6c5a7cf4d49d@amd.com>
References: <7bab24ff-ded7-9f76-ba25-efd07cdd30dd@amd.com>
 <20190918190529.17298-1-navid.emamdoost@gmail.com>
 <88fc639a-32ed-b6c6-f930-552083d5887d@amd.com>
 <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw@mail.gmail.com>
In-Reply-To: <CAGngYiWHe1mw0+Ay6HO7kG5y8HMriUX3BO8VUcTvGayEK-4JOw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
x-originating-ip: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
x-clientproxiedby: PR0P264CA0185.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62e74a1f-844f-4045-1168-08d73d213dab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5SPR00MB111;
x-ms-traffictypediagnostic: DM5SPR00MB111:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5SPR00MB11127912FCA262E139E0BDF83890@DM5SPR00MB111.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(189003)(199004)(5660300002)(2616005)(6506007)(446003)(256004)(305945005)(4326008)(14444005)(6916009)(11346002)(46003)(86362001)(53546011)(65956001)(386003)(186003)(476003)(25786009)(102836004)(65806001)(99286004)(76176011)(52116002)(71200400001)(71190400001)(478600001)(1411001)(31696002)(14454004)(229853002)(58126008)(81156014)(8676002)(66946007)(66446008)(66556008)(66476007)(36756003)(31686004)(64756008)(6436002)(316002)(7416002)(6246003)(7736002)(81166006)(54906003)(2906002)(6512007)(6486002)(8936002)(486006)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5SPR00MB111;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o73sOrfs+wwcW96ncPxEfaCwSekBz4bDisDvr0gap3iqFgPK83dvBdL9Ch5ywjC6coPWbxWpTJixDCSkXSHzK+YljS+lucK0UjDCQ1THvhhHJpCMUB9KCUY4j/q7VHG0ORN3X1VU7Yu2Nbbow0jrkBeaEBfmTK9DC5wfqB33yMliKCRlu3PkLVpTax2QOjEIM+wRx11uZlvArglMRYj6uRh1eMf2VaZSfWtQQxrPbf/zxDezIhOnFZramidrB8aEHWb7VP+3q5mm765dC3WmDP1Zz30SZNZ9S2ATHDkr7hggsCb9rsgrzbLQGUySlVnyKbGO8FrnzjCla3xp43k6AvCzgNZyy7v3dW1oryDmjB3x8AScP/jcUBWYVjUGM/wFtFQ/NwgWk41br5usLS8J+CG59TB1PaX+u9eW3ynqGnM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A52BBEE9F5AE24B8D2F7A702282DBD5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e74a1f-844f-4045-1168-08d73d213dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 16:48:47.6899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq7UOwoD4sDcNfKv/HBncclhXzK22XQOrV3clVVZEN+I4PTSuv5wAjDHlyPlaP/H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5SPR00MB111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gMTkuMDkuMTkgdW0gMTY6Mjggc2NocmllYiBTdmVuIFZhbiBBc2Jyb2VjazoNCj4gSGkgQ2hy
aXN0aWFuLA0KPg0KPiBPbiBUaHUsIFNlcCAxOSwgMjAxOSBhdCA0OjA1IEFNIEtvZW5pZywgQ2hy
aXN0aWFuDQo+IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+IHdyb3RlOg0KPj4+ICtvdXQ0Og0K
Pj4+ICsgICAgIGtmcmVlKGkyc19wZGF0YSk7DQo+Pj4gK291dDM6DQo+Pj4gKyAgICAga2ZyZWUo
YWRldi0+YWNwLmFjcF9yZXMpOw0KPj4+ICtvdXQyOg0KPj4+ICsgICAgIGtmcmVlKGFkZXYtPmFj
cC5hY3BfY2VsbCk7DQo+Pj4gK291dDE6DQo+Pj4gKyAgICAga2ZyZWUoYWRldi0+YWNwLmFjcF9n
ZW5wZCk7DQo+PiBrZnJlZSBvbiBhIE5VTEwgcG9pbnRlciBpcyBoYXJtbGVzcywgc28gYSBzaW5n
bGUgZXJyb3IgbGFiZWwgc2hvdWxkIGJlDQo+PiBzdWZmaWNpZW50Lg0KPiBUaGF0IGlzIHRydWUs
IGJ1dCBJIG5vdGljZSB0aGF0IHRoZSBhZGV2IHN0cnVjdHVyZSBjb21lcyBmcm9tIG91dHNpZGUg
dGhpcw0KPiBkcml2ZXI6DQoNCmFkZXYgaXMgYSB2ZXJ5IGludGVncmFsIHBhcnQgb2YgdGhlIGRy
aXZlciBhbmQgYWx3YXlzIHplcm8gaW5pdGlhbGl6ZWQ6DQoNCmFkZXYgPSBremFsbG9jKHNpemVv
ZihzdHJ1Y3QgYW1kZ3B1X2RldmljZSksIEdGUF9LRVJORUwpOw0KDQpSZWdhcmRzLA0KQ2hyaXN0
aWFuLg0KDQo+DQo+IHN0YXRpYyBpbnQgYWNwX2h3X2luaXQodm9pZCAqaGFuZGxlKQ0KPiB7DQo+
IC4uLg0KPiBzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2Rldmlj
ZSAqKWhhbmRsZTsNCj4gLi4uDQo+IH0NCj4NCj4gQXMgZmFyIGFzIEkgY2FuIHRlbGwsIHRoZSBp
bml0KCkgZG9lcyBub3QgZXhwbGljaXRseSBzZXQgdGhlc2UgdG8gTlVMTDoNCj4gYWRldi0+YWNw
LmFjcF9yZXMNCj4gYWRldi0+YWNwLmFjcF9jZWxsDQo+IGFkZXYtPmFjcC5hY3BfZ2VucGQNCj4N
Cj4gSSBhbSBhc3N1bWluZyB0aGF0IGNvcmUgY29kZSBzZXRzIHRoZXNlIHRvIE5VTEwsIGJlZm9y
ZSBjYWxsaW5nDQo+IGFjcF9od19pbml0KCkuIEJ1dCBpcyB0aGF0IGd1YXJhbnRlZWQgb3Igc2lt
cGx5IGEgaGFwcHkgYWNjaWRlbnQ/DQo+IEllLiBpZiB0aGV5IGFyZSBOVUxMIHRvZGF5LCBhcmUg
dGhleSBsaWtlbHkgdG8gcmVtYWluIE5VTEwgdG9tb3Jyb3c/DQo+DQo+IEJlY2F1c2UgY2FsbGlu
ZyBrZnJlZSgpIG9uIGEgc3RhbGUgcG9pbnRlciB3b3VsZCBiZSwgd2VsbA0KPiBub3QgZ29vZC4g
RXNwZWNpYWxseSBub3Qgb24gYW4gZXJyb3IgcGF0aCwgd2hpY2ggdHlwaWNhbGx5DQo+IGRvZXMg
bm90IHJlY2VpdmUgbXVjaCB0ZXN0aW5nLCBpZiBhbnkuDQo+DQo+IE15IGFwb2xvZ2llcyBpZiBJ
IGhhdmUgbWlzaW50ZXJwcmV0ZWQgdGhpcywgSSBhbSBub3QgZmFtaWxpYXIgd2l0aA0KPiB0aGlz
IGNvZGUgYmFzZS4NCj4NCj4gU3Zlbg0KDQo=
