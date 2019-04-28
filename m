Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F168C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090B72077B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 02:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DHlbPnnb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfD1CAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 22:00:24 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:29390
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfD1CAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 22:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcYqRVh4PJZfhWCaow0smn/6ML2kk+mf9kg1Q+s3bwc=;
 b=DHlbPnnb9nXvOSbpc+btqW9xjpDutVbvTjgVlDUKjFmzpWc4ks4zipgPrafQlXztP/SsWkRh6bW6rKqTLzzAqRS+D3PiTfJnE8AuH/rKDg1ddH7xzEttquA8MMtceSTF0UuzBQA7KnV12u9TJ04c4RpPmciRwxr9nDP4d2JAVpY=
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com (20.177.55.159) by
 VI1PR04MB5934.eurprd04.prod.outlook.com (20.178.205.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.15; Sun, 28 Apr 2019 02:00:13 +0000
Received: from VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df]) by VI1PR04MB4431.eurprd04.prod.outlook.com
 ([fe80::940a:dc67:926:e5df%6]) with mapi id 15.20.1835.016; Sun, 28 Apr 2019
 02:00:13 +0000
From:   Peng Ma <peng.ma@nxp.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH] dmaengine: fsl-qdma: fixed the
 source/destination descriptior format
Thread-Topic: [EXT] Re: [PATCH] dmaengine: fsl-qdma: fixed the
 source/destination descriptior format
Thread-Index: AQHU9o1fbPmX+1SRm0awFND3hnhkWKZOX3eAgAJ8d8A=
Date:   Sun, 28 Apr 2019 02:00:13 +0000
Message-ID: <VI1PR04MB4431E13D34650C2EE3D25861ED380@VI1PR04MB4431.eurprd04.prod.outlook.com>
References: <20190419084629.41742-1-peng.ma@nxp.com>
 <20190426115047.GW28103@vkoul-mobl>
In-Reply-To: <20190426115047.GW28103@vkoul-mobl>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.ma@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a104ad2b-cbab-4de5-a151-08d6cb7d40d1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5934;
x-ms-traffictypediagnostic: VI1PR04MB5934:
x-microsoft-antispam-prvs: <VI1PR04MB5934A20874E874D6DCBFB93CED380@VI1PR04MB5934.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(13464003)(256004)(186003)(26005)(486006)(476003)(11346002)(6506007)(7736002)(305945005)(446003)(74316002)(76176011)(3846002)(6116002)(102836004)(2906002)(229853002)(6916009)(6436002)(44832011)(8676002)(8936002)(478600001)(81156014)(33656002)(81166006)(14454004)(68736007)(25786009)(66066001)(97736004)(76116006)(4326008)(54906003)(64756008)(53936002)(6246003)(9686003)(7696005)(55016002)(99286004)(316002)(52536014)(66476007)(66556008)(71190400001)(66446008)(71200400001)(73956011)(66946007)(5660300002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5934;H:VI1PR04MB4431.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vTHRItC38S9Gq3Ytinjju98uv0+BAYhGqlYlMcE/XTdwkCSQb3rfY8B1QxiRl3thXGYk/xmoJXkQP3D9Y4E/6BTVJ25IACsHj2bAWnVpoxLWrksVCrJ6m3rLon+5Cn+PwkW3QyY6srMDSOKB/Y9Tp5l6toeGaEzMiVi6wnfkYpqSV20p/sgF+CJqcyFsVHNuAZwWsnboxCKjKaRTAhv7sl19f+hPFbBb0x77owrhehg71nIGkB7m2eUWwZ8UhvRhBgd9gEvQOKF0pi0wrNp9Vek4re735NlF4AOB11aQIyFp4uxUx/gS7m1GbguOsGtWisbwW2HhkUVVFMibubY5W07nnOjY5v/18PQ5EJ8faJfEcZB3fUVApCXsb+jqCWgsRse/2ujFyDVq06IbG99b2TFzI3SR4qpOwKMsxLjUetY=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a104ad2b-cbab-4de5-a151-08d6cb7d40d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 02:00:13.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5934
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmlub2QsDQoNClRoYW5rcyB5b3VyIGNvbW1lbnRzLg0KUGxlYXNlIHNlZSBteSBjb21tZW50
cyBpbmxpbmUuDQoNCkJlc3QgUmVnYXJkcywNClBlbmcNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+RnJvbTogVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj5TZW50OiAyMDE5
xOo01MIyNsjVIDE5OjUxDQo+VG86IFBlbmcgTWEgPHBlbmcubWFAbnhwLmNvbT4NCj5DYzogZGFu
Lmoud2lsbGlhbXNAaW50ZWwuY29tOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+ZG1h
ZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPlN1
YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogZnNsLXFkbWE6IGZpeGVkIHRoZSBz
b3VyY2UvZGVzdGluYXRpb24NCj5kZXNjcmlwdGlvciBmb3JtYXQNCj4NCj5DYXV0aW9uOiBFWFQg
RW1haWwNCj4NCj5PbiAxOS0wNC0xOSwgMDg6NDYsIFBlbmcgTWEgd3JvdGU6DQo+PiBDTUQgb2Yg
U291cmNlL0Rlc3RpbmF0aW9uIGRlc2NyaXB0aW9yIGZvcm1hdCBzaG91bGQgYmUgbG93ZXIgb2YN
Cj4NCj5zL2Rlc2NyaXB0aW9yL2Rlc2NyaXB0b3INCj4NCltQZW5nIE1hXSBHb3QgaXQuDQo+PiBz
dHJ1Y3QgZnNsX3FkbWFfZW5naW5lIG51bWJlciBkYXRhIGFkZHJlc3MuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogUGVuZyBNYSA8cGVuZy5tYUBueHAuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9k
bWEvZnNsLXFkbWEuYyB8ICAgMjkgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0NCj4+ICAx
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS9mc2wtcWRtYS5jIGIvZHJpdmVycy9kbWEvZnNsLXFk
bWEuYyBpbmRleA0KPj4gYWExZDBhZS4uNTQyNzY1YSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
ZG1hL2ZzbC1xZG1hLmMNCj4+ICsrKyBiL2RyaXZlcnMvZG1hL2ZzbC1xZG1hLmMNCj4+IEBAIC0x
MTMsNiArMTEzLDcgQEANCj4+ICAvKiBGaWVsZCBkZWZpbml0aW9uIGZvciBEZXNjcmlwdG9yIG9m
ZnNldCAqLw0KPj4gICNkZWZpbmUgUURNQV9DQ0RGX1NUQVRVUyAgICAgICAgICAgICAyMA0KPj4g
ICNkZWZpbmUgUURNQV9DQ0RGX09GRlNFVCAgICAgICAgICAgICAyMA0KPj4gKyNkZWZpbmUgUURN
QV9TRERGX0NNRCh4KSAgICAgICAgICAgICAoKCh1NjQpKHgpKSA8PCAzMikNCj4+DQo+PiAgLyog
RmllbGQgZGVmaW5pdGlvbiBmb3Igc2FmZSBsb29wIGNvdW50Ki8NCj4+ICAjZGVmaW5lIEZTTF9R
RE1BX0hBTFRfQ09VTlQgICAgICAgICAgMTUwMA0KPj4gQEAgLTIxNCw2ICsyMTUsMTIgQEAgc3Ry
dWN0IGZzbF9xZG1hX2VuZ2luZSB7DQo+Pg0KPj4gIH07DQo+Pg0KPj4gK3N0YXRpYyBpbmxpbmUg
dm9pZA0KPj4gK3FkbWFfc2RkZl9zZXRfY21kKHN0cnVjdCBmc2xfcWRtYV9mb3JtYXQgKnNkZGYs
IHUzMiB2YWwpIHsNCj4+ICsgICAgIHNkZGYtPmRhdGEgPSBRRE1BX1NEREZfQ01EKHZhbCk7IH0N
Cj4+ICsNCj4+ICBzdGF0aWMgaW5saW5lIHU2NA0KPj4gIHFkbWFfY2NkZl9hZGRyX2dldDY0KGNv
bnN0IHN0cnVjdCBmc2xfcWRtYV9mb3JtYXQgKmNjZGYpICB7IEBADQo+LTM0MSw2DQo+PiArMzQ4
LDcgQEAgc3RhdGljIHZvaWQgZnNsX3FkbWFfZnJlZV9jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1h
X2NoYW4NCj4+ICpjaGFuKSAgc3RhdGljIHZvaWQgZnNsX3FkbWFfY29tcF9maWxsX21lbWNweShz
dHJ1Y3QgZnNsX3FkbWFfY29tcA0KPipmc2xfY29tcCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgZHN0LCBkbWFfYWRkcl90DQo+c3JjLA0KPj4gdTMy
IGxlbikgIHsNCj4+ICsgICAgIHUzMiBjbWQ7DQo+PiAgICAgICBzdHJ1Y3QgZnNsX3FkbWFfZm9y
bWF0ICpzZGYsICpkZGY7DQo+PiAgICAgICBzdHJ1Y3QgZnNsX3FkbWFfZm9ybWF0ICpjY2RmLCAq
Y3NnZl9kZXNjLCAqY3NnZl9zcmMsICpjc2dmX2Rlc3Q7DQo+Pg0KPj4gQEAgLTM1Myw2ICszNjEs
NyBAQCBzdGF0aWMgdm9pZCBmc2xfcWRtYV9jb21wX2ZpbGxfbWVtY3B5KHN0cnVjdA0KPj4gZnNs
X3FkbWFfY29tcCAqZnNsX2NvbXAsDQo+Pg0KPj4gICAgICAgbWVtc2V0KGZzbF9jb21wLT52aXJ0
X2FkZHIsIDAsDQo+RlNMX1FETUFfQ09NTUFORF9CVUZGRVJfU0laRSk7DQo+PiAgICAgICBtZW1z
ZXQoZnNsX2NvbXAtPmRlc2NfdmlydF9hZGRyLCAwLA0KPj4gRlNMX1FETUFfREVTQ1JJUFRPUl9C
VUZGRVJfU0laRSk7DQo+PiArDQo+PiAgICAgICAvKiBIZWFkIENvbW1hbmQgRGVzY3JpcHRvcihG
cmFtZSBEZXNjcmlwdG9yKSAqLw0KPj4gICAgICAgcWRtYV9kZXNjX2FkZHJfc2V0NjQoY2NkZiwg
ZnNsX2NvbXAtPmJ1c19hZGRyICsgMTYpOw0KPj4gICAgICAgcWRtYV9jY2RmX3NldF9mb3JtYXQo
Y2NkZiwgcWRtYV9jY2RmX2dldF9vZmZzZXQoY2NkZikpOyBAQA0KPj4gLTM2OSwxNCArMzc4LDE0
IEBAIHN0YXRpYyB2b2lkIGZzbF9xZG1hX2NvbXBfZmlsbF9tZW1jcHkoc3RydWN0DQo+ZnNsX3Fk
bWFfY29tcCAqZnNsX2NvbXAsDQo+PiAgICAgICAvKiBUaGlzIGVudHJ5IGlzIHRoZSBsYXN0IGVu
dHJ5LiAqLw0KPj4gICAgICAgcWRtYV9jc2dmX3NldF9mKGNzZ2ZfZGVzdCwgbGVuKTsNCj4+ICAg
ICAgIC8qIERlc2NyaXB0b3IgQnVmZmVyICovDQo+PiAtICAgICBzZGYtPmRhdGEgPQ0KPj4gLSAg
ICAgICAgICAgICBjcHVfdG9fbGU2NChGU0xfUURNQV9DTURfUldUVFlQRSA8PA0KPj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICBGU0xfUURNQV9DTURfUldUVFlQRV9PRkZTRVQpOw0KPj4gLSAg
ICAgZGRmLT5kYXRhID0NCj4+IC0gICAgICAgICAgICAgY3B1X3RvX2xlNjQoRlNMX1FETUFfQ01E
X1JXVFRZUEUgPDwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgRlNMX1FETUFfQ01EX1JX
VFRZUEVfT0ZGU0VUKTsNCj4+IC0gICAgIGRkZi0+ZGF0YSB8PQ0KPj4gLSAgICAgICAgICAgICBj
cHVfdG9fbGU2NChGU0xfUURNQV9DTURfTFdDIDw8DQo+RlNMX1FETUFfQ01EX0xXQ19PRkZTRVQp
Ow0KPj4gKyAgICAgY21kID0gY3B1X3RvX2xlMzIoRlNMX1FETUFfQ01EX1JXVFRZUEUgPDwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgIEZTTF9RRE1BX0NNRF9SV1RUWVBFX09GRlNFVCk7DQo+
PiArICAgICBxZG1hX3NkZGZfc2V0X2NtZChzZGYsIGNtZCk7DQo+PiArDQo+PiArICAgICBjbWQg
PSBjcHVfdG9fbGUzMihGU0xfUURNQV9DTURfUldUVFlQRSA8PA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgRlNMX1FETUFfQ01EX1JXVFRZUEVfT0ZGU0VUKTsNCj4+ICsgICAgIGNtZCB8PSBj
cHVfdG9fbGUzMihGU0xfUURNQV9DTURfTFdDIDw8DQo+RlNMX1FETUFfQ01EX0xXQ19PRkZTRVQp
Ow0KPj4gKyAgICAgcWRtYV9zZGRmX3NldF9jbWQoZGRmLCBjbWQpOw0KPj4gIH0NCj4+DQo+PiAg
LyoNCj4+IEBAIC03MDEsMTAgKzcxMCw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBmc2xfcWRtYV9l
cnJvcl9oYW5kbGVyKGludA0KPj4gaXJxLCB2b2lkICpkZXZfaWQpDQo+Pg0KPj4gICAgICAgaW50
ciA9IHFkbWFfcmVhZGwoZnNsX3FkbWEsIHN0YXR1cyArIEZTTF9RRE1BX0RFRFIpOw0KPj4NCj4+
IC0gICAgIGlmIChpbnRyKSB7DQo+PiArICAgICBpZiAoaW50cikNCj4+ICAgICAgICAgICAgICAg
ZGV2X2Vycihmc2xfcWRtYS0+ZG1hX2Rldi5kZXYsICJETUEgdHJhbnNhY3Rpb24NCj5lcnJvciFc
biIpOw0KPj4gLSAgICAgICAgICAgICByZXR1cm4gSVJRX05PTkU7DQo+PiAtICAgICB9DQo+DQo+
dGhpcyBzZWVtcyB1bnJlbGF0ZWQgY2FuIHlvdSBleHBsYWluPw0KPg0KW1BlbmcgTWFdIFRoaXMg
aXMgYW4gYWRkZWQgaW1wcm92ZW1lbnQuIFdoZW4gYW4gZXJyb3Igb2NjdXJzIHdlIHNob3VsZCBj
bGVhbiB0aGUgZXJyb3IgcmVnIHRoZW4gdG8gcmV0dXJuLg0KSSBmb3Jnb3QgdG8gZXhwbGFpbiBp
dCBvbiBjb21tZW50cy4gU2hvdWxkIEkgYWRkIHRoaXMgY2hhbmdlZCB0byB0aGUgY29tbWVudHM/
DQo+Pg0KPj4gICAgICAgcWRtYV93cml0ZWwoZnNsX3FkbWEsIEZTTF9RRE1BX0RFRFJfQ0xFQVIs
IHN0YXR1cyArDQo+RlNMX1FETUFfREVEUik7DQo+PiAgICAgICByZXR1cm4gSVJRX0hBTkRMRUQ7
DQo+PiAtLQ0KPj4gMS43LjENCj4NCj4tLQ0KPn5WaW5vZA0K
