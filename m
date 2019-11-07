Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBACC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00208214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 21:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="P31P19oX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfKGV6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 16:58:06 -0500
Received: from mail-eopbgr700049.outbound.protection.outlook.com ([40.107.70.49]:42848
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725882AbfKGV6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 16:58:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii+8VJvjQYXHQoxUdOcxPu4Jv/08JhDUM2KMxqSozLCiDsj9OH+QjsgRw5Lbx4W7XnXIO86HjYVRlTKFpF4/aYTG5jtOd68I0e0grPrSolXrMA3RYGMWvfYGW4JZNZu106D+G3/nVYqnYa00ECBF2ynhX9CRgxdMulM3rg1anTm0a7N92MJEbr6EcgYklfE2Vv9rTY9613hbSs3W5FuHIa4kSnEtXUfsOANqIFHTngRRwZttah354joah0OYoaJP9MFTeiYaVJ/JiSTyv+oUOVlxxVX5v/NPSUokPHR68FFkEDnZ3GvFF1diRMNSxXfuDCggguFQ/RJ17cJ+D4ZscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR4aUAj2MR9wMMhCXUbzQUWOHggyLPMx1Ptxh2Tl5Bg=;
 b=HJ8MU5a8Yzeoqpa28RRCQkGxhz+TKxJbUaor23w8IHreXLg+qqOdG+Kmb6vpfzuPywoW8abTvB7X33xUqOw9brYOyxxm5e39stN5ZEma19ju8I2ELRuTDvkWCvCmbiO1xpSu57OnbcPAUhyQ9HDpYijc+9/6Alvt1ydwXK1c/QPlkUVJ3voaLopK9nZzLyi5vTqKwiyu7GVS+DfqR3FJgWZkeI/imBRCzS7PbZRcDdBd7S9TJZegDdc6Vxr91eBO4pDp0zjnJWiAcCCEys4RfkXBDH6yioCR0jmaagCLW9xnBJWRT9RLMoh7VQXa62sTUQy6jUyBs7XLgGymtF4W+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mR4aUAj2MR9wMMhCXUbzQUWOHggyLPMx1Ptxh2Tl5Bg=;
 b=P31P19oX4nlKjUU6OKZTscSBxCQoAybyNzVy3ZNNqui+vaQVinQ3mzFjnJiW0YU4slmMlS+lSTJsYNNuSCGhGnkfLZDBw2p/IztSnaV+kJiXKpT66eDK780oBkEydpOzdn0rZT4p+5qd2iUZwx7qSIFnbUUgwt+DT7NYrhA43rY=
Received: from CH2PR02MB6359.namprd02.prod.outlook.com (52.132.230.25) by
 CH2PR02MB6598.namprd02.prod.outlook.com (20.180.6.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Thu, 7 Nov 2019 21:58:02 +0000
Received: from CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a]) by CH2PR02MB6359.namprd02.prod.outlook.com
 ([fe80::e81d:489c:2bd7:918a%7]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 21:58:01 +0000
From:   Dragan Cvetic <draganc@xilinx.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Derek Kiernan <dkiernan@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/2] misc: xilinx_sdfec: Combine three condition checks
 into one statement in xsdfec_add_ldpc()
Thread-Topic: [PATCH 2/2] misc: xilinx_sdfec: Combine three condition checks
 into one statement in xsdfec_add_ldpc()
Thread-Index: AQHVlAq/6xOFapUQ4keqOaNDjO/0TaeAQ5tA
Date:   Thu, 7 Nov 2019 21:58:01 +0000
Message-ID: <CH2PR02MB63591F1841AC0E54656BDB92CB780@CH2PR02MB6359.namprd02.prod.outlook.com>
References: <af1ff373-56c0-ca49-36dd-15666d183c95@web.de>
 <b927be91-a380-1bba-2b10-f0ca49c477b5@web.de>
In-Reply-To: <b927be91-a380-1bba-2b10-f0ca49c477b5@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=draganc@xilinx.com; 
x-originating-ip: [109.255.167.132]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c6d33bf-0e67-4eff-3b7b-08d763cd8f4d
x-ms-traffictypediagnostic: CH2PR02MB6598:|CH2PR02MB6598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR02MB659808905FBF185B25E74335CB780@CH2PR02MB6598.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(13464003)(199004)(189003)(6246003)(71200400001)(52536014)(4326008)(66066001)(8936002)(86362001)(5660300002)(6116002)(81166006)(2501003)(8676002)(66446008)(66476007)(229853002)(76116006)(110136005)(305945005)(14454004)(54906003)(3846002)(71190400001)(66946007)(316002)(64756008)(55016002)(446003)(6436002)(476003)(66556008)(6636002)(14444005)(11346002)(55236004)(486006)(99286004)(6506007)(186003)(33656002)(53546011)(74316002)(7696005)(26005)(7736002)(478600001)(9686003)(81156014)(256004)(2906002)(76176011)(102836004)(25786009)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR02MB6598;H:CH2PR02MB6359.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aRzaFgZseBJHuxV+ROBfqFCsd3iP2ydwnx7eYn5IXNZnBULHZWytu/Kz6lGzfjnMZqlR9OseSDeLUrDTmAgF9nc78I0Memes7T39TRdTDpJ+vHLEeAUl8Z0/GxsS5SGoG9Edx8scXyVJHXg0WKXaYRpfkzhMCZldsLQQWeyFoAFpgbLxyEXPf5GZsZuPp7Qk1+Wi5WGh/lDZr5vBeNmRhhytp8oNSZ9borWe8izFnzEAIw/zjVa0pMBrPHLphtxeezmOeJB7m/twNjDg3Mveeav8uU1wfeUE2PQYuf/KnvMRoXWmBFKn8BcTcpTS2sP54Voosu2Mwz98nf+z5HhW+iuWp+c8NxuJgtqazGm8OaY1ql6x5+dc0LsWANxCC8ZxwCT3sma0GQ4k2oJDcA3/Wir6K7yqdytMtwGOuMTF1oCcpmZMgZhpiUQ9ga0japhq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6d33bf-0e67-4eff-3b7b-08d763cd8f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 21:58:01.8334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N1jOfOsqlIATZp3H0kTc3OBXBZK3wHXF4qRpkl+1lVSs/nTh1qRl9IwBvLwom+DQVmnQMYbM6jjhzhG+ANSlsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFya3VzIEVsZnJpbmcg
W21haWx0bzpNYXJrdXMuRWxmcmluZ0B3ZWIuZGVdDQo+IFNlbnQ6IFR1ZXNkYXkgNSBOb3ZlbWJl
ciAyMDE5IDE4OjU2DQo+IFRvOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7
IEFybmQgQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBEZXJlayBLaWVybmFuIDxka2llcm5hbkB4
aWxpbnguY29tPjsgRHJhZ2FuIEN2ZXRpYw0KPiA8ZHJhZ2FuY0B4aWxpbnguY29tPjsgR3JlZyBL
cm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz47IE1pY2hhbCBTaW1layA8
bWljaGFsc0B4aWxpbnguY29tPg0KPiBDYzogTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz47IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENI
IDIvMl0gbWlzYzogeGlsaW54X3NkZmVjOiBDb21iaW5lIHRocmVlIGNvbmRpdGlvbiBjaGVja3Mg
aW50byBvbmUgc3RhdGVtZW50IGluIHhzZGZlY19hZGRfbGRwYygpDQo+IA0KPiBGcm9tOiBNYXJr
dXMgRWxmcmluZyA8ZWxmcmluZ0B1c2Vycy5zb3VyY2Vmb3JnZS5uZXQ+DQo+IERhdGU6IFR1ZSwg
NSBOb3YgMjAxOSAxOTozMjoyNSArMDEwMA0KPiANCj4gVGhlIHNhbWUgcmV0dXJuIGNvZGUgd2Fz
IHNldCBhZnRlciB0aHJlZSBjb25kaXRpb24gY2hlY2tzLg0KPiBUaHVzIHVzZSBhIHNpbmdsZSBz
dGF0ZW1lbnQgaW5zdGVhZC4NCj4gDQo+IEZpeGVzOiAyMGVjNjI4ZTgwMDdlYzc1YzJmODg0ZTAw
MDA0ZjM5ZWFiNjI4OWI1ICgibWlzYzogeGlsaW54X3NkZmVjOiBBZGQgYWJpbGl0eSB0byBjb25m
aWd1cmUgTERQQyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBFbGZyaW5nIDxlbGZyaW5nQHVz
ZXJzLnNvdXJjZWZvcmdlLm5ldD4NCj4gLS0tDQo+ICBkcml2ZXJzL21pc2MveGlsaW54X3NkZmVj
LmMgfCAxNiArKysrLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25z
KCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MveGls
aW54X3NkZmVjLmMgYi9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVjLmMNCj4gaW5kZXggYTYyMmZj
ZjQ5NTRhLi4zMjJkNWM2ZTZkMTIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy94aWxpbnhf
c2RmZWMuYw0KPiArKysgYi9kcml2ZXJzL21pc2MveGlsaW54X3NkZmVjLmMNCj4gQEAgLTY1Mywx
OCArNjUzLDEwIEBAIHN0YXRpYyBpbnQgeHNkZmVjX2FkZF9sZHBjKHN0cnVjdCB4c2RmZWNfZGV2
ICp4c2RmZWMsIHZvaWQgX191c2VyICphcmcpDQo+ICAJaWYgKElTX0VSUihsZHBjKSkNCj4gIAkJ
cmV0dXJuIFBUUl9FUlIobGRwYyk7DQo+IA0KPiAtCWlmICh4c2RmZWMtPmNvbmZpZy5jb2RlID09
IFhTREZFQ19UVVJCT19DT0RFKSB7DQo+IC0JCXJldCA9IC1FSU87DQo+IC0JCWdvdG8gZXJyX291
dDsNCj4gLQl9DQo+IC0NCj4gLQkvKiBWZXJpZnkgRGV2aWNlIGhhcyBub3Qgc3RhcnRlZCAqLw0K
PiAtCWlmICh4c2RmZWMtPnN0YXRlID09IFhTREZFQ19TVEFSVEVEKSB7DQo+IC0JCXJldCA9IC1F
SU87DQo+IC0JCWdvdG8gZXJyX291dDsNCj4gLQl9DQo+IC0NCj4gLQlpZiAoeHNkZmVjLT5jb25m
aWcuY29kZV93cl9wcm90ZWN0KSB7DQo+ICsJaWYgKHhzZGZlYy0+Y29uZmlnLmNvZGUgPT0gWFNE
RkVDX1RVUkJPX0NPREUgfHwNCj4gKwkgICAgLyogVmVyaWZ5IGRldmljZSBoYXMgbm90IHN0YXJ0
ZWQgKi8NCj4gKwkgICAgeHNkZmVjLT5zdGF0ZSA9PSBYU0RGRUNfU1RBUlRFRCB8fA0KPiArCSAg
ICB4c2RmZWMtPmNvbmZpZy5jb2RlX3dyX3Byb3RlY3QpIHsNCj4gIAkJcmV0ID0gLUVJTzsNCj4g
IAkJZ290byBlcnJfb3V0Ow0KPiAgCX0NCj4gLS0NCj4gMi4yNC4wDQoNCkFja2VkLWJ5OiBEcmFn
YW4gQ3ZldGljIDxkcmFnYW4uY3ZldGljQHhpbGlueC5jb20+DQo=
