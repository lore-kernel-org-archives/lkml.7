Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426BCC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E462084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 01:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5p+jvu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDLBFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 21:05:37 -0400
Received: from mail-eopbgr140045.outbound.protection.outlook.com ([40.107.14.45]:54322
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfDLBFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 21:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKMin34p7ppiP4SLOVfYqnmQ0h/i5WWOwlshgaJQMtg=;
 b=s5p+jvu7nnPtBGBdOoV0DvGwvNo860sVdW9gGPQTwuITiCS/g2LqTHNIyJsnBYkSNF1YT+AaBsLVhHuyXEz5OAVpw2ICPsRZm9NLHznGyIlOV5ssGlcMMiNS+L8/ABQt2SFTnClmi4KMy6R7v8s9O+jBdKwnO5TygXLvrNrkJyM=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3820.eurprd04.prod.outlook.com (52.134.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Fri, 12 Apr 2019 01:05:32 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1792.016; Fri, 12 Apr 2019
 01:05:32 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Topic: [EXT] Re: [PATCH V7 2/4] firmware: imx: enable imx scu general
 irq function
Thread-Index: AQHU7pESFiPArqSQREy0TQYaxheiu6Y2lGmAgAElItA=
Date:   Fri, 12 Apr 2019 01:05:32 +0000
Message-ID: <DB3PR0402MB3916B67E6DA995AB70C29799F5280@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554785675-8090-1-git-send-email-Anson.Huang@nxp.com>
 <1554785675-8090-2-git-send-email-Anson.Huang@nxp.com>
 <20190411073252.GC3050@dragon>
In-Reply-To: <20190411073252.GC3050@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33efc271-86e7-4bd6-12ae-08d6bee2f633
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3820;
x-ms-traffictypediagnostic: DB3PR0402MB3820:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB3820639E0FA43EDBBDEAD34FF5280@DB3PR0402MB3820.eurprd04.prod.outlook.com>
x-forefront-prvs: 0005B05917
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(376002)(396003)(39860400002)(346002)(13464003)(189003)(199004)(8676002)(52536014)(81166006)(81156014)(2906002)(8936002)(6306002)(6506007)(9686003)(102836004)(7416002)(55016002)(7696005)(53546011)(76176011)(54906003)(110136005)(74316002)(305945005)(86362001)(229853002)(5660300002)(7736002)(316002)(966005)(2501003)(99286004)(478600001)(14454004)(6436002)(66066001)(486006)(6116002)(476003)(14444005)(4326008)(44832011)(5024004)(256004)(3846002)(25786009)(446003)(11346002)(97736004)(71190400001)(71200400001)(68736007)(106356001)(33656002)(105586002)(186003)(6246003)(53936002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3820;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mX+J1AORD+ao1RBcB7PdWDeJedzvups6pLs2aL9rWoBv772+5kec3EaANq0HyAW9+LvuSiD1RkmjNY7OLlg1Q0Aq4CAUBWbrZnRiqDdjcFa2JY4AzjG5K5FuaBxeWwRUWL+EtQaHtXIN/cf/polymKR1nU3pJZPkMFC3PFJOVacwXs0rCdGGgT+lnOvujlMFdih7SEMvpmYl6D5M8wgD4rxN6RHPVknwpXiAvlPwFf4vAowROlElS3u6A8F1yCe2DyJCm3ucjWeWkchd1TxDU9htXBn69QEyQ51C1YwQ13/KOxMeo2PuAfVP1gRS74fZR+TqM8WdyJ0DX3/bwE1P8iP0XFIwtMue9RjyiX/nsRDSjoBvkueNnnIGf1gSmtSAE+1QkMdklLJXeRu7ZdjdLfsZNp7BtRi1W11HvbuaeUU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33efc271-86e7-4bd6-12ae-08d6bee2f633
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2019 01:05:32.1221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sIEFsZXhhbmRyZQ0KCUFzIGkuTVggU0NVIGdlbmVyYWwgaXJxIGZ1bmN0aW9uIGlzIHBp
Y2tlZCB1cCBieSBTaGF3biwgY291bGQgeW91IHBsZWFzZSBhbHNvIHBpY2sgdXAgYmVsb3cgaS5N
WCBTQyBSVEMgYWxhcm0gc3VwcG9ydCBwYXRjaCA/DQoJaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMDg5MDUyNS8gDQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhd24gR3VvIFttYWlsdG86c2hh
d25ndW9Aa2VybmVsLm9yZ10NCj4gU2VudDogMjAxOcTqNNTCMTHI1SAxNTozMw0KPiBUbzogQW5z
b24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+DQo+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7
IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgYS56dW1tb0B0b3dlcnRlY2guaXQ7
DQo+IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyBBaXNoZW5nIERvbmcgPGFpc2hlbmcu
ZG9uZ0BueHAuY29tPjsNCj4gdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgc2JveWRAa2VybmVsLm9y
ZzsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+Ow0KPiBEYW5pZWwgQmFsdXRhIDxkYW5pZWwu
YmFsdXRhQG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+IHJ0Y0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteCA8bGludXgtaW14
QG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggVjcgMi80XSBmaXJtd2FyZTog
aW14OiBlbmFibGUgaW14IHNjdSBnZW5lcmFsIGlycQ0KPiBmdW5jdGlvbg0KPiANCj4gV0FSTklO
RzogVGhpcyBlbWFpbCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxp
bmtzIG9yDQo+IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5k
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24gVHVlLCBBcHIgMDks
IDIwMTkgYXQgMDQ6NTk6NTVBTSArMDAwMCwgQW5zb24gSHVhbmcgd3JvdGU6DQo+ID4gVGhlIFN5
c3RlbSBDb250cm9sbGVyIEZpcm13YXJlIChTQ0ZXKSBjb250cm9scyBSVEMsIHRoZXJtYWwgYW5k
IFdET0cNCj4gPiBldGMuLCB0aGVzZSByZXNvdXJjZXMnIGludGVycnVwdCBmdW5jdGlvbiBhcmUg
bWFuYWdlZCBieSBTQ1UuIFdoZW4gYW55DQo+ID4gSVJRIHBlbmRpbmcsIFNDVSB3aWxsIG5vdGlm
eSBMaW51eCB2aWEgTVUgZ2VuZXJhbCBpbnRlcnJ1cHQgY2hhbm5lbA0KPiA+ICMzLCBhbmQgTGlu
dXgga2VybmVsIG5lZWRzIHRvIGNhbGwgU0NVIEFQSXMgdG8gZ2V0IElSUSBzdGF0dXMgYW5kDQo+
ID4gbm90aWZ5IGVhY2ggbW9kdWxlIHRvIGhhbmRsZSB0aGUgaW50ZXJydXB0Lg0KPiA+DQo+ID4g
U2luY2UgdGhlcmUgaXMgbm8gZGF0YSB0cmFuc21pc3Npb24gZm9yIFNDVSBJUlEgbm90aWZpY2F0
aW9uLCBzbw0KPiA+IGRvb3JiZWxsIG1vZGUgaXMgdXNlZCBmb3IgdGhpcyBNVSBjaGFubmVsLCBh
bmQgU0NVIGRyaXZlciB3aWxsIHVzZQ0KPiA+IG5vdGlmaWVyIG1lY2hhbmlzbSB0byBicm9hZGNh
c3QgdG8gZXZlcnkgbW9kdWxlIHdoaWNoIHJlZ2lzdGVycyB0aGUNCj4gPiBTQ1UgYmxvY2sgbm90
aWZpZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdA
bnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRvbmdAbnhw
LmNvbT4NCj4gDQo+IEFwcGxpZWQsIHRoYW5rcy4NCg==
