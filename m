Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A3CC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2388420883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gAsu4cbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfDHKGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:06:22 -0400
Received: from mail-eopbgr40069.outbound.protection.outlook.com ([40.107.4.69]:4420
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfDHKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zukMmPlvmPM0cbuxNlM532MgdxwIvuwIZAAM91njrxo=;
 b=gAsu4cbmW7SyG9gAre6rBSvHbK6e9a9S7GgPZ7L8YjUg8z6NwIUL/D7x1jFigRswB+gQ4jVdYmmH1UTUcmf3W+O+xXL5VLOnfqsKZq5h0InU0dc37l0vyZVoWXKksX/x3wU3YY+4xr6NUoggcv9sF9YlkrGkbxUjmaaL5eKPctQ=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5934.eurprd04.prod.outlook.com (20.178.205.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Mon, 8 Apr 2019 10:06:15 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df%5]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 10:06:15 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Andy Tang <andy.tang@nxp.com>
Subject: RE: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Topic: [v7 3/3] ahci: qoriq: add lx2160 platforms support
Thread-Index: AQHU2HbclXKnAjThkU+5mzIwr26m+6YyLTYQ
Date:   Mon, 8 Apr 2019 10:06:15 +0000
Message-ID: <VI1PR04MB44310DDDF2D981F0BC0D7381ED2C0@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190312015019.30628-1-peng.ma@nxp.com>
 <20190312015019.30628-3-peng.ma@nxp.com>
In-Reply-To: <20190312015019.30628-3-peng.ma@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66973eb4-8242-47c0-0040-08d6bc09d680
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5934;
x-ms-traffictypediagnostic: VI1PR04MB5934:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR04MB5934E4E3BBFDF9019561B798ED2C0@VI1PR04MB5934.eurprd04.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(346002)(136003)(366004)(189003)(13464003)(199004)(68736007)(3846002)(105586002)(2501003)(53936002)(2906002)(9686003)(4326008)(44832011)(106356001)(6246003)(33656002)(14454004)(55016002)(6116002)(54906003)(6306002)(52536014)(71190400001)(81166006)(316002)(71200400001)(81156014)(8936002)(8676002)(110136005)(478600001)(966005)(446003)(476003)(25786009)(11346002)(186003)(74316002)(305945005)(7736002)(5660300002)(6636002)(229853002)(26005)(76176011)(99286004)(102836004)(6436002)(256004)(486006)(97736004)(86362001)(7696005)(66066001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5934;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: s65VfEocbHQbxtI55rHrYQsBA7Mv+4zI8v/Qw3QP3zOvo8qbEeK6SCJmMYbqEbecfCht/+Gr8KSseFZbt+B8cXzmPbDcx92cyA5KKVTHkzDLbivp/sOYpET46L5NYMBRfzocLdeJppigJxBymZ4IrG3R8jxLWKCXYp+DGR0ygo4oo71y8WXm35koGFawlAu4UYtgFxxJLL6YzAmftRbPZ/C6xYhpHCCIw7uCZGrQZ86Kdi+O+eGXhCB3qOCJBdmYERnI4rWKQC+ipjWm+CxqYnbRTnpG54oW7sWw5l/ORQHmFsuRn9B8fl/5Me0iF+WgU7zPU3zafb0WlazcDE0phBYi+8j0p09tAAcQKXoDUhIVJF4TIywLk89FHk66kyM2yaItd2DcR3ZQi9o59wLOCn7/1FN8ec/57ol/FmDxTuw=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66973eb4-8242-47c0-0040-08d6bc09d680
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 10:06:15.7833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgYXhib2UsDQoNCklmIHlvdSBoYXZlIG5vIGNvbW1lbnRzIG9uIHRoZXNlIHBhdGhzLCBwbGVh
c2UgbWVyZ2UuDQpUaGFuayB5b3UgdmVyeSBtdWNoLg0KUGF0Y2ggbGluazoNCmh0dHA6Ly9wYXRj
aHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMDU1MDI4Lw0KaHR0cDovL3BhdGNod29yay5vemxhYnMu
b3JnL3BhdGNoLzEwNTQxODkvDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj5TZW50OiAy
MDE5xOoz1MIxMsjVIDk6NTANCj5UbzogYXhib2VAa2VybmVsLmRrOyByb2JoK2R0QGtlcm5lbC5v
cmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPnNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaSA8
bGVveWFuZy5saUBueHAuY29tPg0KPkNjOiBsaW51eC1pZGVAdmdlci5rZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj5saW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IFBlbmcgTWENCj48cGVuZy5tYUBu
eHAuY29tPg0KPlN1YmplY3Q6IFt2NyAzLzNdIGFoY2k6IHFvcmlxOiBhZGQgbHgyMTYwIHBsYXRm
b3JtcyBzdXBwb3J0DQo+DQo+THgyMTYwYSBpcyBhIG5ldyBpbnRyb2R1Y2VkIHNvYyB3aGljaCBz
dXBwb3J0cyBBVEEzLjANCj4NCj5TaWduZWQtb2ZmLWJ5OiBQZW5nIE1hIDxwZW5nLm1hQG54cC5j
b20+DQo+LS0tDQo+Y2hhbmdlZCBmb3IgVjc6DQo+CS0gbm8gY2hhbmdlZC4NCj4NCj4gZHJpdmVy
cy9hdGEvYWhjaV9xb3JpcS5jIHwgICA1Mg0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0NCj4gMSBmaWxlcyBjaGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAx
NyBkZWxldGlvbnMoLSkNCj4NCj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9xb3JpcS5j
IGIvZHJpdmVycy9hdGEvYWhjaV9xb3JpcS5jIGluZGV4DQo+Y2U1OTI1My4uMDhkYmI4NiAxMDA2
NDQNCj4tLS0gYS9kcml2ZXJzL2F0YS9haGNpX3FvcmlxLmMNCj4rKysgYi9kcml2ZXJzL2F0YS9h
aGNpX3FvcmlxLmMNCj5AQCAtNTgsNiArNTgsNyBAQCBlbnVtIGFoY2lfcW9yaXFfdHlwZSB7DQo+
IAlBSENJX0xTMTA0NkEsDQo+IAlBSENJX0xTMTA4OEEsDQo+IAlBSENJX0xTMjA4OEEsDQo+KwlB
SENJX0xYMjE2MEEsDQo+IH07DQo+DQo+IHN0cnVjdCBhaGNpX3FvcmlxX3ByaXYgew0KPkBAIC02
Nyw2ICs2OCw4IEBAIHN0cnVjdCBhaGNpX3FvcmlxX3ByaXYgew0KPiAJYm9vbCBpc19kbWFjb2hl
cmVudDsNCj4gfTsNCj4NCj4rc3RhdGljIGJvb2wgZWNjX2luaXRpYWxpemVkOw0KPisNCj4gc3Rh
dGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYWhjaV9xb3JpcV9vZl9tYXRjaFtdID0gew0K
PiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMxMDIxYS1haGNpIiwgLmRhdGEgPSAodm9pZCAqKUFI
Q0lfTFMxMDIxQX0sDQo+IAl7IC5jb21wYXRpYmxlID0gImZzbCxsczEwNDNhLWFoY2kiLCAuZGF0
YSA9ICh2b2lkICopQUhDSV9MUzEwNDNBfSwgQEANCj4tNzQsNiArNzcsNyBAQCBzdHJ1Y3QgYWhj
aV9xb3JpcV9wcml2IHsNCj4gCXsgLmNvbXBhdGlibGUgPSAiZnNsLGxzMTA0NmEtYWhjaSIsIC5k
YXRhID0gKHZvaWQgKilBSENJX0xTMTA0NkF9LA0KPiAJeyAuY29tcGF0aWJsZSA9ICJmc2wsbHMx
MDg4YS1haGNpIiwgLmRhdGEgPSAodm9pZCAqKUFIQ0lfTFMxMDg4QX0sDQo+IAl7IC5jb21wYXRp
YmxlID0gImZzbCxsczIwODhhLWFoY2kiLCAuZGF0YSA9ICh2b2lkICopQUhDSV9MUzIwODhBfSwN
Cj4rCXsgLmNvbXBhdGlibGUgPSAiZnNsLGx4MjE2MGEtYWhjaSIsIC5kYXRhID0gKHZvaWQgKilB
SENJX0xYMjE2MEF9LA0KPiAJe30sDQo+IH07DQo+IE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGFo
Y2lfcW9yaXFfb2ZfbWF0Y2gpOyBAQCAtMTY1LDkgKzE2OSwxMCBAQA0KPnN0YXRpYyBpbnQgYWhj
aV9xb3JpcV9waHlfaW5pdChzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2KQ0KPg0KPiAJc3dp
dGNoIChxcHJpdi0+dHlwZSkgew0KPiAJY2FzZSBBSENJX0xTMTAyMUE6DQo+LQkJaWYgKCFxcHJp
di0+ZWNjX2FkZHIpDQo+KwkJaWYgKCEocXByaXYtPmVjY19hZGRyIHx8IGVjY19pbml0aWFsaXpl
ZCkpDQo+IAkJCXJldHVybiAtRUlOVkFMOw0KPi0JCXdyaXRlbChTQVRBX0VDQ19ESVNBQkxFLCBx
cHJpdi0+ZWNjX2FkZHIpOw0KPisJCWVsc2UgaWYgKHFwcml2LT5lY2NfYWRkciAmJiAhZWNjX2lu
aXRpYWxpemVkKQ0KPisJCQl3cml0ZWwoU0FUQV9FQ0NfRElTQUJMRSwgcXByaXYtPmVjY19hZGRy
KTsNCj4gCQl3cml0ZWwoQUhDSV9QT1JUX1BIWV8xX0NGRywgcmVnX2Jhc2UgKyBQT1JUX1BIWTEp
Ow0KPiAJCXdyaXRlbChMUzEwMjFBX1BPUlRfUEhZMiwgcmVnX2Jhc2UgKyBQT1JUX1BIWTIpOw0K
PiAJCXdyaXRlbChMUzEwMjFBX1BPUlRfUEhZMywgcmVnX2Jhc2UgKyBQT1JUX1BIWTMpOyBAQCAt
MTgwLDEwDQo+KzE4NSwxMiBAQCBzdGF0aWMgaW50IGFoY2lfcW9yaXFfcGh5X2luaXQoc3RydWN0
IGFoY2lfaG9zdF9wcml2ICpocHJpdikNCj4gCQlicmVhazsNCj4NCj4gCWNhc2UgQUhDSV9MUzEw
NDNBOg0KPi0JCWlmICghcXByaXYtPmVjY19hZGRyKQ0KPisJCWlmICghKHFwcml2LT5lY2NfYWRk
ciB8fCBlY2NfaW5pdGlhbGl6ZWQpKQ0KPiAJCQlyZXR1cm4gLUVJTlZBTDsNCj4tCQl3cml0ZWwo
cmVhZGwocXByaXYtPmVjY19hZGRyKSB8IEVDQ19ESVNfQVJNVjhfQ0gyLA0KPi0JCQkJcXByaXYt
PmVjY19hZGRyKTsNCj4rCQllbHNlIGlmIChxcHJpdi0+ZWNjX2FkZHIgJiYgIWVjY19pbml0aWFs
aXplZCkNCj4rCQkJd3JpdGVsKHJlYWRsKHFwcml2LT5lY2NfYWRkcikgfA0KPisJCQkgICAgICAg
RUNDX0RJU19BUk1WOF9DSDIsDQo+KwkJCSAgICAgICBxcHJpdi0+ZWNjX2FkZHIpOw0KPiAJCXdy
aXRlbChBSENJX1BPUlRfUEhZXzFfQ0ZHLCByZWdfYmFzZSArIFBPUlRfUEhZMSk7DQo+IAkJd3Jp
dGVsKEFIQ0lfUE9SVF9QSFkyX0NGRywgcmVnX2Jhc2UgKyBQT1JUX1BIWTIpOw0KPiAJCXdyaXRl
bChBSENJX1BPUlRfUEhZM19DRkcsIHJlZ19iYXNlICsgUE9SVF9QSFkzKTsgQEANCj4tMjAyLDEw
ICsyMDksMTIgQEAgc3RhdGljIGludCBhaGNpX3FvcmlxX3BoeV9pbml0KHN0cnVjdCBhaGNpX2hv
c3RfcHJpdg0KPipocHJpdikNCj4gCQlicmVhazsNCj4NCj4gCWNhc2UgQUhDSV9MUzEwNDZBOg0K
Pi0JCWlmICghcXByaXYtPmVjY19hZGRyKQ0KPisJCWlmICghKHFwcml2LT5lY2NfYWRkciB8fCBl
Y2NfaW5pdGlhbGl6ZWQpKQ0KPiAJCQlyZXR1cm4gLUVJTlZBTDsNCj4tCQl3cml0ZWwocmVhZGwo
cXByaXYtPmVjY19hZGRyKSB8IEVDQ19ESVNfQVJNVjhfQ0gyLA0KPi0JCQkJcXByaXYtPmVjY19h
ZGRyKTsNCj4rCQllbHNlIGlmIChxcHJpdi0+ZWNjX2FkZHIgJiYgIWVjY19pbml0aWFsaXplZCkN
Cj4rCQkJd3JpdGVsKHJlYWRsKHFwcml2LT5lY2NfYWRkcikgfA0KPisJCQkgICAgICAgRUNDX0RJ
U19BUk1WOF9DSDIsDQo+KwkJCSAgICAgICBxcHJpdi0+ZWNjX2FkZHIpOw0KPiAJCXdyaXRlbChB
SENJX1BPUlRfUEhZXzFfQ0ZHLCByZWdfYmFzZSArIFBPUlRfUEhZMSk7DQo+IAkJd3JpdGVsKEFI
Q0lfUE9SVF9QSFkyX0NGRywgcmVnX2Jhc2UgKyBQT1JUX1BIWTIpOw0KPiAJCXdyaXRlbChBSENJ
X1BPUlRfUEhZM19DRkcsIHJlZ19iYXNlICsgUE9SVF9QSFkzKTsgQEANCj4tMjE1LDEwICsyMjQs
MTMgQEAgc3RhdGljIGludCBhaGNpX3FvcmlxX3BoeV9pbml0KHN0cnVjdCBhaGNpX2hvc3RfcHJp
dg0KPipocHJpdikNCj4gCQlicmVhazsNCj4NCj4gCWNhc2UgQUhDSV9MUzEwODhBOg0KPi0JCWlm
ICghcXByaXYtPmVjY19hZGRyKQ0KPisJY2FzZSBBSENJX0xYMjE2MEE6DQo+KwkJaWYgKCEocXBy
aXYtPmVjY19hZGRyIHx8IGVjY19pbml0aWFsaXplZCkpDQo+IAkJCXJldHVybiAtRUlOVkFMOw0K
Pi0JCXdyaXRlbChyZWFkbChxcHJpdi0+ZWNjX2FkZHIpIHwgRUNDX0RJU19MUzEwODhBLA0KPi0J
CSAgICAgICBxcHJpdi0+ZWNjX2FkZHIpOw0KPisJCWVsc2UgaWYgKHFwcml2LT5lY2NfYWRkciAm
JiAhZWNjX2luaXRpYWxpemVkKQ0KPisJCQl3cml0ZWwocmVhZGwocXByaXYtPmVjY19hZGRyKSB8
DQo+KwkJCSAgICAgICBFQ0NfRElTX0xTMTA4OEEsDQo+KwkJCSAgICAgICBxcHJpdi0+ZWNjX2Fk
ZHIpOw0KPiAJCXdyaXRlbChBSENJX1BPUlRfUEhZXzFfQ0ZHLCByZWdfYmFzZSArIFBPUlRfUEhZ
MSk7DQo+IAkJd3JpdGVsKEFIQ0lfUE9SVF9QSFkyX0NGRywgcmVnX2Jhc2UgKyBQT1JUX1BIWTIp
Ow0KPiAJCXdyaXRlbChBSENJX1BPUlRfUEhZM19DRkcsIHJlZ19iYXNlICsgUE9SVF9QSFkzKTsg
QEAgLTIzNyw2DQo+KzI0OSw3IEBAIHN0YXRpYyBpbnQgYWhjaV9xb3JpcV9waHlfaW5pdChzdHJ1
Y3QgYWhjaV9ob3N0X3ByaXYgKmhwcml2KQ0KPiAJCWJyZWFrOw0KPiAJfQ0KPg0KPisJZWNjX2lu
aXRpYWxpemVkID0gdHJ1ZTsNCj4gCXJldHVybiAwOw0KPiB9DQo+DQo+QEAgLTI2NCwxMyArMjc3
LDE4IEBAIHN0YXRpYyBpbnQgYWhjaV9xb3JpcV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
DQo+KnBkZXYpDQo+DQo+IAlxb3JpcV9wcml2LT50eXBlID0gKGVudW0gYWhjaV9xb3JpcV90eXBl
KW9mX2lkLT5kYXRhOw0KPg0KPi0JcmVzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwNCj4tCQkJInNhdGEtZWNjIik7DQo+LQlpZiAocmVzKSB7DQo+
LQkJcW9yaXFfcHJpdi0+ZWNjX2FkZHIgPSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoZGV2LCByZXMp
Ow0KPi0JCWlmIChJU19FUlIocW9yaXFfcHJpdi0+ZWNjX2FkZHIpKQ0KPi0JCQlyZXR1cm4gUFRS
X0VSUihxb3JpcV9wcml2LT5lY2NfYWRkcik7DQo+KwlpZiAodW5saWtlbHkoIWVjY19pbml0aWFs
aXplZCkpIHsNCj4rCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+
KwkJCQkJCSAgIElPUkVTT1VSQ0VfTUVNLA0KPisJCQkJCQkgICAic2F0YS1lY2MiKTsNCj4rCQlp
ZiAocmVzKSB7DQo+KwkJCXFvcmlxX3ByaXYtPmVjY19hZGRyID0NCj4rCQkJCWRldm1faW9yZW1h
cF9yZXNvdXJjZShkZXYsIHJlcyk7DQo+KwkJCWlmIChJU19FUlIocW9yaXFfcHJpdi0+ZWNjX2Fk
ZHIpKQ0KPisJCQkJcmV0dXJuIFBUUl9FUlIocW9yaXFfcHJpdi0+ZWNjX2FkZHIpOw0KPisJCX0N
Cj4gCX0NCj4rDQo+IAlxb3JpcV9wcml2LT5pc19kbWFjb2hlcmVudCA9IG9mX2RtYV9pc19jb2hl
cmVudChucCk7DQo+DQo+IAlyYyA9IGFoY2lfcGxhdGZvcm1fZW5hYmxlX3Jlc291cmNlcyhocHJp
dik7DQo+LS0NCj4xLjcuMQ0KDQo=
