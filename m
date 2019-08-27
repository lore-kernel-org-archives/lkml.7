Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1DDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE37A2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VOKCpqIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbfH0PJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:09:56 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:27328
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726170AbfH0PJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:09:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2EvxnIbxvtqpLcENC9iuFb16ucFdl1hg/eN6FcnxDmoEQf3M7Em6w6t4//bZek9dKxzJXLaYYua3TFv4VKY0jqe60drwnjtIYzdWS76hDDoFpVlFqED22DRn63nFBaPrN4NQfNUUbLM0LEgmv53BRyw4vQIeaRPf6jd/3iOxzDqhuQyNQEnu1U94kFtxFo6W3XY/3vBxMfRAov/O2fQt2fd53QtTRIjGBOuvvYXOnoNHPZsakabI6gisfbPjqJ8CbeI7g5i47HtWOx5GmdqRxYaWsVu5oYasZ1svkBqZ41Sa6JpyIulup7LuZWFOVBkTgSt2XvD8kv52Z324lQmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSs3HoCsuOMDiwNys81C5vj+rWG3kRMjKYcOkYiHm4U=;
 b=N0Rek8++ASXW6Ydi09+xYeSp0ucqOrV15M7wi81QubT9a8IHrEPkxHjR3lxwAJR3nVJ35WfrbVLMJ4SQq0qkjerS8XFRDHY1247UaRfaUX7k/85PdBJ9h9zzxD83npCbX/DtC6oXSBK3Ue9FWpU6zD17a8wI5w0feKeS8E8RTSWAaTyiQAvgyMg+G2O931FWWP8Njg8ne/cJ+vr2vbypyNqdIcmN4HIUbq8HP91atvW1AjVvGmHYebjf6h/da3gLtO1qsda+djSbyeTIo5uy0GHwD9RCRJoqchIJMsmkDu6i8c//ElYQVjKeeIPBZFMbZniRGeugFK9XKtu/kkQ2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSs3HoCsuOMDiwNys81C5vj+rWG3kRMjKYcOkYiHm4U=;
 b=VOKCpqIn8scX0L6SR3f4aPIOvY94CK555K9RUHm7ajnjHV0oW9swbNijxD1sOG2QIrWuqlhVxPL6rIxo7Z38ScpInPGw3Em2ZOS2aR4OO2cypjeY9/3fJNoJHcubahGkrCyhAjOSGGM+5v6nP9ZK5NNdHmtUDOa6yPGoBRgXHeQ=
Received: from DM6PR12MB2617.namprd12.prod.outlook.com (20.176.116.14) by
 DM6PR12MB3132.namprd12.prod.outlook.com (20.178.31.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.20; Tue, 27 Aug 2019 15:09:43 +0000
Received: from DM6PR12MB2617.namprd12.prod.outlook.com
 ([fe80::e9b4:2468:7ffe:6ab3]) by DM6PR12MB2617.namprd12.prod.outlook.com
 ([fe80::e9b4:2468:7ffe:6ab3%4]) with mapi id 15.20.2199.021; Tue, 27 Aug 2019
 15:09:42 +0000
From:   "Othman, Ahmad" <Ahmad.Othman@amd.com>
To:     Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>
CC:     YueHaibing <yuehaibing@huawei.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
        "Koo, Anthony" <Anthony.Koo@amd.com>,
        "Bernstein, Eric" <Eric.Bernstein@amd.com>,
        "Cyr, Aric" <Aric.Cyr@amd.com>,
        "alvin.lee3@amd.com" <alvin.lee3@amd.com>,
        "Tatla, Harmanprit" <Harmanprit.Tatla@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] drm/amd/display: remove unused function
 setFieldWithMask
Thread-Topic: [PATCH 2/3] drm/amd/display: remove unused function
 setFieldWithMask
Thread-Index: AQHVXKZrNZ63bprOUkW/IzNmiDRizqcPBoUAgAAFQoCAAA2qoA==
Date:   Tue, 27 Aug 2019 15:09:42 +0000
Message-ID: <DM6PR12MB26177A7D6E572D31FC46F09E83A00@DM6PR12MB2617.namprd12.prod.outlook.com>
References: <20190827070925.16080-1-yuehaibing@huawei.com>
 <fb49a1d9-8405-4f88-6f9a-af863bd0f657@amd.com>
 <CADnq5_Pe-qnTWZrDxmC=xqHJBQ_SkaBv8go9mVWWp7MciC4NHA@mail.gmail.com>
In-Reply-To: <CADnq5_Pe-qnTWZrDxmC=xqHJBQ_SkaBv8go9mVWWp7MciC4NHA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ahmad.Othman@amd.com; 
x-originating-ip: [165.204.55.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f673747-ca18-46b4-c115-08d72b0096fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM6PR12MB3132;
x-ms-traffictypediagnostic: DM6PR12MB3132:
x-ms-exchange-purlcount: 1
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3132BDED0F15413D687678C283A00@DM6PR12MB3132.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:177;
x-forefront-prvs: 0142F22657
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(199004)(189003)(13464003)(66066001)(8936002)(76176011)(316002)(53936002)(256004)(81156014)(19627235002)(8676002)(81166006)(486006)(186003)(71190400001)(71200400001)(7696005)(110136005)(33656002)(86362001)(102836004)(26005)(53546011)(6506007)(6636002)(476003)(99286004)(478600001)(9686003)(6306002)(55016002)(6436002)(229853002)(74316002)(5660300002)(446003)(11346002)(14454004)(7736002)(3846002)(64756008)(305945005)(66476007)(66556008)(66446008)(76116006)(66946007)(6116002)(4326008)(52536014)(2906002)(966005)(6246003)(25786009)(54906003)(145543001)(145603002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3132;H:DM6PR12MB2617.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tsUWoopFkgbp33DBWD4vvqf6dySDGDL9BHJuhdG0s3oK+C9LJDg8xtuDX3f2IbPcofgMs1mJ6ijtDa3zMNjPCh7lOjYsdXtfKtvWmgubxW0qcn/0g8OQbuXwUSgb7MYKe32GbBxmNw46YC5AcjMx+PL+Ud+2JU7dl6uQxyN+aJVcTA7tnmfpkUgLpLQoxslG9kFey1MuXrPXUoiJIbQdxWvRrVUw1PJbntltv+E29xXta6PU4YNit6dRGuqjVQBbJEtAtKQWXRl/brvjtZJwzEBm57AkYIB4ODngjh+k0Z4aROlB1YshcmGDcdkC8Mo54Z+c1D8C6Ef+m99PB3EuDjKZXtqavMbsF92a2c1FOVIY4WeY4irE9/4aK34CzQOrMOsaaUssS08Y/mDCj/doPk42Ede/jZthr26jX8+2BSw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f673747-ca18-46b4-c115-08d72b0096fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2019 15:09:42.7806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GktINa7/Yu6IULzXyFnTeeK7RoxYXvdfCMJo//diaq40tTOkhvNFjAZZ3Gq6vklfXOIrPPYZerDgMtQsdboeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KVGhlcmUgYXJlIGNhbGxlcnMgaW4gdGhlIHNhbWUgZmlsZSAiaW5mb19wYWNr
ZXQuYyIgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGV4IERldWNoZXIg
PGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4gDQpTZW50OiBBdWd1c3QgMjcsIDIwMTkgMTA6MjANClRv
OiBXZW50bGFuZCwgSGFycnkgPEhhcnJ5LldlbnRsYW5kQGFtZC5jb20+DQpDYzogWXVlSGFpYmlu
ZyA8eXVlaGFpYmluZ0BodWF3ZWkuY29tPjsgV2VudGxhbmQsIEhhcnJ5IDxIYXJyeS5XZW50bGFu
ZEBhbWQuY29tPjsgTGksIFN1biBwZW5nIChMZW8pIDxTdW5wZW5nLkxpQGFtZC5jb20+OyBEZXVj
aGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPjsgWmhvdSwgRGF2aWQoQ2h1bk1pbmcpIDxE
YXZpZDEuWmhvdUBhbWQuY29tPjsgYWlybGllZEBsaW51eC5pZTsgZGFuaWVsQGZmd2xsLmNoOyBM
YWtoYSwgQmhhd2FucHJlZXQgPEJoYXdhbnByZWV0Lkxha2hhQGFtZC5jb20+OyBLb28sIEFudGhv
bnkgPEFudGhvbnkuS29vQGFtZC5jb20+OyBPdGhtYW4sIEFobWFkIDxBaG1hZC5PdGhtYW5AYW1k
LmNvbT47IEJlcm5zdGVpbiwgRXJpYyA8RXJpYy5CZXJuc3RlaW5AYW1kLmNvbT47IEN5ciwgQXJp
YyA8QXJpYy5DeXJAYW1kLmNvbT47IGFsdmluLmxlZTNAYW1kLmNvbTsgVGF0bGEsIEhhcm1hbnBy
aXQgPEhhcm1hbnByaXQuVGF0bGFAYW1kLmNvbT47IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmc7IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDIvM10gZHJtL2FtZC9kaXNwbGF5OiByZW1v
dmUgdW51c2VkIGZ1bmN0aW9uIHNldEZpZWxkV2l0aE1hc2sNCg0KT24gVHVlLCBBdWcgMjcsIDIw
MTkgYXQgMTA6MDEgQU0gSGFycnkgV2VudGxhbmQgPGh3ZW50bGFuQGFtZC5jb20+IHdyb3RlOg0K
Pg0KPiBPbiAyMDE5LTA4LTI3IDM6MDkgYS5tLiwgWXVlSGFpYmluZyB3cm90ZToNCj4gPiBBZnRl
ciBjb21taXQgYTlmNTRjZTNjNjAzICgiZHJtL2FtZC9kaXNwbGF5OiBSZWZhY3RvcmluZyBWVEVN
IiksIA0KPiA+IHRoZXJlIGlzIG5vIGNhbGxlciBpbiB0cmVlLg0KPiA+DQo+ID4gUmVwb3J0ZWQt
Ynk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29tPiBTaWduZWQtb2ZmLWJ5OiANCj4gPiBZ
dWVIYWliaW5nIDx5dWVoYWliaW5nQGh1YXdlaS5jb20+DQo+DQo+IFJldmlld2VkLWJ5OiBIYXJy
eSBXZW50bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4NCj4NCg0KQXBwbGllZC4gIFRoYW5r
cyENCg0KQWxleA0KDQo+IEhhcnJ5DQo+DQo+ID4gLS0tDQo+ID4gIC4uLi9kcm0vYW1kL2Rpc3Bs
YXkvbW9kdWxlcy9pbmZvX3BhY2tldC9pbmZvX3BhY2tldC5jIHwgMTkgDQo+ID4gLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IA0KPiA+IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L21vZHVsZXMv
aW5mb19wYWNrZXQvaW5mb19wYWNrZXQuYyANCj4gPiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlz
cGxheS9tb2R1bGVzL2luZm9fcGFja2V0L2luZm9fcGFja2V0LmMNCj4gPiBpbmRleCA1ZjRiOThk
Li5kODg1ZDY0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9t
b2R1bGVzL2luZm9fcGFja2V0L2luZm9fcGFja2V0LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2Rpc3BsYXkvbW9kdWxlcy9pbmZvX3BhY2tldC9pbmZvX3BhY2tldC5jDQo+ID4gQEAg
LTExNCwyNSArMTE0LDYgQEAgZW51bSBDb2xvcmltZXRyeVlDQ0RQIHsNCj4gPiAgICAgICBDb2xv
cmltZXRyeVlDQ19EUF9JVFUyMDIwWUNiQ3IgID0gNywgIH07DQo+ID4NCj4gPiAtdm9pZCBzZXRG
aWVsZFdpdGhNYXNrKHVuc2lnbmVkIGNoYXIgKmRlc3QsIHVuc2lnbmVkIGludCBtYXNrLCANCj4g
PiB1bnNpZ25lZCBpbnQgdmFsdWUpIC17DQo+ID4gLSAgICAgdW5zaWduZWQgaW50IHNoaWZ0ID0g
MDsNCj4gPiAtDQo+ID4gLSAgICAgaWYgKCFtYXNrIHx8ICFkZXN0KQ0KPiA+IC0gICAgICAgICAg
ICAgcmV0dXJuOw0KPiA+IC0NCj4gPiAtICAgICB3aGlsZSAoISgobWFzayA+PiBzaGlmdCkgJiAx
KSkNCj4gPiAtICAgICAgICAgICAgIHNoaWZ0Kys7DQo+ID4gLQ0KPiA+IC0gICAgIC8vcmVzZXQN
Cj4gPiAtICAgICAqZGVzdCA9ICpkZXN0ICYgfm1hc2s7DQo+ID4gLSAgICAgLy9zZXQNCj4gPiAt
ICAgICAvL2RvbnQgbGV0IHZhbHVlIHNwYW4gcGFzdCBtYXNrDQo+ID4gLSAgICAgdmFsdWUgPSB2
YWx1ZSAmIChtYXNrID4+IHNoaWZ0KTsNCj4gPiAtICAgICAvL2luc2VydCB2YWx1ZQ0KPiA+IC0g
ICAgICpkZXN0ID0gKmRlc3QgfCAodmFsdWUgPDwgc2hpZnQpOw0KPiA+IC19DQo+ID4gLQ0KPiA+
ICB2b2lkIG1vZF9idWlsZF92c2NfaW5mb3BhY2tldChjb25zdCBzdHJ1Y3QgZGNfc3RyZWFtX3N0
YXRlICpzdHJlYW0sDQo+ID4gICAgICAgICAgICAgICBzdHJ1Y3QgZGNfaW5mb19wYWNrZXQgKmlu
Zm9fcGFja2V0KSAgew0KPiA+DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGFtZC1nZnggbWFpbGluZyBsaXN0DQo+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeA0K
