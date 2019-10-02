Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A5CC35280
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 185C820700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 10:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="XnBiiw3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfJBKXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 06:23:53 -0400
Received: from mail-eopbgr00139.outbound.protection.outlook.com ([40.107.0.139]:7161
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbfJBKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 06:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exT9tyCLyVdWgWZlwZjptF9Y+GgIZ++KB2fpyD0vEwMC58q6c886cAPBfNAS7Rmnpo6b8lfmNaVplA1beUK1EN5zbsmSxcK27UjMqV91RzqhIp4w34OVeACOQNDcTAoMS5VclMRNZUbBbhtOqWdOgdJKAsItUEq/VFrv0G38Q4cXPAYnPGEN22jzVgwvQNHT37Zr02URRTU4KeqKnpCNiZA+AoScnbxOKk9ax4M8bzQ2SPe6tKoJkxiGFFJ2fd06Ph+Mop6M1SjSYufOp+iCoK7w/S+HiuCGw+AH7oztyuZK/2XHzxJZ6KHwn5/sDdnqeLUgY6EnLdWoerJRQ/Jqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ZQ83+A7Mmm95Dvysl2xOE7jcCYBP45e0UNhynw+wY=;
 b=O8KhEqNmI/gxnYpmJjH94SXQM0i1cpICpcuiP/cgZdW+w9sIEiV6Ejw0Nl1OZagUg2P2dNVgJeThb6T9qwFIWxGMK/rY841TzpY5pdCkf8k12Tyt9mBYv/DnJcR5QWPgBl8u6Vx0CCyddJE72Hk0ogmWgSKduHgySCUNrB7yZLiV91D0ln8JubwTA8xt1+6PIeVoOe8cJXVLJ2I3ITq4GM2rUo4VngVgDmEgYFmXhwEdwSubANGQ2RM98DrmtVsdXQ5jKf5R/irHUi7HdCe2KCOXZ+vB8rjPKox8sXUIgj+Bdu+J4IGPkMM5G3324K0Pdc8+ldBH7K28qfDzPtf6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6ZQ83+A7Mmm95Dvysl2xOE7jcCYBP45e0UNhynw+wY=;
 b=XnBiiw3NoGma4ds81QjBuB1pUXA6sAeHalHle6IPVk1+GOMiv7WEH9Yjs4LRHTf+r5GR88SwFfWo6jlTunZeokzcT8H/baIGxrUUItNWrT7McWQy49J3puAolLxg/S7lUYQBUXCZhhe7CMr+0iHNRxDm0yZmoyHuIpXjAymhboo=
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com (52.134.19.20) by
 VI1PR0502MB4096.eurprd05.prod.outlook.com (52.134.19.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Wed, 2 Oct 2019 10:23:48 +0000
Received: from VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad]) by VI1PR0502MB3965.eurprd05.prod.outlook.com
 ([fe80::f427:26bb:85cf:abad%7]) with mapi id 15.20.2305.017; Wed, 2 Oct 2019
 10:23:48 +0000
From:   Philippe Schenker <philippe.schenker@toradex.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
CC:     "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Topic: [RESEND PATCH] ARM: dts: Add stmpe-adc DT node to Toradex T30
 modules
Thread-Index: AQHVUo6HlKoSMlWVHkKJ8B1IIQyZPadGJbOAgAFMJAA=
Date:   Wed, 2 Oct 2019 10:23:48 +0000
Message-ID: <bb7d6d2309ba9ad781b65e7eecb2cc61c0b91e3e.camel@toradex.com>
References: <20190814105318.21902-1-philippe.schenker@toradex.com>
         <20191001143501.GA3566931@ulmo>
In-Reply-To: <20191001143501.GA3566931@ulmo>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=philippe.schenker@toradex.com; 
x-originating-ip: [46.140.72.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f63f4f24-1a75-4d77-5b29-08d747229d30
x-ms-traffictypediagnostic: VI1PR0502MB4096:
x-microsoft-antispam-prvs: <VI1PR0502MB409623A983726AFD7598049FF49C0@VI1PR0502MB4096.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0178184651
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39840400004)(346002)(376002)(189003)(199004)(6512007)(6116002)(3846002)(26005)(256004)(6916009)(6486002)(54906003)(76176011)(66446008)(64756008)(76116006)(102836004)(66946007)(66476007)(66556008)(91956017)(2351001)(66066001)(86362001)(6246003)(2906002)(305945005)(7736002)(6506007)(2501003)(1361003)(25786009)(186003)(8676002)(4326008)(81156014)(71190400001)(5660300002)(71200400001)(6436002)(36756003)(478600001)(476003)(446003)(14454004)(11346002)(99286004)(2616005)(316002)(44832011)(8936002)(486006)(118296001)(229853002)(5640700003)(4744005)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0502MB4096;H:VI1PR0502MB3965.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNG+vKMzWYlRl7fmiTunosAbbmmBl/5StiDScjd5qOD4OF3wRILGyMzyCJWZmsEE0ADFZWGp1wy9ArR2mfHYe/NgSI1g3ozpQgJqQ2CkLW8fEvaGngzMQPasICYs9Ezrxt7r1dg5K3t+VL7+OoSJKEkN8o4JPxmt26GU3K2IQrE1CsgHlSXWZAslBzeW2YP0hJdB+aWsJYJg10D7Co7iETF7bUc1BEbLTgUmLhOWFPRaIchGyh4CqJlzD5G+g5B1aobC8tBPjfE4S0Rg/HeLIvYf9dFrPzgL0HFcqSULqKaTj93gUOvumZuOPaQ0uR3YytpTAGyOMlM64LyytbGT/EGOHCN5hNzAEBX1oXiWkZlzaWUE6ZOQoSzGwNezpm00fUdFjAeOY/IlCwuR9D6OXNxUcKYGaDjeX4WtzwmseBY=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <78943F9AA902334689BC841379E01580@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f63f4f24-1a75-4d77-5b29-08d747229d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2019 10:23:48.6877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHsSJvlRFjOccuQtYl9Os3ZgjFILuj/GfsUIyikhVfBXxttgjR4dmBN8MkznVUklnYtg0TI3SjqTJBMqo8TcFf+Y1qGIAa0K1otXKuMQqY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB4096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTEwLTAxIGF0IDE2OjM1ICswMjAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToN
Cj4gT24gV2VkLCBBdWcgMTQsIDIwMTkgYXQgMTA6NTM6MzhBTSArMDAwMCwgUGhpbGlwcGUgU2No
ZW5rZXIgd3JvdGU6DQo+ID4gQWRkIHRoZSBzdG1wZS1hZGMgRFQgbm9kZSBhcyBmb3VuZCBvbiBU
b3JhZGV4IFQzMCBtb2R1bGVzDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgU2No
ZW5rZXIgPHBoaWxpcHBlLnNjaGVua2VyQHRvcmFkZXguY29tPg0KPiA+IA0KPiA+IC0tLQ0KPiA+
IA0KPiA+ICBhcmNoL2FybS9ib290L2R0cy90ZWdyYTMwLWFwYWxpcy12MS4xLmR0c2kgfCAyMiAr
KysrKysrKysrKysrKy0tLS0tDQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3RlZ3Jh
MzAtYXBhbGlzLmR0c2kgICAgICB8IDIyICsrKysrKysrKysrKysrLS0tLS0NCj4gPiAtLS0NCj4g
PiAgYXJjaC9hcm0vYm9vdC9kdHMvdGVncmEzMC1jb2xpYnJpLmR0c2kgICAgIHwgMjIgKysrKysr
KysrKysrKystLS0tLQ0KPiA+IC0tLQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlv
bnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KPiANCj4gQXBwbGllZCB0byBmb3ItNS41L2FybS9kdCAs
IHRoYW5rcy4NCj4gDQo+IFRoaWVycnkNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCENCg0KUGhpbGlw
cGUNCg==
