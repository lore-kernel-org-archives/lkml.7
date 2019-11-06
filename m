Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93CC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B56420663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 14:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NmV/qBHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbfKFOLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:11:52 -0500
Received: from mail-eopbgr820071.outbound.protection.outlook.com ([40.107.82.71]:47168
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727324AbfKFOLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:11:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gb3q5+ZXtsbEowFkJoJ1hEj55bniFolDO3tV1UJGRsNtv61wVnZZamFtGTbU9meemA1c/0OKCD4crkNR1Cwy2iQ0HItXZFHES0vegi1f4mmx7qJGLZvKaBmh2g7i0w1j0NeYvm50paBKCQ4XhsOLdWwMCm7OaS4myRJFvRTAQaWQp6Zjv/Gty21RVnNa0WKoz3eCM0eeoalFZbKSUlB8jzTkBIZhMX+UiJR/cWZJIyUVM2mPf8Xc4nJlp1KuPjNa2mcUWj/q0RyUMVnGP2uHEx4ff+qDEIiax8Z2gWuIL0ahsghJ2MyEMNo6Z724ZN4F0gZeKlZqJ8Z1L+FFwaE1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp9kQEDYX0SpxpQtWF2qtsG7fcRv5YICmBbHD7Ksilg=;
 b=QXb4zRskAR4olGjqbD0t/SaiqvgQCVsriCgKXuUdFC+9yAEPdNauwqhotMwdsVwJQaGJDOU0/5uMACWa+UucbXODppa2wDzv6xsZpLdT2rrv6l02f+NWh65Y7aJ9VB3z+eLL8QbH8x3KEW9YWyUOsrt6SSUPP8z+QYXVtsCc/OEn87nzKQ+DnZ7d+MnpaDy4cpZhpBr3KAXGlOfZ3GVqlW056HMJmcDQjGyvJ6EnLyjN+fhA+WPFle71BV0br1604CNBLaKjmA+iwcPm0kGQisHo/0KvjZdeVDyOcSpYteD/orju+1PBKCDWWa1bPNjlt4hIjp9qMnyoltCRaJwezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp9kQEDYX0SpxpQtWF2qtsG7fcRv5YICmBbHD7Ksilg=;
 b=NmV/qBHfUJhb0LvOpc6Rj/1dGGO2StHbZCnB2RLauFfVEGUVzfFucFEjlBht1oicza2FR0XbYMhZpRDvB7UwAq9D/1gRQW0XLDh1IJqPYftZ+lk8851GC/1yf61OWJmv2XGKmXqd4amS2gF0PlnzEhWACPVzGNF35+Z12KB25iw=
Received: from DM6PR12MB3868.namprd12.prod.outlook.com (10.255.173.213) by
 DM6PR12MB4235.namprd12.prod.outlook.com (10.141.8.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 6 Nov 2019 14:11:47 +0000
Received: from DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843]) by DM6PR12MB3868.namprd12.prod.outlook.com
 ([fe80::ac0a:4c84:7bb:2843%5]) with mapi id 15.20.2430.020; Wed, 6 Nov 2019
 14:11:47 +0000
From:   vishnu <vravulap@amd.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
CC:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] ASoC: amd: ACP powergating should be done by
 controller
Thread-Topic: [PATCH 6/7] ASoC: amd: ACP powergating should be done by
 controller
Thread-Index: AQHVhZzSniHALHuA0kOzcVkkYwwFe6dgNVMAgB7N+QA=
Date:   Wed, 6 Nov 2019 14:11:46 +0000
Message-ID: <37667547-5b85-be25-df5d-39431b4b287a@amd.com>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-6-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191018103910.GL21344@kadam>
In-Reply-To: <20191018103910.GL21344@kadam>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:d::22) To DM6PR12MB3868.namprd12.prod.outlook.com
 (2603:10b6:5:1c8::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Vishnuvardhanrao.Ravulapati@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.159.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d017786f-d7e4-483e-d06e-08d762c34245
x-ms-traffictypediagnostic: DM6PR12MB4235:|DM6PR12MB4235:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4235C5617684B32011D19365E7790@DM6PR12MB4235.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(199004)(189003)(99286004)(81156014)(81166006)(8676002)(316002)(8936002)(2906002)(110136005)(54906003)(3846002)(6116002)(36756003)(25786009)(478600001)(14454004)(26005)(102836004)(66066001)(386003)(486006)(53546011)(6506007)(31696002)(2616005)(476003)(446003)(11346002)(7736002)(229853002)(71200400001)(71190400001)(256004)(6636002)(186003)(52116002)(305945005)(76176011)(6486002)(5660300002)(64756008)(66476007)(66556008)(66446008)(66946007)(31686004)(6512007)(4326008)(6246003)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB4235;H:DM6PR12MB3868.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZuC2hf0/7Vlf9ilKB8Ikhrkzk+Mx/OK4v+0+5gQgY2capj3dIT8GdUQ9DSLN2rOi+afCBApzdDNCb1LVc6BLiBbVcpOv6eZD4NYiN7aqcDvWPe/A/3s2hkgeg9f2qULcGc31/2MPcm1o8iyfI8mO7noEMGf9Hw9rqQn2R14jEXqB+m1yFuUi+aJckBA3wTA0Ae3ohpbUsG3HsH+SnbWYtQudcq558iANQ5fPHnEXwHZ91rvHd5dtIXyRLj3smf4+1/L2ITcGOyPHqbPFYEvxAEhNax7Y00z1Z1aYtGPUW8RCOPAYn9E99Vmlpu0Ewr6jNxAp4c4A4xGK/25APsD5fuaIC2u1Ps4DUW0uERuJtyKfPII2fb1TyBJOTtMlMJFLGVtP5TeZzl0xkNl0hb4aXAqoqx7mKzJiN5z/B67EwpiKpPXECwMsTWoCodUc+zNo
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E6B0AC370004A4895113F3306285261@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d017786f-d7e4-483e-d06e-08d762c34245
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 14:11:47.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuqRM8nqN1X5Ax3LMdxi6TTUyc98aIQMO8OCZPHVc2ooVOq39mtE45xNZ7acdBITThlmqLtOP2OSSmLQd9C07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LzEwLzE5IDQ6MDkgUE0sIERhbiBDYXJwZW50ZXIgd3JvdGU6DQo+IE9uIFNhdCwg
T2N0IDE5LCAyMDE5IGF0IDAyOjM1OjQ0QU0gKzA1MzAsIFJhdnVsYXBhdGkgVmlzaG51IHZhcmRo
YW4gcmFvIHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hbWQvcmF2ZW4vcGNpLWFj
cDN4LmMgYi9zb3VuZC9zb2MvYW1kL3JhdmVuL3BjaS1hY3AzeC5jDQo+PiBpbmRleCA3ZjQzNWIz
Li5iNzRlY2Y2IDEwMDY0NA0KPj4gLS0tIGEvc291bmQvc29jL2FtZC9yYXZlbi9wY2ktYWNwM3gu
Yw0KPj4gKysrIGIvc291bmQvc29jL2FtZC9yYXZlbi9wY2ktYWNwM3guYw0KPj4gQEAgLTE5LDEx
ICsxOSwxNDAgQEAgc3RydWN0IGFjcDN4X2Rldl9kYXRhIHsNCj4+ICAgCXN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKnBkZXZbQUNQM3hfREVWU107DQo+PiAgIH07DQo+PiAgIA0KPj4gK3N0YXRpYyBp
bnQgYWNwM3hfcG93ZXJfb24odm9pZCBfX2lvbWVtICphY3AzeF9iYXNlKQ0KPj4gK3sNCj4+ICsJ
dTMyIHZhbDsNCj4+ICsJdTMyIHRpbWVvdXQgPSAwOw0KPj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsN
Cj4+ICsJdmFsID0gcnZfcmVhZGwoYWNwM3hfYmFzZSArIG1tQUNQX1BHRlNNX1NUQVRVUyk7DQo+
PiArCWlmICh2YWwpIHsNCj4gDQo+IEp1c3QgZmxpcCB0aGlzIGFyb3VuZC4NCldpbGwgYWRkcmVz
cyB0aGlzIHRoYW5rcy4NCj4gDQo+IAlpZiAodmFsID09IDApDQo+IAkJcmV0dXJuIDA7DQo+IA0K
Pj4gKwkJaWYgKCEoKHZhbCAmIEFDUF9QR0ZTTV9TVEFUVVNfTUFTSykgPT0NCj4+ICsJCQkJQUNQ
X1BPV0VSX09OX0lOX1BST0dSRVNTKSkNCj4+ICsJCQlydl93cml0ZWwoQUNQX1BHRlNNX0NOVExf
UE9XRVJfT05fTUFTSywNCj4+ICsJCQkJYWNwM3hfYmFzZSArIG1tQUNQX1BHRlNNX0NPTlRST0wp
Ow0KPj4gKwkJd2hpbGUgKHRydWUpIHsNCj4gDQo+IHdoaWxlICgrK3RpbWVvdXQgPCA1MDApIHsN
Cj4gDQo+IA0KPj4gKwkJCXZhbCAgPSBydl9yZWFkbChhY3AzeF9iYXNlICsgbW1BQ1BfUEdGU01f
U1RBVFVTKTsNCj4+ICsJCQlpZiAoIXZhbCkNCj4+ICsJCQkJYnJlYWs7DQo+IA0KPiByZXR1cm4g
MDsNCj4gDQo+PiArCQkJdWRlbGF5KDEpOw0KPj4gKwkJCWlmICh0aW1lb3V0ID4gNTAwKSB7DQo+
PiArCQkJCXByX2VycigiQUNQIGlzIE5vdCBQb3dlcmVkIE9OXG4iKTsNCj4+ICsJCQkJcmV0ID0g
LUVUSU1FRE9VVDsNCj4+ICsJCQkJYnJlYWs7DQo+PiArCQkJfQ0KPj4gKwkJCXRpbWVvdXQrKzsN
Cj4+ICsJCX0NCj4+ICsJCWlmIChyZXQpIHsNCj4+ICsJCQlwcl9lcnIoIkFDUCBpcyBub3QgcG93
ZXJlZCBvbiBzdGF0dXM6JWRcbiIsIHJldCk7DQo+IA0KPiBKdXN0IG9uZSBlcnJvciBtZXNzYWdl
IGlzIGVub3VnaC4NCldpbGwgYWRkcmVzcyB0aGlzIHRoYW5rcy4NCj4gDQo+IAlwcl9lcnIoIkFD
UCBpcyBOb3QgUG93ZXJlZCBPTlxuIik7DQo+IAlyZXR1cm4gLUVUSU1FRE9VVDsNCj4gDQo+IA0K
Pj4gKwkJCXJldHVybiByZXQ7DQo+PiArCQl9DQo+PiArCX0NCj4+ICsJcmV0dXJuIHJldDsNCj4+
ICt9DQo+PiArDQo+PiArc3RhdGljIGludCBhY3AzeF9wb3dlcl9vZmYodm9pZCBfX2lvbWVtICph
Y3AzeF9iYXNlKQ0KPj4gK3sNCj4+ICsJdTMyIHZhbDsNCj4+ICsJdTMyIHRpbWVvdXQgPSAwOw0K
Pj4gKwlpbnQgcmV0ID0gMDsNCj4+ICsNCj4+ICsJdmFsID0gcnZfcmVhZGwoYWNwM3hfYmFzZSAr
IG1tQUNQX1BHRlNNX0NPTlRST0wpOw0KPiANCj4gdmFsIGlzIG5vdCB1c2VkLiAgV2Ugd2FudCB0
byB0dXJuIG9uIHNldCBidXQgbm90IHVzZWQgd2FybmluZ3MNCj4gZXZlbnR1YWxseS4NCj4gDQpX
aWxsIGFkZHJlc3MgdGhpcyB0aGFua3MuDQo+PiArCXJ2X3dyaXRlbChBQ1BfUEdGU01fQ05UTF9Q
T1dFUl9PRkZfTUFTSywNCj4+ICsJCQlhY3AzeF9iYXNlICsgbW1BQ1BfUEdGU01fQ09OVFJPTCk7
DQo+PiArCXdoaWxlICh0cnVlKSB7DQo+PiArCQl2YWwgID0gcnZfcmVhZGwoYWNwM3hfYmFzZSAr
IG1tQUNQX1BHRlNNX1NUQVRVUyk7DQo+PiArCQlpZiAoKHZhbCAmIEFDUF9QR0ZTTV9TVEFUVVNf
TUFTSykgPT0gQUNQX1BPV0VSRURfT0ZGKQ0KPj4gKwkJCWJyZWFrOw0KPj4gKwkJdWRlbGF5KDEp
Ow0KPj4gKwkJaWYgKHRpbWVvdXQgPiA1MDApIHsNCj4+ICsJCQlwcl9lcnIoIkFDUCBpcyBOb3Qg
UG93ZXJlZCBPRkZcbiIpOw0KPj4gKwkJCXJldCA9IC1FVElNRURPVVQ7DQo+PiArCQkJYnJlYWs7
DQo+PiArCQl9DQo+PiArCQl0aW1lb3V0Kys7DQo+PiArCX0NCj4+ICsJaWYgKHJldCkNCj4+ICsJ
CXByX2VycigiQUNQIGlzIG5vdCBwb3dlcmVkIG9mZiBzdGF0dXM6JWRcbiIsIHJldCk7DQo+PiAr
CXJldHVybiByZXQ7DQo+IA0KPiBTYW1lIGFzIGFib3ZlLg0KPiANCldpbGwgYWRkcmVzcyB0aGlz
IHRoYW5rcy4NCj4+ICt9DQo+PiArDQo+PiArDQo+PiArc3RhdGljIGludCBhY3AzeF9yZXNldCh2
b2lkIF9faW9tZW0gKmFjcDN4X2Jhc2UpDQo+PiArew0KPj4gKwl1MzIgdmFsLCB0aW1lb3V0Ow0K
Pj4gKw0KPj4gKwlydl93cml0ZWwoMSwgYWNwM3hfYmFzZSArIG1tQUNQX1NPRlRfUkVTRVQpOw0K
Pj4gKwl0aW1lb3V0ID0gMDsNCj4+ICsJd2hpbGUgKHRydWUpIHsNCj4gDQo+IAl3aGlsZSAoKyt0
aW1lb3V0IDwgMTAwKSB7DQo+IA0KPj4gKwkJdmFsID0gcnZfcmVhZGwoYWNwM3hfYmFzZSArIG1t
QUNQX1NPRlRfUkVTRVQpOw0KPj4gKwkJaWYgKCh2YWwgJiBBQ1AzeF9TT0ZUX1JFU0VUX19Tb2Z0
UmVzZXRBdWREb25lX01BU0spIHx8DQo+PiArCQkJCQkJCXRpbWVvdXQgPiAxMDApIHsNCj4+ICsJ
CQlpZiAodmFsICYgQUNQM3hfU09GVF9SRVNFVF9fU29mdFJlc2V0QXVkRG9uZV9NQVNLKQ0KPj4g
KwkJCQlicmVhazsNCj4gDQo+IA0KPiBEdXBsaWNhdGVkIG5lZWRsZXNzbHkuDQpBY3R1YWxseSBo
YXZlIHRoZSBzZXF1ZW5jZSBsaWtlIHRoYXQuDQpGaXJzdCB3ZSBoYXZlIHRvIHNldCBtbUFDUF9T
T0ZUX1JFU0VUIHdpdGggMSB0aGVuIHdlIG5lZWQgdG8gY2hlY2sgaXRzIA0KZWZmZWN0IGZyb20g
cmVhZGluZyBzYW1lIHJlZ2lzdGVyIGFuZCB3YWl0IHRpbGwgdGltZW91dCBpZiBlcnJvciBvY2N1
cnMgDQphbmQgdGhlbiBpbW1lZGlhdGx5IHdlIG5lZWQgdG8gcmVzZXQgd2l0aCAwIGFuZCByZWFk
IHRoZSByZXNldCByZWdpc3RlciANCmlmIGl0IGlzIG5vdCByZXNldCB3ZSB3aWxsIHdhaXQgdGls
bCB0aW1lb3V0IGFuZCBleGl0IHdpdGggZXJyb3IuDQoNCldpbGwgYWRkcmVzcyB0aGlzIGJ5IGNo
YW5naW5nIHRoZSBkdXBsaWNhdGlvbiBjb2RlIHRoYW5rcy4NCj4gDQo+PiArCQkJcmV0dXJuIC1F
Tk9ERVY7DQo+PiArCQl9DQo+PiArCQl0aW1lb3V0Kys7DQo+PiArCQljcHVfcmVsYXgoKTsNCj4+
ICsJfQ0KPiANCj4gDQo+IAlpZiAodGltZW91dCA9PSAxMDApDQo+IAkJcmV0dXJuIC1FTk9ERVY7
DQo+IA0KPj4gKwlydl93cml0ZWwoMCwgYWNwM3hfYmFzZSArIG1tQUNQX1NPRlRfUkVTRVQpOw0K
Pj4gKwl0aW1lb3V0ID0gMDsNCj4+ICsJd2hpbGUgKHRydWUpIHsNCj4+ICsJCXZhbCA9IHJ2X3Jl
YWRsKGFjcDN4X2Jhc2UgKyBtbUFDUF9TT0ZUX1JFU0VUKTsNCj4gDQo+IFNwbGl0IHRoZSAiaWYg
KCF2YWwpIGJyZWFrOyIgaW50byBpdCdzIG93biBjb25kaXRpb24gaW5zdGVhZCBvZiBwYXJ0IG9m
DQo+IHRoZSB8fC4NCj4gDQpXaWxsIGFkZHJlc3MgdGhpcyB0aGFua3MuDQo+PiArCQlpZiAoIXZh
bCB8fCB0aW1lb3V0ID4gMTAwKSB7DQo+PiArCQkJaWYgKCF2YWwpDQo+PiArCQkJCWJyZWFrOw0K
Pj4gKwkJCXJldHVybiAtRU5PREVWOw0KPj4gKwkJfQ0KPj4gKwkJdGltZW91dCsrOw0KPj4gKwkJ
Y3B1X3JlbGF4KCk7DQo+PiArCX0NCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0
YXRpYyBpbnQgYWNwM3hfaW5pdCh2b2lkIF9faW9tZW0gKmFjcDN4X2Jhc2UpDQo+PiArew0KPj4g
KwlpbnQgcmV0Ow0KPj4gKw0KPj4gKwkvKiBwb3dlciBvbiAqLw0KPj4gKwlyZXQgPSBhY3AzeF9w
b3dlcl9vbihhY3AzeF9iYXNlKTsNCj4+ICsJaWYgKHJldCkgew0KPj4gKwkJcHJfZXJyKCJBQ1Az
eCBwb3dlciBvbiBmYWlsZWRcbiIpOw0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsJfQ0KPj4gKwkv
KiBSZXNldCAqLw0KPj4gKwlyZXQgPSBhY3AzeF9yZXNldChhY3AzeF9iYXNlKTsNCj4+ICsJaWYg
KHJldCkgew0KPj4gKwkJcHJfZXJyKCJBQ1AzeCByZXNldCBmYWlsZWRcbiIpOw0KPj4gKwkJcmV0
dXJuIHJldDsNCj4+ICsJfQ0KPj4gKwlyZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiArc3RhdGlj
IGludCBhY3AzeF9kZWluaXQodm9pZCBfX2lvbWVtICphY3AzeF9iYXNlKQ0KPj4gK3sNCj4+ICsJ
aW50IHJldDsNCj4+ICsNCj4+ICsJLyogUmVzZXQgKi8NCj4+ICsJcmV0ID0gYWNwM3hfcmVzZXQo
YWNwM3hfYmFzZSk7DQo+PiArCWlmIChyZXQpIHsNCj4+ICsJCXByX2VycigiQUNQM3ggcmVzZXQg
ZmFpbGVkXG4iKTsNCj4+ICsJCXJldHVybiByZXQ7DQo+PiArCX0NCj4+ICsJLyogcG93ZXIgb2Zm
ICovDQo+PiArCXJldCA9IGFjcDN4X3Bvd2VyX29mZihhY3AzeF9iYXNlKTsNCj4+ICsJaWYgKHJl
dCkgew0KPj4gKwkJcHJfZXJyKCJBQ1AzeCBwb3dlciBvZmYgZmFpbGVkXG4iKTsNCj4+ICsJCXJl
dHVybiByZXQ7DQo+PiArCX0NCj4+ICsJcmV0dXJuIDA7DQo+PiArfQ0KPj4gKw0KPj4gICBzdGF0
aWMgaW50IHNuZF9hY3AzeF9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGNpLA0KPj4gICAJCQkgICBj
b25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqcGNpX2lkKQ0KPj4gICB7DQo+PiAgIAlpbnQgcmV0
Ow0KPj4gLQl1MzIgYWRkciwgdmFsLCBpOw0KPj4gKwl1MzIgYWRkciwgdmFsLCBpLCBzdGF0dXM7
DQo+PiAgIAlzdHJ1Y3QgYWNwM3hfZGV2X2RhdGEgKmFkYXRhOw0KPj4gICAJc3RydWN0IHBsYXRm
b3JtX2RldmljZV9pbmZvIHBkZXZpbmZvW0FDUDN4X0RFVlNdOw0KPj4gICAJdW5zaWduZWQgaW50
IGlycWZsYWdzOw0KPj4gQEAgLTYzLDYgKzE5MiwxMCBAQCBzdGF0aWMgaW50IHNuZF9hY3AzeF9w
cm9iZShzdHJ1Y3QgcGNpX2RldiAqcGNpLA0KPj4gICAJfQ0KPj4gICAJcGNpX3NldF9tYXN0ZXIo
cGNpKTsNCj4+ICAgCXBjaV9zZXRfZHJ2ZGF0YShwY2ksIGFkYXRhKTsNCj4+ICsJc3RhdHVzID0g
YWNwM3hfaW5pdChhZGF0YS0+YWNwM3hfYmFzZSk7DQo+PiArCWlmIChzdGF0dXMpDQo+PiArCQly
ZXR1cm4gLUVOT0RFVjsNCj4gDQo+IFdoeSBkbyB3ZSBuZWVkIGJvdGggInN0YXR1cyIgYW5kICJy
ZXQiLiAgUHJlc2VydmUgdGhlIGVycm9yIGNvZGU/DQo+IA0KV2lsbCBhZGRyZXNzIHRoaXMgdGhh
bmtzLg0KPj4gKw0KPj4gICANCj4+ICAgCXZhbCA9IHJ2X3JlYWRsKGFkYXRhLT5hY3AzeF9iYXNl
ICsgbW1BQ1BfSTJTX1BJTl9DT05GSUcpOw0KPj4gICAJc3dpdGNoICh2YWwpIHsNCj4+IEBAIC0x
MzIsNiArMjY1LDExIEBAIHN0YXRpYyBpbnQgc25kX2FjcDN4X3Byb2JlKHN0cnVjdCBwY2lfZGV2
ICpwY2ksDQo+PiAgIAlyZXR1cm4gMDsNCj4+ICAgDQo+PiAgIHVubWFwX21taW86DQo+PiArCXN0
YXR1cyA9IGFjcDN4X2RlaW5pdChhZGF0YS0+YWNwM3hfYmFzZSk7DQo+PiArCWlmIChzdGF0dXMp
DQo+PiArCQlkZXZfZXJyKCZwY2ktPmRldiwgIkFDUCBkZS1pbml0IGZhaWxlZFxuIik7DQo+PiAr
CWVsc2UNCj4+ICsJCWRldl9pbmZvKCZwY2ktPmRldiwgIkFDUCBkZS1pbml0aWFsaXplZFxuIik7
DQo+PiAgIAlmb3IgKGkgPSAwIDsgaSA8IEFDUDN4X0RFVlMgOyBpKyspDQo+PiAgIAkJcGxhdGZv
cm1fZGV2aWNlX3VucmVnaXN0ZXIoYWRhdGEtPnBkZXZbaV0pOw0KPj4gICAJa2ZyZWUoYWRhdGEt
PnJlcyk7DQo+PiBAQCAtMTUzLDYgKzI5MSwxMSBAQCBzdGF0aWMgdm9pZCBzbmRfYWNwM3hfcmVt
b3ZlKHN0cnVjdCBwY2lfZGV2ICpwY2kpDQo+PiAgIAkJZm9yIChpID0gMCA7IGkgPCAgQUNQM3hf
REVWUyA7IGkrKykNCj4+ICAgCQkJcGxhdGZvcm1fZGV2aWNlX3VucmVnaXN0ZXIoYWRhdGEtPnBk
ZXZbaV0pOw0KPj4gICAJfQ0KPj4gKwlpID0gYWNwM3hfZGVpbml0KGFkYXRhLT5hY3AzeF9iYXNl
KTsNCj4gDQo+IFBsZWFzZSBkb24ndCByZS11c2UgImkiIGxpa2UgdGhpcy4gIERlY2xhcmUgInJl
dCIgb3IgInN0YXR1cyIgb3INCj4gc29tZXRoaW5nLg0KPiANCldpbGwgYWRkcmVzcyB0aGlzIHRo
YW5rcy4NCj4+ICsJaWYgKGkpDQo+PiArCQlkZXZfZXJyKCZwY2ktPmRldiwgIkFDUCBkZS1pbml0
IGZhaWxlZFxuIik7DQo+PiArCWVsc2UNCj4+ICsJCWRldl9pbmZvKCZwY2ktPmRldiwgIkFDUCBk
ZS1pbml0aWFsaXplZFxuIik7DQo+PiAgIAlpb3VubWFwKGFkYXRhLT5hY3AzeF9iYXNlKTsNCj4+
ICAgDQo+PiAgIAlwY2lfZGlzYWJsZV9tc2kocGNpKTsNCj4gDQo+IHJlZ2FyZHMsDQo+IGRhbiBj
YXJwZW50ZXINCj4gDQpSZWdhcmRzLA0KVmlzaG51DQo=
