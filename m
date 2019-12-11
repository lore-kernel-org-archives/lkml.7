Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08319208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 01:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="msg7hmai"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfLKBsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 20:48:41 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:10692
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726417AbfLKBsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 20:48:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGnRLOzlAsRygRsGh+7jz909Dq3jumtCKZ1cUYXaqDhIH2fQeLexeAtwLD9rkKPV614Xix7bRe5NoLxAjh+TrpJg/kUZQ/uxQKv3s0aUyOZ9cdb0okcBzj9KxkbFNqpF6pEOp259PidGkKyZyLU4YFku6R6tGl86vrxQ+2Rb904UT1evt4k7sxUGsK13uUG0zhQooa7zSZEcEJzmkYgs+W6tV9Lm+wvEPoq8P5KAg7ccj0Fu7cKMDBhv9EoBwE3YpKjAY2GW5Qp2Tw198KINH1jWnGp6gmr5knVOs96lAI3ZY4tRbmS/LvaM7ge2OLOC4+xmw9RAR93Z1gy6pGAHeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NONE9v26+I5yo1xM58chFzalY5ms6vYaszFFjsgDFBE=;
 b=LGWK8CXNmyXcVPXJA1re767fiyXOW04a/qBbu9lBzdsPBVFqX1kFFfYuvnZTryAOgxEoxNaHV3JiOZtcNWBvd6lmVVyyyPVVSE4F3VhuCOko2M46NaSKfKQa818TAJx93JtLO840PZ7jZSKw7NQKyV7OiNLCNbTHoa80Ma6Hs2H2FhSR9PS9NfKPg5940AkmcJgEBSYKg4ehiFKVCi7YVik8ZUzOYkmuHuMC3A3cBVtZjxflkNoWRpvDDHbFyPqJ7xJRjTx4m2WuRFEkGwmTTuWKpBhpMQeyeTLkJKVRB6cGMTcfLbx1enXx1VHThmFXQ7m5YaZqZSD3XgfIa2XN+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NONE9v26+I5yo1xM58chFzalY5ms6vYaszFFjsgDFBE=;
 b=msg7hmaitFYebmt5fcSrmxabI9gZhLjP8Jiwlz00dV89DMNsZ5sah/H8gSMAjvJXpJY/w5nxftjt5DQxmZ0AeZasJllkkjnW64Mu0L11o8dmljCeNbU/dZ+Ih/vnGLdvk9OU165HzMkNoFgKa5HMbPmagUDYKT1fBPGJdKVCH/o=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4937.eurprd04.prod.outlook.com (20.176.234.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 01:48:31 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::1c96:c591:7d51:64e6%4]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 01:48:31 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Jiri Olsa <jolsa@redhat.com>, John Garry <john.garry@huawei.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: RE: perf top for arm64?
Thread-Topic: perf top for arm64?
Thread-Index: AQHVr3TS8xUBBl2auUq+LOAuNWnWeKezkSeAgAAEdQCAAARrgIAAj7WA
Date:   Wed, 11 Dec 2019 01:48:30 +0000
Message-ID: <DB7PR04MB4618A2196EA1E57D979B1C3AE65A0@DB7PR04MB4618.eurprd04.prod.outlook.com>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
In-Reply-To: <20191210170841.GA23357@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 70588055-7ef5-43c1-0614-08d77ddc39e4
x-ms-traffictypediagnostic: DB7PR04MB4937:
x-microsoft-antispam-prvs: <DB7PR04MB493701A6D83EBA206D1D96A3E65A0@DB7PR04MB4937.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(13464003)(54534003)(189003)(199004)(53754006)(66946007)(81156014)(66556008)(110136005)(8676002)(66476007)(66446008)(8936002)(55016002)(7696005)(26005)(33656002)(966005)(64756008)(9686003)(6506007)(478600001)(186003)(54906003)(81166006)(86362001)(76116006)(71200400001)(5660300002)(53546011)(4326008)(52536014)(2906002)(316002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4937;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uv2PJsbkYcb2UVonimkie7oDEcPNn+f8ID7YnrXl4+PX+dnZmmRCI+h/WxRZFYAoiXUF9aCx9D5UXQQqup/YWIJPEAlJ8yd22Wt3dBwwb3C/mb2UAgkxlqDqNicZwX0UMbdqhjjv6YRHHLwo/EXgEdnztTulAYCi9yhQCb82/8Ed9M/yQLp7luCd28CvOBIFtrnw8WxbvlepkB7q2SwdPuVwypBdFU/nPRh3MNDZQeqGa2eGT1r+CnzrDr3T/S3IzefldRhb3/8M+ZzRURiOi+HKk8w74B+g3SIoob3TCQN2PrRmBbjKf+Lte6lYPD5I9ze9N5art8J48MPJHQ57DoFJ233LRbB9jQoY1GJtt9ByILRl+s4/5HGxahGGk+odZqr/ULYomUxVVYU5/kWnfg/r+bnrhvsllZK8txcI9jwJMLrXLWG2wj19jBrId+n+XCW+2ZpdcTbYwrIlB2LFl9/C0Hhv/hFQVDv6lACXcQ3ieF84JS0NLXELakdXJvfKL1s7IzxM/WfjYYd7Fh24rcrYBMwgLdDJNMheaimER2mZ+K436WtCGAE7wmXK05B5spQ84drex77OOLJn+7ycAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70588055-7ef5-43c1-0614-08d77ddc39e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 01:48:30.8839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /hm86uefmCadHf0pB++wnY528VNGa8rzMZGaxQOOY3THHr5+jxJaAweJ75Cp3dEVEZnI7Z2KuL8SDLt/ZMk73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LXBlcmYtdXNlcnMt
b3duZXJAdmdlci5rZXJuZWwub3JnDQo+IDxsaW51eC1wZXJmLXVzZXJzLW93bmVyQHZnZXIua2Vy
bmVsLm9yZz4gT24gQmVoYWxmIE9mIEppcmkgT2xzYQ0KPiBTZW50OiAyMDE5xOoxMtTCMTHI1SAx
OjA5DQo+IFRvOiBKb2huIEdhcnJ5IDxqb2huLmdhcnJ5QGh1YXdlaS5jb20+DQo+IENjOiBBcm5h
bGRvIENhcnZhbGhvIGRlIE1lbG8gPGFybmFsZG8ubWVsb0BnbWFpbC5jb20+Ow0KPiBwZXRlcnpA
aW5mcmFkZWFkLm9yZzsgbWluZ29AcmVkaGF0LmNvbTsNCj4gYWxleGFuZGVyLnNoaXNoa2luQGxp
bnV4LmludGVsLmNvbTsgbmFtaHl1bmdAa2VybmVsLm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5j
b207IHdpbGxAa2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBMaW51eGFybSA8bGludXhhcm1AaHVh
d2VpLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6
IFJlOiBwZXJmIHRvcCBmb3IgYXJtNjQ/DQo+IA0KPiBPbiBUdWUsIERlYyAxMCwgMjAxOSBhdCAw
NDo1Mjo1MlBNICswMDAwLCBKb2huIEdhcnJ5IHdyb3RlOg0KPiA+IE9uIDEwLzEyLzIwMTkgMTY6
MzYsIEppcmkgT2xzYSB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgRGVjIDEwLCAyMDE5IGF0IDA0OjEz
OjQ5UE0gKzAwMDAsIEpvaG4gR2Fycnkgd3JvdGU6DQo+ID4gPiA+IEhpIGFsbCwNCj4gPiA+ID4N
Cj4gPiA+ID4gSSBmaW5kIHRvIG15IHN1cnByaXNlIHRoYXQgInBlcmYgdG9wIiBkb2VzIG5vdCB3
b3JrIGZvciBhcm02NDoNCj4gPiA+ID4NCj4gPiA+ID4gcm9vdEB1YnVudHU6L2hvbWUvam9obi9s
aW51eCMgdG9vbHMvcGVyZi9wZXJmIHRvcCBDb3VsZG4ndCByZWFkDQo+ID4gPiA+IHRoZSBjcHVp
ZCBmb3IgdGhpcyBtYWNoaW5lOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4gPg0KPiA+
DQo+ID4gSGkgSmlya2EsDQo+ID4NCj4gPiA+IHRoZXJlIHdhcyByZWNlbnQgY2hhbmdlIHRoYXQg
Y2hlY2sgb24gY3B1aWQgYW5kIHF1aXRzOg0KPiA+ID4gICAgNjA4MTI3ZjczNzc5IHBlcmYgdG9w
OiBJbml0aWFsaXplIHBlcmZfZW52LT5jcHVpZCwgbmVlZGVkIGJ5IHRoZQ0KPiA+ID4gcGVyIGFy
Y2ggYW5ub3RhdGlvbiBpbml0IHJvdXRpbmUNCj4gPiA+DQo+ID4NCj4gPiBvaywgdGhpcyBpcyBu
ZXcgY29kZS4gSSBvYnZpb3VzbHkgZGlkbid0IGNoZWNrIHRoZSBnaXQgaGlzdG9yeS4uLg0KPiA+
DQo+ID4gQnV0LCBhcGFydCBmcm9tIHRoaXMsIHRoZXJlIGFyZSBtYW55IG90aGVyIHBsYWNlcyB3
aGVyZSBnZXRfY3B1aWQoKSBpcw0KPiA+IGNhbGxlZC4gSSB3b25kZXIgd2hhdCBlbHNlIHdlJ3Jl
IG1pc3Npbmcgb3V0IG9uLCBhbmQgd2hldGhlciB3ZSBzaG91bGQNCj4gPiBzdGlsbCBhZGQgaXQu
DQo+IA0KPiByaWdodCwgSSB3YXMganVzdCB3b25kZXJpbmcgaG93IGNvbWUgdmVuZG9yIGV2ZW50
cyBhcmUgd29ya2luZyBmb3IgeW91LCBidXQNCj4gcmVhbGl6ZWQgd2UgaGF2ZSBnZXRfY3B1aWRf
c3RyIGJlaW5nIGNhbGxlZCBpbiB0aGVyZSA7LSkNCj4gDQo+IEkgdGhpbmsgd2Ugc2hvdWxkIGFk
ZCBpdCBhcyB5b3UgaGF2ZSBpdCBwcmVwYXJlZCBhbHJlYWR5LCBjb3VsZCB5b3UgcG9zdCBpdCB3
aXRoDQo+IGJpZ2dlciBjaGFuZ2Vsb2cgdGhhdCB3b3VsZCBleHBsYWluIHdoZXJlIGl0J3MgYmVp
bmcgdXNlZCBmb3IgYXJtPw0KDQpIaSBKaXJrYSwNCg0KSSByZXBvcnRlZCBtZXRyaWNncm91cCBj
YW5ub3Qgd29yayBvbiBBUk02NCBiZWZvcmUsIGhvd2V2ZXIsIG5vIG9uZSBjYW4gY29tZSB1cCB3
aXRoIGEgc29sdXRpb24sIGNvdWxkIHlvdSB0YWtlIGEgbG9vayBob3cgdG8gZml4IGl0PyBUaGFu
a3MgYSBsb3QhDQoNCllvdSBjYW4gcmVmZXIgdG8gYmVsb3cgbGluayBmb3IgbW9yZSBpbmZvOg0K
CVsxXSBodHRwczovL3d3dy5zcGluaWNzLm5ldC9saXN0cy9saW51eC1wZXJmLXVzZXJzL21zZzA5
MTkwLmh0bWwgKE5BQ0sgYnkgV2lsbCBEZWFzb24pDQoJWzJdIGh0dHBzOi8vd3d3LnNwaW5pY3Mu
bmV0L2xpc3RzL2xpbnV4LXBlcmYtdXNlcnMvbXNnMDkzMjQuaHRtbA0KDQpCZXN0IFJlZ2FyZHMs
DQpKb2FraW0gWmhhbmcNCj4gamlya2ENCg0K
