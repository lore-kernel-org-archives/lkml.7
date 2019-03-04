Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D8AC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E7B20815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="bKm2oYIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfCDOqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:46:24 -0500
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:60688
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbfCDOqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+8HsJtUDHK7SgwjwLRucT4ahRLgtPyQQRmHQ/jjSI0=;
 b=bKm2oYIb24XUB5BSc0s33f4uGwQEmmyOnezb3MgeH+BEDtLaI5D0iIyQeosQ5uq/cw2xo9jBLlqClS9NIp2QLkZ+FeQlZCnFIDndNT4He7wM+VIU3m+Jkks8Z22IBne2PEAMAMw1nxwNzZBK9mcOE3SDrM57CkW+feF8pgsZubo=
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com (20.178.139.140) by
 TYAPR01MB2845.jpnprd01.prod.outlook.com (20.177.103.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.18; Mon, 4 Mar 2019 14:46:17 +0000
Received: from TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73]) by TYAPR01MB4015.jpnprd01.prod.outlook.com
 ([fe80::4c6e:195:8a7f:bc73%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 14:46:17 +0000
From:   Gareth Williams <gareth.williams.jx@renesas.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Phil Edworthy <phil.edworthy@renesas.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Thread-Topic: [PATCH 2/2] spi: dw: Add support for an optional interface clock
Thread-Index: AQHUz2mB+efpD2BRfU+BuNckEODyBqX6nN6AgADvqXA=
Date:   Mon, 4 Mar 2019 14:46:17 +0000
Message-ID: <TYAPR01MB401511AAAB1784BB50D9A35BDF710@TYAPR01MB4015.jpnprd01.prod.outlook.com>
References: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
 <1551360342-23981-3-git-send-email-gareth.williams.jx@renesas.com>
 <20190304000433.GO23441@sirena.org.uk>
In-Reply-To: <20190304000433.GO23441@sirena.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gareth.williams.jx@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ae31535-edf0-46ba-405d-08d6a0b0286e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYAPR01MB2845;
x-ms-traffictypediagnostic: TYAPR01MB2845:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;TYAPR01MB2845;20:0JeR1s5aCUAJMsLVayn1fbf9wMOIj4251kC7zyJsqur2e/W9uiOBUl4HvMy1e8jQhxjLERg0tnOM+CFa+TssN0KZDJGJZNav7Z+uRNLszMrveAMGs24q86ztzCxtbnS350WlArIeyM/nGkIiYIcCM+tPF8SUvwbmgdA1OQsRbN8=
x-microsoft-antispam-prvs: <TYAPR01MB2845D851F005875E5E365F7CDF710@TYAPR01MB2845.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(136003)(396003)(366004)(199004)(189003)(25786009)(4326008)(99286004)(478600001)(102836004)(81156014)(81166006)(8676002)(8936002)(446003)(97736004)(486006)(476003)(186003)(11346002)(14454004)(9686003)(6436002)(86362001)(6306002)(14444005)(256004)(53936002)(53546011)(6506007)(71190400001)(71200400001)(7696005)(2906002)(76176011)(55016002)(54906003)(316002)(26005)(5660300002)(6246003)(66066001)(3846002)(6116002)(229853002)(105586002)(966005)(305945005)(6916009)(52536013)(74316002)(33656002)(7736002)(68736007)(106356001);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2845;H:TYAPR01MB4015.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: c3Tb7kaGkiI3CUroNtOQoY7Bbc5/CyUVnMQHngLhVkPd/wvha6MhrqyORZ4EHPvjlGjVHmFleWguVO/zKZMOupF5B5odyZ39vO+ENKLYv/fwgoLEG09ytE4yEa1gQa28IhWuKcaqZJj81E5uvr9O/fEeMSSOlK03q/oLL9nXZiD73wJdrTjNj9OkfdgP/O3qDr9XzRVoQLDMwn0HP3QElHPl96529M3+wMo6IuDm/qQHO2dBKA1drpeNSI6NxN3Syv3YhggDl+JPZa+sEpdbr91gS+6yShEAvTQxOlA+pkyhHK85CebhqI2Z9qOWK2RaHCbarbNdtbd0KfLG7k95NCJ2oovEQQ5Jio14wf7a/VaK7GQ41A4bS2W9GIMXAB6T/Aj1Xi0k8NIX04WWUxr44xMXbgt1zi4s1DRKD06RAj8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae31535-edf0-46ba-405d-08d6a0b0286e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 14:46:17.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2845
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyaywNCg0KPiBPbiBNb24sIE1hciAwNCwgMjAxOSAwMDowNTowMCwgTWFyayBCcm93biB3
cm90ZToNCj4NCj4gT24gVGh1LCBGZWIgMjgsIDIwMTkgYXQgMDE6MjU6NDJQTSArMDAwMCwgR2Fy
ZXRoIFdpbGxpYW1zIHdyb3RlOg0KPiA+IEZyb206IFBoaWwgRWR3b3J0aHkgPHBoaWwuZWR3b3J0
aHlAcmVuZXNhcy5jb20+DQo+ID4NCj4gPiBUaGUgU3lub3BzeXMgU1NJIENvbnRyb2xsZXIgaGFz
IGFuIGludGVyZmFjZSBjbG9jaywgYnV0IG1vc3QgU29DcyBoaWRlDQo+ID4gdGhpcyBhd2F5LiBI
b3dldmVyLCBvbiBzb21lIFNvQ3MgeW91IG5lZWQgdG8gZXhwbGljaXR5IGVuYWJsZSB0aGUNCj4g
PiBpbnRlcmZhY2UgY2xvY2sgaW4gb3JkZXIgdG8gYWNjZXNzIHRoZSByZWdpc3RlcnMuIFRoZXJl
Zm9yZSwgYWRkDQo+ID4gc3VwcG9ydCBmb3IgYW4gb3B0aW9uYWwgaW50ZXJmYWNlIGNsb2NrLg0K
Pg0KPiBUaGlzIGRvZXNuJ3QgYnVpbGQgZm9yIG1lOg0KPg0KPiAgIENDICAgICAgZHJpdmVycy9z
cGkvc3BpLWR3LW1taW8ubw0KPiBkcml2ZXJzL3NwaS9zcGktZHctbW1pby5jOiBJbiBmdW5jdGlv
biDigJhkd19zcGlfbW1pb19wcm9iZeKAmToNCj4gZHJpdmVycy9zcGkvc3BpLWR3LW1taW8uYzox
Nzc6MTg6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbg0KPiDigJhkZXZt
X2Nsa19nZXRfb3B0aW9uYWzigJk7IGRpZCB5b3UgbWVhbiDigJhkZXZtX2dwaW9kX2dldF9vcHRp
b25hbOKAmT8gWy0NCj4gV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQ0KPiAg
IGR3c21taW8tPnBjbGsgPSBkZXZtX2Nsa19nZXRfb3B0aW9uYWwoJnBkZXYtPmRldiwgInBjbGsi
KTsNCj4gICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ICAgICAgICAg
ICAgICAgICAgIGRldm1fZ3Bpb2RfZ2V0X29wdGlvbmFsDQo+IGRyaXZlcnMvc3BpL3NwaS1kdy1t
bWlvLmM6MTc3OjE2OiB3YXJuaW5nOiBhc3NpZ25tZW50IHRvIOKAmHN0cnVjdCBjbGsgKuKAmSBm
cm9tDQo+IOKAmGludOKAmSBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2Fz
dCBbLVdpbnQtY29udmVyc2lvbl0NCj4gICBkd3NtbWlvLT5wY2xrID0gZGV2bV9jbGtfZ2V0X29w
dGlvbmFsKCZwZGV2LT5kZXYsICJwY2xrIik7DQo+ICAgICAgICAgICAgICAgICBeDQpTb3JyeSwg
SSBzaG91bGQgaGF2ZSBub3RlZCB0aGUgZGVwZW5kZW5jeSBmb3IgdGhlIHBhdGNoIGJlbG93LiBJ
IHdpbGwgYWRkIHRoaXMgaW50byB0aGUgbmV4dCB2ZXJzaW9uLg0KaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV4dC9saW51eC1uZXh0LmdpdC9jb21taXQv
ZHJpdmVycy9jbGsvY2xrLWRldnJlcy5jP2g9bmV4dC0yMDE5MDMwNCZpZD02MGI4ZjBkZGYxYTky
N2VmMDIxNDFhNjYxMGZkNTI1NzUxMzRmODIxDQoNCktpbmQgUmVnYXJkcywNCg0KR2FyZXRoDQoN
Cg0KUmVuZXNhcyBFbGVjdHJvbmljcyBFdXJvcGUgR21iSCxHZXNjaGFlZnRzZnVlaHJlci9QcmVz
aWRlbnQgOiBNaWNoYWVsIEhhbm5hd2FsZCwgU2l0eiBkZXIgR2VzZWxsc2NoYWZ0L1JlZ2lzdGVy
ZWQgb2ZmaWNlOiBEdWVzc2VsZG9yZiwgQXJjYWRpYXN0cmFzc2UgMTAsIDQwNDcyIER1ZXNzZWxk
b3JmLCBHZXJtYW55LEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdGVyOiBEdWVzc2Vs
ZG9yZiwgSFJCIDM3MDggVVN0LUlETnIuL1RheCBpZGVudGlmaWNhdGlvbiBuby46IERFIDExOTM1
MzQwNiBXRUVFLVJlZy4tTnIuL1dFRUUgcmVnLiBuby46IERFIDE0OTc4NjQ3DQo=
