Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC425C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F432073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PmGVUBDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfDORhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:37:02 -0400
Received: from mail-eopbgr770135.outbound.protection.outlook.com ([40.107.77.135]:55264
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbfDORhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rCi2HKSlJkRblLGGjXv5HEBT0C394/7mDbIaGPr3L1U=;
 b=PmGVUBDn8TvsyB0cfdNpM/zjr4jAPU0hFmiCPNi6ll0VeNDTIMdqUk3UHpDWJbp0mgiHwkSTXfxnhJ1AIWkxyujN7s8F7Ie4Ma3/R5iD+uJh2oxmRIYspW9gMdZITHS5Mtd5xv/txinpDemL8L6bMYNl4RhXAoTzDhc6ohsCFek=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1341.namprd22.prod.outlook.com (10.174.162.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Mon, 15 Apr 2019 17:36:58 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::b9d6:bf19:ec58:2765%7]) with mapi id 15.20.1792.018; Mon, 15 Apr 2019
 17:36:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Aurelien Jarno <aurelien@aurel32.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: scall64-o32: Fix indirect syscall number load
Thread-Topic: [PATCH] MIPS: scall64-o32: Fix indirect syscall number load
Thread-Index: AQHU7uQcwQdHDCGmKEWfhvVLuYZxV6Y9hdiA
Date:   Mon, 15 Apr 2019 17:36:58 +0000
Message-ID: <MWHPR2201MB12779DF3BC8AEC1203A65065C12B0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190409145355.25842-1-aurelien@aurel32.net>
In-Reply-To: <20190409145355.25842-1-aurelien@aurel32.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d9064b7-4676-4912-c596-08d6c1c8f601
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600140)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR2201MB1341;
x-ms-traffictypediagnostic: MWHPR2201MB1341:
x-microsoft-antispam-prvs: <MWHPR2201MB1341600EC4253773F4E7F2A5C12B0@MWHPR2201MB1341.namprd22.prod.outlook.com>
x-forefront-prvs: 000800954F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(366004)(39840400004)(376002)(199004)(189003)(42882007)(3846002)(71190400001)(68736007)(6916009)(81166006)(11346002)(2906002)(7696005)(55016002)(81156014)(229853002)(8676002)(52116002)(256004)(6436002)(99286004)(97736004)(8936002)(9686003)(71200400001)(476003)(14454004)(478600001)(6116002)(446003)(486006)(102836004)(386003)(105586002)(44832011)(5660300002)(4326008)(6506007)(106356001)(316002)(66066001)(25786009)(52536014)(53936002)(6246003)(33656002)(76176011)(26005)(74316002)(54906003)(305945005)(7736002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1341;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 18PFPdYbIeNKUj/pNCPvmtuWnBMEph16Y8ZuIczSuV8dHPnJPH23diDZy5Ar3ziYpkXH27tD6Xc3loTUrToZZeIZ3mqXoCY62T8Z7MqxiQyl2BDB3MHVGqH8Bi91y/7Y05uKWrSNerthSJjsQ0YtfxKs69ikWGNHy1xc8BYU384vYTpAtP2tNamEIzTZlEBtV3l0meXQ9o5/QFhxM29171h6rbaVrhURR/cES5QjO6+JU1W01Q5Kt+1lCebGms9Dyau1Kw5p7JpSRHwCIjEp9/C5ws57xFcMYMJisJ6M9V/W0atZll1xkNe5DIjhs5xmxgHsofQTjIYNwrVqK9Yltgkrl0NZBTEtyqAMVwILxlEvGkfmBUOPlqJS4J/+j6cqG20DrDa5GGDC2xGglrrNXxmyBGMxiZsSg3Tj8Nqn3T4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9064b7-4676-4912-c596-08d6c1c8f601
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2019 17:36:58.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1341
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNCkF1cmVsaWVuIEphcm5vIHdyb3RlOg0KPiBDb21taXQgNGMyMWI4ZmQ4ZjE0IChN
SVBTOiBzZWNjb21wOiBIYW5kbGUgaW5kaXJlY3Qgc3lzdGVtIGNhbGxzIChvMzIpKQ0KPiBhZGRl
ZCBpbmRpcmVjdCBzeXNjYWxsIGRldGVjdGlvbiBmb3IgTzMyIHByb2Nlc3NlcyBydW5uaW5nIG9u
IE1JUFM2NCwNCj4gYnV0IGl0IGRpZCBub3Qgd29yayBjb3JyZWN0bHkgZm9yIGJpZyBlbmRpYW4g
a2VybmVsL3Byb2Nlc3Nlcy4gVGhlDQo+IHJlYXNvbiBpcyB0aGF0IHRoZSBzeXNjYWxsIG51bWJl
ciBpcyBsb2FkZWQgZnJvbSBBUkcxIHVzaW5nIHRoZSBsdw0KPiBpbnN0cnVjdGlvbiB3aGlsZSB0
aGlzIGlzIGEgNjQtYml0IHZhbHVlLCBzbyB6ZXJvIGlzIGxvYWRlZCBpbnN0ZWFkIG9mDQo+IHRo
ZSBzeXNjYWxsIG51bWJlci4NCj4gDQo+IEZpeCB0aGUgY29kZSBieSB1c2luZyB0aGUgbGQgaW5z
dHJ1Y3Rpb24gaW5zdGVhZC4gV2hlbiBydW5uaW5nIGEgMzItYml0DQo+IHByb2Nlc3NlcyBvbiBh
IDY0IGJpdCBDUFUsIHRoZSB2YWx1ZXMgYXJlIHByb3Blcmx5IHNpZ24tZXh0ZW5kZWQsIHNvIGl0
DQo+IGVuc3VyZXMgdGhlIHZhbHVlIHBhc3NlZCB0byBzeXNjYWxsX3RyYWNlX2VudGVyIGlzIGNv
cnJlY3QuDQo+IA0KPiBSZWNlbnQgc3lzdGVtZCB2ZXJzaW9ucyB3aXRoIHNlY2NvbXAgZW5hYmxl
ZCB3aGl0ZWxpc3QgdGhlIGdldHBpZA0KPiBzeXNjYWxsIGZvciB0aGVpciBpbnRlcm5hbCAgcHJv
Y2Vzc2VzIChlLmcuIHN5c3RlbWQtam91cm5hbGQpLCBidXQgY2FsbA0KPiBpdCB0aHJvdWdoIHN5
c2NhbGwoU1lTX2dldHBpZCkuIFRoaXMgZml4IHRoZXJlZm9yZSBhbGxvd3MgTzMyIGJpZyBlbmRp
YW4NCj4gc3lzdGVtcyB3aXRoIGEgNjQtYml0IGtlcm5lbCB0byBydW4gcmVjZW50IHN5c3RlbWQg
dmVyc2lvbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBdXJlbGllbiBKYXJubyA8YXVyZWxpZW5A
YXVyZWwzMi5uZXQ+DQo+IENjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4gIyB2My4xNSsNCj4g
UmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMODwqkgPGY0YnVnQGFtc2F0Lm9yZz4N
Cg0KQXBwbGllZCB0byBtaXBzLWZpeGVzLg0KDQpUaGFua3MsDQogICAgUGF1bA0KDQpbIFRoaXMg
bWVzc2FnZSB3YXMgYXV0by1nZW5lcmF0ZWQ7IGlmIHlvdSBiZWxpZXZlIGFueXRoaW5nIGlzIGlu
Y29ycmVjdA0KICB0aGVuIHBsZWFzZSBlbWFpbCBwYXVsLmJ1cnRvbkBtaXBzLmNvbSB0byByZXBv
cnQgaXQuIF0NCg==
