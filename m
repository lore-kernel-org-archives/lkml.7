Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7EEC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BEF21655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c9fmETtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfHPKho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:37:44 -0400
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:51173
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfHPKhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:37:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YUdhFUog4v1OpGaaAvvCnLuj1+nAhSCRfqW5Vgxn23ZU3knHylRH6E3w4PoxbTCWJAXYHmfjx9pFMIicoQ8truxb4VNaEAhlwz+A2X1aIOzkSG/fvT0tg/xIAVNQcmqpMvKys8ETMOx+bTndC3+H+kbqzq950jvLgd686+BIvXt0Rl4E6U8nCi+bTX98qkcAayzYMuh+ebEoT+3NcmEwCaItQyl2ad+ZwiwtIuNx2J7Mhczu+Cf4aYcSJXEfgohSX6AKCpmipot6NI0yakynmuYoyI8/sr7CUks/k02zT2QAjlwbfCs+e7YxBZEGDl6XJXGLqndVXiTTa2eyGniYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6LJlZ0JnW7dUXYTcFvX7tDyU6rxHRWbenOVAhulxAc=;
 b=O3Z0t223wYC2vw0toetbLFyNUL2PmH8IBxVMmP5B2q9yfJGrHaPnNbWlZK4qOiU913UEQcki9dV10ET/+7BmGiT3ZgcVwVvXq2i6MJHvQgV6Ud/wOVzLJQJ43cm//egX2lt6Ie87uYOVry9uc7IJP/jOZTAckB2WaGZV8Ee8tf0lOEKwiPdU/ixOdRSKbhZMT2znn6yCfel1+/ODv84eZmBtsGDiE3WJLg3EDRrM9jRpIbFt1orJvKSzWFUz+g3Htjt2VvvaiG53TTpDzrwB/whmLxvT/sJ/kQLXRT4sobHQ1SRCOzWLpAtJbm7l1TggaEDNfKYniNDEl4FscprHyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6LJlZ0JnW7dUXYTcFvX7tDyU6rxHRWbenOVAhulxAc=;
 b=c9fmETtYhC3WyzPeLpowDTI7dpPW/PbUVKNtjGFMKDVy+KiNvEAEAjOa5GWwmbX80auJh0MVInIC8TyCmFOQxukwc6EjBYaw6p1eMCBaXk+vkerrSr2urYz2nBlqc9U4qHlazpyHh6J+7aGoZP4GKFoxR8kVYnMcKSeasKzUxow=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Fri, 16 Aug 2019 10:37:00 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::7cdf:bddc:212c:f77e%4]) with mapi id 15.20.2178.016; Fri, 16 Aug 2019
 10:37:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V6 4/4] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Topic: [PATCH V6 4/4] arm64: dts: imx8mm: Enable cpu-idle driver
Thread-Index: AQHVU82SFvIqTYVX002fkrtVdPy2g6b9ix+AgAABRwCAAAd0UA==
Date:   Fri, 16 Aug 2019 10:37:00 +0000
Message-ID: <DB3PR0402MB3916E00B69BD67098F1875FBF5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1565915925-21009-1-git-send-email-Anson.Huang@nxp.com>
 <1565915925-21009-4-git-send-email-Anson.Huang@nxp.com>
 <e62d26b9-8c9b-644f-d2b3-485586e07e35@linaro.org>
 <DB3PR0402MB3916E469219C7CC68D55C90AF5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916E469219C7CC68D55C90AF5AF0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76210fc9-a0db-4f3c-eda3-08d72235aba2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB388326E0D0814CE25CC38124F5AF0@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(199004)(189003)(316002)(81156014)(81166006)(229853002)(478600001)(55016002)(110136005)(966005)(33656002)(6306002)(4326008)(66066001)(6246003)(8676002)(305945005)(6436002)(74316002)(99286004)(2501003)(7736002)(25786009)(53936002)(476003)(66446008)(2201001)(11346002)(6116002)(256004)(5660300002)(66946007)(9686003)(2906002)(52536014)(66556008)(446003)(44832011)(8936002)(486006)(7416002)(3846002)(186003)(6506007)(102836004)(2940100002)(14454004)(64756008)(66476007)(76116006)(86362001)(71190400001)(7696005)(53546011)(26005)(76176011)(71200400001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7clrDBKXyTkFPU3VU0fIzDDJvxjGZc3t5oo0oVQaiy2kyHpb+3wQK90Fk4wSgaXy35wg0MX+tjf3CKVbe7bwTXmaYgB5bcq8vlCFNvGXSlscp9I4pJkWM/HmrJACuGa6q4UQwra+NzNr64Adq89JHPpJxZ4iqkDZAm2koaU8a8fQxcDm5P+Pp9/TlEPkVXLYtCCdw6gdvR2LJLzzInjpSbaItocxuw+ZUTqwl3zBWluHn/PKGdurvneuvrjKv4riCM0jUuxLnh9eDUuAo3F19OqBg/oW1VA53c2WLFD4t7NofSknq8JJT0DIeAdq3BZ2DcKSbw981ZCGjCMCLdDM/jua7ie43Q7xgUaCCgQwGJXk1+WCiqYmqj5ANLocuZFHrkZFs+CEIdp0N0JN8Uhvjdv5vLhSMPjz9dr3fRx+SnY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76210fc9-a0db-4f3c-eda3-08d72235aba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 10:37:00.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UnOVPqSd/D9bzT/6vKFsshJq6G7dqj5tA2sJZZx1vUvQcO0KxIxc5HC9FwpczMNfZHVUfPVbcNMXrZr0qKztw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNoYXduDQoNCj4gPiBPbiAxNi8wOC8yMDE5IDAyOjM4LCBBbnNvbiBIdWFuZyB3cm90ZToN
Cj4gPiA+IEVuYWJsZSBpLk1YOE1NIGNwdS1pZGxlIHVzaW5nIGdlbmVyaWMgQVJNIGNwdS1pZGxl
IGRyaXZlciwgMiBzdGF0ZXMNCj4gPiA+IGFyZSBzdXBwb3J0ZWQsIGRldGFpbHMgYXMgYmVsb3c6
DQo+ID4gPg0KPiA+ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0DQo+ID4gL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1MC9jcHVpZGxlL3N0YXRlMC9uYW1lDQo+ID4gPiBXRkkNCj4gPiA+IHJvb3RA
aW14OG1tZXZrOn4jIGNhdA0KPiA+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVp
ZGxlL3N0YXRlMC91c2FnZQ0KPiA+ID4gMzk3Mw0KPiA+ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0
DQo+ID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MC9jcHVpZGxlL3N0YXRlMS9uYW1lDQo+
ID4gPiBjcHUtcGQtd2FpdA0KPiA+ID4gcm9vdEBpbXg4bW1ldms6fiMgY2F0DQo+ID4gPiAvc3lz
L2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL2NwdWlkbGUvc3RhdGUxL3VzYWdlDQo+ID4gPiA2NjQ3
DQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54
cC5jb20+DQo+ID4NCj4gPiBIaSBBbnNvbiwNCj4gPg0KPiA+IEkndmUgYXBwbGllZCB0aGUgcGF0
Y2hlcyAxLTMgYnV0IHRoaXMgb25lIGRvZXMgbm90IGFwcGx5Lg0KPiANCj4gVGhhbmtzLg0KPiAN
Cj4gPg0KPiA+IFlvdSBjYW4gZWl0aGVyIHJlc3BpbiBpdCBhZ2FpbnN0IHRpcC90aW1lcnMvY29y
ZSBhbmQgdGFrZSBpdCB0aHJvdWdoDQo+ID4gU2hhd24ncyB0cmVlLiBJZiB0aGUgbGF0ZXIsIHlv
dSBjYW4gYWRkIG15IEFja2VkLWJ5Lg0KPiANCj4gSGksIFNoYXduDQo+IAlDYW4geW91IHRha2Ug
dGhpcyBwYXRjaCBhbmQgYWRkIGJlbG93IEFja2VkLWJ5PyBJdCBzaG91bGQgY2FuIGJlDQo+IGFw
cGxpZWQgdG8geW91ciB0cmVlIGRpcmVjdGx5Lg0KPiANCj4gCUFja2VkLWJ5OiBEYW5pZWwgTGV6
Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz4NCg0KU29ycnkgdGhhdCBJIGp1c3QgZm91
bmQgdGhpcyBwYXRjaCBjYW4gTk9UIGJlIGFwcGxpZWQgdG8geW91ciBmb3ItbmV4dCB0cmVlIG5l
aXRoZXIsIHNvDQpJIHJlZG8gdGhlIHBhdGNoIGFnYWluc3QgeW91ciBmb3ItbmV4dCB0cmVlLCBz
byB5b3UgY2FuIGp1c3Qgc2tpcCB0aGlzIHBhdGNoIHNlcmllcyBub3cNCihhcyBEYW5pZWwgYWxy
ZWFkeSBwaWNrZWQgdGhlIHJlc3QgMyBwYXRjaGVzKSBhbmQgdGFrZSB0aGF0IHBhdGNoIEkganVz
dCBzZW50LCBsaW5rIGFzIGJlbG93Og0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Bh
dGNoLzExMDk3NDcxLw0KDQpUaGFua3MsDQpBbnNvbg0KDQo=
